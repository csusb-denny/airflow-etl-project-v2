# Airflow ETL: Weather + Finance

This project runs a daily ETL pipeline with Apache Airflow, loading weather (Open-Meteo) and finance (Alpha Vantage) data into Postgres.

## Quick start (Windows + Docker Desktop)

1. Install Docker Desktop.
2. Clone this repo and create `.env` from the sample in the root.
3. Start the stack:

```bash
docker compose up -d postgres
docker compose up db-init
docker compose up airflow-init
docker compose up -d airflow-scheduler airflow-webserver
```

4. Create Tables
   docker compose exec -T postgres psql -U etl -d warehouse < includes/sql/create_tables.sql

5. Open Airflow: localhost:8080 id: admin, pass: admin

---

# How to run (step-by-step)

From your project folder in Git Bash:

```bash
# 0) first time or when in doubt, do a clean reset:
docker compose down -v

# 1) start Postgres
docker compose up -d postgres

# 2) create airflow + warehouse DBs (one-time, handled by this service)
docker compose up db-init

# 3) initialize Airflow metadata + admin user (one-time)
docker compose up airflow-init

# 4) start scheduler and webserver
docker compose up -d airflow-scheduler airflow-webserver

# 5) create warehouse tables (one-time)
docker compose exec -T postgres psql -U etl -d warehouse < includes/sql/create_tables.sql

# 6) open the UI
# http://localhost:8080   (user: admin, pass: admin)
# Unpause and trigger etl_weather_finance
```
