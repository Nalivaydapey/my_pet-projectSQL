-- ============================================
-- Учебные запросы: проект АМПП
-- ============================================

-- 1. Показать название и IP всех точек
SELECT name, ip_address FROM points;

-- 2. Показать только точки с настроенным IP
SELECT ip_address FROM points 
WHERE ip_address IS NOT NULL;

-- 3. Показать точки с включённой поддержкой Troyka
SELECT * FROM points 
WHERE troyka = TRUE;

-- 4. Найти точку по части названия (поиск по шаблону)
SELECT * FROM points 
WHERE name LIKE '%9117%';

-- 5. Посчитать общее количество точек
SELECT COUNT(*) FROM points;

-- 6. Посчитать, сколько точек имеют IP-адрес
SELECT COUNT(*) FROM points 
WHERE ip_address IS NOT NULL;


-- ============================================
-- Нормализация и обновление данных
-- ============================================

-- Приведение всех UPID к 8-значному формату
UPDATE points 
SET upid = LPAD(LTRIM(upid, '0'), 8, '0');

-- Проверка длины всех UPID (должно быть только 8)
SELECT DISTINCT LENGTH(upid) AS length, COUNT(*) 
FROM points 
GROUP BY length;

-- Добавление ограничения на длину UPID
ALTER TABLE points 
ADD CONSTRAINT check_upid_length 
CHECK (LENGTH(upid) = 8);

-- ============================================
-- Аналитические запросы
-- ============================================

-- Статистика по продуктам
SELECT 
    product, 
    COUNT(*) AS count
FROM points
GROUP BY product
ORDER BY count DESC;

-- Статистика по наличию IP
SELECT 
    CASE 
        WHEN ip_address IS NOT NULL AND ip_address != '' THEN 'С IP'
        ELSE 'Без IP'
    END AS status,
    COUNT(*) AS count
FROM points
GROUP BY status;

-- Статистика по Troyka
SELECT 
    CASE 
        WHEN troyka = TRUE THEN 'С Troyka'
        ELSE 'Без Troyka'
    END AS status,
    COUNT(*) AS count
FROM points
GROUP BY status;
