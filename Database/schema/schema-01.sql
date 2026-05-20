CREATE TABLE USER (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    user_type ENUM('Guest', 'Subscriber') NOT NULL 
);

CREATE TABLE SUBSCRIBER (
    user_id INT PRIMARY KEY,
    password VARCHAR(255) NOT NULL,
    subscription_date DATE NOT NULL,
    is_developer BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES USER(id) ON DELETE CASCADE
);

CREATE TABLE PROJECT (
    id INT AUTO_INCREMENT PRIMARY KEY,
    status VARCHAR(50) NOT NULL,
    description TEXT,
    developer_id INT NOT NULL, 
    FOREIGN KEY (developer_id) REFERENCES SUBSCRIBER(user_id)
);

CREATE TABLE PROJECT_CATEGORY (
    project_id INT,
    category ENUM('A', 'B', 'C', 'D'), 
    PRIMARY KEY (project_id, category),
    FOREIGN KEY (project_id) REFERENCES PROJECT(id) ON DELETE CASCADE
);