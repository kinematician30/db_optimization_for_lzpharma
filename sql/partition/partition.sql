-- Partitioning is the physical division of a logically massive table into smaller, autonomous, and physically independent sub-tables, which are called partitions. We are gonna be using RANGE PARTITIONING.
-- To partition an existing table, we employ a Table-Swap Migration Workflow.
-- 1. Create a partitioned TABLE
CREATE TABLE operations.orders_part(
	LIKE operations.orders INCLUDING DEFAULTS INCLUDING CONSTRAINTS,
	PRIMARY KEY(order_id, order_datetime)
) PARTITION BY RANGE (order_datetime);

-- 2. Create the PARTITIONS
-- 2021
CREATE TABLE operations.orders_2021 PARTITION OF operations.orders_part FOR VALUES FROM ('2021-01-01') TO ('2022-01-01');

-- 2022
CREATE TABLE operations.orders_2022 PARTITION OF operations.orders_part FOR VALUES FROM ('2022-01-01') TO ('2023-01-01');

--2023
CREATE TABLE operations.orders_2023 PARTITION OF operations.orders_part FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

-- 2024
CREATE TABLE operations.orders_2024 PARTITION OF operations.orders_part FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

--2025
CREATE TABLE operations.orders_2025 PARTITION OF operations.orders_part FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

--2026
CREATE TABLE operations.orders_2026 PARTITION OF operations.orders_part FOR VALUES FROM ('2026-01-01') TO ('2027-01-01');


-- 3. Populate the partitioned table with the existing table's data.
INSERT INTO operations.orders_part
SELECT * FROM operations.orders;

-- 4. Table-Swap - Production Friendly
BEGIN;
	ALTER TABLE operations.orders RENAME TO orders_old;

	ALTER TABLE operations.orders_part RENAME TO orders;
COMMIT;