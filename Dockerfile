# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

RUN chmod +x /app/tests/test_app.sh

# Install any needed packages specified in requirements.txt
# Create the requirements file with Flask in your app folder
RUN pip install --no-cache-dir flask

# Make port 5000 available to the world outside this container
EXPOSE 5000

# Define environment variable for Flask
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0

# Run the application
CMD ["bash", "-c", "python3 src/app.py && sleep 10 && ./tests/test_app.sh"]