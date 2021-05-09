#!/usr/bin/expect 

set addr [lindex $argv 0]
set t1 [lindex $argv 1]
set t2 [lindex $argv 2]
set t3 [lindex $argv 3]
set server_port 22
set server_dir /home/test
set server_user test
set server_pswd test
spawn ssh $addr
expect {
    "password"
    { 
       send "$t1\n";
    } 
}
expect { 
    "password"
    { 
       send "$t2\n";
    } 
}
expect { 
    "password"
    { 
       send "$t3\n";
    } 
}
interact
