# SATbox
Toolbox for exploring fractality in satisfiability (SAT) problems

Under Construction: Guidelines to appear in a forthcoming publication.

The core eval function uses a purely functional approach with a universal indicator function over any interval.

The hierarchical classification used here is described in the below table

| Expression Type| Clauses       | Overlaps      |Satisfiability |
| -------------  | ------------- | ------------- | ------------- |
| SAT0           | Equal         | No            | Complete      |
| SAT1           | Unequal       | No            | Complete      |
| SAT2           | Equal         | Yes           | Partial       |        
| SAT3           | Unequal       | Yes           | Partial       |

When the total clause length and the overlap arithmetized codes are taken over an inclusive hierarchy of exponential intervals
complete enumeration of all such expressions over each level becomes possible with the aid of 
<a href="http://mathworld.wolfram.com/PartitionFunctionP.html">Integer Partition</a> and Restricted 2-Integer Partition functions.

Global Truth Tables are defined as symmetric matrices for all possible assignments of atoms to literals ('Negation Codes')

For the example files they should obtain as below

SAT0:
<p align="left">
  <img src="./SATimages/SAT0cnf.jpg" width="400"/> <img src="./SATimages/SAT0dnf.jpg" width="400"/>
</p>

SAT1:
<p align="left">
  <img src="./SATimages/SAT1cnf.jpg" width="400"/> <img src="./SATimages/SAT1dnf.jpg" width="400"/>
</p>

SAT2:
<p align="left">
  <img src="./SATimages/SAT2cnf.jpg" width="400"/> <img src="./SATimages/SAT2dnf.jpg" width="400"/>
</p>

SAT1:
<p align="left">
  <img src="./SATimages/SAT3cnf.jpg" width="400"/> <img src="./SATimages/SAT3dnf.jpg" width="400"/>
</p>
