"""
This modul import dictionary from other modul then export it to csv file using pandas
"""

# import pandas library
import pandas as pd

# import dictionary from other module
from bid import bid

# set dictionary as dataframe
df = pd.DataFrame(bid)

# export to csv file
df.to_csv(r'D:\Pacman\SU_SE\Project\SQL\bid.csv', index=False, header=True)

# print the dataframe
print(df)









