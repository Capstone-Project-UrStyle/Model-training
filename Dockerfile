FROM python:2.7.12

RUN rm /etc/apt/sources.list
RUN echo "deb http://archive.debian.org/debian/ jessie main" | tee -a /etc/apt/sources.list
RUN echo "deb-src http://archive.debian.org/debian/ jessie main" | tee -a /etc/apt/sources.list

# Pick up some TF dependencies
RUN apt-get update && apt-get install -y --force-yes --no-install-recommends \
        build-essential \
        curl \
        libfreetype6-dev \
        libzmq3-dev \
        libpng12-dev \
        pkg-config \
        python-dev \
        software-properties-common \
        unzip \
        rsync \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Upgrade pip to 20.3.4
RUN pip install --upgrade pip==20.3.4

# Install tensorflow 0.12.0
RUN pip install tensorflow==0.12.0

# Install other python packages
RUN pip --no-cache-dir install \
        ipykernel \
        jupyter \
        matplotlib \
        numpy \
        scipy \
		scikit-learn \
        && \
    python -m ipykernel.kernelspec

ENV TENSORFLOW_VERSION 0.12.0

# TensorBoard
EXPOSE 6006

# IPython
EXPOSE 8888

WORKDIR "/root"

CMD ["/bin/bash"]
