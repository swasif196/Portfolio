Sohaib Wasif

This program uses rest API and session cookies to log you in and then get live stock prices for the searched symbol. The login info is stored in a private database which isn't included for privacy reason.

Running the program:

You use the flask run --host=0.0.0.0 --port=[your port] command or any other flask run command to run the program.

Valid Email and Password:

Email -> asd@asd.com
Password -> 123

Description:

When the page loads you are prompted to log in. Login works the same way it did in lab 4. Once you have logged in you have the option to either logout or check a value of a US or Canadian stock by entering its symbol, then you choose whether you want to search its value in the Canadian or the US stock market. Then the flask connects to Yahoo finance API found on rapidapi website. It gets a json back and sends it to client side javascript. Then based on that browser is updated.
