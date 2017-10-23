source("Estado.R")

## Classe e métodos para o problema do Jogo dos Blocos
Blocos <- function(desc = NULL, pai = NULL){
  
  e <- environment()
  
  assign("desc", desc, envir = e)
  assign("pai", pai, envir = e)
  assign("g", 0, envir = e)
  assign("h", Inf, envir = e)
  assign("f", Inf, envir = e)
  
  class(e) <- c("Blocos", "Estado")
  
  return(e)
}

## Sobrecarregando o operador "==" para comparação entre estados
Ops.Blocos = function(obj1,obj2){
  if(.Generic == "=="){
    return(all(obj1$desc[obj1$desc!='E'] == obj2$desc[obj2$desc!='E']))

  }
}

## Sobrecarga da função genérica "print" do R
print.Blocos <- function(obj) {
  cat("Vetor: (", obj$desc, ")\n")
  cat("G(n): ", obj$g, "\n")
  cat("H(n): ", obj$h, "\n")
  cat("F(n): ", obj$f, "\n")
}

## Sobrecarga da função genérica "heuristica", definida por Estado.R
heuristica.Blocos <- function(atual){
   lista <- atual$desc
   h1 <- sum(order(lista[lista!='E'])[4:6]) - sum(order(lista[lista!='E'])[1:3]) + 9
   if (!is.null(atual$pai)) {
     h1 <- h1 + (atual$g - atual$pai$g)
   } else {
     h1 <- h1 + atual$g
   }
   return (h1)
   
}

swap <- function(arr, y, v) {
  aux = arr[y]
  arr[y] = arr[v]
  arr[v] = aux
  return (arr)
}

geraFilhos.Blocos <- function(obj) {
  
  filhos <- list()
  pos <- which(obj$desc == 'E')
  
  for(p in 1:3){
    if(pos + p <= 7){
      filho <- Blocos(desc = swap(obj$desc, pos, pos+p))
      filho$pai = obj
      filho$g <- obj$g + p
      filho$h <- heuristica(filho)
      filhos <- c(filhos, filho)
    }
  }
  
  for(p in -3:-1){
    if(pos + p >= 1) {
      filho <- Blocos(desc = swap(obj$desc, pos, pos+p))
      filho$pai = obj
      filho$g <- obj$g + abs(p)
      filho$h <- heuristica(filho)
      filhos <- c(filhos, filho)
    }
  }
  
  
  return(filhos)
}