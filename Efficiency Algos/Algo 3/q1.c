//Sohaib Wasif
//0874921
//15/03/2020
//CIS*3490
//A4-Q1

#include "a4.h"

void dynamicBST(float freq[600], float c[601][601], float r[601][601], int n)
{
    c[3][1] = 0.0;
    r[3][1] = 0.0;
    for(int i = 0; i < n; i++){
        c[i][i] = 0;
        c[i][i+1] = freq[i];
        r[i][i+1] = i+1;
    }
    //return;
    c[n][n] = 0;
    //return;
    for(int d = 1; d <= n; d++){
        for(int i = 1; i <= n-d; i++){
            int j  = i+d;
            float minval = 1000000;
            int kmin = 0;
            for(int k = i; k <= j; k++){
                if(c[i-1][k-1] + c[k][j] < minval){
                    minval = c[i-1][k-1] + c[k][j];
                    kmin = k;
                }
            }
            r[i-1][j] = kmin;
            float sum = freq[i-1];
            for(int s = i; s < j; s++){
                sum += freq[s];
            }
            c[i-1][j] = minval + sum;
        }
    }
    return;
}