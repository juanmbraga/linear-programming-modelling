# Packing
**Problem**: We're currently helping out a producer with their production planning. This producer wants us to map out their production for a time horizon spanning $n$ periods. They're dealing with a single product, and they've got a good handle on customer demands for each time period $i$ ($d_i$), the production cost per unit at each time $i$ ($c_i$), and the cost of storing a unit from time $i$ to $i + 1$ ($h_i$). However, because their product is seasonal, there's a chance that some customer orders won't be fulfilled in a given period. In such cases, we can still deliver the product late to the customer, but we'll have to pay a penalty of $p_i$ per unit for any product ordered by the customer but not yet delivered in period $i$.

## Values:
- $n$ $\rarr$ Number of periods
- $d_i$ $\rarr$ Demand at time $i$
- $c_i$ $\rarr$ Production cost per unit at time $i$
- $h_i$ $\rarr$ Storage cost at time $i$ 
- $p_i$ $\rarr$ Penalty for storing production at time $i$

## Variables
- $x_i$ $\rarr$ Production at time $i$
- $y_i$ $\rarr$ How much should be stored from time $i$ to $i+1$
- $z_i$ $\rarr$ Undelivered amount at time $i$
- $w_i$ $\rarr$ Actually sold production at time $i$ ($x_i - y_i$)
- 
### First attempt at modelling

### Logic
- using "day" notation to simplify

#### first
$$
\left(
\begin{array}{c}
\text{yesterday's} \\
\text{leftovers}
\end{array}
\right)
+
\left(
\begin{array}{c}
\text{today's} \\
\text{production}
\end{array}
\right)
+
\left(
\begin{array}{c}
\text{today's} \\
\text{undelivered} \\
\text{amount}
\end{array}
\right)
\geq
\left(
\begin{array}{c}
\text{today's} \\
\text{demand}
\end{array}
\right)
+
\left(
\begin{array}{c}
\text{yesterday's} \\
\text{unmet}\\
\text{demand}
\end{array}
\right)
$$

#### second
$$
\left(
\begin{array}{c}
\text{amount} \\
\text{to be} \\
\text{stored}
\end{array}
\right)
+
\left(
\begin{array}{c}
\text{actually} \\
\text{sold} \\
\text{production}
\end{array}
\right)
=
\left(
\begin{array}{c}
\text{today's} \\
\text{production}
\end{array}
\right)
$$

#### third
$$
\left(
\begin{array}{c}
\text{today's} \\
\text{undelivered} \\
\text{amount}
\end{array}
\right)
\times p_i
+
\left(
\begin{array}{c}
\text{today's} \\
\text{production}
\end{array}
\right)
\times c_i
+
\left(
\begin{array}{c}
\text{amount} \\
\text{to be} \\
\text{stored}
\end{array}
\right)
\times h_i
$$



### Resulting mathematical model

## Second attempt at modelling
### Variables
### Logic
### Resulting mathematical model

months, production_cost, demand, storage_cost, penalty_cost = readData(file)

@variable(model, x[i=1:months] >= 0) # production
@variable(model, y[i=1:months] >= 0) # storage for next month
@variable(model, z[i=1:months] >= 0) # undelivered
@variable(model, w[i=1:months] >= 0) # actually sold production

# first day, no storage
#@constraint(model, x[1] + z[1] >= demand[1])
#@constraint(model, y[1] == 0)
# last day, no storage
#@constraint(model, y[months] == 0)
# general equation for each month
#@constraint(model, [i=2:months], y[i-1] + x[i] + z[i] >= demand[i] + z[i-1])
# defining production as stored + sold
#@constraint(model, [i=1:months], y[i] + w[i] == x[i])

# first day, no storage, last day, no storage
@constraint(model, x[1] == demand[1] + y[1] - z[1])
@constraint(model, y[1] == 0)
@constraint(model, y[months] == 0)
# general equation
@constraint(model, [i=2:months], y[i-1] - z[i-1] + x[i] == demand[i] + y[i] - z[i])

@objective(model, Min, sum(z[i]*penalty_cost[i] + x[i]*production_cost[i] + y[i]*storage_cost[i] for i=1:months))
