%[Event,Time,Src_node,Dest_node,Pkt_type,Size,Flow_id] = importfile('projout.txt');
load('Tahoe.mat')
rec_TCP_flow1 = 0; %S1-D1
rec_TCP_flow2 = 0; %S1-D2
rec_TCP_flow3 = 0; %S2-D1
rec_TCP_flow4 = 0; %S2-D2
timebuffer_flow = Time(1);
rec_TCPbuffer_flow1 = 0;
rec_TCPbuffer_flow2 = 0;
rec_TCPbuffer_flow3 = 0;
rec_TCPbuffer_flow4 = 0;
average_interval = 0.1;
throuput_average_flow1=[];
throuput_average_flow2=[];
throuput_average_flow3=[];
throuput_average_flow4=[];
databuffer_flow1 = 0;
databuffer_flow2 = 0;
databuffer_flow3 = 0;
databuffer_flow4 = 0;
for i = 1:length(Event)
    if(Event{i} == 'r' && strcmp(Pkt_type{i},'tcp') && Flow_id(i) == 1 && Dest_node(i) == 5) 
        rec_TCP_flow1 = rec_TCP_flow1 + 1;
        databuffer_flow1 = databuffer_flow1 + Size(i);
    elseif(Event{i} == 'r' && strcmp(Pkt_type{i},'tcp') && Flow_id(i) == 2 && Dest_node(i) == 6) 
        rec_TCP_flow2 = rec_TCP_flow2 + 1;
        databuffer_flow2 = databuffer_flow2 + Size(i);
    elseif(Event{i} == 'r' && strcmp(Pkt_type{i},'tcp') && Flow_id(i) == 3 && Dest_node(i) == 5) 
        rec_TCP_flow3 = rec_TCP_flow3 + 1;
        databuffer_flow3 = databuffer_flow3 + Size(i);
    elseif(Event{i} == 'r' && strcmp(Pkt_type{i},'tcp') && Flow_id(i) == 4 && Dest_node(i) == 6) 
        rec_TCP_flow4 = rec_TCP_flow4 + 1;
        databuffer_flow4 = databuffer_flow4 + Size(i);
    end 
    if(Time(i) - average_interval >= timebuffer_flow)
            throughputbuffer = (databuffer_flow1 - rec_TCPbuffer_flow1) * 8 / (Time(i) - timebuffer_flow) / 10^6;
            throuput_average_flow1 = [throuput_average_flow1 throughputbuffer];
            throughputbuffer = (databuffer_flow2 - rec_TCPbuffer_flow2) * 8 / (Time(i) - timebuffer_flow) / 10^6;
            throuput_average_flow2 = [throuput_average_flow2 throughputbuffer];
            throughputbuffer = (databuffer_flow3 - rec_TCPbuffer_flow3) * 8 / (Time(i) - timebuffer_flow) / 10^6;
            throuput_average_flow3 = [throuput_average_flow3 throughputbuffer];
            throughputbuffer = (databuffer_flow4 - rec_TCPbuffer_flow4) * 8 / (Time(i) - timebuffer_flow) / 10^6;
            throuput_average_flow4 = [throuput_average_flow4 throughputbuffer];            
            timebuffer_flow = Time(i);
            rec_TCPbuffer_flow1 = databuffer_flow1;
            rec_TCPbuffer_flow2 = databuffer_flow2;
            rec_TCPbuffer_flow3 = databuffer_flow3;
            rec_TCPbuffer_flow4 = databuffer_flow4;            
    end
end
OverallThroughput_flow1 = databuffer_flow1 * 8 / (Time(end) - Time(1)) / 10^6;
OverallThroughput_flow2 = databuffer_flow2 * 8 / (Time(end) - Time(1)) / 10^6;
OverallThroughput_flow3 = databuffer_flow3 * 8 / (Time(end) - Time(1)) / 10^6;
OverallThroughput_flow4 = databuffer_flow4 * 8 / (Time(end) - Time(1)) / 10^6;
initial = zeros(1,10);
after = initial;
time = 0:0.1:100;
flow1 = [initial throuput_average_flow1 after];
flow2 = [initial throuput_average_flow2 after];
flow3 = [initial throuput_average_flow3 after];
flow4 = [initial throuput_average_flow4 after];
if(length(flow1)>length(time))
    flow1 = flow1(1:length(time));
    flow2 = flow2(1:length(time));
    flow3 = flow3(1:length(time));
    flow4 = flow4(1:length(time));
elseif(length(flow1)<length(time))
    flow1 = [flow1 zeros(1, length(time)-length(flow1))];
    flow2 = [flow2 zeros(1, length(time)-length(flow2))];
    flow3 = [flow3 zeros(1, length(time)-length(flow3))];
    flow4 = [flow4 zeros(1, length(time)-length(flow4))];
end
set(0,'defaultfigurecolor', 'w')
figure
plot(time, flow1)
xlabel('Time(s)')
ylabel('Throughput(Mbps)')
title('Tahoe flow 1 instantaneous throughput');
figure
plot(time, flow2)
xlabel('Time(s)')
ylabel('Throughput(Mbps)')
title('Tahoe flow 2 instantaneous throughput');
figure
plot(time, flow3)
xlabel('Time(s)')
ylabel('Throughput(Mbps)')
title('Tahoe flow 3 instantaneous throughput');
figure
plot(time, flow4)
xlabel('Time(s)')
ylabel('Throughput(Mbps)')
title('Tahoe flow 4 instantaneous throughput');
