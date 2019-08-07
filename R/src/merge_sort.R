
########################################################################
#                                                                      #
# AUTHOR: Daniel Gaspar Goncalves                                      #
# git: https://github.com/d-gaspar/                                    #
#                                                                      #
########################################################################


merge_sort = function(array){
    n = length(array)
    
    if(n>1){
        n_half = ceiling(n/2)
        
        left = merge_sort(array[1:n_half])

        right = merge_sort(array[(n_half+1):n])
        
        n_left = length(left)
        n_right = length(right)
        
        i = j = 1
        
        aux = c()
        
        while(i<=n_left && j<=n_right){
            if(left[i] < right[j]){
                aux = c(aux, left[i])
                i = i + 1
            } else {
                aux = c(aux, right[j])
                j = j + 1
            }
        }
        
        if(i<=n_left){
            aux = c(aux, left[i:n_left])
        } else {
            aux = c(aux, right[j:n_right])
        }
        
        array = aux
    }
    
    return(array)
}

########################################################################

merge_sort_verbose = function(array, full_array=array, original_n=length(array), pos_aux=0, iter=0, n_swaps=0, output=list()){
    n = length(array)
    
    if(n>1){
        n_half = ceiling(n/2)
        
        # left
        aux = merge_sort_verbose(array[1:n_half], full_array=full_array, pos_aux=pos_aux, iter=iter, n_swaps=n_swaps, output=output)
        iter = aux$iter
        n_swaps = aux$n_swaps
        left = aux$array
        output = aux$output
        full_array[1:n_half + pos_aux] = aux$array
        
        
        # right
        aux = merge_sort_verbose(array[(n_half+1):n], full_array=full_array, pos_aux=pos_aux+n_half, iter=iter, n_swaps=n_swaps, output=output)
        iter = aux$iter
        n_swaps = aux$n_swaps
        right = aux$array
        output = aux$output
        full_array[(n_half+1):n + pos_aux] = aux$array
        
        n_left = length(left)
        n_right = length(right)
        
        i = j = 1
        
        aux = c()
        
        while(i<=n_left && j<=n_right){
            iter = iter + 1
            
            output[[iter]] = list(
                array = full_array,
                comparison = c(pos_aux+i, n_half+pos_aux+j)
            )
            
            if(left[i] < right[j]){
                aux = c(aux, left[i])
                i = i + 1
            } else {
                n_swaps = n_swaps + 1
                
                aux = c(aux, right[j])
                
                j = j + 1
            }
            
            output[[iter]]$n_swaps = n_swaps
        }
        
        if(i<=n_left){
            aux = c(aux, left[i:n_left])
        } else {
            aux = c(aux, right[j:n_right])
        }
        
        array = aux
    }
    
    return(list(
        array = array,
        iter = iter,
        n_swaps = n_swaps,
        output = output
    ))
}
