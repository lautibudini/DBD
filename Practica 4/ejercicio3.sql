/*
 Banda = (codigoB, nombreBanda, genero_musical, año_creacion)
 Integrante = (DNI, nombre, apellido, dirección, email, fecha_nacimiento, codigoB(fk))
 Escenario = (nroEscenario, nombre_escenario, ubicación, cubierto, m2, descripción)
 Recital = (fecha, hora, nroEscenario (fk), codigoB (fk))
*/

/*
1. Listar DNI, nombre, apellido,dirección y email de integrantes nacidos entre 1980 y 1990 y que
 hayan realizado algún recital durante 2023.
*/

select dni , nombre, apellido, direccion, email
from integrante
where ( fecha_nacimiento between '1980-01-01' and '1990-12-31')  and codigoB in (

select distinct r.codigoB
from integrante i natural join recital r
where year(r.fecha) = 2023 
)

/*
 2. Reportar nombre, género musical y año de creación de bandas que hayan realizado recitales
 durante 2023, pero no hayan tocado durante 2022 .
*/

select nombreBanda , genero_musical, año_creacion
from Banda b natural join recital r
where (year(r.fecha) = 2023) and not in (

select nombreBanda , genero_musical, año_creacion
from Banda b natural join recital r
where year(r.fecha) = 2022
)



/*
3. Listar el cronograma de recitales del día 04/12/2023. Se deberá listar nombre de la banda que
 ejecutará el recital, fecha, hora, y el nombre y ubicación del escenario correspondiente.
*/
select b.nombreBanda, r.fecha, r.hora , e.nombre_escenario, e.ubicación
from recital r natural join escenario e natural join banda b 
where r.fecha = 04/12/2023 --> o sino '2023-12-04'


/*
 4. Listar DNI, nombre, apellido,email de integrantes que hayan tocado en el escenario con nombre
 ‘Gustavo Cerati’ y en el escenario con nombre ‘Carlos Gardel’.
*/
-- Otra opcion es hacerlo con Intersect (Sin distinct).

select distinct dni, nombre, apellido, email
from recital r natural join escenario e natural join integrante i 
where e.nombre_escenario = 'Gustavo Cerati' and dni in (      
    select i.dni 
    from recital r natural join escenario e natural join integrante i 
    where e.nombre_escenario = 'Carlos Gardel'
)


/*
 5. Reportar nombre, género musical y año de creación de bandas que tengan más de 8 integrantes.
*/

select b.nombre, b.genero_musical, b.año_creacion
from banda b natural join integrante i 
group by b.codigoB -- no agrupar por dni, ya que separa a los integrantes
having count(i.dni) > 8 

/*
 6. Listar nombre de escenario, ubicación y descripción de escenarios que solo tuvieron recitales
 con el género musical rock and roll. Ordenar por nombre de escenario
*/

select distinct e.nombre_escenario, e.ubicación, e.descripción
from recital r natural join escenario e natural join banda b 
where b.genero_musical = 'Rock and Roll' and e.nroEscenario not in (
    select  e.nroEscenario
    from recital r natural join escenario e natural join banda b 
    where b.genero_musical <> 'Rock and Roll'
)
order by e.nombre_escenario, e.ubicación, e.descripción


/*
 7. Listar nombre, género musical y año de creación de bandas que hayan realizado recitales en
 escenarios cubiertos durante 2023.// cubierto es true, false según corresponda
*/

select distinct b.nombre, b.genero_musical, b.año_creacion
from recital r natural join escenario e natural join banda b
where YEAR(r.fecha )= 2023 and e.cubierto = true


/*
8. Reportar para cada escenario, nombre del escenario y cantidad de recitales durante 2024
*/

select e.nombre_escenario, count(*) as cantidad_de_recitales_2024
from recital r natural join escenario e
where YEAR(r.fecha) = 2024 --Antes de hacer agrupar filtro
group by nroEscenario


/*
9. Modificar el nombre de la banda ‘Mempis la Blusera’ a: ‘Memphis la Blusera’.
*/

update banda
set nombreBanda = ‘Memphis la Blusera’
where nombreBanda = ‘Mempis la Blusera’