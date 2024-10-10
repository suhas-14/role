#!/usr/bin/env python3

from flask import Flask, request, jsonify
import os

app = Flask(__name__)

counter = {
    '/square_odds':0,
    '/sum':0,
    '/stats':0
}

@app.route('/square_odds', methods=['GET'])
def square_odds():
    data = request.json
    numbers = data['numbers']
    
    odd_numbers = []
    for number in numbers:
        #logic correction
        if number % 2 == 1:
            #name correction
            odd_numbers.append(number)

    #name and logic correction
    squared_odds = [odd ** 2 for odd in odd_numbers]   

    return jsonify({'square_odds': squared_odds}), 200

@app.route('/sum', methods=['GET', 'POST'])
def sum_numbers():
    data = request.json

    total = 0
    for i in data['numbers']:
        total += i

    return jsonify({'sum': total}), 200

#created a new route
@app.route('/stats', methods=['GET', 'POST'])
def get_count():
    counter['/stats'] += 1
    return jsonify(counter), 200

@app.route('/', methods=['GET'])
def index():
    return "Welcome to the API", 200

# TODO: add a route `/stats` that returns the number of times each routes have been called since the program started up.

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=1000)
