
// #####################################################################
// #                                                                   #
// # AUTHOR: Daniel Gaspar Goncalves                                   #
// # git: https://github.com/d-gaspar/                                 #
// #                                                                   #
// #####################################################################

#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <direct.h>
#include <string.h>

int n_start = 5000;
int n_stop = 500000;
int n_step = 5000;
int array_opt = 4; // opts (0=Sorted; 1=Random; 2=Nearly_sorted; 3=Reverse; 4=Few_unique)
int cut_opt = 1; // opts (0=10000; 1=n*0.87)

#include "src/general_functions.c"
#include "src/quick_bubble_sort.c"
#include "src/quick_sort.c"

int main(void){

    int i, n, *arr, *arr_original, array_cut;

    long long int iter;

    char file_name[100], file_name_aux[50];

    // #################################################################

    // cut opt
    switch(cut_opt){
        case 0:
            strcpy(file_name_aux, "10000");
            break;
        case 1:
            strcpy(file_name_aux, "Nx0.87");
            break;
    }

    // Print header and create arrays
    // opts (0=Sorted; 1=Random; 2=Nearly_sorted; 3=Reverse; 4=Few_unique)
    printf("\n   ITER COMPARISON\n\n");

    strcpy(file_name, "output/iter_comparison/cut_");
    strcat(file_name, file_name_aux);
    strcat(file_name, "/");

    mkdir("output");
    mkdir("output/iter_comparison");
    mkdir(file_name);

    switch(array_opt){
        case 0:
            printf("opt = Sorted\n");
            strcat(file_name, "sorted.txt");
            break;
        case 1:
            printf("opt = Random\n");
            strcat(file_name, "random.txt");
            break;
        case 2:
            printf("opt = Nearly sorted\n");
            strcat(file_name, "nearly_sorted.txt");
            break;
        case 3:
            printf("opt = Reverse\n");
            strcat(file_name, "reverse.txt");
            break;
        case 4:
            printf("opt = Few unique\n");
            strcat(file_name, "few_unique.txt");
            break;
    }
    printf("\n\n");

    // create file
    FILE *f = fopen(file_name, "w");
    if (f == NULL)
    {
        printf("Error opening file!\n");
        exit(0);
    }

    // file header
    fprintf(f, "# file_name=%s\n", file_name);
    fprintf(f, "n\tcut\tmethod\titer\n");

    // #################################################################

    for(n=n_start; n<=n_stop; n+=n_step){

        // cut opt
        switch(cut_opt){
            case 0:
                array_cut = 10000;
                break;
            case 1:
                array_cut = n*0.87; // array_cut -> 7/8*n
                break;
        }

        arr_original = generate_array(n, array_opt);
        arr = (int *) calloc(n, sizeof(int));

        printf("n: %d\n", n);

        // #############################################################

        // Quick bubble sort

        iter = 0;

        for(i=0; i<n; i++){
            arr[i] = arr_original[i];
        }

        quick_bubble_sort_VERBOSE(arr, 0, n-1, array_cut, &iter);

        fprintf(f, "%d\t%d\t%s\t%lld\n", n, array_cut, "Quick_bubble_sort", iter);

        // #############################################################

        // Quick sort

        iter = 0;

        for(i=0; i<n; i++){
            arr[i] = arr_original[i];
        }

        quick_sort_VERBOSE(arr, 0, n-1, &iter);

        fprintf(f, "%d\t%d\t%s\t%lld\n", n, array_cut, "Quick_sort", iter);

        // #############################################################

        free(arr_original);
        free(arr);
    }

    // #################################################################

    return 0;
}
