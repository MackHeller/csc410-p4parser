# csc410-p4parser

The goal of this project is to build a program to simplify boolean and linear integer arithmetic expressions.
To achieve this, we use a program synthesis tool called Rosette and our custom partial evaluation
procedure.
The problem is the following: given an expression, can you find an equivalent expression such that the size of the expression is smaller?
The main difficulty with synthesis is to design the search space for the programs to synthesize. We have two components: a grammar for the synthesizable expressions, 
and a skeleton to be completed by expressions in this grammar.
We also added our own simplification procedures. For example, (+ a 0) = a 
