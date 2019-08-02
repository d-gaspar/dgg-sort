
########################################################################
#                                                                      #
# AUTHOR: Daniel Gaspar Goncalves                                      #
# git: https://github.com/d-gaspar/                                    #
#                                                                      #
########################################################################

# library(gtools)

########################################################################

dgg_sort = function(array){
    
    n = length(array)
    
    # even number of elements
    if(n %% 2 == 0){
        
        # 2 elements
        if(n==2){
            
            if(array[1] > array[2]){
                return(c(array[2], array[1]))
            }
            
            return(array)
        }
        
        # rainbow 1
        for(i in 1:(n/2)){
            
            if(array[i] > array[n-i+1]){
                array[c(i, n-i+1)] = array[c(n-i+1, i)]
            }
        }
        
        left = dgg_sort(array[1:(n/2)])
        right = dgg_sort(array[(n/2+1):n])
        
        array = c(left, right)
        
        # rainbow 2
        for(i in 0:(n/4-1)){

            if(array[(n/2-i)] > array[(n/2+1+i)]){
                array[c((n/2-i), (n/2+1+i))] = array[c((n/2+1+i), (n/2-i))]
            }
        }
        
        # order right and left
        if(n > 4){
            
            if(n > 6){
                # left
                array[3:(n/2)] = dgg_sort(array[3:(n/2)])
                
                # right
                array[(n/2+1):(n-2)] = dgg_sort(array[(n/2+1):(n-2)])
            }
            
            # left
            if(array[2] > array[3]){
                array[c(2,3)] = array[c(3,2)]
            }
            
            # right
            if(array[n-2] > array[n-1]){
                array[c(n-2, n-1)] = array[c(n-1, n-2)]
            }
        }
        
    ####################################################################
        
    # odd number of elements
    } else {
        
        # 3 elements
        if(n==3){
            
            if(array[1] < array[2]){
                
                if(array[2] < array[3]){
                    # sorted
                    return(array)
                } else {
                    array[c(2,3)] = array[c(3,2)]
                    
                    if(array[1] > array[2]){
                        array[c(1,2)] = array[c(2,1)]
                    }
                    return(array)
                }
            } else {
                array[c(1,2)] = array[c(2,1)]
                
                if(array[2] < array[3]){
                    return(array)
                } else {
                    array[c(2,3)] = array[c(3,2)]
                    
                    if(array[1] > array[2]){
                        array[c(1,2)] = array[c(2,1)]
                    }
                    
                    return(array)
                }
            }
        }
        
        # order all elements except by the median
        array[c(1:((n-1)/2), ((n-1)/2+2):n)] = dgg_sort(array[c(1:((n-1)/2), ((n-1)/2+2):n)])
        
        i = (n+1)/2

        # Bubble left
        if(array[i-1] > array[i]){
            # swap
            array[c(i-1, i)] = array[c(i, i-1)]

            i = i - 1

            while(i > 1 && array[i-1] > array[i]){

                array[c(i-1, i)] = array[c(i, i-1)]

                i = i - 1
            }
        
        # Bubble right
        } else if(array[i] > array[i+1]){

            # swap
            array[c(i, i+1)] = array[c(i+1, i)]

            i = i + 1

            while(i < n && array[i] > array[i+1]){

                array[c(i, i+1)] = array[c(i+1, i)]

                i = i + 1
            }
        }
    }
    
    return(array)
}

########################################################################

