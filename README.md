# Programming_Assignment_1
A two-part programming and bioinformatics assignment.

## Programming Section Instructions

Please write code to solve the challenge below as functions, methods, subroutines, etc. in whatever computer programming language you like.  No external references should be used for these questions.  Integers are of 64 bits in size, unless using a programming language that implements arbitrary-precision numbers natively in which case one can use that.
Bonus points if you also can describe (or even better code) what to do when the input is extremely large and may need to be either processed in parallel and/or distributed.
Given a sorted array of integers, X, and a target number, m, return the number of times m occurs in X.   For example, given X as 

2, 3, 4, 4, 4, 5, 6, 7, 7

and m = 4, then the return value is 3.  

For languages with array filtering built in, such as R and Python, do not use constructs such as X == m to subset the array.

## Bioinformatics Section Objectives

The goal of this exercise is to implement an algorithmic approach that will:

1. Identify segments of the chromosome with similar Log2(Ratio).
2. Use the Log2(Ratio) values in the segment to estimate the copy number.
3. Output a copy number for any point of the chromosome.
