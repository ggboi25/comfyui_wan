#!/bin/bash
#wget -O /workspace/downloads.sh https://raw.githubusercontent.com/ggboi25/comfyui_wan/main/comfy_WAN_jupyter.sh
#chmod +x ./downloads.sh
#./downloads.sh

echo "🚀 Setting up ComfyUI inside /workspace..."

# Step 1: Clone ComfyUI if it doesn't exist
if [ ! -d "/workspace/ComfyUI" ]; then
    echo "📥 Cloning ComfyUI..."
    git clone https://github.com/comfyanonymous/ComfyUI.git /workspace/ComfyUI
else
    echo "✅ ComfyUI already exists. Skipping clone."
fi

cd /workspace/ComfyUI

# Step 2: Install dependencies in the background
echo "📦 Installing dependencies..."
pip install -r requirements.txt > /workspace/install_logs.txt 2>&1 &

# Step 3: Start ComfyUI immediately in the background
echo "🚀 Starting ComfyUI..."
python main.py --listen 0.0.0.0 &  # Runs in the background

# Step 4: Install custom nodes in the background
(
    echo "📦 Installing Custom Nodes..."
    cd custom_nodes
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git
    cd ComfyUI-Manager
    pip install -r requirements.txt
    cd ..
    git clone https://github.com/kijai/ComfyUI-WanVideoWrapper.git
    cd ComfyUI-WanVideoWrapper
    pip install -r requirements.txt
    cd ..
    git https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git
    cd comfyui-videohelpersuite
    pip install -r requirements.txt
    echo "✅ Custom Nodes Installed."
) > /workspace/custom_nodes_log.txt 2>&1 &

echo "✅ ComfyUI is running! Installations are happening in the background."
echo "📜 Logs:"
echo "- Dependencies: /workspace/install_logs.txt"
echo "- Custom Nodes: /workspace/custom_nodes_log.txt"
