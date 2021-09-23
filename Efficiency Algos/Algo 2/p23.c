//Sohaib Wasif
//0874921
//07/03/2020
//CIS*3490
//A3-p23

#include "a3.h"

//This is the Boyer-Moore Algorithm.
void BoyerMooreSearch(char r[], char file[], int good[], int tab[])
{
    int cnt = 0, chk = 0;
    int len = strlen(r);
    int shifts = 1;
    int f = 0;
    f = len-1;
    char doc [2048];    
    
    FILE * fptr = fopen(file, "r");
    while(fscanf(fptr, "%[^\n]\n", doc) != EOF){        
        int d = 0, d1 = 0, d2 = 0;
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
                d2 = good[chk-1];
                if(doc[t+f+1] >= 65 && doc[t+f+1] <= 90){
                    int mv = doc[t+f+1] - 65;
                    d1 = tab[mv] - chk;
                }
                else if(doc[t+f+1] >= 97 && doc[t+f+1] <= 122){
                    int mv = doc[t+f+1] - 97 + 26;
                    d1 = tab[mv] - chk;
                }
                if(d1 < 1){
                    d1 = 1;
                }
                if(d1 >= d2){
                    d = d1;
                }
                else{
                    d = d2;
                }
                j+=d;
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

//This function creates the bad search table for Boyer-Moore.
void CreateBadTable(char r[], int tab[53])
{
    int dis = 1;
    
    int len = strlen(r);
    
    for(int i = 0; i < 53; i++){
        tab[i] = strlen(r);
    }
    
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
    return;
}

//This function creates the good suffix table for Boyer-Moore.
void CreateGoodTable(char chk[], int tab[])
{
    int x = strlen(chk);
    for(int i = 0; i < x-1; i++){
        //int k = 0;
        char pat[128];
        char cmp[128];
        memset(cmp, '\0', sizeof(cmp));
        char * use = NULL;
        use = &(chk[x-i-1]);
        strcpy(pat, use);
        strncpy(cmp, chk, x-i-1);
        char * str1 = strstr(cmp, pat);
        char * str2 = NULL; 
        while(i == 0 && str1 != NULL){
            str2 = str1;
            str1++;
            str1 = strstr(str1, pat);
        }
        if(i == 0){
            if(str2 == NULL){
                tab [i] = x;    
            }
            else{
                tab[i] = strlen(str2);
            }
        }
        else if(i == 1){
            if(str1 == NULL){
                
                char tcmp[128];
                memset(tcmp, '\0', sizeof(tcmp));
                use = &(chk[x-1]);
                strncpy(tcmp, chk, x-1);
                str2 = strstr(tcmp, use);
                if(str2 == NULL){
                    tab[i] = x;
                }
                else{
                    tab[i] = strlen(str2);
                }
            }
            else{
                tab [i] = strlen(str1);
            }
        }
        else if(str1 == NULL){
            tab[i] = tab[i-1];
        }
        else{
            tab [i] = strlen(str1);
        }
    }
    
    return;
}
