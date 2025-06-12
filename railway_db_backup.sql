--
-- PostgreSQL database dump
--

-- Dumped from database version 14.11
-- Dumped by pg_dump version 14.11

-- Started on 2025-06-12 12:30:56

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
-- TOC entry 5 (class 2615 OID 363881)
-- Name: railway_system; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA railway_system;


ALTER SCHEMA railway_system OWNER TO postgres;

--
-- TOC entry 873 (class 1247 OID 363962)
-- Name: enum_booking_payment_status; Type: TYPE; Schema: railway_system; Owner: postgres
--

CREATE TYPE railway_system.enum_booking_payment_status AS ENUM (
    'Paid',
    'Unpaid'
);


ALTER TYPE railway_system.enum_booking_payment_status OWNER TO postgres;

--
-- TOC entry 876 (class 1247 OID 363991)
-- Name: enum_class_type_class_name; Type: TYPE; Schema: railway_system; Owner: postgres
--

CREATE TYPE railway_system.enum_class_type_class_name AS ENUM (
    'AC',
    'General',
    'Sleeper',
    'Ladies'
);


ALTER TYPE railway_system.enum_class_type_class_name OWNER TO postgres;

--
-- TOC entry 882 (class 1247 OID 364008)
-- Name: enum_payment_payment_method; Type: TYPE; Schema: railway_system; Owner: postgres
--

CREATE TYPE railway_system.enum_payment_payment_method AS ENUM (
    'Credit Card',
    'UPI',
    'Net Banking'
);


ALTER TYPE railway_system.enum_payment_payment_method OWNER TO postgres;

--
-- TOC entry 885 (class 1247 OID 364016)
-- Name: enum_payment_payment_status; Type: TYPE; Schema: railway_system; Owner: postgres
--

CREATE TYPE railway_system.enum_payment_payment_status AS ENUM (
    'Success',
    'Failed'
);


ALTER TYPE railway_system.enum_payment_payment_status OWNER TO postgres;

--
-- TOC entry 903 (class 1247 OID 395298)
-- Name: enum_person_berth_choice; Type: TYPE; Schema: railway_system; Owner: postgres
--

CREATE TYPE railway_system.enum_person_berth_choice AS ENUM (
    'Upper',
    'Middle',
    'Lower'
);


ALTER TYPE railway_system.enum_person_berth_choice OWNER TO postgres;

--
-- TOC entry 900 (class 1247 OID 395291)
-- Name: enum_person_gender; Type: TYPE; Schema: railway_system; Owner: postgres
--

CREATE TYPE railway_system.enum_person_gender AS ENUM (
    'Female',
    'Male',
    'Transgender'
);


ALTER TYPE railway_system.enum_person_gender OWNER TO postgres;

--
-- TOC entry 858 (class 1247 OID 363883)
-- Name: enum_train_train_type; Type: TYPE; Schema: railway_system; Owner: postgres
--

CREATE TYPE railway_system.enum_train_train_type AS ENUM (
    'Express',
    'Passenger',
    'Local'
);


ALTER TYPE railway_system.enum_train_train_type OWNER TO postgres;

--
-- TOC entry 864 (class 1247 OID 363900)
-- Name: enum_user_role; Type: TYPE; Schema: railway_system; Owner: postgres
--

CREATE TYPE railway_system.enum_user_role AS ENUM (
    'Admin',
    'User'
);


ALTER TYPE railway_system.enum_user_role OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 231 (class 1259 OID 395548)
-- Name: account; Type: TABLE; Schema: railway_system; Owner: postgres
--

CREATE TABLE railway_system.account (
    id integer NOT NULL,
    bank_name character varying(255) NOT NULL,
    account_number character varying(255) NOT NULL,
    ifsc_code character varying(255) NOT NULL,
    account_holder_name character varying(255) NOT NULL,
    phone_number character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    created_at timestamp with time zone,
    modified_at timestamp with time zone,
    is_deleted boolean DEFAULT false,
    booking_id integer
);


ALTER TABLE railway_system.account OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 395547)
-- Name: account_id_seq; Type: SEQUENCE; Schema: railway_system; Owner: postgres
--

CREATE SEQUENCE railway_system.account_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE railway_system.account_id_seq OWNER TO postgres;

--
-- TOC entry 3474 (class 0 OID 0)
-- Dependencies: 230
-- Name: account_id_seq; Type: SEQUENCE OWNED BY; Schema: railway_system; Owner: postgres
--

ALTER SEQUENCE railway_system.account_id_seq OWNED BY railway_system.account.id;


--
-- TOC entry 229 (class 1259 OID 395525)
-- Name: booking; Type: TABLE; Schema: railway_system; Owner: postgres
--

CREATE TABLE railway_system.booking (
    id integer NOT NULL,
    booking_date timestamp with time zone,
    persons_count integer NOT NULL,
    total_fare integer NOT NULL,
    price integer NOT NULL,
    additional_charge integer NOT NULL,
    created_at timestamp with time zone,
    modified_at timestamp with time zone,
    is_deleted boolean DEFAULT false,
    train_id integer,
    user_id integer,
    schedule_id integer
);


ALTER TABLE railway_system.booking OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 395524)
-- Name: booking_id_seq; Type: SEQUENCE; Schema: railway_system; Owner: postgres
--

CREATE SEQUENCE railway_system.booking_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE railway_system.booking_id_seq OWNER TO postgres;

--
-- TOC entry 3475 (class 0 OID 0)
-- Dependencies: 228
-- Name: booking_id_seq; Type: SEQUENCE OWNED BY; Schema: railway_system; Owner: postgres
--

ALTER SEQUENCE railway_system.booking_id_seq OWNED BY railway_system.booking.id;


--
-- TOC entry 217 (class 1259 OID 364000)
-- Name: class_type; Type: TABLE; Schema: railway_system; Owner: postgres
--

CREATE TABLE railway_system.class_type (
    id integer NOT NULL,
    class_name railway_system.enum_class_type_class_name NOT NULL,
    created_at timestamp with time zone,
    modified_at timestamp with time zone,
    is_deleted boolean DEFAULT false
);


ALTER TABLE railway_system.class_type OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 363999)
-- Name: class_type_id_seq; Type: SEQUENCE; Schema: railway_system; Owner: postgres
--

CREATE SEQUENCE railway_system.class_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE railway_system.class_type_id_seq OWNER TO postgres;

--
-- TOC entry 3476 (class 0 OID 0)
-- Dependencies: 216
-- Name: class_type_id_seq; Type: SEQUENCE OWNED BY; Schema: railway_system; Owner: postgres
--

ALTER SEQUENCE railway_system.class_type_id_seq OWNED BY railway_system.class_type.id;


--
-- TOC entry 233 (class 1259 OID 395563)
-- Name: payment; Type: TABLE; Schema: railway_system; Owner: postgres
--

CREATE TABLE railway_system.payment (
    id integer NOT NULL,
    amount integer NOT NULL,
    payment_date timestamp with time zone,
    payment_status railway_system.enum_payment_payment_status DEFAULT 'Success'::railway_system.enum_payment_payment_status NOT NULL,
    created_at timestamp with time zone,
    modified_at timestamp with time zone,
    is_deleted boolean DEFAULT false,
    booking_id integer
);


ALTER TABLE railway_system.payment OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 395562)
-- Name: payment_id_seq; Type: SEQUENCE; Schema: railway_system; Owner: postgres
--

CREATE SEQUENCE railway_system.payment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE railway_system.payment_id_seq OWNER TO postgres;

--
-- TOC entry 3477 (class 0 OID 0)
-- Dependencies: 232
-- Name: payment_id_seq; Type: SEQUENCE OWNED BY; Schema: railway_system; Owner: postgres
--

ALTER SEQUENCE railway_system.payment_id_seq OWNED BY railway_system.payment.id;


--
-- TOC entry 227 (class 1259 OID 395511)
-- Name: person; Type: TABLE; Schema: railway_system; Owner: postgres
--

