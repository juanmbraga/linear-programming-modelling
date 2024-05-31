
using JuMP
using HiGHS

function formataEntrada(nome_arquivo)
	arquivo = open(nome_arquivo, "r")
	size = 0
	adjacency_list = zeros(Int64, 0, 0)

	for l in eachline(arquivo)
		tokens = split(l, "\t")
		if tokens[1] == "n"
			size = parse(Int64, tokens[2])
			adjacency_list = zeros(Int64, size, size)
		elseif tokens[1] == "e"
			v = parse(Int64, tokens[2])
			u = parse(Int64, tokens[3])
			adjacency_list[v, u] = 1
		end
	end
	return size, adjacency_list
end

modelo = Model(HiGHS.Optimizer)

size, adjacency_list = formataEntrada(ARGS[1])

@variable(modelo, x[1:size], Bin)

# both edge i and its neighbor j can't be on clique
for i in 1:size
    for j in i+1:size
        @constraint(modelo, x[i] + x[j] <= adjacency_list[i,j] + 1)
    end
end

@objective(modelo, Max, sum(x))

optimize!(modelo)

println("TP1 STUDENT = ", objective_value(modelo))
