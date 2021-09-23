/*
** client.c -- a stream socket client demo
** some of the code was copied from beej's tutorial
*/

/*Sohaib Wasif*/


#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <netdb.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <sys/socket.h>

#include <arpa/inet.h>

#define PORT "24921" // the port client will be connecting to 

#define MAXDATASIZE 100 // max number of bytes we can get at once 

// get sockaddr, IPv4 or IPv6:
void *get_in_addr(struct sockaddr *sa)
{
	if (sa->sa_family == AF_INET) {
		return &(((struct sockaddr_in*)sa)->sin_addr);
	}

	return &(((struct sockaddr_in6*)sa)->sin6_addr);
}

int main(int argc, char *argv[])
{
    FILE * fp;
    int sockfd;
    
    if (argc != 3) {
        fprintf(stderr,"usage: client hostname and text file\n");
        exit(1);
    }
    
    fp = fopen(argv[2] , "r");
    if(fp == NULL) {
        perror("Error opening file");
        return(-1);
    }
    
    char buf[10000][MAXDATASIZE];
    int i = 0, c = 0;
    fread(&(buf[i]), sizeof(char), MAXDATASIZE-1, fp);
    while(!feof(fp)){
        i++;
        fread(&(buf[i]), sizeof(char), MAXDATASIZE-1, fp);
    }
    fclose(fp);

    while(c < i+1){
        
        //int numbytes, new_fd;  
        struct addrinfo hints, *servinfo, *p;
        int rv;
        char s[INET6_ADDRSTRLEN];
        

        memset(&hints, 0, sizeof hints);
        hints.ai_family = AF_UNSPEC;
        hints.ai_socktype = SOCK_STREAM;

        if ((rv = getaddrinfo(argv[1], PORT, &hints, &servinfo)) != 0) {
            fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(rv));
            return 1;
        }

        // loop through all the results and connect to the first we can
        for(p = servinfo; p != NULL; p = p->ai_next) {
            if ((sockfd = socket(p->ai_family, p->ai_socktype,
                    p->ai_protocol)) == -1) {
                perror("client: socket");
                continue;
            }
            
            //new_fd=

            if (connect(sockfd, p->ai_addr, p->ai_addrlen) == -1) {
                perror("client: connect");
                close(sockfd);
                continue;
            }

            break;
        }

        if (p == NULL) {
            fprintf(stderr, "client: failed to connect\n");
            return 2;
        }

        inet_ntop(p->ai_family, get_in_addr((struct sockaddr *)p->ai_addr),
                s, sizeof s);
        printf("client: sending to %s\n", s);

        freeaddrinfo(servinfo); // all done with this structure

       if (!fork()) { // this is the child process
            //close(sockfd); // child doesn't need the listener
            //int i = 0;

            int x = send(sockfd, buf[c], MAXDATASIZE, 0);
            if ( x == -1)
                perror("send");
            close(sockfd);
            exit(0);
        }
        printf("Client: sent '%s'\n", buf[c]);
        c++;
    }
    
	return 0;
}
