-- ══════════════════════════════════════════
-- MiniStore — Soluciones con Outer JOINs
-- Autor: Lucia Ramos
-- Fecha: 30-09-2026
-- ══════════════════════════════════════════

	USE ministore_schema

-- ── CONSULTA 1: LEFT JOIN ─────────────────
-- Pregunta de negocio: ¿Qué productos del catálogo nunca fueron vendidos?
-- Mostrá todos los productos y sus ventas asociadas.
-- Los productos sin ventas aparecerán con NULL en las columnas de ventas.

	SELECT		p.producto_id,
				p.nombre,
				p.categoria,
				p.precio,
				v.cantidad,
				v.fecha_venta,
				(v.cantidad * p.precio) AS total
	FROM		productos AS p
	LEFT JOIN	ventas AS v ON p.producto_id = v.producto_id
	WHERE		v.venta_id IS NULL
	ORDER BY	p.producto_id;

-- ── CONSULTA 2: RIGHT JOIN ────────────────
-- Pregunta de negocio: ¿Existen ventas registradas con productos
-- que no figuran en nuestro catálogo? (posible error de carga de datos)
-- Los registros huérfanos aparecerán con NULL en las columnas de productos.

	SELECT		p.nombre,
				p.categoria,
				p.precio,
				v.venta_id,
				v.producto_id,
				v.cantidad,
				v.fecha_venta,
				(v.cantidad * p.precio) AS total
	FROM		productos AS p
	RIGHT JOIN	ventas AS v ON p.producto_id = v.producto_id
	WHERE		p.producto_id IS NULL
	ORDER BY	v.producto_id;

-- ── CONSULTA 3: FULL OUTER JOIN ───────────
-- Pregunta de negocio: Vista completa de auditoría que muestre
-- todos los productos y todas las ventas sin perder ninguna fila,
-- identificando tanto productos sin ventas como ventas sin producto.

	SELECT		p.producto_id,
				p.nombre,
				p.categoria,
				p.precio,
				v.venta_id,
				v.cantidad,
				v.fecha_venta,
				(v.cantidad * p.precio) AS total
	FROM		productos AS p
	FULL		OUTER JOIN ventas AS v ON p.producto_id = v.producto_id
	WHERE		p.producto_id IS NULL
	OR			v.venta_id IS NULL
	ORDER BY	p.producto_id;
