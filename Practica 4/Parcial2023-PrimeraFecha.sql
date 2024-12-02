/*

Cliente=(NROCLIENTE,apellido,nombre,domicilio,tel)              
Articulos=(CODARTICULO,tipo,descripcion,cantExist,precio)    
Pedidos=(NROPEDIDO,fechaPedido,fechaEnvio,nrocliente(fk))                  
PedidoArticulo=(NROPEDIDO(FK),CODARTICULO(FK),cantPedido)       
Remito=(NROREMITO(FK),fechaRemito,nroPedido(fk))                
RemitoArticulo=(NROREMITO(FK,CODIGOARTICULO(FK),cantRemito,precioVenta))   
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
Listar apellido,nombre,domicilio y telefono de cliente mas numero de pedido, fecha de envio y numero de
remito, correspondiente a remitos con fecha 7-11-23.
*/


select c.apellido, c.nombre, c.domicilio, c.tel, p.fechaEnvio, r.NROREMITO
from cliente c inner join pedidos p on (c.nrocliente = p.nrocliente) 
inner join remito r on (p.NROREMITO = r.NROREMITO)
where r.fechaRemito = '23-11-7'


/*
Listar apellido , nombre, y telefono de clientes junto con el codigo, descripcion, y cantidades pedidas y remitida de articulo
para los articulos cuya cantidad remitida sea menor a la cantidad pedida. en sql ordenar por apellido y nombre de cliente y cod de articulo
*/


select c.apellido, c.nombre, c.tel, a.CODARTICULO, a.descripcion, pa.cantPedido, ar.cantRemito
from cliente c inner join pedidos p on (c.NROCLIENTE = p.nrocliente)
inner join PedidoArticulo pa on (p.nroPedido =  pa.nroPedido)
inner join articulos a on (pa.CODARTICULO = a.CODARTICULO)
inner join remito r on (r.NROPEDIDO = pa.nroPedido)
inner join remitoArticulo ra on (r.NROREMITO = ra.NROREMITO)
where ra.cantRemito < pa.cantPedido
order by c.apellido, c.nombre, CODARTICULO

/*
Listar apellido,nombre de cliente y numero de pedido para los pedidos que tengan mas de un remito
*/

select c.apellido, c.nombre, p.nroPedido
from cliente c inner join pedido p on (c.nrocliente = p.nrocliente)
inner join remito r on (r.nroPedido = p.nroPedido)
group by p.nroPedido, c.apellido, c.nombre
having count(r.nroRemito) > 1 

/*
Listar numero de pedido junto con la cantidad de articulos distintos remitidos y el monto total
del pedido para los pedidos de octubre de 2023
*/

/*
Listar numero de pedido junto con la cantidad de articulos distintos remitidos y el monto total
del pedido para los pedidos de octubre de 2023
*/

select p.nroPedido, count(distinct ra.CODARTICULO) as cantidad, sum(ra.precioVenta * ra.cantRemito)
from pedidos p inner join remito r  on (p.nroPedido = r.nroPedido)
inner join remitoArticulo ra  on (r.nroRemito = ra.nroRemito)
where p.fechaPedido between '2023-10-1' and '2023-10-31'
group by p.nroPedido


