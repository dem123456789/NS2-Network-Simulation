#Create a simulator object
set ns [new Simulator]

#Define different colors for data flows (for NAM)
$ns color 1 Blue
$ns color 2 Blue
$ns color 3 Red
$ns color 4 Red


#Open the NAM trace file
set nf [open projout.nam w]
$ns namtrace-all $nf

#Congestion Window file
set outfile1  [open  "WinFile1"  w]
set outfile2  [open  "WinFile2"  w]
set outfile3  [open  "WinFile3"  w]
set outfile4  [open  "WinFile4"  w]

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

#Set Queue Size of link (n2-n3) to 50
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



#Setup TCP connection S1-D1
set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0
set sink0 [new Agent/TCPSink]
$ns attach-agent $n5 $sink0
$ns connect $tcp0 $sink0
$tcp0 set window_ 30000
$tcp0 set fid_ 1

#Setup TCP connection S1-D2
set tcp1 [new Agent/TCP]
$ns attach-agent $n0 $tcp1
set sink1 [new Agent/TCPSink]
$ns attach-agent $n6 $sink1
$ns connect $tcp1 $sink1
$tcp1 set window_ 30000
$tcp1 set fid_ 2

#Setup TCP connection S2-D1
set tcp2 [new Agent/TCP]
$ns attach-agent $n1 $tcp2
set sink2 [new Agent/TCPSink]
$ns attach-agent $n5 $sink2
$ns connect $tcp2 $sink2
$tcp2 set window_ 30000
$tcp2 set fid_ 3

#Setup TCP connection S2-D2
set tcp3 [new Agent/TCP]
$ns attach-agent $n1 $tcp3
set sink3 [new Agent/TCPSink]
$ns attach-agent $n6 $sink3
$ns connect $tcp3 $sink3
$tcp3 set window_ 30000
$tcp3 set fid_ 4

#Setup a FTP over TCP connection
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
$ftp0 set type_ FTP
$ftp0 set packet_size_ 1500

#Setup a FTP over TCP connection
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
$ftp1 set type_ FTP
$ftp1 set packet_size_ 1500

#Setup a FTP over TCP connection
set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2
$ftp2 set type_ FTP
$ftp2 set packet_size_ 1500

#Setup a FTP over TCP connection
set ftp3 [new Application/FTP]
$ftp3 attach-agent $tcp3
$ftp3 set type_ FTP
$ftp3 set packet_size_ 1500

  proc plotWindow {tcpSource outfile} {
     global ns

     set now [$ns now]
     set cwnd [$tcpSource set cwnd_]

  ###Print TIME CWND   for  gnuplot to plot progressing on CWND
     puts  $outfile  "$now $cwnd"

     $ns at [expr $now+0.1] "plotWindow $tcpSource  $outfile"
  }

set rng [new RNG]
$rng seed 0

# create a random variable that follows the uniform distribution
set loss_random_variable [new RandomVariable/Uniform]
$loss_random_variable use-rng $rng
$loss_random_variable set min_ 0 
# the range of the random variable;
$loss_random_variable set max_ 100
set loss_module [new ErrorModel] 
# create the error model;
$loss_module drop-target [new Agent/Null]
#a null agent where the dropped packets go to
$loss_module set rate_ 0
# right now rate is 0 
# error rate will then be (0.1 = 10 / (100 - 0));
$loss_module ranvar $loss_random_variable 
# attach the random variable to loss module; 
$ns lossmodel $loss_module $n2 $n3 

#Schedule events for the CBR and FTP agents
$ns at 0.0  "plotWindow $tcp0  $outfile1"
$ns at 0.0  "plotWindow $tcp1  $outfile2" 
$ns at 0.0  "plotWindow $tcp2  $outfile3" 
$ns at 0.0  "plotWindow $tcp3  $outfile4" 
$ns at 1.0 "$ftp0 start"
$ns at 1.0 "$ftp1 start"
$ns at 1.0 "$ftp2 start"
$ns at 1.0 "$ftp3 start"
$ns at 99.0 "$ftp0 stop"
$ns at 99.0 "$ftp1 stop"
$ns at 99.0 "$ftp2 stop"
$ns at 99.0 "$ftp3 stop"

#Call the finish procedure after 5 seconds of simulation time
$ns at 100.0 "finish"

#Run the simulation
$ns run

