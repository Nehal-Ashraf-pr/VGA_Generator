## **VGA Controller with Custom Sync and RGB Pattern**  

### **Project Overview**  
This project implements a **custom VGA controller** in Verilog with **adjustable horizontal and vertical sync signals** and a **smooth RGB color pattern**. The design operates with a **10x6 resolution** (for testing) and follows proper VGA timing principles.

### **Features**
✔ **Customizable h_counter and v_counter limits**  
✔ **Adjustable sync signal timing**  
✔ **Smooth color transitions based on pixel position**  
✔ **Synthesizable for FPGA deployment**  
✔ **Simulatable in Xilinx ISim**  

---

## **Implementation Details**
### **1️⃣ Horizontal & Vertical Counters**
- `h_counter` increments **from 0 to 9**, then resets.
- `v_counter` increments **from 0 to 5**, then resets.

### **2️⃣ Sync Signal Generation**
- `h_sync` is **LOW only during h_counter [7,8,9]**.
- `v_sync` is **LOW only during v_counter [3,4,5]**.

### **3️⃣ Dynamic RGB Output**
- Colors change smoothly across pixels:
  - **Red (100)** for top-left pixels.
  - **Green (010)** for mid-left pixels.
  - **Blue (001)** for bottom-left pixels.
  - **White (111)** for a transition effect.

---

## **File Structure**
```
|-- vga_controller.v       # Main VGA Controller module
|-- vga_controller_tb.v    # Testbench for simulation
|-- README.md              # Documentation
|-- xilinx_project/        # Xilinx ISE project files
```

---

## **Setup & Simulation**
### **1️⃣ Environment Setup**
- Install **Xilinx ISE / Vivado**.
- Clone the repository or download project files.

### **2️⃣ Running the Simulation**
1. Open **Xilinx ISE**.
2. Add `vga_controller.v` and `vga_controller_tb.v` to the project.
3. Set **`vga_controller_tb.v`** as the top-level module.
4. Run **Behavioral Simulation**.
5. Observe `h_sync`, `v_sync`, `h_counter`, `v_counter`, and `rgb` in the waveform.

---

## **Sample Testbench Output**
```
Time=0      | H_COUNTER=0  | V_COUNTER=0  | H_SYNC=1 | V_SYNC=1 | RGB=100
Time=16500  | H_COUNTER=9  | V_COUNTER=0  | H_SYNC=0 | V_SYNC=1 | RGB=010
Time=33200  | H_COUNTER=9  | V_COUNTER=1  | H_SYNC=0 | V_SYNC=1 | RGB=100
Time=50000  | H_COUNTER=9  | V_COUNTER=2  | H_SYNC=0 | V_SYNC=0 | RGB=001
Time=66500  | H_COUNTER=9  | V_COUNTER=3  | H_SYNC=0 | V_SYNC=0 | RGB=111
Time=83000  | H_COUNTER=9  | V_COUNTER=4  | H_SYNC=0 | V_SYNC=0 | RGB=100
Time=100000 | H_COUNTER=9  | V_COUNTER=5  | H_SYNC=0 | V_SYNC=0 | RGB=010
```
![image](https://github.com/user-attachments/assets/1ab210b9-7380-47a4-bb91-deabc26ec07c)

---

## **Future Improvements**
🔹 Implement **higher resolutions** (e.g., **640x480**).  
🔹 Improve **RGB pattern generation** for gradient effects.  
🔹 Optimize **sync signal timing** for real VGA displays.  
🔹 Deploy on FPGA and connect to a **physical monitor**.  

---
