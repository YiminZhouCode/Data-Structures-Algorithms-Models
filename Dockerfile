# Use an official CUDA runtime as a parent image
FROM nvidia/cuda:12.3.1-base-ubuntu20.04
# Set the working directory in the container
WORKDIR /usr/src/app

# Install wget and bzip2
RUN apt-get update && apt-get install -y wget bzip2

# Download and install Anaconda
RUN wget https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh && \
    bash Anaconda3-2020.02-Linux-x86_64.sh -b -p /opt/conda && \
    rm Anaconda3-2020.02-Linux-x86_64.sh

# Add Anaconda to PATH
ENV PATH /opt/conda/bin:$PATH

# Install PyTorch with CUDA support
RUN conda install pytorch torchvision cudatoolkit=11.0 -c pytorch

# Install Jupyter Notebook
RUN conda install -c conda-forge notebook

# Make port 8888 available to the world outside this container
EXPOSE 8888

# Run Jupyter Notebook when the container launches
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]

# Run docker run -p 8888:8888 <your container name> in terminal, then replace id with 'localhost'