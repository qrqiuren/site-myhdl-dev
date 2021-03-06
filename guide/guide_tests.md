---
title: Writing Tests
layout: article
author: Udara Piumal, Christopher Felton
---

Introduction
============
The MyHDL project contains an extensive test suite.  The tests 
are critical to the quality and expansion of the project.  As 
a developer (new or not) one of the first things you will do 
is write a test.  This document is an introduction to the MyHDL
test suite.


MyHDL test suite
================
The test suite contains two main sets of tests:

* Core: The core tests all the hardware description types and
  extensions in the package.  In the repository core tests can be 
  found under: [myhdl/test/core][test_core]

* Conversion: The conversion tests verify the conversion 
  from MyHDL to Verilog and VHDL.  In the repository conversion 
  tests can be found under: [myhdl/test/conversion][test_conv]

The conversion tests are most often added under [myhdl/test/conversion/general][test_conv_gen]
and make use of [convertible testbenches][tbconv]
There are additional conversion tests that use cosimulation but these
tests are not covered in this document.

<!-- link references used above -->
[test_core]: https://github.com/jandecaluwe/myhdl/tree/master/myhdl/test/core
[test_conv]: https://github.com/jandecaluwe/myhdl/tree/master/myhdl/test/conversion
[test_conv_gen]: https://github.com/jandecaluwe/myhdl/tree/master/myhdl/test/conversion/general
[tbconv]: http://docs.myhdl.org/en/latest/whatsnew/0.6.html#conversion-of-test-benches
[test_bugs]: (https://github.com/jandecaluwe/myhdl/tree/master/myhdl/test/bugs).

The test suite uses [pytest](http://pytest.org) as a
test framework and test runner.  The MyHDL development follows a 
test-driven-design (TDD) methodology, in most cases this involves
having a test generated before a feature is added or a bug is 
fixed.

The [pytest](http://pytest.org) package will need to be installed 
to run the tests.

As bugs or issues are discovered tests are created to reproduce
the issue.  An issue description is first entered into the [issue-tracker].
Then a test can be created in [myhdl/test/bugs/][test_bugs]
The test name should contain the github issue number:

    test_issue_<github issue #>.py
    
The tests in the [bugs][test_bugs] directory are a mix of core and 
conversion tests depending on the issue.  The tests in this directory need to
be invoked similar to the tests in the conversion/general (see below).

HDL simulators
--------------
In addition to [pytest](http://pytest.org) an HDL simulator will be 
required to run the conversion tests.  The following is a list of 
simulators commonly used with the conversion tests.  A simulator 
or analyzer will need to be installed to run the conversion tests.

* Icarus Verilog (iverilog): Icarus Verilog is a Verilog simulation 
  and synthesis tool.  Icarus is an [open-source project](https://github.com/steveicarus/iverilog)

* GHDL (ghdl): GHDL is an open source VHDL simulator. An [installation 
  guide](http://design4hardware.blogspot.com/2015/04/install-ghdl.html) is available. 

* Modelsim (vcom, vlog): vcom and vlog are VHDL and Verilog compilers, 
  respectively.  They ship with [ModelSim by MentorGraphics](http://www.mentor.com/products/fv/modelsim/).
  For installation tips [this guide](http://mattaw.blogspot.com/2014/05/making-modelsim-altera-starter-edition.html) 
  is useful.
      
Other simulators are supported and it is not difficult
to add a new simulator or analyzer.


Running core tests
------------------

```
    >> python setup.py develop
    >> cd myhdl/test/core
    >> py.test   # or make
```

The above command will run all the tests present in core folder. 
If you only want to run a specific test you can do the following.

```
    >> py.test <name_of_test>
```

Running conversion tests
------------------------

```
    >> cd myhdl/test/conversion/general
    >> py.test --sim=('iverilog', 'ghdl', 'vlog', 'vcom') 
```

The `--sim` command line argument is used to select the simulator 
used in the tests.  Many of the tests in the [test/bugs][test_bugs] 
also verify converted results.  The bug/issue tests will need the 
`--sim` argument.


Writing tests
=============
<!-- @todo: some intro here -->

General guidelines
------------------
* Keep it Simple: tests do not have to be complex hardware designs. 
  They should be simple enough to quickly understand.
  
* Focus on a specific feature/function: a test should target a 
  specific feature or issue.  This reduces complicated tests that 
  can be difficult to understand and maintain.
  
* Fully tested: for the feature/issue being tested make sure all 
  aspects are tested.  Test expected failures as well as expected 
  success.
  
* Debug friendly:  Try and provide as much information as possible 
  when a test detects an error.  This will assist in future debugging.
         

<!-- @todo: new section name -->
Using `py.test`
---------------
The following is a brief overview of the test structure using the 
[pytest](pytest.org) style.  Refer to the [pytest site](pytest.org) 
for more information on the pytest framework and test structure.

<!-- @todo: brief summary of  pytest -->
* Files with names `test_*.py` and functions with names `test_*` will
  be executed by the `py.test` runner.
  
* Functions with names `test_*` will be executed as tests by the
  test runner.
  
* Use Python's `assert` statements in the functions to validate 
  expected results and responses.


### Example
The following is a toy example to test the `intbv` assignment 
and bounds.

```python

import pytest
import myhdl
from myhdl import intbv

def test_intbv_assign():
    x = intbv(0, min=-8, max=8)
     x[:] = 4
    assert x == 4
    with pytest.raises(ValueError):
        x[:] = -9
    
```


Writing conversion tests
------------------------
The MyHDL package has simulators that are registered in the code
base.  As mentioned above a registered simulator is selected by
using the `--sim=<sim>` argument with `py.test`.  Two functions 
can be used with the registered simulators to verify converted code.  
The [analyze][analyze_func] and [verify][verify_func] functions.

[analyze_func]: http://docs.myhdl.org/en/stable/manual/reference.html#myhdl.conversion.analyze
[verify_func]: http://docs.myhdl.org/en/stable/manual/reference.html#myhdl.conversion.verify

The [analyze][analyze_func] function is used to verify the converted 
code passes the analysis stage (compilation).  The [analyze][analyze_func] 
function is invoked similar to the conversion functions and the 
[traceSignals][trace].


[convver]: http://docs.myhdl.org/en/stable/manual/reference.html?highlight=component#module-myhdl.conversion
[trace]: http://docs.myhdl.org/en/stable/manual/reference.html#myhdl.traceSignals


### Example using `analyze`

The following example has a valid module and we can check the 
conversion using the `analyze` function.  As mentioned with will
invoke the simulator’s analysis.

```python
def my_valid_module(a, b):
    @always_comb
    def digital_logic():
        b.next = a
    return rtl


def test_valid_analyze():
    a, b = [Signal(bool(0) for _ in range(2)]
    assert analyze(my_module_exposes_issue, a, b) == 0
```

The above can be run with:

```
   >> py.test —sim=iverilog test_valid_module.py
```


### Example using `verify`

The verify function will use a convertible test bench and run the
converted code with the Verilog or VHDL simulator.  First a 
convertible test bench is created.

```python
def tb_valid_module():
    a, b = [Signal(bool(0)) for _ in range(2)]    
    tbdut = my_valid_module(a, b)
    
    @instance
    def tbstim():
        yield delay(2)
        assert a == b == False
        a.next = True
	yield delay(2)
	assert a == b == True
	
	return tbdut, tbstim


def test_valid_verify():
    assert verify(tb_valid_module) == 0
```


If the above is added to the same file, we can invoke py.test 
test same as above and the second test will be run as well.

A template that can be used with Eclipse and othe editors 
can be found [here](https://gist.github.com/josyb/81a837f3ff3dd3eaae2a)




