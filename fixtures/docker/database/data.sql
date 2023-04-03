# create a table with some data
CREATE TABLE student (
    id int,
    name VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO student(id, name) VALUES
(1,'A'),
(2,'B'),
(3,'C');