CREATE TABLE railway_system.person (
    id integer NOT NULL,
    person_name character varying(255) NOT NULL,
    person_age integer NOT NULL,
    gender railway_system.enum_person_gender NOT NULL,
    berth_choice railway_system.enum_person_berth_choice NOT NULL,
    created_at timestamp with time zone,
    modified_at timestamp with time zone,
    is_deleted boolean DEFAULT false,
    booking_id integer
);


ALTER TABLE railway_system.person OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 395510)
-- Name: person_id_seq; Type: SEQUENCE; Schema: railway_system; Owner: postgres
--

CREATE SEQUENCE railway_system.person_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE railway_system.person_id_seq OWNER TO postgres;

--
-- TOC entry 3478 (class 0 OID 0)
-- Dependencies: 226
-- Name: person_id_seq; Type: SEQUENCE OWNED BY; Schema: railway_system; Owner: postgres
--

ALTER SEQUENCE railway_system.person_id_seq OWNED BY railway_system.person.id;


--
-- TOC entry 221 (class 1259 OID 364082)
-- Name: price; Type: TABLE; Schema: railway_system; Owner: postgres
--

CREATE TABLE railway_system.price (
    id integer NOT NULL,
    price integer NOT NULL,
    created_at timestamp with time zone,
    modified_at timestamp with time zone,
    is_deleted boolean DEFAULT false,
    schedule_id integer,
    class_type_id integer
);


ALTER TABLE railway_system.price OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 364081)
-- Name: price_id_seq; Type: SEQUENCE; Schema: railway_system; Owner: postgres
--

CREATE SEQUENCE railway_system.price_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE railway_system.price_id_seq OWNER TO postgres;

--
-- TOC entry 3479 (class 0 OID 0)
-- Dependencies: 220
-- Name: price_id_seq; Type: SEQUENCE OWNED BY; Schema: railway_system; Owner: postgres
--

ALTER SEQUENCE railway_system.price_id_seq OWNED BY railway_system.price.id;


--
-- TOC entry 225 (class 1259 OID 364138)
-- Name: routes; Type: TABLE; Schema: railway_system; Owner: postgres
--

CREATE TABLE railway_system.routes (
    id integer NOT NULL,
    arrival_time timestamp with time zone,
    departure_time timestamp with time zone,
    sequence_number integer NOT NULL,
    created_at timestamp with time zone,
    modified_at timestamp with time zone,
    is_deleted boolean DEFAULT false,
    train_id integer,
    station_id integer
);


ALTER TABLE railway_system.routes OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 364137)
-- Name: routes_id_seq; Type: SEQUENCE; Schema: railway_system; Owner: postgres
--

CREATE SEQUENCE railway_system.routes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE railway_system.routes_id_seq OWNER TO postgres;

--
-- TOC entry 3480 (class 0 OID 0)
-- Dependencies: 224
-- Name: routes_id_seq; Type: SEQUENCE OWNED BY; Schema: railway_system; Owner: postgres
--

ALTER SEQUENCE railway_system.routes_id_seq OWNED BY railway_system.routes.id;


--
-- TOC entry 215 (class 1259 OID 363944)
-- Name: schedule; Type: TABLE; Schema: railway_system; Owner: postgres
--

CREATE TABLE railway_system.schedule (
    id integer NOT NULL,
    date date,
    created_at timestamp with time zone,
    modified_at timestamp with time zone,
    is_deleted boolean DEFAULT false,
    routes_id integer,
    train_id integer
);


ALTER TABLE railway_system.schedule OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 363943)
-- Name: schedule_id_seq; Type: SEQUENCE; Schema: railway_system; Owner: postgres
--

CREATE SEQUENCE railway_system.schedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE railway_system.schedule_id_seq OWNER TO postgres;

--
-- TOC entry 3481 (class 0 OID 0)
-- Dependencies: 214
-- Name: schedule_id_seq; Type: SEQUENCE OWNED BY; Schema: railway_system; Owner: postgres
--

ALTER SEQUENCE railway_system.schedule_id_seq OWNED BY railway_system.schedule.id;


--
-- TOC entry 219 (class 1259 OID 364058)
-- Name: seat_availability; Type: TABLE; Schema: railway_system; Owner: postgres
--

CREATE TABLE railway_system.seat_availability (
    id integer NOT NULL,
    available_seats character varying(255) NOT NULL,
    created_at timestamp with time zone,
    modified_at timestamp with time zone,
    is_deleted boolean DEFAULT false,
    class_type_id integer,
    schedule_id integer,
    train_id integer
);


ALTER TABLE railway_system.seat_availability OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 364057)
-- Name: seat_availability_id_seq; Type: SEQUENCE; Schema: railway_system; Owner: postgres
--

CREATE SEQUENCE railway_system.seat_availability_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE railway_system.seat_availability_id_seq OWNER TO postgres;

--
-- TOC entry 3482 (class 0 OID 0)
-- Dependencies: 218
-- Name: seat_availability_id_seq; Type: SEQUENCE OWNED BY; Schema: railway_system; Owner: postgres
--

ALTER SEQUENCE railway_system.seat_availability_id_seq OWNED BY railway_system.seat_availability.id;


--
-- TOC entry 223 (class 1259 OID 364128)
-- Name: stations; Type: TABLE; Schema: railway_system; Owner: postgres
--

CREATE TABLE railway_system.stations (
    id integer NOT NULL,
    station_name character varying(255) NOT NULL,
    location character varying(255) NOT NULL,
    created_at timestamp with time zone,
    modified_at timestamp with time zone,
    is_deleted boolean DEFAULT false
);


ALTER TABLE railway_system.stations OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 364127)
-- Name: stations_id_seq; Type: SEQUENCE; Schema: railway_system; Owner: postgres
--

CREATE SEQUENCE railway_system.stations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE railway_system.stations_id_seq OWNER TO postgres;

--
-- TOC entry 3483 (class 0 OID 0)
-- Dependencies: 222
-- Name: stations_id_seq; Type: SEQUENCE OWNED BY; Schema: railway_system; Owner: postgres
--

ALTER SEQUENCE railway_system.stations_id_seq OWNED BY railway_system.stations.id;


--
-- TOC entry 211 (class 1259 OID 363890)
-- Name: train; Type: TABLE; Schema: railway_system; Owner: postgres
--

CREATE TABLE railway_system.train (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    train_number character varying(255) NOT NULL,
    train_type railway_system.enum_train_train_type NOT NULL,
    created_at timestamp with time zone,
    modified_at timestamp with time zone,
    is_deleted boolean DEFAULT false
);


ALTER TABLE railway_system.train OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 363889)
-- Name: train_id_seq; Type: SEQUENCE; Schema: railway_system; Owner: postgres
--

CREATE SEQUENCE railway_system.train_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE railway_system.train_id_seq OWNER TO postgres;

--
-- TOC entry 3484 (class 0 OID 0)
-- Dependencies: 210
-- Name: train_id_seq; Type: SEQUENCE OWNED BY; Schema: railway_system; Owner: postgres
--

ALTER SEQUENCE railway_system.train_id_seq OWNED BY railway_system.train.id;


--
-- TOC entry 213 (class 1259 OID 363906)
-- Name: user; Type: TABLE; Schema: railway_system; Owner: postgres
--

CREATE TABLE railway_system."user" (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    role railway_system.enum_user_role NOT NULL,
    phone_number character varying(255) NOT NULL,
    address character varying(255) NOT NULL,
    created_at timestamp with time zone,
    modified_at timestamp with time zone,
    is_deleted boolean DEFAULT false
);


ALTER TABLE railway_system."user" OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 363905)
-- Name: user_id_seq; Type: SEQUENCE; Schema: railway_system; Owner: postgres
--

CREATE SEQUENCE railway_system.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE railway_system.user_id_seq OWNER TO postgres;

--
-- TOC entry 3485 (class 0 OID 0)
-- Dependencies: 212
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: railway_system; Owner: postgres
--

ALTER SEQUENCE railway_system.user_id_seq OWNED BY railway_system."user".id;


