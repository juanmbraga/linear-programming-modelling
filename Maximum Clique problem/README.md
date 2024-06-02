# Maximal Clique
**Problem**: Given a graph G = (V, E), a clique is a set of vertices that are pairwise adjacent, meaning there are no edges between them. We want to find an induced subgraph that forms a clique of maximum cardinality (largest size in terms of the number of vertices).

## Values
- $n$ $\rarr$ Number of nodes
- $i$ and $j$ $\rarr$ nodes from the adjacency list
- $Z_{ij}$ $\rarr$ indicates wether $i$ and $j$ are neighbours

## Modelling
### Logic
This is a simple but tricky one. First we can 

```julia
# both edge i and its neighbor j can't be on clique
for i in 1:size
    for j in i+1:size
        @constraint(modelo, x[i] + x[j] <= adjacency_list[i,j] + 1)
    end
end
```

"Toolset" reminders:
- At least one (boolean) element will be true: $x + y \leq z + 1$

### Variables

### Resulting mathematical model
$x_i + x_j \leq Z_{ij} + 1$

$max \sum_{i=1,j=1}^{n}{x_{ij}}$


