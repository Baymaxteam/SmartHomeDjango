--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: account_emailaddress; Type: TABLE; Schema: public; Owner: django; Tablespace: 
--

CREATE TABLE account_emailaddress (
    id integer NOT NULL,
    email character varying(254) NOT NULL,
    verified boolean NOT NULL,
    "primary" boolean NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE account_emailaddress OWNER TO django;

--
-- Name: account_emailaddress_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE account_emailaddress_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE account_emailaddress_id_seq OWNER TO django;

--
-- Name: account_emailaddress_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE account_emailaddress_id_seq OWNED BY account_emailaddress.id;


--
-- Name: account_emailconfirmation; Type: TABLE; Schema: public; Owner: django; Tablespace: 
--

CREATE TABLE account_emailconfirmation (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    sent timestamp with time zone,
    key character varying(64) NOT NULL,
    email_address_id integer NOT NULL
);


ALTER TABLE account_emailconfirmation OWNER TO django;

--
-- Name: account_emailconfirmation_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE account_emailconfirmation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE account_emailconfirmation_id_seq OWNER TO django;

--
-- Name: account_emailconfirmation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE account_emailconfirmation_id_seq OWNED BY account_emailconfirmation.id;


--
-- Name: api_currentstate; Type: TABLE; Schema: public; Owner: django; Tablespace: 
--

CREATE TABLE api_currentstate (
    id integer NOT NULL,
    "State" integer NOT NULL,
    "Added" timestamp with time zone NOT NULL,
    "NodeID_id" integer NOT NULL
);


ALTER TABLE api_currentstate OWNER TO django;

--
-- Name: api_currentstate_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE api_currentstate_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE api_currentstate_id_seq OWNER TO django;

--
-- Name: api_currentstate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE api_currentstate_id_seq OWNED BY api_currentstate.id;


--
-- Name: api_house; Type: TABLE; Schema: public; Owner: django; Tablespace: 
--

CREATE TABLE api_house (
    id integer NOT NULL,
    "GroupID" character varying(10) NOT NULL,
    "Name" character varying(10) NOT NULL
);


ALTER TABLE api_house OWNER TO django;

--
-- Name: api_house_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE api_house_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE api_house_id_seq OWNER TO django;

--
-- Name: api_house_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE api_house_id_seq OWNED BY api_house.id;


--
-- Name: api_ircommend; Type: TABLE; Schema: public; Owner: django; Tablespace: 
--

CREATE TABLE api_ircommend (
    id integer NOT NULL,
    "Commend" character varying(100) NOT NULL,
    "RawCode" character varying(255) NOT NULL,
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
-- Name: api_nodestate; Type: TABLE; Schema: public; Owner: django; Tablespace: 
--

CREATE TABLE api_nodestate (
    id integer NOT NULL,
    "State" character varying(100) NOT NULL,
    "Added" timestamp with time zone NOT NULL,
    "NodeID_id" integer NOT NULL
);


ALTER TABLE api_nodestate OWNER TO django;

--
-- Name: api_nodestate_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE api_nodestate_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE api_nodestate_id_seq OWNER TO django;

--
-- Name: api_nodestate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE api_nodestate_id_seq OWNED BY api_nodestate.id;


--
-- Name: api_taskschedule; Type: TABLE; Schema: public; Owner: django; Tablespace: 
--

CREATE TABLE api_taskschedule (
    id integer NOT NULL,
    "triggerTime" timestamp with time zone NOT NULL,
    "Commend" character varying(100) NOT NULL,
    completed boolean NOT NULL,
    queued boolean NOT NULL,
    "NodeID_id" integer NOT NULL
);


ALTER TABLE api_taskschedule OWNER TO django;

--
-- Name: api_taskschedule_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE api_taskschedule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE api_taskschedule_id_seq OWNER TO django;

--
-- Name: api_taskschedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE api_taskschedule_id_seq OWNED BY api_taskschedule.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: django; Tablespace: 
--

CREATE TABLE auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE auth_group OWNER TO django;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_group_id_seq OWNER TO django;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE auth_group_id_seq OWNED BY auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: django; Tablespace: 
--

CREATE TABLE auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE auth_group_permissions OWNER TO django;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_group_permissions_id_seq OWNER TO django;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE auth_group_permissions_id_seq OWNED BY auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: django; Tablespace: 
--

CREATE TABLE auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE auth_permission OWNER TO django;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_permission_id_seq OWNER TO django;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE auth_permission_id_seq OWNED BY auth_permission.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: django; Tablespace: 
--

CREATE TABLE django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE django_admin_log OWNER TO django;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_admin_log_id_seq OWNER TO django;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE django_admin_log_id_seq OWNED BY django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: django; Tablespace: 
--

CREATE TABLE django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE django_content_type OWNER TO django;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_content_type_id_seq OWNER TO django;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE django_content_type_id_seq OWNED BY django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: django; Tablespace: 
--

CREATE TABLE django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE django_migrations OWNER TO django;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_migrations_id_seq OWNER TO django;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE django_migrations_id_seq OWNED BY django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: django; Tablespace: 
--

CREATE TABLE django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE django_session OWNER TO django;

--
-- Name: django_site; Type: TABLE; Schema: public; Owner: django; Tablespace: 
--

CREATE TABLE django_site (
    id integer NOT NULL,
    domain character varying(100) NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE django_site OWNER TO django;

--
-- Name: django_site_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE django_site_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_site_id_seq OWNER TO django;

--
-- Name: django_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE django_site_id_seq OWNED BY django_site.id;


--
-- Name: djkombu_message; Type: TABLE; Schema: public; Owner: django; Tablespace: 
--

CREATE TABLE djkombu_message (
    id integer NOT NULL,
    visible boolean NOT NULL,
    sent_at timestamp with time zone,
    payload text NOT NULL,
    queue_id integer NOT NULL
);


ALTER TABLE djkombu_message OWNER TO django;

--
-- Name: djkombu_message_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE djkombu_message_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE djkombu_message_id_seq OWNER TO django;

--
-- Name: djkombu_message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE djkombu_message_id_seq OWNED BY djkombu_message.id;


--
-- Name: djkombu_queue; Type: TABLE; Schema: public; Owner: django; Tablespace: 
--

CREATE TABLE djkombu_queue (
    id integer NOT NULL,
    name character varying(200) NOT NULL
);


ALTER TABLE djkombu_queue OWNER TO django;

--
-- Name: djkombu_queue_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE djkombu_queue_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE djkombu_queue_id_seq OWNER TO django;

--
-- Name: djkombu_queue_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE djkombu_queue_id_seq OWNED BY djkombu_queue.id;


--
-- Name: socialaccount_socialaccount; Type: TABLE; Schema: public; Owner: django; Tablespace: 
--

CREATE TABLE socialaccount_socialaccount (
    id integer NOT NULL,
    provider character varying(30) NOT NULL,
    uid character varying(191) NOT NULL,
    last_login timestamp with time zone NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    extra_data text NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE socialaccount_socialaccount OWNER TO django;

--
-- Name: socialaccount_socialaccount_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE socialaccount_socialaccount_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE socialaccount_socialaccount_id_seq OWNER TO django;

--
-- Name: socialaccount_socialaccount_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE socialaccount_socialaccount_id_seq OWNED BY socialaccount_socialaccount.id;


--
-- Name: socialaccount_socialapp; Type: TABLE; Schema: public; Owner: django; Tablespace: 
--

CREATE TABLE socialaccount_socialapp (
    id integer NOT NULL,
    provider character varying(30) NOT NULL,
    name character varying(40) NOT NULL,
    client_id character varying(191) NOT NULL,
    secret character varying(191) NOT NULL,
    key character varying(191) NOT NULL
);


ALTER TABLE socialaccount_socialapp OWNER TO django;

--
-- Name: socialaccount_socialapp_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE socialaccount_socialapp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE socialaccount_socialapp_id_seq OWNER TO django;

--
-- Name: socialaccount_socialapp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE socialaccount_socialapp_id_seq OWNED BY socialaccount_socialapp.id;


--
-- Name: socialaccount_socialapp_sites; Type: TABLE; Schema: public; Owner: django; Tablespace: 
--

CREATE TABLE socialaccount_socialapp_sites (
    id integer NOT NULL,
    socialapp_id integer NOT NULL,
    site_id integer NOT NULL
);


ALTER TABLE socialaccount_socialapp_sites OWNER TO django;

--
-- Name: socialaccount_socialapp_sites_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE socialaccount_socialapp_sites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE socialaccount_socialapp_sites_id_seq OWNER TO django;

--
-- Name: socialaccount_socialapp_sites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE socialaccount_socialapp_sites_id_seq OWNED BY socialaccount_socialapp_sites.id;


--
-- Name: socialaccount_socialtoken; Type: TABLE; Schema: public; Owner: django; Tablespace: 
--

CREATE TABLE socialaccount_socialtoken (
    id integer NOT NULL,
    token text NOT NULL,
    token_secret text NOT NULL,
    expires_at timestamp with time zone,
    account_id integer NOT NULL,
    app_id integer NOT NULL
);


ALTER TABLE socialaccount_socialtoken OWNER TO django;

--
-- Name: socialaccount_socialtoken_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE socialaccount_socialtoken_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE socialaccount_socialtoken_id_seq OWNER TO django;

--
-- Name: socialaccount_socialtoken_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE socialaccount_socialtoken_id_seq OWNED BY socialaccount_socialtoken.id;


--
-- Name: users_user; Type: TABLE; Schema: public; Owner: django; Tablespace: 
--

CREATE TABLE users_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(30) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE users_user OWNER TO django;

--
-- Name: users_user_groups; Type: TABLE; Schema: public; Owner: django; Tablespace: 
--

CREATE TABLE users_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE users_user_groups OWNER TO django;

--
-- Name: users_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE users_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_user_groups_id_seq OWNER TO django;

--
-- Name: users_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE users_user_groups_id_seq OWNED BY users_user_groups.id;


--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_user_id_seq OWNER TO django;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE users_user_id_seq OWNED BY users_user.id;


--
-- Name: users_user_user_permissions; Type: TABLE; Schema: public; Owner: django; Tablespace: 
--

CREATE TABLE users_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE users_user_user_permissions OWNER TO django;

--
-- Name: users_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE users_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_user_user_permissions_id_seq OWNER TO django;

--
-- Name: users_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE users_user_user_permissions_id_seq OWNED BY users_user_user_permissions.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY account_emailaddress ALTER COLUMN id SET DEFAULT nextval('account_emailaddress_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY account_emailconfirmation ALTER COLUMN id SET DEFAULT nextval('account_emailconfirmation_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY api_currentstate ALTER COLUMN id SET DEFAULT nextval('api_currentstate_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY api_house ALTER COLUMN id SET DEFAULT nextval('api_house_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY api_ircommend ALTER COLUMN id SET DEFAULT nextval('api_ircommend_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY api_nodes ALTER COLUMN id SET DEFAULT nextval('api_nodes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY api_nodestate ALTER COLUMN id SET DEFAULT nextval('api_nodestate_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY api_taskschedule ALTER COLUMN id SET DEFAULT nextval('api_taskschedule_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY auth_group ALTER COLUMN id SET DEFAULT nextval('auth_group_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('auth_group_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY auth_permission ALTER COLUMN id SET DEFAULT nextval('auth_permission_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY django_admin_log ALTER COLUMN id SET DEFAULT nextval('django_admin_log_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY django_content_type ALTER COLUMN id SET DEFAULT nextval('django_content_type_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY django_migrations ALTER COLUMN id SET DEFAULT nextval('django_migrations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY django_site ALTER COLUMN id SET DEFAULT nextval('django_site_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY djkombu_message ALTER COLUMN id SET DEFAULT nextval('djkombu_message_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY djkombu_queue ALTER COLUMN id SET DEFAULT nextval('djkombu_queue_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY socialaccount_socialaccount ALTER COLUMN id SET DEFAULT nextval('socialaccount_socialaccount_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY socialaccount_socialapp ALTER COLUMN id SET DEFAULT nextval('socialaccount_socialapp_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY socialaccount_socialapp_sites ALTER COLUMN id SET DEFAULT nextval('socialaccount_socialapp_sites_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY socialaccount_socialtoken ALTER COLUMN id SET DEFAULT nextval('socialaccount_socialtoken_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY users_user ALTER COLUMN id SET DEFAULT nextval('users_user_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY users_user_groups ALTER COLUMN id SET DEFAULT nextval('users_user_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY users_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('users_user_user_permissions_id_seq'::regclass);


--
-- Data for Name: account_emailaddress; Type: TABLE DATA; Schema: public; Owner: django
--

COPY account_emailaddress (id, email, verified, "primary", user_id) FROM stdin;
1	kuo77122@gmail.com	t	t	1
\.


--
-- Name: account_emailaddress_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('account_emailaddress_id_seq', 1, true);


--
-- Data for Name: account_emailconfirmation; Type: TABLE DATA; Schema: public; Owner: django
--

COPY account_emailconfirmation (id, created, sent, key, email_address_id) FROM stdin;
1	2016-01-08 15:42:40.482144+08	2016-01-08 15:42:41.202188+08	3rg27whpudkggfeqyiwbzvuibgokiirihxofrnepws2kyxovfpz2gchdw9qexczf	1
\.


--
-- Name: account_emailconfirmation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('account_emailconfirmation_id_seq', 1, true);


--
-- Data for Name: api_currentstate; Type: TABLE DATA; Schema: public; Owner: django
--

COPY api_currentstate (id, "State", "Added", "NodeID_id") FROM stdin;
6	20	2016-02-02 19:57:43.704727+08	7
7	42	2016-02-02 19:57:43.843648+08	8
8	15	2016-02-02 19:57:43.847734+08	11
9	89	2016-02-02 19:57:43.851984+08	10
10	21	2016-02-02 19:57:43.856409+08	9
11	32	2016-02-02 19:57:43.861467+08	12
12	41	2016-02-02 19:57:43.868304+08	15
13	30	2016-02-02 19:57:43.872716+08	13
14	20	2016-02-02 19:58:05.338334+08	7
15	22	2016-02-02 19:58:05.440875+08	9
16	43	2016-02-02 19:58:05.447822+08	8
17	14	2016-02-02 19:58:05.454099+08	11
18	33	2016-02-02 19:58:05.467859+08	12
19	30	2016-02-02 19:58:05.47491+08	13
20	44	2016-02-02 19:58:05.483172+08	15
21	89	2016-02-02 19:58:05.488946+08	10
22	22	2016-02-02 19:59:05.32152+08	7
23	42	2016-02-02 19:59:05.37168+08	8
24	39	2016-02-02 19:59:05.380657+08	15
25	31	2016-02-02 19:59:05.387104+08	13
26	16	2016-02-02 19:59:05.420085+08	11
27	32	2016-02-02 19:59:05.500798+08	12
28	21	2016-02-02 19:59:05.520588+08	9
29	90	2016-02-02 19:59:05.581783+08	10
30	22	2016-02-02 20:00:05.062246+08	9
31	30	2016-02-02 20:00:05.129914+08	12
32	14	2016-02-02 20:00:05.134283+08	11
33	88	2016-02-02 20:00:05.138409+08	10
34	31	2016-02-02 20:00:05.14272+08	13
35	19	2016-02-02 20:00:05.147244+08	7
36	40	2016-02-02 20:00:05.151264+08	15
37	45	2016-02-02 20:00:05.158561+08	8
38	23	2016-02-02 20:01:05.313597+08	9
39	32	2016-02-02 20:01:05.364812+08	12
40	89	2016-02-02 20:01:05.370241+08	10
41	21	2016-02-02 20:01:05.375903+08	7
42	31	2016-02-02 20:01:05.380755+08	13
43	42	2016-02-02 20:01:05.385262+08	15
44	13	2016-02-02 20:01:05.389648+08	11
45	44	2016-02-02 20:01:05.39507+08	8
46	44	2016-02-02 20:02:05.347918+08	8
47	19	2016-02-02 20:02:05.378858+08	7
48	16	2016-02-02 20:02:05.385142+08	11
49	91	2016-02-02 20:02:05.391294+08	10
50	31	2016-02-02 20:02:05.395653+08	13
51	33	2016-02-02 20:02:05.40041+08	12
52	22	2016-02-02 20:02:05.407378+08	9
53	40	2016-02-02 20:02:05.411576+08	15
54	42	2016-02-02 20:03:05.258321+08	8
55	89	2016-02-02 20:03:05.265676+08	10
56	29	2016-02-02 20:03:05.270239+08	13
57	32	2016-02-02 20:03:05.274712+08	12
58	44	2016-02-02 20:03:05.278886+08	15
59	24	2016-02-02 20:03:05.283403+08	9
60	21	2016-02-02 20:03:05.287547+08	7
61	18	2016-02-02 20:04:05.212257+08	7
62	43	2016-02-02 20:04:05.218509+08	8
63	91	2016-02-02 20:04:05.222893+08	10
64	40	2016-02-02 20:04:05.227089+08	15
65	32	2016-02-02 20:04:05.231049+08	12
66	29	2016-02-02 20:04:05.236091+08	13
67	15	2016-02-02 20:04:05.240215+08	11
68	22	2016-02-02 20:04:05.244736+08	9
69	44	2016-02-02 20:05:05.235466+08	8
70	15	2016-02-02 20:05:05.269681+08	11
71	22	2016-02-02 20:05:05.282674+08	9
72	23	2016-02-02 20:05:05.287868+08	7
73	30	2016-02-02 20:05:05.293312+08	13
74	32	2016-02-02 20:05:05.298425+08	12
75	90	2016-02-02 20:05:05.30513+08	10
76	43	2016-02-02 20:05:05.314675+08	15
77	21	2016-02-02 20:06:05.376773+08	9
78	32	2016-02-02 20:06:05.43858+08	12
79	46	2016-02-02 20:06:05.444418+08	8
80	29	2016-02-02 20:06:05.448643+08	13
81	41	2016-02-02 20:06:05.452944+08	15
82	20	2016-02-02 20:06:05.456978+08	7
83	89	2016-02-02 20:06:05.461499+08	10
84	23	2016-02-02 20:07:05.320299+08	9
85	22	2016-02-02 20:07:05.375748+08	7
86	91	2016-02-02 20:07:05.383993+08	10
87	29	2016-02-02 20:07:05.432758+08	13
88	31	2016-02-02 20:07:05.501623+08	12
89	44	2016-02-02 20:07:05.526805+08	8
90	44	2016-02-02 20:07:05.558152+08	15
91	24	2016-02-02 20:08:37.604007+08	9
92	21	2016-02-02 20:08:37.731079+08	7
93	89	2016-02-02 20:08:37.736407+08	10
94	45	2016-02-02 20:08:37.741069+08	8
95	31	2016-02-02 20:08:37.745595+08	12
96	43	2016-02-02 20:08:37.750143+08	15
97	29	2016-02-02 20:08:37.754388+08	13
98	22	2016-02-02 20:09:05.259925+08	7
99	42	2016-02-02 20:09:05.421388+08	8
100	89	2016-02-02 20:09:05.427789+08	10
101	29	2016-02-02 20:09:05.493124+08	13
102	39	2016-02-02 20:09:05.499195+08	15
103	22	2016-02-02 20:09:05.505293+08	9
104	33	2016-02-02 20:09:05.510245+08	12
105	44	2016-02-02 20:10:05.167624+08	8
106	21	2016-02-02 20:10:05.204693+08	9
107	21	2016-02-02 20:10:05.209308+08	7
108	31	2016-02-02 20:10:05.214079+08	12
109	89	2016-02-02 20:10:05.218512+08	10
110	40	2016-02-02 20:10:05.222613+08	15
111	30	2016-02-02 20:10:05.254657+08	13
112	21	2016-02-02 20:11:05.198123+08	7
113	42	2016-02-02 20:11:05.22207+08	8
114	21	2016-02-02 20:11:05.226955+08	9
115	87	2016-02-02 20:11:05.23146+08	10
116	42	2016-02-02 20:11:05.235873+08	15
117	30	2016-02-02 20:11:05.24001+08	12
118	28	2016-02-02 20:11:05.246352+08	13
119	42	2016-02-02 20:11:05.250397+08	8
120	38	2016-02-02 20:35:27.929273+08	8
121	17	2016-02-02 20:35:28.146336+08	7
122	20	2016-02-02 20:35:28.15143+08	9
123	17	2016-02-02 20:35:28.156217+08	11
124	29	2016-02-02 20:35:28.160939+08	13
125	31	2016-02-02 20:35:28.165035+08	12
126	11	2016-02-02 20:35:28.169264+08	15
127	57	2016-02-02 20:35:28.173234+08	10
128	21	2016-02-02 20:36:05.228266+08	9
129	39	2016-02-02 20:36:05.327201+08	8
130	8	2016-02-02 20:36:05.332086+08	15
131	13	2016-02-02 20:36:05.336479+08	11
132	29	2016-02-02 20:36:05.34393+08	12
133	30	2016-02-02 20:36:05.34872+08	13
134	54	2016-02-02 20:36:05.35405+08	10
135	19	2016-02-02 20:36:05.3591+08	7
136	40	2016-02-02 20:37:05.322993+08	8
137	22	2016-02-02 20:37:05.375395+08	7
138	16	2016-02-02 20:37:05.382587+08	11
139	29	2016-02-02 20:37:05.388053+08	12
140	29	2016-02-02 20:37:05.393887+08	13
141	11	2016-02-02 20:37:05.400266+08	15
142	21	2016-02-02 20:37:05.405681+08	9
143	58	2016-02-02 20:37:05.436206+08	10
144	23	2016-02-02 20:38:05.3426+08	7
145	20	2016-02-02 20:38:05.373373+08	9
146	56	2016-02-02 20:38:05.377533+08	10
147	17	2016-02-02 20:38:05.383047+08	11
148	30	2016-02-02 20:38:05.395033+08	12
149	31	2016-02-02 20:38:05.403796+08	13
150	40	2016-02-02 20:38:05.407908+08	8
151	12	2016-02-02 20:38:05.411816+08	15
152	5026	2016-02-02 20:39:05.351341+08	14
153	49	2016-02-02 20:39:05.398444+08	14
154	12	2016-02-02 20:39:05.433099+08	11
155	23	2016-02-02 20:39:05.447764+08	9
156	18	2016-02-02 20:39:05.452362+08	7
157	30	2016-02-02 20:39:05.456456+08	12
158	27	2016-02-02 20:39:05.461773+08	13
159	41	2016-02-02 20:39:05.466563+08	8
160	53	2016-02-02 20:39:05.470762+08	10
161	12	2016-02-02 20:39:05.475175+08	15
162	46	2016-02-02 20:39:05.483927+08	14
163	5026	2016-02-02 20:40:05.144681+08	14
164	19	2016-02-02 20:40:05.150523+08	7
165	20	2016-02-02 20:40:05.202035+08	9
166	45	2016-02-02 20:40:05.206828+08	14
167	12	2016-02-02 20:40:05.211825+08	15
168	16	2016-02-02 20:40:05.216206+08	11
169	39	2016-02-02 20:40:05.220156+08	8
170	31	2016-02-02 20:40:05.224139+08	12
171	56	2016-02-02 20:40:05.227989+08	10
172	42	2016-02-02 20:40:05.232028+08	13
173	43	2016-02-02 20:41:05.142012+08	8
174	33	2016-02-02 20:41:05.14968+08	12
175	43	2016-02-02 20:41:05.154374+08	14
176	56	2016-02-02 20:41:05.158637+08	10
177	23	2016-02-02 20:41:05.163387+08	7
178	20	2016-02-02 20:41:05.167653+08	9
179	42	2016-02-02 20:41:05.172398+08	13
180	17	2016-02-02 20:41:05.176961+08	11
181	12	2016-02-02 20:41:05.181647+08	15
182	17	2016-02-02 20:41:05.187567+08	11
183	21	2016-02-02 20:42:05.256735+08	9
184	20	2016-02-02 20:42:05.263565+08	7
185	13	2016-02-02 20:42:05.267799+08	11
186	55	2016-02-02 20:42:05.271788+08	10
187	30	2016-02-02 20:42:05.277408+08	12
188	12	2016-02-02 20:42:05.281375+08	15
189	41	2016-02-02 20:42:05.287898+08	13
190	43	2016-02-02 20:42:05.29421+08	8
191	21	2016-02-02 20:43:05.0617+08	9
192	46	2016-02-02 20:43:05.06747+08	14
193	56	2016-02-02 20:43:05.114467+08	10
194	16	2016-02-02 20:43:05.12021+08	11
195	41	2016-02-02 20:43:05.12551+08	8
196	14	2016-02-02 20:43:05.129781+08	15
197	32	2016-02-02 20:43:05.133645+08	12
198	40	2016-02-02 20:43:05.139551+08	13
199	19	2016-02-02 20:43:05.144036+08	7
200	21	2016-02-02 20:44:05.233854+08	7
201	56	2016-02-02 20:44:05.26711+08	10
202	22	2016-02-02 20:44:05.272186+08	9
203	32	2016-02-02 20:44:05.278058+08	12
204	43	2016-02-02 20:44:05.28395+08	8
205	13	2016-02-02 20:44:05.2888+08	15
206	40	2016-02-02 20:44:05.294234+08	13
207	21	2016-02-02 20:46:05.124445+08	7
208	41	2016-02-02 20:46:05.131891+08	8
209	23	2016-02-02 20:46:05.136258+08	9
210	56	2016-02-02 20:46:05.140424+08	10
211	39	2016-02-02 20:46:05.144503+08	13
212	12	2016-02-02 20:46:05.148615+08	15
213	33	2016-02-02 20:46:05.153539+08	12
214	58	2016-02-02 20:47:05.236919+08	10
215	22	2016-02-02 20:47:05.281933+08	9
216	39	2016-02-02 20:47:05.292237+08	13
217	18	2016-02-02 20:47:05.310241+08	7
218	29	2016-02-02 20:47:05.403267+08	12
219	40	2016-02-02 20:47:05.41559+08	8
220	10	2016-02-02 20:47:05.420034+08	15
221	53	2016-02-02 20:48:05.22028+08	8
222	29	2016-02-02 20:48:05.225715+08	7
223	56	2016-02-02 20:48:05.22986+08	10
224	38	2016-02-02 20:48:05.233768+08	13
225	34	2016-02-02 20:48:05.238232+08	9
226	42	2016-02-02 20:48:05.242214+08	12
227	12	2016-02-02 20:48:05.246149+08	15
228	30	2016-02-02 20:49:05.136715+08	7
229	58	2016-02-02 20:49:05.229008+08	10
230	38	2016-02-02 20:49:05.233956+08	13
231	33	2016-02-02 20:49:05.238653+08	9
232	42	2016-02-02 20:49:05.242928+08	12
233	9	2016-02-02 20:49:05.246925+08	15
234	52	2016-02-02 20:49:05.251123+08	8
\.


--
-- Name: api_currentstate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('api_currentstate_id_seq', 234, true);


--
-- Data for Name: api_house; Type: TABLE DATA; Schema: public; Owner: django
--

COPY api_house (id, "GroupID", "Name") FROM stdin;
8	LR	客廳
9	BR	主臥室
\.


--
-- Name: api_house_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('api_house_id_seq', 9, true);


--
-- Data for Name: api_ircommend; Type: TABLE DATA; Schema: public; Owner: django
--

COPY api_ircommend (id, "Commend", "RawCode", "NodeID_id") FROM stdin;
\.


--
-- Name: api_ircommend_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('api_ircommend_id_seq', 1, false);


--
-- Data for Name: api_nodes; Type: TABLE DATA; Schema: public; Owner: django
--

COPY api_nodes (id, "ID", "Address", "Type", "Appliances", "Added", "Updated", "Group_id") FROM stdin;
7	1	00 13 A2 00 40 EC 3A A4	N	Light	2016-02-02 18:51:08.446612+08	2016-02-02 18:51:08.446633+08	8
8	2	00 13 A2 00 40 EC 3A B7	N	Light	2016-02-02 18:51:33.828057+08	2016-02-02 18:51:33.828074+08	8
9	3	00 13 A2 00 40 EC 3A 97	N	Light	2016-02-02 18:51:53.185163+08	2016-02-02 18:51:53.18518+08	8
10	7	00 13 A2 00 40 B3 2D 4F	L	Light	2016-02-02 18:52:51.141089+08	2016-02-02 18:52:51.141109+08	8
11	9	00 13 A2 00 40 EC 3A BE	IR	TV	2016-02-02 18:53:19.967749+08	2016-02-02 18:53:19.967765+08	8
12	4	00 13 A2 00 40 B3 2D 41	N	Light	2016-02-02 18:53:48.799064+08	2016-02-02 18:53:48.79908+08	9
13	5	00 13 A2 00 40 EC 3A 98	N	Light	2016-02-02 18:54:09.395102+08	2016-02-02 18:54:09.395122+08	9
14	6	00 13 A2 00 40 B3 31 65	N	Light	2016-02-02 18:54:29.847202+08	2016-02-02 18:54:29.847223+08	9
15	8	00 13 A2 00 40 B3 2D 5B	L	Light	2016-02-02 18:54:55.933422+08	2016-02-02 18:54:55.933439+08	9
\.


--
-- Name: api_nodes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('api_nodes_id_seq', 15, true);


--
-- Data for Name: api_nodestate; Type: TABLE DATA; Schema: public; Owner: django
--

COPY api_nodestate (id, "State", "Added", "NodeID_id") FROM stdin;
94	1	2016-02-02 20:39:17.179165+08	14
95	0	2016-02-02 20:39:25.665928+08	14
96	0	2016-02-02 20:39:29.699478+08	13
97	1	2016-02-02 20:42:06.028167+08	14
98	0	2016-02-02 20:42:10.145456+08	14
99	1	2016-02-02 20:42:13.519696+08	14
100	0	2016-02-02 20:42:17.601392+08	14
101	0	2016-02-02 20:42:24.493442+08	13
102	1	2016-02-02 20:42:28.032145+08	13
103	0	2016-02-02 20:42:32.282999+08	13
104	1	2016-02-02 20:42:38.771882+08	14
105	0	2016-02-02 20:42:42.50564+08	14
106	0	2016-02-02 20:47:06.554464+08	7
107	0	2016-02-02 20:47:09.842645+08	8
108	0	2016-02-02 20:47:12.958146+08	9
109	0	2016-02-02 20:47:15.977226+08	12
110	0	2016-02-02 20:47:18.94281+08	13
111	0	2016-02-02 20:47:22.234902+08	14
112	0	2016-02-02 20:47:27.329811+08	10
113	0	2016-02-02 20:47:30.687121+08	15
114	ON	2016-02-02 20:47:40.951735+08	11
\.


--
-- Name: api_nodestate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('api_nodestate_id_seq', 114, true);


--
-- Data for Name: api_taskschedule; Type: TABLE DATA; Schema: public; Owner: django
--

COPY api_taskschedule (id, "triggerTime", "Commend", completed, queued, "NodeID_id") FROM stdin;
\.


--
-- Name: api_taskschedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('api_taskschedule_id_seq', 5, true);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: django
--

COPY auth_group (id, name) FROM stdin;
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('auth_group_id_seq', 1, false);


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: django
--

COPY auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('auth_group_permissions_id_seq', 1, false);


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: django
--

COPY auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add permission	1	add_permission
2	Can change permission	1	change_permission
3	Can delete permission	1	delete_permission
4	Can add group	2	add_group
5	Can change group	2	change_group
6	Can delete group	2	delete_group
7	Can add content type	3	add_contenttype
8	Can change content type	3	change_contenttype
9	Can delete content type	3	delete_contenttype
10	Can add session	4	add_session
11	Can change session	4	change_session
12	Can delete session	4	delete_session
13	Can add site	5	add_site
14	Can change site	5	change_site
15	Can delete site	5	delete_site
16	Can add log entry	6	add_logentry
17	Can change log entry	6	change_logentry
18	Can delete log entry	6	delete_logentry
19	Can add email address	7	add_emailaddress
20	Can change email address	7	change_emailaddress
21	Can delete email address	7	delete_emailaddress
22	Can add email confirmation	8	add_emailconfirmation
23	Can change email confirmation	8	change_emailconfirmation
24	Can delete email confirmation	8	delete_emailconfirmation
25	Can add social application	9	add_socialapp
26	Can change social application	9	change_socialapp
27	Can delete social application	9	delete_socialapp
28	Can add social account	10	add_socialaccount
29	Can change social account	10	change_socialaccount
30	Can delete social account	10	delete_socialaccount
31	Can add social application token	11	add_socialtoken
32	Can change social application token	11	change_socialtoken
33	Can delete social application token	11	delete_socialtoken
34	Can add user	12	add_user
35	Can change user	12	change_user
36	Can delete user	12	delete_user
37	Can add house	13	add_house
38	Can change house	13	change_house
39	Can delete house	13	delete_house
40	Can add nodes	14	add_nodes
41	Can change nodes	14	change_nodes
42	Can delete nodes	14	delete_nodes
43	Can add node state	15	add_nodestate
44	Can change node state	15	change_nodestate
45	Can delete node state	15	delete_nodestate
46	Can add current state	16	add_currentstate
47	Can change current state	16	change_currentstate
48	Can delete current state	16	delete_currentstate
49	Can add i rcommend	17	add_ircommend
50	Can change i rcommend	17	change_ircommend
51	Can delete i rcommend	17	delete_ircommend
52	Can add queue	18	add_queue
53	Can change queue	18	change_queue
54	Can delete queue	18	delete_queue
55	Can add message	19	add_message
56	Can change message	19	change_message
57	Can delete message	19	delete_message
58	Can add cors model	20	add_corsmodel
59	Can change cors model	20	change_corsmodel
60	Can delete cors model	20	delete_corsmodel
61	Can add task schedule	21	add_taskschedule
62	Can change task schedule	21	change_taskschedule
63	Can delete task schedule	21	delete_taskschedule
\.


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('auth_permission_id_seq', 63, true);


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: django
--

COPY django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('django_admin_log_id_seq', 1, false);


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: django
--

COPY django_content_type (id, app_label, model) FROM stdin;
1	auth	permission
2	auth	group
3	contenttypes	contenttype
4	sessions	session
5	sites	site
6	admin	logentry
7	account	emailaddress
8	account	emailconfirmation
9	socialaccount	socialapp
10	socialaccount	socialaccount
11	socialaccount	socialtoken
12	users	user
13	api	house
14	api	nodes
15	api	nodestate
16	api	currentstate
17	api	ircommend
18	kombu_transport_django	queue
19	kombu_transport_django	message
20	corsheaders	corsmodel
21	api	taskschedule
\.


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('django_content_type_id_seq', 21, true);


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: django
--

COPY django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2016-01-28 15:10:19.94833+08
2	contenttypes	0002_remove_content_type_name	2016-01-28 15:10:20.170288+08
3	auth	0001_initial	2016-01-28 15:10:20.45266+08
4	auth	0002_alter_permission_name_max_length	2016-01-28 15:10:20.499923+08
5	auth	0003_alter_user_email_max_length	2016-01-28 15:10:20.535515+08
6	auth	0004_alter_user_username_opts	2016-01-28 15:10:20.554771+08
7	auth	0005_alter_user_last_login_null	2016-01-28 15:10:20.570631+08
8	auth	0006_require_contenttypes_0002	2016-01-28 15:10:20.573961+08
9	users	0001_initial	2016-01-28 15:10:20.65663+08
10	account	0001_initial	2016-01-28 15:10:20.852754+08
11	account	0002_email_max_length	2016-01-28 15:10:20.910535+08
12	admin	0001_initial	2016-01-28 15:10:21.100677+08
13	admin	0002_logentry_remove_auto_add	2016-01-28 15:10:21.130047+08
14	api	0001_initial	2016-01-28 15:10:21.373936+08
15	auth	0007_alter_validators_add_error_messages	2016-01-28 15:10:21.508714+08
16	kombu_transport_django	0001_initial	2016-01-28 15:10:21.597294+08
17	sessions	0001_initial	2016-01-28 15:10:21.616146+08
18	sites	0001_initial	2016-01-28 15:10:21.630075+08
19	sites	0002_set_site_domain_and_name	2016-01-28 15:10:21.655628+08
20	socialaccount	0001_initial	2016-01-28 15:10:21.961578+08
21	socialaccount	0002_token_max_lengths	2016-01-28 15:10:22.260302+08
22	api	0002_auto_20160129_1459	2016-01-29 15:14:57.644337+08
23	sites	0003_auto_20160129_1459	2016-01-29 15:27:39.632919+08
24	users	0002_auto_20160129_1459	2016-01-29 15:27:40.168601+08
25	api	0003_taskschedule	2016-02-01 21:12:40.768793+08
26	api	0004_auto_20160202_1846	2016-02-02 18:46:48.623358+08
\.


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('django_migrations_id_seq', 26, true);


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: django
--

COPY django_session (session_key, session_data, expire_date) FROM stdin;
cttblnsygjf27a1ubh15h3so0nbf6omr	MTM1ZGNlNGZkMTg0NTE0NTJlZGIwZWRmN2EyZGJiOGMzOWY2ZWI5Mzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6IjEiLCJfc2Vzc2lvbl9leHBpcnkiOjAsIl9hdXRoX3VzZXJfaGFzaCI6Ijg2MzczNzFmODMwM2NmZjRhZmVkNTA4NmU2MzAxYTkzN2U5NmFkZDUifQ==	2016-01-22 15:44:06.295355+08
\.


--
-- Data for Name: django_site; Type: TABLE DATA; Schema: public; Owner: django
--

COPY django_site (id, domain, name) FROM stdin;
1	smarthome.com	SmartHome
\.


--
-- Name: django_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('django_site_id_seq', 1, false);


--
-- Data for Name: djkombu_message; Type: TABLE DATA; Schema: public; Owner: django
--

COPY djkombu_message (id, visible, sent_at, payload, queue_id) FROM stdin;
1	f	2016-01-30 16:50:47.949432+08	{"properties": {"reply_to": "ab5b3eb6-d0e4-3e29-81d8-116bfe87ca20", "correlation_id": "1e84d713-f90e-4cbc-92eb-b5dc60aa84ce", "delivery_tag": "a265081a-62bb-4459-b0b9-b10365736cc1", "body_encoding": "base64", "delivery_info": {"exchange": "celery", "routing_key": "celery", "priority": 0}, "delivery_mode": 2}, "content-type": "application/x-python-serialize", "headers": {}, "content-encoding": "binary", "body": "gAJ9cQAoWAkAAABjYWxsYmFja3NxAU5YBwAAAHRhc2tzZXRxAk5YCQAAAHRpbWVsaW1pdHEDTk6GcQRYBwAAAGV4cGlyZXNxBU5YCAAAAGVycmJhY2tzcQZOWAQAAABhcmdzcQdYFAAAAFRoaXMgaXMganVzdCBhIHRlc3QhcQiFcQlYAwAAAGV0YXEKTlgHAAAAcmV0cmllc3ELSwBYAgAAAGlkcQxYJAAAADFlODRkNzEzLWY5MGUtNGNiYy05MmViLWI1ZGM2MGFhODRjZXENWAMAAAB1dGNxDohYBAAAAHRhc2txD1gZAAAAU21hcnRIb21lLm5vZGUudGFza3MudGVzdHEQWAYAAABrd2FyZ3NxEX1xElgFAAAAY2hvcmRxE051Lg=="}	1
2	f	2016-01-30 16:51:16.693618+08	{"properties": {"reply_to": "ab5b3eb6-d0e4-3e29-81d8-116bfe87ca20", "correlation_id": "17a06819-e1d6-4400-8cc4-13afe673d9a6", "delivery_tag": "2cf18540-bd66-4d8c-a348-96a1668f6e56", "body_encoding": "base64", "delivery_info": {"exchange": "celery", "routing_key": "celery", "priority": 0}, "delivery_mode": 2}, "content-type": "application/x-python-serialize", "headers": {}, "content-encoding": "binary", "body": "gAJ9cQAoWAkAAABjYWxsYmFja3NxAU5YBwAAAHRhc2tzZXRxAk5YCQAAAHRpbWVsaW1pdHEDTk6GcQRYBwAAAGV4cGlyZXNxBU5YCAAAAGVycmJhY2tzcQZOWAQAAABhcmdzcQdLAksKhnEIWAMAAABldGFxCU5YBwAAAHJldHJpZXNxCksAWAIAAABpZHELWCQAAAAxN2EwNjgxOS1lMWQ2LTQ0MDAtOGNjNC0xM2FmZTY3M2Q5YTZxDFgDAAAAdXRjcQ2IWAQAAAB0YXNrcQ5YHAAAAFNtYXJ0SG9tZS50YXNrYXBwLmNlbGVyeS5hZGRxD1gGAAAAa3dhcmdzcRB9cRFYBQAAAGNob3JkcRJOdS4="}	1
3	f	2016-01-30 16:51:26.384397+08	{"properties": {"reply_to": "ab5b3eb6-d0e4-3e29-81d8-116bfe87ca20", "correlation_id": "947670aa-ea2f-4636-90f9-798baaa9a6a9", "delivery_tag": "52fbe512-b72b-4bc4-9b78-62f2a86040e2", "body_encoding": "base64", "delivery_info": {"exchange": "celery", "routing_key": "celery", "priority": 0}, "delivery_mode": 2}, "content-type": "application/x-python-serialize", "headers": {}, "content-encoding": "binary", "body": "gAJ9cQAoWAkAAABjYWxsYmFja3NxAU5YBwAAAHRhc2tzZXRxAk5YCQAAAHRpbWVsaW1pdHEDTk6GcQRYBwAAAGV4cGlyZXNxBU5YCAAAAGVycmJhY2tzcQZOWAQAAABhcmdzcQdLAksChnEIWAMAAABldGFxCVggAAAAMjAxNi0wMS0zMFQxNjo1MzowNi4yMjQ1MjUrMDg6MDBxClgHAAAAcmV0cmllc3ELSwBYAgAAAGlkcQxYJAAAADk0NzY3MGFhLWVhMmYtNDYzNi05MGY5LTc5OGJhYWE5YTZhOXENWAMAAAB1dGNxDohYBAAAAHRhc2txD1gcAAAAU21hcnRIb21lLnRhc2thcHAuY2VsZXJ5LmFkZHEQWAYAAABrd2FyZ3NxEX1xElgFAAAAY2hvcmRxE051Lg=="}	1
4	f	2016-01-30 16:53:25.306924+08	{"properties": {"reply_to": "ab5b3eb6-d0e4-3e29-81d8-116bfe87ca20", "correlation_id": "5e4237f6-6aca-4856-9088-6c898b5e34d6", "delivery_tag": "9e352059-d44e-4c3d-a5b5-55ace4010fda", "body_encoding": "base64", "delivery_info": {"exchange": "celery", "routing_key": "celery", "priority": 0}, "delivery_mode": 2}, "content-type": "application/x-python-serialize", "headers": {}, "content-encoding": "binary", "body": "gAJ9cQAoWAkAAABjYWxsYmFja3NxAU5YBwAAAHRhc2tzZXRxAk5YCQAAAHRpbWVsaW1pdHEDTk6GcQRYBwAAAGV4cGlyZXNxBU5YCAAAAGVycmJhY2tzcQZOWAQAAABhcmdzcQdLAksChnEIWAMAAABldGFxCVggAAAAMjAxNi0wMS0zMFQxNjo1MzozNS4zMDIzNzUrMDg6MDBxClgHAAAAcmV0cmllc3ELSwBYAgAAAGlkcQxYJAAAADVlNDIzN2Y2LTZhY2EtNDg1Ni05MDg4LTZjODk4YjVlMzRkNnENWAMAAAB1dGNxDohYBAAAAHRhc2txD1gcAAAAU21hcnRIb21lLnRhc2thcHAuY2VsZXJ5LmFkZHEQWAYAAABrd2FyZ3NxEX1xElgFAAAAY2hvcmRxE051Lg=="}	1
5	f	2016-01-30 16:55:24.578351+08	{"properties": {"reply_to": "ab5b3eb6-d0e4-3e29-81d8-116bfe87ca20", "correlation_id": "d62b278e-d4c6-4c94-a6ff-265af9c162f5", "delivery_tag": "9fe8f73d-478a-406d-a3df-38055199f813", "body_encoding": "base64", "delivery_info": {"exchange": "celery", "routing_key": "celery", "priority": 0}, "delivery_mode": 2}, "content-type": "application/x-python-serialize", "headers": {}, "content-encoding": "binary", "body": "gAJ9cQAoWAkAAABjYWxsYmFja3NxAU5YBwAAAHRhc2tzZXRxAk5YCQAAAHRpbWVsaW1pdHEDTk6GcQRYBwAAAGV4cGlyZXNxBU5YCAAAAGVycmJhY2tzcQZOWAQAAABhcmdzcQdLAksChnEIWAMAAABldGFxCVggAAAAMjAxNi0wMS0zMFQxNjo1NTozNC41NzM0MDgrMDg6MDBxClgHAAAAcmV0cmllc3ELSwBYAgAAAGlkcQxYJAAAAGQ2MmIyNzhlLWQ0YzYtNGM5NC1hNmZmLTI2NWFmOWMxNjJmNXENWAMAAAB1dGNxDohYBAAAAHRhc2txD1gcAAAAU21hcnRIb21lLnRhc2thcHAuY2VsZXJ5LmFkZHEQWAYAAABrd2FyZ3NxEX1xElgFAAAAY2hvcmRxE051Lg=="}	1
6	f	2016-01-30 16:56:00.496776+08	{"content-type": "application/x-python-serialize", "content-encoding": "binary", "properties": {"delivery_tag": "bc61fcb2-2371-4f80-9eb1-c40bb6ecb312", "delivery_info": {"priority": 0, "routing_key": "celery", "exchange": "celery"}, "reply_to": "226b6a78-1e7e-31ff-9742-9f6e2d0f54c4", "correlation_id": "cd6ee7d6-93ad-4873-beb8-70eb2f2df314", "delivery_mode": 2, "body_encoding": "base64"}, "headers": {}, "body": "gAJ9cQAoWAgAAABlcnJiYWNrc3EBTlgDAAAAZXRhcQJOWAkAAAB0aW1lbGltaXRxA05OhnEEWAYAAABrd2FyZ3NxBX1xBlgEAAAAYXJnc3EHSwJLCoZxCFgHAAAAdGFza3NldHEJTlgCAAAAaWRxClgkAAAAY2Q2ZWU3ZDYtOTNhZC00ODczLWJlYjgtNzBlYjJmMmRmMzE0cQtYAwAAAHV0Y3EMiFgEAAAAdGFza3ENWBwAAABTbWFydEhvbWUudGFza2FwcC5jZWxlcnkuYWRkcQ5YBwAAAGV4cGlyZXNxD05YBwAAAHJldHJpZXNxEEsAWAUAAABjaG9yZHERTlgJAAAAY2FsbGJhY2tzcRJOdS4="}	1
7	f	2016-01-30 16:56:03.003121+08	{"content-type": "application/x-python-serialize", "content-encoding": "binary", "properties": {"delivery_tag": "52d525e5-1aba-4645-b4e0-2b8ea2d6e06b", "delivery_info": {"priority": 0, "routing_key": "celery", "exchange": "celery"}, "reply_to": "226b6a78-1e7e-31ff-9742-9f6e2d0f54c4", "correlation_id": "96abe95a-3c9f-40e6-a528-91be7209e1c6", "delivery_mode": 2, "body_encoding": "base64"}, "headers": {}, "body": "gAJ9cQAoWAgAAABlcnJiYWNrc3EBTlgDAAAAZXRhcQJOWAkAAAB0aW1lbGltaXRxA05OhnEEWAYAAABrd2FyZ3NxBX1xBlgEAAAAYXJnc3EHSwJLCoZxCFgHAAAAdGFza3NldHEJTlgCAAAAaWRxClgkAAAAOTZhYmU5NWEtM2M5Zi00MGU2LWE1MjgtOTFiZTcyMDllMWM2cQtYAwAAAHV0Y3EMiFgEAAAAdGFza3ENWBwAAABTbWFydEhvbWUudGFza2FwcC5jZWxlcnkuYWRkcQ5YBwAAAGV4cGlyZXNxD05YBwAAAHJldHJpZXNxEEsAWAUAAABjaG9yZHERTlgJAAAAY2FsbGJhY2tzcRJOdS4="}	1
8	f	2016-01-30 16:56:04.07123+08	{"content-type": "application/x-python-serialize", "content-encoding": "binary", "properties": {"delivery_tag": "e554ed19-503b-40a8-a880-fb385bcc9ada", "delivery_info": {"priority": 0, "routing_key": "celery", "exchange": "celery"}, "reply_to": "226b6a78-1e7e-31ff-9742-9f6e2d0f54c4", "correlation_id": "ea5dbeda-5fae-42fa-87f3-e2b082086c8e", "delivery_mode": 2, "body_encoding": "base64"}, "headers": {}, "body": "gAJ9cQAoWAgAAABlcnJiYWNrc3EBTlgDAAAAZXRhcQJOWAkAAAB0aW1lbGltaXRxA05OhnEEWAYAAABrd2FyZ3NxBX1xBlgEAAAAYXJnc3EHSwJLCoZxCFgHAAAAdGFza3NldHEJTlgCAAAAaWRxClgkAAAAZWE1ZGJlZGEtNWZhZS00MmZhLTg3ZjMtZTJiMDgyMDg2YzhlcQtYAwAAAHV0Y3EMiFgEAAAAdGFza3ENWBwAAABTbWFydEhvbWUudGFza2FwcC5jZWxlcnkuYWRkcQ5YBwAAAGV4cGlyZXNxD05YBwAAAHJldHJpZXNxEEsAWAUAAABjaG9yZHERTlgJAAAAY2FsbGJhY2tzcRJOdS4="}	1
9	f	2016-01-30 16:56:05.055101+08	{"content-type": "application/x-python-serialize", "content-encoding": "binary", "properties": {"delivery_tag": "2c8f998d-dfd0-45cf-bc12-54a094001851", "delivery_info": {"priority": 0, "routing_key": "celery", "exchange": "celery"}, "reply_to": "226b6a78-1e7e-31ff-9742-9f6e2d0f54c4", "correlation_id": "ad7c9b29-e398-40f0-97b3-9d96fdd83455", "delivery_mode": 2, "body_encoding": "base64"}, "headers": {}, "body": "gAJ9cQAoWAgAAABlcnJiYWNrc3EBTlgDAAAAZXRhcQJOWAkAAAB0aW1lbGltaXRxA05OhnEEWAYAAABrd2FyZ3NxBX1xBlgEAAAAYXJnc3EHSwJLCoZxCFgHAAAAdGFza3NldHEJTlgCAAAAaWRxClgkAAAAYWQ3YzliMjktZTM5OC00MGYwLTk3YjMtOWQ5NmZkZDgzNDU1cQtYAwAAAHV0Y3EMiFgEAAAAdGFza3ENWBwAAABTbWFydEhvbWUudGFza2FwcC5jZWxlcnkuYWRkcQ5YBwAAAGV4cGlyZXNxD05YBwAAAHJldHJpZXNxEEsAWAUAAABjaG9yZHERTlgJAAAAY2FsbGJhY2tzcRJOdS4="}	1
10	f	2016-01-30 16:56:05.855052+08	{"content-type": "application/x-python-serialize", "content-encoding": "binary", "properties": {"delivery_tag": "ab94f345-5621-44db-a50b-fb5d0aa08975", "delivery_info": {"priority": 0, "routing_key": "celery", "exchange": "celery"}, "reply_to": "226b6a78-1e7e-31ff-9742-9f6e2d0f54c4", "correlation_id": "c9368ad6-48ae-4b4e-9570-d4cb12a4c027", "delivery_mode": 2, "body_encoding": "base64"}, "headers": {}, "body": "gAJ9cQAoWAgAAABlcnJiYWNrc3EBTlgDAAAAZXRhcQJOWAkAAAB0aW1lbGltaXRxA05OhnEEWAYAAABrd2FyZ3NxBX1xBlgEAAAAYXJnc3EHSwJLCoZxCFgHAAAAdGFza3NldHEJTlgCAAAAaWRxClgkAAAAYzkzNjhhZDYtNDhhZS00YjRlLTk1NzAtZDRjYjEyYTRjMDI3cQtYAwAAAHV0Y3EMiFgEAAAAdGFza3ENWBwAAABTbWFydEhvbWUudGFza2FwcC5jZWxlcnkuYWRkcQ5YBwAAAGV4cGlyZXNxD05YBwAAAHJldHJpZXNxEEsAWAUAAABjaG9yZHERTlgJAAAAY2FsbGJhY2tzcRJOdS4="}	1
11	f	2016-01-31 17:26:33.883064+08	{"content-encoding": "binary", "properties": {"reply_to": "5a252549-2de7-36ca-a01d-b52001f99a70", "body_encoding": "base64", "delivery_mode": 2, "delivery_info": {"routing_key": "celery", "priority": 0, "exchange": "celery"}, "delivery_tag": "31987bd3-8098-44bf-a76f-3956ada6cb62", "correlation_id": "1c3e5238-cff9-4e87-9a16-b630b9746cb2"}, "headers": {}, "content-type": "application/x-python-serialize", "body": "gAJ9cQAoWAQAAABhcmdzcQFLAksKhnECWAIAAABpZHEDWCQAAAAxYzNlNTIzOC1jZmY5LTRlODctOWExNi1iNjMwYjk3NDZjYjJxBFgHAAAAZXhwaXJlc3EFTlgEAAAAdGFza3EGWBwAAABTbWFydEhvbWUudGFza2FwcC5jZWxlcnkuYWRkcQdYCQAAAHRpbWVsaW1pdHEITk6GcQlYCAAAAGVycmJhY2tzcQpOWAYAAABrd2FyZ3NxC31xDFgDAAAAdXRjcQ2IWAUAAABjaG9yZHEOTlgJAAAAY2FsbGJhY2tzcQ9OWAcAAAByZXRyaWVzcRBLAFgDAAAAZXRhcRFOWAcAAAB0YXNrc2V0cRJOdS4="}	1
\.


--
-- Name: djkombu_message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('djkombu_message_id_seq', 11, true);


--
-- Data for Name: djkombu_queue; Type: TABLE DATA; Schema: public; Owner: django
--

COPY djkombu_queue (id, name) FROM stdin;
1	celery
2	celery@MacBook-Pro.local.celery.pidbox
\.


--
-- Name: djkombu_queue_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('djkombu_queue_id_seq', 2, true);


--
-- Data for Name: socialaccount_socialaccount; Type: TABLE DATA; Schema: public; Owner: django
--

COPY socialaccount_socialaccount (id, provider, uid, last_login, date_joined, extra_data, user_id) FROM stdin;
\.


--
-- Name: socialaccount_socialaccount_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('socialaccount_socialaccount_id_seq', 1, false);


--
-- Data for Name: socialaccount_socialapp; Type: TABLE DATA; Schema: public; Owner: django
--

COPY socialaccount_socialapp (id, provider, name, client_id, secret, key) FROM stdin;
\.


--
-- Name: socialaccount_socialapp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('socialaccount_socialapp_id_seq', 1, false);


--
-- Data for Name: socialaccount_socialapp_sites; Type: TABLE DATA; Schema: public; Owner: django
--

COPY socialaccount_socialapp_sites (id, socialapp_id, site_id) FROM stdin;
\.


--
-- Name: socialaccount_socialapp_sites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('socialaccount_socialapp_sites_id_seq', 1, false);


--
-- Data for Name: socialaccount_socialtoken; Type: TABLE DATA; Schema: public; Owner: django
--

COPY socialaccount_socialtoken (id, token, token_secret, expires_at, account_id, app_id) FROM stdin;
\.


--
-- Name: socialaccount_socialtoken_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('socialaccount_socialtoken_id_seq', 1, false);


--
-- Data for Name: users_user; Type: TABLE DATA; Schema: public; Owner: django
--

COPY users_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined, name) FROM stdin;
1	pbkdf2_sha256$24000$leTO4YZoaJ8s$/tu4+KduVEsRDgfWCwa0EbjvM2ZmYJUlkbF8jZH1V3c=	2016-01-08 15:44:06.239949+08	t	Teambaymax			kuo77122@gmail.com	t	t	2016-01-07 14:31:42.208317+08	
\.


--
-- Data for Name: users_user_groups; Type: TABLE DATA; Schema: public; Owner: django
--

COPY users_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Name: users_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('users_user_groups_id_seq', 1, false);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('users_user_id_seq', 1, true);


--
-- Data for Name: users_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: django
--

COPY users_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Name: users_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('users_user_user_permissions_id_seq', 1, false);


--
-- Name: account_emailaddress_email_key; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY account_emailaddress
    ADD CONSTRAINT account_emailaddress_email_key UNIQUE (email);


--
-- Name: account_emailaddress_pkey; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY account_emailaddress
    ADD CONSTRAINT account_emailaddress_pkey PRIMARY KEY (id);


--
-- Name: account_emailconfirmation_key_key; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY account_emailconfirmation
    ADD CONSTRAINT account_emailconfirmation_key_key UNIQUE (key);


--
-- Name: account_emailconfirmation_pkey; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY account_emailconfirmation
    ADD CONSTRAINT account_emailconfirmation_pkey PRIMARY KEY (id);


--
-- Name: api_currentstate_pkey; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY api_currentstate
    ADD CONSTRAINT api_currentstate_pkey PRIMARY KEY (id);


--
-- Name: api_house_pkey; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY api_house
    ADD CONSTRAINT api_house_pkey PRIMARY KEY (id);


--
-- Name: api_ircommend_pkey; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY api_ircommend
    ADD CONSTRAINT api_ircommend_pkey PRIMARY KEY (id);


--
-- Name: api_nodes_pkey; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY api_nodes
    ADD CONSTRAINT api_nodes_pkey PRIMARY KEY (id);


--
-- Name: api_nodestate_pkey; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY api_nodestate
    ADD CONSTRAINT api_nodestate_pkey PRIMARY KEY (id);


--
-- Name: api_taskschedule_pkey; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY api_taskschedule
    ADD CONSTRAINT api_taskschedule_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions_group_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission_content_type_id_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type_app_label_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_app_label_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: django_site_domain_a2e37b91_uniq; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY django_site
    ADD CONSTRAINT django_site_domain_a2e37b91_uniq UNIQUE (domain);


--
-- Name: django_site_pkey; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY django_site
    ADD CONSTRAINT django_site_pkey PRIMARY KEY (id);


--
-- Name: djkombu_message_pkey; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY djkombu_message
    ADD CONSTRAINT djkombu_message_pkey PRIMARY KEY (id);


--
-- Name: djkombu_queue_name_key; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY djkombu_queue
    ADD CONSTRAINT djkombu_queue_name_key UNIQUE (name);


--
-- Name: djkombu_queue_pkey; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY djkombu_queue
    ADD CONSTRAINT djkombu_queue_pkey PRIMARY KEY (id);


--
-- Name: socialaccount_socialaccount_pkey; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY socialaccount_socialaccount
    ADD CONSTRAINT socialaccount_socialaccount_pkey PRIMARY KEY (id);


--
-- Name: socialaccount_socialaccount_provider_fc810c6e_uniq; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY socialaccount_socialaccount
    ADD CONSTRAINT socialaccount_socialaccount_provider_fc810c6e_uniq UNIQUE (provider, uid);


--
-- Name: socialaccount_socialapp_pkey; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY socialaccount_socialapp
    ADD CONSTRAINT socialaccount_socialapp_pkey PRIMARY KEY (id);


--
-- Name: socialaccount_socialapp_sites_pkey; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY socialaccount_socialapp_sites
    ADD CONSTRAINT socialaccount_socialapp_sites_pkey PRIMARY KEY (id);


--
-- Name: socialaccount_socialapp_sites_socialapp_id_71a9a768_uniq; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY socialaccount_socialapp_sites
    ADD CONSTRAINT socialaccount_socialapp_sites_socialapp_id_71a9a768_uniq UNIQUE (socialapp_id, site_id);


--
-- Name: socialaccount_socialtoken_app_id_fca4e0ac_uniq; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY socialaccount_socialtoken
    ADD CONSTRAINT socialaccount_socialtoken_app_id_fca4e0ac_uniq UNIQUE (app_id, account_id);


--
-- Name: socialaccount_socialtoken_pkey; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY socialaccount_socialtoken
    ADD CONSTRAINT socialaccount_socialtoken_pkey PRIMARY KEY (id);


--
-- Name: users_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY users_user_groups
    ADD CONSTRAINT users_user_groups_pkey PRIMARY KEY (id);


--
-- Name: users_user_groups_user_id_b88eab82_uniq; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY users_user_groups
    ADD CONSTRAINT users_user_groups_user_id_b88eab82_uniq UNIQUE (user_id, group_id);


--
-- Name: users_user_pkey; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY users_user
    ADD CONSTRAINT users_user_pkey PRIMARY KEY (id);


--
-- Name: users_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY users_user_user_permissions
    ADD CONSTRAINT users_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: users_user_user_permissions_user_id_43338c45_uniq; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY users_user_user_permissions
    ADD CONSTRAINT users_user_user_permissions_user_id_43338c45_uniq UNIQUE (user_id, permission_id);


--
-- Name: users_user_username_key; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY users_user
    ADD CONSTRAINT users_user_username_key UNIQUE (username);


--
-- Name: account_emailaddress_e8701ad4; Type: INDEX; Schema: public; Owner: django; Tablespace: 
--

CREATE INDEX account_emailaddress_e8701ad4 ON account_emailaddress USING btree (user_id);


--
-- Name: account_emailaddress_email_03be32b2_like; Type: INDEX; Schema: public; Owner: django; Tablespace: 
--

CREATE INDEX account_emailaddress_email_03be32b2_like ON account_emailaddress USING btree (email varchar_pattern_ops);


--
-- Name: account_emailconfirmation_6f1edeac; Type: INDEX; Schema: public; Owner: django; Tablespace: 
--

CREATE INDEX account_emailconfirmation_6f1edeac ON account_emailconfirmation USING btree (email_address_id);


--
-- Name: account_emailconfirmation_key_f43612bd_like; Type: INDEX; Schema: public; Owner: django; Tablespace: 
--

CREATE INDEX account_emailconfirmation_key_f43612bd_like ON account_emailconfirmation USING btree (key varchar_pattern_ops);


--
-- Name: api_currentstate_d8dbccc2; Type: INDEX; Schema: public; Owner: django; Tablespace: 
--

CREATE INDEX api_currentstate_d8dbccc2 ON api_currentstate USING btree ("NodeID_id");


--
-- Name: api_ircommend_d8dbccc2; Type: INDEX; Schema: public; Owner: django; Tablespace: 
--

CREATE INDEX api_ircommend_d8dbccc2 ON api_ircommend USING btree ("NodeID_id");


--
-- Name: api_nodes_fcce8521; Type: INDEX; Schema: public; Owner: django; Tablespace: 
--

CREATE INDEX api_nodes_fcce8521 ON api_nodes USING btree ("Group_id");


--
-- Name: api_nodestate_d8dbccc2; Type: INDEX; Schema: public; Owner: django; Tablespace: 
--

CREATE INDEX api_nodestate_d8dbccc2 ON api_nodestate USING btree ("NodeID_id");


--
-- Name: api_taskschedule_d8dbccc2; Type: INDEX; Schema: public; Owner: django; Tablespace: 
--

CREATE INDEX api_taskschedule_d8dbccc2 ON api_taskschedule USING btree ("NodeID_id");


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: django; Tablespace: 
--

CREATE INDEX auth_group_name_a6ea08ec_like ON auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_0e939a4f; Type: INDEX; Schema: public; Owner: django; Tablespace: 
--

CREATE INDEX auth_group_permissions_0e939a4f ON auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_8373b171; Type: INDEX; Schema: public; Owner: django; Tablespace: 
--

CREATE INDEX auth_group_permissions_8373b171 ON auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_417f1b1c; Type: INDEX; Schema: public; Owner: django; Tablespace: 
--

CREATE INDEX auth_permission_417f1b1c ON auth_permission USING btree (content_type_id);


--
-- Name: django_admin_log_417f1b1c; Type: INDEX; Schema: public; Owner: django; Tablespace: 
--

CREATE INDEX django_admin_log_417f1b1c ON django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_e8701ad4; Type: INDEX; Schema: public; Owner: django; Tablespace: 
--

CREATE INDEX django_admin_log_e8701ad4 ON django_admin_log USING btree (user_id);


--
-- Name: django_session_de54fa62; Type: INDEX; Schema: public; Owner: django; Tablespace: 
--

CREATE INDEX django_session_de54fa62 ON django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: django; Tablespace: 
--

CREATE INDEX django_session_session_key_c0390e0f_like ON django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: djkombu_message_46cf0e59; Type: INDEX; Schema: public; Owner: django; Tablespace: 
--

CREATE INDEX djkombu_message_46cf0e59 ON djkombu_message USING btree (visible);


--
-- Name: djkombu_message_75249aa1; Type: INDEX; Schema: public; Owner: django; Tablespace: 
--

CREATE INDEX djkombu_message_75249aa1 ON djkombu_message USING btree (queue_id);


--
-- Name: djkombu_message_df2f2974; Type: INDEX; Schema: public; Owner: django; Tablespace: 
--

CREATE INDEX djkombu_message_df2f2974 ON djkombu_message USING btree (sent_at);


--
-- Name: djkombu_queue_name_8b43c728_like; Type: INDEX; Schema: public; Owner: django; Tablespace: 
--

CREATE INDEX djkombu_queue_name_8b43c728_like ON djkombu_queue USING btree (name varchar_pattern_ops);


--
-- Name: socialaccount_socialaccount_e8701ad4; Type: INDEX; Schema: public; Owner: django; Tablespace: 
--

CREATE INDEX socialaccount_socialaccount_e8701ad4 ON socialaccount_socialaccount USING btree (user_id);


--
-- Name: socialaccount_socialapp_sites_9365d6e7; Type: INDEX; Schema: public; Owner: django; Tablespace: 
--

CREATE INDEX socialaccount_socialapp_sites_9365d6e7 ON socialaccount_socialapp_sites USING btree (site_id);


--
-- Name: socialaccount_socialapp_sites_fe95b0a0; Type: INDEX; Schema: public; Owner: django; Tablespace: 
--

CREATE INDEX socialaccount_socialapp_sites_fe95b0a0 ON socialaccount_socialapp_sites USING btree (socialapp_id);


--
-- Name: socialaccount_socialtoken_8a089c2a; Type: INDEX; Schema: public; Owner: django; Tablespace: 
--

CREATE INDEX socialaccount_socialtoken_8a089c2a ON socialaccount_socialtoken USING btree (account_id);


--
-- Name: socialaccount_socialtoken_f382adfe; Type: INDEX; Schema: public; Owner: django; Tablespace: 
--

CREATE INDEX socialaccount_socialtoken_f382adfe ON socialaccount_socialtoken USING btree (app_id);


--
-- Name: users_user_groups_0e939a4f; Type: INDEX; Schema: public; Owner: django; Tablespace: 
--

CREATE INDEX users_user_groups_0e939a4f ON users_user_groups USING btree (group_id);


--
-- Name: users_user_groups_e8701ad4; Type: INDEX; Schema: public; Owner: django; Tablespace: 
--

CREATE INDEX users_user_groups_e8701ad4 ON users_user_groups USING btree (user_id);


--
-- Name: users_user_user_permissions_8373b171; Type: INDEX; Schema: public; Owner: django; Tablespace: 
--

CREATE INDEX users_user_user_permissions_8373b171 ON users_user_user_permissions USING btree (permission_id);


--
-- Name: users_user_user_permissions_e8701ad4; Type: INDEX; Schema: public; Owner: django; Tablespace: 
--

CREATE INDEX users_user_user_permissions_e8701ad4 ON users_user_user_permissions USING btree (user_id);


--
-- Name: users_user_username_06e46fe6_like; Type: INDEX; Schema: public; Owner: django; Tablespace: 
--

CREATE INDEX users_user_username_06e46fe6_like ON users_user USING btree (username varchar_pattern_ops);


--
-- Name: account_em_email_address_id_5b7f8c58_fk_account_emailaddress_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY account_emailconfirmation
    ADD CONSTRAINT account_em_email_address_id_5b7f8c58_fk_account_emailaddress_id FOREIGN KEY (email_address_id) REFERENCES account_emailaddress(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_emailaddress_user_id_2c513194_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY account_emailaddress
    ADD CONSTRAINT account_emailaddress_user_id_2c513194_fk_users_user_id FOREIGN KEY (user_id) REFERENCES users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_currentstate_NodeID_id_33593d77_fk_api_nodes_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY api_currentstate
    ADD CONSTRAINT "api_currentstate_NodeID_id_33593d77_fk_api_nodes_id" FOREIGN KEY ("NodeID_id") REFERENCES api_nodes(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_ircommend_NodeID_id_dfa2c9fc_fk_api_nodes_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY api_ircommend
    ADD CONSTRAINT "api_ircommend_NodeID_id_dfa2c9fc_fk_api_nodes_id" FOREIGN KEY ("NodeID_id") REFERENCES api_nodes(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_nodes_Group_id_bf8502e0_fk_api_house_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY api_nodes
    ADD CONSTRAINT "api_nodes_Group_id_bf8502e0_fk_api_house_id" FOREIGN KEY ("Group_id") REFERENCES api_house(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_nodestate_NodeID_id_e99dde0a_fk_api_nodes_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY api_nodestate
    ADD CONSTRAINT "api_nodestate_NodeID_id_e99dde0a_fk_api_nodes_id" FOREIGN KEY ("NodeID_id") REFERENCES api_nodes(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_taskschedule_NodeID_id_4b208b5b_fk_api_nodes_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY api_taskschedule
    ADD CONSTRAINT "api_taskschedule_NodeID_id_4b208b5b_fk_api_nodes_id" FOREIGN KEY ("NodeID_id") REFERENCES api_nodes(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permiss_permission_id_84c5c92e_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permiss_permission_id_84c5c92e_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permiss_content_type_id_2f476e4b_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permiss_content_type_id_2f476e4b_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_content_type_id_c4bce8eb_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_content_type_id_c4bce8eb_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log_user_id_c564eba6_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_users_user_id FOREIGN KEY (user_id) REFERENCES users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: djkombu_message_queue_id_38d205a7_fk_djkombu_queue_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY djkombu_message
    ADD CONSTRAINT djkombu_message_queue_id_38d205a7_fk_djkombu_queue_id FOREIGN KEY (queue_id) REFERENCES djkombu_queue(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialacc_account_id_951f210e_fk_socialaccount_socialaccount_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY socialaccount_socialtoken
    ADD CONSTRAINT socialacc_account_id_951f210e_fk_socialaccount_socialaccount_id FOREIGN KEY (account_id) REFERENCES socialaccount_socialaccount(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialaccou_socialapp_id_97fb6e7d_fk_socialaccount_socialapp_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY socialaccount_socialapp_sites
    ADD CONSTRAINT socialaccou_socialapp_id_97fb6e7d_fk_socialaccount_socialapp_id FOREIGN KEY (socialapp_id) REFERENCES socialaccount_socialapp(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialaccount_soc_app_id_636a42d7_fk_socialaccount_socialapp_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY socialaccount_socialtoken
    ADD CONSTRAINT socialaccount_soc_app_id_636a42d7_fk_socialaccount_socialapp_id FOREIGN KEY (app_id) REFERENCES socialaccount_socialapp(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialaccount_socialaccount_user_id_8146e70c_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY socialaccount_socialaccount
    ADD CONSTRAINT socialaccount_socialaccount_user_id_8146e70c_fk_users_user_id FOREIGN KEY (user_id) REFERENCES users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialaccount_socialapp_site_site_id_2579dee5_fk_django_site_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY socialaccount_socialapp_sites
    ADD CONSTRAINT socialaccount_socialapp_site_site_id_2579dee5_fk_django_site_id FOREIGN KEY (site_id) REFERENCES django_site(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user_groups_group_id_9afc8d0e_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY users_user_groups
    ADD CONSTRAINT users_user_groups_group_id_9afc8d0e_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user_groups_user_id_5f6f5a90_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY users_user_groups
    ADD CONSTRAINT users_user_groups_user_id_5f6f5a90_fk_users_user_id FOREIGN KEY (user_id) REFERENCES users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user_user_pe_permission_id_0b93982e_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY users_user_user_permissions
    ADD CONSTRAINT users_user_user_pe_permission_id_0b93982e_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user_user_permissions_user_id_20aca447_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY users_user_user_permissions
    ADD CONSTRAINT users_user_user_permissions_user_id_20aca447_fk_users_user_id FOREIGN KEY (user_id) REFERENCES users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: public; Type: ACL; Schema: -; Owner: SamKuo
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM "SamKuo";
GRANT ALL ON SCHEMA public TO "SamKuo";
GRANT ALL ON SCHEMA public TO PUBLIC;
GRANT ALL ON SCHEMA public TO django;


--
-- Name: account_emailaddress; Type: ACL; Schema: public; Owner: django
--

REVOKE ALL ON TABLE account_emailaddress FROM PUBLIC;
REVOKE ALL ON TABLE account_emailaddress FROM django;
GRANT ALL ON TABLE account_emailaddress TO django;


--
-- Name: account_emailaddress_id_seq; Type: ACL; Schema: public; Owner: django
--

REVOKE ALL ON SEQUENCE account_emailaddress_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE account_emailaddress_id_seq FROM django;
GRANT ALL ON SEQUENCE account_emailaddress_id_seq TO django;


--
-- Name: account_emailconfirmation; Type: ACL; Schema: public; Owner: django
--

REVOKE ALL ON TABLE account_emailconfirmation FROM PUBLIC;
REVOKE ALL ON TABLE account_emailconfirmation FROM django;
GRANT ALL ON TABLE account_emailconfirmation TO django;


--
-- Name: account_emailconfirmation_id_seq; Type: ACL; Schema: public; Owner: django
--

REVOKE ALL ON SEQUENCE account_emailconfirmation_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE account_emailconfirmation_id_seq FROM django;
GRANT ALL ON SEQUENCE account_emailconfirmation_id_seq TO django;


--
-- Name: api_currentstate; Type: ACL; Schema: public; Owner: django
--

REVOKE ALL ON TABLE api_currentstate FROM PUBLIC;
REVOKE ALL ON TABLE api_currentstate FROM django;
GRANT ALL ON TABLE api_currentstate TO django;


--
-- Name: api_currentstate_id_seq; Type: ACL; Schema: public; Owner: django
--

REVOKE ALL ON SEQUENCE api_currentstate_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE api_currentstate_id_seq FROM django;
GRANT ALL ON SEQUENCE api_currentstate_id_seq TO django;


--
-- Name: api_house; Type: ACL; Schema: public; Owner: django
--

REVOKE ALL ON TABLE api_house FROM PUBLIC;
REVOKE ALL ON TABLE api_house FROM django;
GRANT ALL ON TABLE api_house TO django;


--
-- Name: api_house_id_seq; Type: ACL; Schema: public; Owner: django
--

REVOKE ALL ON SEQUENCE api_house_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE api_house_id_seq FROM django;
GRANT ALL ON SEQUENCE api_house_id_seq TO django;


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
-- Name: api_nodestate; Type: ACL; Schema: public; Owner: django
--

REVOKE ALL ON TABLE api_nodestate FROM PUBLIC;
REVOKE ALL ON TABLE api_nodestate FROM django;
GRANT ALL ON TABLE api_nodestate TO django;


--
-- Name: api_nodestate_id_seq; Type: ACL; Schema: public; Owner: django
--

REVOKE ALL ON SEQUENCE api_nodestate_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE api_nodestate_id_seq FROM django;
GRANT ALL ON SEQUENCE api_nodestate_id_seq TO django;


--
-- Name: auth_group; Type: ACL; Schema: public; Owner: django
--

REVOKE ALL ON TABLE auth_group FROM PUBLIC;
REVOKE ALL ON TABLE auth_group FROM django;
GRANT ALL ON TABLE auth_group TO django;


--
-- Name: auth_group_id_seq; Type: ACL; Schema: public; Owner: django
--

REVOKE ALL ON SEQUENCE auth_group_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE auth_group_id_seq FROM django;
GRANT ALL ON SEQUENCE auth_group_id_seq TO django;


--
-- Name: auth_group_permissions; Type: ACL; Schema: public; Owner: django
--

REVOKE ALL ON TABLE auth_group_permissions FROM PUBLIC;
REVOKE ALL ON TABLE auth_group_permissions FROM django;
GRANT ALL ON TABLE auth_group_permissions TO django;


--
-- Name: auth_group_permissions_id_seq; Type: ACL; Schema: public; Owner: django
--

REVOKE ALL ON SEQUENCE auth_group_permissions_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE auth_group_permissions_id_seq FROM django;
GRANT ALL ON SEQUENCE auth_group_permissions_id_seq TO django;


--
-- Name: auth_permission; Type: ACL; Schema: public; Owner: django
--

REVOKE ALL ON TABLE auth_permission FROM PUBLIC;
REVOKE ALL ON TABLE auth_permission FROM django;
GRANT ALL ON TABLE auth_permission TO django;


--
-- Name: auth_permission_id_seq; Type: ACL; Schema: public; Owner: django
--

REVOKE ALL ON SEQUENCE auth_permission_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE auth_permission_id_seq FROM django;
GRANT ALL ON SEQUENCE auth_permission_id_seq TO django;


--
-- Name: django_admin_log; Type: ACL; Schema: public; Owner: django
--

REVOKE ALL ON TABLE django_admin_log FROM PUBLIC;
REVOKE ALL ON TABLE django_admin_log FROM django;
GRANT ALL ON TABLE django_admin_log TO django;


--
-- Name: django_admin_log_id_seq; Type: ACL; Schema: public; Owner: django
--

REVOKE ALL ON SEQUENCE django_admin_log_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE django_admin_log_id_seq FROM django;
GRANT ALL ON SEQUENCE django_admin_log_id_seq TO django;


--
-- Name: django_content_type; Type: ACL; Schema: public; Owner: django
--

REVOKE ALL ON TABLE django_content_type FROM PUBLIC;
REVOKE ALL ON TABLE django_content_type FROM django;
GRANT ALL ON TABLE django_content_type TO django;


--
-- Name: django_content_type_id_seq; Type: ACL; Schema: public; Owner: django
--

REVOKE ALL ON SEQUENCE django_content_type_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE django_content_type_id_seq FROM django;
GRANT ALL ON SEQUENCE django_content_type_id_seq TO django;


--
-- Name: django_migrations; Type: ACL; Schema: public; Owner: django
--

REVOKE ALL ON TABLE django_migrations FROM PUBLIC;
REVOKE ALL ON TABLE django_migrations FROM django;
GRANT ALL ON TABLE django_migrations TO django;


--
-- Name: django_migrations_id_seq; Type: ACL; Schema: public; Owner: django
--

REVOKE ALL ON SEQUENCE django_migrations_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE django_migrations_id_seq FROM django;
GRANT ALL ON SEQUENCE django_migrations_id_seq TO django;


--
-- Name: django_session; Type: ACL; Schema: public; Owner: django
--

REVOKE ALL ON TABLE django_session FROM PUBLIC;
REVOKE ALL ON TABLE django_session FROM django;
GRANT ALL ON TABLE django_session TO django;


--
-- Name: django_site; Type: ACL; Schema: public; Owner: django
--

REVOKE ALL ON TABLE django_site FROM PUBLIC;
REVOKE ALL ON TABLE django_site FROM django;
GRANT ALL ON TABLE django_site TO django;


--
-- Name: django_site_id_seq; Type: ACL; Schema: public; Owner: django
--

REVOKE ALL ON SEQUENCE django_site_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE django_site_id_seq FROM django;
GRANT ALL ON SEQUENCE django_site_id_seq TO django;


--
-- Name: djkombu_message; Type: ACL; Schema: public; Owner: django
--

REVOKE ALL ON TABLE djkombu_message FROM PUBLIC;
REVOKE ALL ON TABLE djkombu_message FROM django;
GRANT ALL ON TABLE djkombu_message TO django;


--
-- Name: djkombu_message_id_seq; Type: ACL; Schema: public; Owner: django
--

REVOKE ALL ON SEQUENCE djkombu_message_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE djkombu_message_id_seq FROM django;
GRANT ALL ON SEQUENCE djkombu_message_id_seq TO django;


--
-- Name: djkombu_queue; Type: ACL; Schema: public; Owner: django
--

REVOKE ALL ON TABLE djkombu_queue FROM PUBLIC;
REVOKE ALL ON TABLE djkombu_queue FROM django;
GRANT ALL ON TABLE djkombu_queue TO django;


--
-- Name: djkombu_queue_id_seq; Type: ACL; Schema: public; Owner: django
--

REVOKE ALL ON SEQUENCE djkombu_queue_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE djkombu_queue_id_seq FROM django;
GRANT ALL ON SEQUENCE djkombu_queue_id_seq TO django;


--
-- Name: socialaccount_socialaccount; Type: ACL; Schema: public; Owner: django
--

REVOKE ALL ON TABLE socialaccount_socialaccount FROM PUBLIC;
REVOKE ALL ON TABLE socialaccount_socialaccount FROM django;
GRANT ALL ON TABLE socialaccount_socialaccount TO django;


--
-- Name: socialaccount_socialaccount_id_seq; Type: ACL; Schema: public; Owner: django
--

REVOKE ALL ON SEQUENCE socialaccount_socialaccount_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE socialaccount_socialaccount_id_seq FROM django;
GRANT ALL ON SEQUENCE socialaccount_socialaccount_id_seq TO django;


--
-- Name: socialaccount_socialapp; Type: ACL; Schema: public; Owner: django
--

REVOKE ALL ON TABLE socialaccount_socialapp FROM PUBLIC;
REVOKE ALL ON TABLE socialaccount_socialapp FROM django;
GRANT ALL ON TABLE socialaccount_socialapp TO django;


--
-- Name: socialaccount_socialapp_id_seq; Type: ACL; Schema: public; Owner: django
--

REVOKE ALL ON SEQUENCE socialaccount_socialapp_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE socialaccount_socialapp_id_seq FROM django;
GRANT ALL ON SEQUENCE socialaccount_socialapp_id_seq TO django;


--
-- Name: socialaccount_socialapp_sites; Type: ACL; Schema: public; Owner: django
--

REVOKE ALL ON TABLE socialaccount_socialapp_sites FROM PUBLIC;
REVOKE ALL ON TABLE socialaccount_socialapp_sites FROM django;
GRANT ALL ON TABLE socialaccount_socialapp_sites TO django;


--
-- Name: socialaccount_socialapp_sites_id_seq; Type: ACL; Schema: public; Owner: django
--

REVOKE ALL ON SEQUENCE socialaccount_socialapp_sites_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE socialaccount_socialapp_sites_id_seq FROM django;
GRANT ALL ON SEQUENCE socialaccount_socialapp_sites_id_seq TO django;


--
-- Name: socialaccount_socialtoken; Type: ACL; Schema: public; Owner: django
--

REVOKE ALL ON TABLE socialaccount_socialtoken FROM PUBLIC;
REVOKE ALL ON TABLE socialaccount_socialtoken FROM django;
GRANT ALL ON TABLE socialaccount_socialtoken TO django;


--
-- Name: socialaccount_socialtoken_id_seq; Type: ACL; Schema: public; Owner: django
--

REVOKE ALL ON SEQUENCE socialaccount_socialtoken_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE socialaccount_socialtoken_id_seq FROM django;
GRANT ALL ON SEQUENCE socialaccount_socialtoken_id_seq TO django;


--
-- Name: users_user; Type: ACL; Schema: public; Owner: django
--

REVOKE ALL ON TABLE users_user FROM PUBLIC;
REVOKE ALL ON TABLE users_user FROM django;
GRANT ALL ON TABLE users_user TO django;


--
-- Name: users_user_groups; Type: ACL; Schema: public; Owner: django
--

REVOKE ALL ON TABLE users_user_groups FROM PUBLIC;
REVOKE ALL ON TABLE users_user_groups FROM django;
GRANT ALL ON TABLE users_user_groups TO django;


--
-- Name: users_user_groups_id_seq; Type: ACL; Schema: public; Owner: django
--

REVOKE ALL ON SEQUENCE users_user_groups_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE users_user_groups_id_seq FROM django;
GRANT ALL ON SEQUENCE users_user_groups_id_seq TO django;


--
-- Name: users_user_id_seq; Type: ACL; Schema: public; Owner: django
--

REVOKE ALL ON SEQUENCE users_user_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE users_user_id_seq FROM django;
GRANT ALL ON SEQUENCE users_user_id_seq TO django;


--
-- Name: users_user_user_permissions; Type: ACL; Schema: public; Owner: django
--

REVOKE ALL ON TABLE users_user_user_permissions FROM PUBLIC;
REVOKE ALL ON TABLE users_user_user_permissions FROM django;
GRANT ALL ON TABLE users_user_user_permissions TO django;


--
-- Name: users_user_user_permissions_id_seq; Type: ACL; Schema: public; Owner: django
--

REVOKE ALL ON SEQUENCE users_user_user_permissions_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE users_user_user_permissions_id_seq FROM django;
GRANT ALL ON SEQUENCE users_user_user_permissions_id_seq TO django;


--
-- PostgreSQL database dump complete
--

