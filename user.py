"""
This modul will create dummy data for user detail
"""

# import necessary library
from faker import Faker
from tabulate import tabulate
import random

# import dictionary from other modul(s)
from city1 import city

# setup condition
f = Faker('id_ID')
n_data = 100

# populate the dictionary
user = {}
user ["user_id"] = [f'user-{i+1}' for i in range(n_data)]
user ["first_name"] = [f.unique.first_name() for i in range(n_data)]
user ["last_name"] = [f.last_name() for i in range(n_data)]
user ["city"] = [random.choice(city["city_id"]) for i in range(n_data)]
user ["email"] = [f"{first_name.lower()}.{last_name.lower()}@{f.free_email_domain()}" for first_name, last_name in zip(user["first_name"], user["last_name"])]
user ["phone_number"] = [f.unique.phone_number() for i in range(n_data)]
user ["buyer"] = [f.boolean() for i in range(n_data)]
user ["seller"] = []
for row in user["buyer"]:
    if row == True : user ["seller"].append(f.boolean())
    else : user ["seller"].append(True)
    
# print dictionary as table
print(tabulate(user, headers="keys"))

