-- database/schema.sql
CREATE TABLE Users (
    user_id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT NOT NULL UNIQUE,
    email TEXT NOT NULL UNIQUE,
    role TEXT CHECK(role IN ('student', 'teacher')) NOT NULL,
    created_at TEXT DEFAULT (datetime('now'))
);

CREATE TABLE Subjects (
    subject_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE
);

CREATE TABLE Lessons (
    lesson_id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    datetime TEXT NOT NULL,
    room TEXT,
    subject_id INTEGER NOT NULL,
    teacher_id INTEGER NOT NULL,
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id),
    FOREIGN KEY (teacher_id) REFERENCES Users(user_id)
);

CREATE TABLE Assignments (
    assignment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    description TEXT,
    due_date TEXT NOT NULL,
    priority TEXT CHECK(priority IN ('low', 'medium', 'high')) DEFAULT 'medium',
    status TEXT CHECK(status IN ('pending', 'in progress', 'completed', 'overdue')) DEFAULT 'pending',
    created_at TEXT DEFAULT (datetime('now')),
    user_id INTEGER NOT NULL,
    subject_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id)
);

CREATE TABLE Projects (
    project_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    description TEXT
);

-- Таблица связи многие-ко-многим между Заданиями и Проектами
CREATE TABLE Project_Assignments (
    project_id INTEGER,
    assignment_id INTEGER,
    PRIMARY KEY (project_id, assignment_id),
    FOREIGN KEY (project_id) REFERENCES Projects(project_id) ON DELETE CASCADE,
    FOREIGN KEY (assignment_id) REFERENCES Assignments(assignment_id) ON DELETE CASCADE
);

-- Таблица связи многие-ко-многим между Пользователями и Проектами (члены проектов)
CREATE TABLE Project_Members (
    project_id INTEGER,
    user_id INTEGER,
    PRIMARY KEY (project_id, user_id),
    FOREIGN KEY (project_id) REFERENCES Projects(project_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

CREATE TABLE Notifications (
    notification_id INTEGER PRIMARY KEY AUTOINCREMENT,
    message TEXT NOT NULL,
    scheduled_time TEXT NOT NULL,
    type TEXT CHECK(type IN ('lesson', 'deadline')) NOT NULL,
    user_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

CREATE TABLE Comments (
    comment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    text TEXT NOT NULL,
    created_at TEXT DEFAULT (datetime('now')),
    user_id INTEGER NOT NULL,
    assignment_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (assignment_id) REFERENCES Assignments(assignment_id) ON DELETE CASCADE
);

-- Индексы для оптимизации
CREATE INDEX idx_assignments_user_id ON Assignments(user_id);
CREATE INDEX idx_assignments_due_date ON Assignments(due_date);
CREATE INDEX idx_assignments_status ON Assignments(status);
CREATE INDEX idx_lessons_datetime ON Lessons(datetime);
CREATE INDEX idx_lessons_teacher_id ON Lessons(teacher_id);
