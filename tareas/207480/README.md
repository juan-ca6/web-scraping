# Proyecto de Web Scraping con Selenium y Docker

## Descripción
Este proyecto implementa web scraping en Hacker News utilizando Selenium, Docker y Python. Incluye tres tareas principales:
1. Extracción de títulos de noticias
2. Obtención de links de navegación
3. Búsqueda y extracción de resultados

## Requisitos Previos
- Docker
- Docker Compose
- Python 3.8+

## Configuración del Entorno

### 1. Clonar el Repositorio
```bash
git clone https://github.com/tu-usuario/web-scraping-selenium.git
cd web-scraping-selenium
```

### 2. Crear Dockerfile
```dockerfile
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
```

### 3. Crear requirements.txt
```
selenium==4.10.0
pandas==2.0.1
webdriver-manager==3.8.6
```

### 4. Crear docker-compose.yml
```yaml
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
```

### 5. Scripts de Scraping
- `task1_news_titles.py`: Extracción de títulos
- `task2_navigation_links.py`: Obtención de links de navegación
- `task3_search_results.py`: Búsqueda y extracción de resultados

## Ejecución del Proyecto

### Iniciar Servicios de Selenium
```bash
docker-compose up -d selenium-hub chrome
```

### Ejecutar Scripts de Scraping
```bash
# Task 1: Extracción de títulos
docker-compose run scraper python task1_news_titles.py

# Task 2: Links de navegación
docker-compose run scraper python task2_navigation_links.py

# Task 3: Búsqueda de resultados
docker-compose run scraper python task3_search_results.py
```

## Resultados
- Los resultados se guardarán en archivos CSV en el directorio local
- Puedes modificar los scripts para personalizar la búsqueda y extracción

## Consideraciones
- Respeta los términos de servicio de los sitios web
- Usa web scraping de manera ética
- Implementa delays entre solicitudes para no sobrecargar los servidores

## Troubleshooting
- Asegúrate de tener Docker y Docker Compose instalados
- Verifica que los puertos 4444 estén disponibles
- Revisa la conexión a internet

## Contribuciones
Las contribuciones son bienvenidas. Por favor, abre un issue o un pull request.
```

## Detalles Importantes

### Estructura del README
1. Descripción clara del proyecto
2. Requisitos previos
3. Pasos de configuración detallados
4. Instrucciones de ejecución
5. Consideraciones éticas
6. Guía de troubleshooting

### Archivos Incluidos
- Dockerfile
- docker-compose.yml
- requirements.txt
- Scripts de ejemplo

### Consejos Adicionales
- El README proporciona una guía completa para configurar y ejecutar el proyecto
- Incluye consideraciones éticas sobre web scraping
- Ofrece flexibilidad para modificar y personalizar los scripts

¿Quieres que te explique alguna parte del README o necesitas alguna modificación específica?