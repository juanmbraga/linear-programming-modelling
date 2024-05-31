#import Pkg; Pkg.add("HiGHS")
#import Pkg; Pkg.add("JuMP")
using JuMP
using HiGHS

function readData(file)
	months = 0
    production_cost = []
    demand = []
    storage_cost = []
    penalty_cost = []
	for line in eachline(file)
		tokens = split(line, "	")
		number = parse(Int64, tokens[2])
		if tokens[1] == "n"
			months = number
			production_cost = zeros(months)
            demand = zeros(months)
            storage_cost = zeros(months)
            penalty_cost = zeros(months)
		elseif tokens[1] == "c"
            production_cost[number] = parse(Float64, tokens[3])
        elseif tokens[1] == "d"
            demand[number] = parse(Float64, tokens[3])
        elseif tokens[1] == "s"
            storage_cost[number] = parse(Float64, tokens[3])
        elseif tokens[1] == "p"
            penalty_cost[number] = parse(Float64, tokens[3])
        end
	end
	return  months, production_cost, demand, storage_cost, penalty_cost
end

model = Model(HiGHS.Optimizer)

file = open(ARGS[1], "r")

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

optimize!(model)

sol = objective_value(model)
println("TP1 STUDENT = ", round(sol, digits=1))
