/*
Cliente (idCliente, nombre, apellido, DNI, telefono, direccion)
Factura (nroTicket, total, fecha, hora, idCliente (fk))
Detalle (nroTicket (fk), idProducto (fk), cantidad, preciounitario)
Producto (idProducto, nombreP, descripcion, precio, stock)
*/

/*
  1. Listar datos personales de clientes cuyo apellido comience con el string ‘Pe’. Ordenar por DNI
*/

select c.nombre, c.apellido, c.dni , c.telefono, c.direccion
from cliente c  
where( c.nombre like 'Pe%')
order by dni, nombre, apellido, telefono, direccion


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


select p.nombre, p.descripcion , p.precio , p.stock
from cliente c natural join factura f natural join detalle d natural join producto p 
where  ( f.idCliente ='45789456' and c.apellido <> 'Garcia')

/*
 4. Listar nombre, descripción, precio y stock de productos no vendidos a clientes que tengan
 teléfono con característica 221 (la característica está al comienzo del teléfono). Ordenar por
 nombre.
*/

select p.nombre, p.descripcion , p.precio , p.stock
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