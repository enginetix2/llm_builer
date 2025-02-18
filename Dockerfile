FROM ghcr.io/open-webui/open-webui:ollama

# Install curl (if not already installed)
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Install Ollama using the official install script
RUN curl -fsSL https://ollama.com/install.sh | sh

# Pre-download the desired Ollama model during build.
# This command starts Ollama in the background, waits 15 seconds for it to initialize,
# pulls the model (replace "llama3:8b" with your desired model), then stops the temporary service.
RUN ollama serve & \
    OLLAMA_PID=$! && \
    sleep 15 && \
    echo "Pulling model llama3.2:3b..." && \
    ollama pull llama3.2 && \
    echo "Model llama3.2:8b pulled." && \
    echo "Pulling model llama3.3..." && \
    ollama pull llama3.3 && \
    echo "Model llama3.3 pulled." && \
    kill $OLLAMA_PID

# Copy the Ollama configuration file to the container
# COPY ollama-config.yaml /etc/ollama/config.yaml

# Copy the Open WebUI configuration file to the container
# COPY open-webui-config.yaml /etc/open-webui/config.yaml

# Copy the Open WebUI custom CSS file to the container
# COPY custom.css /etc/open-webui/custom.css

# Copy the Open WebUI custom JS file to the container
# COPY custom.js /etc/open-webui/custom.js

# Copy the Open WebUI custom logo file to the container
# COPY custom-logo.png /etc/open-webui/custom-logo.png

# Copy the Open WebUI custom favicon file to the container
# COPY custom-favicon.ico /etc/open-webui/custom-favicon.ico

# Copy the Open WebUI custom background image file to the container
# COPY custom-background.jpg /etc/open-webui/custom-background.jpg

# Copy the Open WebUI custom fonts to the container
# COPY fonts /etc/open-webui/fonts

# Copy the Open WebUI custom translations to the container
# COPY translations /etc/open-webui/translations

# Copy the Open WebUI custom plugins to the container
# COPY plugins /etc/open-webui/plugins

# Copy the Open WebUI custom themes to the container
# COPY themes /etc/open-webui/themes

# Copy the Open WebUI custom templates to the container
# COPY templates /etc/open-webui/templates

# Copy the Open WebUI custom static files to the container
# COPY static /etc/open-webui/static

# Copy the Open WebUI custom data files to the container
# COPY data /etc/open-webui/data

# Expose ports (8080 for Open WebUI, 11434 for Ollama)
EXPOSE 8080 11434

# Do not override the CMD: the base image already defines the command to start both services.
