# Scraping y automatización de llenado
prueba para construir contenedor para web scraping


# Red de contenedores
Una red de contenedores es un entorno virtualizado que conecta contenedores entre sí y con otros recursos, como bases de datos, servicios externos o redes físicas.


Bridge (puente):
La más común para contenedores en una misma máquina.
Se utiliza por defecto si no especificas otra red.
Los contenedores conectados a esta red pueden comunicarse entre sí usando nombres de host.

# Comando para crear la red
Utiliza el siguiente comando en tu bash para crear la red de contenedores. Uno será el selenium server y otro el selenium client.
```bash
docker network create selenium-network
```
# Comandos para crear la imagen y correr el server
Utiliza los siguientes comando para crear un selenium grid dónde podrás abrir el navegador de muestra y visualizar los procesos hechos por selenium.
```bash
docker pull selenium/standalone-chrome
docker run -d --name selenium-server --network selenium-network -p 4444:4444 selenium/standalone-chrome
```
# Visualizar las ventanas
Ejecuta el siguiente comando en Ubuntu para verificar que el servidor X11 está activo:
```bash
echo $DISPLAY
```
Si devuelve algo como :0 o :1, significa que X11 está configurado correctamente.
Si no devuelve nada, necesitas iniciar X11. En Ubuntu, X11 normalmente está preinstalado, pero si no lo está, instálalo con:
```bash
sudo apt update && sudo apt install x11-apps -y
xhost +local:
```

# Comandos para crear la imagen y correr el client con jupyter
Utiliza los siguientes comandos para crear un cliente de selenium que se conectará al grid para poder iniciar una sesión e ir crapeando o llenando en automático.
```bash
docker build -t selenium-client .
docker run --rm -it --name selenium-client --network selenium-network -p 8888:8888 -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix selenium-client-with-jupyter
```


