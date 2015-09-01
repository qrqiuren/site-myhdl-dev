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


MyHDL Test Suite
================
The test suite contains two main sets of tests:

* Core Tests: these test all the hardware description types and
  extensions in the package.  In the repository core tests can be 
  found under: [myhdl/test/core](https://github.com/jandecaluwe/myhdl/tree/master/myhdl/test/core)

* Conversion Tests: these tests verify conversion 
  from MyHDL to Verilog and VHDL.  In the repository conversion tests 
  can be found under: [myhdl/test/conversion](https://github.com/jandecaluwe/myhdl/tree/master/myhdl/test/conversion)

The conversion tests most often created are under [myhdl/test/conversion/general](https://github.com/jandecaluwe/myhdl/tree/master/myhdl/test/conversion/general)
and make use of [convertible testbenches](http://docs.myhdl.org/en/latest/whatsnew/0.6.html#conversion-of-test-benches)
There are addition conversion tests that use cosimulation but these
tests are not covered in this document.

The test suite uses [pytest](http://pytest.org) as a
test framework and test runner.  The MyHDL development follows a 
test-driven-design (TDD) methodology, in most cases this involves
having a test generated before a feature is added or a bug is 
fixed.

The [pytest](http://pytest.org) package will need to be installed 
to run the tests.

As bugs or issues are discovered tests are created to reproduce
the issue.  As issue description is first entered into the [issue-tracker].
Then a test can be crated in [myhdl/test/bugs/](https://github.com/jandecaluwe/myhdl/tree/master/myhdl/test/bugs).
The test name should contain the github issue number:

    test_issue_<github issue #>.py
    
The tests in the [bugs] directory 

HDL Simulators
--------------
In addition to [pytest](http://pytest.org) an HDL simulator will be 
required to run the conversion tests.  The following is a list of 
simulators commonly used with the conversion tests.

* Icarus Verilog [iverilog]: Icarus Verilog is a Verilog simulation 
  and synthesis tool.  Icarus is an [open-source project](https://github.com/steveicarus/iverilog)

* GHDL [ghdl]: GHDL is an open source VHDL simulator. An [installation 
  guide](http://design4hardware.blogspot.com/2015/04/install-ghdl.html) is available. 

* Modelsim [vcom, vlog]: vcom and vlog are VHDL and Verilog compilers, 
  respectively.  They ship with [ModelSim by MentorGraphics](http://www.mentor.com/products/fv/modelsim/).
  For installation tips [this guide](http://mattaw.blogspot.com/2014/05/making-modelsim-altera-starter-edition.html) 
  is useful.
      
Other simulators are supported as well and it is not too difficult
to add a new simulator or analyzer.


Running Core Tests
------------------

```
    >> python setup.py develop
    >> cd myhdl/test/core
    >> py.test   # or make
```

The above command will run all the tests present in core folder. 
If you only want to run a specific test you can do the following.

```
    >> py.test <Name_Of_Test>
```

Running Conversion Tests
------------------------
```
    >> cd myhdl/test/conversion/general
    >> py.test --sim=('iverilog', 'ghdl', 'vlog', 'vcom') 
```

The `--sim` command line argument is used to select the simulator 
used in the tests.


Writing Tests
=============

<!-- 
 @todo: this should be simplified, this document should contain
        the how's:
          - to add a test add it here
          - to run a test run it like
          - gotcha's and other things
-->

<!-- REMOVE METHODOLOGY 
Methodology
-----------
1. Decide on the feature or function that is going to be tested. (File 
   name of the test case should contain this information)
2. Study the events/scenarios where the particular feature is used. 
   Pick a simple and common way of using it.
3. Write a simple design which uses the particular feature.
4. Generate a test vector of reasonable size.
5. Validate the output of the unit under test against the expected output.

*Sometimes the test will be written to misuse a feature and then will 
be tested for raising the correct exception.*
-->

General Guidelines
------------------
* Keep it Simple: tests do not have to be complex hardware designs. 
  They should be simple enough to quickly understand.
  
* Focused on a specific feature/function: a test should target a 
  specific feature or issue.  This reduces complicated tests that 
  can be difficult to understand and maintain.
  
<!-- @todo: this needs rewording and not really true -->
* Cover all/most possible encounters: the test should verify the 
  functionality is valid for every/most possible scenarios. For 
  instance if 8 bit input is used, try to test the functionality 
  for 256 possible numbers.
  
* Debug friendly:  It would be helpful if the test prints informative 
  messages.  For instance messages can be added to assertions so that 
  if the assertion failed it would print possible causes for the failure.

<!-- REMOVE Valid... heading
Validating output
=================
--> 

<!-- 
  @todo: the unittest stuff should be removed because it is 
         deprecated
-->
         

Using `py.test`
---------------
* MyHDL prefer using py.test over unittest because it reduces the 
  number of lines and hence more readable.
* Python's assert method can be used for validating output. A sample 
  code snippet on how to use assert is shown below.
* Adding an error message to assert statement would make it more 
  debug friendly.

*py.test uses some naming conventions to discover test cases. Your 
file should contain the test_ prefix (Ex: test_issue9.py) and the test 
method should also have the test_ prefix (Ex: def test_UniqueLiterals() )*

```python
from myhdl import *

def issue_9():
    t = enum('foo', 'bar')
    assert (Signal(t.foo)==Signal(t.bar)) == False , "ERROR_MESSAGE"
    
def test_issue_9():
    issue_9()
```

Using conversion.verify
-----------------------
* MyHDL introduces conversion.verify to verify the conversions from MyHDL
* More information will be added soon