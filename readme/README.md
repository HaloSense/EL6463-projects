# README for final exam

## Specification of project

According to the specification document, I built a train track controlling system based on a FSM I designed. The diagram I drew for the FSM looks like this:

![Diagram](Final_Diagram-1.jpg)

The FSM program specifies the inputs and outputs as requested.

The FSM is a Moore FSM, because the outputs (track status, light status, etc) can be determined by the state itself. It contains three `always` blocks:

* The first `always` block controls the state transition. When the reset signal is valid (in my case, my N number ends in 3 so reset signal is active-low), the state jumps back to the IDLE state unconditionally. For other cases, the state simply gets updated to the next state.
* The second `always` block determines the next state according to the input. There are 8 valid states, and in terms of exploiting FPGA resourse, I encode them in one-hot codes. The transition conditions are marked in the diagram. Because there are too many signals, all the signals that are not important to the state are not marked and are by default unchanged.
* The third `always` block determines the output. The output is only dependent on the state.

The testbench I wrote is in Verilog and test cases are imported in a CSV. Because all inputs and outputs are registered as asked, all outputs should be one cycle later than the input, which means the output will change one clock cycle after the input signals change. I have simulated situations where a train passes through track 1-3 and a train through track 2-4, a situation where emergency stop button is pressed (and trains waiting during the emergency state), and a situation where reset is set. This should be enough to demonstrate that the test is thorough.

## Clock cycle analysis

Exam time went out.

## Student Exam Code of Conduct

COPY + COMPLETE THE FOLLOWING IN YOUR README.

I certify and affirm that,

1. I am aware of the NYU Code of Conduct.
2. Work presented is 100% my own. I have not collaborated with anyone on the test.
3. I did not misrepresent someone else’s work (e.g. from the internet) as my own.
4. I did not discuss, nor in any way divulge the content of this test or my answers.
5. I understand that my failure to abide by this code of conduct will result in consequences outlined in the NYU Code of Conduct.

Name: Zijie Liu

Date: Dec 16 2022