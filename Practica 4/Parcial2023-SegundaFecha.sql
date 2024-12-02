/*
Persona=(DNI, nombre, apellido,edad)
Visita=(DNI(FK), CODIGO-CIUDAD(FK),FECHA,motivo)
Ciudad=(CODIGO-CIUDAD,nombre,latitud,longitud,cant-habitantes,CODIGO-PAIS(FK))
Pais=(CODIGO-PAIS, nombre, tiene-salida-mar, anio-independencia)
*/



/*
Mostrar los datos de las personas que hayan conocido mas de 10 paises diferentes junto con la cantidad 
de paises conocidos.
*/


select p.dni, p.nombre, p.apellido, p.edad, count(distinct c.CODIGO-PAIS * ) as cantPaisesConocidos
from persona p inner join visita v on (p.dni = v.dni)
inner join ciudad c on (c.CODIGO-CIUDAD = v.CODIGO-CIUDAD) 
group by p.dni, p.nombre, p.apellido, p.edad
having count(distinct c.CODIGO-PAIS * ) > 10 


/* --CONSULTAR 
Eliminar el pais con codigo 2398
*/

delete from visita 
where CODIGO-CIUDAD in (
    select CODIGO-CIUDAD
    from ciudad 
    where CODIGO-PAIS = '2398'
)

delete from ciudad 
where CODIGO-PAIS = '2398'

delete from pais 
where pais.CODIGO-PAIS = '2398'


/* 
Mostrar todos los datos de las personas que hayan conocido todas las ciudades
*/

select p.dni, p.nombre, p.apellido, p.edad
from persona p 
where not exists(
    select c.CODIGO-CIUDAD
    from ciudad c 
    where not exists(
        select *
        from visita v
        where v.dni = p.dni and c.CODIGO-CIUDAD = v.CODIGO-CIUDAD
    )
)




/* 
Mostrar todos los datos de las personas que hayan visitado solo Argentina en el año 2023.
*/ 

select distinct p.dni, p.nombre, p.apellido , p.edad
from persona p inner join visita v on (p.dni = v.dni)
inner join ciudad c  on (v.CODIGO-CIUDAD = c.CODIGO-CIUDAD)
inner join pais p on (c.CODIGO-PAIS = p.CODIGO-PAIS)
where p.nombre = 'Argentina' and year(v.fecha) = '2023' and p.dni not in (
            select p2.dni
            from persona p2 inner join visita v2 on (p2.dni = v2.dni)
            inner join ciudad c2  on (v2.CODIGO-CIUDAD = c2.CODIGO-CIUDAD)
            inner join pais p2 on (c2.CODIGO-PAIS = p2.CODIGO-PAIS)
            where p2.nombre <> 'Argentina' and year(v.fecha) = '2023'
)



/*
Actualizar la cantidad de habitantes de la ciudad con codigo 5432. La nueva
cantidad de habitantes es 23.456.789
*/


update ciudad 
set cant-habitantes = '23.456.789'
where CODIGO-CIUDAD = '5432'
