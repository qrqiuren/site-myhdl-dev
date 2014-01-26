---
title: MyHDL 0.5 
layout: article
date: 2006-10-19 
---

Status
======

0.5.1 has been released

To do for 0.5.1
===============

* [x] solve bug with right shifting of negative numbers - use arithmetic shift in Verilog
* [x] solve inconsistency bug with Python versions in setup.py

toVerilog:

* [x] review shortcutting boolean operations, may be too restrictive
* [x] use if instead of case with a single test
* [x] document undocumented feature to hide MyHDL code from the Verilog convertor, using "`if __debug__`" 

To do for 0.5
=============

User-defined Verilog: error handling 

* [x] acceptable values of the `driven` attribute 
* [x] error messages when exceptions occur with user-defined code 
* [x] `__toVerilog__` not supported in generator functions 

Signed arithmetic: 

* [x] investigate fine-grained approach 
* [x] use base classes for Enum and EnumItem, so that type-checking is possible 

Miscellaneous: 

* [x] check typo bug with signal tracing 
* [x] check simulation suspend mechanism 

Decorators: 

* [x] investigate approach to remove limitations on `@always` decorator 
* [x] infer specialized _Waiter class depending on sensitivity list  

Verification and error reporting: 

* [x] argument tests on `@always` 
* [x] test waiter inference for `@always` and `@always_comb` 
* [x] argument tests on `@instance` 

Get feedback on style issues 

* [x] `clk.posedge` instead of `posedge(clk)` 
* [x] promoting general usage of decorators 

Update documentation ... 

* [x] update what's new document 
* [x] add note on positive numbers returned by slicing of intbv 
* [x] make full pass over manual with new info 

