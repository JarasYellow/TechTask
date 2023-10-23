import json
import pandas as pd
import requests
from bs4 import BeautifulSoup

headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 '
                  'Safari/537.36'
}

page = requests.get('https://www.goszakup.gov.kz/ru/registry/show_supplier/7159', headers=headers, verify=False)

soup = BeautifulSoup(page.text, 'html.parser')

th_elements = soup.find_all('th')
td_elements = soup.find_all('td')

keys = []
values = []

for th in th_elements:
    keys.append(th.text.strip())

for td in td_elements:
    values.append(td.text.strip())

data = {}

desired_fields = ['БИН участника', 'ФИО', 'ИИН', 'Полный адрес(каз)']

for i in range(len(keys)):
    if keys[i] in desired_fields:
        data[keys[i]] = values[i]

with open("data.json", "w") as outfile:
    json.dump(data, outfile)

df = pd.json_normalize(data)

excel_filename = 'excel.xlsx'
df.to_excel(excel_filename, index=False)
