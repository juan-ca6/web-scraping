# Web Scraping con Selenium

Bienvenidos al proyecto sobre web scraping. Este repositorio contiene el material necesario para entender, instalar y trabajar con selenium, una potente herramienta de automatización diseñada para pruebas funcionales de aplicaciones web. Contiene una solución para web scraping y automatización utilizando contenedores Docker y Selenium Grid.

## Estructura del Repositorio

```
.
├── notebooks/         # Jupyter notebooks para la clase
├── tareas/            # Directorio de tareas
├── Dockerfile         # Configuración del contenedor
├── README.md          # Este archivo
└── requirements.txt   # Dependencias del proyecto
```

## Instalación

Crear un fork y clonar tu propio repositorio
```bash
cd path/donde/quieres/tu/repositorio
git clone url/git@
cd web-scraping
```

## Red de Contenedores

Una red de contenedores es un entorno virtualizado que conecta contenedores entre sí y con otros recursos, como bases de datos, servicios externos o redes físicas.

### Tipos de Red

- **Bridge (puente)**:
  - La más común para contenedores en una misma máquina
  - Se utiliza por defecto si no especificas otra red
  - Los contenedores conectados a esta red pueden comunicarse entre sí usando nombres de host

## Configuración del Ambiente

### 1. Crear la Red

Crea la red de contenedores que conectará el servidor Selenium con el cliente:

```bash
docker network create selenium-network
```

### 2. Configurar Selenium Server

Descarga y ejecuta el servidor Selenium con Chrome:

```bash
# Descargar la imagen
docker pull selenium/standalone-chrome
o
docker pull seleniarm/standalone-chromium # Para Mac M1, M2, M3                                               

# Ejecutar el servidor
docker run -d --name selenium-server --network selenium-network -p 4444:4444 selenium/standalone-chrome
o
docker run -d --name selenium-server --network selenium-network -p 4444:4444 seleniarm/standalone-chromium # Para Mac M1, M2, M3
```

Para abrir el contenedor primero descarga en VS Code la extensión de Docker e identifica el siguiente apartado:  

<img width="196" alt="Screenshot 2024-12-04 at 12 43 54" src="https://github.com/user-attachments/assets/4a0444df-c4f4-48fc-8dda-fb4ff732bbe4">

Considera el container con nombre "selenium/standalone-chrome" o "seleniarm/standalone-chromium" y luego deberas hacer doble click. Si no esta iniciado, deberas hacer click en "start". Después harás nuevamente doble click y harás click en "Open in Browser". Esto abrirá la ventana en chrome que funcionara como pantalla. 

<img width="230" alt="Screenshot 2024-12-04 at 12 41 25" src="https://github.com/user-attachments/assets/43354c06-9310-43ff-975f-3a028f23a089">

### 3. Configurar Visualización (X11)

Para visualizar las ventanas del navegador, configura X11:

```bash
# Verificar que X11 está activo. 
echo $DISPLAY
```

Si devuelve algo como :0 o :1, significa que X11 está configurado correctamente. Si no devuelve nada, necesitas iniciar X11. En Ubuntu, X11 normalmente está preinstalado, pero si no lo está, instálalo con:
```bash
# Si X11 no está instalado, instálalo
sudo apt update && sudo apt install x11-apps -y
xhost +local: # # Permitir conexiones locales a X11
```



### 4. Configurar Cliente Selenium con Jupyter

Construir la imagen del cliente
```bash
docker build -t selenium-client .
```

Ejecutar el cliente
```bash
docker run --rm -it \
    --name selenium-client \
    --network selenium-network \
    -p 8888:8888 \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    selenium-client
```

Aparecerán varios logs en la terminal y deberás buscar un link similar al siguiente: 
```bash
http://127.0.0.1:8888/tree?token=acc1426b0db1c4c57947c17bc3e961133a4132f50280ac2c
```

Copialo y pegalo en tu navegador chrome. 

### 5. Uso

Para este punto tendrás 2 ventanas abiertas en tu navegador. Una servirá para visulizar el código y el otro para ejecutar los jupyter notebooks. Asegúrate de que todos los contenedores estén ejecutándose correctamente. 

Cuando trates de ejecutar un notebook toma en cuenta lo siguiente: 
1. Ejecuta la primera casilla del notebook
2. Vete a la ventana para visualización (selenium grid) y haces click en el apartado de Sessions (esta en la barra lateral de la izquierda). Entonces aparecerá algo así: 

<img width="1597" alt="Screenshot 2024-12-04 at 12 53 27" src="https://github.com/user-attachments/assets/d5c6d905-53b8-4e89-99b1-d7ec4fbf30f3">

3. Haz click en el icono de la cámara. Saldrá un popup como el siguiente:

<img width="321" alt="Screenshot 2024-12-04 at 12 54 41" src="https://github.com/user-attachments/assets/e9aab966-5863-4cb4-aea3-7b11db6615b0">

4. Después de ingresar la anterior contreseña, finalmente podrás ver el navegador y ver en tiempo real los efectos de los notebooks.  


