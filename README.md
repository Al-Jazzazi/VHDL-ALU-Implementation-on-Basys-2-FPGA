# VHDL ALU Implementation on Basys 2 FPGA

This repository contains the implementation of an Arithmetic Logic Unit (ALU) using VHDL, designed to execute basic arithmetic and logical operations on a Basys 2 FPGA board. The project showcases the integration of digital logic design with hardware demonstration.

## Table of Contents

1. [Introduction](#introduction)
2. [Features](#features)
3. [Components](#components)
4. [Implemented Operations](#implemented-operations)
5. [Usage](#usage)
6. [Project Structure](#project-structure)
7. [Contributors](#contributors)
8. [Acknowledgements](#acknowledgements)

## Introduction

This project involves designing and implementing an ALU using VHDL, capable of performing various arithmetic and logical operations. The ALU is integrated with a seven-segment display to visually demonstrate the inputs and results of the operations on a Basys 2 FPGA board.

## Features

- 4-bit two's complement arithmetic
- 8 basic ALU operations
- Overflow detection and display
- Visual output using seven-segment displays
- Hierarchical design with modular components

## Components

1. **ALU Module (`ALU.vhd`)**: Performs arithmetic and logical operations.
2. **Display Module (`single_number.vhd`)**: Converts binary numbers to seven-segment display format.
3. **Top-level Module (`ALU_display.vhd`)**: Connects ALU and display modules, manages inputs and outputs.
4. **User Constraint File (`display.ucf`)**: Maps FPGA pins to the VHDL design.
5. **Netlist Circuit Description (`ALU_display_guide.ncd`)**: Contains the physical layout information from the place-and-route process.

## Implemented Operations

The ALU supports the following operations, which can be selected using FPGA switches:

1. **Addition (ADD)**: Adds two signed 4-bit numbers.
2. **Subtraction (SUB)**: Subtracts the second signed 4-bit number from the first.
3. **AND**: Performs bitwise AND on two 4-bit numbers.
4. **OR**: Performs bitwise OR on two 4-bit numbers.
5. **Rotate Right (ROR)**: Rotates the bits of the first number to the right.
6. **Shift Left Logical (SLL)**: Shifts the bits of the first number to the left logically.
7. **Shift Right Logical (SRL)**: Shifts the bits of the first number to the right logically.
8. **Shift Right Arithmetic (SRA)**: Shifts the bits of the first number to the right arithmetically.

## Usage

### Prerequisites

- Basys 2 FPGA board
- Xilinx ISE Design Suite

### Steps

1. **Clone the Repository**:
   ```sh
   git clone https://github.com/Al-Jazzazi/VHDL-ALU-Implementation-on-Basys-2-FPGA.git
   cd VHDL-ALU-Basys2
   ```

2. **Open in ISE**:
   Open the project in ISE using the files in the `iseconfigure` folder.

3. **Compile the VHDL Code**:
   Use ISE to compile the VHDL files and generate the bitstream.

4. **Load onto FPGA**:
   Load the generated bitstream onto the Basys 2 FPGA board.

5. **Test Operations**:
   Use the switches on the FPGA board to select and test different ALU operations. The inputs and results will be displayed on the seven-segment displays.

## Contributors

- Mohammad Amjad (maa9951@nyu.edu)
- Yousef Al-Jazzazi (ya2225@nyu.edu)

## Acknowledgements

This project is part of the Advanced Digital Logic course (ENGR-UH 2310) at New York University Abu Dhabi. Special thanks to Instructor Muhammad Hassan Jamil for guidance throughout the project.

