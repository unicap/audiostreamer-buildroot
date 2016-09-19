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
