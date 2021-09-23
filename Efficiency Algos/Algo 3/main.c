//Sohaib Wasif
//0874921
//15/03/2020
//CIS*3490
//A4-main

#include "a4.h"

int main()
{
    char buff[128];
    buff[127] = '\0';
    char keys[2045][128];
    float freq[2045] = {0};
    int cnt = 0;
    int fnd = -1;
    FILE * fptr = fopen("data_7.txt", "r");
    while(fscanf(fptr, "%s", buff) != EOF){
        buff[127] = '\0';
        for(int i = 0; i < cnt; i++){
            if(strcmp(keys[i], buff) == 0){
                fnd = i;
                break;
            }
        }
        if(fnd != -1){
            freq[fnd]++;
            fnd = -1;
        }
        else{
            strcpy(keys[cnt], buff);
            freq[cnt]++;
            cnt++;
        }
    }
    fclose(fptr);
    for(int i = 0; i < cnt; i++){
        freq[i] = (freq[i]/2045.0000)*100;
    }
    for(int i = 0; i < cnt-1; i++){
        for(int j = i+1; j < cnt; j++){
            if(strcmp(keys[i], keys[j]) > 0){
                char tmp [128];
                strcpy(tmp, keys[i]);
                strcpy(keys[i], keys[j]);
                strcpy(keys[j], tmp);
                float val = freq[i];
                freq[i] = freq[j];
                freq[j] = val;
            }
        }
    }
    //return 0;
    //char keys[] = {'C','D','B', 'A'};
    //float freq[] = {0.4,0.3,0.2,0.1};
    float c [cnt+1][cnt+1];
    float r [cnt+1][cnt+1];
    //return 0;
    dynamicBST(freq, c, r, cnt);
    //return 0;
    Tree * root = createTree(0, cnt, r, keys, freq);
    
    for(int i = 0; i < cnt-1; i++){
        for(int j = i+1; j < cnt; j++){
            if(freq[i] < freq[j]){
                char tmp [128];
                strcpy(tmp, keys[i]);
                strcpy(keys[i], keys[j]);
                strcpy(keys[j], tmp);
                float val = freq[i];
                freq[i] = freq[j];
                freq[j] = val;
            }
        }
    }
    
    Tree * root2 = NULL;
    for(int i = 0; i < cnt; i++){
        root2 = greedyBST(freq[i], keys[i], root2 );
    }
    
    printf("**********Question 1 Dynamic Programming Algorithm**********\n");
    printf("Please Enter a String: ");
    scanf("%s", buff);
    buff[127] = '\0';
    search(root, buff);
    
    printf("**********Question  Greedy Algorithm**********\n");
    printf("Please Enter a String: ");
    scanf("%s", buff);
    buff[127] = '\0';
    search(root2, buff);
    
    return 0;
}

Tree * createTree(int i, int j, float r[601][601], char keys[2045][128], float c[600])
{
    Tree * t = NULL;
    if(i != j){
        t = (Tree*) malloc(sizeof(Tree));
        int x = (int) r[i][j]; 
		strcpy(t->key, keys[x-1]);
        t->freq = c[x-1];
		t->left = createTree(i, (int)r[i][j] - 1, r, keys, c); //left subtree
		t->right = createTree((int)r[i][j], j, r, keys, c); //right subtree
    }
   
   return t; 
}

void search(Tree * t, char s[128])
{
    if(t == NULL){
        printf("Not Found.\n");
    }
    else if(strcmp(t->key, s) == 0){
        printf("Compared With %s (%0.4f), Found.\n", t->key, t->freq);
    }
    else if(strcmp(t->key, s) > 0){
        printf("Compared With %s (%0.4f), Go Left Subtree.\n", t->key, t->freq);
        search(t->left, s);
    }
    else if(strcmp(t->key, s) < 0){
        printf("Compared With %s (%0.4f), Go Right Subtree.\n", t->key, t->freq);
        search(t->right, s);
    }
    
    return;
}