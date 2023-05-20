DROP TABLE IF EXISTS `student`;

CREATE TABLE student (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    status VARCHAR(255) CHECK(status IN('studying', 'graduated', 'suspended'))
);