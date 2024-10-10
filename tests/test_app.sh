#!/bin/bash

BASE_URL="http://localhost:5000"

test_sum() {
    local response
    echo "Testing /sum..."
    response=$(curl -s -d '{"numbers": [1, 2, 3, 4, 5, 6, 7, 8, 9]}' -H "Content-Type: application/json" $BASE_URL/sum | jq .total)
    if (( response == 45 )); then
        echo "Test /sum passed"
    else
        echo "Test /sum failed. Expected 45, got $response"
    fi
}

# TODO: write the rest of the tests for the other routes.

test_squared_odds(){
    local response
    echo "Testing /sqaured_odds"
    response=$(curl -s -d '{"numbers": [1, 9, 25, 49, 81]}' -H "Content-Type: application/json" $BASE_URL/square_odds | jq .total)
    expect="[1, 9, 25]"
    if [[ "$response" == *"/squared_odds" && "$response" == *"/sum"* && "$response" == *"/stats"* ]]; then
        echo "Test /squared_odds passed"
    else
        echo "Test /squared_odds failed. Expected $expect, got $response"
    fi
}

test_stats(){
    local response
    echo "Test /stats"
    response=$(curl -s $BASE_URL/stats | jq .total)
    if [[ "$response" == *"/squared_odds"* && "$response" == *"/sum"* && "$response" == *"/stats" ]]; then
        echo "Test /stats passed."
    else
        echo "Test /stats failed. Expected $response"
    fi
}


test_sum
test_squared_odds
test_stats
