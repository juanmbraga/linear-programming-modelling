using JuMP
using HiGHS

function readData(file)
	size = 0
    lista_adjacencias = [[]]

	for line in eachline(file)
		tokens = split(line, "	")
		if tokens[1] == "n"
			size = parse(Int64, tokens[2])
			lista_adjacencias = [[] for i=1:size]
		elseif tokens[1] == "e"
            v = parse(Int64, tokens[2])
            u = parse(Int64, tokens[3])
            push!(lista_adjacencias[v], u) 
            push!(lista_adjacencias[u], v)
        end
	end
	return  size, lista_adjacencias
end

model = Model(HiGHS.Optimizer)

file = open(ARGS[1], "r")

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

optimize!(model)

sol = objective_value(model)
println("TP1 STUDENT = ", round(sol, digits=1))
