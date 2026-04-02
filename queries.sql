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
