--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: api_ircommend; Type: TABLE; Schema: public; Owner: django; Tablespace: 
--

CREATE TABLE api_ircommend (
    id integer NOT NULL,
    "Commend" character varying(100) NOT NULL,
    "RawCode" text NOT NULL,
    "NodeID_id" integer NOT NULL
);


ALTER TABLE api_ircommend OWNER TO django;

--
-- Name: api_ircommend_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE api_ircommend_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE api_ircommend_id_seq OWNER TO django;

--
-- Name: api_ircommend_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE api_ircommend_id_seq OWNED BY api_ircommend.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY api_ircommend ALTER COLUMN id SET DEFAULT nextval('api_ircommend_id_seq'::regclass);


--
-- Data for Name: api_ircommend; Type: TABLE DATA; Schema: public; Owner: django
--

COPY api_ircommend (id, "Commend", "RawCode", "NodeID_id") FROM stdin;
3	chup	7E 00 52 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 02 FC 21 C6 11 C2 01 8A 02 C2 01 D6 06 C2 01 BC 02 C2 01 8A 02 90 01 BC 02 C2 01 8A 02 C2 01 8A 02 C2 01 8A 02 C2 01 08 07 90 01 BC 02 90 01 08 07 C2 01 D6 06 C2 01 D6 06 C2 01 08 07 90 01 BC 02, 7E 00 52 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 01 C2 01 D6 06 C2 01 8A 02 C2 01 08 07 90 01 8A 02 C2 01 BC 02 C2 01 D6 06 C2 01 8A 02 C2 01 8A 02 C2 01 8A 02 C2 01 08 07 90 01 BC 02 C2 01 D6 06 C2 01 D6 06 C2 01 BC 02 90 01 08 07 C2 01 D6 06, 7E 00 1A 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 00 43 00 C2 01 D6 06 C2 01	11
4	on	7E 00 52 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 02 FC 21 C6 11 C2 01 8A 02 C2 01 D6 06 C2 01 8A 02 C2 01 BC 02 90 01 BC 02 90 01 BC 02 C2 01 8A 02 90 01 BC 02 C2 01 D6 06 C2 01 8A 02 C2 01 08 07 90 01 08 07 C2 01 D6 06 C2 01 D6 06 C2 01 8A 02, 7E 00 52 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 01 C2 01 08 07 90 01 BC 02 90 01 BC 02 C2 01 D6 06 C2 01 8A 02 C2 01 D6 06 C2 01 8A 02 C2 01 8A 02 C2 01 BC 02 90 01 08 07 C2 01 D6 06 C2 01 8A 02 C2 01 D6 06 C2 01 BC 02 90 01 D6 06 F4 01 D6 06, 7E 00 1A 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 00 43 00 C2 01 D6 06 C2 01	11
5	chdown	7E 00 52 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 02 60 22 C6 11 C2 01 BC 02 90 01 08 07 C2 01 BC 02 90 01 BC 02 C2 01 8A 02 C2 01 BC 02 90 01 BC 02 90 01 BC 02 90 01 3A 07 90 01 BC 02 90 01 08 07 C2 01 08 07 90 01 08 07 C2 01 08 07 C2 01 8A 02, 7E 00 52 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 01 C2 01 08 07 90 01 08 07 C2 01 08 07 90 01 BC 02 C2 01 BC 02 90 01 08 07 90 01 BC 02 C2 01 8A 02 C2 01 BC 02 90 01 BC 02 C2 01 8A 02 C2 01 D6 06 C2 01 08 07 C2 01 BC 02 90 01 08 07 C2 01 D6 06, 7E 00 1B 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 00 43 00 C2 01 08 07 C2 01 A6	11
6	mute	7E 00 52 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 02 FC 21 C6 11 C2 01 8A 02 C2 01 08 07 90 01 8A 02 C2 01 BC 02 C2 01 8A 02 90 01 BC 02 C2 01 8A 02 C2 01 8A 02 C2 01 D6 06 C2 01 BC 02 90 01 08 07 C2 01 D6 06 C2 01 D6 06 C2 01 D6 06 C2 01 BC 02, 7E 00 52 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 01 90 01 08 07 C2 01 8A 02 90 01 BC 02 C2 01 D6 06 C2 01 D6 06 C2 01 BC 02 90 01 BC 02 90 01 BC 02 C2 01 8A 02 C2 01 D6 06 C2 01 D6 06 C2 01 BC 02 90 01 BC 02 90 01 08 07 C2 01 D6 06 C2 01 D6 06, 7E 00 1A 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 00 43 00 C2 01 08 07 90 01	11
7	voiceup	7E 00 52 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 02 FC 21 2A 12 5E 01 20 03 5E 01 3A 07 5E 01 20 03 2C 01 EE 02 90 01 EE 02 5E 01 EE 02 5E 01 20 03 5E 01 EE 02 5E 01 08 07 90 01 BC 02 90 01 6C 07 5E 01 3A 07 90 01 08 07 90 01 3A 07 90 01 EE 02, 7E 00 52 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 01 5E 01 3A 07 5E 01 EE 02 5E 01 20 03 5E 01 EE 02 5E 01 EE 02 5E 01 6C 07 5E 01 EE 02 90 01 BC 02 5E 01 20 03 5E 01 3A 07 90 01 3A 07 5E 01 3A 07 5E 01 3A 07 90 01 EE 02 5E 01 3A 07 90 01 6C 07, 7E 00 1A 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 00 43 00 2C 01 3A 07 90 01	11
8	menu	7E 00 52 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 02 60 22 F8 11 90 01 BC 02 C2 01 08 07 90 01 BC 02 C2 01 8A 02 C2 01 8A 02 C2 01 8A 02 F4 01 8A 02 C2 01 8A 02 C2 01 08 07 C2 01 8A 02 C2 01 D6 06 F4 01 D6 06 C2 01 08 07 90 01 08 07 C2 01 BC 02, 7E 00 52 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 01 90 01 08 07 C2 01 D6 06 F4 01 8A 02 C2 01 D6 06 C2 01 BC 02 C2 01 D6 06 C2 01 8A 02 F4 01 8A 02 C2 01 8A 02 C2 01 8A 02 C2 01 08 07 C2 01 8A 02 C2 01 08 07 C2 01 8A 02 C2 01 D6 06 F4 01 D6 06, 7E 00 1A 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 00 43 00 C2 01 08 07 C2 01	11
9	tv1	7E 00 52 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 02 60 22 F8 11 90 01 BC 02 C2 01 D6 06 C2 01 BC 02 C2 01 8A 02 C2 01 8A 02 C2 01 BC 02 C2 01 8A 02 C2 01 8A 02 C2 01 08 07 C2 01 8A 02 C2 01 08 07 C2 01 08 07 90 01 08 07 90 01 08 07 F4 01 8A 02, 7E 00 52 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 01 90 01 08 07 C2 01 BC 02 90 01 BC 02 C2 01 8A 02 C2 01 BC 02 90 01 BC 02 C2 01 8A 02 C2 01 BC 02 90 01 BC 02 C2 01 D6 06 C2 01 08 07 C2 01 08 07 C2 01 D6 06 C2 01 08 07 C2 01 08 07 90 01 08 07, 7E 00 1A 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 00 43 00 C2 01 08 07 C2 01 A6 7E 00 16 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 00 00 01 00 B0 04	11
10	tv2	7E 00 52 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 02 92 22 C6 11 C2 01 8A 02 F4 01 D6 06 C2 01 8A 02 C2 01 BC 02 C2 01 8A 02 C2 01 8A 02 C2 01 BC 02 90 01 BC 02 C2 01 08 07 90 01 BC 02 C2 01 D6 06 C2 01 08 07 C2 01 D6 06 F4 01 D6 06 C2 01 8A 02, 7E 00 52 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 01 F4 01 D6 06 C2 01 08 07 C2 01 8A 02 C2 01 8A 02 C2 01 BC 02 C2 01 8A 02 C2 01 8A 02 C2 01 8A 02 C2 01 BC 02 C2 01 8A 02 C2 01 08 07 90 01 08 07 C2 01 08 07 C2 01 08 07 90 01 08 07 C2 01 D6 06, 7E 00 1A 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 00 43 00 F4 01 D6 06 C2 01	11
11	tv3	7E 00 52 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 02 60 22 C6 11 C2 01 BC 02 90 01 08 07 C2 01 8A 02 C2 01 BC 02 C2 01 8A 02 C2 01 8A 02 C2 01 BC 02 90 01 BC 02 C2 01 08 07 90 01 BC 02 C2 01 08 07 90 01 08 07 C2 01 D6 06 F4 01 D6 06 C2 01 8A 02, 7E 00 52 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 01 C2 01 08 07 C2 01 8A 02 C2 01 08 07 C2 01 8A 02 C2 01 8A 02 C2 01 BC 02 C2 01 8A 02 C2 01 8A 02 C2 01 BC 02 90 01 08 07 C2 01 BC 02 90 01 08 07 C2 01 D6 06 F4 01 D6 06 C2 01 08 07 90 01 08 07, 7E 00 1A 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 00 43 00 C2 01 08 07 C2 01 A6	11
12	tv4	7E 00 52 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 02 2E 22 F8 11 C2 01 BC 02 90 01 08 07 C2 01 8A 02 C2 01 8A 02 F4 01 8A 02 90 01 BC 02 C2 01 8A 02 C2 01 BC 02 90 01 08 07 C2 01 BC 02 90 01 08 07 C2 01 08 07 C2 01 D6 06 C2 01 08 07 C2 01 8A 02, 7E 00 52 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 01 C2 01 08 07 C2 01 D6 06 C2 01 08 07 90 01 BC 02 C2 01 8A 02 C2 01 BC 02 90 01 BC 02 C2 01 8A 02 C2 01 BC 02 90 01 BC 02 C2 01 8A 02 C2 01 08 07 C2 01 D6 06 C2 01 08 07 C2 01 08 07 90 01 08 07, 7E 00 1A 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 00 43 00 C2 01 08 07 C2 01 A6	11
13	tv5	7E 00 52 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 02 60 22 F8 11 C2 01 8A 02 C2 01 08 07 C2 01 8A 02 C2 01 8A 02 C2 01 BC 02 C2 01 8A 02 C2 01 8A 02 C2 01 BC 02 90 01 08 07 90 01 EE 02 90 01 08 07 C2 01 D6 06 F4 01 D6 06 C2 01 08 07 90 01 BC 02, 7E 00 52 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 01 C2 01 08 07 90 01 BC 02 C2 01 8A 02 C2 01 08 07 90 01 BC 02 C2 01 8A 02 C2 01 BC 02 90 01 BC 02 C2 01 8A 02 90 01 3A 07 C2 01 D6 06 C2 01 8A 02 C2 01 08 07 C2 01 08 07 90 01 08 07 C2 01 08 07, 7E 00 1A 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 00 43 00 C2 01 D6 06 C2 01 D9	11
14	tv6	7E 00 52 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 02 60 22 F8 11 90 01 BC 02 C2 01 08 07 90 01 BC 02 C2 01 8A 02 C2 01 8A 02 C2 01 8A 02 F4 01 8A 02 90 01 BC 02 C2 01 08 07 90 01 BC 02 C2 01 08 07 90 01 08 07 C2 01 08 07 C2 01 D6 06 C2 01 BC 02, 7E 00 52 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 01 90 01 08 07 C2 01 D6 06 F4 01 8A 02 C2 01 D6 06 C2 01 BC 02 90 01 BC 02 C2 01 8A 02 C2 01 BC 02 90 01 BC 02 C2 01 8A 02 C2 01 08 07 C2 01 8A 02 C2 01 08 07 90 01 08 07 C2 01 08 07 C2 01 08 07, 7E 00 1A 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 00 43 00 90 01 08 07 90 01 0A	11
15	tv7	7E 00 52 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 02 2E 22 F8 11 90 01 BC 02 C2 01 08 07 90 01 BC 02 C2 01 8A 02 C2 01 8A 02 C2 01 BC 02 C2 01 8A 02 C2 01 8A 02 C2 01 08 07 C2 01 8A 02 C2 01 08 07 C2 01 D6 06 C2 01 08 07 90 01 08 07 C2 01 BC 02, 7E 00 52 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 01 90 01 08 07 C2 01 8A 02 C2 01 08 07 C2 01 08 07 90 01 BC 02 C2 01 8A 02 C2 01 BC 02 90 01 BC 02 C2 01 8A 02 C2 01 D6 06 F4 01 8A 02 90 01 BC 02 C2 01 08 07 90 01 08 07 C2 01 08 07 C2 01 D6 06, 7E 00 1A 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 00 43 00 C2 01 08 07 C2 01 A6	11
16	tv8	7E 00 52 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 02 60 22 C6 11 C2 01 8A 02 C2 01 08 07 C2 01 8A 02 C2 01 8A 02 C2 01 BC 02 90 01 BC 02 C2 01 8A 02 C2 01 BC 02 90 01 08 07 90 01 BC 02 C2 01 08 07 90 01 08 07 C2 01 08 07 90 01 08 07 C2 01 BC 02, 7E 00 52 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 01 90 01 08 07 90 01 08 07 C2 01 08 07 C2 01 D6 06 C2 01 BC 02 90 01 BC 02 C2 01 8A 02 C2 01 BC 02 90 01 BC 02 C2 01 8A 02 C2 01 8A 02 C2 01 8A 02 F4 01 D6 06 C2 01 08 07 90 01 08 07 C2 01 08 07, 7E 00 1A 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 00 43 00 C2 01 D6 06 C2 01 D9	11
17	tv9	7E 00 52 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 02 60 22 F8 11 C2 01 8A 02 C2 01 08 07 90 01 BC 02 C2 01 8A 02 C2 01 BC 02 90 01 BC 02 C2 01 8A 02 C2 01 8A 02 C2 01 08 07 C2 01 8A 02 C2 01 08 07 C2 01 08 07 90 01 08 07 C2 01 D6 06 F4 01 8A 02,F 7E 00 52 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 01 90 01 08 07 C2 01 BC 02 90 01 BC 02 C2 01 8A 02 C2 01 08 07 C2 01 8A 02 C2 01 8A 02 C2 01 BC 02 90 01 BC 02 C2 01 D6 06 C2 01 08 07 90 01 08 07 F4 01 8A 02 90 01 08 07 C2 01 08 07 C2 01 D6 06, 7E 00 1A 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 00 43 00 C2 01 08 07 C2 01 A6	11
18	tv0	7E 00 52 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 02 60 22 F8 11 C2 01 8A 02 C2 01 D6 06 C2 01 BC 02 90 01 BC 02 C2 01 8A 02 C2 01 BC 02 90 01 8A 02 F4 01 8A 02 C2 01 D6 06 C2 01 BC 02 C2 01 D6 06 C2 01 08 07 C2 01 D6 06 C2 01 08 07 C2 01 8A 02, 7E 00 52 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 01 C2 01 D6 06 F4 01 D6 06 C2 01 8A 02 C2 01 8A 02 C2 01 08 07 C2 01 8A 02 C2 01 BC 02 90 01 BC 02 C2 01 8A 02 C2 01 8A 02 C2 01 08 07 C2 01 D6 06 C2 01 8A 02 F4 01 D6 06 C2 01 08 07 90 01 08 07, 7E 00 1A 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 00 43 00 C2 01 D6 06 F4 01 A7	11
19	voicedown	7E 00 52 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 02 FC 21 2A 12 90 01 BC 02 5E 01 3A 07 90 01 EE 02 5E 01 EE 02 C2 01 8A 02 90 01 EE 02 5E 01 20 03 5E 01 BC 02 5E 01 6C 07 5E 01 EE 02 90 01 3A 07 5E 01 3A 07 5E 01 6C 07 5E 01 3A 07 C2 01 BC 02, 7E 00 52 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 01 5E 01 6C 07 2C 01 3A 07 90 01 BC 02 C2 01 BC 02 C2 01 8A 02 90 01 3A 07 5E 01 20 03 2C 01 EE 02 90 01 BC 02 90 01 EE 02 5E 01 3A 07 90 01 3A 07 90 01 08 07 90 01 EE 02 90 01 3A 07 5E 01 3A 07, 7E 00 1A 10 01 00 13 A2 00 40 EC 3A BE FF FE 00 00 72 00 02 00 43 00 90 01 3A 07 5E 01	11
\.


