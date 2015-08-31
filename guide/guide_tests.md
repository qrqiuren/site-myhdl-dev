---
title: Writing Tests
layout: article
author: Udara Piumal
---

Introduction
============
Test cases are useful in verifying the features and functionalities 
of MyHDL. They also serve the purpose of guiding users on how to use 
different features of MyHDL.
Mainly there are two types of test cases in MyHDL.

* Core Tests
    - These tests are written to verify core functionalities of MyHDL. 
      In the repository core tests can be found under :
    [REPO/myhdl/test/core](https://github.com/jandecaluwe/myhdl/tree/master/myhdl/test/core) and 
    [REPO/myhdl/test/core2](https://github.com/jandecaluwe/myhdl/tree/master/myhdl/test/core2)

* Conversion Tests
    - Thess tests are written to verify if the conversion from MyHDL 
      to Verilog or MyHDL to VHDL has happened properly. 
      In the repository conversion tests can be found under: 
    [REPO/myhdl/test/conversion](https://github.com/jandecaluwe/myhdl/tree/master/myhdl/test/conversion)

Run built-in tests
==================

Prerequisites
-------------
The MyHDL tests use py.test as the test runner.  The conversion
tests require a Verilog and VHDL simulator.  The following lists
the simulators currently supported.

* py.test
    - pytest is a mature full-featured Python testing tool. MyHDL uses 
      py.test in MyHDL/test/core2/ and MyHDL/test/convertion/
    - Intallation guid for pytest can be found 
      [here](http://pytest.org/latest/getting-started.html)
* icarus Verilog
    - Icarus Verilog is a Verilog simulation and synthesis tool. MyHDL 
      to Verilog conversions can be verified using this.
    - It is an open-source project. Source can be found 
      [here](https://github.com/steveicarus/iverilog)
* GHDL
    - GHDL is a popular open source VHDL simulator. MyHDL to VHDL 
      conversions can be verified using this.
    - Installation guide for ghdl-updates from source can be found 
      [here](http://design4hardware.blogspot.com/2015/04/install-ghdl.html)
* vcom / vlog
    - vcom and vlog are VHDL and Verilog compilers in respective order. 
      They ships with ModelSim by MentorGraphics.
    - Details about Modelsim can be found [here](http://www.mentor.com/products/fv/modelsim/)
    - Linux version of Modelsim is mainly targeting RedHat. Therefore 
      incompatible with the freetype library in Ubuntu 14.04. A guide 
      to resolve this issue can be found
      [here](http://mattaw.blogspot.com/2014/05/making-modelsim-altera-starter-edition.html)

Run Core tests
--------------
```
    $ export PYTHONPATH=<Path_To_Repo>
    $ cd <Path_To_Repo>/myhdl/test/core
    $ make
```
Above command will run all the tests present in core folder. If you only want to run a specific test you can do the following.
```
    $ py.test <Name_Of_Test>
```
Run Conversion tests
--------------------
```
    $ export PYTHONPATH=<Path_To_Repo>
    $ cd <Path_to_Repo>/myhdl/test/conversion/general
    $ make
```
Default simulator for conversion tests is vlog and vcom. But you can 
select the one you prefer as follows
```
    $ make icarus OR $ make GHDL
```
Write your own test
===================

Methodology
-----------
1. Decide on the feature or function that is going to be tested. (File 
   name of the test case should contain this information)
2. Study the events/scenarios where the particular feature is used. 
   Pick a simple and common way of using it.
3. Write a simple design which uses the particular feature.
4. Generate a test vector of reasonable size.
5. Validate the output of the unit under test against the expected output.

*Sometimes the test will be written to missuse a feature and then will 
be tested for raising the correct exception.*

General Guidelines
------------------
* Keep it Simple
    - Tests does not have to be complex hardware designs. They should 
      be simple enough to understand quickly.
* Focused on a specific functionality
    - A single test should only test for a destinguishable specific 
      functionality.
* Cover all/most possible encounters
    - The test should verify the functionality is valid for every/most 
      possible scenarios. For instance if 8 bit input is used, 
      try to test the functionality for 256 possible numbers.
* Debug friendly
    - It would be helpfull if the test prints informative messages. 
      For instance messages can be added to assertions so that if the 
      assertion failed it would print possible causes for the failure.

Validating output
=================

Using unittest
--------------
*unittest is maintenance for legacy tests and MyHDL recommends using 
py.test for all new tests*

* unittest is the buil-in unit testing framework in python. 
  myhdl/core/ tests is using unittest to perform tests.
* Following snippet is an example of using unittest to verify that 
  myhdl.enum need to be unique literals.
* Have a look at the full test suit : 
  [test_enum.py](https://github.com/jandecaluwe/myhdl/blob/master/myhdl/test/core/test_enum.py)

```python
import unittest
from myhdl import enum

class TestEnum(unittest.TestCase):
    def testUniqueLiterals(self):
        try:
            t_State = enum("SEARCH","CONFIRM","SEARCH")
        except ValueError:
            pass
        else
            self.fail()
            
if __name__ == "__main__":
    unittest.main()
```

Using py.test
-------------
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