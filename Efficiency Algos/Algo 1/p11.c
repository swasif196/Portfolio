//Sohaib Wasif
//0874921
//07/02/2020
//CIS*3490
//A2-1.1

//Brute force for inversion
int bruteInv(int x [], int s)
{
    int cnt = 0;
    
    for(int i = 0; i<s-1; i++){
        for(int j = i+1; j < s; j++){
            if(x[i] > x[j]){
                cnt++;
            }
        }
    }
    return cnt;
}