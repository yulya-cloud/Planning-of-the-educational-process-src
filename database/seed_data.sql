-- Тестовые данные для приложения "Планирование учебного процесса"

-- Добавляем тестовых пользователей
INSERT INTO Users (username, email, role) VALUES 
('ivanov_student', 'ivanov@university.ru', 'student'),
('petrova_student', 'petrova@university.ru', 'student'),
('sidorov_teacher', 'sidorov@university.ru', 'teacher'),
('kozlov_teacher', 'kozlov@university.ru', 'teacher');

-- Добавляем дисциплины
INSERT INTO Subjects (name, description, credits) VALUES 
('Математика', 'Высшая математика и математический анализ', 6),
('Программирование', 'Основы программирования и алгоритмы', 5),
('Базы данных', 'Проектирование и работа с базами данных', 4),
('Физика', 'Общая физика и механика', 5);

-- Добавляем занятия
INSERT INTO Lessons (title, description, datetime, room, lesson_type, subject_id, teacher_id) VALUES 
('Лекция по математике', 'Введение в математический анализ', '2024-12-10 09:00:00', 'А-101', 'lecture', 1, 3),
('Практика по программированию', 'Решение задач на Python', '2024-12-11 11:00:00', 'Б-205', 'practice', 2, 4),
('Лабораторная по базам данных', 'Создание ER-диаграмм', '2024-12-12 13:00:00', 'В-301', 'lab', 3, 3),
('Лекция по физике', 'Законы Ньютона', '2024-12-13 15:00:00', 'А-102', 'lecture', 4, 4);

-- Добавляем задания
INSERT INTO Assignments (title, description, due_date, priority, status, user_id, subject_id) VALUES 
('Домашняя работа по математике', 'Решить задачи 1-10 из учебника', '2024-12-15 23:59:00', 'high', 'pending', 1, 1),
('Курсовая по программированию', 'Разработать приложение для учета задач', '2024-12-20 23:59:00', 'medium', 'in progress', 1, 2),
('Лабораторная по базам данных', 'Спроектировать схему БД для библиотеки', '2024-12-18 23:59:00', 'medium', 'pending', 2, 3),
('Расчетная работа по физике', 'Решить задачи по механике', '2024-12-14 23:59:00', 'high', 'completed', 2, 4);

-- Добавляем проекты
INSERT INTO Projects (name, description, deadline, status) VALUES 
('Учебный портал', 'Разработка веб-портала для университета', '2024-12-25 23:59:00', 'active'),
('Научное исследование', 'Исследование алгоритмов машинного обучения', '2024-12-30 23:59:00', 'active'),
('База данных библиотеки', 'Проектирование и реализация БД для библиотеки', '2024-12-22 23:59:00', 'completed');

-- Добавляем участников проектов
INSERT INTO Project_Members (project_id, user_id, role, permissions) VALUES 
(1, 1, 'developer', 'read,write'),
(1, 2, 'designer', 'read,write'),
(1, 3, 'mentor', 'read,write,admin'),
(2, 1, 'researcher', 'read,write'),
(2, 4, 'supervisor', 'read,write,admin'),
(3, 2, 'architect', 'read,write');

-- Связываем задания с проектами
INSERT INTO Project_Assignments (project_id, assignment_id, assigned_by) VALUES 
(1, 2, 3),  -- Курсовая по программированию в проекте "Учебный портал"
(3, 3, 4);  -- Лабораторная по базам данных в проекте "База данных библиотеки"

-- Добавляем уведомления
INSERT INTO Notifications (message, scheduled_time, type, user_id) VALUES 
('Напоминание: Лекция по математике завтра в 9:00', '2024-12-09 18:00:00', 'lesson', 1),
('Дедлайн: Домашняя работа по математике через 3 дня', '2024-12-12 09:00:00', 'deadline', 1),
('Напоминание: Практика по программированию завтра в 11:00', '2024-12-10 18:00:00', 'lesson', 2),
('Дедлайн: Лабораторная по базам данных через 2 дня', '2024-12-16 09:00:00', 'deadline', 2);


