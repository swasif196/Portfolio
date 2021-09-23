//Sohaib Wasif
//0874921
//15/03/2020
//CIS*3490
//A4-Q2

#include "a4.h"

Tree * greedyBST(float freq, char keys[128], Tree * t)
{
    if (t == NULL){
        t = malloc(sizeof(Tree));
        strcpy(t->key, keys);
        t->freq = freq;
        t->right = NULL;
        t->left = NULL;
        //printf()
        return t;
    }
    if( strcmp(t->key, keys) > 0){
        //printf("%s, %c\n", t->key, keys);
        t->left = greedyBST(freq, keys, t->left);
    }
    else if(strcmp(t->key, keys) < 0){
        t->right = greedyBST(freq, keys, t->right);
    }
    
    return t;
}