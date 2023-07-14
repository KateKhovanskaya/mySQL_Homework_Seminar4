-- 1. Подсчитать общее количество лайков, которые получили пользователи младше 12 лет.
SELECT likes.user_id, COUNT(*) FROM likes
WHERE user_id IN (SELECT profiles.user_id FROM profiles
WHERE profiles.birthday > "2011-07-14")
group by user_id;

-- 2. Определить кто больше поставил лайков (всего): мужчины или женщины.

SELECT profiles.gender
FROM likes JOIN profiles ON likes.user_id = profiles.user_id
GROUP BY profiles.gender
ORDER BY (SELECT COUNT(*) AS total_likes FROM likes) DESC
LIMIT 1;

-- 3. Вывести всех пользователей, которые не отправляли сообщения.
SELECT users.id, users.firstname, users.lastname
FROM users
WHERE users.id NOT IN(
SELECT messages.from_user_id FROM messages);

-- 4.Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека,
-- который больше всех написал ему сообщений.

SELECT users.id, users.firstname, users.lastname, COUNT(*) AS count_messages FROM messages
JOIN users ON users.id = messages.from_user_id
WHERE messages.to_user_id = 1
GROUP BY messages.from_user_id
ORDER BY count_messages DESC
LIMIT 1;
