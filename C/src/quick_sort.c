
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
