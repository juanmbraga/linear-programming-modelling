# Packing
**Problem**: We're currently helping out a producer with their production planning. This producer wants us to map out their production for a time horizon spanning $n$ periods. They're dealing with a single product, and they've got a good handle on customer demands for each time period $i$ ($d_i$), the production cost per unit at each time $i$ ($c_i$), and the cost of storing a unit from time $i$ to $i + 1$ ($h_i$). However, because their product is seasonal, there's a chance that some customer orders won't be fulfilled in a given period. In such cases, we can still deliver the product late to the customer, but we'll have to pay a penalty of $p_i$ per unit for any product ordered by the customer but not yet delivered in period $i$.

Source: Assignment 1 from 2024.1, DCC035 Pesquisa Operacional, UFMG.

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

### First attempt at modelling

### Logic
Using "day" to represent periods make the notation easier.

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


$$
\left(
\begin{array}{c}
\text{today's} \\
\text{undelivered} \\
\text{amount}
\end{array}
\right)
\times penalty_i
+
\left(
\begin{array}{c}
\text{today's} \\
\text{production}
\end{array}
\right)
\times cost_i
+
\left(
\begin{array}{c}
\text{amount} \\
\text{to be} \\
\text{stored}
\end{array}
\right)
\times storage\_price_i
$$


### Resulting mathematical model
Equation one : $y_{i-1} + x_i + z_i \geq d_i + z_{i-1}$ $(\forall i \in \{periods\})$

Equation two: $y_i + w_i = x_i$ $(\forall i \in \{periods\})$

Equation three: $min\sum_{i=1}^{n}{{z_i \cdot p_i} + {x_i \cdot c_i} + {y_i \cdot h_i}}$ $(\forall i \in \{periods\})$

No storage in the first day from before: $y_0 = 0$

No storage remaining in the last day: $y_n = 0$

$w_i \geq 0$, $z_i \geq 0$, $x_i \geq 0$, $y_i \geq 0$ $(\forall i \in \{periods\})$

$\text{periods} = \{1,2,3,...,n\}$


## Second attempt at modelling
### Logic
First day:
$$
\left(
\begin{array}{c}
\text{today's} \\
\text{production}
\end{array}
\right)
=
\left(
\begin{array}{c}
\text{today's} \\
\text{demand}
\end{array}
\right)
+
\left(
\begin{array}{c}
\text{amount} \\
\text{to be} \\
\text{stored}
\end{array}
\right)
-
\left(
\begin{array}{c}
\text{today's} \\
\text{undelivered} \\
\text{amount}
\end{array}
\right)
$$

Second day:
$$
\left(
\begin{array}{c}
\text{yesterday's} \\
\text{leftovers}
\end{array}
\right)
-
\left(
\begin{array}{c}
\text{yesterday's} \\
\text{unmet}\\
\text{demand}
\end{array}
\right)
+
\left(
\begin{array}{c}
\text{today's} \\
\text{production}
\end{array}
\right)
=
\left(
\begin{array}{c}
\text{today's} \\
\text{demand}
\end{array}
\right)
+
\left(
\begin{array}{c}
\text{amount} \\
\text{to be} \\
\text{stored}
\end{array}
\right)
-
\left(
\begin{array}{c}
\text{today's} \\
\text{undelivered} \\
\text{amount}
\end{array}
\right)
$$

Target function:
$$
\left(
\begin{array}{c}
\text{today's} \\
\text{undelivered} \\
\text{amount}
\end{array}
\right)
\times penalty_i
+
\left(
\begin{array}{c}
\text{today's} \\
\text{production}
\end{array}
\right)
\times cost_i
+
\left(
\begin{array}{c}
\text{amount} \\
\text{to be} \\
\text{stored}
\end{array}
\right)
\times storage\_price_i
$$

### Resulting mathematical model
Day one: $x_1 = d_1 + y_1 - z_1$

Equation two: $y_{i-1} - z_{i-1} + x_i = d_i + y_i - z_i$ $(\forall i \in \{2, 3, ..., n\})$

Target equation: $min\sum_{i=1}^{n}{{z_i \cdot p_i} + {x_i \cdot c_i} + {y_i \cdot h_i}}$ $(\forall i \in \{periods\})$

No storage in the first day ($i$) from before ($i-1$): $y_0 = 0$

No storage remaining in the last day: $y_n = 0$

$w_i \geq 0$, $z_i \geq 0$, $x_i \geq 0$, $y_i \geq 0$ $(\forall i \in \{periods\})$

$\text{periods} = \{1,2,3,...,n\}$