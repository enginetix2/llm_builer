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
    kill $OLLAMA_PID

# Expose ports (8080 for Open WebUI, 11434 for Ollama)
EXPOSE 8080 11434

# Do not override the CMD: the base image already defines the command to start both services.
