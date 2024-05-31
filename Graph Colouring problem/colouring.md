# Graph coloring
**Problem**: Given a graph G = (V, E), a proper coloring is an assignment of colors to the vertices of the graph such that adjacent vertices receive different colors. We want to determine the smallest number of colors needed to properly color a given input graph.

## Values

## Modelling
### Variables

### Logic

### Resulting mathematical model


size, lista_adjacencias = readData(file)

# matrix for node 'j' has color 'i'
@variable(model, x[i=1:size, j=1:size], Bin)

# vector to tell whether a color has been used
@variable(model, z[i=1:size], Bin)

# each node has only one color
for j in 1:size
    @constraint(model, sum(x[i,j] for i=1:size) == 1)
end

# each color is used only once
for u in 1:size, v in lista_adjacencias[u], i in 1:size
    @constraint(model, x[i,u] + x[i,v] <= z[i])
end

@objective(model, Min, sum(z))