# 📚 Exercícios de SQL: CTEs
Fala Pessoal! Dessa vez eu separei 10 exercicíos gerados através do DeepSeek para serem resolvidos com queries mais complexas(CTEs), aqui está.

## CREATE_TABLES

#### [create_tables.py](project_queries/create_tables.py)

Este é um script Python simples que utiliza SQLAlchemy para se conectar ao banco de dados. Em seguida, criamos uma lista de tuplas com nossos arquivos CSV e, por fim, iteramos sobre ele para carregar os arquivos no banco como tabelas.


```python
from sqlalchemy import create_engine
import pandas as pd

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
```

## Enunciados

#### 
```
1 - Qual é o total de vendas (em valor monetário) por região, considerando apenas os clientes que possuem mais de 2 filhos?

2 - Quais são os 5 produtos mais devolvidos (em quantidade) e qual é a porcentagem de devolução em relação ao total de vendas desses produtos?

3 - Qual é a média de renda anual (AnnualIncome) dos clientes que compraram produtos da categoria "Clothing" e que são proprietários de casa (HomeOwner = 'Y')?

4 - Quais são os 3 produtos mais vendidos (em quantidade) para clientes do sexo feminino (Gender = 'F') na Europa (Continent = 'Europe')?

5 - Qual é o número total de devoluções por mês no ano de 2015, e qual foi o mês com o maior número de devoluções?

6 - Quais são os clientes que realizaram compras em mais de um território (TerritoryKey), e qual é o número total de territórios distintos em que cada um comprou?

7 - Qual é o produto com o maior custo (ProductCost) que foi vendido para clientes com nível de educação "Bachelors" e que possuem renda anual superior a $70,000?

8 - Qual é a porcentagem de clientes que são solteiros (MaritalStatus = 'S') e que compraram produtos da subcategoria "Mountain Bikes"?

9 - Quais são os 3 produtos com o menor preço (ProductPrice) que foram devolvidos mais de uma vez?

10 - Qual é a diferença média entre o preço de venda (ProductPrice) e o custo (ProductCost) dos produtos vendidos para clientes que têm mais de 3 filhos (TotalChildren > 3)?
```

### Queries Resolvidas

#### Exercício 1
![Exercício_1](prints/Ex1.png)
#### Exercício 2
![Exercício_2](prints/Ex2.png)
#### Exercício 3
![Exercício_3](prints/Ex3.png)
#### Exercício 4
![Exercício_4](prints/Ex4.png)
#### Exercício 5
![Exercício_5](prints/Ex5.png)
#### Exercício 6
![Exercício_6](prints/Ex6.png)
#### Exercício 7
![Exercício_7](prints/Ex7.png)
#### Exercício 8
![Exercício_8](prints/Ex8.png)
#### Exercício 9
![Exercício_9](prints/Ex9.png)
#### Exercício 10
![Exercício_10](prints/Ex10.png)
