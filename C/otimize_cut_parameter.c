
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

int array_n = 100000;
int n_arrays = 1;
int repeats = 1000;
int array_opt = 4; // opts (0=Sorted; 1=Random; 2=Nearly_sorted; 3=Reverse; 4=Few_unique)

int array_cut_start = 0; // Quick Bubble sort

#include "src/general_functions.c"
#include "src/quick_bubble_sort.c"

int main(void){

    int n=array_n, i, z, *arr, *arr_original, array_cut=array_cut_start, array_step=array_n/100;

    double t_cur=0.0, t_min, clock_cur=0.0, clock_min;

    arr = (int *) calloc(n, sizeof(int));

    struct timeval time_start, time_stop;

    clock_t clock_start, clock_stop;

    char file_name[50];

    // #################################################################

    // Print header and create arrays
    printf("Quick bubble sort\n");
    printf("n = %d\n", n);
    switch(array_opt){
        case 0:
            printf("opt = Sorted\n");
            strcpy(file_name, "output/otimize_cut_parameter/sorted.txt");
            break;
        case 1:
            printf("opt = Random\n");
            strcpy(file_name, "output/otimize_cut_parameter/random.txt");
            break;
        case 2:
            printf("opt = Nearly sorted\n");
            strcpy(file_name, "output/otimize_cut_parameter/nearly_sorted.txt");
            break;
        case 3:
            printf("opt = Reverse\n");
            strcpy(file_name, "output/otimize_cut_parameter/reverse.txt");
            break;
        case 4:
            printf("opt = Few unique\n");
            strcpy(file_name, "output/otimize_cut_parameter/few_unique.txt");
            break;
    }

    // create file
    mkdir("output");
    mkdir("output/otimize_cut_parameter");
    FILE *f = fopen(file_name, "w");
    if (f == NULL)
    {
        printf("Error opening file!\n");
        exit(0);
    }

    // file header
    if(array_opt == 0 || array_opt == 3){ // opts (0=Sorted; 1=Random; 2=Nearly_sorted; 3=Reverse; 4=Few_unique)
        arr_original = generate_array(n, array_opt);

        printf("repeats = %d\n\n", n_arrays*repeats);

        fprintf(f, "# array_size=%d; file_name=%s; repeats=%d\n", array_n, file_name, n_arrays*repeats);
    } else {
        printf("number of arrays = %d\n", n_arrays);
        printf("repeats = %d\n\n", repeats);

        fprintf(f, "# array_size=%d; file_name=%s; number_of_arrays=%d; repeats=%d\n", array_n, file_name, n_arrays, repeats);
    }
    fprintf(f, "cut\ttime_ms\tclock_ms\n");

    // #################################################################

    int iter=0;

    while(array_cut < array_n){

        t_cur = 0.0;
        clock_cur = 0.0;

        iter++;

        if(iter > 1){
            array_cut = array_cut + array_step;
        }

        printf("array_cut = %d\n", array_cut);

        for(z=0; z<n_arrays; z++){
            // Create random array
            if(array_opt!=0 && array_opt!=3){ // opts (0=Sorted; 1=Random; 2=Nearly_sorted; 3=Reverse; 4=Few_unique)
                arr_original = generate_array(n, array_opt);
            }

            // #########################################################

            // Dgg2 sort

            for(i=0; i<n; i++){
                arr[i] = arr_original[i];
            }

            gettimeofday(&time_start, NULL);
            clock_start = clock();

            for(i=0; i<repeats; i++){
                quick_bubble_sort(arr, 0, n-1, array_cut);
            }

            gettimeofday(&time_stop, NULL);
            clock_stop = clock();

            t_cur += time_spent(time_start, time_stop);
            clock_cur += clock_spent(clock_start, clock_stop);

            if(is_sorted(arr, n) == 0){
                printf("\n\nUNSORTED\n\n");
                exit(0);
            }
        }

        fprintf(f, "%d\t%.20f\t%.20f\n", array_cut, (t_cur)*1000000, clock_cur);

        if(iter > 1){
            if(clock_cur < clock_min){
                clock_min = clock_cur;
            }
            if(t_cur < t_min){
                t_min = t_cur;
            }
        }
    }

    // #################################################################

    return 0;
}
