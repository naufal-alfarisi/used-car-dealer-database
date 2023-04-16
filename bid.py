"""
This modul will create dummy data for used bid from buyer
"""

# import necessary library
from faker import Faker
from tabulate import tabulate
import datetime
import pandas as pd
import random

# setup condition and import from a scv file using pandas
df1=pd.read_csv(r'D:\Pacman\SU_SE\Project\SQL\user.csv', skipinitialspace=True)
df1.columns = ['user_id', 'first_name', 'last_name','city','email','phone_number','buyer','seller']

slicer1 = df1[df1['buyer'] == True]
buyer = slicer1.to_dict('list')

df2=pd.read_csv(r'D:\Pacman\SU_SE\Project\SQL\car_product.csv', skipinitialspace=True)
car_product = df2.to_dict('list')

f = Faker()
n_data = 1_000
status = ['sent', 'read']
date = datetime.date(2022,8,1)

# populate the dictionary
bid = {}
bid ['bid_id'] = [f'bid-{i+1}' for i in range(n_data)]
bid ['buyer_id'] = [random.choice(buyer['user_id']) for i in range(n_data)]
bid ['product_id'] = [random.choice(car_product['product_id']) for i in range(n_data)]
bid ['date'] = [] #[f.date_between(datetime.date(2022, 8, 1)) for i in range(n_data)]
for i in range(n_data):
    bid ['date'].append(date)
    if i%4 == 0: date += datetime.timedelta(days=1) 
    else : date += datetime.timedelta(days=0)
bid ['price'] = [f.random_int(80_000_000, 270_000_000, 2_000_000) for i in range(n_data)]
bid ['status'] = [random.choice(status) for i in range(n_data)]

# print dictionary as table
print(tabulate(bid, headers="keys"))
