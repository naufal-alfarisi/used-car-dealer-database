"""
This module import city data from a csv file
"""

# import necessary library
import csv
from tabulate import tabulate

# creating function to import data from csv file to a dictionary
def csvcity_to_dict() :

    with open(file = 'city.csv', mode = 'r') as csv_city:

        csv_reader = csv.DictReader(csv_city)

        data = {}
        for row in csv_reader:
            for key, value in row.items():
                    if key not in data:
                        data[key] = []
                    data[key].append(value)
        return data

# run the function
city = csvcity_to_dict()

# print the resulted dictioanry as table
print(tabulate(city, headers="keys"))
