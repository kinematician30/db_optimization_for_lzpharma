-- Optimization III - Data Governance & Role-Based Access Control!

-- Data Quality Implementation
ALTER TABLE inventory.drugs
ADD CONSTRAINT chk_price_positive CHECK (price > 0);

ALTER TABLE inventory.stock
ADD CONSTRAINT chk_quantity_nonnegative CHECK (quantity >= 0);

-- RBACs
-- Roles are the positions/groups in the DATABASE
-- Users are the people that occupies the ROLE

-- Step 1: Create the Roles
CREATE ROLE data_engineer NOLOGIN;
CREATE ROLE data_analyst NOLOGIN;
CREATE ROLE researcher NOLOGIN;

-- Delete a ROLE
DROP ROLE name_of_role
-- Strip of its permission
DROP OWNED BY name_of_role

-- Step 2: Grant Permisssions and Define actions within the database 
-- For Data Engineer [Full Read/Write Permission on the Inventory and Operation Schema; Read-Only access to the research schema]
GRANT USAGE ON SCHEMA operations, inventory TO data_engineer; -- to see the SCHEMAS
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA operations, inventory TO data_engineer;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA operations, inventory TO data_engineer;

-- Read Only Access to Research
GRANT USAGE ON SCHEMA research TO data_engineer; -- to see the SCHEMAS
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA research TO data_engineer;


-- For Researchers [Full Read/Write Permission on research schema]
GRANT USAGE ON SCHEMA research TO researcher;
GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA research TO researcher;
GRANT USAGE ON ALL SEQUENCES IN SCHEMA research TO researcher;

-- Analyst - [Read-Only access on the Operations and Inventory]
GRANT USAGE ON SCHEMA operations, inventory TO data_analyst;
GRANT SELECT ON ALL TABLES IN SCHEMA operations, inventory TO data_analyst;

-- Revoke access to PII
REVOKE SELECT ON operations.customers FROM data_analyst;

-- Step 3: Create Users & Assign Roles
CREATE USER somto WITH PASSWORD 'SomtoTheDataEngineer!';
CREATE USER osaka WITH PASSWORD 'OsakaTheDataAnalyst!';
CREATE USER toby WITH PASSWORD 'TobyTheResearcher';

-- Assign roles to the users
GRANT data_engineer TO somto;
GRANT data_analyst TO osaka;
GRANT researcher TO toby;




