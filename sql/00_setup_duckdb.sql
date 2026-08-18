-- Run from the repository root.
-- Creates local DuckDB tables from the synthetic CSV files.

CREATE OR REPLACE TABLE fact_performance AS
SELECT *
FROM read_csv_auto(
    'data/csv/fact_performance.csv',
    header = true,
    dateformat = '%Y-%m-%d'
);

CREATE OR REPLACE TABLE fact_expense_recovery AS
SELECT *
FROM read_csv_auto(
    'data/csv/fact_expense_recovery.csv',
    header = true,
    dateformat = '%Y-%m-%d'
);

CREATE OR REPLACE TABLE fact_dq_log AS
SELECT *
FROM read_csv_auto(
    'data/csv/fact_dq_log.csv',
    header = true,
    dateformat = '%Y-%m-%d'
);

CREATE OR REPLACE TABLE dim_date AS
SELECT *
FROM read_csv_auto(
    'data/csv/dim_date.csv',
    header = true,
    dateformat = '%Y-%m-%d'
);

CREATE OR REPLACE TABLE dim_client AS
SELECT * FROM read_csv_auto('data/csv/dim_client.csv', header = true);

CREATE OR REPLACE TABLE dim_product AS
SELECT * FROM read_csv_auto('data/csv/dim_product.csv', header = true);

CREATE OR REPLACE TABLE dim_banker AS
SELECT * FROM read_csv_auto('data/csv/dim_banker.csv', header = true);