--
-- TOC entry 3264 (class 2604 OID 395551)
-- Name: account id; Type: DEFAULT; Schema: railway_system; Owner: postgres
--

ALTER TABLE ONLY railway_system.account ALTER COLUMN id SET DEFAULT nextval('railway_system.account_id_seq'::regclass);


--
-- TOC entry 3262 (class 2604 OID 395528)
-- Name: booking id; Type: DEFAULT; Schema: railway_system; Owner: postgres
--

ALTER TABLE ONLY railway_system.booking ALTER COLUMN id SET DEFAULT nextval('railway_system.booking_id_seq'::regclass);


--
-- TOC entry 3250 (class 2604 OID 364003)
-- Name: class_type id; Type: DEFAULT; Schema: railway_system; Owner: postgres
--

ALTER TABLE ONLY railway_system.class_type ALTER COLUMN id SET DEFAULT nextval('railway_system.class_type_id_seq'::regclass);


--
-- TOC entry 3266 (class 2604 OID 395566)
-- Name: payment id; Type: DEFAULT; Schema: railway_system; Owner: postgres
--

ALTER TABLE ONLY railway_system.payment ALTER COLUMN id SET DEFAULT nextval('railway_system.payment_id_seq'::regclass);


--
-- TOC entry 3260 (class 2604 OID 395514)
-- Name: person id; Type: DEFAULT; Schema: railway_system; Owner: postgres
--

ALTER TABLE ONLY railway_system.person ALTER COLUMN id SET DEFAULT nextval('railway_system.person_id_seq'::regclass);


--
-- TOC entry 3254 (class 2604 OID 364085)
-- Name: price id; Type: DEFAULT; Schema: railway_system; Owner: postgres
--

ALTER TABLE ONLY railway_system.price ALTER COLUMN id SET DEFAULT nextval('railway_system.price_id_seq'::regclass);


--
-- TOC entry 3258 (class 2604 OID 364141)
-- Name: routes id; Type: DEFAULT; Schema: railway_system; Owner: postgres
--

ALTER TABLE ONLY railway_system.routes ALTER COLUMN id SET DEFAULT nextval('railway_system.routes_id_seq'::regclass);


--
-- TOC entry 3248 (class 2604 OID 363947)
-- Name: schedule id; Type: DEFAULT; Schema: railway_system; Owner: postgres
--

ALTER TABLE ONLY railway_system.schedule ALTER COLUMN id SET DEFAULT nextval('railway_system.schedule_id_seq'::regclass);


--
-- TOC entry 3252 (class 2604 OID 364061)
-- Name: seat_availability id; Type: DEFAULT; Schema: railway_system; Owner: postgres
--

ALTER TABLE ONLY railway_system.seat_availability ALTER COLUMN id SET DEFAULT nextval('railway_system.seat_availability_id_seq'::regclass);


--
-- TOC entry 3256 (class 2604 OID 364131)
-- Name: stations id; Type: DEFAULT; Schema: railway_system; Owner: postgres
--

ALTER TABLE ONLY railway_system.stations ALTER COLUMN id SET DEFAULT nextval('railway_system.stations_id_seq'::regclass);


--
-- TOC entry 3244 (class 2604 OID 363893)
-- Name: train id; Type: DEFAULT; Schema: railway_system; Owner: postgres
--

ALTER TABLE ONLY railway_system.train ALTER COLUMN id SET DEFAULT nextval('railway_system.train_id_seq'::regclass);


--
-- TOC entry 3246 (class 2604 OID 363909)
-- Name: user id; Type: DEFAULT; Schema: railway_system; Owner: postgres
--

ALTER TABLE ONLY railway_system."user" ALTER COLUMN id SET DEFAULT nextval('railway_system.user_id_seq'::regclass);


--
-- TOC entry 3466 (class 0 OID 395548)
-- Dependencies: 231
-- Data for Name: account; Type: TABLE DATA; Schema: railway_system; Owner: postgres
--

COPY railway_system.account (id, bank_name, account_number, ifsc_code, account_holder_name, phone_number, email, created_at, modified_at, is_deleted, booking_id) FROM stdin;
\.


--
-- TOC entry 3464 (class 0 OID 395525)
-- Dependencies: 229
-- Data for Name: booking; Type: TABLE DATA; Schema: railway_system; Owner: postgres
--

COPY railway_system.booking (id, booking_date, persons_count, total_fare, price, additional_charge, created_at, modified_at, is_deleted, train_id, user_id, schedule_id) FROM stdin;
\.


--
-- TOC entry 3452 (class 0 OID 364000)
-- Dependencies: 217
-- Data for Name: class_type; Type: TABLE DATA; Schema: railway_system; Owner: postgres
--

COPY railway_system.class_type (id, class_name, created_at, modified_at, is_deleted) FROM stdin;
1	AC	2024-08-22 16:55:17.381488+05:30	2024-08-22 16:55:17.381488+05:30	f
2	General	2024-08-22 16:55:17.381488+05:30	2024-08-22 16:55:17.381488+05:30	f
3	Sleeper	2024-08-22 16:55:17.381488+05:30	2024-08-22 16:55:17.381488+05:30	f
4	Ladies	2024-08-22 16:55:17.381488+05:30	2024-08-22 16:55:17.381488+05:30	f
\.


--
-- TOC entry 3468 (class 0 OID 395563)
-- Dependencies: 233
-- Data for Name: payment; Type: TABLE DATA; Schema: railway_system; Owner: postgres
--

COPY railway_system.payment (id, amount, payment_date, payment_status, created_at, modified_at, is_deleted, booking_id) FROM stdin;
\.


--
-- TOC entry 3462 (class 0 OID 395511)
-- Dependencies: 227
-- Data for Name: person; Type: TABLE DATA; Schema: railway_system; Owner: postgres
--

COPY railway_system.person (id, person_name, person_age, gender, berth_choice, created_at, modified_at, is_deleted, booking_id) FROM stdin;
1	Kanishka	23	Female	Middle	2024-10-08 14:18:33.047+05:30	2024-10-08 14:18:33.047+05:30	f	1
2	aarthy	22	Female	Upper	2024-10-08 16:38:22.734+05:30	2024-10-08 16:38:22.734+05:30	f	2
3	aarthy	22	Female	Upper	2024-10-08 16:42:14.719+05:30	2024-10-08 16:42:14.719+05:30	f	3
4	Madona	34	Female	Upper	2024-10-15 14:03:08.551+05:30	2024-10-15 14:03:08.551+05:30	f	4
5	vv	43	Female	Middle	2024-10-15 18:27:42.96+05:30	2024-10-15 18:27:42.96+05:30	f	5
6	aa	44	Male	Lower	2024-10-15 18:27:42.961+05:30	2024-10-15 18:27:42.961+05:30	f	5
7	fgdf	44	Male	Middle	2024-10-15 18:40:57.169+05:30	2024-10-15 18:40:57.169+05:30	f	6
8	fgdf	44	Male	Middle	2024-10-15 18:41:13.702+05:30	2024-10-15 18:41:13.702+05:30	f	7
9	fgdf	44	Male	Middle	2024-10-15 18:41:58.819+05:30	2024-10-15 18:41:58.819+05:30	f	8
10	fgdf	44	Male	Middle	2024-10-15 18:43:31.83+05:30	2024-10-15 18:43:31.83+05:30	f	9
\.


--
-- TOC entry 3456 (class 0 OID 364082)
-- Dependencies: 221
-- Data for Name: price; Type: TABLE DATA; Schema: railway_system; Owner: postgres
--

