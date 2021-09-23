//Sohaib Wasif
//0874921
//07/03/2020
//CIS*3490
//A3-p12

#include "a3.h"

//This is the pre-sorted algorithm.
void SortedAnagram(Num arr [], Num x, int n)
{
    int cnt = 0, chk = 0;
    
    for(int i = 0; i < n && chk == 0; i++){
        while(strcmp(arr[i].sign, x.sign) == 0){
            chk = 1;
            if(strcmp(arr[i].val, x.val) != 0){
                cnt++;
                printf("%s\t",arr[i].val);
            }
            i++;
        }
    }
    printf("\nThe string %s has %d anagram(s) as listed above.\n", x.val, cnt);
    return;
}

//This is the compare function that is passed to qsort for sorting.
int compare(const void * p1, const void * p2)
{
    const Num * a = (const Num *) p1;
	const Num * b = (const Num *) p2;
    
    return strcmp(a->sign, b->sign);
}