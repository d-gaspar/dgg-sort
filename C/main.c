
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

int array_n = 1000;
int repeats = 100;
int array_opt = 0; // opts (0=Sorted; 1=Random; 2=Nearly_sorted; 3=Reverse; 4=Few_unique)

int array_cut = 3000; // Quick Bubble sort

#include "src/general_functions.c"
#include "src/dgg_sort.c"
#include "src/quick_bubble_sort.c"
#include "src/quick_sort.c"

int main(void){

    int n=array_n, i, *arr, *arr_original;

    double t, c;

    arr = (int *) calloc(n, sizeof(int));

    struct timeval time_start, time_stop;

    clock_t clock_start, clock_stop;

    // Print header and create arrays
    // opts (0=Sorted; 1=Random; 2=Nearly_sorted; 3=Reverse; 4=Few_unique)
    printf("\n   USAGE EXAMPLES\n\n");
    printf("n = %d\n", n);
    arr_original = generate_array(n, array_opt);
    switch(array_opt){
        case 0:
            printf("opt = Sorted\n");
            break;
        case 1:
            printf("opt = Random\n");
            break;
        case 2:
            printf("opt = Nearly sorted\n");
            break;
        case 3:
            printf("opt = Reverse\n");
            break;
        case 4:
            printf("opt = Few unique\n");
            break;
    }

    printf("repeats = %d\n\n", repeats);

    // #################################################################

    // Dgg sort

    t = 0.0;
    c = 0.0;

    for(i=0; i<n; i++){
        arr[i] = arr_original[i];
    }

    gettimeofday(&time_start, NULL);
    clock_start = clock();

    for(i=0; i<repeats; i++){
        dgg_sort(arr, n, 0, n-1);
    }

    gettimeofday(&time_stop, NULL);
    clock_stop = clock();

    if(is_sorted(arr, n) == 0){
        printf("\n\nUNSORTED - Dgg sort\n\n");
        exit(0);
    }

    t += time_spent(time_start, time_stop);
    c += clock_spent(clock_start, clock_stop);

    printf("Dgg sort\n");
    printf("time: %.6f seconds or %.20f milliseconds \n", t, (t)*1000000);
    printf("clock: %.20f milliseconds \n\n", c);

    // #################################################################

    // Quick bubble sort

    t = 0.0;
    c = 0.0;

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

    if(is_sorted(arr, n) == 0){
        printf("\n\nUNSORTED - Quick bubble sort\n\n");
        exit(0);
    }

    t += time_spent(time_start, time_stop);
    c += clock_spent(clock_start, clock_stop);

    printf("Quick bubble sort\n");
    printf("time: %.6f seconds or %.20f milliseconds \n", t, (t)*1000000);
    printf("clock: %.20f milliseconds \n\n", c);

    // #################################################################

    // Quick sort

    t = 0.0;
    c = 0.0;

    for(i=0; i<n; i++){
        arr[i] = arr_original[i];
    }

    gettimeofday(&time_start, NULL);
    clock_start = clock();

    for(i=0; i<repeats; i++){
        quick_sort(arr, 0, n-1);
    }

    gettimeofday(&time_stop, NULL);
    clock_stop = clock();

    if(is_sorted(arr, n) == 0){
        printf("\n\nUNSORTED - Quick sort\n\n");
        exit(0);
    }

    t += time_spent(time_start, time_stop);
    c += clock_spent(clock_start, clock_stop);

    printf("Quick sort\n");
    printf("time: %.6f seconds or %.20f milliseconds \n", t, (t)*1000000);
    printf("clock: %.20f milliseconds \n\n", c);

    // #################################################################

    return 0;
}
