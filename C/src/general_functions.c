
double clock_spent(clock_t clock1,clock_t clock2);
int *generate_array(int n, int opt);
int is_sorted(int *arr, int n);
void make_dir(const char* name);
void print_array(int arr[], int pos1, int pos2);
void swap(int *a, int *b);
double time_spent(struct timeval start, struct timeval stop);

double clock_spent(clock_t start,clock_t stop){
    double c_begin, c_end;

    c_end = (double) stop / ( CLOCKS_PER_SEC / 1000.0);
    c_begin = (double) start / ( CLOCKS_PER_SEC / 1000.0);

    return c_end-c_begin;
}

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

void make_dir(const char* name){
    #ifdef __linux__
        mkdir(name, 777);
    #else
        _mkdir(name);
    #endif
}

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

double time_spent(struct timeval start, struct timeval stop){
    double t_begin, t_end;

    t_end = (double) stop.tv_usec/1000000.0 + stop.tv_sec ;
    t_begin = (double) start.tv_usec/1000000.0 + start.tv_sec ;
    return t_end-t_begin;
}
