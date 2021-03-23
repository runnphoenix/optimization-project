# Usage of source files

## PWP-Z3.py
This is a python script file which contains the Z3 model. Use `python3 PWP-Z3.py` or `./PWP-Z3.py` in terminal to run this file when in the directory of this file.

This file reads all the input files in the `instances` direcoty and output result files in the `out` directory.

## result-check.py
This is also a python script file which check whether a reuslt file is correct.

To run this file, use `python3 result-check.py ../out/xxx-out.txt` or `./result-check.py ../out/xxx-out.txt` in termianl when in the same directory as this file.

## z3-utils-hakank.py
This is the file which contains global constraints which we downloaed from internet. This file is not meant to be run independantly.
