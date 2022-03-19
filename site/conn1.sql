
drop database link server1;

create database link server1
 connect to system identified by "180104108"
 using '(DESCRIPTION =
       (ADDRESS_LIST =
         (ADDRESS = (PROTOCOL = TCP)
		 (HOST = 192.168.0.102)
		 (PORT = 1622))
       )
       (CONNECT_DATA =
         (SID = XE)
       )
     )'
;  