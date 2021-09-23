//Sohaib Wasif
//0874921
//15/03/2020
//CIS*3490
//A4-headers

//This file is very essential. It contains all theaders for all the .c files.

#ifndef A4_H
#define A4_H

#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<time.h>

typedef struct tree
{
    char key[128];
    float freq;
	struct tree * right;
	struct tree * left;
}Tree;

void dynamicBST(float freq[600], float c[601][601], float r[601][601], int n);
Tree * createTree(int i, int j, float r [601][601], char keys[2045][128], float freq[600]);
Tree * greedyBST(float freq, char keys[128], Tree * t);
void search(Tree * t, char s[128]);

#endif