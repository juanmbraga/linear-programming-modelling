# Maximal Clique
**Problem**: Given a graph G = (V, E), a clique is a set of vertices that are pairwise adjacent, meaning there are no edges between them. We want to find an induced subgraph that forms a clique of maximum cardinality (largest size in terms of the number of vertices).

## Values

## Modelling
### Variables

### Logic

### Resulting mathematical model



size, adjacency_list = formataEntrada(ARGS[1])

@variable(modelo, x[1:size], Bin)

# both edge i and its neighbor j can't be on clique
for i in 1:size
    for j in i+1:size
        @constraint(modelo, x[i] + x[j] <= adjacency_list[i,j] + 1)
    end
end

@objective(modelo, Max, sum(x))