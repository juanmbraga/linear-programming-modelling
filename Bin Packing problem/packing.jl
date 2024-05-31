#import Pkg; Pkg.add("HiGHS")
#import Pkg; Pkg.add("JuMP")
using JuMP
using HiGHS

function readData(file)
	number = 0
	weight = []
	capacity = 20
	for line in eachline(file)
		tokens = split(line, "	")
		num = parse(Int64, tokens[2])
		if tokens[1] == "n"
			number = num
			weight = [0.0 for i=1:number]
		elseif tokens[1] == "o"
            weight[num+1] = parse(Float64, tokens[3])
        end
	end
	return  number, weight, capacity
end

model = Model(HiGHS.Optimizer)

file = open(ARGS[1], "r")

number, weight, capacity = readData(file)

@variable(model, x[i=1:number, j=1:number], Bin)
@variable(model, z[i=1:number], Bin)

@constraint(model,[i=1:number], sum(weight[j]*x[i,j] for j=1:number) <= capacity*z[i])
@constraint(model,[j=1:number], sum(x[i,j] for i=1:number) == 1)

@objective(model, Min, sum(z))

optimize!(model)

sol = objective_value(model)
println("TP1 STUDENT = ", round(sol, digits=1))