COPY railway_system.price (id, price, created_at, modified_at, is_deleted, schedule_id, class_type_id) FROM stdin;
1	1500	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	1	1
14	900	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	14	2
15	800	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	15	2
16	700	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	16	2
19	400	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	19	2
20	300	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	20	2
22	900	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	22	3
24	700	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	24	3
25	600	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	25	3
26	500	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	26	3
27	400	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	27	3
28	300	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	28	3
29	200	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	29	3
30	100	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	30	3
31	1000	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	31	4
32	900	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	32	4
33	800	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	33	4
34	700	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	34	4
35	600	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	35	4
36	500	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	36	4
37	400	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	37	4
38	300	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	38	4
39	200	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	39	4
40	100	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	40	4
41	1500	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	41	1
42	1400	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	42	1
43	1300	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	43	1
44	1200	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	44	1
45	1100	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	45	1
46	1000	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	46	1
47	900	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	47	1
48	800	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	48	1
49	700	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	49	1
50	600	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	50	1
51	500	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	51	1
52	400	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	52	1
53	300	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	53	1
54	200	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	54	1
4	1200	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	1	4
13	1000	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	13	1
10	600	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	3	2
11	500	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	4	4
2	1400	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	6	2
3	1300	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	11	3
8	800	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	8	4
9	700	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	7	1
12	400	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	12	4
17	600	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	1	2
21	1000	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	1	3
5	1100	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	10	2
18	500	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	2	2
23	800	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	2	3
6	1000	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	2	3
7	900	2024-08-22 17:01:24.894754+05:30	2024-08-22 17:01:24.894754+05:30	f	2	4
\.


--
-- TOC entry 3460 (class 0 OID 364138)
-- Dependencies: 225
-- Data for Name: routes; Type: TABLE DATA; Schema: railway_system; Owner: postgres
--

COPY railway_system.routes (id, arrival_time, departure_time, sequence_number, created_at, modified_at, is_deleted, train_id, station_id) FROM stdin;
3	2024-10-17 09:50:14.179689+05:30	2024-11-23 10:50:14.179689+05:30	3	2024-08-22 15:49:26.358043+05:30	2024-10-15 09:50:14.179689+05:30	f	1	3
4	2024-10-18 09:50:14.179689+05:30	2024-10-29 10:50:14.179689+05:30	4	2024-08-22 15:49:26.358043+05:30	2024-10-15 09:50:14.179689+05:30	f	1	4
5	2024-10-19 09:50:14.179689+05:30	2024-10-23 10:50:14.179689+05:30	5	2024-08-22 15:49:26.358043+05:30	2024-10-15 09:50:14.179689+05:30	f	1	5
6	2024-10-20 09:50:14.179689+05:30	2024-11-17 10:50:14.179689+05:30	6	2024-08-22 15:49:26.358043+05:30	2024-10-15 09:50:14.179689+05:30	f	1	6
7	2024-10-21 09:50:14.179689+05:30	2024-11-16 10:50:14.179689+05:30	7	2024-08-22 15:49:26.358043+05:30	2024-10-15 09:50:14.179689+05:30	f	1	7
8	2024-10-22 09:50:14.179689+05:30	2024-10-22 10:50:14.179689+05:30	8	2024-08-22 15:49:26.358043+05:30	2024-10-15 09:50:14.179689+05:30	f	1	8
10	2024-10-24 09:50:14.179689+05:30	2024-12-07 10:50:14.179689+05:30	10	2024-08-22 15:49:26.358043+05:30	2024-10-15 09:50:14.179689+05:30	f	1	10
11	2024-10-25 09:50:14.179689+05:30	2024-11-10 10:50:14.179689+05:30	11	2024-08-22 15:49:26.358043+05:30	2024-10-15 09:50:14.179689+05:30	f	1	11
12	2024-10-26 09:50:14.179689+05:30	2024-10-29 10:50:14.179689+05:30	12	2024-08-22 15:49:26.358043+05:30	2024-10-15 09:50:14.179689+05:30	f	1	12
14	2024-10-28 09:50:14.179689+05:30	2024-12-10 10:50:14.179689+05:30	2	2024-08-22 15:49:37.218933+05:30	2024-10-15 09:50:14.179689+05:30	f	2	14
15	2024-10-29 09:50:14.179689+05:30	2024-10-15 10:50:14.179689+05:30	3	2024-08-22 15:49:37.218933+05:30	2024-10-15 09:50:14.179689+05:30	f	2	15
16	2024-10-30 09:50:14.179689+05:30	2024-10-27 10:50:14.179689+05:30	4	2024-08-22 15:49:37.218933+05:30	2024-10-15 09:50:14.179689+05:30	f	2	16
17	2024-10-31 09:50:14.179689+05:30	2024-11-14 10:50:14.179689+05:30	5	2024-08-22 15:49:37.218933+05:30	2024-10-15 09:50:14.179689+05:30	f	2	17
19	2024-11-02 09:50:14.179689+05:30	2024-11-09 10:50:14.179689+05:30	7	2024-08-22 15:49:37.218933+05:30	2024-10-15 09:50:14.179689+05:30	f	2	19
20	2024-11-03 09:50:14.179689+05:30	2024-11-20 10:50:14.179689+05:30	8	2024-08-22 15:49:37.218933+05:30	2024-10-15 09:50:14.179689+05:30	f	2	20
22	2024-11-05 09:50:14.179689+05:30	2024-12-12 10:50:14.179689+05:30	2	2024-08-22 15:49:48.546857+05:30	2024-10-15 09:50:14.179689+05:30	f	3	22
23	2024-11-06 09:50:14.179689+05:30	2024-11-15 10:50:14.179689+05:30	3	2024-08-22 15:49:48.546857+05:30	2024-10-15 09:50:14.179689+05:30	f	3	23
24	2024-11-07 09:50:14.179689+05:30	2024-10-27 10:50:14.179689+05:30	4	2024-08-22 15:49:48.546857+05:30	2024-10-15 09:50:14.179689+05:30	f	3	24
25	2024-11-08 09:50:14.179689+05:30	2024-11-21 10:50:14.179689+05:30	5	2024-08-22 15:49:48.546857+05:30	2024-10-15 09:50:14.179689+05:30	f	3	25
26	2024-11-09 09:50:14.179689+05:30	2024-11-07 10:50:14.179689+05:30	6	2024-08-22 15:49:48.546857+05:30	2024-10-15 09:50:14.179689+05:30	f	3	26
27	2024-11-10 09:50:14.179689+05:30	2024-11-10 10:50:14.179689+05:30	7	2024-08-22 15:49:48.546857+05:30	2024-10-15 09:50:14.179689+05:30	f	3	27
28	2024-11-16 09:50:14.179689+05:30	2024-11-05 10:50:14.179689+05:30	1	2024-08-22 15:49:55.453218+05:30	2024-10-15 09:50:14.179689+05:30	f	4	13
29	2024-11-17 09:50:14.179689+05:30	2024-12-08 10:50:14.179689+05:30	2	2024-08-22 15:49:55.453218+05:30	2024-10-15 09:50:14.179689+05:30	f	4	14
30	2024-11-18 09:50:14.179689+05:30	2024-11-09 10:50:14.179689+05:30	3	2024-08-22 15:49:55.453218+05:30	2024-10-15 09:50:14.179689+05:30	f	4	15
31	2024-11-19 09:50:14.179689+05:30	2024-11-02 10:50:14.179689+05:30	4	2024-08-22 15:49:55.453218+05:30	2024-10-15 09:50:14.179689+05:30	f	4	16
32	2024-11-20 09:50:14.179689+05:30	2024-10-18 10:50:14.179689+05:30	5	2024-08-22 15:49:55.453218+05:30	2024-10-15 09:50:14.179689+05:30	f	4	17
33	2024-11-21 09:50:14.179689+05:30	2024-11-07 10:50:14.179689+05:30	6	2024-08-22 15:49:55.453218+05:30	2024-10-15 09:50:14.179689+05:30	f	4	28
34	2024-11-22 09:50:14.179689+05:30	2024-11-15 10:50:14.179689+05:30	7	2024-08-22 15:49:55.453218+05:30	2024-10-15 09:50:14.179689+05:30	f	4	29
21	2024-11-26 09:50:14.179689+05:30	2024-12-06 10:50:14.179689+05:30	1	2024-08-22 15:49:48.546857+05:30	2024-10-15 09:50:14.179689+05:30	f	3	12
9	2024-10-24 09:50:14.179689+05:30	2024-12-06 10:50:14.179689+05:30	9	2024-08-22 15:49:26.358043+05:30	2024-10-15 09:50:14.179689+05:30	f	1	9
2	2024-10-16 09:50:14.179689+05:30	2024-10-15 10:50:14.179689+05:30	2	2024-08-22 15:49:26.358043+05:30	2024-10-15 09:50:14.179689+05:30	f	1	2
1	2024-10-16 09:50:14.179689+05:30	2024-10-16 10:50:14.179689+05:30	1	2024-08-22 15:49:26.358043+05:30	2024-10-15 09:50:14.179689+05:30	f	1	1
37	2024-10-27 09:50:14.179689+05:30	2024-10-27 10:50:14.179689+05:30	10	2024-08-22 15:49:55.453218+05:30	2024-10-15 09:50:14.179689+05:30	f	4	32
38	2024-11-10 09:50:14.179689+05:30	2024-10-20 10:50:14.179689+05:30	11	2024-08-22 15:49:55.453218+05:30	2024-10-15 09:50:14.179689+05:30	f	4	33
39	2024-12-09 09:50:14.179689+05:30	2024-11-09 10:50:14.179689+05:30	12	2024-08-22 15:49:55.453218+05:30	2024-10-15 09:50:14.179689+05:30	f	4	34
40	2024-11-18 09:50:14.179689+05:30	2024-11-23 10:50:14.179689+05:30	13	2024-08-22 15:49:55.453218+05:30	2024-10-15 09:50:14.179689+05:30	f	4	35
41	2024-11-08 09:50:14.179689+05:30	2024-11-12 10:50:14.179689+05:30	14	2024-08-22 15:49:55.453218+05:30	2024-10-15 09:50:14.179689+05:30	f	4	36
42	2024-11-06 09:50:14.179689+05:30	2024-11-19 10:50:14.179689+05:30	1	2024-08-22 15:51:54.965588+05:30	2024-10-15 09:50:14.179689+05:30	f	5	12
43	2024-10-21 09:50:14.179689+05:30	2024-11-26 10:50:14.179689+05:30	2	2024-08-22 15:51:54.965588+05:30	2024-10-15 09:50:14.179689+05:30	f	5	21
44	2024-11-02 09:50:14.179689+05:30	2024-11-07 10:50:14.179689+05:30	3	2024-08-22 15:51:54.965588+05:30	2024-10-15 09:50:14.179689+05:30	f	5	22
45	2024-11-09 09:50:14.179689+05:30	2024-10-25 10:50:14.179689+05:30	4	2024-08-22 15:51:54.965588+05:30	2024-10-15 09:50:14.179689+05:30	f	5	23
46	2024-10-31 09:50:14.179689+05:30	2024-11-27 10:50:14.179689+05:30	5	2024-08-22 15:51:54.965588+05:30	2024-10-15 09:50:14.179689+05:30	f	5	24
47	2024-11-20 09:50:14.179689+05:30	2024-12-03 10:50:14.179689+05:30	6	2024-08-22 15:51:54.965588+05:30	2024-10-15 09:50:14.179689+05:30	f	5	25
48	2024-12-08 09:50:14.179689+05:30	2024-10-20 10:50:14.179689+05:30	7	2024-08-22 15:51:54.965588+05:30	2024-10-15 09:50:14.179689+05:30	f	5	26
49	2024-10-17 09:50:14.179689+05:30	2024-11-03 10:50:14.179689+05:30	8	2024-08-22 15:51:54.965588+05:30	2024-10-15 09:50:14.179689+05:30	f	5	27
50	2024-11-16 09:50:14.179689+05:30	2024-12-12 10:50:14.179689+05:30	9	2024-08-22 15:51:54.965588+05:30	2024-10-15 09:50:14.179689+05:30	f	5	28
51	2024-11-09 09:50:14.179689+05:30	2024-10-29 10:50:14.179689+05:30	10	2024-08-22 15:51:54.965588+05:30	2024-10-15 09:50:14.179689+05:30	f	5	29
52	2024-10-19 09:50:14.179689+05:30	2024-10-18 10:50:14.179689+05:30	11	2024-08-22 15:51:54.965588+05:30	2024-10-15 09:50:14.179689+05:30	f	5	30
53	2024-11-22 09:50:14.179689+05:30	2024-10-17 10:50:14.179689+05:30	12	2024-08-22 15:51:54.965588+05:30	2024-10-15 09:50:14.179689+05:30	f	5	31
54	2024-11-10 09:50:14.179689+05:30	2024-11-05 10:50:14.179689+05:30	13	2024-08-22 15:51:54.965588+05:30	2024-10-15 09:50:14.179689+05:30	f	5	32
13	2024-10-27 09:50:14.179689+05:30	2024-12-13 10:50:14.179689+05:30	1	2024-08-22 15:49:37.218933+05:30	2024-10-15 09:50:14.179689+05:30	f	2	1
18	2024-11-01 09:50:14.179689+05:30	2024-12-05 10:50:14.179689+05:30	6	2024-08-22 15:49:37.218933+05:30	2024-10-15 09:50:14.179689+05:30	f	2	12
35	2024-11-23 09:50:14.179689+05:30	2024-12-11 10:50:14.179689+05:30	8	2024-08-22 15:49:55.453218+05:30	2024-10-15 09:50:14.179689+05:30	f	4	30
36	2024-11-24 09:50:14.179689+05:30	2024-11-14 10:50:14.179689+05:30	9	2024-08-22 15:49:55.453218+05:30	2024-10-15 09:50:14.179689+05:30	f	4	31
\.


