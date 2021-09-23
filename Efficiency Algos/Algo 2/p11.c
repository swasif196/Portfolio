//Sohaib Wasif
//0874921
//07/03/2020
//CIS*3490
//A3-p11

#include "a3.h"

//This is the brute force algorithm
void BruteAnagram(Num arr [], Num x, int n)
{
    int cnt = 0;
    for(int i = 0; i < n; i++){
        if(strcmp(arr[i].sign, x.sign) == 0 && strcmp(arr[i].val, x.val) != 0){
            cnt++;
            printf("%s\t",arr[i].val);
        }
    }
    printf("\nThe string %s has %d anagram(s) as listed above.\n", x.val, cnt);
    return;
}