FROM nvidia/cuda:12.1.0-devel-ubuntu22.04
ENV DEBIAN_FRONTEND noninteractive

# https://futhark.readthedocs.io/en/latest/installation.html
RUN apt update && \
    apt install -y --no-install-recommends \
    curl \
    git

# install homebrew
RUN NONINTERACTIVE=1 bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
ENV PATH="/home/linuxbrew/.linuxbrew/bin:${PATH}"
RUN (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /root/.profile

# install futhark
RUN brew install futhark

ENV CUDA_HOME="/usr/local/cuda"
ENV C_INCLUDE_PATH=${CUDA_HOME}/include:${C_INCLUDE_PATH}
ENV LIBRARY_PATH=${CUDA_HOME}/lib64:$LIBRARY_PATH

WORKDIR /app
ADD ./ /app