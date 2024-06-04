Assignment 01 | DCC035 - Operational Research | March 2024, Federal University of Minas Gerais

### Modelling optimization problems
In this assignment the students were meant to model 5 problems in the `Julia` programming language, to be solved by the HiGHS linear programming optimizer.

### What is linear programming for?
Here's what [Brilliant.org](https://brilliant.org/wiki/linear-programming/) ([mirror](https://web.archive.org/web/20240602224450/https://brilliant.org/wiki/linear-programming/)) says about it: *Linear programming can be used to solve a problem when the goal of the problem is to maximize some value and there is a linear system of inequalities that defines the constraints on the problem.*

In other words, we can get many types of real-world problems and then model them mathematically into linear equations, such that existing solvers may optimize their result. Many of these problems can have large amounts of variables and restrictions, but solving them this way can give us pretty good results and in reasonable time.

### How to run
#### Dependencies
In a linux environment, you will need the Julia Programming Language installed (see the [offical site](https://julialang.org/downloads/) for instructions).

You will also need the `JuMP` package to access the `HiGHS` optimizer. With Julia installed, open up a terminal and
- Type `julia` to open the environment
- Type `]` to open the package mode
- Type in `add JuMP` and then hit enter and wait for the installation
- Then type `add HiGHS`, hit enter and wait for it to finish.
- You can close things up with `Ctrl+D`.

#### Running
Inside the folder of each problem there will be a `.jl` file and a folder with problem instances. You may run each program in the terminal with the command ```julia program.jl instance.txt```. See an example below:
```shell
cd "Lot-Sizing problem"

julia lotsizing.jl "problem instances"/INST1_PB3.txt
```

### TODO
- Refactor code for readability
- Figure out A-colouring
- Revise readme problem explanations