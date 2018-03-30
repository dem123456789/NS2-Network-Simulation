# NS2 network simulation

An example of using NS2 network simulator building FTP over TCP topology  
![Topology](https://github.com/dem123456789/NS2-network-simulation/blob/master/layout.PNG "Topology")  
[Project Description](https://github.com/dem123456789/NS2-network-simulation/blob/master/Project.pdf)  
[Project Report](https://github.com/dem123456789/NS2-network-simulation/blob/master/Project%20Report.pdf)

## Initialization
#### Install NS2
It is a hard part before you want to use NS2.  
The most convenient solution is to use [VitrualBox](https://www.virtualbox.org/wiki/Downloads)  
Download the newest [Ubuntu](https://virtualboximages.com/VirtualBox+Ubuntu+Client+VDIs) desktop image.   
This one is what I used.  
Then follow instructions [here](http://installwithme.blogspot.com/2014/05/how-to-install-ns-2.35-in-ubuntu-13.10-or-14.04.html).  
You can ignore the first step where requires to update all your packages or something, but do update the required packages in step 1.3.

#### NAM trace file
.nam trace file instruction [here](http://www.mathcs.emory.edu/~cheung/Courses/558/Syllabus/A4-TCP-Sim/TCP-Throughput.html)
## Usage
1. ns something.tcl
2. You will get the output like projout.nam and Winfile (Congestion Window data)
3. You can analyse the nam trace file and Congestion Window data file

## Contributing

1. Fork
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request

## Source
ECE 4607 Project

## Credits
*Enmao Diao  
James Eccles  
Daniel Graves  
Wes Smith*

