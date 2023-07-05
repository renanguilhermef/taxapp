#!/bin/bash
sudo dnf install python pip -y
pip install fastapi
pip install uvicorn

echo "import socket
from fastapi import FastAPI
from fastapi.responses import HTMLResponse

app = FastAPI()

@app.get('/dev/check')
def root():
    hostname = socket.gethostname()
    ip_address = socket.gethostbyname(hostname)
    return {'Hostname: ' +  hostname + ' IP Address: ' + ip_address }" > main.py

uvicorn main:app --host 0.0.0.0 --port 8080