--
-- TOC entry 3450 (class 0 OID 363944)
-- Dependencies: 215
-- Data for Name: schedule; Type: TABLE DATA; Schema: railway_system; Owner: postgres
--

COPY railway_system.schedule (id, date, created_at, modified_at, is_deleted, routes_id, train_id) FROM stdin;
9	2024-10-24	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	9	1
2	2024-10-16	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	2	1
3	2024-10-17	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	3	1
4	2024-10-18	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	4	1
5	2024-10-19	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	5	1
6	2024-10-20	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	6	1
7	2024-10-21	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	7	1
8	2024-10-22	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	8	1
10	2024-10-24	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	10	1
11	2024-10-25	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	11	1
12	2024-10-26	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	12	1
13	2024-10-27	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	13	2
14	2024-10-28	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	14	2
15	2024-10-29	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	15	2
16	2024-10-30	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	16	2
17	2024-10-31	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	17	2
18	2024-11-01	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	18	2
19	2024-11-02	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	19	2
20	2024-11-03	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	20	2
21	2024-11-04	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	12	3
22	2024-11-05	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	22	3
23	2024-11-06	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	23	3
24	2024-11-07	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	24	3
25	2024-11-08	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	25	3
26	2024-11-09	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	26	3
27	2024-11-10	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	27	3
28	2024-11-11	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	13	4
29	2024-11-12	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	14	4
30	2024-11-13	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	15	4
31	2024-11-14	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	16	4
32	2024-11-15	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	17	4
33	2024-11-16	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	28	4
34	2024-11-17	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	29	4
35	2024-11-18	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	30	4
36	2024-11-19	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	31	4
37	2024-11-20	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	32	4
38	2024-11-21	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	33	4
39	2024-11-22	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	34	4
40	2024-11-23	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	35	4
41	2024-11-24	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	36	4
42	2024-11-25	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	12	5
43	2024-11-26	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	21	5
44	2024-11-27	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	22	5
45	2024-11-28	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	23	5
46	2024-11-29	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	24	5
47	2024-11-30	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	25	5
48	2024-12-01	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	26	5
49	2024-12-02	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	27	5
50	2024-12-03	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	28	5
51	2024-12-04	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	29	5
52	2024-12-05	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	30	5
53	2024-12-06	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	31	5
1	2024-10-15	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	1	1
54	2024-12-07	2024-08-22 16:50:43.144022+05:30	2024-10-15 09:57:34.706938+05:30	f	32	5
\.


--
-- TOC entry 3454 (class 0 OID 364058)
-- Dependencies: 219
-- Data for Name: seat_availability; Type: TABLE DATA; Schema: railway_system; Owner: postgres
--

