//Sohaib Wasif
//0874921
//07/03/2020
//CIS*3490
//A3-main

#include "a3.h"

int main ()
{
    clock_t t;
    Num arr[30000];
    
    int x = 0;
    //Reads in data_4.txt
    FILE * fptr = fopen("data_4.txt", "r");
    for(int i = 0; i < 30000; i++){
        fscanf(fptr, "%d ", &x);
        sprintf(arr[i].val, "%d", x);
        sprintf(arr[i].sign, "%d", x);
        GenSign(arr[i].sign);
    }
    fclose(fptr);
    
    
    {//This block of code runs and display time for the Brute force Algorithm for Anagrams
        Num r;
        printf("\n**********Question 1.1 Brute Force**********\n");
        printf("Please Enter a String: ");
        scanf("%s", r.val);
        strcpy(r.sign, r.val);
        GenSign(r.sign); //Generates a signature to identify the Anagram
        t = clock();
        BruteAnagram(arr, r, 30000);
        t = clock() - t;
        printf("Brute Force Time = %f\n", (float)t);
    }
    
    {//This block of code runs and display time for the Pre-Sorted Algorithm for Anagrams
        Num r;
        printf("\n**********Question 1.2 Pre-Sorting**********\n");
        printf("Please Enter a String: ");
        scanf("%s", r.val);
        strcpy(r.sign, r.val);
        GenSign(r.sign); //Generates a signature to identify the Anagrams
        //Calculates and outputs the sorting time. I use qsort to sort the list of Anagrams
        //by their signatures.
        t = clock();
        qsort(&arr, 30000, sizeof(Num), compare);
        t = clock() - t;
        printf("Sort Time = %f\n", (float)t);
        t = clock();
        //This function contains the algorithm for pre-sorted anagrams.
        SortedAnagram(arr, r, 30000);
        t = clock() - t;
        printf("Pre Sorted Time = %f\n", (float)t);
    }
    
   {//Brute Force Method for String Searching
        char r [2048];
        printf("\n**********Question 2.1 Brute Force**********\n");
        printf("Please Enter a String: ");
        scanf("%s", r);
        t = clock();        
        BruteSearch(r, "data_5.txt"); //44049
        t = clock() - t;
        printf("Brute Force Time = %f\n", (float)t);
    }
    
    {//Horspool's Method for String Searching
        char r [2048];
        printf("\n**********Question 2.2 Horspool's Method**********\n");
        printf("Please Enter a String: ");
        scanf("%s", r);
        t = clock();        
        HorspoolSearch(r, "data_5.txt"); //44049
        t = clock() - t;
        printf("Horspool's Method Time = %f\n\n", (float)t);
    }
    
    {//Boyer-Moore Algorithm for String Searching
        char r [2048];
        printf("\n**********Question 2.3 Boyer-Moore Method**********\n");
        printf("Please Enter a String: ");
        scanf("%s", r);
        int btab[53];
        int gtab[strlen(r) - 1];
        CreateGoodTable(r, gtab); //Creates a good suffix table
        CreateBadTable(r, btab); //Creates a bad table
        t = clock();
        BoyerMooreSearch(r, "data_5.txt", gtab, btab);
        t = clock() - t;
        printf("Boyer-Moore's Method Time = %f\n", (float)t);
    }
    
    return 0;
}

//Generates a unique signature for any anagram
void GenSign(char x [])
{
    for (int i = 0; i < strlen(x)-1; i++) {
        for (int j = i+1; j < strlen(x); j++) {
            if (x[i] > x[j]) {
                int temp = x[i];
                x[i] = x[j];
                x[j] = temp;
            }
        }
    }
}