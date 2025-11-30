Create DATABASE AcademicManagement;
USE AcademicManagement;

-- StudentInfo table
CREATE TABLE StudentInfo (
    STU_ID INT PRIMARY KEY,
    STU_NAME VARCHAR(100),
    DOB DATE,
    PHONE_NO VARCHAR(15),
    EMAIL_ID VARCHAR(100),
    ADDRESS VARCHAR(255)
);

-- CoursesInfo table
CREATE TABLE CoursesInfo (
    COURSE_ID INT PRIMARY KEY,
    COURSE_NAME VARCHAR(100),
    COURSE_INSTRUCTOR_NAME VARCHAR(100)
);

-- EnrollmentInfo table
CREATE TABLE EnrollmentInfo (
    ENROLLMENT_ID INT PRIMARY KEY,
    STU_ID INT,
    COURSE_ID INT,
    ENROLL_STATUS VARCHAR(20) CHECK (ENROLL_STATUS IN ('Enrolled', 'Not Enrolled')),

    FOREIGN KEY (STU_ID) REFERENCES StudentInfo(STU_ID),
    FOREIGN KEY (COURSE_ID) REFERENCES CoursesInfo(COURSE_ID)
);


-- DATA INSERTION
-- StudentInfo sample data
INSERT INTO StudentInfo VALUES
(1, 'Ravi', '2003-04-10', '9876543210', 'ravi@gmail.com', 'Chennai'),
(2, 'Priya', '2002-08-15', '8765432190', 'priya@gmail.com', 'Bangalore'),
(3, 'Arun', '2001-12-20', '7654321980', 'arun@gmail.com', 'Hyderabad');

-- CoursesInfo sample data
INSERT INTO CoursesInfo VALUES
(101, 'Database Systems', 'Dr. Mohan'),
(102, 'Computer Networks', 'Dr. Leena'),
(103, 'Operating Systems', 'Dr. Rahul');

-- EnrollmentInfo sample data
INSERT INTO EnrollmentInfo VALUES
(1, 1, 101, 'Enrolled'),
(2, 1, 102, 'Enrolled'),
(3, 2, 101, 'Not Enrolled'),
(4, 2, 103, 'Enrolled'),
(5, 3, 103, 'Enrolled');


-- RETRIEVE STUDENT INFORMATION
-- Retrieve student details + contact + enrollment status
SELECT 
    s.STU_NAME,
    s.PHONE_NO,
    s.EMAIL_ID,
    e.ENROLL_STATUS,
    c.COURSE_NAME
FROM StudentInfo s
LEFT JOIN EnrollmentInfo e ON s.STU_ID = e.STU_ID
LEFT JOIN CoursesInfo c ON e.COURSE_ID = c.COURSE_ID;

-- query to retrieve a list of courses in which a specific student is enrolled
SELECT 
    s.STU_NAME,
    c.COURSE_NAME
FROM EnrollmentInfo e
JOIN StudentInfo s ON e.STU_ID = s.STU_ID
JOIN CoursesInfo c ON e.COURSE_ID = c.COURSE_ID
WHERE e.STU_ID = 1 AND e.ENROLL_STATUS = 'Enrolled';

-- query to retrieve course information, including course name, instructor information
SELECT COURSE_NAME, COURSE_INSTRUCTOR_NAME
FROM CoursesInfo;

-- query to retrieve course information for a specific course
SELECT *
FROM CoursesInfo
WHERE COURSE_ID = 101;

-- query to retrieve course information for multiple courses
SELECT *
FROM CoursesInfo
WHERE COURSE_ID IN (101, 103);


-- REPORTING & ANALYTICS (JOINING QUERIES)
-- query to retrieve the number of students enrolled in each course
SELECT 
    c.COURSE_NAME,
    COUNT(e.STU_ID) AS ENROLLED_STUDENTS
FROM CoursesInfo c
LEFT JOIN EnrollmentInfo e 
    ON c.COURSE_ID = e.COURSE_ID 
    AND e.ENROLL_STATUS = 'Enrolled'
GROUP BY c.COURSE_NAME;

-- query to retrieve the list of students enrolled in a specific course
SELECT 
    s.STU_NAME,
    c.COURSE_NAME
FROM EnrollmentInfo e
JOIN StudentInfo s ON e.STU_ID = s.STU_ID
JOIN CoursesInfo c ON e.COURSE_ID = c.COURSE_ID
WHERE e.COURSE_ID = 103 AND ENROLL_STATUS = 'Enrolled';

-- query to retrieve the count of enrolled students for each instructor
SELECT 
    c.COURSE_INSTRUCTOR_NAME,
    COUNT(e.STU_ID) AS ENROLLED_STUDENTS
FROM CoursesInfo c
LEFT JOIN EnrollmentInfo e 
    ON c.COURSE_ID = e.COURSE_ID 
    AND e.ENROLL_STATUS = 'Enrolled'
GROUP BY c.COURSE_INSTRUCTOR_NAME;

-- query to retrieve the list of students who are enrolled in multiple courses
SELECT 
    s.STU_NAME,
    COUNT(e.COURSE_ID) AS TOTAL_COURSES
FROM StudentInfo s
JOIN EnrollmentInfo e ON s.STU_ID = e.STU_ID
WHERE e.ENROLL_STATUS = 'Enrolled'
GROUP BY s.STU_NAME
HAVING COUNT(e.COURSE_ID) > 1;

-- query to retrieve the courses that have the highest number of enrolled students(arranging from highest to lowest)
SELECT 
    c.COURSE_NAME,
    COUNT(e.STU_ID) AS ENROLLED_STUDENTS
FROM CoursesInfo c
LEFT JOIN EnrollmentInfo e 
    ON c.COURSE_ID = e.COURSE_ID 
    AND e.ENROLL_STATUS = 'Enrolled'
GROUP BY c.COURSE_NAME
ORDER BY ENROLLED_STUDENTS DESC;










