#!/bin/bash

# Create LoRAs directory if it doesn't exist
mkdir -p models/loras

# Download LoRAs
wget -O models/loras/Lora1.safetensors "https://huggingface.co/YourRepo/Lora1/resolve/main/Lora1.safetensors"
wget -O models/loras/Lora2.safetensors "https://huggingface.co/YourRepo/Lora2/resolve/main/Lora2.safetensors"
wget -O models/loras/Lora3.safetensors "https://huggingface.co/YourRepo/Lora3/resolve/main/Lora3.safetensors"

echo "LoRA downloads complete!"
