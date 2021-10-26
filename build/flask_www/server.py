# -*- coding: utf-8 -*-
import sqlite3, re, csv, os
import os.path
from flask import Flask
from flask import render_template, request, redirect, url_for, g
from datetime import datetime

def internal_server_error(e):
    return render_template('555_666.html'), 500
def czterystacztery(e):
    return render_template('555_666.html'), 404

app = Flask(__name__)
app.register_error_handler(500, internal_server_error)
app.register_error_handler(404, czterystacztery)

app.debug = False

DATABASE = "/cytrynkidb/cytrynki.db"

def get_db():
    db = getattr(g, '_database', None)
    if db is None:
        db = g._database = sqlite3.connect(DATABASE)
        db.row_factory = sqlite3.Row
    return db

def query_db(query, args=(), one=False):
    cur = get_db().execute(query, args)
    rv = cur.fetchall()
    cur.close()
    return (rv[0] if rv else None) if one else rv

@app.teardown_appcontext
def close_connection(exception):
    db = getattr(g, '_database', None)
    if db is not None:
        db.close()

@app.route('/')
#@auth.login_required
def index():
    contact_list=query_db("SELECT data, iif(ilosc > 0, ilosc, '') as ilosc, iif(((100.0 * ilosc)/31) > 0,  round(((100.0 * ilosc)/ilosco), 2), '' ) as procent, iif(ilosco > 0, ilosco, '') as ilosco , iif(iloscz > 0, iloscz, '') as iloscz, iif(ilosc > 0, round((ilosc*1.0/iloscz),2), '') as dzieciperciocie FROM cytrynki ORDER by data desc")
    monthly=query_db("select strftime('%m', data) as month, min(ilosc) as minimum, max(ilosc) as maximum, round(avg(ilosc), 1) as average, min(iloscz) as minimumo, max(iloscz) as maximumo, round(avg(iloscz), 1) as averageo from cytrynki where ilosc > 0 group by strftime('%m',data)")
    return render_template("index.html",contact_list=contact_list,monthly=monthly)
