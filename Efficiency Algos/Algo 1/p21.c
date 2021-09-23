//Sohaib Wasif
//0874921
//07/02/2020
//CIS*3490
//A2-2.1

#include<stdio.h>
//Brute force function for Convex Hull Problem
void convexBrute(float y[][2], int s)
{
    for(int i = 0; i<s-1; i++){
        for(int j = i+1; j < s; j++){
            if(y[i][0] > y[j][0]){
                float tempX = y[i][0];
                float tempY = y[i][1];
                y[i][0] = y[j][0];
                y[i][1] = y[j][1];
                y[j][0] = tempX;
                y[j][1] = tempY;
            }
        }
    }
    int ind = -1;
    int cnt = 1;
    float arr [s][2];
    
    arr[0][0] = y[0][0];
    arr[0][1] = y[0][1];
    //printf("Entering for 1\n");
    for(int i = 0; i < s-2; i++){
        for(int j = i+1; j < s-1; j++){
            for(int k = j+1; k < s; k++){
                int val = (y[k][1] - y[i][1]) * (y[j][0] - y[k][0]) - (y[k][0] - y[i][0]) * (y[j][1] - y[k][1]);
                if (val < 0){
                    ind = k;
                    j = k;
                }
            }
            //printf("Exiting for 2\n");
            if(ind != -1){
                arr [cnt][0] = y[ind][0];
                arr [cnt][1] = y[ind][1];
                cnt++;
                i = ind;
                ind = -1;
            }
            else{
                arr [cnt][0] = y[j][0];
                arr [cnt][1] = y[j][1];
                cnt++;
                i = j;
            }
            break;
        }
        i--;
        //printf("out of for 3 i = %d\n", i);
    }
    
    for(int i = 0; i < cnt; i++){
        printf("(%.1f,%.1f)\n", arr[i][0], arr[i][1]);
    }
    printf("There are in total %d points listed above\n", cnt);
    return;
}