Sohaib Wasif


Compiling the program:

make

Running the program:

./server

Removing server:

make clean

Directory:

- .html files
- Makefile
- Server
- Readme
- css folder
    - .css
- js folder
    - .js
- pics folder
    - .svg
    
URL Paths:

'/' <- Doesn't exist you get a 404 page

'/<existing html>' <- Html is rendered and loaded

'/<non existing html>' <- If the html isn't in the server directory you get a 404 page

Reference/Attribution

The code for the stream socket server was taken from Beej's tutorials/book.
Link <- https://beej.us/guide/bgnet/examples/server.c

All the other code regarding http functionality was written by me and was not taken from any other source.

Description:

For this program you are given index.html as a sample file. Also, 404.html is also given for 404 error message. Supporting css and js files are in their respective folders for the index.html. You don't need to put the css and js files in the folder they can be in the same directory as the server and server would run fine. The svg image used in 404 is located in the pics directory.