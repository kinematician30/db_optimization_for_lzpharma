-- Index all the foreign keys in the orders TABLE
CREATE INDEX idx_orders_customer_id ON operations.orders (customer_id);
CREATE INDEX idx_order_drugs_id ON operations.orders (drug_id);
CREATE INDEX idx_order_attendant_emp ON operations.orders(attendant_id);
CREATE INDEX idx_order_paid_emp ON operations.orders(paid_to);
CREATE INDEX idx_order_dispatched_emp ON operations.orders(dispatched_by);
CREATE INDEX idx_order_prescribe_emp ON operations.orders(prescribed_by);

-- Index all foreign keys in each tables
CREATE INDEX idx_stocks_drugs ON inventory.stock(drug_id);
CREATE INDEX idx_suppliers_drugs ON inventory.suppliers(drug_id);

