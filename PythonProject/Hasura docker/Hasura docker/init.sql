DROP SCHEMA IF EXISTS public;

CREATE SCHEMA public;

ALTER SCHEMA public OWNER TO postgres;

CREATE TABLE devices(
    id integer,
    frameDeviceIdentifier varchar(50),
    firstRegistration timestamp,
    lastRegistration timestamp,
    totalRegistrations integer
);

CREATE TABLE alarms (
    id integer,
    frameUUID varchar (50),
    created timestamp,
    ended timestamp,
    responses varchar,
    id_respons integer,
    reaction_respons varchar(20),
    timestamp_respons timestamp
);


--  Een view voor de lijndiagram om de gebruiker te vinden met de meeste alerts "MESSAGE_MEDICINE_ANSWER_NO --
CREATE VIEW medicine_answer_no_alerts_top_tien AS
SELECT
  "frameUUID",
  COUNT(*) AS aantal_meldingen
FROM
  alerts
WHERE
  "type" = 'MESSAGE_MEDICINE_ANSWER_NO'
  AND "created" >= '2024-09-01T00:00:00'
  AND "created" < '2025-03-01T00:00:00'
GROUP BY
  "frameUUID"
ORDER BY
  aantal_meldingen DESC
LIMIT 10;

-- Een view om de hoeveelheid originId's te vinden die naar meer dan 1 frame zijn gestuurd in december --
CREATE VIEW meerdere_originids_december_2024 AS
SELECT
  "originId"
FROM
  messages
WHERE
  sent >= '2024-12-01'
  AND sent < '2025-01-01'
GROUP BY
  "originId"
HAVING
  COUNT(*) > 1;

-- Een view om de hoeveelheid originId's te vinden die naar meer dan 1 frame zijn gestuurd in januari --
CREATE VIEW meerdere_originids_januari_2025 AS
SELECT
  "originId"
FROM
  messages
WHERE
  sent >= '2025-01-01'
  AND sent < '2025-02-01'
GROUP BY
  "originId"
HAVING
  COUNT(*) > 1;

-- Een view om de hoeveelheid originId's te vinden die naar meer dan 1 frame zijn gestuurd in februari --
CREATE VIEW meerdere_originids_februari_2025 AS
SELECT
  "originId"
FROM
  messages
WHERE
  sent >= '2025-02-01'
  AND sent < '2025-03-01'
GROUP BY
  "originId"
HAVING
  COUNT(*) > 1;

-- Een view om de hoeveelheid originId's te vinden die naar meer dan 1 frame zijn gestuurd in maart --
CREATE VIEW meerdere_originids_maart_2025 AS
SELECT
  "originId"
FROM
  messages
WHERE
  sent >= '2025-03-01'
  AND sent < '2025-04-01'
GROUP BY
  "originId"
HAVING
  COUNT(*) > 1;

