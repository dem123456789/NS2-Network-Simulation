filename = './Data./Sack/WinFile1';
[time,CongestWindow_flow1] = ImportWin(filename);
filename = './Data./Sack/WinFile2';
[~,CongestWindow_flow2] = ImportWin(filename);
filename = './Data./Sack/WinFile3';
[~,CongestWindow_flow3] = ImportWin(filename);
filename = './Data./Sack/WinFile4';
[~,CongestWindow_flow4] = ImportWin(filename);
set(0,'defaultfigurecolor', 'w')
figure
plot(time, CongestWindow_flow1)
xlabel('Time(s)')
ylabel('Congestion Window (Bytes)')
title('Sack flow 1 Congest Window');
figure
plot(time, CongestWindow_flow2)
xlabel('Time(s)')
ylabel('Congestion Window (Bytes)')
title('Sack flow 2 Congest Window');
figure
plot(time, CongestWindow_flow3)
xlabel('Time(s)')
ylabel('Congestion Window (Bytes)')
title('Sack flow 3 Congest Window');
figure
plot(time, CongestWindow_flow4)
xlabel('Time(s)')
ylabel('Congestion Window (Bytes)')
title('Sack flow 4 Congest Window');
