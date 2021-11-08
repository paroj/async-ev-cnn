FROM ubuntu:18.04
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y python3 python3-pip libsm6 libxext6 libxrender1
RUN pip3 install --upgrade pip
RUN pip3 install tensorflow==1.4.1 cython==0.29.22 tqdm==4.58.0 opencv-python==4.2.0.34 configargparse==1.3 bitstring==3.1.7 numba==0.52.0 dill==0.3.3
COPY cython_setup.py .
COPY src ./src
RUN python3 cython_setup.py build_ext --inplace
# convenience ENV for running the code
ENV PYTHONPATH=.
ENV HOME=/home/devuser
RUN adduser --disabled-password --gecos "" --shell /bin/bash devuser