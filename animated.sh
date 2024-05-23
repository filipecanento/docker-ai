#!/bin/bash

# This file will be sourced in init.sh

# https://raw.githubusercontent.com/ai-dock/comfyui/main/config/provisioning/animated.sh
printf "\n##############################################\n#                                            #\n#          Provisioning container            #\n#                                            #\n#         This will take some time           #\n#                                            #\n# Your container will be ready on completion #\n#                                            #\n##############################################\n\n"
function download() {
    wget -q --show-progress -e dotbytes="${3:-4M}" -O "$2" "$1"
}

# install ffmpeg
sudo apt install ffmpeg

## Set paths
nodes_dir=/opt/ComfyUI/custom_nodes
models_dir=/opt/ComfyUI/models
checkpoints_dir=${models_dir}/checkpoints
vae_dir=${models_dir}/vae
controlnet_dir=${models_dir}/controlnet
loras_dir=${models_dir}/loras
upscale_dir=${models_dir}/upscale_models

### Install custom nodes

# ComfyUI-Manager
this_node_dir=${nodes_dir}/ComfyUI-Manager
if [[ ! -d $this_node_dir ]]; then
    git clone https://github.com/ltdrdata/ComfyUI-Manager $this_node_dir
else
    (cd $this_node_dir && git pull)
fi

# ComfyUI-AnimateDiff-Evolved
this_node_dir=${nodes_dir}/ComfyUI-AnimateDiff-Evolved
if [[ ! -d $this_node_dir ]]; then
    git clone https://github.com/Kosinkadink/ComfyUI-AnimateDiff-Evolved $this_node_dir
else
    (cd $this_node_dir && git pull)
fi

animated_models_dir=${nodes_dir}/ComfyUI-AnimateDiff-Evolved/models

# ComfyUI-Advanced-ControlNet
this_node_dir=${nodes_dir}/ComfyUI-Advanced-ControlNet
if [[ ! -d $this_node_dir ]]; then
    git clone https://github.com/Kosinkadink/ComfyUI-Advanced-ControlNet $this_node_dir
else
    (cd $this_node_dir && git pull)
fi

### Download checkpoints

# Animated
# mm_sd_v15
model_file=${animated_models_dir}/mm_sd_v15.ckpt
model_url=https://huggingface.co/guoyww/animatediff/resolve/main/mm_sd_v15.ckpt
if [[ ! -e ${model_file} ]]; then
    printf "mm_sd_v15.ckpt...\n"
    download ${model_url} ${model_file}
fi

# Animated - Motion models
# temporaldiff-v1-animatediff
model_file=${animated_models_dir}/temporaldiff-v1-animatediff.ckpt
model_url=https://huggingface.co/CiaraRowles/TemporalDiff/blob/main/temporaldiff-v1-animatediff.ckpt
if [[ ! -e ${model_file} ]]; then
    printf "temporaldiff-v1-animatediff...\n"
    download ${model_url} ${model_file}
fi

## Standard
# v1-5-pruned-emaonly
model_file=${checkpoints_dir}/v1-5-pruned-emaonly.ckpt
model_url=https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/v1-5-pruned-emaonly.ckpt

if [[ ! -e ${model_file} ]]; then
    printf "Downloading Stable Diffusion 1.5...\n"
    download ${model_url} ${model_file}
fi

model_file=${checkpoints_dir}/dreamshaper_8.safetensors
model_url=https://civitai.com/api/download/models/128713

if [[ ! -e ${model_file} ]]; then
    printf "Downloading dreamshaper_8...\n"
    download ${model_url} ${model_file}
fi

## VAE
# vae-ft-mse-840000-ema-pruned.ckpt
model_file=${vae_dir}/vae-ft-mse-840000-ema-pruned.ckpt
model_url=https://huggingface.co/stabilityai/sd-vae-ft-mse-original/resolve/main/vae-ft-mse-840000-ema-pruned.ckpt

if [[ ! -e ${model_file} ]]; then
    printf "Downloading vae-ft-mse-840000-ema-pruned.ckpt...\n"
    download ${model_url} ${model_file}
fi

### Download controlnet

## example

model_file=${controlnet_dir}/control_canny-fp16.safetensors
model_url=https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/control_canny-fp16.safetensors

if [[ ! -e ${model_file} ]]; then
    printf "Downloading Canny...\n"
    download ${model_url} ${model_file}
fi

model_file=${controlnet_dir}/control_v11p_sd15_lineart.pth
model_url=https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11p_sd15_lineart.pth

if [[ ! -e ${model_file} ]]; then
    printf "Downloading control_v11p_sd15_lineart.pth...\n"
    download ${model_url} ${model_file}
fi

model_file=${controlnet_dir}/control_v11p_sd15_lineart.yaml
model_url=https://huggingface.co/lllyasviel/ControlNet-v1-1/blob/main/control_v11p_sd15_lineart.yaml

if [[ ! -e ${model_file} ]]; then
    printf "Downloading control_v11p_sd15_lineart.yaml...\n"
    download ${model_url} ${model_file}
fi

model_file=${controlnet_dir}/control_v11f1p_sd15_depth.pth
model_url=https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11f1p_sd15_depth.pth

if [[ ! -e ${model_file} ]]; then
    printf "Downloading control_v11f1p_sd15_depth.pth...\n"
    download ${model_url} ${model_file}
fi

model_file=${controlnet_dir}/control_v11f1p_sd15_depth.yaml
model_url=https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11f1p_sd15_depth.yaml

if [[ ! -e ${model_file} ]]; then
    printf "Downloading control_v11f1p_sd15_depth.yaml...\n"
    download ${model_url} ${model_file}
fi

model_file=${controlnet_dir}/control_v11p_sd15_openpose.pth
model_url=https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11p_sd15_openpose.pth

if [[ ! -e ${model_file} ]]; then
    printf "Downloading control_v11p_sd15_openpose.pth...\n"
    download ${model_url} ${model_file}
fi

model_file=${controlnet_dir}/control_v11p_sd15_openpose.yaml
model_url=https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11p_sd15_openpose.yaml

if [[ ! -e ${model_file} ]]; then
    printf "Downloading control_v11p_sd15_openpose.yaml...\n"
    download ${model_url} ${model_file}
fi
### Download loras

## example

#model_file=${loras_dir}/epi_noiseoffset2.safetensors
#model_url=https://civitai.com/api/download/models/16576

#if [[ ! -e ${model_file} ]]; then
#    printf "Downloading epi_noiseoffset2 lora...\n"
#    download ${model_url} ${model_file}
#fi
