//Sohaib Wasif
//0874921
//07/03/2020
//CIS*3490
//A3-p22

#include "a3.h"

//This is the Horspool's algorithm.
void HorspoolSearch(char r[], char file[])
{
    int cnt = 0, chk = 0;
    int len = strlen(r);
    int shifts = 1;
    int f = 0;
    f = len-1;
    char doc [2048];
    int tab[53];
    //This part of the algorithm generates the search table.
    for(int i = 0; i < 53; i++){
        tab[i] = strlen(r);
    }
    int dis = 1;
    for(int i = len-2; i >= 0; i--){
        if(r[i] >= 65 && r[i] <= 90){
            int x = r[i] - 65;
            if(tab[x] == len){
                tab[x] = dis;
            }
        }
        else if(r[i] >= 97 && r[i] <= 122){
            int x = r[i] - 97 + 26;
            if(tab[x] == len){
                tab [x] = dis;
            }
        }
        dis++;
    }
    
    FILE * fptr = fopen(file, "r");
    while(fscanf(fptr, "%[^\n]\n", doc) != EOF){
        int j = 0;
        while(j < strlen(doc)){
            int t = j;
            while(doc[t+f] == r[f] && t >= 0 && f >= 0){
                chk++;
                f--;
            }
            if(chk == len){
                cnt++;
                j+=len;
            }
            else if(chk == 0){
                if(doc[t+f] >= 65 && doc[t+f] <= 90){
                    int mv = doc[t+f] - 65;
                    j+= tab[mv];
                }
                else if(doc[t+f] >= 97 && doc[t+f] <= 122){
                    int mv = doc[t+f] - 97 + 26;
                    j+= tab[mv];
                }
                else{
                    j+= len;
                }
            }
            else{
                if(doc[t+f+1] >= 65 && doc[t+f+1] <= 90){
                    int mv = doc[t+f+1] - 65;
                    j+= tab[mv];
                }
                else if(doc[t+f+1] >= 97 && doc[t+f+1] <= 122){
                    int mv = doc[t+f+1] - 97 + 26;
                    j+= tab[mv];
                }
            }
            chk = 0;
            shifts++;
            f = len-1;
        }
    }
    fclose(fptr);
    
    printf("Number of Occurences = %d, Number of Shifts = %d\n", cnt, shifts-1);
    return;
}