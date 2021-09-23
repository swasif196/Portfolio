Sohaib Wasif
0874921
CIS*3210
A1-Readme


Compiling:

make -> creates server and client executables
make clean -> deletes the server and client executables

Running the program:

server -> ./server
client -> ./client 'server_host' 'file to send'
If client is missing any of the arguments it will give an error.
If a client tries to connect to an offline server it will give an error.

Description:

Each send request client sends 99 characters over to the server. Sometimes some of the words might be cut off due to the character limit but the rest of the word would be sent over in the next send request. For example if the word was "and" and 'a' was the 99th character "nd" would not be sent over. on the next send request "nd" would be the first two characters to be sent over.
