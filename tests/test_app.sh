#!/bin/bash

BASE_URL="http://localhost:5000"

# Test /sum endpoint
test_sum() {
    local response
    echo "Testing /sum..."
    # Print full response to debug
    full_response=$(curl -s -d '{"numbers": [1, 2, 3, 4, 5, 6, 7, 8, 9]}' -H "Content-Type: application/json" $BASE_URL/sum)
    echo "Full response: $full_response"

    # Extract sum from response
    response=$(echo $full_response | jq .sum)
    echo "Hello : $response"
    
    # Use a direct comparison for integers
    if [ "$response" -eq 45 ]; then
        echo "Test /sum passed"
    else
        echo "Test /sum failed. Expected 45, got $response"
    fi
}

# Test /square_odds endpoint
test_squared_odds() {
    local response
    echo "Testing /square_odds..."
    full_response=$(curl -s -d '{"numbers": [1, 2, 3, 4, 5]}' -H "Content-Type: application/json" $BASE_URL/square_odds)
    echo "Full response: $full_response"
    
    # Extract square_odds from the response (correct key name)
    response=$(echo "$full_response" | jq -c '.square_odds')
    echo "Square odds: $response"
    
    expected="[1,9,25]"
    
    # Use single bracket for compatibility
    if [ "$response" = $expected ]; then
        echo "Test /square_odds passed"
    else
        echo "Test /square_odds failed. Expected $expected, got $response"
    fi
}

# Test /stats endpoint
test_stats() {
    local response
    echo "Testing /stats..."
    full_response=$(curl -s $BASE_URL/stats)
    echo "Full response: $full_response"

    # Extract the value for "/stats"
    response=$(echo "$full_response" | jq '."/stats"')
    
    # Check if the response is null or empty
    if [ -z "$response" ] || [ "$response" = "null" ]; then
        echo "Test /stats failed. No valid response received."
        return
    fi
    
    expected="5"
    
    # Use single brackets for compatibility
    if [ "$response" = "$expected" ]; then
        echo "Test /stats passed"
    else
        echo "Test /stats failed. Expected $expected, got $response"
    fi
}

# Run the tests
test_sum
test_squared_odds
test_stats
