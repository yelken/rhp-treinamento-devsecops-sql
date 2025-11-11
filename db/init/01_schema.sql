-- Esquema simplificado para exercícios
CREATE SCHEMA IF NOT EXISTS hospital_data;
SET search_path TO hospital_data, public;

-- Departamentos
CREATE TABLE IF NOT EXISTS departments (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

-- Pacientes
CREATE TABLE IF NOT EXISTS patients (
  id SERIAL PRIMARY KEY,
  full_name TEXT NOT NULL,
  ssn TEXT, -- identificador sensível fictício
  dob DATE,
  address TEXT,
  phone TEXT,
  department_id INT REFERENCES departments(id)
);

-- Admissões
CREATE TABLE IF NOT EXISTS admissions (
  id SERIAL PRIMARY KEY,
  patient_id INT REFERENCES patients(id),
  department_id INT REFERENCES departments(id),
  admitted_at TIMESTAMPTZ NOT NULL,
  discharged_at TIMESTAMPTZ
);

-- Resultados de exames
CREATE TABLE IF NOT EXISTS lab_results (
  id SERIAL PRIMARY KEY,
  patient_id INT REFERENCES patients(id),
  test_name TEXT NOT NULL,
  result_value TEXT,
  result_unit TEXT,
  result_date DATE NOT NULL
);

-- Usuários lógicos (para simular permissões)
CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY,
  username TEXT UNIQUE NOT NULL,
  role TEXT NOT NULL, -- ex: report_reader, etl_writer, auditor
  department_id INT REFERENCES departments(id)
);


