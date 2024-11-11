# Use official Python 3.9.6 base image
FROM python:3.9.6-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the local requirements.txt to the container
COPY requirements.txt .

# Install dependencies (skip pywin32 for non-Windows systems)
RUN if [ "$(uname)" != "Linux" ]; then \
        pip install --no-cache-dir -r requirements.txt; \
    else \
        grep -v 'pywin32' requirements.txt > requirements-linux.txt && \
        pip install --no-cache-dir -r requirements-linux.txt; \
    fi

# Copy the entire project code into the container
COPY . .

# Set the default command to run your Python application
CMD ["python", "main.py"]



# docker build -t my-python-app .

# docker run -it my-python-app


