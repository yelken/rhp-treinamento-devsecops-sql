SET search_path TO hospital_data, public;

INSERT INTO users (username, role, department_id) VALUES
('report_cli_med', 'report_cli_med', 1),
('report_cir', 'report_cir', 2)
ON CONFLICT DO NOTHING;