# Base image with Python
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    build-essential \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Chrome and Chromedriver dependencies
RUN apt-get update && apt-get install -y \
    libnss3 \
    libgconf-2-4 \
    fonts-liberation \
    libappindicator3-1 \
    xdg-utils \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Python libraries
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt \
    && pip install jupyter notebook

# Copy the Selenium script (optional for preloading scripts)
COPY notebooks/ .

# Expose port for Jupyter Notebook
EXPOSE 8888

# Set the default command to start Jupyter Notebook
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]



# -----------¡¡¡IGNORAR A PARTIR DE AQUÍ!!!-------
# # Base image with Python
# FROM python:3.11-slim

# # Set working directory
# WORKDIR /app

# # Install dependencies
# RUN apt-get update && apt-get install -y \
#     wget \
#     x11-apps \
#     && rm -rf /var/lib/apt/lists/*

# # Install Python libraries
# COPY requirements.txt .
# RUN pip install --no-cache-dir -r requirements.txt

# # Copy the Selenium script to the container
# COPY your_script.py .

# # Set the default command to run the script
# CMD ["python", "your_script.py"]



# docker network create selenium-network

# docker pull selenium/standalone-chrome

# docker run -d --name selenium-server -p 4444:4444 --shm-size=2g selenium/standalone-chrome

# docker run -d \
#     --name selenium-server \
#     --network selenium-network \
#     -p 4444:4444 \
#     selenium/standalone-chrome

# docker build -t selenium-client .

# docker run --rm \
#     --name selenium-client \
#     --network selenium-network \
#     -e DISPLAY=$DISPLAY \
#     -v /tmp/.X11-unix:/tmp/.X11-unix \
#     selenium-client

# docker run --rm -it \
#     --name selenium-client \
#     --network selenium-network \
#     -p 8888:8888 \
#     -e DISPLAY=$DISPLAY \
#     -v /tmp/.X11-unix:/tmp/.X11-unix \
#     selenium-client-with-jupyter



# Ejecuta el siguiente comando en Ubuntu para verificar que el servidor X11 está activo:

#     echo $DISPLAY

#     Si devuelve algo como :0 o :1, significa que X11 está configurado correctamente.
#     Si no devuelve nada, necesitas iniciar X11. En Ubuntu, X11 normalmente está preinstalado, pero si no lo está, instálalo con:

#     sudo apt update && sudo apt install x11-apps -y

# xhost +local:


