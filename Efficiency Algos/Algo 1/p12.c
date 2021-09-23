//Sohaib Wasif
//0874921
//07/02/2020
//CIS*3490
//A2-1.2

int mergeInv(int x [], int temp [], int s, int indL, int indM);

//Recursive function to calculate inversions using merge sort
int recurseInv(int x [], int temp [], int s, int indL)
{
    //int cnt = 0;
    if(s > indL){
        int indM = (s+indL)/ 2;
    
        return recurseInv(x, temp, indM, indL) + recurseInv(x, temp, s, indM + 1) + mergeInv(x, temp, s, indL, indM + 1);
    }
    return 0;
}

//Merges arrays for merge sort
int mergeInv(int x [], int temp [], int s, int indL, int indM)
{
    int cnt = 0;
    int i = indL;
    int j = indM;
    int ind = indL;
    
    while(i < indM && j < s+1){
        if(x[i] <= x[j]){
            temp[ind++] = x[i++];
        }
        else{
            //Inversion is needed since its not sorted
            temp[ind++] = x[j++];
            cnt += indM - i; 
        }
    }
    
    for(i = i*1; i < indM; i++){
        temp[ind++] = x[i];
    }
    for(j = j*1; j < s + 1; j++){
        temp[ind++] = x[j];
    }
    for(i = indL; i <= s; i++){
        x[i] = temp[i];
    }
    return cnt;
}