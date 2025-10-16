-- ========================
-- CLIENTES
-- ========================
INSERT INTO client (name, phone, password, email, address)
VALUES
('Carlos Pérez', '3104567890', 'clave123', 'carlos.perez@mail.com', 'Cra 12 #45-23'),
('Laura Gómez', '3205671234', 'pass456', 'laura.gomez@mail.com', 'Cll 50 #22-10'),
('Andrés Rojas', '3156782345', 'andres789', 'andres.rojas@mail.com', 'Av 68 #10-05');

-- ========================
-- CODEUDORES
-- ========================
INSERT INTO co_debt (name, phone, password, email, address)
VALUES
('María Torres', '3129876543', 'maria123', 'maria.torres@mail.com', 'Cll 80 #30-22'),
('Julián Díaz', '3007654321', 'julian456', 'julian.diaz@mail.com', 'Cra 90 #15-45'),
('Sofía Herrera', '3148765432', 'sofia789', 'sofia.herrera@mail.com', 'Cll 100 #60-10');

-- ========================
-- PRÉSTAMOS
-- ========================
-- Supongamos que los IDs generados automáticamente son:
-- client_ID = 1, 2, 3
-- co_debt_ID = 1, 2, 3

INSERT INTO loan (loan, interest, date_creation, client_ID, co_debt_ID, frequency)
VALUES
(5000000, 0.12, '2025-10-10 09:30:00', 1, 1, 'Mensual'),
(8000000, 0.10, '2025-10-11 14:00:00', 2, 2, 'Quincenal'),
(3000000, 0.15, '2025-10-12 16:45:00', 3, 3, 'Semanal');

-- ========================
-- PAGOS
-- ========================
-- Supongamos que los id_loan generados son 1, 2, 3

INSERT INTO pay (pay_date, amount, id_loan)
VALUES
('2025-11-10 10:00:00', 450000, 1),
('2025-12-10 10:00:00', 450000, 1),
('2025-11-15 08:30:00', 600000, 2),
('2025-12-01 08:30:00', 600000, 2),
('2025-10-20 09:00:00', 300000, 3),
('2025-10-27 09:00:00', 300000, 3);
