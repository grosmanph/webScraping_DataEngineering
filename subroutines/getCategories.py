from selenium import webdriver
from bs4 import BeautifulSoup
from selenium.common.exceptions import ErrorInResponseException
opts = webdriver.ChromeOptions()
opts.headless =True
import numpy as np
from time import sleep
from requests import get

def get_categories(url,wdpath):
    try:
        browser = webdriver.Chrome(executable_path=wdpath+'\chromedriver.exe',
                                   options =opts)
        browser.get(url)
        sleep(0.2)
        html_soup = BeautifulSoup(get(browser.current_url).text, 'html.parser')
        
        if html_soup.head.title.text == '404 Not Found':
            print('Page not found\n')
        else:
            cat_urls = []
            site= url
            html_soup = BeautifulSoup(get(browser.current_url).text, 'html.parser')
            side_cat = html_soup.find_all('div',class_='side_categories')[0]
            for nav in side_cat.find_all('a', href=True)[1:]:
                new_url = site+nav['href']
                browser.get(new_url)
    
                is_last_page = False
                while is_last_page == False:
                    cat_urls.append(browser.current_url)
                    
                    pager = browser.find_elements_by_class_name('pager')
                    if pager==[] or pager[0].text.split('\n')[-1].split(' ')[0]=='Page':
                        is_last_page = True
                    else:
                        next_button = pager[0].find_elements_by_tag_name('a')
                        next_button[-1].click()
        
    except ErrorInResponseException:
        print('An error has occurred on the server side')
    finally:
        browser.quit()
        return cat_urls
