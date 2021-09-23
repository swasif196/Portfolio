Sohaib Wasif

******************************Compiling the Program******************************

make <- This command compiles all the programs using one main and produces an executable
        named main.
        
main <- When you compile and run the executable it first runs the program for 1.1 then 1.2
        and the 2.1 and so on all the way to 2.3.
        
a3.h <- It's a very important header file as it contains all the function declarations and
        includes needed for all the c files and the defined struct needed for 1.1 & 1.2.
        
The makefile will not run as intended untill a11 the files from p11.c to p23.c, main.c, a3.h
data_4.txt and data_5.txt are not present in the same directory as the makefile.

All the functions are pretty explanatory and have comments to explain them further.

******************************Question 2.4******************************

Pattern 1: Math
Brute Force
Number of Occurences = 111, Number of Shifts = 3120320
Brute Force Time = 76014.000000
Ratio: 3120320/76014 = 41.05
Horspool's Method
Number of Occurences = 111, Number of Shifts = 911220
Horspool's Method Time = 34256.000000
Ratio: 911220/34256 = 26.60

Pattern 2: University
Brute Force
Number of Occurences = 2345, Number of Shifts = 2856038
Brute Force Time = 72019.000000
Ratio: 2856038/72019 = 39.66
Horspool's Method
Number of Occurences = 2345, Number of Shifts = 442991
Horspool's Method Time = 24087.000000
Ratio: 442991/24087 = 18.39

Pattern 3: Letters
Brute Force
Number of Occurences = 21, Number of Shifts = 2988179
Brute Force Time = 69604.000000
Ratio: 2988179/69604 = 42.93
Horspool's Method
Number of Occurences = 21, Number of Shifts = 574466
Horspool's Method Time = 27113.000000
Ratio: 574466/27113 = 21.19

Pattern 4: Statistics
Brute Force
Number of Occurences = 88, Number of Shifts = 2856038
Brute Force Time = 75141.000000
Ratio: 2856038/75141 = 38.01
Horspool's Method
Number of Occurences = 88, Number of Shifts = 409256
Horspool's Method Time = 24557.000000
Ratio: 409256/24557 = 16.67

Pattern 5: Graduate
Brute Force
Number of Occurences = 43, Number of Shifts = 2944132
Brute Force Time = 76785.000000
Ratio: 2944132/76785 = 38.34
Horspool's Method
Number of Occurences = 43, Number of Shifts = 501114
Horspool's Method Time = 28400.000000
Ratio: 501114/28400 = 17.64

Pattern 6: Undergraduate
Brute Force
Number of Occurences = 183, Number of Shifts = 2723903
Brute Force Time = 64036.000000
Ratio: 2723903/64036 = 42.54
Horspool's Method
Number of Occurences = 183, Number of Shifts = 346544
Horspool's Method Time = 23353.000000
Ratio: 346544/23353 = 14.84

Pattern 7: Guelph
Brute Force
Number of Occurences = 2196, Number of Shifts = 3032226
Brute Force Time = 70849.000000
Ratio: 3032226/70849 = 42.80
Horspool's Method
Number of Occurences = 2196, Number of Shifts = 613060
Horspool's Method Time = 28208.000000
Ratio: 613060/28202 = 21.73

Pattern 8: Degree
Brute Force
Number of Occurences = 69, Number of Shifts = 3032226
Brute Force Time = 80918.000000
Ratio: 3032226/80918 = 37.47
Horspool's Method
Number of Occurences = 69, Number of Shifts = 631439
Horspool's Method Time = 29199.000000
Ratio: 631439/29199 = 21.63

Pattern 9: Stats
Brute Force
Number of Occurences = 2, Number of Shifts = 3076273
Brute Force Time = 71856.000000
Ratio: 3076273/71856 = 42.81
Horspool's Method
Number of Occurences = 2, Number of Shifts = 730709
Horspool's Method Time = 29064.000000
Ratio: 730709/29064 = 25.14

Pattern 10: Supplemental
Brute Force
Number of Occurences = 13, Number of Shifts = 2767947
Brute Force Time = 68982.000000
Ratio: 2767947/68982 = 40.13
Horspool's Method
Number of Occurences = 13, Number of Shifts = 385041
Horspool's Method Time = 23306.000000
Ratio: 385041/23306 = 16.52

Average Ratio Brute Force: 
(40.13 + 42.81 + 37.47 + 42.80 + 42.54 + 38.34 + 38.01 + 42.93 + 39.66 + 41.05)/10 = 40.57

Average Ratio Horspool's:
(16.52 + 25.14 + 21.63 + 21.73 + 14.84 + 17.64 + 16.67 + 21.19 + 18.39 + 26.60)/10 = 20.04

After calculating individual raitos and aveerage ratio for 10 different patterns it can be 
stated with confidence that Brute Force has the ratio of approximately 40 shifts per clock
cycle while Horspool's method has approximately the ratio of 20 shifts per clock cycle.
This, tells us that the Horspool's method is more efficent since it requires almost half
the shifts per clock cycle and less time as observed above to accomplish the task compared
to the Brute Force Method. Half the shifts means that Horspool's method uses much less CPU
resources than the brute force method when executed.