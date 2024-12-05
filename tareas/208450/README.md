# Proyecto de Web Scraping con Selenium

## Configuración para ejecutar el proyecto
Para que la tarea corra, es necesario tener instalados, localmente o en un ambiente, las librerías de `selenium` y `pandas`. Después, yo lo hice localmente, pero debemos conectarnos al servicio de `Selenium Grid`. Para lograrlo, debemos seguir estos pasos (estoy en mac entonces baje la imagen correspondiente a mac):

```bash
docker pull seleniarm/standalone-chromium
docker run -d --name selenium-server -p 4444:4444 seleniarm/standalone-chromium
```
Después, accedemos a `http://localhost:4444/ui/` en nuestro navegador y ya estamos conectados a `Selenium Grid` y podemos correr los códigos del notebook **Tarea.ipynb** de manera local.

## Explicación de los códigos
Notar que, para poder realizar los códigos del notebook, abri la página de noticias `https://news.ycombinator.com` en mi navegador para poder inspeccionarla y ver como estaba la estructura de HTML, ya que si lo veía desde el grid de Selenium era medio lento, pero igualmente se podía ver.

### Ejercicio 1
Para el primer ejercicio solo modifiqué el `driver.get()` para incluir el url de la página de noticias y cambié el `driver.find_elements(By.CLASS_NAME, "titleline")` para que obtuviera bien el título, ya que con *storylink* no lo hacía.

### Ejercicio 2
Para este ejericio, vi la estructura html de la página para acceder a los links (primero listé todos los links que se encontraban arriba con sus referencias). Después utilicé `find_element()` y `click()` para acceder a la sección de *"past"* y esperar a que cargue la página. Despúes, para cada artículo de la noticia que accedí con *"tr.athing"* (así estaba en el html) pude sacar el título, link, autor y link del autor. Después, metí todo a un dataframe de pandas y lo guardé como un csv. 

### Ejercicio 3
Finalmente, aquí vi donde estaba la barra de búsqueda y mandé que buscara *"cats"* con `find_element()`, `send_keys()` y `submit()`, igualmente esperé a que cargara la página. Después obtuve todos los artículos de la página que daba como resultado con el `XPATH` y obtuve el título, enlace, puntos, autor, hace cuánto s epublico y los comentarios de cada artículo para meterlos a un dataframe de pandas y guardarlo como csv. La verdad, la búsqueda te mandaba como a otra página y su html estaba medio raro, los textos como el título o número de comentarios estaban en un varios separadores y sacarlos estuvo difícil.