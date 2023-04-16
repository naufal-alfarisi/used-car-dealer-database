"""
This module create a new dictionary with item combination from previous dictionary.
The new dictionary can be used as validation table so there is no missmatched 
categories of item.

Note:
This data is only a dummy data, not actual
"""

# import tabulate to print dictionary in table
from tabulate import tabulate

# crete a dictionary with specific category combination
car_data = {
    'Toyota': {
        'Yaris': {'Hatchback': ['MT', 'AT']}, 
        'Agya': {'Hatchback': ['MT', 'AT']},
        'Calya': {'Wagon': ['MT', 'AT']}
    },
    'Daihatsu': {
        'Ayla': {'Hatchback': ['MT', 'AT']},
        'Terios': {'SUV': ['MT']},
        'Xenia': {'MPV': ['MT']}
    },
    'Honda': {
        'Jazz': {'Hatchback': ['MT', 'AT']},
        'CR-V': {'SUV': ['MT', 'AT']},
        # will return Honda Civic Hatchback MT and AT, Honda Civic Sedan MT only
        'Civic': {'Hatchback': ['MT', 'AT'], 'Sedan': ['MT']} 
    },
    'Suzuki': {
        'Ertiga': {'MPV': ['MT']}
    },
    'Ford': {
        'Focus': {'Hatchback': ['MT', 'AT'], 'Sedan': ['MT']},
        'Mustang': {'Sedan': ['MT', 'AT']}
    },
    'VW': {
        'Golf': {'Hatchback': ['MT', 'AT']},
        'Passat': {'Sedan': ['MT']}
    }
}

# set condition
car_id = 1

# create new empty dictionary
car_type = {}
car_type ['car_id'] = []
car_type ['brand'] = []
car_type ['model'] = []
car_type ['type'] = []
car_type ['transmission'] = []

# populate new dictionary with combination from previous dictionary
for brand in car_data:
    for model in car_data[brand]:
        for type in car_data[brand][model]:
            for transmission in car_data[brand][model][type]:
                car_type ['car_id'].append(f'car-{car_id}'), 
                car_type ['brand'].append(brand), 
                car_type ['model'].append(model),
                car_type ['type'].append(type),
                car_type ['transmission'].append(transmission)
                car_id += 1

# print dictionary into table
print(tabulate(car_type, headers="keys"))