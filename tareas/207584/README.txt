# Proyecto de Web Scraping con Selenium y Docker

Este proyecto utiliza Selenium y Docker para realizar web scraping en la página de noticias "Hacker News" (`https://news.ycombinator.com`). El script extrae información de la página, como los títulos de las noticias, enlaces del menú de navegación, y resultados de búsqueda.

## Requisitos Previos

1. **Docker**: Instalar Docker en tu sistema. [Instrucciones](https://www.docker.com/get-started/)
2. **Selenium Grid**: Configurar un contenedor Docker con Selenium Grid.
   ```bash
   docker run -d -p 4444:4444 --name selenium-hub selenium/hub
   docker run -d --link selenium-hub:hub -v /dev/shm:/dev/shm selenium/node-chrome
