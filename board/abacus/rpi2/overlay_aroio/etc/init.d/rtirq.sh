#!/bin/sh
#
# Copyright (c) 2004-2007 rncbc aka Rui Nuno Capela.
#
# /etc/init.d/rtirq
#
# Startup script for realtime-preempt enabled kernels.
#
# This program is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License version 2 or later.
#
# chkconfig: 35 81 19
# description: Realtime IRQ thread tunning.
#
### BEGIN INIT INFO
# Provides:          rtirq
# Required-Start:    $syslog $local_fs
# Should-Start: $time alsa alsasound hotplug
# Required-Stop:     $syslog $local_fs
# Should-Stop: $time alsa alsasound hotplug
# Default-Start:     3 5
# Default-Stop:      0 1 2 6
# Short-Description: Realtime IRQ thread tunning.
# Description:       Change the realtime scheduling policy
#	and priority of relevant system driver IRQ handlers.
### END INIT INFO
#


# Won't work without those binaries.
for DIR in /sbin /usr/sbin /bin /usr/bin /usr/local/bin; do
	[ -z "${RTIRQ_CHRT}" -a -x ${DIR}/chrt ] && RTIRQ_CHRT=${DIR}/chrt
done

# Check for missing binaries (stale symlinks should not happen)
[ -n "${RTIRQ_CHRT}" -a -x ${RTIRQ_CHRT} ] || {
	echo "`basename $0`: chrt: not installed."  
	[ "$1" = "stop" ] && exit 0 || exit 5
}

# Check for existence of needed config file and read it.
RTIRQ_CONFIG=/etc/conf.d/rtirq
[ -r ${RTIRQ_CONFIG} ] || {
	echo "`basename $0`: ${RTIRQ_CONFIG}: not found."
	[ "${RTIRQ_ACTION}" = "stop" ] && exit 0 || exit 6
}

# Read configuration.
. ${RTIRQ_CONFIG}

# Colon delimited trail list of already assigned IRQ numbers,
# preventind lower priority override due to shared IRQs.
RTIRQ_TRAIL=":"

# 
# Reset policy of all IRQ threads out there. 
#
rtirq_reset()
{
	# Reset all softirq-timer/s from highest priority.
	rtirq_exec_high reset
	# PIDS=`ps -eo pid,class | egrep '(FF|RR)' | awk '{print $1}'`
	PIDS=`ps -eo pid,comm | grep IRQ | awk '{print $1}'`
	for PID in ${PIDS}
	do
		${RTIRQ_CHRT} -p -o 0 ${PID}
	done
}

