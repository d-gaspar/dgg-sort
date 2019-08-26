
// #####################################################################
// #                                                                   #
// # AUTHOR: Daniel Gaspar Goncalves                                   #
// # git: https://github.com/d-gaspar/                                 #
// #                                                                   #
// #####################################################################

void quick_bubble_sort(int *arr, int pos1, int pos2, int array_cut);
void quick_sort_modified(int *arr, int pos1, int pos2, int array_cut);
void quick_bubble_sort_VERBOSE(int *arr, int pos1, int pos2, int array_cut, long long int *iter);
void quick_sort_modified_VERBOSE(int *arr, int pos1, int pos2, int array_cut, long long int *iter);

void quick_bubble_sort(int *arr, int pos1, int pos2, int array_cut){

    int i, j;

    // Quick sort
    quick_sort_modified(arr, pos1, pos2, array_cut);

    // Bubble
    i = 0;
    while(i < pos2){

        if(arr[i] > arr[i+1]){
            swap(&arr[i], &arr[i+1]);

            j = i-1;
            while(j>=0 && arr[j] > arr[j+1]){
                swap(&arr[j], &arr[j+1]);

                j--;
            }
        }
        i++;

    }
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

void quick_bubble_sort_VERBOSE(int *arr, int pos1, int pos2, int array_cut, long long int *iter){

    int i, j;
    
    // Quick sort
    quick_sort_modified_VERBOSE(arr, pos1, pos2, array_cut, iter);

    // Bubble
    i = 0;
    while(i < pos2){

        if(arr[i] > arr[i+1]){
            swap(&arr[i], &arr[i+1]);

            j = i-1;

            if(j<0 || arr[j] <= arr[j+1]) (*iter)++;

            while(j>=0 && arr[j] > arr[j+1]){
                (*iter)++;
                swap(&arr[j], &arr[j+1]);

                j--;
            }
        }
        i++;

    }
}

void quick_sort_modified_VERBOSE(int *arr, int pos1, int pos2, int array_cut, long long int *iter){

    int pivo, i=pos1, j=pos2;

    pivo = arr[(pos1 + pos2) / 2];

    while(i <= j){

        if(arr[i] >= pivo || i >= pos2) (*iter)++;
        if(arr[j] <= pivo || j <= pos1) (*iter)++;

        while(arr[i] < pivo && i < pos2){
            (*iter)++;
            i++;
        }
        while(arr[j] > pivo && j > pos1){
            (*iter)++;
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
        quick_sort_modified_VERBOSE(arr, i, pos2, array_cut, iter);
    }
    if(j > pos1){
        quick_sort_modified_VERBOSE(arr, pos1, j, array_cut, iter);
    }
}
