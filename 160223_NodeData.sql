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
-- Name: api_nodes; Type: TABLE; Schema: public; Owner: django; Tablespace: 
--

CREATE TABLE api_nodes (
    id integer NOT NULL,
    "ID" integer,
    "Address" character varying(100) NOT NULL,
    "Type" character varying(2) NOT NULL,
    "Appliances" character varying(100) NOT NULL,
    "Added" timestamp with time zone NOT NULL,
    "Updated" timestamp with time zone NOT NULL,
    "Group_id" integer
);


ALTER TABLE api_nodes OWNER TO django;

--
-- Name: api_nodes_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE api_nodes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE api_nodes_id_seq OWNER TO django;

--
-- Name: api_nodes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE api_nodes_id_seq OWNED BY api_nodes.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY api_nodes ALTER COLUMN id SET DEFAULT nextval('api_nodes_id_seq'::regclass);


--
-- Data for Name: api_nodes; Type: TABLE DATA; Schema: public; Owner: django
--

COPY api_nodes (id, "ID", "Address", "Type", "Appliances", "Added", "Updated", "Group_id") FROM stdin;
7	1	00 13 A2 00 40 EC 3A A4	N	檯燈	2016-02-02 18:51:08.446612+08	2016-02-02 18:51:08.446633+08	8
8	2	00 13 A2 00 40 EC 3A B7	N	微波爐	2016-02-02 18:51:33.828057+08	2016-02-02 18:51:33.828074+08	8
9	3	00 13 A2 00 40 EC 3A 97	N	風扇	2016-02-02 18:51:53.185163+08	2016-02-02 18:51:53.18518+08	8
12	4	00 13 A2 00 40 B3 2D 41	N	風扇	2016-02-02 18:53:48.799064+08	2016-02-02 18:53:48.79908+08	9
13	5	00 13 A2 00 40 EC 3A 98	N	檯燈	2016-02-02 18:54:09.395102+08	2016-02-02 18:54:09.395122+08	9
14	6	00 13 A2 00 40 B3 31 65	N	除濕機	2016-02-02 18:54:29.847202+08	2016-02-02 18:54:29.847223+08	9
10	7	00 13 A2 00 40 B3 2D 4F	L	主燈	2016-02-02 18:52:51.141089+08	2016-02-02 18:52:51.141109+08	8
15	8	00 13 A2 00 40 B3 2D 5B	L	主燈	2016-02-02 18:54:55.933422+08	2016-02-02 18:54:55.933439+08	9
11	9	00 13 A2 00 40 C2 8B B7	IR	電視	2016-02-02 18:53:19.967749+08	2016-02-02 18:53:19.967765+08	8
\.


--
-- Name: api_nodes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('api_nodes_id_seq', 15, true);


--
-- Name: api_nodes_pkey; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY api_nodes
    ADD CONSTRAINT api_nodes_pkey PRIMARY KEY (id);


--
-- Name: api_nodes_fcce8521; Type: INDEX; Schema: public; Owner: django; Tablespace: 
--

CREATE INDEX api_nodes_fcce8521 ON api_nodes USING btree ("Group_id");


--
-- Name: api_nodes_Group_id_bf8502e0_fk_api_house_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY api_nodes
    ADD CONSTRAINT "api_nodes_Group_id_bf8502e0_fk_api_house_id" FOREIGN KEY ("Group_id") REFERENCES api_house(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_nodes; Type: ACL; Schema: public; Owner: django
--

REVOKE ALL ON TABLE api_nodes FROM PUBLIC;
REVOKE ALL ON TABLE api_nodes FROM django;
GRANT ALL ON TABLE api_nodes TO django;


--
-- Name: api_nodes_id_seq; Type: ACL; Schema: public; Owner: django
--

REVOKE ALL ON SEQUENCE api_nodes_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE api_nodes_id_seq FROM django;
GRANT ALL ON SEQUENCE api_nodes_id_seq TO django;


--
-- PostgreSQL database dump complete
--

