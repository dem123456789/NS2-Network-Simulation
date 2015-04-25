#Create a simulator object
set ns [new Simulator]

#Define different colors for data flows (for NAM)
$ns color 1 Blue
$ns color 2 Blue
$ns color 3 Red
$ns color 4 Red
$ns color 5 Green
$ns color 6 Green

#Open the NAM trace file
set nf [open projout.nam w]
$ns namtrace-all $nf

#Define a 'finish' procedure
proc finish {} {
        global ns nf
        $ns flush-trace
        #Close the NAM trace file
        close $nf
        #Execute NAM on the trace file
        exec nam projout.nam &
        exit 0
}

#Create four nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]

#Create links between the nodes
$ns duplex-link $n0 $n2 20Mb 4ms DropTail
$ns duplex-link $n1 $n2 10Mb 5ms DropTail
$ns duplex-link $n2 $n3 20Mb 40ms DropTail
$ns duplex-link $n3 $n4 10Mb 45ms DropTail
$ns duplex-link $n4 $n5 20Mb 3ms DropTail
$ns duplex-link $n4 $n6 10Mb 5ms DropTail

#Set Queue Size of link (n2-n3) to 10
$ns queue-limit $n0 $n2 50
$ns queue-limit $n1 $n2 50
$ns queue-limit $n2 $n3 50
$ns queue-limit $n3 $n4 50
$ns queue-limit $n4 $n5 50
$ns queue-limit $n4 $n6 50

#Give node position (for NAM)
$ns duplex-link-op $n0 $n2 orient right-down
$ns duplex-link-op $n1 $n2 orient right-up
$ns duplex-link-op $n2 $n3 orient right
$ns duplex-link-op $n3 $n4 orient right
$ns duplex-link-op $n4 $n5 orient right-up
$ns duplex-link-op $n4 $n6 orient right-down

#Setup TCP connection S1-R1
set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0
set sink0 [new Agent/TCPSink]
$ns attach-agent $n2 $sink0
$ns connect $tcp0 $sink0
$tcp0 set window_ 3000
$tcp0 set fid_ 1

#Setup TCP connection S2-R1
set tcp1 [new Agent/TCP]
$ns attach-agent $n1 $tcp1
set sink1 [new Agent/TCPSink]
$ns attach-agent $n2 $sink1
$ns connect $tcp1 $sink1
$tcp1 set window_ 3000
$tcp1 set fid_ 2

#Setup TCP connection R1-R2
set tcp2 [new Agent/TCP]
$ns attach-agent $n2 $tcp2
set sink2 [new Agent/TCPSink]
$ns attach-agent $n3 $sink2
$ns connect $tcp2 $sink2
$tcp2 set window_ 3000
$tcp2 set fid_ 3

#Setup TCP connection R2-R3
set tcp3 [new Agent/TCP]
$ns attach-agent $n3 $tcp3
set sink3 [new Agent/TCPSink]
$ns attach-agent $n4 $sink3
$ns connect $tcp3 $sink3
$tcp3 set window_ 3000
$tcp3 set fid_ 4

#Setup TCP connection R3-D1
set tcp4 [new Agent/TCP]
$ns attach-agent $n4 $tcp4
set sink4 [new Agent/TCPSink]
$ns attach-agent $n5 $sink4
$ns connect $tcp4 $sink4
$tcp4 set window_ 3000
$tcp4 set fid_ 5

#Setup TCP connection R3-D1
set tcp5 [new Agent/TCP]
$ns attach-agent $n4 $tcp5
set sink5 [new Agent/TCPSink]
$ns attach-agent $n6 $sink5
$ns connect $tcp5 $sink5
$tcp5 set window_ 3000
$tcp5 set fid_ 6

#Setup a FTP over TCP connection
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
$ftp0 set type_ FTP
$ftp0 set packet_size_ 13000

#Setup a FTP over TCP connection
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
$ftp1 set type_ FTP
$ftp1 set packet_size_ 13000

#Setup a FTP over TCP connection
set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2
$ftp2 set type_ FTP
$ftp2 set packet_size_ 13000

#Setup a FTP over TCP connection
set ftp3 [new Application/FTP]
$ftp3 attach-agent $tcp3
$ftp3 set type_ FTP
$ftp3 set packet_size_ 13000

#Setup a FTP over TCP connection
set ftp4 [new Application/FTP]
$ftp4 attach-agent $tcp4
$ftp4 set type_ FTP
$ftp4 set packet_size_ 13000

#Setup a FTP over TCP connection
set ftp5 [new Application/FTP]
$ftp5 attach-agent $tcp5
$ftp5 set type_ FTP
$ftp5 set packet_size_ 13000

#Schedule events for the CBR and FTP agents
$ns at 1.0 "$ftp0 start"
$ns at 1.0 "$ftp1 start"
$ns at 1.0 "$ftp2 start"
$ns at 1.0 "$ftp3 start"
$ns at 1.0 "$ftp4 start"
$ns at 1.0 "$ftp5 start"
$ns at 4.0 "$ftp0 stop"
$ns at 4.0 "$ftp1 stop"
$ns at 4.0 "$ftp2 stop"
$ns at 4.0 "$ftp3 stop"
$ns at 4.0 "$ftp4 stop"
$ns at 4.0 "$ftp5 stop"

#Call the finish procedure after 5 seconds of simulation time
$ns at 5.0 "finish"

#Run the simulation
$ns run

