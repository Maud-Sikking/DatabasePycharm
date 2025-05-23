--
-- PostgreSQL database dump
--

-- Dumped from database version 15.13 (Debian 15.13-1.pgdg120+1)
-- Dumped by pg_dump version 15.13

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it

DROP SCHEMA IF EXISTS public CASCADE;
CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: alarms; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alarms (
    id integer NOT NULL,
    "frameUUID" character varying(50) NOT NULL,
    created timestamp without time zone NOT NULL,
    ended timestamp without time zone NOT NULL,
    responses character varying,
    id_respons integer,
    reaction_respons character varying(20),
    timestamp_respons timestamp without time zone
);


ALTER TABLE public.alarms OWNER TO postgres;

--
-- Name: alerts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alerts (
    id integer,
    "frameUUID" character varying(50) NOT NULL,
    type character varying(50),
    created timestamp without time zone,
    solved timestamp without time zone
);


ALTER TABLE public.alerts OWNER TO postgres;

--
-- Name: alerts_per_device_december_2024; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.alerts_per_device_december_2024 AS
 SELECT alerts."frameUUID",
    count(*) AS alert_count
   FROM public.alerts
  WHERE ((alerts.created >= '2024-12-01 00:00:00'::timestamp without time zone) AND (alerts.created < '2025-01-01 00:00:00'::timestamp without time zone))
  GROUP BY alerts."frameUUID";


ALTER TABLE public.alerts_per_device_december_2024 OWNER TO postgres;

--
-- Name: alerts_per_device_februari_2025; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.alerts_per_device_februari_2025 AS
 SELECT alerts."frameUUID",
    count(*) AS alert_count
   FROM public.alerts
  WHERE ((alerts.created >= '2025-02-01 00:00:00'::timestamp without time zone) AND (alerts.created < '2025-03-01 00:00:00'::timestamp without time zone))
  GROUP BY alerts."frameUUID";


ALTER TABLE public.alerts_per_device_februari_2025 OWNER TO postgres;

--
-- Name: alerts_per_device_januari_2025; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.alerts_per_device_januari_2025 AS
 SELECT alerts."frameUUID",
    count(*) AS alert_count
   FROM public.alerts
  WHERE ((alerts.created >= '2025-01-01 00:00:00'::timestamp without time zone) AND (alerts.created < '2025-02-01 00:00:00'::timestamp without time zone))
  GROUP BY alerts."frameUUID";


ALTER TABLE public.alerts_per_device_januari_2025 OWNER TO postgres;

--
-- Name: alerts_per_device_november_2024; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.alerts_per_device_november_2024 AS
 SELECT alerts."frameUUID",
    count(*) AS alert_count
   FROM public.alerts
  WHERE ((alerts.created >= '2024-11-01 00:00:00'::timestamp without time zone) AND (alerts.created < '2024-12-01 00:00:00'::timestamp without time zone))
  GROUP BY alerts."frameUUID";


ALTER TABLE public.alerts_per_device_november_2024 OWNER TO postgres;

--
-- Name: calls; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.calls (
    id integer NOT NULL,
    "frameUUID" character varying(50) NOT NULL,
    type character varying(30),
    created timestamp without time zone,
    started timestamp without time zone,
    ended timestamp without time zone
);


ALTER TABLE public.calls OWNER TO postgres;

--
-- Name: devices; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.devices (
    id integer NOT NULL,
    "frameDeviceIdentifier" character varying(50) NOT NULL,
    "firstRegistration" timestamp without time zone NOT NULL,
    "lastRegistration" timestamp without time zone NOT NULL,
    "totalRegistrations" integer NOT NULL
);


ALTER TABLE public.devices OWNER TO postgres;

--
-- Name: medicine_answer_no_alerts_top_tien; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.medicine_answer_no_alerts_top_tien AS
 SELECT alerts."frameUUID",
    count(*) AS aantal_meldingen
   FROM public.alerts
  WHERE (((alerts.type)::text = 'MESSAGE_MEDICINE_ANSWER_NO'::text) AND (alerts.created >= '2024-09-01 00:00:00'::timestamp without time zone) AND (alerts.created < '2025-03-01 00:00:00'::timestamp without time zone))
  GROUP BY alerts."frameUUID"
  ORDER BY (count(*)) DESC
 LIMIT 10;


ALTER TABLE public.medicine_answer_no_alerts_top_tien OWNER TO postgres;

--
-- Name: messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.messages (
    id integer NOT NULL,
    "frameUUID" character varying(50) NOT NULL,
    "originId" integer,
    sent timestamp without time zone,
    id_respons integer,
    created_respons timestamp without time zone
);


ALTER TABLE public.messages OWNER TO postgres;

--
-- Name: meerdere_originids_december_2024; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.meerdere_originids_december_2024 AS
 SELECT messages."originId"
   FROM public.messages
  WHERE ((messages.sent >= '2024-12-01 00:00:00'::timestamp without time zone) AND (messages.sent < '2025-01-01 00:00:00'::timestamp without time zone))
  GROUP BY messages."originId"
 HAVING (count(*) > 1);


