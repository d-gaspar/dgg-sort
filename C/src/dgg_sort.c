
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

void rainbow_even(int *arr, int pos1, int pos2){
    while(pos1 < pos2){

        if(arr[pos1] > arr[pos2]){
            swap(&arr[pos1], &arr[pos2]);
        }

        pos1++;
        pos2--;
    }
}

void rainbow_odd(int *arr, int pos1, int pos2){
    while(pos1 != pos2){

        if(arr[pos1] > arr[pos2]){
            swap(&arr[pos1], &arr[pos2]);
        }

        pos1++;
        pos2--;
    }
}

void dgg_sort(int *arr, int n, int pos1, int pos2){
    int i, j;

    // even number of elements
    if(n % 2 == 0){

        if(n == 2){

            if(arr[pos1] > arr[pos2]){
                swap(&arr[pos1], &arr[pos2]);
            }

            return;
        }

        int n_half = n/2;

        // Rainbow even 1
        rainbow_even(arr, pos1, pos2);

        // left
        dgg_sort(arr, n_half, pos1, pos1+n_half-1);

        // right
        dgg_sort(arr, n_half, pos1+n_half, pos2);

        // Rainbow even 2
        int n_quarter = n/4;
        rainbow_even(arr, pos1+n_half-n_quarter, pos1+n_half+n_quarter-1);

        // Order right and left
        if(n > 4){

            if(n > 6){
                // left
                dgg_sort(arr, n_half-2, pos1+2, pos1+n_half-1);

                // right
                dgg_sort(arr, n_half-2, pos1+n_half, pos2-2);
            }

            // left
            if(arr[pos1+1] > arr[pos1+2]){
                swap(&arr[pos1+1], &arr[pos1+2]);
            }

            // right
            if(arr[pos2-2] > arr[pos2-1]){
                swap(&arr[pos2-2], &arr[pos2-1]);
            }
        }

    // #################################################################

    // odd number of elements
    } else {

        // 3 elements
        if(n == 3){
            
            if(arr[pos1] <= arr[pos1+1]){
                if(arr[pos1+1] <= arr[pos2]){
                    return; // Sorted
                } else {
                    swap(&arr[pos1+1], &arr[pos2]);

                    if(arr[pos1] > arr[pos1+1]){
                        swap(&arr[pos1], &arr[pos1+1]);
                    }
                    return;
                }
            } else {
                swap(&arr[pos1], &arr[pos1+1]);

                if(arr[pos1+1] <= arr[pos2]){
                    return;
                } else {
                    swap(&arr[pos1+1], &arr[pos2]);

                    if(arr[pos1] > arr[pos1+1]){
                        swap(&arr[pos1], &arr[pos1+1]);
                    }
                    return;
                }
            }
            
        }

        int n_half = n/2;

        // Rainbow odd 1
        rainbow_odd(arr, pos1, pos2);

        // left
        dgg_sort(arr, n_half, pos1, pos1+n_half-1);

        // right
        dgg_sort(arr, n_half, pos1+n_half+1, pos2);

        // Rainbow odd 2
        int n_quarter = n/4;
        rainbow_odd(arr, pos1+n_half-n_quarter, pos1+n_half+n_quarter);

        if(n > 5){

            if(n > 7){
                // left
                dgg_sort(arr, n_half-2, pos1+2, pos1+n_half-1);

                // right
                dgg_sort(arr, n_half-2, pos1+n_half+1, pos2-2);
            }

            // left
            if(arr[pos1+1] > arr[pos1+2]){
                swap(&arr[pos1+1], &arr[pos1+2]);
            }

            // right
            if(arr[pos2-2] > arr[pos2-1]){
                swap(&arr[pos2-2], &arr[pos2-1]);
            }
        }

        // bubble left
        if(arr[pos1+n_half-1] > arr[pos1+n_half]){
            swap(&arr[pos1+n_half-1], &arr[pos1+n_half]);

            for(i=pos1+n_half-1; i>pos1; i--){
                if(arr[i-1] > arr[i]){
                    swap(&arr[i-1], &arr[i]);
                } else {
                    break;
                }
            }

        // bubble right
        } else if(arr[pos1+n_half] > arr[pos1+n_half+1]){
            swap(&arr[pos1+n_half], &arr[pos1+n_half+1]);

            for(i=pos1+n_half+1; i<pos2; i++){
                if(arr[i] > arr[i+1]){
                    swap(&arr[i], &arr[i+1]);
                } else {
                    break;
                }
            }
        }
    }
}
