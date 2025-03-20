#!/bin/bash

# Create LoRAs directory if it doesn't exist
mkdir -p models/loras

CIVITAI_API="7bf31f5b0c8ced06638c50ccc2a73ca9"

# Download LoRAs
wget --header="Authorization: Bearer $CIVITAI_API" \ -O models/loras/WAN General NSFW model (FIXED).safetensors "https://civitai.com/api/download/models/1475095?type=Model&format=SafeTensor" &
wget --header="Authorization: Bearer $CIVITAI_API" \ -O models/loras/Wan Side View Missionary.safetensors "https://civitai.com/api/download/models/1516873?type=Model&format=SafeTensor" &
wget --header="Authorization: Bearer $CIVITAI_API" \ -O models/loras/Doggystyle side view 14B.safetensors "https://civitai.com/api/download/models/1549343?type=Model&format=SafeTensor" &
wget --header="Authorization: Bearer $CIVITAI_API" \ -O models/loras/Wan Cowgirl.safetensors "https://civitai.com/api/download/models/1533834?type=Model&format=SafeTensor" &

echo "LoRA downloads complete!"
