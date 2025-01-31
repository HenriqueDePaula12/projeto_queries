from sqlalchemy import create_engine
import pandas as pd
import os

## Configurações do banco de dados PostgreSQL
engine = create_engine('postgresql://postgres:changeme@localhost:5432/postgres')

files_and_tables = [
    ('datasets/AdventureWorks_Customers.csv', 'customers'),
    ('datasets/AdventureWorks_Product_Categories.csv', 'products_categories'),
    ('datasets/AdventureWorks_Product_Subcategories.csv', 'products_sub_categories'),
    ('datasets/AdventureWorks_Products.csv', 'products'),
    ('datasets/AdventureWorks_Returns.csv', 'returns'),
    ('datasets/AdventureWorks_Sales.csv', 'sales'),
    ('datasets/AdventureWorks_Territories.csv', 'territories')
]

for file, table in files_and_tables:
    df = pd.read_csv(file, encoding='ISO-8859-1') 
    df.columns = df.columns.str.lower()
    df.to_sql(table, engine, if_exists='replace', index=False)
    print(f"Dados de {file} carregados na tabela {table}.")
