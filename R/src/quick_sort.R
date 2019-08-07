
########################################################################
#                                                                      #
# AUTHOR: Daniel Gaspar Goncalves                                      #
# git: https://github.com/d-gaspar/                                    #
#                                                                      #
########################################################################

quick_sort = function(array){
    
    n = length(array)
    
    if(n > 1){
        pivo = sample(1:n, 1)
        
        left = c()
        right = c()
        
        # left
        for(i in 1:n){
            if(i != pivo){
                if(array[i] < array[pivo]){
                    left = c(left, array[i])
                }
                
            }
        }
        
        # mid
        mid = array[pivo]
        
        # right
        for(i in 1:n){
            if(i != pivo){
                if(array[i] > array[pivo]){
                    right = c(right, array[i])
                }
                
            }
        }
        
        left = quick_sort(left)
        right = quick_sort(right)
        
        array = c(left, mid, right)
    }
    
    
    
    return(array)
}

########################################################################

quick_sort_verbose = function(array, full_array=array, pos_aux=0, iter=0, n_swaps=0, output=list()){
    
    n = length(array)
    
    if(n > 1){
        # pivo = sample(1:n, 1)
        pivo = ceiling(n/2)
        
        left = c()
        right = c()
        
        # split
        n_swaps_aux = n_swaps
        for(i in 1:n){
            if(i != pivo){
                
                iter = iter + 1
                
                output[[iter]] = list(
                    array = full_array,
                    comparison = c(pos_aux+pivo, pos_aux+i),
                    n_swaps = n_swaps
                )
                
                # left
                if(array[i] <= array[pivo]){
                    
                    if(i > pivo){
                        n_swaps_aux = n_swaps_aux + 1
                    }
                    
                    left = c(left, array[i])
                    
                # right
                } else if(array[i] > array[pivo]){
                    
                    if(i < pivo){
                        n_swaps_aux = n_swaps_aux + 1
                    }
                    
                    iter = iter + 1
                    
                    output[[iter]] = list(
                        array = full_array,
                        comparison = c(pos_aux+pivo, pos_aux+i),
                        n_swaps = n_swaps
                    )
                    
                    right = c(right, array[i])
                    
                    
                }
            }
        }
        
        # mid
        mid = array[pivo]
        
        n_swaps = n_swaps_aux
        full_array[1:n + pos_aux] = c(left, mid, right)
        
        # left
        if(length(left) > 0){
            aux = quick_sort_verbose(left, full_array=full_array, pos_aux=pos_aux, iter=iter, n_swaps=n_swaps, output=output)
            iter = aux$iter
            n_swaps = aux$n_swaps
            left = aux$array
            
            output = aux$output
            full_array[1:length(left) + pos_aux] = left
        }
        
        # right
        if(length(right) > 0){
            aux = quick_sort_verbose(right, full_array=full_array, pos_aux=pos_aux+length(left)+1, iter=iter, n_swaps=n_swaps, output=output)
            iter = aux$iter
            n_swaps = aux$n_swaps
            right = aux$array
            output = aux$output
        }
        
        array = c(left, mid, right)
    }
    
    return(list(
        array = array,
        iter = iter,
        n_swaps = n_swaps,
        output = output
    ))
}#;z=quick_sort_verbose(array_1)
