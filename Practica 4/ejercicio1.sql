/*
Cliente (idCliente, nombre, apellido, DNI, telefono, direccion)
Factura (nroTicket, total, fecha, hora, idCliente (fk))
Detalle (nroTicket (fk), idProducto (fk), cantidad, preciounitario)
Producto (idProducto, nombreP, descripcion, precio, stock)
*/

/*
  1. Listar datos personales de clientes cuyo apellido comience con el string ‘Pe’. Ordenar por DNI
*/

select distinct c.nombre, c.apellido, c.dni , c.telefono, c.direccion
from cliente c  
where( c.nombre like 'Pe%')
order by c.dni, c.nombre, c.apellido


/*
   2. Listar nombre, apellido, DNI, teléfono y dirección de clientes que realizaron compras solamente
 durante 2017.
*/

select  c.nombre, c.apellido, c.dni , c.telefono, c.direccion
from cliente c natural join factura f 
where ( f.fecha between '2017-01-01' and '2017-12-31' )
except 
select  c.nombre, c.apellido, c.dni , c.telefono, c.direccion
from cliente c natural join factura f 
where ( f.fecha < '2017-01-01' and f.fecha > '2017-12-31' )

/*
   3. Listar nombre, descripción, precio y stock de productos vendidos al cliente con DNI 45789456,
 pero que no fueron vendidos a clientes de apellido ‘Garcia’.
*/


select distinct p.nombre, p.descripcion , p.precio , p.stock
from cliente c natural join factura f natural join detalle d natural join producto p 
where  ( f.idCliente ='45789456' and c.apellido <> 'Garcia')

/*
 4. Listar nombre, descripción, precio y stock de productos no vendidos a clientes que tengan
 teléfono con característica 221 (la característica está al comienzo del teléfono). Ordenar por
 nombre.
*/ de producto.

select distinct p.nombre, p.descripcion , p.precio , p.stock
from producto p 
where p.idProducto not in (select p.idProducto
                           from cliente c natural join factura f natural join  detalle d natural join  producto p
                           where (c.telefono like '221%'))
order by p.nombre, p.descripcion, p.precio , p.stock

-- En el order by tengo que poner todos ? o solo por el que quiero que ordene


/*   CONSULTAR
 5. Listar para cada producto nombre, descripción, precio y cuantas veces fue vendido. Tenga en
 cuenta que puede no haberse vendido nunca el producto
*/


select p.nombre, p.descripcion , p.precio , sum(d.cantidad) as vecesVendidio
from producto p left join detalle d on p.idProducto= d.idProducto
group by p.idProducto , p.nombre, p.precio , p.vecesVendidio 
--having vecesVendidio > 0 no se que hacer con los que queden en null , los reemplazo ?


/*
 6. Listar nombre, apellido, DNI, teléfono y dirección de clientes que compraron los productos con
 nombre ‘prod1’ y ‘prod2’ pero nunca compraron el producto con nombre ‘prod3’.
*/

select c.nombre , c.apellido , c.dni, c.telefono , c.direccion
from cliente c natural join factura f natural join detalle d natural join producto p 
where p.nombre in ('prod1','prod2') --Aca puede pasar q solo compre uno o el otro.
except
select c.nombre , c.apellido , c.dni, c.telefono , c.direccion
from cliente c natural join factura f natural join detalle d natural join producto p 
where (p.nombre = 'prod3')

/*
 7. Listar nroTicket, total, fecha, hora y DNI del cliente, de aquellas facturas donde se haya
 comprado el producto ‘prod38’ o la factura tenga fecha de 2019.
*/

select f.nroTicket , f.total , f.fecha , f.hora , c.dni
from cliente c natural join factura f natural join detalle d natural join producto p 
where (p.nombreP = 'prod38' or  f.fecha LIKE '2019-%' ) -- siendo el formato 'año-mes-dia'


/*
 8. Agregar un cliente con los siguientes datos: nombre:’Jorge Luis’, apellido:’Castor’, DNI:
 40578999, teléfono: ‘221-4400789’, dirección:’11 entre 500 y 501 nro:2587’ y el id de cliente:
 500002. Se supone que el idCliente 500002 no existe
*/

insert into cliente (idCliente, nombre, apellido, DNI, telefono, direccion) 
values ('500002','Jorge Luis','Castor','40578999','221-4400789','11 entre 500 y 501 nro:2587')

/*
9. Listar nroTicket, total, fecha, hora para las facturas del cliente ´Jorge Pérez´ donde no haya
 comprado el producto ´Z´
*/

select f.nroTicket, f.total, f.fecha, f.hora
from cliente c natural join factura f natural join detalle d natural join producto p 
where ( c.nombre = 'Jorge' and c.apellido = 'Perez' and p.nombreP <> 'Z' )

/*
10. Listar DNI, apellido y nombre de clientes donde el monto total comprado, teniendo en cuenta
 todas sus facturas, supere $10.000.000.
*/

select c.dni, c.apellido, c.nombre 
from cliente c natural join factura f
group by c.dni , c.apellido , c.nombre 
having sum(f.total) > '10.000.000'





where 
group by 
having 