with vendas_total as (
	select 
		ROUND(SUM(s.orderquantity * p.productprice)::NUMERIC, 2) as total_vendas_valor_monetario,
		t.region
	from 
		sales s
	inner join
		products p 
	on 
		p.productkey = s.productkey
	inner join
		customers c
	on
		c.customerkey = s.customerkey
	inner join 
		territories t
	on
		t.salesterritorykey = s.territorykey
	where 
		c.totalchildren > 2
	group by 
		t.region
	order by 
		total_vendas_valor_monetario desc
)	
SELECT 
    total_vendas_valor_monetario,
	region
FROM 
    vendas_total

-- Numero 2 
    
with porcentagem_devolucao as (
	select
		SUM(returnquantity) as totalreturns,
		r.productkey,
		SUM(orderquantity) as totalorders
	from
		returns r
	inner join
		sales s
	on
		r.productkey = s.productkey
	group by 
		r.productkey
	order by 
		totalreturns desc 
	limit 5
)
select
	productkey,
	totalreturns,
	totalorders,
	ROUND((totalreturns * 1.0 / totalorders) * 100, 2) AS returnpercentage
from porcentagem_devolucao

 -- Numero 3

with media_anual as (	
	select
		AVG(cast(REPLACE(REPLACE(c.annualincome, '$', ''), ',', '') AS NUMERIC)) AS avgincome
	from 
		customers c
	inner join
		sales s
	on 
		c.customerkey = s.customerkey
	inner join
		products p 
	on 
		s.productkey  = p.productkey 
	inner join
		products_sub_categories psc 
	on 
		p.productsubcategorykey = psc.productsubcategorykey
	inner join
		products_categories pc 
	on 
		psc.productcategorykey = pc.productcategorykey
	where 
		pc.categoryname = 'Clothing'
	and
		c.homeowner = 'Y'
)
select
	avgincome
from media_anual

-- Numero 4 

with mais_vendidos_mulheres as (	
	select 
		sum(orderquantity) as total_vendidos,
		s.productkey
	from
		sales s
	inner join
		customers c
	on	
		s.customerkey = c.customerkey
	inner join 
		products p
	on
		s.productkey  = p.productkey 
	inner join 
		territories t 
	on
		s.territorykey = t.salesterritorykey
	where 
		gender = 'F'
	and
		continent = 'Europe'
	group by s.productkey
	order by total_vendidos desc
	limit 3
)
select
	productkey,
	total_vendidos
from
	mais_vendidos_mulheres
	
-- Numero 5 

with retornos_mes as (
 	select 
 		EXTRACT(month FROM CAST(returndate AS DATE)) as mes,
 		count(returnquantity) as retornos
 	from
 		returns
 	where 
 		EXTRACT(YEAR FROM CAST(returndate AS DATE)) = '2015'
 	group by mes	
)
select 
	mes,
	retornos
from retornos_mes

-- Numero 6 
		
with compras_territorio as (
	select 
		customerkey,
		count(distinct territorykey) as territorios_distintos
	from 
		sales
	group by 
		customerkey
	HAVING 
        COUNT(DISTINCT TerritoryKey) > 1
)
select 
	customerkey,
	territorios_distintos
from
	compras_territorio
	
-- Numero 7
	
with maior_custo as (
	select 
		cast(REPLACE(REPLACE(c.annualincome, '$', ''), ',', '') AS NUMERIC) AS annualincome,
		c.educationlevel,
		c.firstname,
		c.lastname,
		p.productcost,
		p.productname
	from 
		customers c 
 	inner join
 		sales s
 	on
 		c.customerkey = s.customerkey 
 	inner join 
		products p 
	on
 		s.productkey = p.productkey 
 	where 
 		educationlevel = 'Bachelors'
 	and 
 		cast(REPLACE(REPLACE(c.annualincome, '$', ''), ',', '') AS NUMERIC) > 70000
 	order by productcost desc 
)

select
	firstname,
	lastname,
	productname,
	productcost
from
	maior_custo
	
-- Numero 8 
	
with solteiros_com_bike as (
	
	select
		COUNT(DISTINCT c.CustomerKey) AS totalsolteirosmountainbikes
	from customers c
	inner join
		sales s 
	on 
		c.customerkey = s.customerkey
	inner join 
		products p
	on
		s.productkey = p.productkey
	inner join 
		products_sub_categories psc 
	on 
		p.productsubcategorykey = psc.productsubcategorykey
	where 
		c.maritalstatus = 'S'
	and 
		psc.subcategoryname = 'Mountain Bikes'
),
totalclientes AS (
    SELECT 
        COUNT(DISTINCT CustomerKey) AS totalclientes
    FROM 
        Customers
)
select 
	scb.totalsolteirosmountainbikes,
	tc.totalclientes,
	(scb.TotalSolteirosMountainBikes::numeric / tc.TotalClientes) * 100 AS Porcentagem
from
	solteiros_com_bike scb,
	totalclientes tc

-- Numero 9
	
	
with produtos_devolvidos as (
	select 
		p.productkey,
        p.productname,
        p.productprice,
		sum(r.returnquantity) as totalreturns
	from
		returns r
	inner join
		products p 
	on
		r.productkey = p.productkey
	group by 
		p.productkey, p.productname, p.productprice 
	having
		sum(r.returnquantity) > 1
	order by 
		productprice asc
	limit 3
)
select 
	productname,
	productprice,
	totalreturns
from produtos_devolvidos

-- Numero 10
	
with dif_media as (
	select
		s.productkey,
		p.productname,
		ROUND(AVG(ProductPrice - ProductCost)::NUMERIC, 2) AS media_diferenca_arredondada
	from
		sales s
	inner join
		products p
	on 
		s.productkey  = p.productkey
	inner join
		customers c
	on
		s.customerkey = c.customerkey 
	where 
		c.totalchildren > 3
	group by s.productkey, p.productname
	order by productkey asc
)
select
	productkey,
	productname,
	media_diferenca_arredondada
from
	dif_media

	
	