dgg_sort_verbose = function(array, full_array=array, original_n=length(array), pos_aux=0, pos_aux_odd=0, iter=0, n_swaps=0, output=list()){
    
    n = length(array)
    
    # even number of elements
    if(n %% 2 == 0){
        
        # 2 elements
        if(n==2){
            
            iter = iter + 1
            
            if(array[1] > array[2]){
                array[c(1,2)] = array[c(2,1)]
                
                n_swaps = n_swaps + 1
            }
            
            output[[iter]] = list(
                array = full_array,
                comparison = c(1, 2) + pos_aux,
                n_swaps = n_swaps
            )
            
            return(list(
                array = array,
                iter = iter,
                n_swaps = n_swaps,
                output = output
            ))
        }
        
        # rainbow 1
        for(i in 1:(n/2)){
            
            if(array[i] > array[n-i+1]){
                array[c(i, n-i+1)] = array[c(n-i+1, i)]
                
                n_swaps = n_swaps + 1
                full_array[c(i, n-i+1+pos_aux_odd) + pos_aux] = array[c(i, n-i+1)]
            }
            
            iter = iter + 1
            
            output[[iter]] = list(
                array = full_array,
                comparison = c(i, n-i+1+pos_aux_odd) + pos_aux,
                n_swaps = n_swaps
            )
        }
        
        # left
        aux = dgg_sort_verbose(array[1:(n/2)], full_array=full_array, pos_aux=0+pos_aux, iter=iter, n_swaps=n_swaps, output=output)
        iter = aux$iter
        n_swaps = aux$n_swaps
        left = aux$array
        output = aux$output
        full_array[1:(n/2) + pos_aux] = aux$array
        
        # right
        aux = dgg_sort_verbose(array[(n/2+1):n], full_array=full_array, pos_aux=(n/2)+pos_aux+pos_aux_odd, iter=iter, n_swaps=n_swaps, output=output)
        iter = aux$iter
        n_swaps = aux$n_swaps
        right = aux$array
        output = aux$output
        full_array[(n/2+1):n + pos_aux + pos_aux_odd] = aux$array
        
        array = c(left, right)

        # rainbow 2
        for(i in 0:(n/4-1)){
            
            if(array[(n/2-i)] > array[(n/2+1+i)]){
                array[c((n/2-i), (n/2+1+i))] = array[c((n/2+1+i), (n/2-i))]
                
                n_swaps = n_swaps + 1
                full_array[c((n/2-i), (n/2+1+i+pos_aux_odd)) + pos_aux] = array[c((n/2-i), (n/2+1+i))]
            }
            
            iter = iter + 1
            
            output[[iter]] = list(
                array = full_array,
                comparison = c((n/2-i), (n/2+1+i+pos_aux_odd)) + pos_aux,
                n_swaps = n_swaps
            )
        }

        # order right and left
        if(n > 4){

            if(n > 6){
                # left
                aux = dgg_sort_verbose(array[3:(n/2)], full_array=full_array, pos_aux=2+pos_aux, iter=iter, n_swaps=n_swaps, output=output)
                iter = aux$iter
                n_swaps = aux$n_swaps
                array[3:(n/2)] = aux$array
                output = aux$output
                full_array[3:(n/2) + pos_aux] = aux$array

                # right
                aux = dgg_sort_verbose(array[(n/2+1):(n-2)], full_array=full_array, pos_aux=n/2+pos_aux, iter=iter, n_swaps=n_swaps, output=output)
                iter = aux$iter
                n_swaps = aux$n_swaps
                array[(n/2+1):(n-2)] = aux$array
                output = aux$output
                full_array[(n/2+1):(n-2) + pos_aux] = aux$array
            }

            # left
            iter = iter + 1
            if(array[2] > array[3]){
                array[c(2,3)] = array[c(3,2)]
                
                n_swaps = n_swaps + 1
                full_array[c(2,3) + pos_aux] = array[c(2,3)]
            }
            output[[iter]] = list(
                array = full_array,
                comparison = c(2,3) + pos_aux,
                n_swaps = n_swaps
            )

            # right
            iter = iter + 1
            if(array[n-2] > array[n-1]){
                array[c(n-2, n-1)] = array[c(n-1, n-2)]
                
                n_swaps = n_swaps + 1
                full_array[c(n-2, n-1) + pos_aux + pos_aux_odd] = array[c(n-2, n-1)]
            }
            output[[iter]] = list(
                array = full_array,
                comparison = c(n-2, n-1) + pos_aux + pos_aux_odd,
                n_swaps = n_swaps
            )
        }

        ####################################################################

        # odd number of elements
    } else {

        # 3 elements
        if(n==3){
            
            iter = iter + 1

            if(array[1] < array[2]){
                
                output[[iter]] = list(
                    array = full_array,
                    comparison = c(1,2) + pos_aux,
                    n_swaps = n_swaps
                )
                
                iter = iter + 1

                if(array[2] < array[3]){
                    # sorted
                    
                    output[[iter]] = list(
                        array = full_array,
                        comparison = c(2,3) + pos_aux,
                        n_swaps = n_swaps
                    )
                    
                    return(list(
                        array = array,
                        iter = iter,
                        n_swaps = n_swaps,
                        output = output
                    ))
                } else {
                    array[c(2,3)] = array[c(3,2)]
                    
                    n_swaps = n_swaps + 1
                    full_array[c(2,3) + pos_aux] = array[c(2,3)]
                    
                    output[[iter]] = list(
                        array = full_array,
                        comparison = c(2,3) + pos_aux,
                        n_swaps = n_swaps
                    )
                    
                    iter = iter + 1

                    if(array[1] > array[2]){
                        array[c(1,2)] = array[c(2,1)]
                        
                        n_swaps = n_swaps + 1
                        full_array[c(1,2) + pos_aux] = array[c(1,2)]
                    }
                    
                    output[[iter]] = list(
                        array = full_array,
                        comparison = c(1,2) + pos_aux,
                        n_swaps = n_swaps
                    )
                    
                    return(list(
                        array = array,
                        iter = iter,
                        n_swaps = n_swaps,
                        output = output
                    ))
                }
            } else {
                array[c(1,2)] = array[c(2,1)]
                
                n_swaps = n_swaps + 1
                full_array[c(1,2) + pos_aux] = array[c(1,2)]
                
                output[[iter]] = list(
                    array = full_array,
                    comparison = c(1,2) + pos_aux,
                    n_swaps = n_swaps
                )
                
                iter = iter + 1

                if(array[2] < array[3]){
                    
                    output[[iter]] = list(
                        array = full_array,
                        comparison = c(2,3) + pos_aux,
                        n_swaps = n_swaps
                    )
                    
                    return(list(
                        array = array,
                        iter = iter,
                        n_swaps = n_swaps,
                        output = output
                    ))
                } else {
                    array[c(2,3)] = array[c(3,2)]
                    
                    n_swaps = n_swaps + 1
                    full_array[c(2,3) + pos_aux] = array[c(2,3)]
                    
                    output[[iter]] = list(
                        array = full_array,
                        comparison = c(2,3) + pos_aux,
                        n_swaps = n_swaps
                    )
                    
                    iter = iter + 1

                    if(array[1] > array[2]){
                        array[c(1,2)] = array[c(2,1)]
                        
                        n_swaps = n_swaps + 1
                        full_array[c(1,2) + pos_aux] = array[c(1,2)]
                    }
                    
                    output[[iter]] = list(
                        array = full_array,
                        comparison = c(1,2) + pos_aux,
                        n_swaps = n_swaps
                    )

                    return(list(
                        array = array,
                        iter = iter,
                        n_swaps = n_swaps,
                        output = output
                    ))
                }
            }
        }

        # order all elements except by the median
        aux = dgg_sort_verbose(array[c(1:((n-1)/2), ((n-1)/2+2):n)], full_array=full_array, pos_aux=0+pos_aux, pos_aux_odd=1, iter=iter, n_swaps=n_swaps, output=output)
        iter = aux$iter
        n_swaps = aux$n_swaps
        array[c(1:((n-1)/2), ((n-1)/2+2):n)] = aux$array
        output = aux$output
        full_array[c(1:((n-1)/2), ((n-1)/2+2):n) + pos_aux] = aux$array

        i = (n+1)/2

        # Bubble left
        if(array[i-1] > array[i]){
            iter = iter + 1
            
            # swap
            array[c(i-1, i)] = array[c(i, i-1)]
            
            n_swaps = n_swaps + 1
            full_array[c(i-1, i) + pos_aux] = array[c(i-1, i)]
            
            output[[iter]] = list(
                array = full_array,
                comparison = c(i-1, i) + pos_aux,
                n_swaps = n_swaps
            )
            
            i = i - 1
            
            if(i > 1){
                
                iter = iter + 1
                
                if(array[i-1] > array[i]){
                    while(i > 1 && array[i-1] > array[i]){
                        
                        array[c(i-1, i)] = array[c(i, i-1)]
                        
                        n_swaps = n_swaps + 1
                        full_array[c(i-1, i) + pos_aux] = array[c(i-1, i)]
                        
                        output[[iter]] = list(
                            array = full_array,
                            comparison = c(i-1, i) + pos_aux,
                            n_swaps = n_swaps
                        )
                        
                        iter = iter + 1
                        
                        i = i - 1
                    }
                    
                    iter = iter - 1
                } else {
                    output[[iter]] = list(
                        array = full_array,
                        comparison = c(i-1, i) + pos_aux,
                        n_swaps = n_swaps
                    )
                }
            }
            
            
            # Bubble right
        } else if(array[i] > array[i+1]){
            
            iter = iter + 1
            
            output[[iter]] = list(
                array = full_array,
                comparison = c(i-1, i) + pos_aux,
                n_swaps = n_swaps
            )
            
            iter = iter + 1

            # swap
            array[c(i, i+1)] = array[c(i+1, i)]
            
            n_swaps = n_swaps + 1
            full_array[c(i, i+1) + pos_aux] = array[c(i, i+1)]
            
            output[[iter]] = list(
                array = full_array,
                comparison = c(i, i+1) + pos_aux,
                n_swaps = n_swaps
            )

            i = i + 1
            
            if(i < n){
                
                iter = iter + 1
                
                if(array[i] > array[i+1]){
                    while(i < n && array[i] > array[i+1]){
                        
                        array[c(i, i+1)] = array[c(i+1, i)]
                        
                        n_swaps = n_swaps + 1
                        full_array[c(i, i+1) + pos_aux] = array[c(i, i+1)]
                        
                        output[[iter]] = list(
                            array = full_array,
                            comparison = c(i, i+1) + pos_aux,
                            n_swaps = n_swaps
                        )
                        
                        iter = iter + 1
                        
                        i = i + 1
                    }
                    
                    iter = iter - 1
                } else {
                    output[[iter]] = list(
                        array = full_array,
                        comparison = c(i, i+1) + pos_aux,
                        n_swaps = n_swaps
                    )
                }
            }
        }
    }

    return(list(
        array = array,
        iter = iter,
        n_swaps = n_swaps,
        output = output
    ))
}

