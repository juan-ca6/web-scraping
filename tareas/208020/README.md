Proyecto de Web Scraping con Selenium y Docker
Descripción
Este proyecto implementa web scraping en Hacker News utilizando Selenium, Docker y Python. Incluye tres tareas principales:

Extracción de títulos de noticias.
Obtención de links de navegación.
Búsqueda y extracción de resultados.
El objetivo es automatizar estas tareas y guardar los datos en archivos CSV para su análisis posterior.

Requisitos Previos
Antes de comenzar, asegúrate de tener instalados los siguientes componentes en tu sistema:

Docker
Docker Compose
Python 3.8+
Configuración del Entorno
Sigue estos pasos para configurar y ejecutar el proyecto:

1. Clonar el Repositorio
bash
Copiar código
git clone https://github.com/barbaperezf/web-scraping
cd web-scraping-selenium
2. Crear el Dockerfile
Crea un archivo Dockerfile con el siguiente contenido:

dockerfile
Copiar código
FROM python:3.9-slim

WORKDIR /app

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    unzip

# Copiar archivos de requerimientos
COPY requirements.txt .

# Instalar dependencias de Python
RUN pip install --no-cache-dir -r requirements.txt

# Copiar scripts de scraping
COPY . .

# Comando por defecto
CMD ["python", "script.py"]
3. Crear el archivo requirements.txt
Crea un archivo requirements.txt con las siguientes dependencias:

makefile
Copiar código
selenium==4.10.0
pandas==2.0.1
webdriver-manager==3.8.6
4. Crear el archivo docker-compose.yml
Crea un archivo docker-compose.yml para configurar el entorno Docker:

yaml
Copiar código
version: '3'
services:
  selenium-hub:
    image: selenium/hub:4.10.0
    ports:
      - "4444:4444"

  chrome:
    image: selenium/node-chrome:4.10.0
    shm-size: 2gb
    depends_on:
      - selenium-hub
    environment:
      - SE_EVENT_BUS_HOST=selenium-hub
      - SE_EVENT_BUS_PUBLISH_PORT=4442
      - SE_EVENT_BUS_SUBSCRIBE_PORT=4443

  scraper:
    build: .
    volumes:
      - .:/app
    depends_on:
      - selenium-hub
Ejecución del Proyecto
1. Iniciar Servicios de Selenium
Ejecuta los siguientes comandos para levantar los servicios necesarios:

bash
Copiar código
docker-compose up -d selenium-hub chrome
2. Ejecutar el Script Principal
Ejecuta el script de scraping:

bash
Copiar código
docker-compose run --rm scraper python script.py
Resultados
Los títulos de noticias, links de navegación y resultados de búsqueda se guardarán como archivos CSV en el directorio local del proyecto.
Los archivos generados pueden incluir:
hacker_news_links.csv
hacker_news_search_<término>.csv
Consideraciones
Respeta los términos de servicio de los sitios web que scrapeas.
Usa web scraping de manera ética y responsable.
Implementa delays entre solicitudes para evitar sobrecargar los servidores.
Troubleshooting
Si encuentras problemas, verifica lo siguiente:

Asegúrate de que Docker y Docker Compose están instalados correctamente.
Verifica que el puerto 4444 no esté en uso por otro servicio.
Confirma que tienes conexión a internet.
Contribuciones
Las contribuciones son bienvenidas. Si tienes mejoras o encuentras problemas, por favor abre un issue o envía un pull request.
