-- ================================================
-- Configuración de tiempo (PostgreSQL)
-- ================================================

-- Tamaño máximo de mensaje (equivalente a max_allowed_packet)
SET statement_timeout = '8h';
SET idle_in_transaction_session_timeout = '8h';

-- PostgreSQL maneja automáticamente lectura/escritura de red
-- No hay equivalentes exactos de net_read_timeout / net_write_timeout.
