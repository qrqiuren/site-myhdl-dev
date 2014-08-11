---
title: Guide
layout: article
author: Jan Decaluwe
---

Background info
===============

The [dev.myhdl.org] website aims to document all aspects of the development
process of the MyHDL project. MyHDL is a Python library to use
Python as a HDL. The main projects website is [here][myhdl]. 

*[HDL]: Hardware Description Language 

MyHDL's original developer, [jandecaluwe-mail], is MyHDL's BDFL. He has the
final say about its design and development decisions.  The development workflow
takes that into account.

*[BDFL]: Benevolent Dictator For Life

The repository
==============

MyHDL code development is managed on [bitbucket] using
[mercurial](http://www.selenic.com/mercurial).

The public repository resides [here][myhdl-repo].  Bitbucket offers an
excellent interface to the repository and its history. 

The repository can be used for several purposes, such as browsing through the
development history, and tracking development. In addition, you can use it to
contribute your own changesets.  

Tracking development
====================

Basic usage
-----------

If you have mercurial installed, you can use the repository to track
development.  First, use the instructions on Bitbucket to clone the repository
to a local repository on your machine.

In that directory you can check for new changesets at any time:

    $ hg in

To get new changesets:

    $ hg pull

To update the workspace with the new changesets: 

    $ hg update

Development branches
--------------------

The repository contains multiple branches. Each branch corresponds to a
development line with a specific purpose. Before using the repository to
install MyHDL or to develop your own changesets, make sure you are on the
correct branch.

To find out what branches are available, use:

    $ hg branches

Currently, the following branches are active:

Branch name   |  Purpose    | Policy                                                       
--------------|-------------|------------------------
 default      | Stable      | 0.8 release + bug fixes 
 0.9-dev      | Development | 0.9 new features 

To switch to a particular branch, use:
 
    $ hg update

Using the repository code
-------------------------

To use the repository code the simplest way is to adjust the `$PYTHONPATH` shell
variable. Let's assume you have checked out the MyHDL code from the mercurial
repository to `$HOME/dev/myhdl`. Insert that path as the first entry to the
`$PYTHONPATH` variable. When doing the import, the `myhdl` package in the
`$HOME/dev/myhdl` path will be found first, before any other MyHDL version that
may be installed.

For convenience you can put the change of the `$PYTHONPATH` variable in a script
and source it when needed. The bash shell script would look like this:

    PYTHONPATH="$HOME/dev/myhdl:${PYTHONPATH}"
    export PYTHONPATH

If you save this in `myhdl.sh`, you can use it as follows: 

    source myhdl.sh

Creating your own changesets 
============================

Introduction
------------

You can also make your own changesets and contribute them to the development. 

The workflow is such that every contributed change is reviewed by other
developers and applied or rejected by the BDFL. Therefore, your goal as a
contributor should be to minimize the work of other developers. What is needed
is the following:

* an understanding why the change is needed, and why
  it will be useful to many people
* some confidence that it won't break current
  and foreseeable features 
* the changes have to be tested  
* you have to use [mercurial](http://www.selenic.com/mercurial)
  to manage the changesets
* you have to use [Bitbucket](http://www.bitbucket.org)
  to fork the main repo and create Pull Requests.

The implementation of these requirements is described in more detail in the
following sections.

First step: communicate 
-----------------------

Don't send patches out of the blue.

Your first step is to communicate about the problem or feature with the MyHDL
community.  Start a discussion in the [mailing-list] or (if you are certain)
add an entry in the [bug-tracker].

The result will be a fruitful discussion that hopefully results in a decision
about what should be done. The byproduct will be a specification for the work.

Creating changesets
-------------------

To manage your patches, use mercurial. By doing so, the other developers can
simply use their normal development workflow to incorporate your work.
Moreover, your name will be preserved as the author, so you get the credit you
deserve.

In mercurial terminology, a set of patches that belong together is called
a *changeset*. Assuming you know how to work with mercurial, creating changesets
is easy. You make changes in your local repository clone, and use:

    hg commit

to create a new changeset that contains your patches.

Quality
-------

At a certain point you will want to publish your changesets, so that everyone
can benefit from them. However, don't publish your work until it is complete.
Make sure there are no loose ends that others will have to address after you.
Most importantly, make sure your changes have been tested.

Run the MyHDL regression tests to make sure nothing breaks.  As a minimum, the
tests in `test/core` should be run. If your changes are related to conversion
to VHDL/Verilog, the test in the `test/conversion` directories should be run
also.

Presumably, you have some test for your changes in place. If at all possible,
turn it into a test that can be added to the regression test suites.

You may need a number of changesets to complete your work. That isn't a problem
at all, on the contrary. Finish the job before publishing.  Note that this
development flow relies on the decoupling of the creation and the publication
of changesets.  This is a distinguishing feature of distributed revision
control systems versus centralized ones.

Contributing changesets
-----------------------

When you are ready with your changes, use mercurial and [Bitbucket] to publish
them. The advantage of using mercurial instead of traditional patch files is
that it minimizes the overhead to review and apply, and, more importantly, it
keeps the authoring information intact. Bitbucket has a great web interface to
review and merge the changesets.

Contributing changesets is done by creating *pull requests*. This
process is documented
[here](https://confluence.atlassian.com/display/BITBUCKET/Fork+a+Repo%2C+Compare+Code%2C+and+Create+a+Pull+Request).

Other developers will review the pull request, and the BDFL will decide to
merge it in or not.