COPY railway_system.seat_availability (id, available_seats, created_at, modified_at, is_deleted, class_type_id, schedule_id, train_id) FROM stdin;
1	50	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	1	1	1
5	30	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	1	5	1
6	25	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	2	6	1
7	20	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	3	7	1
9	10	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	1	9	1
10	5	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	2	10	1
11	50	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	3	11	2
13	40	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	1	13	2
14	35	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	2	14	2
15	30	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	3	15	2
16	25	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	4	16	2
17	20	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	1	17	2
18	15	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	2	18	2
19	10	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	3	19	2
20	5	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	4	20	2
21	50	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	1	21	3
22	45	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	2	22	3
23	40	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	3	23	3
24	35	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	4	24	3
25	30	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	1	25	3
26	25	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	2	26	3
27	20	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	3	27	3
28	15	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	4	28	4
29	10	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	1	29	4
30	5	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	2	30	4
31	50	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	3	31	4
32	45	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	4	32	4
33	40	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	1	33	4
34	35	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	2	34	4
35	30	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	3	35	4
36	25	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	4	36	4
37	20	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	1	37	5
38	15	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	2	38	5
39	10	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	3	39	5
40	5	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	4	40	5
41	50	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	1	41	5
42	45	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	2	42	5
43	40	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	3	43	5
44	35	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	4	44	5
45	30	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	1	45	5
46	25	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	2	46	5
47	20	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	3	47	5
48	15	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	4	48	5
49	10	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	1	49	5
50	5	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	2	50	5
51	50	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	3	51	5
52	45	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	4	52	5
53	40	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	1	53	5
54	35	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	2	54	5
2	45	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	2	1	1
8	15	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	4	8	2
12	45	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	4	12	1
3	39	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	3	2	1
4	39	2024-08-22 17:32:42.609569+05:30	2024-08-22 17:32:42.609569+05:30	f	4	2	1
\.


--
-- TOC entry 3458 (class 0 OID 364128)
-- Dependencies: 223
-- Data for Name: stations; Type: TABLE DATA; Schema: railway_system; Owner: postgres
--

COPY railway_system.stations (id, station_name, location, created_at, modified_at, is_deleted) FROM stdin;
1	New Delhi	Delhi	2024-08-22 15:47:13.403713+05:30	2024-08-22 15:47:13.403713+05:30	f
2	Agra Cantt	Uttar Pradesh	2024-08-22 15:47:13.403713+05:30	2024-08-22 15:47:13.403713+05:30	f
3	Gwalior Jn	Madhya Pradesh	2024-08-22 15:47:13.403713+05:30	2024-08-22 15:47:13.403713+05:30	f
4	Veerangana Laxmibai Jhansi	Madhya Pradesh	2024-08-22 15:47:13.403713+05:30	2024-08-22 15:47:13.403713+05:30	f
5	Bhopal Jn	Madhya Pradesh	2024-08-22 15:47:13.403713+05:30	2024-08-22 15:47:13.403713+05:30	f
6	Itarsi Jn	Madhya Pradesh	2024-08-22 15:47:13.403713+05:30	2024-08-22 15:47:13.403713+05:30	f
7	Nagpur	Maharashtra	2024-08-22 15:47:13.403713+05:30	2024-08-22 15:47:13.403713+05:30	f
8	Balharshah	Maharashtra	2024-08-22 15:47:13.403713+05:30	2024-08-22 15:47:13.403713+05:30	f
9	Warangal	Telangana	2024-08-22 15:47:13.403713+05:30	2024-08-22 15:47:13.403713+05:30	f
10	Khammam	Telangana	2024-08-22 15:47:13.403713+05:30	2024-08-22 15:47:13.403713+05:30	f
11	Vijayawada Jn	Andhra Pradesh	2024-08-22 15:47:13.403713+05:30	2024-08-22 15:47:13.403713+05:30	f
12	MGR Chennai Central	Tamil Nadu	2024-08-22 15:47:13.403713+05:30	2024-08-22 15:47:13.403713+05:30	f
13	Chennai Egmore	Tamil Nadu	2024-08-22 15:47:13.403713+05:30	2024-08-22 15:47:13.403713+05:30	f
14	Tambaram	Tamil Nadu	2024-08-22 15:47:13.403713+05:30	2024-08-22 15:47:13.403713+05:30	f
15	Chengalpattu	Tamil Nadu	2024-08-22 15:47:13.403713+05:30	2024-08-22 15:47:13.403713+05:30	f
16	Villupuram Jn	Tamil Nadu	2024-08-22 15:47:13.403713+05:30	2024-08-22 15:47:13.403713+05:30	f
17	Vriddhachalam Jn	Tamil Nadu	2024-08-22 15:47:13.403713+05:30	2024-08-22 15:47:13.403713+05:30	f
18	Tiruchchirappalli Jn	Tamil Nadu	2024-08-22 15:47:13.403713+05:30	2024-08-22 15:47:13.403713+05:30	f
19	Dindigul Jn	Tamil Nadu	2024-08-22 15:47:13.403713+05:30	2024-08-22 15:47:13.403713+05:30	f
20	Madurai Jn	Tamil Nadu	2024-08-22 15:47:13.403713+05:30	2024-08-22 15:47:13.403713+05:30	f
21	Arakkonam	Tamil Nadu	2024-08-22 15:47:13.403713+05:30	2024-08-22 15:47:13.403713+05:30	f
22	Katpadi Jn	Tamil Nadu	2024-08-22 15:47:13.403713+05:30	2024-08-22 15:47:13.403713+05:30	f
23	Jolarpettai	Tamil Nadu	2024-08-22 15:47:13.403713+05:30	2024-08-22 15:47:13.403713+05:30	f
24	Salem Jn	Tamil Nadu	2024-08-22 15:47:13.403713+05:30	2024-08-22 15:47:13.403713+05:30	f
25	Erode Jn	Tamil Nadu	2024-08-22 15:47:13.403713+05:30	2024-08-22 15:47:13.403713+05:30	f
26	Tiruppur	Tamil Nadu	2024-08-22 15:47:13.403713+05:30	2024-08-22 15:47:13.403713+05:30	f
27	Coimbatore Jn	Tamil Nadu	2024-08-22 15:47:13.403713+05:30	2024-08-22 15:47:13.403713+05:30	f
28	Pudukkottai	Tamil Nadu	2024-08-22 15:47:13.403713+05:30	2024-08-22 15:47:13.403713+05:30	f
29	Karaikkudi Jn	Tamil Nadu	2024-08-22 15:47:13.403713+05:30	2024-08-22 15:47:13.403713+05:30	f
30	Devakottai Road	Tamil Nadu	2024-08-22 15:47:13.403713+05:30	2024-08-22 15:47:13.403713+05:30	f
31	Sivaganga	Tamil Nadu	2024-08-22 15:47:13.403713+05:30	2024-08-22 15:47:13.403713+05:30	f
32	Manamadurai Jn	Tamil Nadu	2024-08-22 15:47:13.403713+05:30	2024-08-22 15:47:13.403713+05:30	f
33	Paramakkudi	Tamil Nadu	2024-08-22 15:47:13.403713+05:30	2024-08-22 15:47:13.403713+05:30	f
34	Ramanathapuram	Tamil Nadu	2024-08-22 15:47:13.403713+05:30	2024-08-22 15:47:13.403713+05:30	f
35	Mandapam	Tamil Nadu	2024-08-22 15:47:13.403713+05:30	2024-08-22 15:47:13.403713+05:30	f
36	Rameswaram	Tamil Nadu	2024-08-22 15:47:13.403713+05:30	2024-08-22 15:47:13.403713+05:30	f
37	Vellore Cantt	Vellore	2024-10-08 17:49:31.951863+05:30	2024-10-08 17:49:31.951863+05:30	f
38	Kumbakonam	Thanjavur	2024-10-08 17:49:31.951863+05:30	2024-10-08 17:49:31.951863+05:30	f
39	Nagercoil	Kanyakumari	2024-10-08 17:49:31.951863+05:30	2024-10-08 17:49:31.951863+05:30	f
40	Tenkasi	Tenkasi	2024-10-08 17:49:31.951863+05:30	2024-10-08 17:49:31.951863+05:30	f
41	Puducherry	Puducherry	2024-10-08 17:49:31.951863+05:30	2024-10-08 17:49:31.951863+05:30	f
\.


