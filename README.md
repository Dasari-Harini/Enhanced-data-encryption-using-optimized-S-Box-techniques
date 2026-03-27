#  Enhanced Data Encryption using Optimized S-Box Techniques

##  Overview
This project implements the **Advanced Encryption Standard (AES)** algorithm in Verilog with optimized S-Box techniques to improve hardware efficiency and performance.

The design includes complete AES functionality:
- Encryption
- Decryption
- Key Expansion
- Testbench verification

This project is focused on **hardware-level cryptography**, which is widely used in secure embedded and automotive systems.

---

##  Objectives
- Implement AES algorithm in Verilog
- Optimize S-Box for better performance
- Design modular encryption and decryption blocks
- Validate functionality using testbench

---

## AES Architecture
AES consists of the following steps:

1. SubBytes (S-Box substitution)
2. ShiftRows
3. MixColumns
4. AddRoundKey

This project includes both:
- Forward AES (Encryption)
- Inverse AES (Decryption)

---

##  Project Structure
CODE/
│── AES_encryption_top.v # Top module for encryption
│── AES_decryption_top.v # Top module for decryption
│── AES_key_expansion.v # Key generation logic
│── AES_testbench.v # Testbench for simulation
│── aes_rcon.v # Round constants
│── affine.v # Affine transformation
│── gamma.v # Galois field operations
│── inv_sbox.v # Inverse S-Box
│── AES_AR.v # AES round
│── AES_AR_DEC.v # AES inverse round
│── AES_FR.v # Final round

##  Tools & Technologies
- Verilog HDL
- Digital Design Concepts
- Simulation Tools (ModelSim / Vivado recommended)

---

##  How to Run

1. Open your simulation tool (ModelSim / Vivado)
2. Compile all `.v` files
3. Run the testbench:

AES_testbench.v
4. Observe waveform output for encryption/decryption results

---

##  Features
- Complete AES implementation
- Optimized S-Box design
- Modular and reusable code
- Testbench validation included

---

##  Applications
- Secure embedded systems
- Automotive ECUs
- Cryptographic hardware design
- FPGA-based security systems

---

##  Author
**Harini Dasari**  
Electronics and Communication Engineering Graduate  
Interested in Embedded Systems, Automotive, and Hardware Security

---

## Future Improvements
- FPGA implementation
- Performance comparison with standard AES
- Integration with embedded systems
