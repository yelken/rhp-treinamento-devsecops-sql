SET search_path TO hospital_data, public;

INSERT INTO departments (name) VALUES
('Clínica Médica'),
('Cirurgia'),
('Pediatria')
ON CONFLICT DO NOTHING;

-- Dados de exemplo
INSERT INTO patients (full_name, ssn, dob, address, phone, department_id) VALUES
('Ana Souza', '111-22-3333', '1985-04-12', 'Rua A, 100', '5551-1111', 1),
('Bruno Lima', '222-33-4444', '1990-08-30', 'Rua B, 200', '5551-2222', 2),
('Carla Dias', '333-44-5555', '1978-01-05', 'Rua C, 300', '5551-3333', 1),
('Diego Nunes', '444-55-6666', '2002-11-23', 'Rua D, 400', '5551-4444', 3),
('Eva Prado', '555-66-7777', '1969-07-19', 'Rua E, 500', '5551-5555', 2)
ON CONFLICT DO NOTHING;

INSERT INTO admissions (patient_id, department_id, admitted_at, discharged_at) VALUES
(1, 1, NOW() - INTERVAL '10 days', NOW() - INTERVAL '7 days'),
(2, 2, NOW() - INTERVAL '5 days', NULL),
(3, 1, NOW() - INTERVAL '20 days', NOW() - INTERVAL '18 days'),
(4, 3, NOW() - INTERVAL '2 days', NULL),
(5, 2, NOW() - INTERVAL '15 days', NOW() - INTERVAL '12 days')
ON CONFLICT DO NOTHING;

INSERT INTO lab_results (patient_id, test_name, result_value, result_unit, result_date) VALUES
(1, 'Hemoglobina', '13.5', 'g/dL', CURRENT_DATE - INTERVAL '9 days'),
(2, 'Hemoglobina', '12.1', 'g/dL', CURRENT_DATE - INTERVAL '4 days'),
(3, 'Glicose', '98', 'mg/dL', CURRENT_DATE - INTERVAL '19 days'),
(4, 'PCR', '0.5', 'mg/dL', CURRENT_DATE - INTERVAL '1 day'),
(5, 'Colesterol', '210', 'mg/dL', CURRENT_DATE - INTERVAL '14 days')
ON CONFLICT DO NOTHING;

INSERT INTO users (username, role, department_id) VALUES
('report_cli_med', 'report_reader', 1),
('report_cir', 'report_reader', 2),
('etl_user', 'etl_writer', 1),
('auditor_user', 'auditor', NULL)
ON CONFLICT DO NOTHING;


