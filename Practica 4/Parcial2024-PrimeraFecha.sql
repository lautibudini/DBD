/*

Cliente =(idCliente-, nombre, apellido, dni, telefono, direccion)
Venta=(nroVenta- , total, fecha, hora, idCliente(fk))
DetalleVenta =(nroVenta(fk)-, idLibro(fk)-,cantidad, precioUnitario)
Libro=(idLibro-, titulo, autor, precio, stock)

*/


-- Listar todos los libros cuyo  precio es mayor a 2300

select titulo, autor, precio , stock
from libro
where precio > 2300

-- Listar todas las ventas realizadas en agosto de 2023

select nroVenta, total, fecha, hora
from venta
where fecha between '2023-08-01' and '2023-08-31' 


-- Listar nombre, apellido, dni, telefono, direccion de clientes que realizaron compras solo en el 2022

select c.nombre, c.apellido, c.dni, c.telefono, c.direccion
from cliente c inner join venta v on (c.idCliente = v.idCliente)
where year(fecha) = '2022' and c.idCliente not in (
    select idCliente
    from venta
    where year(fecha) <> '2022'
)

-- Listar para cada libro el titulo, autor, precio y la cantidad total de veces que fue vendido. Tener en cuenta que
-- Puede haber libros que no se vendieron.

select l.titulo, l.autor, l.precio , sum(d.cantidad) as cantVendido
from libro l left join DetalleVenta d on (l.idLibro = d.idLibro)
group by titulo, autor , precio

-- Listar nroVenta, total, fecha, hora, dni de aquellas ventas donde se haya vendido al menos un libro con precio > 1000

select distinct v.nroVenta, v.total, v.fecha , v.hora , c.dni 
from venta v inner join DetalleVenta d on (v.nroVenta = d.nroVenta) 
inner join cliente c on (v.idCliente = c.idCliente)
wehre d.precioUnitario > 1000