#
# IRQ thread handler policy prioritizer, by IRQ number.
#
rtirq_exec_num()
{
	ACTION=$1
	NAME1=$2
	NAME2=$3
	PRI2=$4
	IRQ=$5
	# Check the services that are to be (un)threaded.
	if [ -n "`echo :${RTIRQ_NON_THREADED}: | sed 's/ /:/g' | grep :${NAME1}:`" ]
	then
		PREPEND="`basename $0`: ${ACTION} [${NAME2}] irq=${IRQ}"
		for THREADED in /proc/irq/${IRQ}/*/threaded
		do
			if [ -f "${THREADED}" ]
			then
				case ${ACTION} in
				*start)
					echo "${PREPEND}: ${THREADED}: OFF."
					echo -n 0 > "${THREADED}"
					;;
				stop)
					echo "${PREPEND}: ${THREADED}: ON."
					echo -n 1 > "${THREADED}"
					;;
				esac
			fi
		done
	fi
	# And now do the proper threading prioritization...
	if [ -z "`echo ${RTIRQ_TRAIL} | grep :${IRQ}:`" ]
	then 
		PIDS=`ps -eo pid,comm | egrep "IRQ.${IRQ}\$" | awk '{print $1}'`
		for PID in ${PIDS}
		do
			PREPEND="`basename $0`: ${ACTION} [${NAME2}] irq=${IRQ} pid=${PID}"
			case ${ACTION} in
			*start)
				PREPEND="${PREPEND} prio=${PRI2}"
				if ${RTIRQ_CHRT} -p -f ${PRI2} ${PID}
				then
					echo "${PREPEND}: OK."
				else 
					echo "${PREPEND}: FAILED."
				fi
				;;
			stop)
				if ${RTIRQ_CHRT} -p -o 0 ${PID}
				then
					echo "${PREPEND}: OK."
				else 
					echo "${PREPEND}: FAILED."
				fi
				;;
			status)
				echo "${PREPEND}: " && ${RTIRQ_CHRT} -p ${PID}
				;;
			*)
				echo "${PREPEND}: ERROR."
				;;
			esac
			PRI2=$((${PRI2} - 1))
		done
		RTIRQ_TRAIL=":${IRQ}${RTIRQ_TRAIL}"
	fi
}

#
# IRQ thread handler policy prioritizer, by service name.
#
rtirq_exec_name()
{
	ACTION=$1
	NAME1=$2
	NAME2=$3
	PRI1=$4
	IRQS=`grep "${NAME2}" /proc/interrupts | awk -F: '{print $1}'`
	for IRQ in ${IRQS}
	do
		rtirq_exec_num ${ACTION} ${NAME1} ${NAME2} ${PRI1} ${IRQ}
		PRI1=$((${PRI1} - 1))
	done
}

#
# Generic process top prioritizer
#
rtirq_exec_high()
{
	ACTION=$1
	case ${ACTION} in
	*start)
		PRI1=99
		;;
	*)
		PRI1=1
		;;
	esac
	# Process all configured process names...
	for NAME in ${RTIRQ_HIGH_LIST}
	do
		PREPEND="`basename $0`: ${ACTION} [${NAME}]"
		PIDS=`ps -eo pid,comm | grep "${NAME}" | awk '{print $1}'`
		for PID in ${PIDS}
		do
			if ${RTIRQ_CHRT} -p -f ${PRI1} ${PID}
			then
				echo "${PREPEND} pid=${PID} prio=${PRI1}: OK."
			else 
				echo "${PREPEND} pid=${PID} prio=${PRI1}: FAILED."
			fi
		done
		[ ${PRI1} -gt ${RTIRQ_PRIO_HIGH} ] && PRI1=$((${PRI1} - 1))
	done
}


#
# Main executive.
#
rtirq_exec()
{
	ACTION=$1
	# Check configured base priority.
	PRI0=${RTIRQ_PRIO_HIGH:-90}
	[ $((${PRI0})) -gt 95 ] && PRI0=95
	[ $((${PRI0})) -lt 55 ] && PRI0=55
	# Check configured priority decrease step.
	DECR=${RTIRQ_PRIO_DECR:-5}
	[ $((${DECR})) -gt 10 ] && DECR=10
	[ $((${DECR})) -lt  1 ] && DECR=1
	# (Re)set all softirq-timer/s to highest priority.
	rtirq_exec_high ${ACTION}
	# Process all configured service names...
	for NAME in ${RTIRQ_NAME_LIST}
	do
		case ${NAME} in
		snd)
			PRI1=${PRI0}
			IRQS=`grep irq /proc/asound/cards | tac | sed 's/.* irq \(.*\)/\1/'`
			for IRQ in ${IRQS}
			do
				rtirq_exec_num ${ACTION} ${NAME} ${NAME} ${PRI1} ${IRQ}
				PRI1=$((${PRI1} - 1))
			done
			;;
		usb)
			rtirq_exec_name ${ACTION} ${NAME} "ohci_hcd" ${PRI0}
			rtirq_exec_name ${ACTION} ${NAME} "uhci_hcd" ${PRI0}
			rtirq_exec_name ${ACTION} ${NAME} "ehci_hcd" ${PRI0}
			;;
		*)
			rtirq_exec_name ${ACTION} ${NAME} ${NAME} ${PRI0}
			;;  
		esac
		[ ${PRI0} -gt ${DECR} ] && PRI0=$((${PRI0} - ${DECR}))
	done
}


#
# Main procedure line.
#
case $1 in
*start)
	if [ "${RTIRQ_RESET_ALL}" = "yes" -o "${RTIRQ_RESET_ALL}" = "1" ]
	then
		rtirq_reset
	fi
	rtirq_exec start
	;;
stop)
	if [ "${RTIRQ_RESET_ALL}" = "yes" -o "${RTIRQ_RESET_ALL}" = "1" ]
	then
		rtirq_reset
	#else
	#  rtirq_exec stop
	fi
	;;
reset)
	if [ "${RTIRQ_RESET_ALL}" = "yes" -o "${RTIRQ_RESET_ALL}" = "1" ]
	then
		rtirq_reset
	else
		rtirq_exec stop
	fi
	;;
status)
	echo
	#rtirq_exec status
	ps -eo pid,class,rtprio,ni,pri,pcpu,stat,comm --sort -rtprio \
		| egrep '(^[[:blank:]]*PID|IRQ|softirq)' \
		| awk 'BEGIN {
			while (getline IRQLine < "/proc/interrupts") {
				split(IRQLine, IRQSplit, ":[[:blank:]|0-9]+");
				if (match(IRQSplit[1], "^[[:blank:]]*[0-9]+$")) {
					gsub("[^[:blank:]]+PIC[^[:blank:]]*[[:blank:]]+" \
						"|\\[[^\\]]+\\][^[:blank:]]*[[:blank:]]+",
						"", IRQSplit[2]);
					IRQTable[IRQSplit[1] + 0] = IRQSplit[2];
				}
			}
		} { if ($9 == "")
			{ print $0"\t"IRQTable[substr($8,5)]; }
			else
			{ print $0"\t"IRQTable[$9]; } }'
	echo
	;;
*)
	echo
	echo "  Usage: $0 {[re]start|stop|reset|status}"
	echo
	exit 1
	;;
esac

exit 0