ALTER TABLE public.meerdere_originids_december_2024 OWNER TO postgres;

--
-- Name: meerdere_originids_februari_2025; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.meerdere_originids_februari_2025 AS
 SELECT messages."originId"
   FROM public.messages
  WHERE ((messages.sent >= '2025-02-01 00:00:00'::timestamp without time zone) AND (messages.sent < '2025-03-01 00:00:00'::timestamp without time zone))
  GROUP BY messages."originId"
 HAVING (count(*) > 1);


ALTER TABLE public.meerdere_originids_februari_2025 OWNER TO postgres;

--
-- Name: meerdere_originids_januari_2025; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.meerdere_originids_januari_2025 AS
 SELECT messages."originId"
   FROM public.messages
  WHERE ((messages.sent >= '2025-01-01 00:00:00'::timestamp without time zone) AND (messages.sent < '2025-02-01 00:00:00'::timestamp without time zone))
  GROUP BY messages."originId"
 HAVING (count(*) > 1);


ALTER TABLE public.meerdere_originids_januari_2025 OWNER TO postgres;

--
-- Name: meerdere_originids_maart_2025; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.meerdere_originids_maart_2025 AS
 SELECT messages."originId"
   FROM public.messages
  WHERE ((messages.sent >= '2025-03-01 00:00:00'::timestamp without time zone) AND (messages.sent < '2025-04-01 00:00:00'::timestamp without time zone))
  GROUP BY messages."originId"
 HAVING (count(*) > 1);


ALTER TABLE public.meerdere_originids_maart_2025 OWNER TO postgres;

--
-- Name: photos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.photos (
    id integer NOT NULL,
    "frameUUID" character varying(50) NOT NULL,
    sent timestamp without time zone
);


ALTER TABLE public.photos OWNER TO postgres;

--
-- Name: soort_alert_december_2024; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.soort_alert_december_2024 AS
 SELECT alerts.type,
    count(*) AS alert_count
   FROM public.alerts
  WHERE ((alerts.created >= '2024-12-01 00:00:00'::timestamp without time zone) AND (alerts.created < '2025-01-01 00:00:00'::timestamp without time zone))
  GROUP BY alerts.type;


ALTER TABLE public.soort_alert_december_2024 OWNER TO postgres;

--
-- Name: soort_alert_februari_2025; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.soort_alert_februari_2025 AS
 SELECT alerts.type,
    count(*) AS alert_count
   FROM public.alerts
  WHERE ((alerts.created >= '2025-02-01 00:00:00'::timestamp without time zone) AND (alerts.created < '2025-03-01 00:00:00'::timestamp without time zone))
  GROUP BY alerts.type;


ALTER TABLE public.soort_alert_februari_2025 OWNER TO postgres;

--
-- Name: soort_alert_januari_2025; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.soort_alert_januari_2025 AS
 SELECT alerts.type,
    count(*) AS alert_count
   FROM public.alerts
  WHERE ((alerts.created >= '2025-01-01 00:00:00'::timestamp without time zone) AND (alerts.created < '2025-02-01 00:00:00'::timestamp without time zone))
  GROUP BY alerts.type;


ALTER TABLE public.soort_alert_januari_2025 OWNER TO postgres;

--
-- Name: soort_alert_maart_2025; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.soort_alert_maart_2025 AS
 SELECT alerts.type,
    count(*) AS alert_count
   FROM public.alerts
  WHERE ((alerts.created >= '2025-03-01 00:00:00'::timestamp without time zone) AND (alerts.created < '2025-04-01 00:00:00'::timestamp without time zone) AND ((alerts.type)::text <> 'Frame offline'::text))
  GROUP BY alerts.type;


ALTER TABLE public.soort_alert_maart_2025 OWNER TO postgres;

--
-- Name: alarms alarms_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alarms
    ADD CONSTRAINT alarms_id PRIMARY KEY (id);


--
-- Name: alerts alerts_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alerts
    ADD CONSTRAINT alerts_id_key UNIQUE (id);


--
-- Name: calls calls_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.calls
    ADD CONSTRAINT calls_id PRIMARY KEY (id);


--
-- Name: calls calls_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.calls
    ADD CONSTRAINT calls_id_key UNIQUE (id);


--
-- Name: devices devices_frameDeviceIdentifier; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.devices
    ADD CONSTRAINT "devices_frameDeviceIdentifier" PRIMARY KEY ("frameDeviceIdentifier");


--
-- Name: devices devices_frameDeviceIdentifier_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.devices
    ADD CONSTRAINT "devices_frameDeviceIdentifier_key" UNIQUE ("frameDeviceIdentifier");


--
-- Name: messages messages_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_id PRIMARY KEY (id);


--
-- Name: photos photos_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.photos
    ADD CONSTRAINT photos_id PRIMARY KEY (id);


--
-- Name: photos photos_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.photos
    ADD CONSTRAINT photos_id_key UNIQUE (id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--

