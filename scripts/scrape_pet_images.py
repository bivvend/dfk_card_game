from bs4 import BeautifulSoup
import requests
import os
from PIL import Image
import time

URL = "https://dfkeggspert.com/pets/types-of-pets/"
save_location = "D:\DFK\Petimages"
page = requests.get(URL)
soup = BeautifulSoup(page.content, "html.parser")

for a_href in soup.find_all("a", href=True):
    if "dfk-pets-" in a_href["href"]: 
        print(a_href["href"])
        sub_page = requests.get(a_href["href"])
        sub_soup = BeautifulSoup(sub_page.content, "html.parser")
        for img in sub_soup.findAll('img'):
            file_name = str(img).split("?")[0]
            file_name = file_name.split("/")[-1]
            print(file_name)
            path = os.path.join(save_location, file_name)
            time.sleep(0.1)
            
            img = Image.open(requests.get(img.get('src'), stream = True).raw)

            img.save(path)

#print(images)
