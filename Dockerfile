# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install system dependencies if needed (you can add more if required)
RUN apt-get update && apt-get install -y \
    build-essential \
    libssl-dev \
    libffi-dev \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Remove any pre-installed XlsxWriter package and then install dependencies
RUN pip show XlsxWriter && pip uninstall -y XlsxWriter || true

# Install Python dependencies from requirements.txt
RUN pip install --no-cache-dir --ignore-installed -r requirements.txt

# Copy entrypoint script into the image and make it executable (adjust the entrypoint if needed)
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set the entrypoint for the container
ENTRYPOINT ["/entrypoint.sh"]
