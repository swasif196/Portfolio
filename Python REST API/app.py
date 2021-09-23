#Sohaib Wasif



import mysql.connector
import json
import requests
from flask import Flask, render_template, request, jsonify, session


db = mysql.connector.connect(host="database_server_to_connect",user="user",passwd="password", db = 'db_name')

mycursor = db.cursor()

app = Flask(__name__, static_url_path='')
app.debug = False

@app.route('/')
def index(name=None):
    session['logged_in'] = False
    return render_template('index.html', name=name) 

@app.route('/value')
def value():
    symbol = request.args.get('symbol')

    
    url = "https://yahoo-finance15.p.rapidapi.com/api/yahoo/qu/quote/" + symbol
        
    headers = {
        'x-rapidapi-host': "yahoo-finance15.p.rapidapi.com",
        'x-rapidapi-key': "e9aaab42f7msh7a1ebf291f1c262p108dcbjsnf45b92f2264c"
    }
    
    response = requests.request("GET", url, headers=headers)
    x = response.text;
    x = x[1:-1]
    y = {}
    if (x != ""):
        y = json.loads(x)
    
    if(x != "" and y["longName"] == None and y["regularMarketPrice"] == None):
         x = "{\"error\":\"Invalid Data\"}"
    
    if(x == ""):
        x = "{\"error\":\"Invalid Data\"}"

    return (jsonify(x))

@app.route('/login', methods=['GET','POST'])
def login(name=None):
    error = None
    if request.method == 'POST':
        email = request.form['email']
        passw = request.form['pass']
        sql = "SELECT username FROM users WHERE username= %s"
        val = (email,)
        mycursor.execute(sql, val)
        res = mycursor.fetchall()
        if(res != []):
            sql = "SELECT username FROM users WHERE username= %s AND pass = %s"
            val = (email, passw)
            mycursor.execute(sql, val)
            res = mycursor.fetchall()
            if(res == []):
                error = 'Invalid username/password'
                session['logged_in'] = False
                return render_template('index.html', error=error)
            session['email'] = email
            session['logged_in'] = True
            return render_template('index.html', name=name)
        
        sql = "INSERT INTO users (username, pass) VALUES (%s, %s)"
        val = (email, passw)
        mycursor.execute(sql, val)
        db.commit()
        session['email'] = email
        session['logged_in'] = True
        return render_template('index.html', name=name)
    return render_template('index.html', name=name)

@app.route('/logout')
def logout(name=None):
    session['logged_in'] = False
        
    return render_template('index.html', name=name)

@app.route('/view')
def view():
    if(session['logged_in'] != True ):
        return "<h1>You can't view the list without logging in.</h1><br><a href=\"/login\">Go back to login page.</a>"
    x = mycursor.rowcount
    if x == 0:
        return "<h1>NO USERS</h1><br><a href=\"/login\">Go back to login page.</a>"
    st=""
    a = ""
    mycursor.execute("SELECT username, pass FROM users")
    myresult = mycursor.fetchall()
    for i in myresult:
        a = str(i)
        st = st + "<br><br>"+a
    st += "<br><br><a href=\'/login\'>Go back to login page.</a>"
    return st;

app.secret_key = 'l;sajflsjbv48485bjlk21!23hlhfl/fsad.,sdf\sd'
app.config["SESSION_COOKIE_SAMESITE"] = "Lax"
