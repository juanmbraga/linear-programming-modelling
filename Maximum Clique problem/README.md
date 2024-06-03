# Maximal Clique
**Problem**: Given a graph G = (V, E), a clique is a set of vertices that are pairwise adjacent, meaning there are edges between all of them (a totally connected subgraph). We want to find an induced subgraph that forms a clique of maximum cardinality (largest size in terms of the number of vertices).

## Values
- $n$ $\rarr$ Number of nodes
- $i$ and $j$ $\rarr$ nodes from the adjacency list
- $Z_{ij}$ $\rarr$ indicates wether $i$ and $j$ are neighbours

## Modelling
### Logic
This is a tricky one, even if the solution is short.

When it comes to cliques, the only restriction to be considered is that every node in it must have a connection to all of it's other nodes. 

Because of that, **whenever we get any two given nodes, if they don't have an edge connecting them, then they cannot both be in the solution at the same time**.

Therefore we must make a model that will only be false when 1. two of them are not connected and 2. they are both included in the solution:

---

First we consider an array of boolean elements, where $x_i$ will indicate wether node $i$ belongs to the largest clique. The objective function will be to maximize the sum of these elements, getting a clique with the most nodes in it.

Second, we build a boolean matrix to indicate wether a pair of nodes have a connection or not. Let's just call it `adjacency_matrix`.

Then we add the restriction described above to all pairs of vertices. Check out the code below:

```julia
# both edge i and its neighbor j can't be on clique if they are not connected
for (every i and j in Graph)
    @constraint(model, x[i] + x[j] <= adjacency_matrix[i,j] + 1)
end
```

"Toolset" reminders:
- At least one (boolean) element from the left size of the equation will be true: $x + y \leq 1$

### Variables

### Resulting mathematical model
$max \sum_{i=1,j=1}^{n}{x_{ij}}$

Such that:

$x_i + x_j \leq Z_{ij} + 1$ $(\forall i,j \in \{range\})$

$\text{range} = \{1,2,3,...,n\}$