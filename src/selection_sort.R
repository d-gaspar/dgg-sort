
########################################################################
#                                                                      #
# AUTHOR: Daniel Gaspar Goncalves                                      #
# git: https://github.com/d-gaspar/                                    #
#                                                                      #
########################################################################

selection_sort = function(array){
    n = length(array)
    
    for(i in 1:(n-1)){
        
        min = i
        
        for(j in (i+1):n){
            if(array[j] < array[min]){
                min = j
            }
        } 
        
        if(min != i){
            aux = array[min]
            array[min] = array[i]
            array[i] = aux
        }
    }
    
    return(array)
}

########################################################################

selection_sort_verbose = function(array){
    iter = 0
    n_swaps = 0
    sorted_values = c()
    output = list()
    n = length(array)
    
    for(i in 1:(n-1)){
        
        min = i
        
        for(j in (i+1):n){
            iter = iter + 1
            
            output[[iter]] = list(
                array=array,
                comparison = c(min, j),
                sorted = sorted_values,
                n_swaps = n_swaps
            )
            
            if(array[j] < array[min]){
                min = j
            }
        }
        
        if(min != i){
            aux = array[min]
            array[min] = array[i]
            array[i] = aux
            
            n_swaps = n_swaps + 1
        }
        
        sorted_values = c(sorted_values, i)
    }
    
    return(output)
}
