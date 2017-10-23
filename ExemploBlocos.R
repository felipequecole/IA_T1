debugSource("Blocos.R")
debugSource("buscaDesinformada.R")
debugSource("buscaInformada.R")

inicial <- Blocos(desc = c('B','B','B','W','W','W','E'))

objetivo <- Blocos()
objetivo$desc <- c('W','W','W','B','B','B')

cat("====\tBusca em Largura\t====\n")
print(unlist(buscaEmLargura(inicial, objetivo)))

cat("====\tBusca em Profundidade\t=====\n")
print(unlist(buscaEmProfundidade(inicial, objetivo)))

cat("====\tBusca de Custo Uniforme\t=====\n")
print(unlist(buscaCustoUniforme(inicial, objetivo)))

cat("====\tBusca Best-First (Gulosa)\t=====\n")
print(unlist(buscaBestFirst(inicial, objetivo, "Gulosa")))

cat("====\tBusca Best-First (A*)\t=====\n")
print(unlist(buscaBestFirst(inicial, objetivo, "AEstrela")))

