"""
This modul will create dummy data for used car product
"""

# import necessary library
from faker import Faker
from tabulate import tabulate

import datetime
import pandas as pd
import random

# import dictionary from other modul(s)
from car_type import car_type

# setup condition and import from a scv file using pandas
f = Faker()
n_data = 300
color = ['red', 'black', 'white', 'grey', 'blue', 'yellow', None]
current_year = datetime.datetime.now().year
detail = ['ready to go', 'good', 'need some attention', 'never involved in an accident', 'well maintained', None]

df1=pd.read_csv(r'D:\Pacman\SU_SE\Project\SQL\user.csv', skipinitialspace=True)
df1.columns = ['user_id', 'first_name', 'last_name','city','email','phone_number','buyer','seller']

slicer1 = df1[df1['seller'] == True]
seller = slicer1.to_dict('list')

# populate the dictionary
car_product = {}
car_product ['product_id'] = [f'product-{i+1}' for i in range(n_data)]
car_product ['seller_id'] =[random.choice(seller['user_id']) for i in range(n_data)]
car_product ["car_id"] = [random.choice(car_type["car_id"]) for i in range(n_data)]
car_product ['year'] = [random.randint(2005, 2022) for i in range(n_data)]
car_product ['price'] = [f.random_int(100_000_000, 250_000_000, 1_000_000) for i in range(n_data)]
car_product ['color'] = [random.choice(color) for i in range(n_data)]
car_product ['milage'] = []
for row in car_product ['year']:
    if row > 2019 : car_product ['milage'].append((current_year - row)*f.random_int(9_000, 12_000, 1000))
    elif row < 2010 : car_product ['milage'].append(None)
    else : car_product ['milage'].append((current_year - row)*f.random_int(10_000, 15_000, 1000))
car_product ['date_posted'] = [f.date_between(datetime.date(2021, 1, 1), datetime.date(2022, 7, 31)) for i in range(n_data)]
car_product ['detail'] = [random.choice(detail) for i in range(n_data)]

# print dictionary as table
print(tabulate(car_product, headers="keys"))
