---
title: MyHDL 0.6 
layout: article
date: 2009-05-12
---

Status
======

0.6 has been released.

To do
=====

* [x] RAM support using array types 
* [x] operators with signed operands 
* [x] augmented operators 
* [x] enhanced `print` statement support 
* [x] user-defined VHDL support 
* [x] `inout` handling
* [x] enhance `toVerilog` so that it can work with the new verification method also.
In particular, `print` statements should be handled properly.
* [x] write conversion verification test benches for some cookbook examples
* [x] include date/tool info in conversion output 
* [x] review `if __debug__` functionality with new verification capabilities  
* [x] encoding attributes to enumeration types  
* [x] use a package in a separate file for general VHDL output code 

Open issues
===========

Name clashes
------------

* Find a good solution to avoid name clashes. In the Verilog output, I relied on using `_` as a prefix, but because VHDL doesn't allow this, and I want a general solution, this needs to change.

* Find a good solution to avoid name clashes with Verilog and VHDL keywords.

Rom inference support
---------------------

Currently, ROMs are inferred from case statements, as in Verilog. Users and synthesis tools may prefer arrays of integers. Feedback welcome.


User-defined VHDL code
----------------------

<del>It is straightforward to support the `__toVHDL__` attribute for
user-defined VHDL, similar to the Verilog solution. This may not be sufficient
however, because VHDL requires instantiated components to be declared in the
code. We may have to add a way to add such user-defined declarations.</del>
