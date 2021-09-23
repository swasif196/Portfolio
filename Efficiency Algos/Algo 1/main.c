//Sohaib Wasif
//0874921
//07/02/2020
//CIS*3490
//A2-main

#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<time.h>

typedef struct Points
{
	float x;
	float y;
}Point;

int bruteInv(int x [], int s);
int recurseInv(int x [], int temp [], int s, int indL);
void convexBrute(float y [][2], int s);
void convexRecu(Point y [], int s);

int main()
{
    clock_t t;
    int x [50000];
    float y [30000] [2];
    FILE * fptr = NULL;
    //Reads in data_1.txt
    fptr = fopen("data_1.txt", "r");
    for(int i = 0; i < 50000; i++){
        fscanf(fptr, "%d ", &x[i]);
    }
    fclose(fptr);
    //Reads in data_1.txt
    fptr = fopen("data_2.txt", "r");
    for(int i = 0; i < 30000; i++){
        for(int j = 0; j<2; j++){
            fscanf(fptr, " %f ", &y[i][j]);
        }
    }
    fclose(fptr);
    
    t = clock();
    int p_11 = bruteInv(x, 50000);
    t = clock() - t;
    printf("Iversions for 1.1 = %d\nExecution Time = %f\n", p_11, (float)t);
	printf("Press any key to execute algorithm for Inversion 1.2\n");
	getchar();

    t = clock();
    int temp [50000];
    int p_12 = recurseInv(x, temp, 50000-1, 0);
    t = clock() - t;
    printf("Iversions for 1.2 = %d\nExecution Time = %f\n", p_12, (float)t);
    printf("Press any key to execute algorithm for Convex Hull 2.1\n");
    getchar();
	
    t = clock();
    convexBrute(y, 30000);
    t = clock() - t;
    printf("Convex Hull 2.1 Execution Time = %f\n", (float)t);
    printf("Press any key to execute algorithm for Convex Hull 2.2\n");
	getchar();
    
    //Converts matrix y into an array of points to be used with qsort function in c
	Point p [30000];
	for(int i = 0; i <30000; i++){
		p[i].x = y[i][0];
		p[i].y = y[i][1];
	}
    t = clock();
    convexRecu(p, 30000);
    t = clock() - t;
    printf("Convex Hull 2.2 Execution Time = %f\n", (float)t);
    
    return 0;
}