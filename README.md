¿Por qué usaste LEFT JOIN para la Consulta 1 y no INNER JOIN? ¿Qué se perdería si usaras INNER JOIN?
Porque la pregunta es qué productos nunca se vendieron, y esos productos, por definición, no tienen ninguna fila en ventas.
El LEFT JOIN conserva todos los productos (tabla izquierda) y completa con NULL las columnas de ventas cuando no hay coincidencia.

¿Por qué usaste RIGHT JOIN para la Consulta 2? ¿Qué tabla está a la izquierda y cuál a la derecha en tu consulta?
La pregunta es si hay ventas cuyo producto no está en el catálogo, así que la tabla que hay que conservar completa es ventas.
El RIGHT JOIN conserva todas las filas de la tabla derecha (ventas). Si una venta apunta a un producto que no existe, las columnas de productos quedan en NULL.

¿Qué representan los valores NULL en cada resultado? Explicá con un ejemplo concreto de los datos qué significa que venta_id sea NULL en la Consulta 1 y que producto_id de productos sea NULL en la Consulta 2.
Un NULL no es cero ni vacío: significa "no hay dato correspondiente en la otra tabla".
Consulta 1, v.venta_id es NULL: por ejemplo, en la fila del producto 108. Significa que ese producto existe en el catálogo pero no tiene ninguna venta registrada. El JOIN no encontró ninguna fila en ventas con producto_id = 108, por eso todas las columnas de ventas (venta_id, cantidad, fecha_venta) salen NULL.
Consulta 2, p.producto_id es NULL: por ejemplo, en la venta 10, que registra el producto 999. Significa que esa venta hace referencia a un producto que no existe en el catálogo. El JOIN no encontró ningún producto con producto_id = 999, así que todas las columnas de productos salen NULL. Probablemente sea un error de carga de datos.

¿Cuándo usarías FULL OUTER JOIN en un caso real de negocio?
Cuando necesitás auditar o reconciliar dos fuentes de datos y querés ver las diferencias de ambos lados en una sola consulta, sin perder nada.
Ejemplos reales:
Conciliación de inventario: comparar el stock del sistema contra el conteo físico del depósito. Aparecen productos que están en el sistema pero no en el depósito, y viceversa.
Conciliación bancaria: comparar los movimientos del banco con los registros contables, para detectar pagos sin registrar y registros sin pago.
Migración de datos: comparar la base vieja con la nueva para ver qué registros faltan en cada una.
En este ejercicio, el FULL OUTER JOIN permite ver en una sola pasada los productos sin ventas (108 y 109) y las ventas sin producto (venta 10), que con LEFT o RIGHT por separado requerirían dos consultas.