--
-- Name: api_ircommend_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('api_ircommend_id_seq', 19, true);


--
-- Name: api_ircommend_pkey; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY api_ircommend
    ADD CONSTRAINT api_ircommend_pkey PRIMARY KEY (id);


--
-- Name: api_ircommend_d8dbccc2; Type: INDEX; Schema: public; Owner: django; Tablespace: 
--

CREATE INDEX api_ircommend_d8dbccc2 ON api_ircommend USING btree ("NodeID_id");


--
-- Name: api_ircommend_NodeID_id_dfa2c9fc_fk_api_nodes_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY api_ircommend
    ADD CONSTRAINT "api_ircommend_NodeID_id_dfa2c9fc_fk_api_nodes_id" FOREIGN KEY ("NodeID_id") REFERENCES api_nodes(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_ircommend; Type: ACL; Schema: public; Owner: django
--

REVOKE ALL ON TABLE api_ircommend FROM PUBLIC;
REVOKE ALL ON TABLE api_ircommend FROM django;
GRANT ALL ON TABLE api_ircommend TO django;


--
-- Name: api_ircommend_id_seq; Type: ACL; Schema: public; Owner: django
--

REVOKE ALL ON SEQUENCE api_ircommend_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE api_ircommend_id_seq FROM django;
GRANT ALL ON SEQUENCE api_ircommend_id_seq TO django;


--
-- PostgreSQL database dump complete
--

