//Sohaib Wasif
//0874921
//07/02/2020
//CIS*3490
//A2-2.2

#include<stdio.h>
#include<stdlib.h>

//Made a struct for points because I couldn't use the qsort function with a matrix
typedef struct Points
{
	float x;
	float y;
}Point;

Point p0;

int compare(const void * p1, const void * pb);

//Recursive function for Convex Hull problem using qsort
void convexRecu(Point p [], int s)
{
	int ind = 0;
	Point temp [s];
	int y = p[0].y;
    for(int i = 0; i<s-1; i++){
		int cy = p[i].y;
		if(cy < y || (cy == y && p[i].x < p[ind].x)){
			y = p[i].y;
			ind = i;
		}
    }
    Point t = p[0];
	p[0] = p[ind];
	p[ind] = t;
	ind = 0;
    p0 = p[0];
    
	qsort(&p[1], s-1, sizeof(Point), compare);
	
	for(int i = 1; i < s; i++){
		while(i < s-1 && (p[i].y - p0.y) * (p[i+1].x - p[i].x) - (p[i].x - p0.x) * (p[i+1].y - p[i].y) == 0){
			i++;
		}
		//i++;
		/*for(int j = i; j < s-1 && val == 0; j++){
			val = (p[j].y - p0.y) * (p[j+1].x - p[j].x) - (p[j].x - p0.x) * (p[j+1].y - p[j].y);
			i++;
		}*/
		temp[ind] = p[i];
		ind++;
		//printf("i = %d\n", i);
	}
	
	if(ind < 2){
		printf("Convex Hull doesn't exists\n");
		return;
	}
	
	Point temp2[ind];
	int ind2 = 2;
	temp2[0] = p0;
	temp2[1] = temp[1];
	temp2[2] = temp[2];
	for(int i = 2; i < ind; i++){
		int val = (temp[i].y - temp[i-1].y) * (temp[i+1].x - temp[i].x) - (temp[i].x - temp[i-1].x) * (temp[i+1].y - temp[i].y);
		if(val < 0){
			temp2[ind2] = temp[i];
			ind2++;
		}
	}
	for(int i = 0; i<ind2-1; i++){
        for(int j = i+1; j < ind2; j++){
            if(temp2[i].x > temp2[j].x){
                Point t2 = temp2[i];
				temp2[i] = temp2[j];
				temp2[j] = t2;
            }
        }
    }
	for(int i = 0; i < ind2; i++){
		printf("(%.2f,%.2f)\t", temp2[i].x, temp2[i].y);
	}
	printf("\nThere are %d points\n", ind2);
    return;
}

//The compare function for qsort
int compare(const void * p1, const void * p2)
{
	const Point * a = (const Point *) p1;
	const Point * b = (const Point *) p2;
	//printf("Here\n");
    //Calculates orientation
	int val = (a->y - p0.y) * (b->x - a->x) - (a->x - p0.x) * (b->y - a->y);
	//printf("Here2\n");
	if(val < 0){
		return -1;
	}
	else if(val == 0){
		float c1 = (p0.x - a->x) * (p0.x - a->x) + (p0.y - a->y) * (p0.y - a->y);
		float c2 = (p0.x - b->x) * (p0.x - b->x) + (p0.y - b->y) * (p0.y - b->y);
		
		if (c2 >= c1){
			return -1;
		}
		else{
			return 1;
		}
	}
	else{
		return 1;
	}
}