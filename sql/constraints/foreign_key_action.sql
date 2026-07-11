-- Foreign Key Action 
-- customer id column 
ALTER TABLE operations.orders
ADD CONSTRAINT fk_orders_customer_delete
FOREIGN KEY (customer_id) REFERENCES operations.customers (customer_id) ON DELETE SET NULL;

-- drug id COLUMN
ALTER TABLE operations.orders
ADD CONSTRAINT fk_orders_drug_delete
FOREIGN KEY (drug_id) REFERENCES inventory.drugs (drug_id) ON DELETE SET NULL;

-- employees: attendant_id, prescribed_by, paid_to, dispatched_by
ALTER TABLE operations.orders
ADD CONSTRAINT fk_orders_attendant_emp_delete
FOREIGN KEY (attendant_id) REFERENCES operations.employees (employee_id) ON DELETE SET NULL;

ALTER TABLE operations.orders
ADD CONSTRAINT fk_orders_prescribed_emp_delete
FOREIGN KEY (prescribed_by) REFERENCES operations.employees (employee_id) ON DELETE SET NULL;

ALTER TABLE operations.orders
ADD CONSTRAINT fk_orders_paid_to_emp_delete
FOREIGN KEY (paid_to) REFERENCES operations.employees (employee_id) ON DELETE SET NULL;

ALTER TABLE operations.orders
ADD CONSTRAINT fk_orders_dispatched_by_emp_delete
FOREIGN KEY (dispatched_by) REFERENCES operations.employees (employee_id) ON DELETE SET NULL;


-- Inventory.stock dependency
ALTER TABLE inventory.stock
ADD CONSTRAINT fk_stock_drug
FOREIGN KEY (drug_id) REFERENCES inventory.drugs(drug_id)
ON DELETE CASCADE;

-- Inventory.suppliers dependency
ALTER TABLE inventory.suppliers
ADD CONSTRAINT fk_suppliers_drug
FOREIGN KEY (drug_id) REFERENCES inventory.drugs(drug_id)
ON DELETE CASCADE;