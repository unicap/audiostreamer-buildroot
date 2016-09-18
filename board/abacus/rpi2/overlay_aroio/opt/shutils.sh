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
