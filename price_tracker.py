
import time
from selenium import webdriver
from selenium.webdriver.chrome.options import Options

options = Options()
options.add_argument('--headless')
options.add_argument('--disable-gpu')
options.add_argument('--disable-notifications')
DRIVER_PATH = 'chromedriver.exe'
driver = webdriver.Chrome(DRIVER_PATH, chrome_options=options)
driver.get('https://www.nordpoolgroup.com/en/Market-data1/Dayahead/Area-Prices/ALL1/Hourly/?view=table')
time.sleep(1)
popup = driver.find_element_by_xpath('/html/body/div[5]/div[1]/div[2]/div/img').click()
day = driver.find_element_by_xpath('/html/body/div[2]/div/div/div/div[3]/div/div[3]/div[2]/div[1]/div[2]/div/table/tfoot/tr/th[1]')
print(day.text)
area = driver.find_element_by_xpath('/html/body/div[2]/div/div/div/div[3]/div/div[3]/div[1]/div[1]/div/div/ul/li[5]/a').click()
time.sleep(1)
prices = driver.find_elements_by_xpath('//*[@id="datatable"]/tbody/tr')

for i in range (24):
    print(prices[i].text)
