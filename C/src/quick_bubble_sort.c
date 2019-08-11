
// #####################################################################
// #                                                                   #
// # AUTHOR: Daniel Gaspar Goncalves                                   #
// # git: https://github.com/d-gaspar/                                 #
// #                                                                   #
// #####################################################################

void quick_sort_modified(int *arr, int pos1, int pos2, int array_cut);
void quick_bubble_sort(int *arr, int pos1, int pos2, int array_cut);

void print_array(int arr[], int pos1, int pos2){
    int i;
    pos1 = 0;
    pos2 = array_n-1;
    int n_half = array_n/2;

    if(array_n % 2 == 0){
        for(i=pos1; i<=pos2; i++){
            if(i == n_half){
                printf(" |");
            }
            printf(" %d", arr[i]);
        }
    } else {
        for(i=pos1; i<=pos2; i++){
            if(i == n_half){
                printf(" | %d |", arr[i]);
            } else {
                printf(" %d", arr[i]);
            }
        }
    }

    printf("\n");
}

void swap(int *a, int *b){
    int aux;

    aux = *a;
    *a = *b;
    *b = aux;
}


void quick_sort_modified(int *arr, int pos1, int pos2, int array_cut){

    int pivo, i=pos1, j=pos2;

    pivo = arr[(pos1 + pos2) / 2];

    while(i <= j){
        while(arr[i] < pivo && i < pos2){
            i++;
        }
        while(arr[j] > pivo && j > pos1){
            j--;
        }
        if(i <= j){
            swap(&arr[i], &arr[j]);
            i++;
            j--;
        }
    }

    if((pos2-pos1) <= array_cut){
        return;
    }

    if(i < pos2){
        quick_sort_modified(arr, i, pos2, array_cut);
    }
    if(j > pos1){
        quick_sort_modified(arr, pos1, j, array_cut);
    }
}

void quick_bubble_sort(int *arr, int pos1, int pos2, int array_cut){

    int i, j;

    if((pos2-pos1) <= array_cut){
        // Single Quick sort
        quick_sort_modified(arr, pos1, pos2, array_cut);
    } else {
        // Quick sort
        quick_sort_modified(arr, pos1, pos2, array_cut);
    }

    // Bubble
    i = 0;
    while(i < pos2){

        if(arr[i] > arr[i+1]){
            j = i;
            while(j>=0 && arr[j] > arr[j+1]){
                swap(&arr[j], &arr[j+1]);

                j--;
            }
        }
        i++;

    }
}