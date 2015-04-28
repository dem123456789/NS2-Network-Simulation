#============================= throughput100ms.awk ======================

BEGIN {
time = 0;
packetbuffer_flow1 = 0;
packetbuffer_flow2 = 0;
packetbuffer_flow3 = 0;
packetbuffer_flow4 = 0;
gotime = 1;
time_interval = 0.1;
}
#body
{
       	     event = $1
             time = $3
             Src_node = $5
             Dest_node = $7
	     Pkt_type = $9
             Size = $11
	     Flow_id = $13
	     
             
if(time - time_interval >= gotime) {

print time, (packetbuffer_flow1 * 8.0)/((time - gotime)*10^6), (packetbuffer_flow2 * 8.0)/((time - gotime)*10^6), (packetbuffer_flow3 * 8.0)/((time - gotime)*10^6), (packetbuffer_flow4 * 8.0)/((time - gotime)*10^6);
gotime = time;
packetbuffer_flow1 = 0;
packetbuffer_flow1 = 0;
packetbuffer_flow1 = 0;
packetbuffer_flow1 = 0;
}

#============= CALCULATE throughput=================
#FLOW 1 4-5 S1-D1
if (( event == "r") && ( Pkt_type == "tcp" ) && ( Src_node == "4" ) && ( Dest_node == "5" ) && (Flow_id == "1") )
{
packetbuffer_flow1 = packetbuffer_flow1 + Size; 
}
#FLOW 2 4-6 S1-D2
if (( event == "r") && ( Pkt_type == "tcp" ) && ( Src_node == "4" ) && ( Dest_node == "6" ) && (Flow_id == "2"))
{
packetbuffer_flow2 = packetbuffer_flow2 + Size; 
}
#FLOW 3 4-5 S2-D1
if (( event == "r") && ( Pkt_type == "tcp" ) && ( Src_node == "4" ) && ( Dest_node == "5" ) && (Flow_id == "3") )
{
packetbuffer_flow3 = packetbuffer_flow3 + Size; 
}
#FLOW 4 4-6 S2-D2
if (( event == "r") && ( Pkt_type == "tcp" ) && ( Src_node == "4" ) && ( Dest_node == "6" ) && (Flow_id == "4") )
{
packetbuffer_flow4 = packetbuffer_flow4 + Size; 
}
} #body


END {
;
}
#============================= Ends ============================

