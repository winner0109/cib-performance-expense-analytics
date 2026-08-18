# SQL Analysis

The SQL files use DuckDB-compatible SQL and read the CSV files under `data/csv/`.

From the repository root:

```bash
duckdb cib_analytics.duckdb < sql/00_setup_duckdb.sql
duckdb cib_analytics.duckdb < sql/01_revenue_variance.sql
```

The analytical queries mirror the four Power BI pages:

1. Revenue variance
2. Client and product economics
3. Expense recovery
4. Data-quality exceptions
