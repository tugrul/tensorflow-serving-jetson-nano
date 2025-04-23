#!/bin/bash
set -e

git config --global --add safe.directory /github/workspace

export TF_NEED_CUDA=1
export TF_CUDA_VERSION=10.2
export TF_CUDNN_VERSION=8
export TF_CUDA_COMPUTE_CAPABILITIES="5.3"
export CUDA_HOME=/usr/local/cuda

bazel build \
  --config=cuda \
  --define=no_nccl_support=true \
  --define=maxrregcount=80 \
  --action_env=PYTHON_BIN_PATH="$(which python3)" \
  --action_env=TF_CUDA_VERSION="$TF_CUDA_VERSION" \
  --action_env=TF_CUDNN_VERSION="$TF_CUDNN_VERSION" \
  --action_env=TF_CUDA_COMPUTE_CAPABILITIES="$TF_CUDA_COMPUTE_CAPABILITIES" \
  //tensorflow_serving/model_servers:tensorflow_model_server

cp bazel-bin/tensorflow_serving/model_servers/tensorflow_model_server /github/workspace/

