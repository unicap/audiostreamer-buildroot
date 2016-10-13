#!/bin/sh

# Write message to the console and a file log
clog() {
    echo $* | tee -a /tmp/shell.log
}

# Write message to the file log only
clogn() {
    echo $* >> /tmp/shell.log
}

# Write a banner with the current uptime to console and file log
cmark() {
    clog -n "-------------- "
    echo -n `uptime -s` | tee -a /tmp/shell.log
    clog "-------------- "
}

cmarkn() {
    clog -n "-------------- "
    echo -n `uptime -s` >> /tmp/shell.log
    clog "-------------- "
}

cmarks() {
    clog -n "-------------- [$1] "
    echo -n `uptime -s` | tee -a /tmp/shell.log
    clog "-------------- "
}

cmarksn() {
    clog -n "-------------- [$1] "
    echo -n `uptime -s` >> /tmp/shell.log
    clog "-------------- "
}

logstart() {
    cmarks $(basename $1)
    $* | tee -a /tmp/shell.log
    cmarks "Finished: $(basename $1)"
}

logstartn() {
    cmarksn $(basename $1)
    $* 2>&1 >> /tmp/shell.log
    cmarksn "Finished: $(basename $1)"
}

ethaddr()
{
    ifconfig | grep -A 2 eth0 | grep -w inet -m1 | grep -v 127 | awk -F[:] '{ print $2  }' | awk -F[:' '] '{ print $1 }'
}
wlanaddr()
{
    ifconfig | grep -A 2 wlan0 | grep -w inet -m1 | grep -v 127 | awk -F[:] '{ print $2  }' | awk -F[:' '] '{ print $1 }'
}

macaddr()
{
    if grep 1 /sys/class/net/eth0/carrier &> /dev/null
    then	cat /sys/class/net/eth0/address
    else	cat /sys/class/net/wlan0/address
    fi
}

check_status()
{
    DAEMON=$1
    PIDFILE=$2
    if ! [ -e $PIDFILE ]; then return 1; fi
    if ! [ -e /proc/$(cat $PIDFILE) ]; then return 1; fi
    set -- $(cat /proc/$(cat $PIDFILE)/cmdline | strings)
    EXECUTABLE=$1
    if ! [ $DAEMON = $EXECUTABLE ]; then return 1; fi
    return 0
}
