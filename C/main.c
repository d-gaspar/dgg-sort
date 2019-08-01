
#include <stdio.h>
#include <stdlib.h>

int array_n = 42;

#include "dgg_sort.c"

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

int main(void){

    int n=array_n, i, j, sorted=1, *arr;

    printf("n: %d\n", n);

    arr = generate_array(n, 1);

    print_array(arr, 0, n-1);

    dgg_sort(arr, n, 0, n-1);

    print_array(arr, 0, n-1);

    return 0;
}
