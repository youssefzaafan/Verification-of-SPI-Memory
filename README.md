# SPI Memory Verification using UVM

## Overview

This project presents a **SystemVerilog UVM-based testbench** to verify an **SPI Memory** module. It follows industry-standard verification methodologies with a modular, scalable, and reusable testbench architecture. The design under verification includes a memory block and an SPI controller, and the verification environment is fully constrained-random with functional coverage.

![SPI Memory + Controller Flow](Verification-of-SPI-Memory/Screenshot%20(3).png)
![Controller Flow Diagram](Verification-of-SPI-Memory/Screenshot%20(4).png)
![Memory Flow Diagram](Verification-of-SPI-Memory/Screenshot%20(6).png)

---

## Testbench Architecture

The entire UVM environment is encapsulated in a **package (`pkg`)**, allowing for easy reuse and integration. 
The `agent` includes the following components:
- **Driver**
- **Monitor**
- **Sequencer**
- **Sequence (with multiple randomized and directed tests)**

A single **UVM Agent** handles SPI transactions, and the testbench includes:

- **Environment**
- **Scoreboard**
- **Subscriber**
- **SPI Interface**

---

## Key Features

- ✅ **Modular UVM Testbench** with `agent`, `env`, and `test` separation
- ✅ **Integrated Functional Coverage** on both `address` and `data` fields
- ✅ **100% Functional Coverage Achieved**
- ✅ **Reusable Class Packaging (`pkg`)**
- ✅ **Constrained Random Testing**
- ✅ **Assertions and Self-Checking Scoreboard**
- ✅ **Testcase Scalability** for future protocol extensions

---


## Coverage

The following covergroups were implemented to ensure exhaustive testing:

- `cg_data` – Covers all possible SPI data values
- `cg_address` – Covers all valid memory address ranges

✅ **Coverage Results**:  
- `cg_data`: 100%  
- `cg_address`: 100%
- Functional coverage report available in the `coverage_data.txt` .

---

## Simulation

- Simulator Used: **Aldec Rivieria Pro 2023.04**
- Test Results: All testcases passed successfully with zero failures.
  [EDA Playgroud Link to Run](https://www.edaplayground.com/x/Y6QY)

---

## Conclusion

This UVM environment provides a robust verification solution for SPI Memory systems, demonstrating full functional coverage and a reusable modular structure.

> **Note**: All verification components are wrapped under a single package `pkg` to streamline reuse and minimize integration effort in future projects.

---

## Author

Youssef Zaafan  
📧 youssefzafan@gmail.com  
🔗 [LinkedIn](https://www.linkedin.com/in/youssef-zaafan-211482169)

