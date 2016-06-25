#!/bin/sh
iwScan()
{
	# disable globbing to avoid surprises
	set -o noglob
	# make temporary variables local to our function
	local AP S
	# read stdin of the function into AP variable
	while read -r AP
	do
		## print lines only containing needed fields
		[[ "${AP//'ESSID:'*}" == '' ]] && echo "2" && printf '%b' "${AP/'ESSID:'}\n"
		#[[ "${AP//'signal: '*}" == '' ]] && ( S=( ${AP/'signal: '} ); printf '%b' "${S[0]},";)
		done
		set +o noglob
}

iwlist wlan0 scan | iwScan
