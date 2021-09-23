//Sohaib Wasif
//0874921
//07/03/2020
//CIS*3490
//A3-p21

#include "a3.h"

//This is the brute force algorithm.
void BruteSearch(char r[], char file[])
{
    int cnt = 0, chk = 0;
    int len = strlen(r);
    int shifts = 1;
    int f = 0;
    char doc [2048];
    
    FILE * fptr = fopen(file, "r");
    while(fscanf(fptr, "%[^\n]\n", doc) != EOF){

        for(int j = 0; j < strlen(doc); j++){
            int t = j;
            while(doc[t+f] == r[f] && f < len){
                chk++;
                f++;
            }
            
            if(chk == len){
                cnt++;
                chk = 0;
            }
            if(t+len-1 >= strlen(doc)-1){
                j = strlen(doc);
                shifts++;
            }
            else{
                chk = 0;
                shifts++;
                f = 0;
            }
        }
    }
    fclose(fptr);
    
    printf("Number of Occurences = %d, Number of Shifts = %d\n", cnt, shifts-1);
    return;
}