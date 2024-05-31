# Packing
## Problem
Consider a set of objects $O = {o_1, o_2, ..., o_n}$, where each object has a weight $w_i$. We have several cardboard boxes, each with a weight limit of 20kg. We want to pack our objects using the fewest number of boxes possible, ensuring that the sum of the weights of the objects in any box does not exceed its weight limit.

## Values:
- $n$ $\rarr$ Number of objects
- $i$ $\rarr$ Current box
- $j$ $\rarr$ Current object
- $w_j$ $\rarr$ Weight of object $i$
- $c_i$ $\rarr$ Capacity of each box, always 20kg in this problem

## Modelling
### Variables:
- $x_{ij}$ $\rarr$ Indicates wether box $i$ contains object $j$
- $z_i$ $\rarr$ Indicates wether box $i$ is being utilized

### Logic
It is useful to imagine a matrix where each line $i$ represents a box, each column $j$ represents an object, and each object in a given line ($x_{ij}$) represents a boolean variable indicating wether that object (column) is stored in the current box (line).

All restrictions can then be derived from that:
- An object can either be or not be contained in a box
- An object can only be in one box
- The maximum wheight all objects in a box can sum up to is 20kg

### Resulting mathematical model
$\text{objects} = \{1,2,...,n\}$

If object $j$ is in box $i$ : $w_j \in \{0,1\}$

Object $j$ can only be in one box : $\sum_{j=1}^{n}{x_{ij} = 1}$ such that $\forall i \in objects$

Max. weight of box $i$ is 20kg : $\sum_{j=1}^{n}{x_{ij} * w_j \leq 20}$ such that $\forall i \in \text{objects}$

Adding trick to choose wether box $i$ is used : $\sum_{j=1}^{n}{x_{ij} * w_j \leq 20 * z_i}$ such that $\forall i \in \text{objects}$

$z_i \in \{0,1\}$

$min \sum_{i=1}^{n}{z_i}$