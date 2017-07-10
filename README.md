# SATbox: A toolbox for exploring fractality in satisfiability (SAT) problems

Full explanations for the methods used are given in a submitted publication of which a preprint is available in this link 
http://vixra.org/abs/1707.0074 [PDF]

The core eval function uses a purely functional approach with a universal indicator function over any search interval.

The hierarchical classification used here is described in the below table

| Expression Type| Clauses       | Overlaps      |Satisfiability |
| -------------  | ------------- | ------------- | ------------- |
| SAT0           | Equal         | No            | Complete      |
| SAT1           | Unequal       | No            | Complete      |
| SAT2           | Equal         | Yes           | Partial       |        
| SAT3           | Unequal       | Yes           | Partial       |

When the total clause length and the overlap arithmetized codes are taken over an inclusive hierarchy of exponential intervals
complete enumeration of all such expressions over each level becomes possible with the aid of 
<a href="http://mathworld.wolfram.com/PartitionFunctionP.html">Integer Partition</a> and Restricted Integer Partition functions.

Partial satisfiability criterion depends only on the structure of a connectivity matrix in an assignment map from atoms to literals. 

Global Truth Tables (GTTs) are defined as symmetric matrices for all possible assignments of atoms to literals ('Negation Codes') where 'X' axis holds all possible combinations of atom variables and 'Y' axis (Top-Down:) holds all possible negation codes.

INPUT FILE FORMAT: Each and every clause occupies a single row. For every clause only the indices of atom variables are denoted
and any negation operator in front of a variable is given as a minus sign. In case of a GTT computation this is ignored since all possible negations will be tried by the program. Hence, an expression like (X1 \/ X3) /\ ( NOT(X2) \/ X4) /\ (X2 \/ NOT(X3) \/ X5) will be denoted as

1  3

-2 4

2 -3 5

For the example files they should obtain as below (eg, cd SATbox/; addpaths; sat('sat0', 1);). 

SAT0:
<p align="left">
  <img src="./SATimages/SAT0cnf.jpg" width="400"/> <img src="./SATimages/SAT0dnf.jpg" width="400"/>
</p>

SAT1:
<p align="left">
  <img src="./SATimages/SAT1cnf.jpg" width="400"/> <img src="./SATimages/SAT1dnf.jpg" width="400"/>
</p>

SAT2-2: (from https://en.wikipedia.org/wiki/Maximum_satisfiability_problem)
<p align="left">
  <img src="./SATimages/SAT2cnf.jpg" width="400"/> <img src="./SATimages/SAT2dnf.jpg" width="400"/>
</p>

SAT3:
<p align="left">
  <img src="./SATimages/SAT3cnf.jpg" width="400"/> <img src="./SATimages/SAT3dnf.jpg" width="400"/>
</p>
