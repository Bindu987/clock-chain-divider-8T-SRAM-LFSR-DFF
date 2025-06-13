# 🕒 Low-Power Clock Chain Dividers using 8T SRAM, Gated LFSR, and DFF

> A Comparative Study and Physical Implementation of Clock Chain Dividers  
> **Verilog | ModelSim | Synopsys DC | Cadence Innovus | RTL to Layout Flow**  

## 📘 Overview

This project presents the design, verification, and physical implementation of **three low-power clock divider architectures** using Verilog HDL:

- D Flip-Flop (DFF)-Based Divider
- Gated Linear Feedback Shift Register (LFSR)-Based Divider
- Symbolic 8T SRAM-Based Divider

Each design incorporates **clock gating, power gating, and test mode** for functional observability and power efficiency. The designs are verified using simulation and synthesized to analyze area, timing, and power trade-offs. The most efficient design (SRAM-based) is taken through **physical design using Cadence Innovus**.

---

## 🎯 Objectives

- ✅ Implement three RTL clock divider architectures
- ✅ Integrate low-power features (clock & power gating)
- ✅ Perform simulation using ModelSim
- ✅ Synthesize using Synopsys Design Compiler
- ✅ Compare area, power, and timing
- ✅ Physically implement the optimal design in Cadence Innovus

---

## 📂 Repository Structure

```
clock-chain-divider-8T-SRAM-LFSR-DFF/
├── src/                    # Verilog source and testbenches
│   ├── dff_clock_chain_divider.v
│   ├── gated_lfsr_clock_divider.v
│   ├── sram_clock_chain_divider.v
│   └── sram_8t_bitcell.v
│   └── tb_*.v              # All testbenches
├── netlist/                # Synthesized netlist (.vg)
│   └── sram_clock_chain_divider_netlist.v
├── reports/                # Synthesis, waveform, and layout results
│   ├── synthesis_reports.pdf
│   ├── waveform_snapshots.png
│   └── layout_screenshots.png
├── presentation/
│   └── 240FinalProject_presentation.pdf
├── report/
│   └── 240_FINAL_PROJECT.pdf
├── README.md
└── LICENSE
```

---

## 🧪 Functional Verification (ModelSim)

Each design was simulated using ModelSim with custom testbenches that verified:

- Clock/reset behavior  
- Clock and power gating functionality  
- Test mode override for debug  
- Correct state transitions and output waveforms  

🖥️ Waveforms and logs were captured for each architecture.

---

## 🧠 RTL Architectures

### 🔹 DFF-Based Divider
- Uses chained D flip-flops.
- Simple structure but high toggling = more power.

### 🔹 Gated LFSR-Based Divider
- Uses XOR feedback.
- Adds clock & power gating for improved efficiency.

### 🔹 8T SRAM-Based Divider (Proposed)
- Uses symbolic SRAM bitcells.
- Supports state retention and selective activation.
- Offers best power savings with minimal area trade-off.

---

## 📊 Synthesis Results (Synopsys DC)
✅ **SRAM-based divider** selected for physical design due to lowest power and acceptable area/timing.

---

## 🧱 Physical Design (Cadence Innovus)

Performed full backend layout for the 8T SRAM-based divider:

- Floorplanning  
- Power rings and stripes  
- Clock Tree Synthesis (CTS)  
- Standard cell placement  
- NanoRoute detailed routing  
- DRC verification  
- Power analysis

🖼️ Final layout is clean and shows optimized routing with minimal skew.

---

## 🚧 Challenges Faced

- RTL modeling of SRAM behavior  
- RTL gating integration without glitches  
- Interfacing Verilog → Synopsys DC → Innovus  
- Manual layout constraint tuning  
- Interpreting synthesis and power reports

---

## 🔭 Future Scope

- Extend SRAM-based design to 16-bit / 32-bit chains  
- Integrate into RISC-V processor subsystems  
- Perform IR-drop and post-route STA  
- Add automated Makefiles/scripts for full flow  
- Explore dynamic multi-Vt techniques

---

## 👨‍💻 Tools Used

| Tool                     | Use Case                            |
|--------------------------|-------------------------------------|
| **ModelSim**             | RTL Simulation                      |
| **Synopsys Design Compiler** | RTL Synthesis                    |
| **Design Vision**        | RTL/Gate Schematic View             |
| **Cadence Innovus**      | Floorplan, CTS, Routing, DRC        |
| **CentOS Linux 7**       | Linux environment for toolchain     |

---

## 📄 References

- CMOS VLSI Design – Weste & Harris  
- Synopsys and Cadence official tool manuals  
- IEEE Access, vol. 8, 2020: "Clock Division and Randomization using LFSRs"  
- https://www.researchgate.net/figure/The-schematic-diagram-of-8T-SRAM-cell_fig3_283862501

---

## 🙌 Authors

- **Bindu Sree Chandu**  
*California State University, Fresno*

---

## 📜 License

This project is licensed under the [MIT License](LICENSE).


## 📜 Disclaimer

The work presented here is intended solely for academic and educational purposes. It demonstrates concepts in RTL design, low-power architecture implementation, functional simulation, synthesis, and physical design using industry-standard tools such as ModelSim, Synopsys Design Compiler, and Cadence Innovus.

All content, including Verilog source code, simulation outputs, and design reports, is provided for learning, research, and portfolio use only. This repository is not intended for commercial applications.
