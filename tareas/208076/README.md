Tarea: Web Scraping con Selenium y Docker
Esta tarea es parte del proyecto presentado sobre Web Scraping con Selenium. En esta tarea, se implementaron scripts específicos para automatizar la extracción de datos de la página de Hacker News (https://news.ycombinator.com/) utilizando Selenium y Docker. El objetivo fue consolidar conocimientos sobre web scraping y entornos virtualizados.

Estructura del Repositorio

.
├── script.py          # Código para realizar el scraping
├── README.md          # Este archivo
└── resultados/        # Directorio para almacenar archivos CSV con los datos extraídos
Instalación y Configuración
Sigue los mismos pasos para configurar el entorno Docker y Selenium que se presentaron en el proyecto principal. Esto incluye:

Crear una red de contenedores:


docker network create selenium-network
Configurar el servidor Selenium:


docker pull selenium/standalone-chrome
docker run -d --name selenium-server --network selenium-network -p 4444:4444 selenium/standalone-chrome
Configurar el cliente Selenium: Construye la imagen Docker para el cliente:


docker build -t selenium-client .
Luego, ejecuta el cliente:


docker run --rm -it \
    --name selenium-client \
    --network selenium-network \
    -p 8888:8888 \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    selenium-client
Accede al cliente a través del enlace proporcionado en la terminal.

Tareas Realizadas
1. Extracción de Títulos de Noticias
Se implementó un script para extraer los títulos de las noticias principales de Hacker News. Estos datos se imprimen en consola y se pueden almacenar en un archivo CSV.

2. Enlaces de Navegación
El script también incluye la extracción de enlaces de navegación (por ejemplo, New, Past, etc.), organizándolos en un DataFrame.

3. Resultados de Búsqueda
Se creó una funcionalidad para buscar un término en el apartado de búsqueda de Hacker News y almacenar los resultados en un DataFrame, incluyendo los títulos y enlaces de los resultados.

Ejecución del Script
Asegúrate de que los contenedores Docker estén configurados y corriendo.
Ejecuta el script desde el cliente Selenium:

python3 script.py
Los resultados de las tareas se imprimirán en consola. Opcionalmente, puedes guardar los datos en archivos CSV, como se muestra en el script.
Resultados y Observaciones
Los scripts completan las siguientes tareas con éxito:

Extracción de títulos de noticias: Se validó que los títulos extraídos correspondan a las noticias principales de Hacker News.
Enlaces de navegación: Los enlaces como New, Past, etc., se organizan en un formato tabular.
Búsqueda: Los resultados de búsqueda reflejan términos ingresados, con enlaces funcionales.

