
void quick_sort(int *arr, int pos1, int pos2);
void quick_sort_VERBOSE(int *arr, int pos1, int pos2, int *iter);

void quick_sort(int *arr, int pos1, int pos2){

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

    if(i < pos2){
        quick_sort(arr, i, pos2);
    }
    if(j > pos1){
        quick_sort(arr, pos1, j);
    }
}

void quick_sort_VERBOSE(int *arr, int pos1, int pos2, int *iter){

    int pivo, i=pos1, j=pos2, aux;

    pivo = arr[(pos1 + pos2) / 2];

    while(i <= j){

        if(arr[i] >= pivo || i >= pos2) iter++;
        if(arr[j] <= pivo || j <= pos1) iter++;

        while(arr[i] < pivo && i < pos2){
            iter++;
            i++;
        }
        while(arr[j] > pivo && j > pos1){
            iter++;
            j--;
        }
        if(i <= j){
            swap(&arr[i], &arr[j]);
            i++;
            j--;
        }
    }

    if(i < pos2){
        quick_sort_VERBOSE(arr, i, pos2, iter);
    }
    if(j > pos1){
        quick_sort_VERBOSE(arr, pos1, j, iter);
    }
}