--
-- TOC entry 3446 (class 0 OID 363890)
-- Dependencies: 211
-- Data for Name: train; Type: TABLE DATA; Schema: railway_system; Owner: postgres
--

COPY railway_system.train (id, name, train_number, train_type, created_at, modified_at, is_deleted) FROM stdin;
1	Tamil Nadu Express	12621/12622	Express	2024-08-22 14:41:09.869458+05:30	2024-08-22 14:41:09.869458+05:30	f
2	Chennai Egmore - Madurai Vaigai Express	12635/12636	Express	2024-08-22 14:41:09.869458+05:30	2024-08-22 14:41:09.869458+05:30	f
3	Chennai Central - Coimbatore Shatabdi Express	12243/12244	Express	2024-08-22 14:41:09.869458+05:30	2024-08-22 14:41:09.869458+05:30	f
4	Chennai Egmore - Rameswaram Sethu Express	16713/16714	Express	2024-08-22 14:41:09.869458+05:30	2024-08-22 14:41:09.869458+05:30	f
5	Chennai Central - Coimbatore Intercity Express	12679/12680	Express	2024-08-22 14:41:09.869458+05:30	2024-08-22 14:41:09.869458+05:30	f
6	Coimbatore Express	12620	Express	2024-10-08 17:38:47.797189+05:30	2024-10-08 17:38:47.797189+05:30	f
7	Kanyakumari Express	12633	Express	2024-10-08 17:38:47.797189+05:30	2024-10-08 17:38:47.797189+05:30	f
8	Duronto Express	12267	Express	2024-10-08 17:38:47.797189+05:30	2024-10-08 17:38:47.797189+05:30	f
9	Madurai Local	41002	Local	2024-10-08 17:38:47.797189+05:30	2024-10-08 17:38:47.797189+05:30	f
10	Bharat Gaurav Passenger	57031	Passenger	2024-10-08 17:38:47.797189+05:30	2024-10-08 17:38:47.797189+05:30	f
11	Nagarcoil Express	22621	Express	2024-10-08 17:38:47.797189+05:30	2024-10-08 17:38:47.797189+05:30	f
12	Palakkad Passenger	57032	Passenger	2024-10-08 17:38:47.797189+05:30	2024-10-08 17:38:47.797189+05:30	f
13	Vellore Local	41003	Local	2024-10-08 17:38:47.797189+05:30	2024-10-08 17:38:47.797189+05:30	f
\.


--
-- TOC entry 3448 (class 0 OID 363906)
-- Dependencies: 213
-- Data for Name: user; Type: TABLE DATA; Schema: railway_system; Owner: postgres
--

COPY railway_system."user" (id, name, email, password, role, phone_number, address, created_at, modified_at, is_deleted) FROM stdin;
1	Vinisha	vinisha@mailinator.com	Admin@1234	Admin	9083209282	47, Chandni Society, Ananya Nagar,Tirunelveli	2024-09-11 17:16:50.094+05:30	2024-09-11 17:16:50.094+05:30	f
2	Vishnu	vishnu@mailinator.com	vishnu@1234	User	8908234903	50, Sona Heights, Model Town,chennai	2024-09-11 17:33:44.851+05:30	2024-09-11 17:33:44.851+05:30	f
3	Prasath P	prasath2019cs@gmail.com	Prasath@2001	User	8762637373	centizen	2024-09-12 12:12:38.528+05:30	2024-09-12 12:12:38.528+05:30	f
5	Aarthy R	aarthy@mailinator.com	Admin@1234	User	9876543212	west street,sivaganga	2024-10-08 16:35:25.052+05:30	2024-10-08 16:35:25.052+05:30	f
6	sivan	sivan@mailinator.com	Sivanraj@13	Admin	9362898374	enga veedu 	2024-10-14 18:50:48.339+05:30	2024-10-14 18:50:48.341+05:30	f
4	Gokila	gokila@mailinator.com	Mcoders@123	User	9090889098	123,street,Tirunelveli.	2024-09-19 10:24:43.769+05:30	2024-09-19 10:24:43.769+05:30	f
\.


--
-- TOC entry 3486 (class 0 OID 0)
-- Dependencies: 230
-- Name: account_id_seq; Type: SEQUENCE SET; Schema: railway_system; Owner: postgres
--

SELECT pg_catalog.setval('railway_system.account_id_seq', 1, false);


--
-- TOC entry 3487 (class 0 OID 0)
-- Dependencies: 228
-- Name: booking_id_seq; Type: SEQUENCE SET; Schema: railway_system; Owner: postgres
--

SELECT pg_catalog.setval('railway_system.booking_id_seq', 1, false);


--
-- TOC entry 3488 (class 0 OID 0)
-- Dependencies: 216
-- Name: class_type_id_seq; Type: SEQUENCE SET; Schema: railway_system; Owner: postgres
--

SELECT pg_catalog.setval('railway_system.class_type_id_seq', 4, true);


--
-- TOC entry 3489 (class 0 OID 0)
-- Dependencies: 232
-- Name: payment_id_seq; Type: SEQUENCE SET; Schema: railway_system; Owner: postgres
--

SELECT pg_catalog.setval('railway_system.payment_id_seq', 1, false);


--
-- TOC entry 3490 (class 0 OID 0)
-- Dependencies: 226
-- Name: person_id_seq; Type: SEQUENCE SET; Schema: railway_system; Owner: postgres
--

SELECT pg_catalog.setval('railway_system.person_id_seq', 10, true);


--
-- TOC entry 3491 (class 0 OID 0)
-- Dependencies: 220
-- Name: price_id_seq; Type: SEQUENCE SET; Schema: railway_system; Owner: postgres
--

SELECT pg_catalog.setval('railway_system.price_id_seq', 1, false);


--
-- TOC entry 3492 (class 0 OID 0)
-- Dependencies: 224
-- Name: routes_id_seq; Type: SEQUENCE SET; Schema: railway_system; Owner: postgres
--

SELECT pg_catalog.setval('railway_system.routes_id_seq', 54, true);


--
-- TOC entry 3493 (class 0 OID 0)
-- Dependencies: 214
-- Name: schedule_id_seq; Type: SEQUENCE SET; Schema: railway_system; Owner: postgres
--

SELECT pg_catalog.setval('railway_system.schedule_id_seq', 1, false);


--
-- TOC entry 3494 (class 0 OID 0)
-- Dependencies: 218
-- Name: seat_availability_id_seq; Type: SEQUENCE SET; Schema: railway_system; Owner: postgres
--

SELECT pg_catalog.setval('railway_system.seat_availability_id_seq', 1, false);


--
-- TOC entry 3495 (class 0 OID 0)
-- Dependencies: 222
-- Name: stations_id_seq; Type: SEQUENCE SET; Schema: railway_system; Owner: postgres
--

SELECT pg_catalog.setval('railway_system.stations_id_seq', 41, true);


--
-- TOC entry 3496 (class 0 OID 0)
-- Dependencies: 210
-- Name: train_id_seq; Type: SEQUENCE SET; Schema: railway_system; Owner: postgres
--

SELECT pg_catalog.setval('railway_system.train_id_seq', 13, true);


--
-- TOC entry 3497 (class 0 OID 0)
-- Dependencies: 212
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: railway_system; Owner: postgres
--

SELECT pg_catalog.setval('railway_system.user_id_seq', 6, true);


--
-- TOC entry 3290 (class 2606 OID 395556)
-- Name: account account_pkey; Type: CONSTRAINT; Schema: railway_system; Owner: postgres
--

ALTER TABLE ONLY railway_system.account
    ADD CONSTRAINT account_pkey PRIMARY KEY (id);


