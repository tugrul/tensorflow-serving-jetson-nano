FROM arm64v8/ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

# Sistem bağımlılıkları
RUN apt-get update && apt-get install -y \
  build-essential software-properties-common \
  python3 python3-pip automake libtool \
  wget unzip zip curl git openjdk-11-jdk \
  libgmp-dev libmpfr-dev libmpc-dev zlib1g-dev

RUN ln -s /usr/bin/python3 /usr/bin/python

# Jetson CUDA ve cuDNN kaynakları
RUN wget -qO - https://repo.download.nvidia.com/jetson/jetson-ota-public.asc | tee /etc/apt/trusted.gpg.d/jetson.asc && \
    echo "deb https://repo.download.nvidia.com/jetson/common r32.7 main" > /etc/apt/sources.list.d/jetson-common.list && \
    echo "deb https://repo.download.nvidia.com/jetson/t210 r32.7 main" > /etc/apt/sources.list.d/jetson-t210.list && \
    apt-get update && \
    apt-get install -y cuda-toolkit-10-2 libcudnn8 libcudnn8-dev libnvinfer8 libnvinfer-dev

# Python kütüphaneleri
RUN python3 -m pip install --upgrade pip && \
    pip install numpy gast keras_preprocessing grpcio absl-py wrapt opt_einsum

# Bazel 3.4.1 kurulumu (doğrudan binary)
RUN wget -O /usr/local/bin/bazel https://github.com/bazelbuild/bazel/releases/download/3.4.1/bazel-3.4.1-linux-arm64 && \
    chmod +x /usr/local/bin/bazel

WORKDIR /github/workspace
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

