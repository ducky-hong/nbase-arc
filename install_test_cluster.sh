#!/usr/bin/expect -f
spawn fab main
expect ">>"
send "14\r"
expect "PM information('ip list' or all)"
send "0.0.0.0\r"
sleep 5
expect ">>"
send "4\r"
expect "Cluster name :"
send "test\r"
expect "PG count :"
send "1\r"
expect "Replication number :"
send "1\r"
expect "PGS Physical Machine list"
send {[["machine1 0.0.0.0"]]}
send "\r"
expect "Gateway Physical Machine list"
send {["machine1 0.0.0.0"]}
send "\r"
expect "Cronsave number"
send "1\r"
expect "Print script?"
send "Y\r"
expect "Print configuration?"
send "Y\r"
expect "Create PGS, Continue?"
send "Y\r"
expect "Confirm Mode?"
send "n\r"
expect eof
