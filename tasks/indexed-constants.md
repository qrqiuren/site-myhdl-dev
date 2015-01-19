---
title:        More general support of indexed constants
task:         4
status:       Open 
layout:       task
complexity:   Medium to hard
requirements: Access to a synthesis tool 
type:         conversion
---

Currently, indexing into a tuple of constants is supported by conversion in a
limited way. The code has to written so that the indexing operations can be
expanded in-place into a case statement. This is mapped to ROMs by some
synthesis tools, such as Xilinx synthesis.

It would be nicer to be able to use indexing into a tuple of constants in a
general way. This could be done by mapping the tuple access to a function in
Verilog and VHDL, with the index as the parameter. The function call could then
be used and converted without restrictions. 

The question is what synthesis tools do with this. For example, suppose you
call the function multiple times with different indices in the same expression.
Some restrictions would be acceptable, as long as the basic ROM mapping feature
still works.

It may be best to include tuples of constants in the hierarchical extraction
process to give them an unique name, like is done for signals and lists of
signals.
