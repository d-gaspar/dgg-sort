
// #####################################################################
// #                                                                   #
// # AUTHOR: Daniel Gaspar Goncalves                                   #
// # git: https://github.com/d-gaspar/                                 #
// #                                                                   #
// #####################################################################

#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>

int array_n = 1000;
int n_arrays = 100;
int repeats = 100;
int array_opt = 4;

int array_cut = 3000; // Quick Bubble sort

#include "src/quick_bubble_sort.c"
#include "src/dgg_sort.c"
#include "src/quick_sort.c"

int *generate_array(int n, int opt){
    int i, j, aux, aux2=3, *arr;

    arr = (int *) calloc(n, sizeof(int));

    switch(opt){
        // Sorted
        case 0:
            for(i=0; i<n; i++){
                arr[i] = i+1;
            }

            break;

        // Random
        case 1:
            // Inicialize
            for(i=0; i<n; i++){
                arr[i] = i+1;
            }

            // Fisher-Yates shuffle
            for(i=1; i<(n-1); i++){
                j = rand() % i;

                // Swap
                aux = arr[i];
                arr[i] = arr[j];
                arr[j] = aux;
            }

            break;

        // Nearly sorted
        case 2:
            // Inicialize
            for(i=0; i<n; i++){
                arr[i] = i + 1;
            }

            if(aux2 < n){
                // Fisher-Yates shuffle
                for(i=1; i<aux2; i++){
                    j = rand() % i;

                    // Swap
                    aux = arr[i];
                    arr[i] = arr[j];
                    arr[j] = aux;
                }
            }

            break;

        // Reverse
        case 3:
            j = n;

            for(i=0; i<n; i++){
                arr[i] = j;
                j = j - 1;
            }

            break;

        // Few unique
        case 4:
            // Inicialize
            for(i=0; i<n; i++){
                arr[i] = ((i+1) % aux2) + 1;
            }

            // Fisher-Yates shuffle
            for(i=1; i<(n-1); i++){
                j = rand() % i;

                // Swap
                aux = arr[i];
                arr[i] = arr[j];
                arr[j] = aux;
            }

            break;
    }

    return(arr);
}

int is_sorted(int *arr, int n){
    int i, a = 1;

    for(i=0; i<(n-1); i++){
        if(arr[i] > arr[i+1]){
            a = 0;
            break;
        }
    }

    return(a);
}

double time_spent(struct timeval start, struct timeval stop){
    double t_begin, t_end;

    t_end = (double)stop.tv_usec/1000000.0 + stop.tv_sec ;
    t_begin = (double)start.tv_usec/1000000.0 + start.tv_sec ;
    return t_end-t_begin;
}

int main(void){

    int n=array_n, i, z, *arr, *arr_original;

    double t_dgg=0.0, t_dgg2=0.0, t_quick=0.0;

    arr = (int *) calloc(n, sizeof(int));

    struct timeval start, stop;

    // Print header and create arrays
    printf("n = %d\n", n);
    if(array_opt != 1){
        arr_original = generate_array(n, array_opt);

        switch(array_opt){
            case 0:
                printf("Array = Sorted\n");
                break;
            case 2:
                printf("Array = Nearly sorted\n");
                break;
            case 3:
                printf("Array = Reverse\n");
                break;
            case 4:
                printf("Array = Few unique\n");
                break;
        }

        printf("repeats = %d\n\n", n_arrays*repeats);
    } else {
        printf("Array = Random\n");
        printf("number of arrays = %d\n", n_arrays);
        printf("repeats = %d\n\n", repeats);
    }



    for(z=0; z<n_arrays; z++){
        // Create random array
        if(array_opt==1){
            arr_original = generate_array(n, 1);
        }

        // #############################################################

//        // Dgg sort
//
//        for(i=0; i<n; i++){
//            arr[i] = arr_original[i];
//        }
//
//        gettimeofday(&start, NULL);
//
//        for(i=0; i<repeats; i++){
//            dgg_sort(arr, n, 0, n-1);
//        }
//
//        gettimeofday(&stop, NULL);
//
//        t_dgg += time_spent(start, stop);
//
//        if(is_sorted(arr, n) == 0){
//            printf("\n\nUNSORTED\n\n");
//            exit(0);
//        }

        // #############################################################

        // Dgg2 sort

        for(i=0; i<n; i++){
            arr[i] = arr_original[i];
        }

        gettimeofday(&start, NULL);

        for(i=0; i<repeats; i++){
            quick_bubble_sort(arr, 0, n-1, array_cut);
        }

        gettimeofday(&stop, NULL);

        t_dgg2 += time_spent(start, stop);

        if(is_sorted(arr, n) == 0){
            printf("\n\nUNSORTED\n\n");
            exit(0);
        }

        // #############################################################

        // Quick sort

        for(i=0; i<n; i++){
            arr[i] = arr_original[i];
        }

        gettimeofday(&start, NULL);

        for(i=0; i<repeats; i++){
            quick_sort(arr, 0, n-1);
        }

        gettimeofday(&stop, NULL);

        t_quick += time_spent(start, stop);

    }

//    printf("Dgg sort\n");
//    printf("%.6f seconds or %.20f milisseconds \n\n",t_dgg,(t_dgg)*1000000);

    printf("Quick bubble sort\n");
    printf("%.6f seconds or %.20f milisseconds \n\n",t_dgg2,(t_dgg2)*1000000);

    printf("Quick sort\n");
    printf("%.6f seconds or %.20f milisseconds \n\n",t_quick,(t_quick)*1000000);

    return 0;
}
