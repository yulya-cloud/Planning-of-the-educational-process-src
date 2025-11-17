-- НОРМАЛИЗОВАННАЯ СХЕМА ДЛЯ ПРИЛОЖЕНИЯ "ПЛАНИРОВАНИЕ УЧЕБНОГО ПРОЦЕССА"
-- Нормализована до 3NF

-- Таблица пользователей
CREATE TABLE Users (
    user_id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT NOT NULL UNIQUE,
    email TEXT NOT NULL UNIQUE,
    role TEXT NOT NULL CHECK(role IN ('student', 'teacher')),
    created_at TEXT DEFAULT (datetime('now')),
    updated_at TEXT DEFAULT (datetime('now'))
);

-- Таблица дисциплин
CREATE TABLE Subjects (
    subject_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE,
    description TEXT,
    credits INTEGER DEFAULT 0,
    created_at TEXT DEFAULT (datetime('now'))
);

-- Таблица занятий
CREATE TABLE Lessons (
    lesson_id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    description TEXT,
    datetime TEXT NOT NULL,
    room TEXT,
    lesson_type TEXT CHECK(lesson_type IN ('lecture', 'practice', 'lab')),
    subject_id INTEGER NOT NULL,
    teacher_id INTEGER NOT NULL,
    created_at TEXT DEFAULT (datetime('now')),
    updated_at TEXT DEFAULT (datetime('now')),
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id) ON DELETE CASCADE,
    FOREIGN KEY (teacher_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Таблица заданий
CREATE TABLE Assignments (
    assignment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    description TEXT,
    due_date TEXT NOT NULL,
    priority TEXT DEFAULT 'medium' CHECK(priority IN ('low', 'medium', 'high')),
    status TEXT DEFAULT 'pending' CHECK(status IN ('pending', 'in progress', 'completed', 'overdue')),
    created_at TEXT DEFAULT (datetime('now')),
    updated_at TEXT DEFAULT (datetime('now')),
    user_id INTEGER NOT NULL,
    subject_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id) ON DELETE CASCADE
);

-- Таблица проектов
CREATE TABLE Projects (
    project_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    description TEXT,
    deadline TEXT,
    status TEXT DEFAULT 'active' CHECK(status IN ('active', 'completed', 'archived')),
    created_at TEXT DEFAULT (datetime('now')),
    updated_at TEXT DEFAULT (datetime('now'))
);

-- Таблица участников проектов (связь многие-ко-многим)
CREATE TABLE Project_Members (
    project_id INTEGER,
    user_id INTEGER,
    role TEXT DEFAULT 'member',
    joined_at TEXT DEFAULT (datetime('now')),
    permissions TEXT,
    PRIMARY KEY (project_id, user_id),
    FOREIGN KEY (project_id) REFERENCES Projects(project_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Таблица заданий в проектах (связь многие-ко-многим)
CREATE TABLE Project_Assignments (
    project_id INTEGER,
    assignment_id INTEGER,
    assigned_at TEXT DEFAULT (datetime('now')),
    assigned_by INTEGER,
    PRIMARY KEY (project_id, assignment_id),
    FOREIGN KEY (project_id) REFERENCES Projects(project_id) ON DELETE CASCADE,
    FOREIGN KEY (assignment_id) REFERENCES Assignments(assignment_id) ON DELETE CASCADE,
    FOREIGN KEY (assigned_by) REFERENCES Users(user_id) ON DELETE SET NULL
);

-- Таблица уведомлений
CREATE TABLE Notifications (
    notification_id INTEGER PRIMARY KEY AUTOINCREMENT,
    message TEXT NOT NULL,
    scheduled_time TEXT NOT NULL,
    type TEXT NOT NULL CHECK(type IN ('lesson', 'deadline')),
    is_sent BOOLEAN DEFAULT 0,
    is_read BOOLEAN DEFAULT 0,
    created_at TEXT DEFAULT (datetime('now')),
    user_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Таблица комментариев
CREATE TABLE Comments (
    comment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    text TEXT NOT NULL,
    created_at TEXT DEFAULT (datetime('now')),
    updated_at TEXT DEFAULT (datetime('now')),
    user_id INTEGER NOT NULL,
    assignment_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (assignment_id) REFERENCES Assignments(assignment_id) ON DELETE CASCADE
);

