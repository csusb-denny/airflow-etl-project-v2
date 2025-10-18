#!/usr/bin/env bash
set -e

# Bring up Postgres + initialize DBs + Airflow metadata, then start Airflow
docker compose down -v
docker compose up -d postgres
docker compose up db-init
docker compose up airflow-init
docker compose up -d airflow-scheduler airflow-webserver

# Create warehouse tables
docker compose exec -T postgres psql -U "${POSTGRES_USER}" -d "${POSTGRES_DB}" < includes/sql/create_tables.sql

echo "Open http://localhost:8080  (user: admin / pass: admin)"
