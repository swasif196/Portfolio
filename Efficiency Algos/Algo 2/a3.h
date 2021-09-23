//Sohaib Wasif
//0874921
//07/03/2020
//CIS*3490
//A3-main

//This file is very essential. It contains all theaders for all the .c files.

#ifndef A3_H
#define A3_H

#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<time.h>

typedef struct nums
{
	char val [50];
	char sign [50];
}Num;

void GenSign(char x []);
void BruteAnagram(Num arr [], Num x, int n);
int compare(const void * p1, const void * p2);
void SortedAnagram(Num arr [], Num x, int n);
void BruteSearch(char r[], char file[]);
void HorspoolSearch(char r[], char file[]);
void BoyerMooreSearch(char r[], char file[], int good[], int bad[]);
void CreateBadTable(char r[], int tab[53]);
void CreateGoodTable(char r[], int tab[]);

#endif