-- Таблица точек продаж
CREATE TABLE points (
    id SERIAL PRIMARY KEY,
    upid VARCHAR(8) NOT NULL UNIQUE,
    name VARCHAR(255) NOT NULL,
    ip_address VARCHAR(50),
    ad_number VARCHAR(100),
    comment TEXT,
    product VARCHAR(255),
    troyka BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Ограничение: UPID всегда 8 символов
    CONSTRAINT check_upid_length CHECK (LENGTH(upid) = 8)
);

-- Триггер для автоматического дополнения UPID нулями
CREATE OR REPLACE FUNCTION pad_upid()
RETURNS TRIGGER AS $$
BEGIN
    NEW.upid := LPAD(LTRIM(NEW.upid, '0'), 8, '0');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_pad_upid
BEFORE INSERT OR UPDATE ON points
FOR EACH ROW
EXECUTE FUNCTION pad_upid();

-- Индекс для ускорения сортировки
CREATE INDEX idx_points_id ON points(id);
