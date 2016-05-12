---
title:      Easier way to use intbv or Signal as an array index
task:       1
layout:     task
status:     Completed, 0.7
complexity: Easy
type:       modeling
---

Currently, you can't directly use a Signal or an intbv to index an array. Such
objects have to be converted explicitly using `int()` first.  Probably, this
can be solved with the `__index__()` special method.  This should be tried out
both for indexing and slicing.
