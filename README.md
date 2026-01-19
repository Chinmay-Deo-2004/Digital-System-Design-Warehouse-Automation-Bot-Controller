# Warehouse automation Bot
(Spoilers: Yes. before you can point it out, we know Control Theory exists and this very same problem statement can be solved in a far more optimal way with a custom PID controller programmed in ROS2. This is merely a proof of concept and a showcasing of the application of a System Design workflow on a toy problem, pushing the limits of feasibility of conventional MIMO controller design using Verilog.)

## Problem Environment:
![image](https://github.com/user-attachments/assets/1e49856b-b895-45a0-8202-6d2b74375596)

## The Problem Statement:
An autonomous robot is assigned an RFID (which maps to a box of cargo) to look for in the warehouse. Each box is identified by a unique RFID. The bot is to manoeuvre itself to the warehouse, find the correct box, and bring it back to the assembly unit. 

## What does the robot look like?
![image](https://github.com/user-attachments/assets/bd503b11-73f3-4fee-b564-c465ed352506)

## Solution workflow:
* High Level Block Diagram
* Flowchart
* Mnemonic Documented State Diagram
* Code assignment, Minimization using K-maps and Circuit implementation
* Implementation of controller using Verilog

### 1) High Level Block Diagram
![image](https://github.com/user-attachments/assets/78458546-4e1f-41b8-9d9e-6af4aaff5e5a)

### 2) Flowchart
![image](https://github.com/user-attachments/assets/476dd147-c03d-43ce-944e-c9ed695ee153)

I know the quality of the image isn't world class. Here's a link to view the flowchart yourself in all its glory. https://whimsical.com/DbWmcVLEU8ybgdcfG7E7FR

### 3) Mnemonic Documented State Diagram (MDS)
![image](https://github.com/user-attachments/assets/d48becaf-909c-45fa-88aa-774dd749d2bf)

Now, using the MDS and a K-map to assign codes to every state, keeping in mind the adjacency requirements and asynchronity of input variables, we can then finally implement the hardware using more K-maps for the expressions of the outputs of the D-Flip Flops used as the memory of the FSM.

### 4) Hardware Design (method-1: Verilog)

With some tinkering around and experimentation, found the right level of abstraction to encompass the whole design using cleverly enclosed Verilog modules, it makes it much cleaner and easier to read and understand.

![image](https://github.com/user-attachments/assets/fe2bc987-3265-4e25-b87b-5c4e6ae928bd)

But, in case you're wondering what this looks like on the inside, here's a more detailed schematic:
![image](https://github.com/user-attachments/assets/fe42ce47-4bea-4610-a223-6bab8a206c7c)

Finally, we ran the code using a testbench that we wrote to simulate its working and here were the results:
![image](https://github.com/user-attachments/assets/d1946fc1-6a12-47c9-b1f8-995106098e44)

## (method-2: PCB assembly)
We made a PoC PCB schematic in KiCad to provide an alternative to fabricating the controller as a chip.
<img width="1034" height="714" alt="image" src="https://github.com/user-attachments/assets/500f238d-e4b2-4518-9562-0c9d6633eaf0" />

Again, this is a very crude and simplistic modeling of a very complex real world problem, and is a purely proof-of-concept based fun idea we wanted to experiment with. Massive thanks to the collaborative effort of our team which made this whole project possible. I've mentioned their names in the notes and references.

## Notes and References:

### Team:
* Chinmay
* Hitish
* Aditya
* Devansh
* Shivam

Theory: An Engineering Approach to Digital Design (William L. Fletcher) 

Software used for VHDL implementation: Vivado








