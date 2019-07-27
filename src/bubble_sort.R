
########################################################################
#                                                                      #
# AUTHOR: Daniel Gaspar Goncalves                                      #
# git: https://github.com/d-gaspar/                                    #
#                                                                      #
########################################################################

bubble_sort = function(array){
    n = length(array)
    
    for(i in 1:(n-1)){
        for(j in 1:(n-i)){
            if(array[j] > array[j+1]){
                aux = array[j]
                array[j] = array[j+1]
                array[j+1] = aux
            }
        } 
    }
    
    return(array)
}

########################################################################

bubble_sort_verbose = function(array){
    iter = 0
    n_swaps = 0
    sorted_values = c()
    output = list()
    n = length(array)
    
    for(i in 1:(n-1)){
        for(j in 1:(n-i)){
            iter = iter + 1
            
            if(array[j] > array[j+1]){
                n_swaps = n_swaps + 1
                
                aux = array[j]
                array[j] = array[j+1]
                array[j+1] = aux
            }
            
            output[[iter]] = list(
                array=array,
                comparison = c(j, j+1),
                sorted = sorted_values,
                n_swaps = n_swaps
            )
        }
        sorted_values = c(j+1, sorted_values)
    }
    
    return(output)
}
