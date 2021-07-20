# Usage of source files

## requirements
There should be a folder named 'instances' which contains all the instances in the root directory of this project.

## the streamline
We first convert all .txt input files into .dzn files using `txt2dzn.py`. Then we use `processing.py` to read in all input files then do the calculation and finally write results to output files. `result-check.py` is the file we use to check whether the result of a single output file is correct.

### txt2dzn.py
To run this file, use `python3 txt2dzn.py` or `./txt2dzn.py` in termianl when in the same directory of the source file.

### processing.py
Use `python3 processing.py` or `./processing.py` in terminal to run this file when in the same directory as this file.

### result-check.py
This is also a python script file which checks whether a result file is correct.

To run this file, use `python3 result-check.py ../out/xxx-out.txt` or `./result-check.py ../out/xxx-out.txt` in terminal. Replace 'xxx' with a specific file name.