########################################################################

# generate matrix of vectors given an "n"
generate_vector_matrix = function(n, repeats=FALSE){
    print(paste0("creating matrix with ", factorial(n), " rows."))
    
    m = permutations(length(1:n), n, 1:n, repeats = FALSE)
    
    if(!repeats){
        # unique values
        return(m)
    } else {
        # unique values
        m = as.list(as.data.frame(t(m))) # matrix to list
        
        ################################################################
        
        # repeated values
        m_aux = permutations(length(1:n), n, 1:n, repeats = TRUE)
        m_aux = as.list(as.data.frame(t(m_aux))) # matrix to list
        m_aux = m_aux[!(m_aux %in% m)]
        
        i = 1
        while(i < length(m_aux)){
            j = i + 1
            while(j <= length(m_aux)){
                if(all(rank(m_aux[[i]])==rank(m_aux[[j]]))){
                    m_aux[[j]] = NULL
                } else {
                    j = j + 1
                }
            }
            i = i + 1
        }
        
        # list to matrix
        m = t(as.data.frame(m))
        m_aux = t(as.data.frame(m_aux))
        
        # merge matrices
        m = rbind(m, m_aux)
        
        return(m)
    }
    
}

########################################################################

# # test all possible vectors
# n = 9
# m = generate_vector_matrix(n, repeats = F)
# max_iter = 0
# for(i in 1:nrow(m)){
#     iter = 0
# 
#     if(is.unsorted(dgg_sort(m[i,]))){
#         print(i)
#         print(m[i,])
#         print(dgg_sort(m[i,]))
#         break
#     }
# 
#     if(iter > max_iter) max_iter = iter
# }
# print(max_iter)

########################################################################

# # test random vectors
# for(n in 2:1000){
# for(i in 0:100){
#     set.seed(i)
#     array = sample(1:n,n)
# 
#     if(is.unsorted(dgg_sort(array))){
#         print(i)
#         print(array)
#         print(dgg_sort(array))
#         break
#     }
# 
#     if(iter > max_iter) max_iter = iter
# }
# print(paste0("n:", n))
# }

