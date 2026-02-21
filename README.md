# Issue #1 – Pipelined rotate_shift Module

## 🔹 Problem Statement
The original `rotate_shift` module was implemented as a pure combinational logic design using `always_comb`.  
This creates a long combinational path which may lead to timing violations and negative slack in larger ALU integration.

---

## 🔹 Objective
To convert the combinational `rotate_shift` module into a pipelined sequential design by:
- Adding a clock (`clk`)
- Introducing pipeline registers
- Reducing critical path delay
- Improving timing performance

---

## 🔹 Modifications Made
1. Added `input logic clk` to the module.
2. Replaced `always_comb` with `always_ff @(posedge clk)`.
3. Introduced a 2-stage pipeline:
   - **Stage 1:** Register inputs `{a, b}` and `shift`
   - **Stage 2:** Perform rotation and register output
4. Updated testbench to include clock generation.

---

## 🔹 Pipelining Strategy

### Stage 1:
- Inputs are captured into registers.
- Shift value is reduced using `shift % 64`.

### Stage 2:
- Rotation logic is executed.
- Output is registered.

This breaks the long combinational path into two smaller stages.

---

## 🔹 Timing Improvement
By inserting pipeline registers:
- Critical path delay is reduced.
- Slack violations are minimized.
- Maximum operating frequency is improved.

---

## 🔹 Notes
- Output now appears after 2 clock cycles due to pipeline latency.
- Initial `X` values in simulation are expected because registers are uninitialized before the first clock edge.

---

## 📂 Files Included
- `rotate_shift.sv` – Pipelined design module
- `rotate_shift_tb.sv` – Updated testbench with clock generation
