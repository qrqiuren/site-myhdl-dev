---
title:        Initial values support
task:         2
layout:       task
status:       Open
complexity:   Easy to medium
requirements: Access to synthesis
tags:         conversion
---

Currently, there are often problems at the start of simulation with converted
code. For many data types, Verilog and VHDL start at `X`, but MyHDL doesn't
have that concept.

To have a better match, it would be preferable to use initial value syntax in
Verilog and VHDL based on the initial value of the Signal or intbv in MyHDL.
The only reason why this is not yet done is that some synthesis tools didn't
support this syntax some years ago, in particular Altera synthesis. It should
be checked whether this is still the case.

Note that the requirement is *not* that synthesis tools do something meaningful
with the initial value. Proper reset at the gate level should be done with an
explicit reset. The only goal is to have a better match at the RTL level.

An option could be to make this functionality programmable, using
an attribute of `toVerilog()` and `toVHDL()`.

Lists of signals and intbv's require special attention.

