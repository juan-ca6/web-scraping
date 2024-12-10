# Proyecto de Web Scraping con Selenium y Docker

## Descripción
Este proyecto utiliza Selenium junto con Docker para realizar web scraping y extraer información de la página "https://news.ycombinator.com/". Incluye:

1. Extracción de los títulos de noticias.
2. Extracción de enlaces como "New", "Past", etc., y su almacenamiento en un archivo CSV.
3. Realización de una búsqueda en el apartado "Search" y almacenamiento de los resultados en un archivo CSV.

## Prerrequisitos
- Docker y Docker Compose instalados.
- Contenedor Selenium configurado para ejecutarse con Chrome.

## Configuración
1. Clona el repositorio.
2. Configura tu archivo `docker-compose.yml` para incluir un contenedor Selenium con soporte para Chrome.

Ejemplo de configuración para `docker-compose.yml`:
```yaml
version: "3"
services:
  selenium-server:
    image: selenium/standalone-chrome
    ports:
      - "4444:4444"

