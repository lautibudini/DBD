/*
 Localidad = (codigoPostal, nombreL, descripcion, #habitantes)
 Arbol = (nroArbol, especie, años, calle, nro, codigoPostal(fk))
 Podador = (DNI, nombre, apellido, telefono, fnac, codigoPostalVive(fk)) -- Aca se equivaron es codigoPostal ?
 Poda = (codPoda, fecha, DNI(fk), nroArbol(fk)
 */

 /*
 1. Listar especie, años, calle, nro y localidad de árboles podados por el podador ‘Juan Perez’ y por
 el podador ‘Jose Garcia’.
 */

 select a.especie, a.años, a.calle, a.nro, a.codigoPostal , l.nombreL
 from Arbol a inner join Podador p on a.codigoPostal = p.codigoPostal inner join Localidad l on l.codigoPostal = p.codigoPostal 
 where ( p.nombre = 'Juan' and p.apellido = 'Perez' )
 intersect
 select a.especie, a.años, a.calle, a.nro, a.codigoPostal , l.nombreL
 from Arbol a inner join Podador p on a.codigoPostal = p.codigoPostal inner join Localidad l on l.codigoPostal = p.codigoPostal 
 where ( p.nombre = 'Jose' and p.apellido = 'Garcia' )

 /*
 2. Reportar DNI, nombre, apellido, fecha de nacimiento y localidad donde viven de aquellos
 podadores que tengan podas realizadas durante 2023
 */

 select distinct dni, nombre , apellido , fnac , nombreL 
 from --inner join de todas las tablas.
 where ( p.fecha like '2023%' )

/*
  3. Listar especie, años, calle, nro y localidad de árboles que no fueron podados nunca
 */

 select distinct especie, años, calle, nroArbol, nombreL
 from -- localidad arbol y poda inner join 
 where a.nroArbol not in (
 
 select distinct especie, años, calle, nroArbol, nombreL
 from -- localidad arbol y poda inner join 
 where (a.nroArbol = p.nroArbol) -- Donde el numero de arbol coincida con una poda

 )

 /*
   4. Reportar especie, años,calle, nro y localidad de árboles que fueron podados durante 2022 y no
   fueron podados durante 2023.
 */ 
 -- Saco los que fueron podados en 2022 y le resto los que fueron podados en 2023

select  especie, años, calle , nro, nombreL
from -- localidad arbol y poda inner join 
where (p.fecha like '2022%') 
except
select  especie, años, calle , nro, nombreL
from -- localidad arbol y poda inner join 
where (p.fecha like '2023%')


/*
   5. Reportar DNI, nombre, apellido, fecha de nacimiento y localidad donde viven de aquellos
 podadores con apellido terminado con el string ‘ata’ y que tengan al menos una poda durante
 2024. Ordenar por apellido y nombre.
 */


select distinct dni, nombre, apellido, fnac, nombreL
from
where (podador.apellido like '%ata') and podador.dni in (

select distinct dni
from poda
where  ( fecha like '2024%')

)
order by  podador.apellido,podador.nombre,podador.dni 


/*
   6. Listar DNI, apellido, nombre, teléfono y fecha de nacimiento de podadores que solo podaron
 árboles de especie ‘Coníferas’.
 */

select distinct dni, apellido, nombre, telefono, fnac
from arbol a inner join poda p ON (p.nroArbol = a.nroArbol) inner join podador (podador.DNI = p.DNI)
where (a.especie = 'Coniferas') and podador.dni not in (

select distinct p.dni
from arbol a natural join poda p 
where (a.especie <> 'Conifera')

)

/*
   7. Listar especies de árboles que se encuentren en la localidad de ‘La Plata’ y también en la
 localidad de ‘Salta’.

 */

 select  a.especie
 from --arbol y localidad
 where (l.nombreL = 'La Plata')
 intersect
 select a.especie
 from --arbol y localidad
 where (l.nombreL = 'Salta')


/*
   8. Eliminar el podador con DNI 22234566.

 */

 delete from podador
 where dni = '22234566'
 --Elimino las podas del podador ?


 /*
   9. Reportar nombre, descripción y cantidad de habitantes de localidades que tengan menos de 100
 árboles.
 */

 select nombre, descripcion, cantidad
 from --localidad y arbol
 group by l.codigoPostal, l.nombreL
 having count(*) < 100

