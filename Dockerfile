# Base image with CUDA support
FROM nvidia/cuda:11.7.1-cudnn8-devel-ubuntu20.04

# Install necessary packages
RUN apt-get update && apt-get install -y python3-pip python3-venv && rm -rf /var/lib/apt/lists/*

# Set up a virtual environment
WORKDIR /app
COPY requirements.txt requirements.txt
RUN python3 -m venv venv && source venv/bin/activate && pip install --upgrade pip && pip install -r requirements.txt

# Copy the training script and data
COPY . .

# Set the command to run the training script
CMD ["/bin/bash", "-c", "source venv/bin/activate && python3 train.py"]
