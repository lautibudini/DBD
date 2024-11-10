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

select p.dni, p.nombre , p.apellido , p.edad, count(distinct pais.CODIGO-PAIS) as cantidad
from Persona p natural join Visita v natural join Ciudad c  
group by p.DNI, p.nombre , p.apellido , p.edad
having count(distinct pais.CODIGO-PAIS) > 10 

/* --CONSULTAR 
Eliminar el pais con codigo 2398
*/

delete from Visita
where CODIGO-CIUDAD in (
    select CODIGO-CIUDAD
    from Ciudad
    where CODIGO-PAIS = 2398
)

delete from Ciudad 
where CODIGO-PAIS = 2398

delete from Pais
where CODIGO-PAIS = 2398


/* --CONSULTAR
Mostrar todos los datos de las personas que hayan conocido todas las ciudades
*/

/*
1. Personas (primera tabla)
2. Ciudadades (tabla donde quiero encontrar todo)
3. Viaje (tabla que matcchea con las 2 anteriores)
*/



SELECT p.dni, p.nombre, p.apellido, p.edad
FROM Persona p NATURAL JOIN Visita v NATURAL JOIN Ciudad c 
GROUP BY p.dni, p.nombre, p.apellido, p.edad
HAVING COUNT(DISTINCT c.CODIGO-CIUDAD) = (
    SELECT COUNT(*) 
    FROM Ciudad)


--Soluciones posibles ejemplos :

SELECT p.dni, p.nombre, p.apellido, p.edad
FROM Persona p
WHERE NOT EXISTS (
    SELECT *
    FROM Ciudad c
    where NOT EXISTS (
        SELECT *
        FROM Viaje v
        WHERE p.dni=v.dni AND v.CODIGO-CIUDAD=c.CODIGO-CIUDAD
    )
)



SELECT p.dni, p.nombre, p.apellido, p.edad 
FROM Persona p
WHERE NOT EXISTS (SELECT c.codigo-ciudad 
                    FROM Ciudad c 
                    WHERE NOT EXISTS(
                        SELECT v.codigo-ciudad FROM Visita WHERE v.dni == p.dni and v.codigo-ciudad == c.codigo-ciudad
                    ))




-- Personas que visitaron todas las ciudades

/*
pepe la plata v1
*/
SELECT p.dni, p.nombre, p.apellido, p.edad
FROM Persona p
WHERE NOT EXISTS (
    SELECT Codigo-ciudad
    FROM Ciudad c
    except (
        SELECT codigo-ciudad
        FROM Viaje v
        WHERE p.dni=v.dni
    )
)


/* --CONSULTAR
Mostrar todos los datos de las personas que hayan visitado solo Argentina en el año 2023.
--en 2023 unico lugar q visito Argentina?
*/ --CAMBIAR A UN NOT IN 
select distinct p.dni, p.nombre , p.apellido , p.edad
from  Persona p natural join Visita v natural join Ciudad c natural join Pais pais
where pais.nombre = 'Argentina' and (year(v.fecha) = 2023) 
except
select distinct p2.dni, p2.nombre , p2.apellido , p2.edad
from  Persona p2 natural join Visita v2 natural join Ciudad c2 natural join Pais pais2
where (pais2.nombre <> 'Argentina') and (year(v2.fecha) = 2023) 


/*
Actualizar la cantidad de habitantes de la ciudad con codigo 5432. La nueva
cantidad de habitantes es 23.456.789
*/

update Ciudad
set cant-habitantes = 23.256.789
where CODIGO-CIUDAD = 5432
