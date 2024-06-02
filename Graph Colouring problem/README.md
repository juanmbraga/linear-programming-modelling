# Graph coloring
**Problem**: Given a graph G = (V, E), a proper coloring is an assignment of colors to the vertices of the graph such that adjacent vertices receive different colors. We want to determine the smallest number of colors needed to properly color a given input graph.

## Values
- $n$ Number of objects
- $i$ Index of colour (maximum is the number of objects)
- $j$ Index of object
- $u$ Object from the adjacency list (belongs to $Vertices(Graph)$)
- $v$ Object from the adjacency list (belongs to $Neighbours(Graph)$)

## Modelling
### Logic
It is useful to imagine a matrix where each line $i$ represents a colour, each column $j$ represents a node, and each object in a given line ($x_{ij}$) represents a boolean variable indicating wether a given object has a colour. The matrix is square as the maximum number of colours is the number of objects.

We may then think of the necessary restrictions:
- An object han only have a single colour
- No two neighbouring objects can have the same colour

We must then consider a way of ~~mathematically~~ programmatically determine when objects are neighbours. The most direct approach is to consider the data structure that is to be received: by addressing the adjacency list with indices $u$ and $v$, we can address only the existing connected pairs of the dataset.

Toolset reminders:
- Only one (boolean) element can be true: $x + y \leq 1$
- Maximizing or minimizing the number of choices: Multiply values by a boolean variable for each element,and the sum of all of these boolean variables must be maximized/minimized (represented by the $E_i$ variable in this problem).

### Variables
- $x_{ij}$ $\rarr$ Indicates that colour $i$ paints object $j$
- $E_i$ $\rarr$ Indicates wether the colour $i$ was chosen to be in the result.

### Resulting mathematical model
$\left( \sum_{i=1}^{n}{x_{ij}} \right) = 1$  (Each node has only one colour)

$x_{ui} + x_{vi} \leq 1$ (Each connected object $u$ and $v$ cannot have the same colour $i$)

$x_{ui} + x_{vi} \leq 1 * E_i$ (Auxiliary variable $E_i$ defines choice of wether colour will be used)

$min \sum_{i=1}^{n}{E_i}$