--
-- TOC entry 3288 (class 2606 OID 395531)
-- Name: booking booking_pkey; Type: CONSTRAINT; Schema: railway_system; Owner: postgres
--

ALTER TABLE ONLY railway_system.booking
    ADD CONSTRAINT booking_pkey PRIMARY KEY (id);


--
-- TOC entry 3276 (class 2606 OID 364006)
-- Name: class_type class_type_pkey; Type: CONSTRAINT; Schema: railway_system; Owner: postgres
--

ALTER TABLE ONLY railway_system.class_type
    ADD CONSTRAINT class_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3292 (class 2606 OID 395570)
-- Name: payment payment_pkey; Type: CONSTRAINT; Schema: railway_system; Owner: postgres
--

ALTER TABLE ONLY railway_system.payment
    ADD CONSTRAINT payment_pkey PRIMARY KEY (id);


--
-- TOC entry 3286 (class 2606 OID 395517)
-- Name: person person_pkey; Type: CONSTRAINT; Schema: railway_system; Owner: postgres
--

ALTER TABLE ONLY railway_system.person
    ADD CONSTRAINT person_pkey PRIMARY KEY (id);


--
-- TOC entry 3280 (class 2606 OID 364088)
-- Name: price price_pkey; Type: CONSTRAINT; Schema: railway_system; Owner: postgres
--

ALTER TABLE ONLY railway_system.price
    ADD CONSTRAINT price_pkey PRIMARY KEY (id);


--
-- TOC entry 3284 (class 2606 OID 364144)
-- Name: routes routes_pkey; Type: CONSTRAINT; Schema: railway_system; Owner: postgres
--

ALTER TABLE ONLY railway_system.routes
    ADD CONSTRAINT routes_pkey PRIMARY KEY (id);


--
-- TOC entry 3274 (class 2606 OID 363950)
-- Name: schedule schedule_pkey; Type: CONSTRAINT; Schema: railway_system; Owner: postgres
--

ALTER TABLE ONLY railway_system.schedule
    ADD CONSTRAINT schedule_pkey PRIMARY KEY (id);


--
-- TOC entry 3278 (class 2606 OID 364064)
-- Name: seat_availability seat_availability_pkey; Type: CONSTRAINT; Schema: railway_system; Owner: postgres
--

ALTER TABLE ONLY railway_system.seat_availability
    ADD CONSTRAINT seat_availability_pkey PRIMARY KEY (id);


--
-- TOC entry 3282 (class 2606 OID 364136)
-- Name: stations stations_pkey; Type: CONSTRAINT; Schema: railway_system; Owner: postgres
--

ALTER TABLE ONLY railway_system.stations
    ADD CONSTRAINT stations_pkey PRIMARY KEY (id);


--
-- TOC entry 3270 (class 2606 OID 363898)
-- Name: train train_pkey; Type: CONSTRAINT; Schema: railway_system; Owner: postgres
--

ALTER TABLE ONLY railway_system.train
    ADD CONSTRAINT train_pkey PRIMARY KEY (id);


--
-- TOC entry 3272 (class 2606 OID 363914)
-- Name: user user_pkey; Type: CONSTRAINT; Schema: railway_system; Owner: postgres
--

ALTER TABLE ONLY railway_system."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- TOC entry 3304 (class 2606 OID 395557)
-- Name: account account_booking_id_fkey; Type: FK CONSTRAINT; Schema: railway_system; Owner: postgres
--

ALTER TABLE ONLY railway_system.account
    ADD CONSTRAINT account_booking_id_fkey FOREIGN KEY (booking_id) REFERENCES railway_system.booking(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3301 (class 2606 OID 395542)
-- Name: booking booking_schedule_id_fkey; Type: FK CONSTRAINT; Schema: railway_system; Owner: postgres
--

ALTER TABLE ONLY railway_system.booking
    ADD CONSTRAINT booking_schedule_id_fkey FOREIGN KEY (schedule_id) REFERENCES railway_system.schedule(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3302 (class 2606 OID 395532)
-- Name: booking booking_train_id_fkey; Type: FK CONSTRAINT; Schema: railway_system; Owner: postgres
--

ALTER TABLE ONLY railway_system.booking
    ADD CONSTRAINT booking_train_id_fkey FOREIGN KEY (train_id) REFERENCES railway_system.train(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3303 (class 2606 OID 395537)
-- Name: booking booking_user_id_fkey; Type: FK CONSTRAINT; Schema: railway_system; Owner: postgres
--

ALTER TABLE ONLY railway_system.booking
    ADD CONSTRAINT booking_user_id_fkey FOREIGN KEY (user_id) REFERENCES railway_system."user"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3305 (class 2606 OID 395571)
-- Name: payment payment_booking_id_fkey; Type: FK CONSTRAINT; Schema: railway_system; Owner: postgres
--

ALTER TABLE ONLY railway_system.payment
    ADD CONSTRAINT payment_booking_id_fkey FOREIGN KEY (booking_id) REFERENCES railway_system.booking(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3298 (class 2606 OID 364094)
-- Name: price price_class_type_id_fkey; Type: FK CONSTRAINT; Schema: railway_system; Owner: postgres
--

ALTER TABLE ONLY railway_system.price
    ADD CONSTRAINT price_class_type_id_fkey FOREIGN KEY (class_type_id) REFERENCES railway_system.class_type(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3297 (class 2606 OID 364089)
-- Name: price price_schedule_id_fkey; Type: FK CONSTRAINT; Schema: railway_system; Owner: postgres
--

ALTER TABLE ONLY railway_system.price
    ADD CONSTRAINT price_schedule_id_fkey FOREIGN KEY (schedule_id) REFERENCES railway_system.schedule(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3300 (class 2606 OID 364150)
-- Name: routes routes_station_id_fkey; Type: FK CONSTRAINT; Schema: railway_system; Owner: postgres
--

ALTER TABLE ONLY railway_system.routes
    ADD CONSTRAINT routes_station_id_fkey FOREIGN KEY (station_id) REFERENCES railway_system.stations(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3299 (class 2606 OID 364145)
-- Name: routes routes_train_id_fkey; Type: FK CONSTRAINT; Schema: railway_system; Owner: postgres
--

ALTER TABLE ONLY railway_system.routes
    ADD CONSTRAINT routes_train_id_fkey FOREIGN KEY (train_id) REFERENCES railway_system.train(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3293 (class 2606 OID 363956)
-- Name: schedule schedule_train_id_fkey; Type: FK CONSTRAINT; Schema: railway_system; Owner: postgres
--

ALTER TABLE ONLY railway_system.schedule
    ADD CONSTRAINT schedule_train_id_fkey FOREIGN KEY (train_id) REFERENCES railway_system.train(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3294 (class 2606 OID 364065)
-- Name: seat_availability seat_availability_class_type_id_fkey; Type: FK CONSTRAINT; Schema: railway_system; Owner: postgres
--

ALTER TABLE ONLY railway_system.seat_availability
    ADD CONSTRAINT seat_availability_class_type_id_fkey FOREIGN KEY (class_type_id) REFERENCES railway_system.class_type(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3295 (class 2606 OID 364070)
-- Name: seat_availability seat_availability_schedule_id_fkey; Type: FK CONSTRAINT; Schema: railway_system; Owner: postgres
--

ALTER TABLE ONLY railway_system.seat_availability
    ADD CONSTRAINT seat_availability_schedule_id_fkey FOREIGN KEY (schedule_id) REFERENCES railway_system.schedule(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3296 (class 2606 OID 364075)
-- Name: seat_availability seat_availability_train_id_fkey; Type: FK CONSTRAINT; Schema: railway_system; Owner: postgres
--

ALTER TABLE ONLY railway_system.seat_availability
    ADD CONSTRAINT seat_availability_train_id_fkey FOREIGN KEY (train_id) REFERENCES railway_system.train(id) ON UPDATE CASCADE ON DELETE SET NULL;


-- Completed on 2025-06-12 12:30:56

--
-- PostgreSQL database dump complete
--

