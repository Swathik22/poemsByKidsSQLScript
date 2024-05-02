-- What grades are stored in the database?
select * from grade;
-- What emotions may be associated with a poem?
select p.Title,e.Name from poem p left join poememotion pe on p.id=pe.poemId left join emotion e on e.id=pe.emotionId;
-- How many poems are in the database?
select count(*) from poem;
-- Sort authors alphabetically by name. What are the names of the top 76 authors?
select name from author order by name limit 76;
-- Starting with the above query, add the grade of each of the authors.
select a.name,g.name from author a left join grade g on a.gradeId=g.id order by a.name limit 76;
-- Starting with the above query, add the recorded gender of each of the authors.
--------------select a.name,gr.name,g.name from author a left join grade gr on a.gradeId=gr.id left join gender g on a.genderId=g.id where a.genderId!=0 order by a.name limit 76;
-- What is the total number of words in all poems in the database?
select count(wordcount) from poem
-- Which poem has the fewest characters?
select title,charCount from poem where charcount=(select min(charcount) from poem)
-- How many authors are in the third grade?
select count(*) from author where gradeid=3
-- How many total authors are in the first through third grades?
select count(*) from author where gradeid between 1 and 3
-- What is the total number of poems written by fourth graders?
select count(*) from poem p left join author a on a.id=p.authorId where a.gradeId=4
-- How many poems are there per grade?
select a.gradeId,count(gradeId) from author a left join poem p on a.id=p.authorId group by gradeid
-- How many authors are in each grade? (Order your results by grade starting with 1st Grade)
select gradeId,count(author) as AuthorCount from author group by gradeId order by gradeId
select gradeId,count(*) as AuthorCount from author group by gradeId order by gradeId
-- What is the title of the poem that has the most words?
select title from poem where wordcount=(select max(wordcount) from poem)
-- Which author(s) have the most poems? (Remember authors can have the same name.)
-- select authorId,max(authorId) from poem group by authorId
SELECT a.name AS author_name, COUNT(p.id) AS poem_count
FROM author a
JOIN poem p ON a.id = p.authorid
GROUP BY a.name
ORDER BY COUNT(p.id) desc
LIMIT 1;
-- How many poems have an emotion of sadness?
select count(*) from poememotion where emotionId=3
-- How many poems are not associated with any emotion?---------------
select * from poememotion p left join emotion e on p.emotionId=e.id where p.emotionId is null
-- Which emotion is associated with the least number of poems?---------------
-- select count(poemId),poemId from poememotion group by poemId
-- SELECT COUNT(*) AS poem_count
-- FROM emotion e
-- JOIN poememotion p ON e.id=p.emotionId
-- GROUP BY p.emotionId
-- ORDER BY COUNT(p.emotionId) desc
-- LIMIT 1;
-- Which grade has the largest number of poems with an emotion of joy?----------
-- select poemId from poememotion where emotionid=4
select count(p.id) from grade g left join author a on a.gradeid=g.id left join poem p on p.authorid=a.id where p.id in(select poemId from poememotion where emotionId=4) group by p.id 
-------
SELECT g.Name AS grade_name, COUNT(p.id) AS poem_count
FROM Grade g
LEFT JOIN Author a ON g.Id = a.GradeId
LEFT JOIN Poem p ON a.Id = p.AuthorId
LEFT JOIN PoemEmotion pe ON p.Id = pe.PoemId
WHERE pe.EmotionId = 4
GROUP BY g.Name
order by count(p.id) desc
limit 1;
----------
-- Which gender has the least number of poems with an emotion of fear?
SELECT g.Name AS gender_name, COUNT(p.id) AS poem_count
FROM gender g
LEFT JOIN Author a ON g.Id = a.genderId
LEFT JOIN Poem p ON a.Id = p.AuthorId
LEFT JOIN PoemEmotion pe ON p.Id = pe.PoemId
WHERE pe.EmotionId = 2
GROUP BY g.Name
order by count(p.id) asc
limit 1;