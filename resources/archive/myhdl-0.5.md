---
title: MyHDL 0.5 
layout: article
date: 2006-10-19 
---

{% from 'util.html' import open, done %}

Status
======

0.5.1 has been released

To do for 0.5.1
===============

* {{done}} solve bug with right shifting of negative numbers - use arithmetic shift in Verilog
* {{done}} solve inconsistency bug with Python versions in setup.py

toVerilog:

* {{done}} review shortcutting boolean operations, may be too restrictive
* {{done}} use if instead of case with a single test
* {{done}} document undocumented feature to hide MyHDL code from the Verilog convertor, using "`if __debug__`" 

To do for 0.5
=============

User-defined Verilog: error handling 

* {{done}} acceptable values of the `driven` attribute 
* {{done}} error messages when exceptions occur with user-defined code 
* {{done}} `__toVerilog__` not supported in generator functions 

Signed arithmetic: 

* {{done}} investigate fine-grained approach 
* {{done}} use base classes for Enum and EnumItem, so that type-checking is possible 

Miscellaneous: 

* {{done}} check typo bug with signal tracing 
* {{done}} check simulation suspend mechanism 

Decorators: 

* {{done}} investigate approach to remove limitations on `@always` decorator 
* {{done}} infer specialized _Waiter class depending on sensitivity list  

Verification and error reporting: 

* {{done}} argument tests on `@always` 
* {{done}} test waiter inference for `@always` and `@always_comb` 
* {{done}} argument tests on `@instance` 

Get feedback on style issues 

* {{done}} `clk.posedge` instead of `posedge(clk)` 
* {{done}} promoting general usage of decorators 

Update documentation ... 

* {{done}} update what's new document 
* {{done}} add note on positive numbers returned by slicing of intbv 
* {{done}} make full pass over manual with new info 

