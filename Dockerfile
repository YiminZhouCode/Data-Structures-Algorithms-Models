# Use an official CUDA runtime as a parent image
FROM nvidia/cuda:12.3.1-devel-ubuntu20.04

# Set the working directory in the container
WORKDIR /usr/src/app

# Install system packages
RUN apt-get update && apt-get install -y \
    wget \
    bzip2 \
    python3-pip \
    python3-dev && \
    rm -rf /var/lib/apt/lists/*

# Upgrade pip and setuptools
RUN pip3 install --upgrade pip setuptools

# Install the latest PyTorch with CUDA support compatible with the system's CUDA
RUN pip3 install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu113

# Note: Adjust the --extra-index-url to match the CUDA version available in your Docker image if necessary.
# This example uses cu113 for CUDA 11.3. Adjust according to your CUDA version, e.g., cu123 for CUDA 12.3 if available.

# Install Jupyter Notebook
RUN pip3 install notebook

# Make port 8888 available to the world outside this container
EXPOSE 8888

# Run Jupyter Notebook when the container launches
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]

# Run docker run -p 8888:8888 <your container name> in terminal, then replace id with 'localhost'
