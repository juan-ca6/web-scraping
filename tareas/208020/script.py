from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import pandas as pd

# Configura las opciones de Chrome
chrome_options = Options()
chrome_options.add_argument("--no-sandbox")
chrome_options.add_argument("--disable-dev-shm-usage")
chrome_options.add_argument("--headless")  # Ejecutar en modo sin cabeza

# Conéctate al servidor Selenium Grid
driver = webdriver.Remote(
    command_executor="http://selenium-server:4444/wd/hub",
    options=chrome_options
)

try:
    ### --- Ejercicio 1: Extraer títulos de noticias ---
    print("Ejercicio 1: Extraer títulos de noticias")
    driver.get("https://news.ycombinator.com/")
    
    # Espera a que los elementos de los títulos estén presentes
    WebDriverWait(driver, 10).until(
        EC.presence_of_all_elements_located((By.CSS_SELECTOR, ".titlelink"))
    )
    
    # Extrae los títulos de las noticias
    titles = driver.find_elements(By.CSS_SELECTOR, ".titlelink")
    
    print("Títulos de noticias en Hacker News:")
    for index, title in enumerate(titles, 1):
        print(f"{index}. {title.text}")
    print(f"\nTotal de títulos encontrados: {len(titles)}\n")
    
    ### --- Ejercicio 2: Extraer links de navegación ---
    print("Ejercicio 2: Extraer links de navegación")
    WebDriverWait(driver, 10).until(
        EC.presence_of_all_elements_located((By.CSS_SELECTOR, ".topbar a"))
    )
    
    # Encuentra todos los links de navegación
    nav_links = driver.find_elements(By.CSS_SELECTOR, ".topbar a")
    
    # Crear listas para almacenar datos de los links
    link_texts = []
    link_hrefs = []
    
    for link in nav_links:
        link_texts.append(link.text)
        link_hrefs.append(link.get_attribute('href'))
    
    # Crear DataFrame
    df_links = pd.DataFrame({
        'Link Text': link_texts,
        'Link URL': link_hrefs
    })
    
    print("Links de navegación encontrados:")
    print(df_links)
    
    # Guardar el DataFrame en un archivo CSV
    df_links.to_csv('hacker_news_links.csv', index=False)
    print("\nLinks guardados en el archivo 'hacker_news_links.csv'.\n")
    
    ### --- Ejercicio 3: Buscar algo en la página ---
    print("Ejercicio 3: Buscar algo en la página")
    driver.get("https://hn.algolia.com/")  # Página con función de búsqueda
    
    # Encuentra el campo de búsqueda
    search_input = WebDriverWait(driver, 10).until(
        EC.presence_of_element_located((By.CSS_SELECTOR, "input[placeholder='Search stories by title, url, or author']"))
    )
    
    # Término de búsqueda
    search_term = "Python"
    search_input.send_keys(search_term)
    search_input.send_keys(Keys.RETURN)
    
    # Espera a que se carguen los resultados
    WebDriverWait(driver, 10).until(
        EC.presence_of_all_elements_located((By.CSS_SELECTOR, ".item-title"))
    )
    
    # Extrae los resultados de búsqueda
    search_results = driver.find_elements(By.CSS_SELECTOR, ".item-title")
    result_links = driver.find_elements(By.CSS_SELECTOR, ".item-title a")
    
    # Listas para almacenar datos de los resultados
    titles = []
    links = []
    
    for result, link in zip(search_results, result_links):
        titles.append(result.text)
        links.append(link.get_attribute('href'))
    
    # Crear DataFrame
    df_search_results = pd.DataFrame({
        'Title': titles,
        'Link': links,
    })
    
    print(f"Resultados de búsqueda para '{search_term}':")
    print(df_search_results)
    
    # Guardar el DataFrame en un archivo CSV
    filename = f'hacker_news_search_{search_term}.csv'
    df_search_results.to_csv(filename, index=False)
    print(f"Resultados guardados en el archivo '{filename}'.")

except Exception as e:
    print(f"Ocurrió un error: {e}")

finally:
    # Cierra el navegador
    driver.quit()


