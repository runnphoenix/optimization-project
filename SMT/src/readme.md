# Usage of source files

## requirements.txt
### Instances' location
There should be a folder named 'instances' which contains all the instances in the root directory of this project.
### libraties
To download all necesasry libraries for the project
`pip install -r requirements.txt`

## PWP-Z3.py
This is a python script file which contains the Z3 model. Use `python3 PWP-Z3.py` or `./PWP-Z3.py` in terminal to run this file when in the directory of this file.

This file reads all the input files in the `instances` directory and output result files in the `out` directory.

## result-check.py
This is also a python script file which check whether a reuslt file is correct.

To run this file, use `python3 result-check.py ../out/xxx-out.txt` or `./result-check.py ../out/xxx-out.txt` in termianl when in the same directory as this file.
