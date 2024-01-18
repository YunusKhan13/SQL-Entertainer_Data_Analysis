-- Q1: How many entertainers are there in the 'basic_info' table?
SELECT 
    COUNT(*) 
FROM 
    `basic_info`;

-- Q2: What is the average birth year of the entertainers?
SELECT 
    AVG(`Birth Year`) 
FROM 
    `basic_info`;

-- Q3: How many entertainers had their breakthrough in the year 2000?
SELECT 
    COUNT(*) 
FROM 
    `breakthrough_info` 
WHERE 
    `Year of Breakthrough/#1 Hit/Award Nomination` = 2000;

-- Q4: Which entertainer had the earliest breakthrough?
SELECT 
    `Entertainer` 
FROM 
    `breakthrough_info` 
ORDER BY 
    `Year of Breakthrough/#1 Hit/Award Nomination` ASC 
LIMIT 1;

-- Q5: How many entertainers have won an Oscar/Grammy/Emmy?
SELECT 
    COUNT(*) 
FROM 
    `breakthrough_info` 
WHERE 
    `Year of First Oscar/Grammy/Emmy` IS NOT NULL;

-- Q6: Who was the last entertainer to have a major work?
SELECT 
    `Entertainer` 
FROM 
    `last_work_info` 
ORDER BY 
    `Year of Last Major Work (arguable)` DESC 
LIMIT 1;

-- Q7: How many entertainers had their last major work in the same year as their death?
SELECT 
    COUNT(*) 
FROM 
    `last_work_info` 
WHERE 
    `Year of Last Major Work (arguable)` = `Year of Death`;

-- Q8: What is the gender distribution of the entertainers?
SELECT 
    `Gender (traditional)`, 
    COUNT(*) 
FROM 
    `basic_info` 
GROUP BY 
    `Gender (traditional)`;

-- Q9: Who is the youngest entertainer to have a breakthrough?
SELECT 
    `basic_info`.`Entertainer` 
FROM 
    `basic_info` 
INNER JOIN 
    `breakthrough_info` 
ON 
    `basic_info`.`Entertainer` = `breakthrough_info`.`Entertainer` 
ORDER BY 
    (`breakthrough_info`.`Year of Breakthrough/#1 Hit/Award Nomination` - `basic_info`.`Birth Year`) ASC 
LIMIT 1;

-- Q10: Who is the oldest living entertainer?
SELECT 
    `basic_info`.`Entertainer` 
FROM 
    `basic_info` 
LEFT JOIN 
    `last_work_info` 
ON 
    `basic_info`.`Entertainer` = `last_work_info`.`Entertainer` 
WHERE 
    `last_work_info`.`Year of Death` IS NULL 
ORDER BY 
    `basic_info`.`Birth Year` ASC 
LIMIT 1;

-- Q11: How many entertainers had their breakthrough before the age of 18?
SELECT 
    COUNT(*) 
FROM 
    `basic_info` 
INNER JOIN 
    `breakthrough_info` 
ON 
    `basic_info`.`Entertainer` = `breakthrough_info`.`Entertainer` 
WHERE 
    (`breakthrough_info`.`Year of Breakthrough/#1 Hit/Award Nomination` - `basic_info`.`Birth Year`) < 18;

-- Q12: What is the average time between an entertainer's breakthrough and their first Oscar/Grammy/Emmy?
SELECT 
    AVG(`breakthrough_info`.`Year of First Oscar/Grammy/Emmy` - `breakthrough_info`.`Year of Breakthrough/#1 Hit/Award Nomination`) 
FROM 
    `breakthrough_info` 
WHERE 
    `breakthrough_info`.`Year of First Oscar/Grammy/Emmy` IS NOT NULL;

-- Q13: How many entertainers had a #1 hit before receiving an award nomination?
SELECT 
    COUNT(*) 
FROM 
    `breakthrough_info` 
WHERE 
    `Year of Breakthrough/#1 Hit/Award Nomination` < `Year of First Oscar/Grammy/Emmy`;

-- Q14: What is the average lifespan of the entertainers?
SELECT 
    AVG(`last_work_info`.`Year of Death` - `basic_info`.`Birth Year`) 
FROM 
    `basic_info` 
INNER JOIN 
    `last_work_info` 
ON 
    `basic_info`.`Entertainer` = `last_work_info`.`Entertainer` 
WHERE 
    `last_work_info`.`Year of Death` IS NOT NULL;

-- Q15: How many entertainers are still alive?
SELECT 
    COUNT(*) 
FROM 
    `basic_info` 
LEFT JOIN 
    `last_work_info` 
ON 
    `basic_info`.`Entertainer` = `last_work_info`.`Entertainer` 
WHERE 
    `last_work_info`.`Year of Death` IS NULL;
