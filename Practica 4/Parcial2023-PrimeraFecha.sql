/*

Cliente=(NROCLIENTE,apellido,nombre,domicilio,tel)            -  
Articulos=(CODARTICULO,tipo,descripcion,cantExist,precio)     
Pedidos=(NROPEDIDO,fechaPedido,fechaEnvio,nrocliente(fk))     -
PedidoArticulo=(NROPEDIDO(FK),CODARTICULO(FK),cantPedido)      
Remito=(NROREMITO(FK),fechaRemito,nroPedido(fk))              -   
RemitoArticulo=(NROREMITO(FK,CODIGOARTICULO(FK),cantRemito,precioVenta))   -
*/




/*
Listar numero de pedido, codigo de articulo, cantidad pedida, tipo y descripcion de articulo
para los pedidos con fecha de envio 7-11-23. En sql ordenar por codigo de articulo y numero de pedido.
*/


select p.NROPEDIDO, pa.CODARTICULO, pa.cantPedido,  a.tipo, a.descripcion
from Pedidos p inner join PedidoArticulo pa on (p.NROPEDIDO = pa.NROPEDIDO ) 
inner join articulo a on (pa.CODARTICULO = a.CODARTICULO)
where p.fechaEnvio = '23-11-7'
order by pa.CODARTICULO, pa.CODARTICULO

/*
Listar apellido,nombre,domicilio y telefono de cliente mas numero de pedido, fecha de envio  numero de
remito, correspondiente a remitos con fecha 7-11-23.
*/




/*
Listar apellido , nombre, y telefono de clientes junto con el codigo, descripcion, y cantidades pedidas y remitida de articulo
para los articulos cuya cantidad remitida sea menor a la cantidad pedida. en sql ordenar por apellido y nombre de cliente y cod de articulo
*/


/*
Listar apellido,nombre de cliente y numero de pedido para los pedidos que tengan mas de un remito
*/


/*
Listar numero de pedido junto con la cantidad de articulos distintos remitidos y el monto total
del pedido para los pedidos de octubre de 2023
*/


















/*
Listar numero de pedido, codigo de articulo, cantidad pedida, tipo y descripcion de articulo
para los pedidos con fecha de envio 7-11-23. En sql ordenar por codigo de articulo y numero de pedido.
*/


select p.NROPEDIDO, a.CODARTICULO, pa.cantPedido, a.tipo, a.descripcion 
from Articulo a natural join Pedidos p natural join PedidoArticulo pa  
where p.fechaEnvio = 7-11-23.
order by a.CODARTICULO, p.nroPedido


/*
Listar apellido,nombre,domicilio y telefono de cliente mas numero de pedido, fecha de envio  numero de
remito, correspondiente a remitos con fecha 7-11-23.
*/

select c.apellido, c.nombre, c.domicilio, c.tel, p.NROPEDIDO, p.fechaEnvio, r.NROREMITO
from Cliente c natural join Pedidos p natural join Remito r
where r.fechaRemito = 7-11-23





/*
Listar apellido , nombre, y telefono de clientes junto con el codigo, descripcion, y cantidades pedidas y remitida de articulo
para los articulos cuya cantidad remitida sea menor a la cantidad pedida. en sql ordenar por apellido y nombre de cliente y cod de articulo
*/
-- No queda otra que relacionar las 5 tablas. --CONSULTAR

select c.apellido, c.nombre, c.tel, a.CODARTICULO, a.descripcion, pa.cantPedido, ra.cantRemito
from Pedidos p natural join PedidoArticulo pa natural join Remito r natural join RemitoArticulo ra natural join cliente
where ra.cantRemito < pa.cantPedido
order by c.apellido,c.nombre, a.CODARTICULO


/*
Listar apellido,nombre de cliente y numero de pedido para los pedidos que tengan mas de un remito
*/ --CONSULTAR

select c.apellido, c.nombre, p.nroPedido
from Cliente natural join Pedidos p natural join Remito r  
group by p.nroPedido,  c.apellido, c.nombre
having count(distinct r.NROREMITO ) > 1


/*
Listar numero de pedido junto con la cantidad de articulos distintos remitidos y el monto total
del pedido para los pedidos de octubre de 2023
*/ -- CONSULTAR

select p.nroPedido , count(distinct pa.CODARTICULO) as cant , sum(ra.precioVenta * ra.cantRemito) as montoTotal
from Pedidos p natural join PedidoArticulo pa natural join Remito r natural join RemitoArticulo ra
where ( p.fechaPedido between '01-10-2023' and '31-10-2023') 
group by  nroPedido 
