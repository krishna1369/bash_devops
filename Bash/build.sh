#!/bin/bash

# --- SAFE REMOVE OLD IMAGES ---
IMAGES=$(docker images -q)
if [ ! -z "$IMAGES" ]; then
    sudo docker rmi -f $IMAGES
fi

# --- CLEAN OLD FOLDER ---
sudo rm -rf gold
mkdir gold
cd gold/

# --- CLONE LATEST CODE ---
git clone https://github.com/krishna1369/Gold_Site_Ecommerce.git
cd Gold_Site_Ecommerce/

# --- BUILD REACT PROJECT ---
echo "Installing npm packages..."
npm install

echo "Creating production build..."
npm run build

# --- VERIFY BUILD EXISTS ---
if [ ! -d "build" ]; then
    echo "❌ ERROR: React build folder not created. Docker image cannot be built."
    exit 1
fi

# --- BUILD DOCKER IMAGE ---
echo "Building Docker image..."
sudo docker build -t react-image -f golddockerfile .

# --- TAG IMAGE ---
sudo docker tag react-image:latest krishna1369/react-repo:latest

# --- PUSH IMAGE TO DOCKER HUB ---
echo "Pushing image..."
sudo docker push krishna1369/react-repo:latest

echo "✅ Build and push completed successfully!"

