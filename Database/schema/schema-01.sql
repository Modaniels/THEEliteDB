CREATE TABLE "USER" (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    user_type VARCHAR(50) CHECK (user_type IN ('Guest', 'Subscriber')) NOT NULL 
);

CREATE TABLE SUBSCRIBER (
    user_id INT PRIMARY KEY,
    password VARCHAR(255) NOT NULL,
    subscription_date DATE NOT NULL,
    is_developer BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES "USER"(id) ON DELETE CASCADE
);

CREATE TABLE PROJECT (
    id SERIAL PRIMARY KEY,
    status VARCHAR(50) NOT NULL,
    description TEXT,
    developer_id INT NOT NULL, 
    FOREIGN KEY (developer_id) REFERENCES SUBSCRIBER(user_id)
);

CREATE TABLE PROJECT_CATEGORY (
    project_id INT,
    category VARCHAR(50) CHECK (category IN ('A', 'B', 'C', 'D')), 
    PRIMARY KEY (project_id, category),
    FOREIGN KEY (project_id) REFERENCES PROJECT(id) ON DELETE CASCADE
);

CREATE TABLE PROJECT_UPDATE (
    update_id SERIAL PRIMARY KEY,
    project_id INT NOT NULL,
    developer_id INT NOT NULL,
    name VARCHAR(255),
    status VARCHAR(50),
    description TEXT,
    type INT CHECK (type IN (1, 2, 3)),
    FOREIGN KEY (project_id) REFERENCES PROJECT(id) ON DELETE CASCADE,
    FOREIGN KEY (developer_id) REFERENCES SUBSCRIBER(user_id)
);

-- Manages which projects require other projects
CREATE TABLE PROJECT_DEPENDENCY (
    project_id INT,
    depends_on_project_id INT,
    PRIMARY KEY (project_id, depends_on_project_id),
    FOREIGN KEY (project_id) REFERENCES PROJECT(id) ON DELETE CASCADE,
    FOREIGN KEY (depends_on_project_id) REFERENCES PROJECT(id) ON DELETE CASCADE
);

-- Weak entity dependent on the Project
CREATE TABLE BUG_REPORT (
    project_id INT,
    bug_id INT,
    subscriber_id INT NOT NULL,
    description TEXT,
    file_date DATE,
    PRIMARY KEY (project_id, bug_id),
    FOREIGN KEY (project_id) REFERENCES PROJECT(id) ON DELETE CASCADE,
    FOREIGN KEY (subscriber_id) REFERENCES SUBSCRIBER(user_id)
);

-- Join table tracking user downloads
CREATE TABLE DOWNLOAD_RECORD (
    user_id INT,
    project_id INT,
    download_count INT DEFAULT 0,
    PRIMARY KEY (user_id, project_id),
    FOREIGN KEY (user_id) REFERENCES "USER"(id) ON DELETE CASCADE,
    FOREIGN KEY (project_id) REFERENCES PROJECT(id) ON DELETE CASCADE
);

-- Weak entity linking uploads to projects and optionally to updates
CREATE TABLE TRANSACTION (
    project_id INT,
    transaction_id INT,
    update_id INT NULL,
    transaction_date DATE,
    PRIMARY KEY (project_id, transaction_id),
    FOREIGN KEY (project_id) REFERENCES PROJECT(id) ON DELETE CASCADE,
    FOREIGN KEY (update_id) REFERENCES PROJECT_UPDATE(update_id) ON DELETE SET NULL
);
