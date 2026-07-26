# Smart UART Data Logger using Verilog HDL

![Verilog](https://img.shields.io/badge/Language-Verilog-blue)
![Simulation](https://img.shields.io/badge/Simulation-Icarus%20Verilog-success)
![Waveform](https://img.shields.io/badge/Waveform-GTKWave-orange)
![Synthesis](https://img.shields.io/badge/Synthesis-Yosys-red)
![License](https://img.shields.io/badge/License-All%20Rights%20Reserved-red)

A **Register Transfer Level (RTL)** implementation of a **Smart UART Data Logger** using **Verilog HDL**.

This project demonstrates the design, verification, and synthesis of a UART-based data logging system capable of receiving serial data, converting it into parallel format, validating the UART frame, and storing the received data into a memory buffer.

The design follows a modular RTL architecture consisting of:

- Baud Rate Generator
- UART Receiver
- Data Logger
- Top-Level Smart UART Logger

The complete digital design flow is demonstrated using:

- Verilog HDL for RTL design
- Icarus Verilog for functional simulation
- GTKWave for waveform analysis
- Yosys for RTL synthesis

---

# Project Overview

The Smart UART Data Logger is an RTL-based UART receiver design implemented using Verilog HDL.

The system receives serial UART data, converts it into parallel format, validates the received frame, and stores the data in a memory buffer using an FSM-based control architecture.

The design was verified using Icarus Verilog and GTKWave, and synthesized using Yosys.

----

# Features

- UART Receiver implementation
- Baud Rate Generator
- Start Bit Detection
- 8-bit Serial-to-Parallel Data Conversion
- Stop Bit Verification
- FSM-Based UART Control
- Memory Buffer for Data Logging
- Data Ready Signal Generation
- Modular RTL Architecture
- Synthesizable Verilog Design
- Functional Verification using Testbench
- Simulation using Icarus Verilog
- Waveform Analysis using GTKWave
- RTL Synthesis using Yosys

---

# Design Architecture

The Smart UART Data Logger consists of three major RTL blocks.

## 1. Baud Generator

The Baud Generator provides timing control for UART communication.

Functions:

- Generates UART baud timing pulses
- Controls serial data sampling rate
- Provides synchronization for UART reception


## 2. UART Receiver

The UART Receiver handles incoming serial communication.

Functions:

- Detects UART start bit
- Receives 8-bit serial data
- Performs serial-to-parallel conversion
- Validates stop bit
- Generates received data output


## 3. Data Logger

The Data Logger stores received UART data.

Functions:

- Stores received bytes into memory
- Maintains memory address
- Generates data ready indication

---

# Block Diagram

```
                 UART Serial Input
                        |
                        v

              +-------------------+
              |  Baud Generator   |
              +-------------------+
                        |
                        v

              +-------------------+
              |  UART Receiver    |
              +-------------------+
                        |
                        |
                 Received Data
                        |
                        v

              +-------------------+
              |   Data Logger     |
              |  Memory Buffer    |
              +-------------------+
                        |
                        v

                Logged Data Output
```

---

# FSM Design

The UART Receiver is controlled using a **Finite State Machine (FSM)** to ensure correct UART frame reception.

## UART Frame Format

```
Start Bit | 8 Data Bits | Stop Bit

    0     |   D7-D0     |    1
```

Example:

```
0 10101010 1
```

---

# FSM States

| State | Description |
|-------|-------------|
| IDLE | Waits for UART communication and monitors RX line |
| START_BIT | Detects and validates the UART start bit |
| RECEIVE_DATA | Receives 8 serial data bits and converts them into parallel data |
| STOP_BIT | Checks the UART stop bit |
| STORE_DATA | Stores received byte into memory |
| DONE | Generates data ready signal and returns to IDLE |

---

# FSM Flow

```
              +-------+
              | IDLE  |
              +-------+
                  |
                  v
          +---------------+
          |  START_BIT    |
          +---------------+
                  |
                  v
          +---------------+
          | RECEIVE_DATA  |
          +---------------+
                  |
                  v
          +---------------+
          |   STOP_BIT    |
          +---------------+
                  |
                  v
          +---------------+
          |  STORE_DATA   |
          +---------------+
                  |
                  v
              +-------+
              | DONE  |
              +-------+
                  |
                  |
                  v
                IDLE
```

---

# Project Structure

```
Smart-Uart-Data-Logger
│
├── LICENSE
├── README.md
├── synth.ys
│
├── rtl
│   ├── baud_generator.v
│   ├── uart_rx.v
│   ├── data_logger.v
│   └── smart_uart_logger.v
│
├── tb
│   └── uart_logger_tb.v
│
├── sim
│
└── images
    ├── gtkwave_simulation_waveform.png
    ├── simulation_result.png
    └── yosys_rtl_schematic.png
```

---

# Tools Used

| Tool | Purpose |
|------|---------|
| Verilog HDL | RTL Design |
| Icarus Verilog | Functional Simulation |
| GTKWave | Waveform Analysis |
| Yosys | RTL Synthesis |
| Ubuntu WSL | Development Environment |

---
# Simulation

The Smart UART Data Logger was verified using a Verilog testbench and simulated using **Icarus Verilog**.

The testbench performs:

- UART serial data transmission
- Start bit generation
- 8-bit data transmission
- Stop bit generation
- Data reception verification
- Memory storage validation

---

# Simulation Flow

## Compile RTL and Testbench

```bash
iverilog -o sim/uart_logger rtl/*.v tb/uart_logger_tb.v
```

---

## Run Simulation

```bash
vvp sim/uart_logger
```

---

# Expected Simulation Output

The simulation successfully receives the UART byte `0xAA`, stores it into the memory buffer, and updates the memory address after successful frame reception.

### Output

```text
UART Received Data = aa
Stored Data = aa
Memory Address = 1
```

---

# Simulation Result

The simulation output confirms successful UART data reception and storage.

![Simulation Result](images/simulation_result.png)

---

# GTKWave Waveform Analysis

The generated waveform file is analyzed using GTKWave.

Run:

```bash
gtkwave sim/uart_logger.vcd
```

The waveform verifies:

- Clock operation
- Reset behavior
- UART RX signal
- Serial data reception
- Data conversion
- Data storage operation
- Data ready indication

![GTKWave Simulation Waveform](images/gtkwave_simulation_waveform.png)

---

# RTL Synthesis using Yosys

The RTL design was synthesized using **Yosys** to verify synthesizability and generate the hardware representation.

## Synthesis Command

```bash
yosys synth.ys
```

The synthesis flow performs:

- Verilog RTL parsing
- Design hierarchy analysis
- Process conversion
- Logic optimization
- Technology mapping
- RTL schematic generation

---

# Yosys Synthesis Summary

The complete design was successfully synthesized with the following hardware structure:

| Metric | Value |
|--------|------:|
| RTL Modules | 4 |
| Total Wires | 151 |
| Total Wire Bits | 989 |
| Public Wires | 30 |
| Public Wire Bits | 129 |
| Memories | 0 |
| Memory Bits | 0 |
| Total Cells | 428 |

Synthesized RTL hierarchy:

```
smart_uart_logger
│
├── baud_generator
│
├── uart_rx
│
└── data_logger
```

The synthesis results confirm that the Verilog RTL implementation is suitable for FPGA/ASIC hardware realization.

---

# RTL Schematic

The RTL schematic generated by Yosys provides a graphical representation of the synthesized hardware structure.

![Yosys RTL Schematic](images/yosys_rtl_schematic.png)

---

# Results

The Smart UART Data Logger successfully demonstrates a complete digital design workflow.

## Verified Functions

✔ UART Start Bit Detection

✔ Serial Data Reception

✔ 8-bit Serial-to-Parallel Conversion

✔ Stop Bit Validation

✔ Data Storage in Memory Buffer

✔ Data Ready Signal Generation

✔ Functional Simulation using Icarus Verilog

✔ Waveform Verification using GTKWave

✔ RTL Synthesis using Yosys

---
# Learning Outcomes

- UART Protocol Implementation
- FSM-Based RTL Design
- Verilog HDL Coding
- Testbench Development
- Functional Verification
- GTKWave Waveform Analysis
- Yosys RTL Synthesis
- Digital Design Flow

---
# Future Improvements

- UART Transmitter Implementation
- FIFO-Based Data Buffer
- FPGA Hardware Validation
- Configurable Baud Rate Support

---
# Author

**Monita Ciea Salins**

Electronics and Communication Engineering Student

## Areas of Interest

- VLSI Design
- RTL Design
- Digital Design
- FPGA Design
- ASIC Design
- Verilog HDL

## Connect

GitHub:  
https://github.com/Monita-Ciea

LinkedIn:  
https://www.linkedin.com/in/monita-ciea-salins-a76583298/

---

# License

Copyright © 2026 Monita Ciea Salins. All Rights Reserved.

This project is intended for educational and portfolio purposes only.

See the `LICENSE` file for details.
