--
-- PostgreSQL database dump
--

-- Dumped from database version 9.4.5
-- Dumped by pg_dump version 9.4.5
-- Started on 2016-04-11 01:11:41 BRT

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 196 (class 3079 OID 11895)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2273 (class 0 OID 0)
-- Dependencies: 196
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- TOC entry 197 (class 3079 OID 65949)
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- TOC entry 2274 (class 0 OID 0)
-- Dependencies: 197
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 183 (class 1259 OID 65742)
-- Name: d_person; Type: TABLE; Schema: public; Owner: guilherme.platzeck; Tablespace: 
--

CREATE TABLE d_person (
    per_id uuid NOT NULL,
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    updated_date timestamp without time zone DEFAULT now() NOT NULL,
    username text NOT NULL,
    forename text NOT NULL,
    middle_names text NOT NULL,
    surname text NOT NULL,
    blood_status text,
    marital_status text,
    species text DEFAULT 'HUMAN'::text,
    gender text,
    hou_id uuid,
    death_date timestamp without time zone,
    birthday timestamp without time zone DEFAULT (now() - '21 years'::interval) NOT NULL,
    active boolean DEFAULT true NOT NULL,
    story text
);


ALTER TABLE d_person OWNER TO "guilherme.platzeck";

--
-- TOC entry 194 (class 1259 OID 66083)
-- Name: d_user; Type: TABLE; Schema: public; Owner: guilherme.platzeck; Tablespace: 
--

CREATE TABLE d_user (
    use_id uuid NOT NULL,
    per_id uuid,
    active boolean DEFAULT true NOT NULL,
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    updated_date timestamp without time zone DEFAULT now() NOT NULL,
    login text NOT NULL,
    email text NOT NULL,
    password text NOT NULL,
    user_birthday timestamp without time zone NOT NULL,
    role text DEFAULT 'USER'::text NOT NULL
);


ALTER TABLE d_user OWNER TO "guilherme.platzeck";

--
-- TOC entry 182 (class 1259 OID 65734)
-- Name: k_blood_status; Type: TABLE; Schema: public; Owner: guilherme.platzeck; Tablespace: 
--

CREATE TABLE k_blood_status (
    name text NOT NULL
);


ALTER TABLE k_blood_status OWNER TO "guilherme.platzeck";

--
-- TOC entry 181 (class 1259 OID 65726)
-- Name: k_boggart; Type: TABLE; Schema: public; Owner: guilherme.platzeck; Tablespace: 
--

CREATE TABLE k_boggart (
    bog_id uuid NOT NULL,
    name text NOT NULL,
    description text
);


ALTER TABLE k_boggart OWNER TO "guilherme.platzeck";

--
-- TOC entry 179 (class 1259 OID 65705)
-- Name: k_field; Type: TABLE; Schema: public; Owner: guilherme.platzeck; Tablespace: 
--

CREATE TABLE k_field (
    fie_id uuid NOT NULL,
    name text NOT NULL,
    description text
);


ALTER TABLE k_field OWNER TO "guilherme.platzeck";

--
-- TOC entry 178 (class 1259 OID 65697)
-- Name: k_gender; Type: TABLE; Schema: public; Owner: guilherme.platzeck; Tablespace: 
--

CREATE TABLE k_gender (
    name text NOT NULL
);


ALTER TABLE k_gender OWNER TO "guilherme.platzeck";

--
-- TOC entry 177 (class 1259 OID 65689)
-- Name: k_house; Type: TABLE; Schema: public; Owner: guilherme.platzeck; Tablespace: 
--

CREATE TABLE k_house (
    hou_id uuid NOT NULL,
    name text NOT NULL,
    primary_colour text,
    secundary_colour text,
    symbol text,
    history text,
    per_id uuid
);


ALTER TABLE k_house OWNER TO "guilherme.platzeck";

--
-- TOC entry 176 (class 1259 OID 65673)
-- Name: k_marital_status; Type: TABLE; Schema: public; Owner: guilherme.platzeck; Tablespace: 
--

CREATE TABLE k_marital_status (
    name text NOT NULL
);


ALTER TABLE k_marital_status OWNER TO "guilherme.platzeck";

--
-- TOC entry 175 (class 1259 OID 65665)
-- Name: k_patrounous; Type: TABLE; Schema: public; Owner: guilherme.platzeck; Tablespace: 
--

CREATE TABLE k_patrounous (
    pat_id uuid NOT NULL,
    name text NOT NULL,
    description text
);


ALTER TABLE k_patrounous OWNER TO "guilherme.platzeck";

--
-- TOC entry 174 (class 1259 OID 65657)
-- Name: k_role; Type: TABLE; Schema: public; Owner: guilherme.platzeck; Tablespace: 
--

CREATE TABLE k_role (
    name text NOT NULL
);


ALTER TABLE k_role OWNER TO "guilherme.platzeck";

--
-- TOC entry 173 (class 1259 OID 65649)
-- Name: k_skill; Type: TABLE; Schema: public; Owner: guilherme.platzeck; Tablespace: 
--

CREATE TABLE k_skill (
    ski_id uuid NOT NULL,
    name text NOT NULL,
    description text
);


ALTER TABLE k_skill OWNER TO "guilherme.platzeck";

--
-- TOC entry 172 (class 1259 OID 65641)
-- Name: k_species; Type: TABLE; Schema: public; Owner: guilherme.platzeck; Tablespace: 
--

CREATE TABLE k_species (
    name text NOT NULL
);


ALTER TABLE k_species OWNER TO "guilherme.platzeck";

--
-- TOC entry 180 (class 1259 OID 65713)
-- Name: k_spell; Type: TABLE; Schema: public; Owner: guilherme.platzeck; Tablespace: 
--

CREATE TABLE k_spell (
    spe_id uuid NOT NULL,
    name text NOT NULL,
    description text,
    type text,
    fie_id uuid
);


ALTER TABLE k_spell OWNER TO "guilherme.platzeck";

--
-- TOC entry 191 (class 1259 OID 65960)
-- Name: k_wand; Type: TABLE; Schema: public; Owner: guilherme.platzeck; Tablespace: 
--

CREATE TABLE k_wand (
    wan_id uuid NOT NULL,
    wood text NOT NULL,
    size numeric NOT NULL,
    kernel text NOT NULL
);


ALTER TABLE k_wand OWNER TO "guilherme.platzeck";

--
-- TOC entry 189 (class 1259 OID 65919)
-- Name: r_house_headmaster; Type: TABLE; Schema: public; Owner: guilherme.platzeck; Tablespace: 
--

CREATE TABLE r_house_headmaster (
    per_id uuid NOT NULL,
    hou_id uuid NOT NULL,
    creation_date date DEFAULT now() NOT NULL,
    updated_date date DEFAULT now() NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE r_house_headmaster OWNER TO "guilherme.platzeck";

--
-- TOC entry 190 (class 1259 OID 65935)
-- Name: r_house_notorious_people; Type: TABLE; Schema: public; Owner: guilherme.platzeck; Tablespace: 
--

CREATE TABLE r_house_notorious_people (
    per_id uuid NOT NULL,
    hou_id uuid NOT NULL,
    creation_date date DEFAULT now() NOT NULL
);


ALTER TABLE r_house_notorious_people OWNER TO "guilherme.platzeck";

--
-- TOC entry 192 (class 1259 OID 65968)
-- Name: r_person_boggart; Type: TABLE; Schema: public; Owner: guilherme.platzeck; Tablespace: 
--

CREATE TABLE r_person_boggart (
    per_id uuid NOT NULL,
    bog_id uuid NOT NULL,
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    updated_date timestamp without time zone DEFAULT now() NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE r_person_boggart OWNER TO "guilherme.platzeck";

--
-- TOC entry 185 (class 1259 OID 65856)
-- Name: r_person_field; Type: TABLE; Schema: public; Owner: guilherme.platzeck; Tablespace: 
--

CREATE TABLE r_person_field (
    fie_id uuid NOT NULL,
    per_id uuid NOT NULL,
    points numeric,
    usage numeric
);


ALTER TABLE r_person_field OWNER TO "guilherme.platzeck";

--
-- TOC entry 187 (class 1259 OID 65892)
-- Name: r_person_parenting; Type: TABLE; Schema: public; Owner: guilherme.platzeck; Tablespace: 
--

CREATE TABLE r_person_parenting (
    per_id uuid NOT NULL,
    per_id_parent uuid NOT NULL
);


ALTER TABLE r_person_parenting OWNER TO "guilherme.platzeck";

--
-- TOC entry 188 (class 1259 OID 65905)
-- Name: r_person_partner; Type: TABLE; Schema: public; Owner: guilherme.platzeck; Tablespace: 
--

CREATE TABLE r_person_partner (
    per_id uuid NOT NULL,
    per_id_2 uuid NOT NULL,
    active boolean DEFAULT true NOT NULL,
    updated_date timestamp without time zone DEFAULT now() NOT NULL,
    creation_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE r_person_partner OWNER TO "guilherme.platzeck";

--
-- TOC entry 195 (class 1259 OID 82090)
-- Name: r_person_patrounous; Type: TABLE; Schema: public; Owner: guilherme.platzeck; Tablespace: 
--

CREATE TABLE r_person_patrounous (
    per_id uuid NOT NULL,
    pat_id uuid NOT NULL,
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    updated_date timestamp without time zone DEFAULT now() NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE r_person_patrounous OWNER TO "guilherme.platzeck";

--
-- TOC entry 184 (class 1259 OID 65838)
-- Name: r_person_skill; Type: TABLE; Schema: public; Owner: guilherme.platzeck; Tablespace: 
--

CREATE TABLE r_person_skill (
    ski_id uuid NOT NULL,
    per_id uuid NOT NULL,
    points numeric,
    usage numeric
);


ALTER TABLE r_person_skill OWNER TO "guilherme.platzeck";

--
-- TOC entry 186 (class 1259 OID 65874)
-- Name: r_person_spell; Type: TABLE; Schema: public; Owner: guilherme.platzeck; Tablespace: 
--

CREATE TABLE r_person_spell (
    spe_id uuid NOT NULL,
    per_id uuid NOT NULL,
    points numeric,
    usage numeric
);


ALTER TABLE r_person_spell OWNER TO "guilherme.platzeck";

--
-- TOC entry 193 (class 1259 OID 65984)
-- Name: r_person_wand; Type: TABLE; Schema: public; Owner: guilherme.platzeck; Tablespace: 
--

CREATE TABLE r_person_wand (
    per_id uuid NOT NULL,
    wan_id uuid NOT NULL,
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    updated_date timestamp without time zone DEFAULT now() NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE r_person_wand OWNER TO "guilherme.platzeck";

--
-- TOC entry 2253 (class 0 OID 65742)
-- Dependencies: 183
-- Data for Name: d_person; Type: TABLE DATA; Schema: public; Owner: guilherme.platzeck
--

COPY d_person (per_id, creation_date, updated_date, username, forename, middle_names, surname, blood_status, marital_status, species, gender, hou_id, death_date, birthday, active, story) FROM stdin;
\.


--
-- TOC entry 2264 (class 0 OID 66083)
-- Dependencies: 194
-- Data for Name: d_user; Type: TABLE DATA; Schema: public; Owner: guilherme.platzeck
--

COPY d_user (use_id, per_id, active, creation_date, updated_date, login, email, password, user_birthday, role) FROM stdin;
\.


--
-- TOC entry 2252 (class 0 OID 65734)
-- Dependencies: 182
-- Data for Name: k_blood_status; Type: TABLE DATA; Schema: public; Owner: guilherme.platzeck
--

COPY k_blood_status (name) FROM stdin;
MUGGLE BORN
PURE BLOOD
\.


--
-- TOC entry 2251 (class 0 OID 65726)
-- Dependencies: 181
-- Data for Name: k_boggart; Type: TABLE DATA; Schema: public; Owner: guilherme.platzeck
--

COPY k_boggart (bog_id, name, description) FROM stdin;
788ef15c-fac8-11e5-8787-5ce0c56ce5ee	Santa Claus	Green Fat Santa Claus
7cee7fb0-fac8-11e5-8787-5ce0c56ce5ee	Santa Claus	Skinny Santa Claus
851ddef6-fac8-11e5-8787-5ce0c56ce5ee	Clown	Happy Clown
\.


--
-- TOC entry 2249 (class 0 OID 65705)
-- Dependencies: 179
-- Data for Name: k_field; Type: TABLE DATA; Schema: public; Owner: guilherme.platzeck
--

COPY k_field (fie_id, name, description) FROM stdin;
\.


--
-- TOC entry 2248 (class 0 OID 65697)
-- Dependencies: 178
-- Data for Name: k_gender; Type: TABLE DATA; Schema: public; Owner: guilherme.platzeck
--

COPY k_gender (name) FROM stdin;
MALE
FEMALE
ANDROGYNE
\.


--
-- TOC entry 2247 (class 0 OID 65689)
-- Dependencies: 177
-- Data for Name: k_house; Type: TABLE DATA; Schema: public; Owner: guilherme.platzeck
--

COPY k_house (hou_id, name, primary_colour, secundary_colour, symbol, history, per_id) FROM stdin;
\.


--
-- TOC entry 2246 (class 0 OID 65673)
-- Dependencies: 176
-- Data for Name: k_marital_status; Type: TABLE DATA; Schema: public; Owner: guilherme.platzeck
--

COPY k_marital_status (name) FROM stdin;
SINGLE
DIVORCED
ENGAGED
MARRIED
WIDDOWED
\.


--
-- TOC entry 2245 (class 0 OID 65665)
-- Dependencies: 175
-- Data for Name: k_patrounous; Type: TABLE DATA; Schema: public; Owner: guilherme.platzeck
--

COPY k_patrounous (pat_id, name, description) FROM stdin;
43032e1e-fac7-11e5-8787-5ce0c56ce5ee	Wolf	Big white wolf
4c5e2626-fac7-11e5-8787-5ce0c56ce5ee	Otter	Fluffy Otter
4c65c2a0-fac7-11e5-8787-5ce0c56ce5ee	Otter	Fluffy Otter
633e245e-fac7-11e5-8787-5ce0c56ce5ee	Horse	Big White Horse
\.


--
-- TOC entry 2244 (class 0 OID 65657)
-- Dependencies: 174
-- Data for Name: k_role; Type: TABLE DATA; Schema: public; Owner: guilherme.platzeck
--

COPY k_role (name) FROM stdin;
USER
ADMIN
MANAGER
\.


--
-- TOC entry 2243 (class 0 OID 65649)
-- Dependencies: 173
-- Data for Name: k_skill; Type: TABLE DATA; Schema: public; Owner: guilherme.platzeck
--

COPY k_skill (ski_id, name, description) FROM stdin;
\.


--
-- TOC entry 2242 (class 0 OID 65641)
-- Dependencies: 172
-- Data for Name: k_species; Type: TABLE DATA; Schema: public; Owner: guilherme.platzeck
--

COPY k_species (name) FROM stdin;
HUMAN
MERPEOPLE
GOBLIN
CENTAURS
\.


--
-- TOC entry 2250 (class 0 OID 65713)
-- Dependencies: 180
-- Data for Name: k_spell; Type: TABLE DATA; Schema: public; Owner: guilherme.platzeck
--

COPY k_spell (spe_id, name, description, type, fie_id) FROM stdin;
\.


--
-- TOC entry 2261 (class 0 OID 65960)
-- Dependencies: 191
-- Data for Name: k_wand; Type: TABLE DATA; Schema: public; Owner: guilherme.platzeck
--

COPY k_wand (wan_id, wood, size, kernel) FROM stdin;
e1dffce6-f438-11e5-8038-099f03ff0738	macieira	31.97	pó de chifre de dragão
e1e02e14-f438-11e5-8038-099f03ff0738	macieira	32.34	raiz de mandrágora
e1e0561e-f438-11e5-8038-099f03ff0738	macieira	32.26	escama de dragão
e1e080bc-f438-11e5-8038-099f03ff0738	macieira	32.01	fibra de coração de dragão
e1e0a790-f438-11e5-8038-099f03ff0738	macieira	31.71	pêlo de cauda de testrálio
e1e0ab6e-f438-11e5-8038-099f03ff0738	macieira	31.56	pó de chifre de unicórnio
e1e0ad12-f438-11e5-8038-099f03ff0738	macieira	31.82	cabelo de veela
e1e0ae7a-f438-11e5-8038-099f03ff0738	ipê	31.61	pó de chifre de dragão
e1e0afd8-f438-11e5-8038-099f03ff0738	ipê	31.61	pó de chifre de dragão
e1e0b12c-f438-11e5-8038-099f03ff0738	ipê	32.12	raiz de mandrágora
e1e0b294-f438-11e5-8038-099f03ff0738	ipê	32.21	escama de sereiano
e1e0b3e8-f438-11e5-8038-099f03ff0738	ipê	32.42	pena de hipogrifo
e1e0b53c-f438-11e5-8038-099f03ff0738	ipê	31.60	escama de dragão
e1e0b6a4-f438-11e5-8038-099f03ff0738	ipê	32.35	fibra de coração de dragão
e1e0b7f8-f438-11e5-8038-099f03ff0738	ipê	31.69	pó de presa de dragão
e1e0b956-f438-11e5-8038-099f03ff0738	ipê	32.32	pêlo de cauda de unicórnio
e1e0baa0-f438-11e5-8038-099f03ff0738	ipê	32.31	pó de chifre de unicórnio
e1e0bbfe-f438-11e5-8038-099f03ff0738	ipê	32.31	pó de chifre de unicórnio
e1e0bd5c-f438-11e5-8038-099f03ff0738	salgueiro	31.87	pó de chifre de dragão
e1e0bea6-f438-11e5-8038-099f03ff0738	salgueiro	32.46	raiz de mandrágora
e1e0c00e-f438-11e5-8038-099f03ff0738	salgueiro	31.51	pena de hipogrifo
e1e0c16c-f438-11e5-8038-099f03ff0738	salgueiro	32.20	escama de dragão
e1e0c2ca-f438-11e5-8038-099f03ff0738	salgueiro	31.51	fibra de coração de dragão
e1e0c428-f438-11e5-8038-099f03ff0738	salgueiro	31.53	pêlo de cauda de testrálio
e1e0c572-f438-11e5-8038-099f03ff0738	salgueiro	31.59	pó de chifre de unicórnio
e1e0c6e4-f438-11e5-8038-099f03ff0738	sabugueiro	32.97	pó de chifre de dragão
e1e0c842-f438-11e5-8038-099f03ff0738	sabugueiro	32.53	escama de sereiano
e1e0c9aa-f438-11e5-8038-099f03ff0738	sabugueiro	33.26	pena de hipogrifo
e1e0cafe-f438-11e5-8038-099f03ff0738	sabugueiro	33.24	escama de dragão
e1e0cc52-f438-11e5-8038-099f03ff0738	sabugueiro	32.63	fibra de coração de dragão
e1e0cdb0-f438-11e5-8038-099f03ff0738	sabugueiro	32.66	pó de presa de dragão
e1e0cf04-f438-11e5-8038-099f03ff0738	sabugueiro	33.28	pêlo de cauda de unicórnio
e1e0d058-f438-11e5-8038-099f03ff0738	sabugueiro	32.55	pó de chifre de unicórnio
e1e0d1a2-f438-11e5-8038-099f03ff0738	sabugueiro	32.55	pó de chifre de unicórnio
e1e0d3d2-f438-11e5-8038-099f03ff0738	figueira	32.59	pó de chifre de dragão
e1e0d5b2-f438-11e5-8038-099f03ff0738	figueira	32.81	pena de hipogrifo
e1e0d706-f438-11e5-8038-099f03ff0738	figueira	33.16	escama de dragão
e1e0d85a-f438-11e5-8038-099f03ff0738	figueira	33.02	fibra de coração de dragão
e1e0d9b8-f438-11e5-8038-099f03ff0738	figueira	33.07	pó de presa de dragão
e1e0db0c-f438-11e5-8038-099f03ff0738	figueira	32.38	pêlo de cauda de unicórnio
e1e0dc56-f438-11e5-8038-099f03ff0738	figueira	32.49	pêlo de cauda de testrálio
e1e0ddc8-f438-11e5-8038-099f03ff0738	figueira	32.44	sangue de unicórnio
e1e0df30-f438-11e5-8038-099f03ff0738	figueira	32.63	pó de chifre de unicórnio
e1e0e098-f438-11e5-8038-099f03ff0738	figueira	32.63	pó de chifre de unicórnio
e1e0e1ec-f438-11e5-8038-099f03ff0738	figueira	33.13	cabelo de veela
e1e0e354-f438-11e5-8038-099f03ff0738	cerejeira	33.32	pó de chifre de dragão
e1e0e4a8-f438-11e5-8038-099f03ff0738	cerejeira	33.09	escama de sereiano
e1e0e5fc-f438-11e5-8038-099f03ff0738	cerejeira	33.16	pena de hipogrifo
e1e0e750-f438-11e5-8038-099f03ff0738	cerejeira	33.29	escama de dragão
e1e0e8ae-f438-11e5-8038-099f03ff0738	cerejeira	33.32	fibra de coração de dragão
e1e0ea02-f438-11e5-8038-099f03ff0738	cerejeira	33.32	fibra de coração de dragão
e1e0eb60-f438-11e5-8038-099f03ff0738	cerejeira	33.07	pó de presa de dragão
e1e0ecb4-f438-11e5-8038-099f03ff0738	cerejeira	32.40	pêlo de cauda de unicórnio
e1e0ee08-f438-11e5-8038-099f03ff0738	cerejeira	33.21	pêlo de cauda de testrálio
e1e0ef70-f438-11e5-8038-099f03ff0738	cerejeira	32.86	pó de chifre de unicórnio
e1e0f0d8-f438-11e5-8038-099f03ff0738	carvalho	32.79	pó de chifre de dragão
e1e0f2b8-f438-11e5-8038-099f03ff0738	carvalho	32.70	raiz de mandrágora
e1e0f420-f438-11e5-8038-099f03ff0738	carvalho	33.22	escama de sereiano
e1e0f560-f438-11e5-8038-099f03ff0738	carvalho	32.61	pena de hipogrifo
e1e0f6dc-f438-11e5-8038-099f03ff0738	carvalho	32.75	escama de dragão
e1e0f83a-f438-11e5-8038-099f03ff0738	carvalho	32.35	fibra de coração de dragão
e1e0f998-f438-11e5-8038-099f03ff0738	carvalho	32.94	pó de presa de dragão
e1e0fae2-f438-11e5-8038-099f03ff0738	carvalho	32.33	coral
e1e0fc36-f438-11e5-8038-099f03ff0738	carvalho	32.33	coral
e1e0fd8a-f438-11e5-8038-099f03ff0738	carvalho	32.97	pêlo de cauda de unicórnio
e1e0fed4-f438-11e5-8038-099f03ff0738	carvalho	32.42	pêlo de cauda de testrálio
e1e10050-f438-11e5-8038-099f03ff0738	carvalho	32.46	pó de chifre de unicórnio
e1e102da-f438-11e5-8038-099f03ff0738	cedro	32.71	pó de chifre de dragão
e1e104c4-f438-11e5-8038-099f03ff0738	cedro	32.75	raiz de mandrágora
e1e10618-f438-11e5-8038-099f03ff0738	cedro	32.39	escama de sereiano
e1e1076c-f438-11e5-8038-099f03ff0738	cedro	33.10	pena de hipogrifo
e1e108c0-f438-11e5-8038-099f03ff0738	cedro	33.30	escama de dragão
e1e10a0a-f438-11e5-8038-099f03ff0738	cedro	32.73	fibra de coração de dragão
e1e10b5e-f438-11e5-8038-099f03ff0738	cedro	32.77	coral
e1e10cbc-f438-11e5-8038-099f03ff0738	cedro	32.71	sangue de unicórnio
e1e10e1a-f438-11e5-8038-099f03ff0738	cedro	33.14	pó de chifre de unicórnio
e1e10f6e-f438-11e5-8038-099f03ff0738	macieira	33.09	pó de chifre de dragão
e1e11144-f438-11e5-8038-099f03ff0738	macieira	32.77	raiz de mandrágora
e1e112ac-f438-11e5-8038-099f03ff0738	macieira	33.07	escama de sereiano
e1e11414-f438-11e5-8038-099f03ff0738	macieira	32.70	pena de hipogrifo
e1e1157c-f438-11e5-8038-099f03ff0738	macieira	32.88	escama de dragão
e1e116f8-f438-11e5-8038-099f03ff0738	macieira	32.92	fibra de coração de dragão
e1e11874-f438-11e5-8038-099f03ff0738	macieira	32.90	pó de presa de dragão
e1e119dc-f438-11e5-8038-099f03ff0738	macieira	32.90	pó de presa de dragão
e1e11b4e-f438-11e5-8038-099f03ff0738	macieira	32.64	pêlo de cauda de testrálio
e1e11cc0-f438-11e5-8038-099f03ff0738	macieira	32.38	pó de chifre de unicórnio
e1e11e1e-f438-11e5-8038-099f03ff0738	ipê	32.53	pó de chifre de dragão
e1e11fc2-f438-11e5-8038-099f03ff0738	ipê	32.53	pó de chifre de dragão
e1e1212a-f438-11e5-8038-099f03ff0738	ipê	32.55	escama de sereiano
e1e1229c-f438-11e5-8038-099f03ff0738	ipê	33.11	escama de dragão
e1e123fa-f438-11e5-8038-099f03ff0738	ipê	33.11	escama de dragão
e1e1256c-f438-11e5-8038-099f03ff0738	ipê	32.97	fibra de coração de dragão
e1e126d4-f438-11e5-8038-099f03ff0738	ipê	32.85	pó de presa de dragão
e1e1283c-f438-11e5-8038-099f03ff0738	ipê	32.45	coral
e1e129b8-f438-11e5-8038-099f03ff0738	ipê	32.58	pêlo de cauda de unicórnio
e1e12b2a-f438-11e5-8038-099f03ff0738	ipê	32.53	pêlo de cauda de testrálio
e1e13142-f438-11e5-8038-099f03ff0738	ipê	32.67	pó de chifre de unicórnio
e1e132d2-f438-11e5-8038-099f03ff0738	salgueiro	32.41	pó de chifre de dragão
e1e13444-f438-11e5-8038-099f03ff0738	salgueiro	33.04	raiz de mandrágora
e1e135d4-f438-11e5-8038-099f03ff0738	salgueiro	32.70	escama de sereiano
e1e1373c-f438-11e5-8038-099f03ff0738	salgueiro	32.35	pena de hipogrifo
e1e138ae-f438-11e5-8038-099f03ff0738	salgueiro	32.63	escama de dragão
e1e13aa2-f438-11e5-8038-099f03ff0738	salgueiro	33.32	fibra de coração de dragão
e1e13c1e-f438-11e5-8038-099f03ff0738	salgueiro	33.22	pó de presa de dragão
e1e13dea-f438-11e5-8038-099f03ff0738	salgueiro	32.65	pêlo de cauda de unicórnio
e1e13fde-f438-11e5-8038-099f03ff0738	salgueiro	32.43	pêlo de cauda de testrálio
e1e14132-f438-11e5-8038-099f03ff0738	salgueiro	33.21	sangue de unicórnio
e1e14286-f438-11e5-8038-099f03ff0738	salgueiro	33.19	pó de chifre de unicórnio
e1e143f8-f438-11e5-8038-099f03ff0738	salgueiro	33.19	pó de chifre de unicórnio
e1e14556-f438-11e5-8038-099f03ff0738	sabugueiro	34.07	pó de chifre de dragão
e1e146aa-f438-11e5-8038-099f03ff0738	sabugueiro	33.20	raiz de mandrágora
e1e147f4-f438-11e5-8038-099f03ff0738	sabugueiro	33.62	escama de sereiano
e1e14948-f438-11e5-8038-099f03ff0738	sabugueiro	34.17	pena de hipogrifo
e1e14ab0-f438-11e5-8038-099f03ff0738	sabugueiro	34.17	pena de hipogrifo
e1e14c04-f438-11e5-8038-099f03ff0738	sabugueiro	33.55	escama de dragão
e1e14d62-f438-11e5-8038-099f03ff0738	sabugueiro	33.51	fibra de coração de dragão
e1e14ec0-f438-11e5-8038-099f03ff0738	sabugueiro	33.33	pó de presa de dragão
e1e15014-f438-11e5-8038-099f03ff0738	sabugueiro	33.94	pêlo de cauda de testrálio
e1e1515e-f438-11e5-8038-099f03ff0738	sabugueiro	33.94	pêlo de cauda de testrálio
e1e152b2-f438-11e5-8038-099f03ff0738	sabugueiro	34.05	pó de chifre de unicórnio
e1e15406-f438-11e5-8038-099f03ff0738	sabugueiro	33.93	cabelo de veela
e1e15550-f438-11e5-8038-099f03ff0738	figueira	34.04	pó de chifre de dragão
e1e15708-f438-11e5-8038-099f03ff0738	figueira	33.64	raiz de mandrágora
e1e15866-f438-11e5-8038-099f03ff0738	figueira	33.33	escama de sereiano
e1e159c4-f438-11e5-8038-099f03ff0738	figueira	33.53	pena de hipogrifo
e1e15b0e-f438-11e5-8038-099f03ff0738	figueira	33.90	escama de dragão
e1e15c62-f438-11e5-8038-099f03ff0738	figueira	34.14	fibra de coração de dragão
e1e15dca-f438-11e5-8038-099f03ff0738	figueira	33.47	pêlo de cauda de unicórnio
e1e15f32-f438-11e5-8038-099f03ff0738	figueira	33.57	pêlo de cauda de testrálio
e1e16086-f438-11e5-8038-099f03ff0738	figueira	33.63	sangue de unicórnio
e1e161da-f438-11e5-8038-099f03ff0738	figueira	33.32	pó de chifre de unicórnio
e1e16338-f438-11e5-8038-099f03ff0738	cerejeira	33.36	pó de chifre de dragão
e1e16482-f438-11e5-8038-099f03ff0738	cerejeira	34.16	raiz de mandrágora
e1e165d6-f438-11e5-8038-099f03ff0738	cerejeira	33.88	escama de sereiano
e1e1673e-f438-11e5-8038-099f03ff0738	cerejeira	33.33	pena de hipogrifo
e1e16892-f438-11e5-8038-099f03ff0738	cerejeira	33.40	escama de dragão
e1e169dc-f438-11e5-8038-099f03ff0738	cerejeira	33.39	fibra de coração de dragão
e1e16b30-f438-11e5-8038-099f03ff0738	cerejeira	33.91	pêlo de cauda de unicórnio
e1e16c8e-f438-11e5-8038-099f03ff0738	cerejeira	33.93	pó de chifre de unicórnio
e1e16dd8-f438-11e5-8038-099f03ff0738	carvalho	34.04	pó de chifre de dragão
e1e16f40-f438-11e5-8038-099f03ff0738	carvalho	33.59	raiz de mandrágora
e1e170d0-f438-11e5-8038-099f03ff0738	carvalho	33.23	escama de sereiano
e1e172ba-f438-11e5-8038-099f03ff0738	carvalho	34.14	pena de hipogrifo
e1e17486-f438-11e5-8038-099f03ff0738	carvalho	33.74	escama de dragão
e1e1772e-f438-11e5-8038-099f03ff0738	carvalho	33.34	fibra de coração de dragão
e1e178c8-f438-11e5-8038-099f03ff0738	carvalho	33.87	pó de presa de dragão
e1e17b5c-f438-11e5-8038-099f03ff0738	carvalho	33.65	coral
e1e17d46-f438-11e5-8038-099f03ff0738	carvalho	33.78	pêlo de cauda de unicórnio
e1e17f44-f438-11e5-8038-099f03ff0738	carvalho	33.75	pó de chifre de unicórnio
e1e18138-f438-11e5-8038-099f03ff0738	cedro	33.81	pó de chifre de dragão
e1e18304-f438-11e5-8038-099f03ff0738	cedro	33.63	raiz de mandrágora
e1e18516-f438-11e5-8038-099f03ff0738	cedro	33.29	escama de sereiano
e1e187e6-f438-11e5-8038-099f03ff0738	cedro	33.96	pena de hipogrifo
e1e18994-f438-11e5-8038-099f03ff0738	cedro	33.84	escama de dragão
e1e18c3c-f438-11e5-8038-099f03ff0738	cedro	33.64	fibra de coração de dragão
e1e18e44-f438-11e5-8038-099f03ff0738	cedro	33.38	pêlo de cauda de unicórnio
e1e1902e-f438-11e5-8038-099f03ff0738	cedro	33.75	pó de chifre de unicórnio
e1e1922c-f438-11e5-8038-099f03ff0738	macieira	33.23	pó de chifre de dragão
e1e194ca-f438-11e5-8038-099f03ff0738	macieira	33.85	escama de sereiano
e1e197a4-f438-11e5-8038-099f03ff0738	macieira	33.64	pena de hipogrifo
e1e19c04-f438-11e5-8038-099f03ff0738	macieira	33.64	pena de hipogrifo
e1e1a32a-f438-11e5-8038-099f03ff0738	macieira	33.98	escama de dragão
e1e1a848-f438-11e5-8038-099f03ff0738	macieira	33.52	pena de fênix
e1e1af46-f438-11e5-8038-099f03ff0738	macieira	33.65	fibra de coração de dragão
e1e1b644-f438-11e5-8038-099f03ff0738	macieira	34.13	pó de presa de dragão
e1e1bd4c-f438-11e5-8038-099f03ff0738	macieira	34.13	pó de presa de dragão
e1e1bf04-f438-11e5-8038-099f03ff0738	macieira	33.73	pêlo de cauda de testrálio
e1e1c062-f438-11e5-8038-099f03ff0738	macieira	34.04	pó de chifre de unicórnio
e1e1c1ac-f438-11e5-8038-099f03ff0738	ipê	33.56	pó de chifre de dragão
e1e1c300-f438-11e5-8038-099f03ff0738	ipê	33.33	pena de hipogrifo
e1e1c47c-f438-11e5-8038-099f03ff0738	ipê	33.31	escama de dragão
e1e1c5c6-f438-11e5-8038-099f03ff0738	ipê	33.31	escama de dragão
e1e1c71a-f438-11e5-8038-099f03ff0738	ipê	33.86	fibra de coração de dragão
e1e1c86e-f438-11e5-8038-099f03ff0738	ipê	33.44	coral
e1e1c9cc-f438-11e5-8038-099f03ff0738	ipê	34.00	pêlo de cauda de unicórnio
e1e1cb20-f438-11e5-8038-099f03ff0738	ipê	33.54	pêlo de cauda de testrálio
e1e1cc7e-f438-11e5-8038-099f03ff0738	ipê	33.54	pêlo de cauda de testrálio
e1e1cdd2-f438-11e5-8038-099f03ff0738	ipê	33.52	pó de chifre de unicórnio
e1e1cf1c-f438-11e5-8038-099f03ff0738	salgueiro	33.67	pó de chifre de dragão
e1e1d084-f438-11e5-8038-099f03ff0738	salgueiro	33.48	escama de sereiano
e1e1d1e2-f438-11e5-8038-099f03ff0738	salgueiro	33.30	pena de hipogrifo
e1e1d340-f438-11e5-8038-099f03ff0738	salgueiro	33.78	escama de dragão
e1e1d48a-f438-11e5-8038-099f03ff0738	salgueiro	33.36	pena de fênix
e1e1d5e8-f438-11e5-8038-099f03ff0738	salgueiro	33.88	fibra de coração de dragão
e1e1d73c-f438-11e5-8038-099f03ff0738	salgueiro	33.22	pó de presa de dragão
e1e1d886-f438-11e5-8038-099f03ff0738	salgueiro	33.76	pêlo de cauda de unicórnio
e1e1d9da-f438-11e5-8038-099f03ff0738	salgueiro	33.96	pêlo de cauda de testrálio
e1e1db2e-f438-11e5-8038-099f03ff0738	salgueiro	33.34	sangue de unicórnio
e1e1dca0-f438-11e5-8038-099f03ff0738	salgueiro	33.42	pó de chifre de unicórnio
e1e1ddea-f438-11e5-8038-099f03ff0738	sabugueiro	34.17	pó de chifre de dragão
e1e1e0a6-f438-11e5-8038-099f03ff0738	sabugueiro	33.70	escama de sereiano
e1e1e204-f438-11e5-8038-099f03ff0738	sabugueiro	33.87	pena de hipogrifo
e1e1e376-f438-11e5-8038-099f03ff0738	sabugueiro	33.90	escama de dragão
e1e1e4ca-f438-11e5-8038-099f03ff0738	sabugueiro	34.25	pena de fênix
e1e1e628-f438-11e5-8038-099f03ff0738	sabugueiro	34.25	pena de fênix
e1e1e77c-f438-11e5-8038-099f03ff0738	sabugueiro	33.45	fibra de coração de dragão
e1e1e8c6-f438-11e5-8038-099f03ff0738	sabugueiro	33.39	coral
e1e1ea1a-f438-11e5-8038-099f03ff0738	sabugueiro	34.30	pêlo de cauda de testrálio
e1e1eb6e-f438-11e5-8038-099f03ff0738	sabugueiro	33.83	pó de chifre de unicórnio
e1e1ecb8-f438-11e5-8038-099f03ff0738	sabugueiro	33.97	cabelo de veela
e1e1ee0c-f438-11e5-8038-099f03ff0738	figueira	33.75	pó de chifre de dragão
e1e1ef6a-f438-11e5-8038-099f03ff0738	figueira	34.23	raiz de mandrágora
e1e1f0be-f438-11e5-8038-099f03ff0738	figueira	33.61	escama de sereiano
e1e1f208-f438-11e5-8038-099f03ff0738	figueira	33.92	pena de hipogrifo
e1e1f35c-f438-11e5-8038-099f03ff0738	figueira	33.34	escama de dragão
e1e1f4ba-f438-11e5-8038-099f03ff0738	figueira	34.28	fibra de coração de dragão
e1e1f60e-f438-11e5-8038-099f03ff0738	figueira	33.46	pêlo de cauda de unicórnio
e1e1f762-f438-11e5-8038-099f03ff0738	figueira	33.53	pó de chifre de unicórnio
e1e1f8b6-f438-11e5-8038-099f03ff0738	cerejeira	33.88	pó de chifre de dragão
e1e1fa14-f438-11e5-8038-099f03ff0738	cerejeira	33.76	escama de sereiano
e1e1fb86-f438-11e5-8038-099f03ff0738	cerejeira	34.23	pena de hipogrifo
e1e1fcf8-f438-11e5-8038-099f03ff0738	cerejeira	34.26	escama de dragão
e1e1fe56-f438-11e5-8038-099f03ff0738	cerejeira	33.85	fibra de coração de dragão
e1e1ffaa-f438-11e5-8038-099f03ff0738	cerejeira	33.73	coral
e1e200f4-f438-11e5-8038-099f03ff0738	cerejeira	34.21	pêlo de cauda de unicórnio
e1e20248-f438-11e5-8038-099f03ff0738	cerejeira	33.86	pó de chifre de unicórnio
e1e2039c-f438-11e5-8038-099f03ff0738	cerejeira	33.72	cabelo de veela
e1e204fa-f438-11e5-8038-099f03ff0738	carvalho	33.97	pó de chifre de dragão
e1e20658-f438-11e5-8038-099f03ff0738	carvalho	33.68	raiz de mandrágora
e1e207b6-f438-11e5-8038-099f03ff0738	carvalho	33.53	escama de sereiano
e1e20914-f438-11e5-8038-099f03ff0738	carvalho	33.91	pena de hipogrifo
e1e20a54-f438-11e5-8038-099f03ff0738	carvalho	34.16	escama de dragão
e1e20bb2-f438-11e5-8038-099f03ff0738	carvalho	33.98	pena de fênix
e1e20d06-f438-11e5-8038-099f03ff0738	carvalho	33.70	fibra de coração de dragão
e1e20e5a-f438-11e5-8038-099f03ff0738	carvalho	33.63	pêlo de cauda de unicórnio
e1e20fae-f438-11e5-8038-099f03ff0738	carvalho	33.34	pó de chifre de unicórnio
e1e21102-f438-11e5-8038-099f03ff0738	carvalho	33.87	cabelo de veela
e1e21256-f438-11e5-8038-099f03ff0738	cedro	33.47	pó de chifre de dragão
e1e213b4-f438-11e5-8038-099f03ff0738	cedro	33.40	raiz de mandrágora
e1e21508-f438-11e5-8038-099f03ff0738	cedro	34.02	escama de sereiano
e1e2165c-f438-11e5-8038-099f03ff0738	cedro	34.13	pena de hipogrifo
e1e217a6-f438-11e5-8038-099f03ff0738	cedro	33.57	escama de dragão
e1e2190e-f438-11e5-8038-099f03ff0738	cedro	33.82	fibra de coração de dragão
e1e21a62-f438-11e5-8038-099f03ff0738	cedro	33.80	pó de presa de dragão
e1e21bb6-f438-11e5-8038-099f03ff0738	cedro	33.95	coral
e1e21d0a-f438-11e5-8038-099f03ff0738	cedro	33.79	pêlo de cauda de unicórnio
e1e21e5e-f438-11e5-8038-099f03ff0738	cedro	33.51	pêlo de cauda de testrálio
e1e21fb2-f438-11e5-8038-099f03ff0738	cedro	33.93	pó de chifre de unicórnio
e1e220fc-f438-11e5-8038-099f03ff0738	cedro	34.05	cabelo de veela
e1e22250-f438-11e5-8038-099f03ff0738	macieira	33.87	pó de chifre de dragão
e1e223ae-f438-11e5-8038-099f03ff0738	macieira	34.01	raiz de mandrágora
e1e22502-f438-11e5-8038-099f03ff0738	macieira	34.26	escama de sereiano
e1e22660-f438-11e5-8038-099f03ff0738	macieira	33.58	pena de hipogrifo
e1e227be-f438-11e5-8038-099f03ff0738	macieira	33.81	escama de dragão
e1e22912-f438-11e5-8038-099f03ff0738	macieira	34.28	fibra de coração de dragão
e1e22a7a-f438-11e5-8038-099f03ff0738	macieira	33.40	coral
e1e22be2-f438-11e5-8038-099f03ff0738	macieira	33.50	pó de chifre de unicórnio
e1e22d36-f438-11e5-8038-099f03ff0738	ipê	33.94	pó de chifre de dragão
e1e22e8a-f438-11e5-8038-099f03ff0738	ipê	33.94	pó de chifre de dragão
e1e22fe8-f438-11e5-8038-099f03ff0738	ipê	33.36	raiz de mandrágora
e1e2313c-f438-11e5-8038-099f03ff0738	ipê	33.62	escama de sereiano
e1e232ae-f438-11e5-8038-099f03ff0738	ipê	33.54	pena de hipogrifo
e1e233f8-f438-11e5-8038-099f03ff0738	ipê	33.49	escama de dragão
e1e23556-f438-11e5-8038-099f03ff0738	ipê	34.01	fibra de coração de dragão
e1e236b4-f438-11e5-8038-099f03ff0738	ipê	34.18	pó de presa de dragão
e1e237fe-f438-11e5-8038-099f03ff0738	ipê	34.03	coral
e1e23952-f438-11e5-8038-099f03ff0738	ipê	34.03	coral
e1e23c0e-f438-11e5-8038-099f03ff0738	ipê	33.49	sangue de unicórnio
e1e23e0c-f438-11e5-8038-099f03ff0738	ipê	33.44	pó de chifre de unicórnio
e1e23f56-f438-11e5-8038-099f03ff0738	ipê	33.90	cabelo de veela
e1e240b4-f438-11e5-8038-099f03ff0738	salgueiro	33.49	pó de chifre de dragão
e1e24208-f438-11e5-8038-099f03ff0738	salgueiro	33.93	escama de sereiano
e1e2435c-f438-11e5-8038-099f03ff0738	salgueiro	34.18	pena de hipogrifo
e1e244a6-f438-11e5-8038-099f03ff0738	salgueiro	34.09	escama de dragão
e1e24604-f438-11e5-8038-099f03ff0738	salgueiro	33.88	pena de fênix
e1e24758-f438-11e5-8038-099f03ff0738	salgueiro	33.43	fibra de coração de dragão
e1e248b6-f438-11e5-8038-099f03ff0738	salgueiro	33.60	pó de presa de dragão
e1e249f6-f438-11e5-8038-099f03ff0738	salgueiro	33.60	coral
e1e24b4a-f438-11e5-8038-099f03ff0738	salgueiro	34.23	pêlo de cauda de unicórnio
e1e24cbc-f438-11e5-8038-099f03ff0738	salgueiro	34.29	pó de chifre de unicórnio
e1e24e06-f438-11e5-8038-099f03ff0738	salgueiro	33.67	cabelo de veela
e1e24f5a-f438-11e5-8038-099f03ff0738	sabugueiro	34.69	pó de chifre de dragão
e1e250ae-f438-11e5-8038-099f03ff0738	sabugueiro	34.67	raiz de mandrágora
e1e25202-f438-11e5-8038-099f03ff0738	sabugueiro	35.06	escama de sereiano
e1e25360-f438-11e5-8038-099f03ff0738	sabugueiro	35.06	escama de sereiano
e1e254be-f438-11e5-8038-099f03ff0738	sabugueiro	34.48	pena de hipogrifo
e1e25630-f438-11e5-8038-099f03ff0738	sabugueiro	34.42	escama de dragão
e1e2577a-f438-11e5-8038-099f03ff0738	sabugueiro	34.42	escama de dragão
e1e258ce-f438-11e5-8038-099f03ff0738	sabugueiro	34.40	fibra de coração de dragão
e1e25a22-f438-11e5-8038-099f03ff0738	sabugueiro	34.09	pêlo de cauda de unicórnio
e1e25b76-f438-11e5-8038-099f03ff0738	sabugueiro	34.89	pó de chifre de unicórnio
e1e25cc0-f438-11e5-8038-099f03ff0738	sabugueiro	34.99	cabelo de veela
e1e25e96-f438-11e5-8038-099f03ff0738	figueira	34.40	pó de chifre de dragão
e1e26062-f438-11e5-8038-099f03ff0738	figueira	35.08	raiz de mandrágora
e1e261ac-f438-11e5-8038-099f03ff0738	figueira	35.08	raiz de mandrágora
e1e26300-f438-11e5-8038-099f03ff0738	figueira	34.91	escama de sereiano
e1e26562-f438-11e5-8038-099f03ff0738	figueira	34.77	pena de hipogrifo
e1e266c0-f438-11e5-8038-099f03ff0738	figueira	34.68	escama de dragão
e1e2680a-f438-11e5-8038-099f03ff0738	figueira	34.98	fibra de coração de dragão
e1e26972-f438-11e5-8038-099f03ff0738	figueira	34.58	coral
e1e26ada-f438-11e5-8038-099f03ff0738	figueira	34.67	pêlo de cauda de unicórnio
e1e26c1a-f438-11e5-8038-099f03ff0738	figueira	34.61	sangue de unicórnio
e1e2702a-f438-11e5-8038-099f03ff0738	figueira	34.39	pó de chifre de unicórnio
e1e271ba-f438-11e5-8038-099f03ff0738	cerejeira	34.22	pó de chifre de dragão
e1e27318-f438-11e5-8038-099f03ff0738	cerejeira	34.40	escama de dragão
e1e27462-f438-11e5-8038-099f03ff0738	cerejeira	35.06	pena de fênix
e1e275b6-f438-11e5-8038-099f03ff0738	cerejeira	34.18	fibra de coração de dragão
e1e27714-f438-11e5-8038-099f03ff0738	cerejeira	34.78	pó de presa de dragão
e1e2785e-f438-11e5-8038-099f03ff0738	cerejeira	34.67	coral
e1e279b2-f438-11e5-8038-099f03ff0738	cerejeira	34.27	pêlo de cauda de unicórnio
e1e27b06-f438-11e5-8038-099f03ff0738	cerejeira	34.50	pó de chifre de unicórnio
e1e27c6e-f438-11e5-8038-099f03ff0738	carvalho	34.80	pó de chifre de dragão
e1e27dae-f438-11e5-8038-099f03ff0738	carvalho	34.80	pó de chifre de dragão
e1e27f0c-f438-11e5-8038-099f03ff0738	carvalho	34.53	raiz de mandrágora
e1e28060-f438-11e5-8038-099f03ff0738	carvalho	34.77	escama de dragão
e1e281aa-f438-11e5-8038-099f03ff0738	carvalho	34.77	escama de dragão
e1e282fe-f438-11e5-8038-099f03ff0738	carvalho	34.57	fibra de coração de dragão
e1e28452-f438-11e5-8038-099f03ff0738	carvalho	34.43	pó de presa de dragão
e1e285a6-f438-11e5-8038-099f03ff0738	carvalho	35.07	coral
e1e286f0-f438-11e5-8038-099f03ff0738	carvalho	34.11	pêlo de cauda de unicórnio
e1e28844-f438-11e5-8038-099f03ff0738	carvalho	34.56	cabelo de veela
e1e289ac-f438-11e5-8038-099f03ff0738	cedro	34.65	pó de chifre de dragão
e1e28b14-f438-11e5-8038-099f03ff0738	cedro	34.71	raiz de mandrágora
e1e28c54-f438-11e5-8038-099f03ff0738	cedro	34.42	escama de sereiano
e1e28dbc-f438-11e5-8038-099f03ff0738	cedro	34.39	pena de hipogrifo
e1e28f10-f438-11e5-8038-099f03ff0738	cedro	34.88	escama de dragão
e1e29050-f438-11e5-8038-099f03ff0738	cedro	34.63	fibra de coração de dragão
e1e291b8-f438-11e5-8038-099f03ff0738	cedro	34.41	pó de presa de dragão
e1e2930c-f438-11e5-8038-099f03ff0738	cedro	34.34	coral
e1e2947e-f438-11e5-8038-099f03ff0738	cedro	34.58	pêlo de cauda de unicórnio
e1e295c8-f438-11e5-8038-099f03ff0738	cedro	34.29	pêlo de cauda de testrálio
e1e2971c-f438-11e5-8038-099f03ff0738	cedro	34.29	pêlo de cauda de testrálio
e1e29870-f438-11e5-8038-099f03ff0738	cedro	34.16	pó de chifre de unicórnio
e1e299ba-f438-11e5-8038-099f03ff0738	cedro	34.36	cabelo de veela
e1e29b18-f438-11e5-8038-099f03ff0738	macieira	34.64	pó de chifre de dragão
e1e29c6c-f438-11e5-8038-099f03ff0738	macieira	34.58	escama de sereiano
e1e29dd4-f438-11e5-8038-099f03ff0738	macieira	34.29	escama de dragão
e1e29fa0-f438-11e5-8038-099f03ff0738	macieira	34.98	fibra de coração de dragão
e1e2a11c-f438-11e5-8038-099f03ff0738	macieira	34.23	pó de presa de dragão
e1e2a298-f438-11e5-8038-099f03ff0738	macieira	34.88	coral
e1e2a3f6-f438-11e5-8038-099f03ff0738	macieira	34.27	pêlo de cauda de unicórnio
e1e2a568-f438-11e5-8038-099f03ff0738	macieira	34.97	pó de chifre de unicórnio
e1e2a6d0-f438-11e5-8038-099f03ff0738	macieira	34.45	cabelo de veela
e1e2a856-f438-11e5-8038-099f03ff0738	ipê	34.77	pó de chifre de dragão
e1e2a9be-f438-11e5-8038-099f03ff0738	ipê	34.34	raiz de mandrágora
e1e2ab3a-f438-11e5-8038-099f03ff0738	ipê	34.19	escama de sereiano
e1e2acac-f438-11e5-8038-099f03ff0738	ipê	34.25	pena de hipogrifo
e1e2ae0a-f438-11e5-8038-099f03ff0738	ipê	34.54	escama de dragão
e1e2af72-f438-11e5-8038-099f03ff0738	ipê	34.33	fibra de coração de dragão
e1e2b0da-f438-11e5-8038-099f03ff0738	ipê	34.66	coral
e1e2b256-f438-11e5-8038-099f03ff0738	ipê	34.57	pêlo de cauda de unicórnio
e1e2b3be-f438-11e5-8038-099f03ff0738	ipê	34.62	pó de chifre de unicórnio
e1e2b616-f438-11e5-8038-099f03ff0738	ipê	34.51	cabelo de veela
e1e2b882-f438-11e5-8038-099f03ff0738	salgueiro	34.27	pó de chifre de dragão
e1e2ba9e-f438-11e5-8038-099f03ff0738	salgueiro	34.50	pena de hipogrifo
e1e2bcb0-f438-11e5-8038-099f03ff0738	salgueiro	34.28	escama de dragão
e1e2bec2-f438-11e5-8038-099f03ff0738	salgueiro	34.53	fibra de coração de dragão
e1e2c0d4-f438-11e5-8038-099f03ff0738	salgueiro	34.53	fibra de coração de dragão
e1e2c2d2-f438-11e5-8038-099f03ff0738	salgueiro	34.48	pó de presa de dragão
e1e2c4e4-f438-11e5-8038-099f03ff0738	salgueiro	34.71	coral
e1e2c78c-f438-11e5-8038-099f03ff0738	salgueiro	34.75	pó de chifre de unicórnio
e1e2c9da-f438-11e5-8038-099f03ff0738	sabugueiro	35.46	pó de chifre de dragão
e1e2cc6e-f438-11e5-8038-099f03ff0738	sabugueiro	34.85	raiz de mandrágora
e1e2cf02-f438-11e5-8038-099f03ff0738	sabugueiro	34.91	pena de hipogrifo
e1e2d240-f438-11e5-8038-099f03ff0738	sabugueiro	34.92	escama de dragão
e1e2d498-f438-11e5-8038-099f03ff0738	sabugueiro	35.60	fibra de coração de dragão
e1e2d7cc-f438-11e5-8038-099f03ff0738	sabugueiro	35.07	pó de presa de dragão
e1e2d9de-f438-11e5-8038-099f03ff0738	sabugueiro	34.79	coral
e1e2dbbe-f438-11e5-8038-099f03ff0738	sabugueiro	35.60	pó de chifre de unicórnio
e1e2ddbc-f438-11e5-8038-099f03ff0738	sabugueiro	35.16	cabelo de veela
e1e2dfb0-f438-11e5-8038-099f03ff0738	figueira	35.16	pó de chifre de dragão
e1e2e352-f438-11e5-8038-099f03ff0738	figueira	35.07	raiz de mandrágora
e1e2e564-f438-11e5-8038-099f03ff0738	figueira	35.28	pena de hipogrifo
e1e2e7d0-f438-11e5-8038-099f03ff0738	figueira	34.76	escama de dragão
e1e2ea50-f438-11e5-8038-099f03ff0738	figueira	35.68	fibra de coração de dragão
e1e2ebf4-f438-11e5-8038-099f03ff0738	figueira	35.68	pó de chifre de unicórnio
e1e2ed5c-f438-11e5-8038-099f03ff0738	figueira	35.54	cabelo de veela
e1e2ef3c-f438-11e5-8038-099f03ff0738	cerejeira	35.19	pó de chifre de dragão
e1e2f090-f438-11e5-8038-099f03ff0738	cerejeira	35.56	raiz de mandrágora
e1e2f1da-f438-11e5-8038-099f03ff0738	cerejeira	35.19	escama de sereiano
e1e2f324-f438-11e5-8038-099f03ff0738	cerejeira	35.03	pena de hipogrifo
e1e2f478-f438-11e5-8038-099f03ff0738	cerejeira	35.15	escama de dragão
e1e2f5cc-f438-11e5-8038-099f03ff0738	cerejeira	35.67	fibra de coração de dragão
e1e2f716-f438-11e5-8038-099f03ff0738	cerejeira	35.16	pó de presa de dragão
e1e2f888-f438-11e5-8038-099f03ff0738	cerejeira	35.07	pêlo de cauda de unicórnio
e1e2f9e6-f438-11e5-8038-099f03ff0738	cerejeira	35.01	pó de chifre de unicórnio
e1e2fb30-f438-11e5-8038-099f03ff0738	carvalho	34.93	pó de chifre de dragão
e1e2fc98-f438-11e5-8038-099f03ff0738	carvalho	35.27	raiz de mandrágora
e1e2fdf6-f438-11e5-8038-099f03ff0738	carvalho	35.00	escama de sereiano
e1e2ff40-f438-11e5-8038-099f03ff0738	carvalho	35.09	escama de dragão
e1e30094-f438-11e5-8038-099f03ff0738	carvalho	35.21	fibra de coração de dragão
e1e301fc-f438-11e5-8038-099f03ff0738	carvalho	35.59	pó de presa de dragão
e1e304ae-f438-11e5-8038-099f03ff0738	carvalho	34.76	pêlo de cauda de unicórnio
e1e30602-f438-11e5-8038-099f03ff0738	carvalho	34.76	pêlo de cauda de unicórnio
e1e30774-f438-11e5-8038-099f03ff0738	carvalho	35.01	pó de chifre de unicórnio
e1e308d2-f438-11e5-8038-099f03ff0738	cedro	34.71	pó de chifre de dragão
e1e30a26-f438-11e5-8038-099f03ff0738	cedro	35.38	raiz de mandrágora
e1e30b70-f438-11e5-8038-099f03ff0738	cedro	34.82	escama de sereiano
e1e30cc4-f438-11e5-8038-099f03ff0738	cedro	35.45	pena de hipogrifo
e1e30e18-f438-11e5-8038-099f03ff0738	cedro	34.84	escama de dragão
e1e30f62-f438-11e5-8038-099f03ff0738	cedro	34.84	escama de dragão
e1e310ca-f438-11e5-8038-099f03ff0738	cedro	35.68	fibra de coração de dragão
e1e31228-f438-11e5-8038-099f03ff0738	cedro	35.67	pó de presa de dragão
e1e3137c-f438-11e5-8038-099f03ff0738	cedro	35.02	pêlo de cauda de unicórnio
e1e314c6-f438-11e5-8038-099f03ff0738	cedro	35.02	pêlo de cauda de unicórnio
e1e3162e-f438-11e5-8038-099f03ff0738	cedro	35.21	pó de chifre de unicórnio
e1e31782-f438-11e5-8038-099f03ff0738	cedro	35.05	cabelo de veela
e1e318d6-f438-11e5-8038-099f03ff0738	macieira	34.71	pó de chifre de dragão
e1e31a34-f438-11e5-8038-099f03ff0738	macieira	35.10	escama de sereiano
e1e31b88-f438-11e5-8038-099f03ff0738	macieira	34.81	pena de hipogrifo
e1e31cdc-f438-11e5-8038-099f03ff0738	macieira	34.91	escama de dragão
e1e31e4e-f438-11e5-8038-099f03ff0738	macieira	35.26	fibra de coração de dragão
e1e31fa2-f438-11e5-8038-099f03ff0738	macieira	35.55	pó de presa de dragão
e1e320f6-f438-11e5-8038-099f03ff0738	macieira	35.54	pêlo de cauda de unicórnio
e1e32240-f438-11e5-8038-099f03ff0738	macieira	35.25	pó de chifre de unicórnio
e1e3239e-f438-11e5-8038-099f03ff0738	ipê	34.74	pó de chifre de dragão
e1e324f2-f438-11e5-8038-099f03ff0738	ipê	35.03	raiz de mandrágora
e1e3263c-f438-11e5-8038-099f03ff0738	ipê	34.96	escama de sereiano
e1e32786-f438-11e5-8038-099f03ff0738	ipê	34.97	pena de hipogrifo
e1e328ee-f438-11e5-8038-099f03ff0738	ipê	35.39	escama de dragão
e1e32a4c-f438-11e5-8038-099f03ff0738	ipê	35.60	fibra de coração de dragão
e1e32b96-f438-11e5-8038-099f03ff0738	ipê	35.11	pêlo de cauda de unicórnio
e1e32ce0-f438-11e5-8038-099f03ff0738	ipê	34.84	pêlo de cauda de testrálio
e1e32e3e-f438-11e5-8038-099f03ff0738	ipê	35.31	pó de chifre de unicórnio
e1e32f92-f438-11e5-8038-099f03ff0738	salgueiro	35.02	pó de chifre de dragão
e1e330dc-f438-11e5-8038-099f03ff0738	salgueiro	35.06	raiz de mandrágora
e1e33244-f438-11e5-8038-099f03ff0738	salgueiro	35.07	escama de sereiano
e1e33398-f438-11e5-8038-099f03ff0738	salgueiro	34.78	pena de hipogrifo
e1e334ec-f438-11e5-8038-099f03ff0738	salgueiro	35.65	escama de dragão
e1e33640-f438-11e5-8038-099f03ff0738	salgueiro	35.65	escama de dragão
e1e337f8-f438-11e5-8038-099f03ff0738	salgueiro	35.20	fibra de coração de dragão
e1e33960-f438-11e5-8038-099f03ff0738	salgueiro	35.50	pó de presa de dragão
e1e33aaa-f438-11e5-8038-099f03ff0738	salgueiro	35.50	coral
e1e33c12-f438-11e5-8038-099f03ff0738	salgueiro	35.28	pêlo de cauda de unicórnio
e1e33d70-f438-11e5-8038-099f03ff0738	salgueiro	34.96	pó de chifre de unicórnio
e1e33ec4-f438-11e5-8038-099f03ff0738	salgueiro	34.96	pó de chifre de unicórnio
e1e3400e-f438-11e5-8038-099f03ff0738	salgueiro	35.48	cabelo de veela
e1e34162-f438-11e5-8038-099f03ff0738	sabugueiro	35.08	pó de chifre de dragão
e1e342c0-f438-11e5-8038-099f03ff0738	sabugueiro	35.95	pena de hipogrifo
e1e34414-f438-11e5-8038-099f03ff0738	sabugueiro	35.58	escama de dragão
e1e34568-f438-11e5-8038-099f03ff0738	sabugueiro	35.52	fibra de coração de dragão
e1e346bc-f438-11e5-8038-099f03ff0738	sabugueiro	35.30	pó de presa de dragão
e1e34810-f438-11e5-8038-099f03ff0738	sabugueiro	35.97	pêlo de cauda de unicórnio
e1e34964-f438-11e5-8038-099f03ff0738	sabugueiro	35.10	pêlo de cauda de testrálio
e1e34ab8-f438-11e5-8038-099f03ff0738	sabugueiro	35.48	sangue de unicórnio
e1e34c02-f438-11e5-8038-099f03ff0738	sabugueiro	35.60	pó de chifre de unicórnio
e1e34d60-f438-11e5-8038-099f03ff0738	figueira	35.89	pó de chifre de dragão
e1e34ebe-f438-11e5-8038-099f03ff0738	figueira	35.59	escama de sereiano
e1e35012-f438-11e5-8038-099f03ff0738	figueira	35.94	pena de hipogrifo
e1e35166-f438-11e5-8038-099f03ff0738	figueira	35.49	escama de dragão
e1e352ba-f438-11e5-8038-099f03ff0738	figueira	35.20	fibra de coração de dragão
e1e35422-f438-11e5-8038-099f03ff0738	figueira	35.63	pó de presa de dragão
e1e35576-f438-11e5-8038-099f03ff0738	figueira	35.92	pêlo de cauda de unicórnio
e1e356b6-f438-11e5-8038-099f03ff0738	figueira	35.10	sangue de unicórnio
e1e3580a-f438-11e5-8038-099f03ff0738	figueira	35.25	pó de chifre de unicórnio
e1e35972-f438-11e5-8038-099f03ff0738	figueira	35.25	pó de chifre de unicórnio
e1e35ad0-f438-11e5-8038-099f03ff0738	cerejeira	35.03	pó de chifre de dragão
e1e35c1a-f438-11e5-8038-099f03ff0738	cerejeira	35.98	raiz de mandrágora
e1e35d78-f438-11e5-8038-099f03ff0738	cerejeira	35.45	pena de hipogrifo
e1e35ed6-f438-11e5-8038-099f03ff0738	cerejeira	35.20	escama de dragão
e1e36020-f438-11e5-8038-099f03ff0738	cerejeira	35.14	fibra de coração de dragão
e1e36174-f438-11e5-8038-099f03ff0738	cerejeira	35.24	pó de presa de dragão
e1e362c8-f438-11e5-8038-099f03ff0738	cerejeira	35.15	coral
e1e36426-f438-11e5-8038-099f03ff0738	cerejeira	35.07	pêlo de cauda de unicórnio
e1e36570-f438-11e5-8038-099f03ff0738	cerejeira	35.07	pêlo de cauda de unicórnio
e1e366ce-f438-11e5-8038-099f03ff0738	cerejeira	35.22	pêlo de cauda de testrálio
e1e36818-f438-11e5-8038-099f03ff0738	cerejeira	35.23	pó de chifre de unicórnio
e1e3698a-f438-11e5-8038-099f03ff0738	carvalho	35.04	pó de chifre de dragão
e1e36ad4-f438-11e5-8038-099f03ff0738	carvalho	35.04	pó de chifre de dragão
e1e36c28-f438-11e5-8038-099f03ff0738	carvalho	35.89	raiz de mandrágora
e1e36d7c-f438-11e5-8038-099f03ff0738	carvalho	35.09	escama de sereiano
e1e36ed0-f438-11e5-8038-099f03ff0738	carvalho	35.51	pena de hipogrifo
e1e3702e-f438-11e5-8038-099f03ff0738	carvalho	35.89	escama de dragão
e1e37182-f438-11e5-8038-099f03ff0738	carvalho	35.45	pena de fênix
e1e373b2-f438-11e5-8038-099f03ff0738	carvalho	35.81	fibra de coração de dragão
e1e3751a-f438-11e5-8038-099f03ff0738	carvalho	35.47	pó de presa de dragão
e1e376dc-f438-11e5-8038-099f03ff0738	carvalho	35.42	pêlo de cauda de unicórnio
e1e37830-f438-11e5-8038-099f03ff0738	carvalho	35.28	pêlo de cauda de testrálio
e1e3797a-f438-11e5-8038-099f03ff0738	carvalho	35.28	pêlo de cauda de testrálio
e1e37ac4-f438-11e5-8038-099f03ff0738	carvalho	35.39	pó de chifre de unicórnio
e1e37c22-f438-11e5-8038-099f03ff0738	cedro	35.59	pó de chifre de dragão
e1e37d76-f438-11e5-8038-099f03ff0738	cedro	35.78	raiz de mandrágora
e1e37eca-f438-11e5-8038-099f03ff0738	cedro	35.20	escama de sereiano
e1e3801e-f438-11e5-8038-099f03ff0738	cedro	35.02	pena de hipogrifo
e1e38168-f438-11e5-8038-099f03ff0738	cedro	35.09	escama de dragão
e1e382b2-f438-11e5-8038-099f03ff0738	cedro	35.09	escama de dragão
e1e38514-f438-11e5-8038-099f03ff0738	cedro	35.73	fibra de coração de dragão
e1e38672-f438-11e5-8038-099f03ff0738	cedro	35.73	pó de presa de dragão
e1e387e4-f438-11e5-8038-099f03ff0738	cedro	35.73	pó de presa de dragão
e1e3892e-f438-11e5-8038-099f03ff0738	cedro	35.82	coral
e1e38a8c-f438-11e5-8038-099f03ff0738	cedro	35.30	pêlo de cauda de unicórnio
e1e38bea-f438-11e5-8038-099f03ff0738	cedro	35.30	pêlo de cauda de unicórnio
e1e38d52-f438-11e5-8038-099f03ff0738	cedro	35.35	pó de chifre de unicórnio
e1e38ea6-f438-11e5-8038-099f03ff0738	macieira	35.06	pó de chifre de dragão
e1e39004-f438-11e5-8038-099f03ff0738	macieira	35.05	escama de sereiano
e1e39158-f438-11e5-8038-099f03ff0738	macieira	35.50	pena de hipogrifo
e1e392a2-f438-11e5-8038-099f03ff0738	macieira	35.70	escama de dragão
e1e393f6-f438-11e5-8038-099f03ff0738	macieira	35.73	fibra de coração de dragão
e1e3954a-f438-11e5-8038-099f03ff0738	macieira	35.02	pó de presa de dragão
e1e396a8-f438-11e5-8038-099f03ff0738	macieira	35.01	coral
e1e397f2-f438-11e5-8038-099f03ff0738	macieira	35.01	coral
e1e39946-f438-11e5-8038-099f03ff0738	macieira	35.26	pêlo de cauda de unicórnio
e1e39aa4-f438-11e5-8038-099f03ff0738	macieira	35.26	pêlo de cauda de unicórnio
e1e39bee-f438-11e5-8038-099f03ff0738	macieira	35.06	sangue de unicórnio
e1e39d42-f438-11e5-8038-099f03ff0738	macieira	35.03	pó de chifre de unicórnio
e1e39ea0-f438-11e5-8038-099f03ff0738	macieira	35.03	pó de chifre de unicórnio
e1e39fea-f438-11e5-8038-099f03ff0738	macieira	35.03	cabelo de veela
e1e3a13e-f438-11e5-8038-099f03ff0738	ipê	35.56	pó de chifre de dragão
e1e3a2a6-f438-11e5-8038-099f03ff0738	ipê	35.37	raiz de mandrágora
e1e3a40e-f438-11e5-8038-099f03ff0738	ipê	35.91	pena de hipogrifo
e1e3a558-f438-11e5-8038-099f03ff0738	ipê	35.71	escama de dragão
e1e3a6b6-f438-11e5-8038-099f03ff0738	ipê	35.80	fibra de coração de dragão
e1e3a814-f438-11e5-8038-099f03ff0738	ipê	35.52	coral
e1e3a968-f438-11e5-8038-099f03ff0738	ipê	35.02	pêlo de cauda de unicórnio
e1e3aabc-f438-11e5-8038-099f03ff0738	ipê	35.65	pó de chifre de unicórnio
e1e3ac10-f438-11e5-8038-099f03ff0738	ipê	35.83	cabelo de veela
e1e3ad64-f438-11e5-8038-099f03ff0738	salgueiro	35.28	pó de chifre de dragão
e1e3aec2-f438-11e5-8038-099f03ff0738	salgueiro	35.29	escama de sereiano
e1e3b016-f438-11e5-8038-099f03ff0738	salgueiro	35.38	pena de hipogrifo
e1e3b174-f438-11e5-8038-099f03ff0738	salgueiro	35.67	escama de dragão
e1e3b2dc-f438-11e5-8038-099f03ff0738	salgueiro	35.11	fibra de coração de dragão
e1e3b426-f438-11e5-8038-099f03ff0738	salgueiro	35.51	pó de presa de dragão
e1e3b584-f438-11e5-8038-099f03ff0738	salgueiro	35.91	pêlo de cauda de unicórnio
e1e3b8f4-f438-11e5-8038-099f03ff0738	salgueiro	35.37	pêlo de cauda de testrálio
e1e3ba52-f438-11e5-8038-099f03ff0738	salgueiro	35.32	pó de chifre de unicórnio
e1e3bbba-f438-11e5-8038-099f03ff0738	sabugueiro	36.07	pó de chifre de dragão
e1e3bd2c-f438-11e5-8038-099f03ff0738	sabugueiro	36.31	escama de sereiano
e1e3be80-f438-11e5-8038-099f03ff0738	sabugueiro	36.06	pena de hipogrifo
e1e3bfca-f438-11e5-8038-099f03ff0738	sabugueiro	36.01	escama de dragão
e1e3c13c-f438-11e5-8038-099f03ff0738	sabugueiro	36.01	escama de dragão
e1e3c290-f438-11e5-8038-099f03ff0738	sabugueiro	36.52	pena de fênix
e1e3c3da-f438-11e5-8038-099f03ff0738	sabugueiro	36.33	fibra de coração de dragão
e1e3c538-f438-11e5-8038-099f03ff0738	sabugueiro	36.23	pó de presa de dragão
e1e3c6a0-f438-11e5-8038-099f03ff0738	sabugueiro	36.14	pêlo de cauda de unicórnio
e1e3c808-f438-11e5-8038-099f03ff0738	sabugueiro	36.46	pó de chifre de unicórnio
e1e3c952-f438-11e5-8038-099f03ff0738	figueira	36.12	pó de chifre de dragão
e1e3caba-f438-11e5-8038-099f03ff0738	figueira	36.23	raiz de mandrágora
e1e3cc0e-f438-11e5-8038-099f03ff0738	figueira	36.64	escama de sereiano
e1e3cd58-f438-11e5-8038-099f03ff0738	figueira	36.64	escama de sereiano
e1e3ceac-f438-11e5-8038-099f03ff0738	figueira	36.02	pena de hipogrifo
e1e3d01e-f438-11e5-8038-099f03ff0738	figueira	35.92	escama de dragão
e1e3d172-f438-11e5-8038-099f03ff0738	figueira	36.00	fibra de coração de dragão
e1e3d2bc-f438-11e5-8038-099f03ff0738	figueira	36.56	pó de presa de dragão
e1e3d41a-f438-11e5-8038-099f03ff0738	figueira	36.62	pêlo de cauda de unicórnio
e1e3d56e-f438-11e5-8038-099f03ff0738	figueira	36.20	pêlo de cauda de testrálio
e1e3d6b8-f438-11e5-8038-099f03ff0738	figueira	36.62	pó de chifre de unicórnio
e1e3d80c-f438-11e5-8038-099f03ff0738	figueira	36.43	cabelo de veela
e1e3d974-f438-11e5-8038-099f03ff0738	cerejeira	36.12	pó de chifre de dragão
e1e3dac8-f438-11e5-8038-099f03ff0738	cerejeira	35.85	raiz de mandrágora
e1e3dc12-f438-11e5-8038-099f03ff0738	cerejeira	36.71	escama de sereiano
e1e3dd84-f438-11e5-8038-099f03ff0738	cerejeira	36.71	escama de sereiano
e1e3ded8-f438-11e5-8038-099f03ff0738	cerejeira	36.64	pena de hipogrifo
e1e3e022-f438-11e5-8038-099f03ff0738	cerejeira	36.34	escama de dragão
e1e3e176-f438-11e5-8038-099f03ff0738	cerejeira	35.82	fibra de coração de dragão
e1e3e2ca-f438-11e5-8038-099f03ff0738	cerejeira	36.72	coral
e1e3e432-f438-11e5-8038-099f03ff0738	cerejeira	36.61	sangue de unicórnio
e1e3e57c-f438-11e5-8038-099f03ff0738	cerejeira	36.70	pó de chifre de unicórnio
e1e3e6d0-f438-11e5-8038-099f03ff0738	carvalho	36.25	pó de chifre de dragão
e1e3e8ba-f438-11e5-8038-099f03ff0738	carvalho	36.25	pó de chifre de dragão
e1e3ea18-f438-11e5-8038-099f03ff0738	carvalho	36.04	escama de sereiano
e1e3eb80-f438-11e5-8038-099f03ff0738	carvalho	36.14	pena de hipogrifo
e1e3ed10-f438-11e5-8038-099f03ff0738	carvalho	36.48	escama de dragão
e1e3ee78-f438-11e5-8038-099f03ff0738	carvalho	36.53	fibra de coração de dragão
e1e3f1d4-f438-11e5-8038-099f03ff0738	carvalho	36.10	coral
e1e3f350-f438-11e5-8038-099f03ff0738	carvalho	36.18	pêlo de cauda de unicórnio
e1e3f4c2-f438-11e5-8038-099f03ff0738	carvalho	35.85	pó de chifre de unicórnio
e1e3f62a-f438-11e5-8038-099f03ff0738	carvalho	36.40	cabelo de veela
e1e3f7a6-f438-11e5-8038-099f03ff0738	cedro	36.48	pó de chifre de dragão
e1e3f90e-f438-11e5-8038-099f03ff0738	cedro	35.90	escama de sereiano
e1e3fa80-f438-11e5-8038-099f03ff0738	cedro	36.12	pena de hipogrifo
e1e3fbe8-f438-11e5-8038-099f03ff0738	cedro	36.44	escama de dragão
e1e3fd50-f438-11e5-8038-099f03ff0738	cedro	36.58	fibra de coração de dragão
e1e3fec2-f438-11e5-8038-099f03ff0738	cedro	36.31	pó de presa de dragão
e1e40034-f438-11e5-8038-099f03ff0738	cedro	36.00	coral
e1e40188-f438-11e5-8038-099f03ff0738	cedro	36.22	pêlo de cauda de unicórnio
e1e402fa-f438-11e5-8038-099f03ff0738	cedro	36.22	pêlo de cauda de unicórnio
e1e4048a-f438-11e5-8038-099f03ff0738	cedro	36.23	pó de chifre de unicórnio
e1e405e8-f438-11e5-8038-099f03ff0738	macieira	36.18	pó de chifre de dragão
e1e40750-f438-11e5-8038-099f03ff0738	macieira	36.57	raiz de mandrágora
e1e408b8-f438-11e5-8038-099f03ff0738	macieira	36.54	pena de hipogrifo
e1e40a2a-f438-11e5-8038-099f03ff0738	macieira	36.54	pena de hipogrifo
e1e40c78-f438-11e5-8038-099f03ff0738	macieira	35.97	escama de dragão
e1e40dea-f438-11e5-8038-099f03ff0738	macieira	36.14	fibra de coração de dragão
e1e41074-f438-11e5-8038-099f03ff0738	macieira	36.72	pêlo de cauda de unicórnio
e1e411fa-f438-11e5-8038-099f03ff0738	macieira	36.48	pó de chifre de unicórnio
e1e41362-f438-11e5-8038-099f03ff0738	macieira	36.48	pó de chifre de unicórnio
e1e414de-f438-11e5-8038-099f03ff0738	macieira	36.56	cabelo de veela
e1e41646-f438-11e5-8038-099f03ff0738	ipê	36.43	pó de chifre de dragão
e1e417c2-f438-11e5-8038-099f03ff0738	ipê	35.93	raiz de mandrágora
e1e4192a-f438-11e5-8038-099f03ff0738	ipê	36.62	escama de sereiano
e1e41a9c-f438-11e5-8038-099f03ff0738	ipê	35.92	pena de hipogrifo
e1e41bfa-f438-11e5-8038-099f03ff0738	ipê	35.98	escama de dragão
e1e41da8-f438-11e5-8038-099f03ff0738	ipê	35.98	escama de dragão
e1e41f1a-f438-11e5-8038-099f03ff0738	ipê	36.69	fibra de coração de dragão
e1e4219a-f438-11e5-8038-099f03ff0738	ipê	36.64	pó de presa de dragão
e1e42640-f438-11e5-8038-099f03ff0738	ipê	36.63	coral
e1e42a82-f438-11e5-8038-099f03ff0738	ipê	35.97	pêlo de cauda de unicórnio
e1e4307c-f438-11e5-8038-099f03ff0738	ipê	35.83	pêlo de cauda de testrálio
e1e4366c-f438-11e5-8038-099f03ff0738	ipê	36.28	pó de chifre de unicórnio
e1e43ce8-f438-11e5-8038-099f03ff0738	salgueiro	35.81	pó de chifre de dragão
e1e44378-f438-11e5-8038-099f03ff0738	salgueiro	36.57	raiz de mandrágora
e1e445bc-f438-11e5-8038-099f03ff0738	salgueiro	36.34	escama de sereiano
e1e4472e-f438-11e5-8038-099f03ff0738	salgueiro	36.51	pena de hipogrifo
e1e448a0-f438-11e5-8038-099f03ff0738	salgueiro	36.51	pena de hipogrifo
e1e44a08-f438-11e5-8038-099f03ff0738	salgueiro	35.89	escama de dragão
e1e44b66-f438-11e5-8038-099f03ff0738	salgueiro	36.06	fibra de coração de dragão
e1e44cd8-f438-11e5-8038-099f03ff0738	salgueiro	35.92	pó de presa de dragão
e1e44e40-f438-11e5-8038-099f03ff0738	salgueiro	36.07	coral
e1e44fa8-f438-11e5-8038-099f03ff0738	salgueiro	36.23	pó de chifre de unicórnio
e1e45138-f438-11e5-8038-099f03ff0738	sabugueiro	37.09	pó de chifre de dragão
e1e452be-f438-11e5-8038-099f03ff0738	sabugueiro	37.10	escama de sereiano
e1e45430-f438-11e5-8038-099f03ff0738	sabugueiro	36.87	pena de hipogrifo
e1e45598-f438-11e5-8038-099f03ff0738	sabugueiro	36.65	escama de dragão
e1e45700-f438-11e5-8038-099f03ff0738	sabugueiro	36.86	fibra de coração de dragão
e1e45872-f438-11e5-8038-099f03ff0738	sabugueiro	37.07	pó de presa de dragão
e1e459e4-f438-11e5-8038-099f03ff0738	sabugueiro	37.26	coral
e1e45b42-f438-11e5-8038-099f03ff0738	sabugueiro	36.76	pó de chifre de unicórnio
e1e45caa-f438-11e5-8038-099f03ff0738	sabugueiro	37.38	cabelo de veela
e1e45e26-f438-11e5-8038-099f03ff0738	sabugueiro	37.38	cabelo de veela
e1e45f98-f438-11e5-8038-099f03ff0738	figueira	36.49	pó de chifre de dragão
e1e4610a-f438-11e5-8038-099f03ff0738	figueira	37.15	escama de sereiano
e1e46272-f438-11e5-8038-099f03ff0738	figueira	37.00	pena de hipogrifo
e1e463da-f438-11e5-8038-099f03ff0738	figueira	36.75	escama de dragão
e1e4652e-f438-11e5-8038-099f03ff0738	figueira	36.60	pena de fênix
e1e466e6-f438-11e5-8038-099f03ff0738	figueira	36.97	fibra de coração de dragão
e1e4688a-f438-11e5-8038-099f03ff0738	figueira	36.97	fibra de coração de dragão
e1e469fc-f438-11e5-8038-099f03ff0738	figueira	37.07	coral
e1e46bbe-f438-11e5-8038-099f03ff0738	figueira	36.43	pêlo de cauda de unicórnio
e1e46d44-f438-11e5-8038-099f03ff0738	figueira	37.39	pó de chifre de unicórnio
e1e46eb6-f438-11e5-8038-099f03ff0738	figueira	36.72	cabelo de veela
e1e470aa-f438-11e5-8038-099f03ff0738	cerejeira	36.84	pó de chifre de dragão
e1e47208-f438-11e5-8038-099f03ff0738	cerejeira	36.65	escama de sereiano
e1e4735c-f438-11e5-8038-099f03ff0738	cerejeira	36.71	escama de dragão
e1e474b0-f438-11e5-8038-099f03ff0738	cerejeira	37.14	fibra de coração de dragão
e1e475fa-f438-11e5-8038-099f03ff0738	cerejeira	36.61	pó de presa de dragão
e1e4776c-f438-11e5-8038-099f03ff0738	cerejeira	37.17	pêlo de cauda de unicórnio
e1e478c0-f438-11e5-8038-099f03ff0738	cerejeira	37.07	cabelo de veela
e1e47a0a-f438-11e5-8038-099f03ff0738	carvalho	37.38	pó de chifre de dragão
e1e47b7c-f438-11e5-8038-099f03ff0738	carvalho	37.12	escama de sereiano
e1e47cda-f438-11e5-8038-099f03ff0738	carvalho	36.64	pena de hipogrifo
e1e47e2e-f438-11e5-8038-099f03ff0738	carvalho	37.06	escama de dragão
e1e47f78-f438-11e5-8038-099f03ff0738	carvalho	37.30	fibra de coração de dragão
e1e480cc-f438-11e5-8038-099f03ff0738	carvalho	37.37	coral
e1e48220-f438-11e5-8038-099f03ff0738	carvalho	36.86	pêlo de cauda de unicórnio
e1e48374-f438-11e5-8038-099f03ff0738	carvalho	36.60	pó de chifre de unicórnio
e1e484c8-f438-11e5-8038-099f03ff0738	cedro	37.20	pó de chifre de dragão
e1e48c48-f438-11e5-8038-099f03ff0738	cedro	37.01	escama de sereiano
e1e48db0-f438-11e5-8038-099f03ff0738	cedro	37.01	escama de sereiano
e1e48ef0-f438-11e5-8038-099f03ff0738	cedro	36.89	pena de hipogrifo
e1e49026-f438-11e5-8038-099f03ff0738	cedro	36.67	escama de dragão
e1e49170-f438-11e5-8038-099f03ff0738	cedro	36.80	pena de fênix
e1e4938c-f438-11e5-8038-099f03ff0738	cedro	37.25	fibra de coração de dragão
e1e49544-f438-11e5-8038-099f03ff0738	cedro	37.25	fibra de coração de dragão
e1e4967a-f438-11e5-8038-099f03ff0738	cedro	37.06	pêlo de cauda de unicórnio
e1e497a6-f438-11e5-8038-099f03ff0738	cedro	37.30	pêlo de cauda de testrálio
e1e498e6-f438-11e5-8038-099f03ff0738	cedro	36.48	pó de chifre de unicórnio
e1e49a1c-f438-11e5-8038-099f03ff0738	macieira	37.22	pó de chifre de dragão
e1e49b52-f438-11e5-8038-099f03ff0738	macieira	36.53	raiz de mandrágora
e1e49c7e-f438-11e5-8038-099f03ff0738	macieira	37.16	pena de hipogrifo
e1e49db4-f438-11e5-8038-099f03ff0738	macieira	37.37	escama de dragão
e1e49ef4-f438-11e5-8038-099f03ff0738	macieira	37.27	fibra de coração de dragão
e1e4a020-f438-11e5-8038-099f03ff0738	macieira	37.15	pêlo de cauda de unicórnio
e1e4a156-f438-11e5-8038-099f03ff0738	macieira	36.56	pêlo de cauda de testrálio
e1e4a296-f438-11e5-8038-099f03ff0738	macieira	37.03	pó de chifre de unicórnio
e1e4a3cc-f438-11e5-8038-099f03ff0738	ipê	37.23	pó de chifre de dragão
e1e4a502-f438-11e5-8038-099f03ff0738	ipê	36.51	escama de sereiano
e1e4a638-f438-11e5-8038-099f03ff0738	ipê	37.08	pena de hipogrifo
e1e4a764-f438-11e5-8038-099f03ff0738	ipê	37.31	escama de dragão
e1e4a89a-f438-11e5-8038-099f03ff0738	ipê	36.81	fibra de coração de dragão
e1e4a9c6-f438-11e5-8038-099f03ff0738	ipê	36.48	pó de presa de dragão
e1e4abce-f438-11e5-8038-099f03ff0738	ipê	36.81	coral
e1e4ad40-f438-11e5-8038-099f03ff0738	ipê	36.81	coral
e1e4ae8a-f438-11e5-8038-099f03ff0738	ipê	36.99	pêlo de cauda de testrálio
e1e4afd4-f438-11e5-8038-099f03ff0738	ipê	36.68	pó de chifre de unicórnio
e1e4b128-f438-11e5-8038-099f03ff0738	ipê	36.51	cabelo de veela
e1e4b2e0-f438-11e5-8038-099f03ff0738	ipê	36.51	cabelo de veela
e1e4b416-f438-11e5-8038-099f03ff0738	salgueiro	36.94	pó de chifre de dragão
e1e4b6d2-f438-11e5-8038-099f03ff0738	salgueiro	37.12	raiz de mandrágora
e1e4b812-f438-11e5-8038-099f03ff0738	salgueiro	37.36	escama de sereiano
e1e4b93e-f438-11e5-8038-099f03ff0738	salgueiro	36.50	pena de hipogrifo
e1e4ba74-f438-11e5-8038-099f03ff0738	salgueiro	36.50	pena de hipogrifo
e1e4bbb4-f438-11e5-8038-099f03ff0738	salgueiro	36.88	escama de dragão
e1e4bcea-f438-11e5-8038-099f03ff0738	salgueiro	37.16	fibra de coração de dragão
e1e4be20-f438-11e5-8038-099f03ff0738	salgueiro	36.91	pêlo de cauda de unicórnio
e1e4bfd8-f438-11e5-8038-099f03ff0738	salgueiro	37.08	pêlo de cauda de testrálio
e1e4c12c-f438-11e5-8038-099f03ff0738	salgueiro	36.99	pó de chifre de unicórnio
e6e937e8-f438-11e5-8038-099f03ff0738	macieira	24.31	pêlo de cauda de unicórnio
e6e93b80-f438-11e5-8038-099f03ff0738	macieira	24.27	pó de chifre de unicórnio
e6e93d2e-f438-11e5-8038-099f03ff0738	ipê	24.65	pó de chifre de dragão
e6e93eaa-f438-11e5-8038-099f03ff0738	ipê	24.70	raiz de mandrágora
e6e94026-f438-11e5-8038-099f03ff0738	ipê	24.31	escama de sereiano
e6e9418e-f438-11e5-8038-099f03ff0738	ipê	24.24	pena de hipogrifo
e6e943dc-f438-11e5-8038-099f03ff0738	ipê	24.33	escama de dragão
e6e94558-f438-11e5-8038-099f03ff0738	ipê	24.31	fibra de coração de dragão
e6e946e8-f438-11e5-8038-099f03ff0738	ipê	24.39	pó de chifre de unicórnio
e6e94878-f438-11e5-8038-099f03ff0738	salgueiro	24.75	pó de chifre de dragão
e6e949fe-f438-11e5-8038-099f03ff0738	salgueiro	25.02	raiz de mandrágora
e6e94b70-f438-11e5-8038-099f03ff0738	salgueiro	25.09	pena de hipogrifo
e6e94ce2-f438-11e5-8038-099f03ff0738	salgueiro	24.29	escama de dragão
e6e94e54-f438-11e5-8038-099f03ff0738	salgueiro	24.29	fibra de coração de dragão
e6e94fc6-f438-11e5-8038-099f03ff0738	salgueiro	24.75	pó de presa de dragão
e6e95142-f438-11e5-8038-099f03ff0738	salgueiro	25.12	pêlo de cauda de unicórnio
e6e952c8-f438-11e5-8038-099f03ff0738	salgueiro	24.92	pó de chifre de unicórnio
e6e9543a-f438-11e5-8038-099f03ff0738	sabugueiro	25.16	pó de chifre de dragão
e6e955ac-f438-11e5-8038-099f03ff0738	sabugueiro	25.16	pó de chifre de dragão
e6e9573c-f438-11e5-8038-099f03ff0738	sabugueiro	25.16	raiz de mandrágora
e6e958b8-f438-11e5-8038-099f03ff0738	sabugueiro	25.94	escama de sereiano
e6e95a20-f438-11e5-8038-099f03ff0738	sabugueiro	25.14	pena de hipogrifo
e6e95b9c-f438-11e5-8038-099f03ff0738	sabugueiro	26.02	escama de dragão
e6e95d18-f438-11e5-8038-099f03ff0738	sabugueiro	26.02	escama de dragão
e6e95e8a-f438-11e5-8038-099f03ff0738	sabugueiro	25.64	fibra de coração de dragão
e6e95ff2-f438-11e5-8038-099f03ff0738	sabugueiro	25.66	pó de presa de dragão
e6e96178-f438-11e5-8038-099f03ff0738	sabugueiro	25.70	pêlo de cauda de testrálio
e6e962f4-f438-11e5-8038-099f03ff0738	sabugueiro	25.96	sangue de unicórnio
e6e9645c-f438-11e5-8038-099f03ff0738	sabugueiro	25.57	pó de chifre de unicórnio
e6e965ce-f438-11e5-8038-099f03ff0738	figueira	25.98	pó de chifre de dragão
e6e9674a-f438-11e5-8038-099f03ff0738	figueira	25.06	escama de sereiano
e6e968d0-f438-11e5-8038-099f03ff0738	figueira	25.29	pena de hipogrifo
e6e96a42-f438-11e5-8038-099f03ff0738	figueira	25.50	escama de dragão
e6e96bbe-f438-11e5-8038-099f03ff0738	figueira	25.46	pena de fênix
e6e96d3a-f438-11e5-8038-099f03ff0738	figueira	25.20	fibra de coração de dragão
e6e96eca-f438-11e5-8038-099f03ff0738	figueira	25.95	pêlo de cauda de unicórnio
e6e97064-f438-11e5-8038-099f03ff0738	figueira	26.05	pó de chifre de unicórnio
e6e972d0-f438-11e5-8038-099f03ff0738	figueira	25.98	cabelo de veela
e6e9758c-f438-11e5-8038-099f03ff0738	cerejeira	25.63	pó de chifre de dragão
e6e97794-f438-11e5-8038-099f03ff0738	cerejeira	25.46	pena de hipogrifo
e6e97910-f438-11e5-8038-099f03ff0738	cerejeira	25.58	escama de dragão
e6e97a64-f438-11e5-8038-099f03ff0738	cerejeira	25.88	pena de fênix
e6e97bb8-f438-11e5-8038-099f03ff0738	cerejeira	25.67	fibra de coração de dragão
e6e97d0c-f438-11e5-8038-099f03ff0738	cerejeira	25.36	pó de presa de dragão
e6e97e6a-f438-11e5-8038-099f03ff0738	cerejeira	25.96	coral
e6e97fd2-f438-11e5-8038-099f03ff0738	cerejeira	25.71	pêlo de cauda de unicórnio
e6e98130-f438-11e5-8038-099f03ff0738	cerejeira	25.62	pêlo de cauda de testrálio
e6e982b6-f438-11e5-8038-099f03ff0738	cerejeira	25.62	pêlo de cauda de testrálio
e6e98414-f438-11e5-8038-099f03ff0738	cerejeira	25.81	pó de chifre de unicórnio
e6e98568-f438-11e5-8038-099f03ff0738	cerejeira	25.81	pó de chifre de unicórnio
e6e986c6-f438-11e5-8038-099f03ff0738	carvalho	25.53	pó de chifre de dragão
e6e98824-f438-11e5-8038-099f03ff0738	carvalho	25.07	raiz de mandrágora
e6e98982-f438-11e5-8038-099f03ff0738	carvalho	25.63	pena de hipogrifo
e6e98ad6-f438-11e5-8038-099f03ff0738	carvalho	25.10	escama de dragão
e6e98c3e-f438-11e5-8038-099f03ff0738	carvalho	25.28	fibra de coração de dragão
e6e98db0-f438-11e5-8038-099f03ff0738	carvalho	25.90	pó de presa de dragão
e6e98f7c-f438-11e5-8038-099f03ff0738	carvalho	25.90	coral
e6e9915c-f438-11e5-8038-099f03ff0738	carvalho	25.30	pêlo de cauda de unicórnio
e6e992b0-f438-11e5-8038-099f03ff0738	carvalho	25.44	pêlo de cauda de testrálio
e6e9940e-f438-11e5-8038-099f03ff0738	carvalho	25.33	cabelo de veela
e6e99562-f438-11e5-8038-099f03ff0738	cedro	25.56	pó de chifre de dragão
e6e996c0-f438-11e5-8038-099f03ff0738	cedro	25.43	escama de sereiano
e6e9981e-f438-11e5-8038-099f03ff0738	cedro	25.42	pena de hipogrifo
e6e99986-f438-11e5-8038-099f03ff0738	cedro	25.89	escama de dragão
e6e99ada-f438-11e5-8038-099f03ff0738	cedro	25.89	escama de dragão
e6e99c38-f438-11e5-8038-099f03ff0738	cedro	25.61	fibra de coração de dragão
e6e99d96-f438-11e5-8038-099f03ff0738	cedro	25.44	pó de presa de dragão
e6e99ee0-f438-11e5-8038-099f03ff0738	cedro	25.53	pêlo de cauda de unicórnio
e6e9a052-f438-11e5-8038-099f03ff0738	cedro	26.05	pó de chifre de unicórnio
e6e9a1ba-f438-11e5-8038-099f03ff0738	macieira	25.26	pó de chifre de dragão
e6e9a30e-f438-11e5-8038-099f03ff0738	macieira	25.26	pó de chifre de dragão
e6e9a462-f438-11e5-8038-099f03ff0738	macieira	25.66	pena de hipogrifo
e6e9a5ca-f438-11e5-8038-099f03ff0738	macieira	25.20	escama de dragão
e6e9a732-f438-11e5-8038-099f03ff0738	macieira	25.13	fibra de coração de dragão
e6e9a87c-f438-11e5-8038-099f03ff0738	macieira	25.31	pó de presa de dragão
e6e9a9e4-f438-11e5-8038-099f03ff0738	macieira	25.51	coral
e6e9ab42-f438-11e5-8038-099f03ff0738	macieira	25.23	pêlo de cauda de unicórnio
e6e9aca0-f438-11e5-8038-099f03ff0738	macieira	25.70	sangue de unicórnio
e6e9adea-f438-11e5-8038-099f03ff0738	macieira	25.86	pó de chifre de unicórnio
e6e9af48-f438-11e5-8038-099f03ff0738	macieira	25.41	cabelo de veela
e6e9b0a6-f438-11e5-8038-099f03ff0738	ipê	25.20	pó de chifre de dragão
e6e9b1fa-f438-11e5-8038-099f03ff0738	ipê	25.47	raiz de mandrágora
e6e9b34e-f438-11e5-8038-099f03ff0738	ipê	25.95	escama de sereiano
e6e9b4b6-f438-11e5-8038-099f03ff0738	ipê	25.70	pena de hipogrifo
e6e9b61e-f438-11e5-8038-099f03ff0738	ipê	25.98	escama de dragão
e6e9b77c-f438-11e5-8038-099f03ff0738	ipê	25.93	fibra de coração de dragão
e6e9bc68-f438-11e5-8038-099f03ff0738	ipê	25.78	pó de presa de dragão
e6e9bde4-f438-11e5-8038-099f03ff0738	ipê	25.34	coral
e6e9bf4c-f438-11e5-8038-099f03ff0738	ipê	25.38	pêlo de cauda de unicórnio
e6e9c0a0-f438-11e5-8038-099f03ff0738	ipê	25.40	pêlo de cauda de testrálio
e6e9c208-f438-11e5-8038-099f03ff0738	ipê	25.20	pó de chifre de unicórnio
e6e9c35c-f438-11e5-8038-099f03ff0738	salgueiro	25.84	pó de chifre de dragão
e6e9c4b0-f438-11e5-8038-099f03ff0738	salgueiro	25.43	raiz de mandrágora
e6e9c60e-f438-11e5-8038-099f03ff0738	salgueiro	25.82	escama de dragão
e6e9c776-f438-11e5-8038-099f03ff0738	salgueiro	26.04	pena de fênix
e6e9c8d4-f438-11e5-8038-099f03ff0738	salgueiro	25.97	fibra de coração de dragão
e6e9ca28-f438-11e5-8038-099f03ff0738	salgueiro	25.97	fibra de coração de dragão
e6e9cb86-f438-11e5-8038-099f03ff0738	salgueiro	25.33	pó de presa de dragão
e6e9cce4-f438-11e5-8038-099f03ff0738	salgueiro	25.52	pêlo de cauda de unicórnio
e6e9ce56-f438-11e5-8038-099f03ff0738	salgueiro	25.52	pêlo de cauda de unicórnio
e6e9cfb4-f438-11e5-8038-099f03ff0738	salgueiro	25.84	pêlo de cauda de testrálio
e6e9d112-f438-11e5-8038-099f03ff0738	salgueiro	25.84	pêlo de cauda de testrálio
e6e9d27a-f438-11e5-8038-099f03ff0738	salgueiro	25.37	sangue de unicórnio
e6e9d3e2-f438-11e5-8038-099f03ff0738	salgueiro	25.24	pó de chifre de unicórnio
e6e9d540-f438-11e5-8038-099f03ff0738	salgueiro	25.75	cabelo de veela
e6e9d69e-f438-11e5-8038-099f03ff0738	sabugueiro	26.16	pó de chifre de dragão
e6e9d7fc-f438-11e5-8038-099f03ff0738	sabugueiro	27.02	escama de sereiano
e6e9d95a-f438-11e5-8038-099f03ff0738	sabugueiro	26.94	pena de hipogrifo
e6e9dab8-f438-11e5-8038-099f03ff0738	sabugueiro	26.94	pena de hipogrifo
e6e9dc16-f438-11e5-8038-099f03ff0738	sabugueiro	26.98	escama de dragão
e6e9dd92-f438-11e5-8038-099f03ff0738	sabugueiro	26.94	fibra de coração de dragão
e6e9defa-f438-11e5-8038-099f03ff0738	sabugueiro	26.62	pó de presa de dragão
e6e9e04e-f438-11e5-8038-099f03ff0738	sabugueiro	26.33	coral
e6e9e1a2-f438-11e5-8038-099f03ff0738	sabugueiro	26.12	pó de chifre de unicórnio
e6e9e300-f438-11e5-8038-099f03ff0738	sabugueiro	26.94	cabelo de veela
e6e9e45e-f438-11e5-8038-099f03ff0738	figueira	26.85	pó de chifre de dragão
e6e9e5c6-f438-11e5-8038-099f03ff0738	figueira	26.06	raiz de mandrágora
e6e9e71a-f438-11e5-8038-099f03ff0738	figueira	26.32	escama de sereiano
e6e9e88c-f438-11e5-8038-099f03ff0738	figueira	26.50	escama de dragão
e6e9e9ea-f438-11e5-8038-099f03ff0738	figueira	26.22	pena de fênix
e6e9eb34-f438-11e5-8038-099f03ff0738	figueira	26.17	fibra de coração de dragão
e6e9ec92-f438-11e5-8038-099f03ff0738	figueira	26.62	pó de presa de dragão
e6e9eddc-f438-11e5-8038-099f03ff0738	figueira	26.66	coral
e6e9ef94-f438-11e5-8038-099f03ff0738	figueira	26.77	pêlo de cauda de unicórnio
e6e9f0e8-f438-11e5-8038-099f03ff0738	figueira	26.25	pó de chifre de unicórnio
e6e9f250-f438-11e5-8038-099f03ff0738	figueira	26.34	cabelo de veela
e6e9f3ae-f438-11e5-8038-099f03ff0738	cerejeira	26.20	pó de chifre de dragão
e6e9f502-f438-11e5-8038-099f03ff0738	cerejeira	26.21	escama de sereiano
e6e9f660-f438-11e5-8038-099f03ff0738	cerejeira	27.04	pena de hipogrifo
e6e9f7b4-f438-11e5-8038-099f03ff0738	cerejeira	26.36	escama de dragão
e6e9f91c-f438-11e5-8038-099f03ff0738	cerejeira	26.36	escama de dragão
e6e9fa70-f438-11e5-8038-099f03ff0738	cerejeira	26.56	fibra de coração de dragão
e6e9fbce-f438-11e5-8038-099f03ff0738	cerejeira	26.60	pó de presa de dragão
e6e9fd22-f438-11e5-8038-099f03ff0738	cerejeira	26.89	coral
e6e9fe8a-f438-11e5-8038-099f03ff0738	cerejeira	26.35	pó de chifre de unicórnio
e6e9ffde-f438-11e5-8038-099f03ff0738	carvalho	26.37	pó de chifre de dragão
e6ea013c-f438-11e5-8038-099f03ff0738	carvalho	26.55	escama de sereiano
e6ea029a-f438-11e5-8038-099f03ff0738	carvalho	26.74	pena de hipogrifo
e6ea05ce-f438-11e5-8038-099f03ff0738	carvalho	26.63	escama de dragão
e6ea0736-f438-11e5-8038-099f03ff0738	carvalho	26.61	fibra de coração de dragão
e6ea089e-f438-11e5-8038-099f03ff0738	carvalho	26.79	pó de presa de dragão
e6ea09f2-f438-11e5-8038-099f03ff0738	carvalho	26.79	pó de presa de dragão
e6ea0b46-f438-11e5-8038-099f03ff0738	carvalho	26.54	coral
e6ea0c9a-f438-11e5-8038-099f03ff0738	carvalho	26.07	pêlo de cauda de unicórnio
e6ea0df8-f438-11e5-8038-099f03ff0738	carvalho	26.77	pêlo de cauda de testrálio
e6ea0f42-f438-11e5-8038-099f03ff0738	carvalho	26.45	pó de chifre de unicórnio
e6ea1096-f438-11e5-8038-099f03ff0738	cedro	26.99	pó de chifre de dragão
e6ea12e4-f438-11e5-8038-099f03ff0738	cedro	26.23	raiz de mandrágora
e6ea14ba-f438-11e5-8038-099f03ff0738	cedro	26.39	escama de sereiano
e6ea1604-f438-11e5-8038-099f03ff0738	cedro	26.78	pena de hipogrifo
e6ea1762-f438-11e5-8038-099f03ff0738	cedro	26.64	escama de dragão
e6ea18b6-f438-11e5-8038-099f03ff0738	cedro	26.71	fibra de coração de dragão
e6ea1a0a-f438-11e5-8038-099f03ff0738	cedro	26.07	coral
e6ea1b68-f438-11e5-8038-099f03ff0738	cedro	26.64	pêlo de cauda de unicórnio
e6ea1cd0-f438-11e5-8038-099f03ff0738	cedro	27.04	pó de chifre de unicórnio
e6ea1e2e-f438-11e5-8038-099f03ff0738	macieira	26.47	pó de chifre de dragão
e6ea1f78-f438-11e5-8038-099f03ff0738	macieira	26.54	raiz de mandrágora
e6ea20d6-f438-11e5-8038-099f03ff0738	macieira	27.03	escama de sereiano
e6ea222a-f438-11e5-8038-099f03ff0738	macieira	27.04	pena de hipogrifo
e6ea2374-f438-11e5-8038-099f03ff0738	macieira	26.72	escama de dragão
e6ea24e6-f438-11e5-8038-099f03ff0738	macieira	26.31	fibra de coração de dragão
e6ea263a-f438-11e5-8038-099f03ff0738	macieira	26.80	pó de presa de dragão
e6ea2798-f438-11e5-8038-099f03ff0738	macieira	26.48	coral
e6ea28f6-f438-11e5-8038-099f03ff0738	macieira	26.97	pêlo de cauda de testrálio
e6ea2a54-f438-11e5-8038-099f03ff0738	macieira	26.66	pó de chifre de unicórnio
e6ea2bbc-f438-11e5-8038-099f03ff0738	macieira	27.03	cabelo de veela
e6ea2d88-f438-11e5-8038-099f03ff0738	ipê	26.87	pó de chifre de dragão
e6ea2f18-f438-11e5-8038-099f03ff0738	ipê	26.99	raiz de mandrágora
e6ea3094-f438-11e5-8038-099f03ff0738	ipê	26.83	escama de sereiano
e6ea3210-f438-11e5-8038-099f03ff0738	ipê	26.47	pena de hipogrifo
e6ea33a0-f438-11e5-8038-099f03ff0738	ipê	27.02	escama de dragão
e6ea3512-f438-11e5-8038-099f03ff0738	ipê	26.55	fibra de coração de dragão
e6ea3684-f438-11e5-8038-099f03ff0738	ipê	26.36	pêlo de cauda de unicórnio
e6ea37f6-f438-11e5-8038-099f03ff0738	ipê	26.89	pó de chifre de unicórnio
e6ea3968-f438-11e5-8038-099f03ff0738	salgueiro	26.10	pó de chifre de dragão
e6ea3ada-f438-11e5-8038-099f03ff0738	salgueiro	27.04	raiz de mandrágora
e6ea3c56-f438-11e5-8038-099f03ff0738	salgueiro	26.34	escama de sereiano
e6ea3dbe-f438-11e5-8038-099f03ff0738	salgueiro	26.86	pena de hipogrifo
e6ea3f3a-f438-11e5-8038-099f03ff0738	salgueiro	26.69	escama de dragão
e6ea40ac-f438-11e5-8038-099f03ff0738	salgueiro	26.69	fibra de coração de dragão
e6ea421e-f438-11e5-8038-099f03ff0738	salgueiro	26.12	pó de presa de dragão
e6ea45de-f438-11e5-8038-099f03ff0738	salgueiro	26.85	coral
e6ea47dc-f438-11e5-8038-099f03ff0738	salgueiro	26.93	pêlo de cauda de unicórnio
e6ea4958-f438-11e5-8038-099f03ff0738	salgueiro	26.09	pêlo de cauda de testrálio
e6ea4aca-f438-11e5-8038-099f03ff0738	salgueiro	26.09	pêlo de cauda de testrálio
e6ea4c3c-f438-11e5-8038-099f03ff0738	salgueiro	26.40	pó de chifre de unicórnio
e6ea4dcc-f438-11e5-8038-099f03ff0738	sabugueiro	27.56	pó de chifre de dragão
e6ea4f48-f438-11e5-8038-099f03ff0738	sabugueiro	27.45	escama de sereiano
e6ea50ba-f438-11e5-8038-099f03ff0738	sabugueiro	27.84	pena de hipogrifo
e6ea5236-f438-11e5-8038-099f03ff0738	sabugueiro	27.87	escama de dragão
e6ea53bc-f438-11e5-8038-099f03ff0738	sabugueiro	27.85	fibra de coração de dragão
e6ea5600-f438-11e5-8038-099f03ff0738	sabugueiro	27.61	pó de presa de dragão
e6ea575e-f438-11e5-8038-099f03ff0738	sabugueiro	27.49	pêlo de cauda de testrálio
e6ea58bc-f438-11e5-8038-099f03ff0738	figueira	26.98	pó de chifre de dragão
e6ea5a1a-f438-11e5-8038-099f03ff0738	figueira	27.58	escama de sereiano
e6ea5b78-f438-11e5-8038-099f03ff0738	figueira	27.58	escama de sereiano
e6ea5ce0-f438-11e5-8038-099f03ff0738	figueira	27.61	pena de hipogrifo
e6ea5e34-f438-11e5-8038-099f03ff0738	figueira	27.72	escama de dragão
e6ea5f88-f438-11e5-8038-099f03ff0738	figueira	27.17	fibra de coração de dragão
e6ea6154-f438-11e5-8038-099f03ff0738	figueira	27.33	pó de presa de dragão
e6ea633e-f438-11e5-8038-099f03ff0738	figueira	27.67	pêlo de cauda de unicórnio
e6ea649c-f438-11e5-8038-099f03ff0738	figueira	27.89	pó de chifre de unicórnio
e6ea65f0-f438-11e5-8038-099f03ff0738	cerejeira	27.00	pó de chifre de dragão
e6ea6758-f438-11e5-8038-099f03ff0738	cerejeira	27.05	escama de sereiano
e6ea68c0-f438-11e5-8038-099f03ff0738	cerejeira	27.64	pena de hipogrifo
e6ea6a14-f438-11e5-8038-099f03ff0738	cerejeira	27.63	escama de dragão
e6ea6b72-f438-11e5-8038-099f03ff0738	cerejeira	27.93	fibra de coração de dragão
e6ea6cda-f438-11e5-8038-099f03ff0738	cerejeira	27.78	pó de presa de dragão
e6ea6e38-f438-11e5-8038-099f03ff0738	cerejeira	27.34	coral
e6ea6f8c-f438-11e5-8038-099f03ff0738	cerejeira	26.98	pêlo de cauda de unicórnio
e6ea70f4-f438-11e5-8038-099f03ff0738	cerejeira	27.49	pó de chifre de unicórnio
e6ea7252-f438-11e5-8038-099f03ff0738	cerejeira	27.06	cabelo de veela
e6ea73a6-f438-11e5-8038-099f03ff0738	carvalho	27.06	pó de chifre de dragão
e6ea7504-f438-11e5-8038-099f03ff0738	carvalho	27.12	escama de sereiano
e6ea766c-f438-11e5-8038-099f03ff0738	carvalho	27.22	pena de hipogrifo
e6ea77ca-f438-11e5-8038-099f03ff0738	carvalho	27.85	escama de dragão
e6ea7914-f438-11e5-8038-099f03ff0738	carvalho	27.84	fibra de coração de dragão
e6ea7a7c-f438-11e5-8038-099f03ff0738	carvalho	27.79	pó de presa de dragão
e6ea7be4-f438-11e5-8038-099f03ff0738	carvalho	27.85	coral
e6ea7d38-f438-11e5-8038-099f03ff0738	carvalho	27.85	coral
e6ea7e96-f438-11e5-8038-099f03ff0738	carvalho	27.83	pêlo de cauda de unicórnio
e6ea7ffe-f438-11e5-8038-099f03ff0738	carvalho	27.60	pó de chifre de unicórnio
e6ea8170-f438-11e5-8038-099f03ff0738	cedro	27.63	pó de chifre de dragão
e6ea82c4-f438-11e5-8038-099f03ff0738	cedro	27.03	escama de sereiano
e6ea8422-f438-11e5-8038-099f03ff0738	cedro	27.16	pena de hipogrifo
e6ea858a-f438-11e5-8038-099f03ff0738	cedro	27.16	escama de dragão
e6ea86d4-f438-11e5-8038-099f03ff0738	cedro	26.97	fibra de coração de dragão
e6ea8832-f438-11e5-8038-099f03ff0738	cedro	27.03	coral
e6ea899a-f438-11e5-8038-099f03ff0738	cedro	27.70	pó de chifre de unicórnio
e6ea8aee-f438-11e5-8038-099f03ff0738	macieira	27.45	pó de chifre de dragão
e6ea8c42-f438-11e5-8038-099f03ff0738	macieira	27.17	raiz de mandrágora
e6ea8da0-f438-11e5-8038-099f03ff0738	macieira	27.89	escama de sereiano
e6ea8ef4-f438-11e5-8038-099f03ff0738	macieira	27.56	pena de hipogrifo
e6ea9052-f438-11e5-8038-099f03ff0738	macieira	27.43	escama de dragão
e6ea91a6-f438-11e5-8038-099f03ff0738	macieira	27.76	fibra de coração de dragão
e6ea9304-f438-11e5-8038-099f03ff0738	macieira	27.24	pó de presa de dragão
e6ea946c-f438-11e5-8038-099f03ff0738	macieira	27.82	pêlo de cauda de unicórnio
e6ea95b6-f438-11e5-8038-099f03ff0738	macieira	27.41	pêlo de cauda de testrálio
e6ea9804-f438-11e5-8038-099f03ff0738	macieira	27.72	pó de chifre de unicórnio
e6ea9962-f438-11e5-8038-099f03ff0738	macieira	27.59	cabelo de veela
e6ea9ac0-f438-11e5-8038-099f03ff0738	ipê	27.05	pó de chifre de dragão
e6ea9c14-f438-11e5-8038-099f03ff0738	ipê	27.88	raiz de mandrágora
e6ea9d7c-f438-11e5-8038-099f03ff0738	ipê	27.83	escama de sereiano
e6ea9eda-f438-11e5-8038-099f03ff0738	ipê	27.12	pena de hipogrifo
e6eaa038-f438-11e5-8038-099f03ff0738	ipê	27.02	escama de dragão
e6eaa196-f438-11e5-8038-099f03ff0738	ipê	27.02	fibra de coração de dragão
e6eaa2f4-f438-11e5-8038-099f03ff0738	ipê	27.53	pó de presa de dragão
e6eaa452-f438-11e5-8038-099f03ff0738	ipê	27.64	coral
e6eaa59c-f438-11e5-8038-099f03ff0738	ipê	27.91	pêlo de cauda de unicórnio
e6eaa704-f438-11e5-8038-099f03ff0738	ipê	27.56	pêlo de cauda de testrálio
e6eaa862-f438-11e5-8038-099f03ff0738	ipê	27.65	pó de chifre de unicórnio
e6eaa9b6-f438-11e5-8038-099f03ff0738	ipê	27.56	cabelo de veela
e6eaab1e-f438-11e5-8038-099f03ff0738	salgueiro	26.99	pó de chifre de dragão
e6eaac7c-f438-11e5-8038-099f03ff0738	salgueiro	27.15	raiz de mandrágora
e6eaaeac-f438-11e5-8038-099f03ff0738	salgueiro	27.02	escama de sereiano
e6eab078-f438-11e5-8038-099f03ff0738	salgueiro	27.89	escama de dragão
e6eab1d6-f438-11e5-8038-099f03ff0738	salgueiro	27.29	fibra de coração de dragão
e6eab32a-f438-11e5-8038-099f03ff0738	salgueiro	27.56	pêlo de cauda de testrálio
e6eab4a6-f438-11e5-8038-099f03ff0738	salgueiro	27.56	pêlo de cauda de testrálio
e6eab5fa-f438-11e5-8038-099f03ff0738	salgueiro	27.56	sangue de unicórnio
e6eab762-f438-11e5-8038-099f03ff0738	salgueiro	27.46	pó de chifre de unicórnio
e6eab8b6-f438-11e5-8038-099f03ff0738	salgueiro	27.30	cabelo de veela
e6eaba00-f438-11e5-8038-099f03ff0738	sabugueiro	28.79	pó de chifre de dragão
e6eabb5e-f438-11e5-8038-099f03ff0738	sabugueiro	28.63	escama de sereiano
e6eabcbc-f438-11e5-8038-099f03ff0738	sabugueiro	28.63	escama de sereiano
e6eabe10-f438-11e5-8038-099f03ff0738	sabugueiro	28.30	pena de hipogrifo
e6eabf6e-f438-11e5-8038-099f03ff0738	sabugueiro	28.51	escama de dragão
e6eac0cc-f438-11e5-8038-099f03ff0738	sabugueiro	27.92	fibra de coração de dragão
e6eac22a-f438-11e5-8038-099f03ff0738	sabugueiro	27.92	fibra de coração de dragão
e6eac37e-f438-11e5-8038-099f03ff0738	sabugueiro	28.68	pó de presa de dragão
e6eac4dc-f438-11e5-8038-099f03ff0738	sabugueiro	28.77	pêlo de cauda de unicórnio
e6eac630-f438-11e5-8038-099f03ff0738	sabugueiro	27.97	pó de chifre de unicórnio
e6eac7ac-f438-11e5-8038-099f03ff0738	sabugueiro	28.79	cabelo de veela
e6eac914-f438-11e5-8038-099f03ff0738	figueira	28.49	pó de chifre de dragão
e6eaca72-f438-11e5-8038-099f03ff0738	figueira	28.64	raiz de mandrágora
e6eacbc6-f438-11e5-8038-099f03ff0738	figueira	28.69	escama de sereiano
e6eace3c-f438-11e5-8038-099f03ff0738	figueira	28.70	pena de hipogrifo
e6eacf9a-f438-11e5-8038-099f03ff0738	figueira	28.38	escama de dragão
e6ead0f8-f438-11e5-8038-099f03ff0738	figueira	28.29	fibra de coração de dragão
e6ead24c-f438-11e5-8038-099f03ff0738	figueira	28.33	pó de presa de dragão
e6ead3aa-f438-11e5-8038-099f03ff0738	figueira	28.24	pó de chifre de unicórnio
e6ead580-f438-11e5-8038-099f03ff0738	figueira	28.72	cabelo de veela
e6ead706-f438-11e5-8038-099f03ff0738	cerejeira	28.58	pó de chifre de dragão
e6ead86e-f438-11e5-8038-099f03ff0738	cerejeira	28.58	pó de chifre de dragão
e6ead9e0-f438-11e5-8038-099f03ff0738	cerejeira	28.77	raiz de mandrágora
e6eadb52-f438-11e5-8038-099f03ff0738	cerejeira	28.23	pena de hipogrifo
e6eadcc4-f438-11e5-8038-099f03ff0738	cerejeira	28.78	escama de dragão
e6eade2c-f438-11e5-8038-099f03ff0738	cerejeira	28.20	pena de fênix
e6eadf9e-f438-11e5-8038-099f03ff0738	cerejeira	28.30	fibra de coração de dragão
e6eae110-f438-11e5-8038-099f03ff0738	cerejeira	28.07	pó de presa de dragão
e6eae282-f438-11e5-8038-099f03ff0738	cerejeira	27.96	pêlo de cauda de unicórnio
e6eae3fe-f438-11e5-8038-099f03ff0738	cerejeira	28.51	sangue de unicórnio
e6eae642-f438-11e5-8038-099f03ff0738	cerejeira	27.97	pó de chifre de unicórnio
e6eae84a-f438-11e5-8038-099f03ff0738	cerejeira	28.67	cabelo de veela
e6eaea66-f438-11e5-8038-099f03ff0738	carvalho	28.60	pó de chifre de dragão
e6eaec78-f438-11e5-8038-099f03ff0738	carvalho	28.38	raiz de mandrágora
e6eaee9e-f438-11e5-8038-099f03ff0738	carvalho	28.56	pena de hipogrifo
e6eaf092-f438-11e5-8038-099f03ff0738	carvalho	27.95	escama de dragão
e6eaf2cc-f438-11e5-8038-099f03ff0738	carvalho	27.97	fibra de coração de dragão
e6eaf524-f438-11e5-8038-099f03ff0738	carvalho	28.06	pó de presa de dragão
e6eaf740-f438-11e5-8038-099f03ff0738	carvalho	28.20	pêlo de cauda de unicórnio
e6eaf948-f438-11e5-8038-099f03ff0738	carvalho	28.81	pêlo de cauda de testrálio
e6eafba0-f438-11e5-8038-099f03ff0738	carvalho	28.65	sangue de unicórnio
e6eafe34-f438-11e5-8038-099f03ff0738	carvalho	27.98	pó de chifre de unicórnio
e6eaffec-f438-11e5-8038-099f03ff0738	carvalho	27.88	cabelo de veela
e6eb017c-f438-11e5-8038-099f03ff0738	cedro	28.23	pó de chifre de dragão
e6eb030c-f438-11e5-8038-099f03ff0738	cedro	28.04	raiz de mandrágora
e6eb050a-f438-11e5-8038-099f03ff0738	cedro	28.18	escama de sereiano
e6eb07d0-f438-11e5-8038-099f03ff0738	cedro	28.51	pena de hipogrifo
e6eb09ce-f438-11e5-8038-099f03ff0738	cedro	28.14	escama de dragão
e6eb0bc2-f438-11e5-8038-099f03ff0738	cedro	28.38	fibra de coração de dragão
e6eb0d98-f438-11e5-8038-099f03ff0738	cedro	28.40	pó de presa de dragão
e6eb0fc8-f438-11e5-8038-099f03ff0738	cedro	28.49	pêlo de cauda de unicórnio
e6eb136a-f438-11e5-8038-099f03ff0738	cedro	27.93	sangue de unicórnio
e6eb1e3c-f438-11e5-8038-099f03ff0738	cedro	28.11	pó de chifre de unicórnio
e6eb2878-f438-11e5-8038-099f03ff0738	macieira	28.16	pó de chifre de dragão
e6eb334a-f438-11e5-8038-099f03ff0738	macieira	28.45	raiz de mandrágora
e6eb38c2-f438-11e5-8038-099f03ff0738	macieira	28.10	pena de hipogrifo
e6eb3af2-f438-11e5-8038-099f03ff0738	macieira	28.69	escama de dragão
e6eb3caa-f438-11e5-8038-099f03ff0738	macieira	28.69	escama de dragão
e6eb3e1c-f438-11e5-8038-099f03ff0738	macieira	27.91	fibra de coração de dragão
e6eb3f8e-f438-11e5-8038-099f03ff0738	macieira	27.91	fibra de coração de dragão
e6eb40e2-f438-11e5-8038-099f03ff0738	macieira	28.62	pó de presa de dragão
e6eb424a-f438-11e5-8038-099f03ff0738	macieira	28.01	pó de chifre de unicórnio
e6eb43c6-f438-11e5-8038-099f03ff0738	ipê	28.76	pó de chifre de dragão
e6eb451a-f438-11e5-8038-099f03ff0738	ipê	28.61	raiz de mandrágora
e6eb466e-f438-11e5-8038-099f03ff0738	ipê	27.92	escama de sereiano
e6eb47cc-f438-11e5-8038-099f03ff0738	ipê	28.33	pena de hipogrifo
e6eb493e-f438-11e5-8038-099f03ff0738	ipê	28.18	escama de dragão
e6eb4b8c-f438-11e5-8038-099f03ff0738	ipê	28.24	fibra de coração de dragão
e6eb4d1c-f438-11e5-8038-099f03ff0738	ipê	28.56	pó de chifre de unicórnio
e6eb4f06-f438-11e5-8038-099f03ff0738	ipê	28.11	cabelo de veela
e6eb5064-f438-11e5-8038-099f03ff0738	salgueiro	27.96	pó de chifre de dragão
e6eb51ae-f438-11e5-8038-099f03ff0738	salgueiro	28.71	raiz de mandrágora
e6eb5334-f438-11e5-8038-099f03ff0738	salgueiro	27.88	escama de sereiano
e6eb5492-f438-11e5-8038-099f03ff0738	salgueiro	28.48	pena de hipogrifo
e6eb55e6-f438-11e5-8038-099f03ff0738	salgueiro	27.86	escama de dragão
e6eb573a-f438-11e5-8038-099f03ff0738	salgueiro	27.86	pena de fênix
e6eb588e-f438-11e5-8038-099f03ff0738	salgueiro	28.73	fibra de coração de dragão
e6eb59f6-f438-11e5-8038-099f03ff0738	salgueiro	28.25	pó de presa de dragão
e6eb5b4a-f438-11e5-8038-099f03ff0738	salgueiro	28.49	coral
e6eb5ca8-f438-11e5-8038-099f03ff0738	salgueiro	28.25	pêlo de cauda de unicórnio
e6eb5e06-f438-11e5-8038-099f03ff0738	salgueiro	28.24	pó de chifre de unicórnio
e6eb5f5a-f438-11e5-8038-099f03ff0738	salgueiro	28.20	cabelo de veela
e6eb60c2-f438-11e5-8038-099f03ff0738	sabugueiro	29.83	pó de chifre de dragão
e6eb6216-f438-11e5-8038-099f03ff0738	sabugueiro	29.35	escama de sereiano
e6eb6388-f438-11e5-8038-099f03ff0738	sabugueiro	29.77	pena de hipogrifo
e6eb64dc-f438-11e5-8038-099f03ff0738	sabugueiro	29.58	escama de dragão
e6eb6644-f438-11e5-8038-099f03ff0738	sabugueiro	29.32	fibra de coração de dragão
e6eb67a2-f438-11e5-8038-099f03ff0738	sabugueiro	29.26	pó de presa de dragão
e6eb68f6-f438-11e5-8038-099f03ff0738	sabugueiro	29.44	coral
e6eb6a4a-f438-11e5-8038-099f03ff0738	sabugueiro	29.16	pêlo de cauda de unicórnio
e6eb6ba8-f438-11e5-8038-099f03ff0738	sabugueiro	29.16	pêlo de cauda de unicórnio
e6eb6d06-f438-11e5-8038-099f03ff0738	sabugueiro	29.74	pêlo de cauda de testrálio
e6eb6e5a-f438-11e5-8038-099f03ff0738	sabugueiro	29.82	pó de chifre de unicórnio
e6eb6fcc-f438-11e5-8038-099f03ff0738	sabugueiro	29.31	cabelo de veela
e6eb7134-f438-11e5-8038-099f03ff0738	figueira	29.23	pó de chifre de dragão
e6eb727e-f438-11e5-8038-099f03ff0738	figueira	29.16	raiz de mandrágora
e6eb73dc-f438-11e5-8038-099f03ff0738	figueira	29.59	pena de hipogrifo
e6eb753a-f438-11e5-8038-099f03ff0738	figueira	28.87	escama de dragão
e6eb7698-f438-11e5-8038-099f03ff0738	figueira	29.29	fibra de coração de dragão
e6eb77f6-f438-11e5-8038-099f03ff0738	figueira	29.09	pó de presa de dragão
e6eb7954-f438-11e5-8038-099f03ff0738	figueira	28.98	coral
e6eb7ab2-f438-11e5-8038-099f03ff0738	figueira	29.48	cabelo de veela
e6eb7c1a-f438-11e5-8038-099f03ff0738	cerejeira	28.96	pó de chifre de dragão
e6eb7d82-f438-11e5-8038-099f03ff0738	cerejeira	29.32	escama de sereiano
e6eb7ee0-f438-11e5-8038-099f03ff0738	cerejeira	29.58	pena de hipogrifo
e6eb803e-f438-11e5-8038-099f03ff0738	cerejeira	29.34	escama de dragão
e6eb8192-f438-11e5-8038-099f03ff0738	cerejeira	29.09	pena de fênix
e6eb82e6-f438-11e5-8038-099f03ff0738	cerejeira	29.09	pena de fênix
e6eb8444-f438-11e5-8038-099f03ff0738	cerejeira	29.70	fibra de coração de dragão
e6eb8746-f438-11e5-8038-099f03ff0738	cerejeira	29.15	pó de presa de dragão
e6eb88a4-f438-11e5-8038-099f03ff0738	cerejeira	29.23	coral
e6eb89f8-f438-11e5-8038-099f03ff0738	cerejeira	29.30	pêlo de cauda de unicórnio
e6eb8b60-f438-11e5-8038-099f03ff0738	cerejeira	29.03	pêlo de cauda de testrálio
e6eb8cb4-f438-11e5-8038-099f03ff0738	cerejeira	29.02	sangue de unicórnio
e6eb8e1c-f438-11e5-8038-099f03ff0738	cerejeira	29.05	pó de chifre de unicórnio
e6eb8f7a-f438-11e5-8038-099f03ff0738	carvalho	29.21	pó de chifre de dragão
e6eb90f6-f438-11e5-8038-099f03ff0738	carvalho	29.21	pó de chifre de dragão
e6eb924a-f438-11e5-8038-099f03ff0738	carvalho	29.01	raiz de mandrágora
e6eb93b2-f438-11e5-8038-099f03ff0738	carvalho	29.16	escama de sereiano
e6eb9510-f438-11e5-8038-099f03ff0738	carvalho	29.61	pena de hipogrifo
e6eb965a-f438-11e5-8038-099f03ff0738	carvalho	29.68	escama de dragão
e6eb97ae-f438-11e5-8038-099f03ff0738	carvalho	29.40	fibra de coração de dragão
e6eb990c-f438-11e5-8038-099f03ff0738	carvalho	29.06	pó de presa de dragão
e6eb9a6a-f438-11e5-8038-099f03ff0738	carvalho	29.01	coral
e6eb9bbe-f438-11e5-8038-099f03ff0738	carvalho	29.57	pêlo de cauda de unicórnio
e6eb9d1c-f438-11e5-8038-099f03ff0738	carvalho	29.66	pó de chifre de unicórnio
e6eb9e7a-f438-11e5-8038-099f03ff0738	carvalho	29.66	pó de chifre de unicórnio
e6eb9fce-f438-11e5-8038-099f03ff0738	carvalho	29.18	cabelo de veela
e6eba12c-f438-11e5-8038-099f03ff0738	cedro	29.61	pó de chifre de dragão
e6eba29e-f438-11e5-8038-099f03ff0738	cedro	29.45	pena de hipogrifo
e6eba406-f438-11e5-8038-099f03ff0738	cedro	29.03	escama de dragão
e6eba55a-f438-11e5-8038-099f03ff0738	cedro	29.65	fibra de coração de dragão
e6eba6c2-f438-11e5-8038-099f03ff0738	cedro	29.58	coral
e6eba820-f438-11e5-8038-099f03ff0738	cedro	29.02	pêlo de cauda de unicórnio
e6eba97e-f438-11e5-8038-099f03ff0738	cedro	29.56	pó de chifre de unicórnio
e6ebaae6-f438-11e5-8038-099f03ff0738	cedro	29.81	cabelo de veela
e6ebac4e-f438-11e5-8038-099f03ff0738	macieira	29.20	pó de chifre de dragão
e6ebaf6e-f438-11e5-8038-099f03ff0738	macieira	29.72	raiz de mandrágora
e6ebb0cc-f438-11e5-8038-099f03ff0738	macieira	29.08	escama de sereiano
e6ebb23e-f438-11e5-8038-099f03ff0738	macieira	29.35	escama de dragão
e6ebb39c-f438-11e5-8038-099f03ff0738	macieira	28.96	fibra de coração de dragão
e6ebb4f0-f438-11e5-8038-099f03ff0738	macieira	29.23	pó de presa de dragão
e6ebb658-f438-11e5-8038-099f03ff0738	macieira	29.49	pêlo de cauda de unicórnio
e6ebb7b6-f438-11e5-8038-099f03ff0738	macieira	29.21	sangue de unicórnio
e6ebb914-f438-11e5-8038-099f03ff0738	macieira	29.66	pó de chifre de unicórnio
e6ebba72-f438-11e5-8038-099f03ff0738	macieira	29.77	cabelo de veela
e6ebbbe4-f438-11e5-8038-099f03ff0738	ipê	29.54	pó de chifre de dragão
e6ebbd42-f438-11e5-8038-099f03ff0738	ipê	29.66	raiz de mandrágora
e6ebbea0-f438-11e5-8038-099f03ff0738	ipê	29.66	raiz de mandrágora
e6ebc012-f438-11e5-8038-099f03ff0738	ipê	29.32	pena de hipogrifo
e6ebc170-f438-11e5-8038-099f03ff0738	ipê	29.27	escama de dragão
e6ebc2e2-f438-11e5-8038-099f03ff0738	ipê	29.74	fibra de coração de dragão
e6ebc436-f438-11e5-8038-099f03ff0738	ipê	29.75	pó de presa de dragão
e6ebc594-f438-11e5-8038-099f03ff0738	ipê	29.82	coral
e6ebc6f2-f438-11e5-8038-099f03ff0738	ipê	28.96	pêlo de cauda de unicórnio
e6ebc846-f438-11e5-8038-099f03ff0738	ipê	29.05	pó de chifre de unicórnio
e6ebc9a4-f438-11e5-8038-099f03ff0738	salgueiro	29.49	pó de chifre de dragão
e6ebcb02-f438-11e5-8038-099f03ff0738	salgueiro	28.97	escama de sereiano
e6ebcc56-f438-11e5-8038-099f03ff0738	salgueiro	29.65	pena de hipogrifo
e6ebcdfa-f438-11e5-8038-099f03ff0738	salgueiro	28.88	escama de dragão
e6ebcf58-f438-11e5-8038-099f03ff0738	salgueiro	29.41	fibra de coração de dragão
e6ebd0b6-f438-11e5-8038-099f03ff0738	salgueiro	29.16	pó de presa de dragão
e6ebd20a-f438-11e5-8038-099f03ff0738	salgueiro	28.86	coral
e6ebd372-f438-11e5-8038-099f03ff0738	salgueiro	29.56	pêlo de cauda de unicórnio
e6ebd4d0-f438-11e5-8038-099f03ff0738	salgueiro	29.73	pêlo de cauda de testrálio
e6ebd624-f438-11e5-8038-099f03ff0738	salgueiro	29.44	pó de chifre de unicórnio
e6ebd782-f438-11e5-8038-099f03ff0738	sabugueiro	29.48	pó de chifre de dragão
e6ebd8e0-f438-11e5-8038-099f03ff0738	sabugueiro	30.08	raiz de mandrágora
e6ebda34-f438-11e5-8038-099f03ff0738	sabugueiro	30.40	escama de sereiano
e6ebdb9c-f438-11e5-8038-099f03ff0738	sabugueiro	29.45	pena de hipogrifo
e6ebdd0e-f438-11e5-8038-099f03ff0738	sabugueiro	30.14	escama de dragão
e6ebde76-f438-11e5-8038-099f03ff0738	sabugueiro	30.14	escama de dragão
e6ebdfde-f438-11e5-8038-099f03ff0738	sabugueiro	29.47	pena de fênix
e6ebe132-f438-11e5-8038-099f03ff0738	sabugueiro	29.70	fibra de coração de dragão
e6ebe290-f438-11e5-8038-099f03ff0738	sabugueiro	29.85	coral
e6ebe3e4-f438-11e5-8038-099f03ff0738	sabugueiro	29.83	pó de chifre de unicórnio
e6ebe542-f438-11e5-8038-099f03ff0738	sabugueiro	29.96	cabelo de veela
e6ebe772-f438-11e5-8038-099f03ff0738	sabugueiro	29.96	cabelo de veela
e6ebe8ee-f438-11e5-8038-099f03ff0738	figueira	30.25	pó de chifre de dragão
e6ebea6a-f438-11e5-8038-099f03ff0738	figueira	30.35	raiz de mandrágora
e6ebebdc-f438-11e5-8038-099f03ff0738	figueira	30.19	escama de sereiano
e6ebed9e-f438-11e5-8038-099f03ff0738	figueira	30.19	escama de sereiano
e6ebeef2-f438-11e5-8038-099f03ff0738	figueira	29.47	pena de hipogrifo
e6ebf064-f438-11e5-8038-099f03ff0738	figueira	30.16	escama de dragão
e6ebf1ae-f438-11e5-8038-099f03ff0738	figueira	30.22	fibra de coração de dragão
e6ebf30c-f438-11e5-8038-099f03ff0738	figueira	29.48	pó de presa de dragão
e6ebf47e-f438-11e5-8038-099f03ff0738	figueira	29.68	pêlo de cauda de unicórnio
e6ebf5d2-f438-11e5-8038-099f03ff0738	figueira	29.68	pêlo de cauda de unicórnio
e6ebf73a-f438-11e5-8038-099f03ff0738	figueira	30.23	pó de chifre de unicórnio
e6ebf88e-f438-11e5-8038-099f03ff0738	cerejeira	29.97	pó de chifre de dragão
e6ebfa00-f438-11e5-8038-099f03ff0738	cerejeira	29.72	escama de sereiano
e6ebfb54-f438-11e5-8038-099f03ff0738	cerejeira	30.40	pena de hipogrifo
e6ebfcb2-f438-11e5-8038-099f03ff0738	cerejeira	30.40	pena de hipogrifo
e6ebfe1a-f438-11e5-8038-099f03ff0738	cerejeira	30.12	escama de dragão
e6ebff6e-f438-11e5-8038-099f03ff0738	cerejeira	29.90	fibra de coração de dragão
e6ec00cc-f438-11e5-8038-099f03ff0738	cerejeira	29.67	pó de presa de dragão
e6ec0234-f438-11e5-8038-099f03ff0738	cerejeira	30.19	pêlo de cauda de unicórnio
e6ec0392-f438-11e5-8038-099f03ff0738	cerejeira	30.43	pó de chifre de unicórnio
e6ec04e6-f438-11e5-8038-099f03ff0738	carvalho	29.70	pó de chifre de dragão
e6ec063a-f438-11e5-8038-099f03ff0738	carvalho	29.44	escama de sereiano
e6ec0798-f438-11e5-8038-099f03ff0738	carvalho	30.21	pena de hipogrifo
e6ec08e2-f438-11e5-8038-099f03ff0738	carvalho	30.31	escama de dragão
e6ec0a40-f438-11e5-8038-099f03ff0738	carvalho	29.53	pena de fênix
e6ec0ba8-f438-11e5-8038-099f03ff0738	carvalho	30.03	fibra de coração de dragão
e6ec0e0a-f438-11e5-8038-099f03ff0738	carvalho	29.67	pó de presa de dragão
e6ec0f68-f438-11e5-8038-099f03ff0738	carvalho	29.62	coral
e6ec10bc-f438-11e5-8038-099f03ff0738	carvalho	30.12	pêlo de cauda de unicórnio
e6ec121a-f438-11e5-8038-099f03ff0738	carvalho	30.12	pêlo de cauda de unicórnio
e6ec136e-f438-11e5-8038-099f03ff0738	cedro	29.78	pó de chifre de dragão
e6ec14d6-f438-11e5-8038-099f03ff0738	cedro	29.80	escama de dragão
e6ec1634-f438-11e5-8038-099f03ff0738	cedro	29.54	fibra de coração de dragão
e6ec1792-f438-11e5-8038-099f03ff0738	cedro	29.81	pó de presa de dragão
e6ec18e6-f438-11e5-8038-099f03ff0738	cedro	30.32	pêlo de cauda de unicórnio
e6ec1a44-f438-11e5-8038-099f03ff0738	cedro	29.73	pó de chifre de unicórnio
e6ec1bc0-f438-11e5-8038-099f03ff0738	macieira	30.13	pó de chifre de dragão
e6ec1d14-f438-11e5-8038-099f03ff0738	macieira	30.13	pó de chifre de dragão
e6ec1e68-f438-11e5-8038-099f03ff0738	macieira	30.31	escama de sereiano
e6ec1fe4-f438-11e5-8038-099f03ff0738	macieira	29.47	pena de hipogrifo
e6ec2138-f438-11e5-8038-099f03ff0738	macieira	29.54	escama de dragão
e6ec228c-f438-11e5-8038-099f03ff0738	macieira	29.99	fibra de coração de dragão
e6ec23ea-f438-11e5-8038-099f03ff0738	macieira	30.19	pó de presa de dragão
e6ec2552-f438-11e5-8038-099f03ff0738	macieira	30.19	pó de presa de dragão
e6ec26b0-f438-11e5-8038-099f03ff0738	macieira	29.45	coral
e6ec27fa-f438-11e5-8038-099f03ff0738	macieira	30.42	pêlo de cauda de unicórnio
e6ec2958-f438-11e5-8038-099f03ff0738	macieira	30.42	pêlo de cauda de unicórnio
e6ec2ac0-f438-11e5-8038-099f03ff0738	macieira	30.42	pêlo de cauda de testrálio
e6ec2c0a-f438-11e5-8038-099f03ff0738	macieira	30.14	sangue de unicórnio
e6ec2d68-f438-11e5-8038-099f03ff0738	macieira	30.14	sangue de unicórnio
e6ec2ebc-f438-11e5-8038-099f03ff0738	macieira	30.41	pó de chifre de unicórnio
e6ec301a-f438-11e5-8038-099f03ff0738	macieira	29.87	cabelo de veela
e6ec3164-f438-11e5-8038-099f03ff0738	ipê	30.00	pó de chifre de dragão
e6ec32c2-f438-11e5-8038-099f03ff0738	ipê	29.84	escama de sereiano
e6ec3416-f438-11e5-8038-099f03ff0738	ipê	29.73	pena de hipogrifo
e6ec3574-f438-11e5-8038-099f03ff0738	ipê	29.65	escama de dragão
e6ec36e6-f438-11e5-8038-099f03ff0738	ipê	29.90	fibra de coração de dragão
e6ec3844-f438-11e5-8038-099f03ff0738	ipê	29.90	fibra de coração de dragão
e6ec39a2-f438-11e5-8038-099f03ff0738	ipê	29.48	coral
e6ec3af6-f438-11e5-8038-099f03ff0738	ipê	30.11	pêlo de cauda de unicórnio
e6ec3c54-f438-11e5-8038-099f03ff0738	ipê	30.35	pêlo de cauda de testrálio
e6ec3db2-f438-11e5-8038-099f03ff0738	ipê	29.65	pó de chifre de unicórnio
e6ec3f06-f438-11e5-8038-099f03ff0738	salgueiro	29.53	pó de chifre de dragão
e6ec4064-f438-11e5-8038-099f03ff0738	salgueiro	30.21	raiz de mandrágora
e6ec41c2-f438-11e5-8038-099f03ff0738	salgueiro	30.37	escama de sereiano
e6ec4320-f438-11e5-8038-099f03ff0738	salgueiro	30.18	pena de hipogrifo
e6ec446a-f438-11e5-8038-099f03ff0738	salgueiro	29.71	escama de dragão
e6ec45c8-f438-11e5-8038-099f03ff0738	salgueiro	29.57	fibra de coração de dragão
e6ec471c-f438-11e5-8038-099f03ff0738	salgueiro	29.74	pó de presa de dragão
e6ec4870-f438-11e5-8038-099f03ff0738	salgueiro	30.18	coral
e6ec49c4-f438-11e5-8038-099f03ff0738	salgueiro	30.32	pêlo de cauda de testrálio
e6ec4b36-f438-11e5-8038-099f03ff0738	sabugueiro	30.35	pó de chifre de dragão
e6ec4c94-f438-11e5-8038-099f03ff0738	sabugueiro	30.15	escama de sereiano
e6ec4faa-f438-11e5-8038-099f03ff0738	sabugueiro	31.03	pena de hipogrifo
e6ec5112-f438-11e5-8038-099f03ff0738	sabugueiro	30.19	escama de dragão
e6ec5270-f438-11e5-8038-099f03ff0738	sabugueiro	30.45	fibra de coração de dragão
e6ec53e2-f438-11e5-8038-099f03ff0738	sabugueiro	30.83	pó de presa de dragão
e6ec5554-f438-11e5-8038-099f03ff0738	sabugueiro	30.49	pêlo de cauda de unicórnio
e6ec56b2-f438-11e5-8038-099f03ff0738	sabugueiro	30.29	pêlo de cauda de testrálio
e6ec5810-f438-11e5-8038-099f03ff0738	sabugueiro	30.54	pó de chifre de unicórnio
e6ec598c-f438-11e5-8038-099f03ff0738	sabugueiro	30.72	cabelo de veela
e6ec5ae0-f438-11e5-8038-099f03ff0738	figueira	30.36	pó de chifre de dragão
e6ec5c3e-f438-11e5-8038-099f03ff0738	figueira	30.80	escama de sereiano
e6ec5d92-f438-11e5-8038-099f03ff0738	figueira	31.09	pena de hipogrifo
e6ec5ee6-f438-11e5-8038-099f03ff0738	figueira	30.35	escama de dragão
e6ec6044-f438-11e5-8038-099f03ff0738	figueira	30.88	fibra de coração de dragão
e6ec6198-f438-11e5-8038-099f03ff0738	figueira	30.88	fibra de coração de dragão
e6ec62f6-f438-11e5-8038-099f03ff0738	figueira	31.02	sangue de unicórnio
e6ec6454-f438-11e5-8038-099f03ff0738	figueira	30.98	pó de chifre de unicórnio
e6ec65b2-f438-11e5-8038-099f03ff0738	cerejeira	30.70	pó de chifre de dragão
e6ec677e-f438-11e5-8038-099f03ff0738	cerejeira	31.11	raiz de mandrágora
e6ec68f0-f438-11e5-8038-099f03ff0738	cerejeira	30.45	escama de sereiano
e6ec6a62-f438-11e5-8038-099f03ff0738	cerejeira	30.79	pena de hipogrifo
e6ec6be8-f438-11e5-8038-099f03ff0738	cerejeira	30.41	escama de dragão
e6ec6d5a-f438-11e5-8038-099f03ff0738	cerejeira	30.34	fibra de coração de dragão
e6ec6ec2-f438-11e5-8038-099f03ff0738	cerejeira	31.00	pó de chifre de unicórnio
e6ec703e-f438-11e5-8038-099f03ff0738	cerejeira	30.39	cabelo de veela
e6ec71e2-f438-11e5-8038-099f03ff0738	carvalho	30.14	pó de chifre de dragão
e6ec7354-f438-11e5-8038-099f03ff0738	carvalho	30.68	raiz de mandrágora
e6ec74c6-f438-11e5-8038-099f03ff0738	carvalho	30.19	pena de hipogrifo
e6ec764c-f438-11e5-8038-099f03ff0738	carvalho	30.64	escama de dragão
e6ec77b4-f438-11e5-8038-099f03ff0738	carvalho	30.19	fibra de coração de dragão
e6ec7926-f438-11e5-8038-099f03ff0738	carvalho	30.19	pó de presa de dragão
e6ec7aac-f438-11e5-8038-099f03ff0738	carvalho	30.59	pêlo de cauda de unicórnio
e6ec7c32-f438-11e5-8038-099f03ff0738	carvalho	30.49	pó de chifre de unicórnio
e6ec7d90-f438-11e5-8038-099f03ff0738	carvalho	30.65	cabelo de veela
e6ec7f20-f438-11e5-8038-099f03ff0738	cedro	30.45	pó de chifre de dragão
e6ec809c-f438-11e5-8038-099f03ff0738	cedro	30.45	pó de chifre de dragão
e6ec8204-f438-11e5-8038-099f03ff0738	cedro	30.26	raiz de mandrágora
e6ec83e4-f438-11e5-8038-099f03ff0738	cedro	30.86	escama de sereiano
e6ec8560-f438-11e5-8038-099f03ff0738	cedro	30.66	escama de dragão
e6ec86d2-f438-11e5-8038-099f03ff0738	cedro	30.93	fibra de coração de dragão
e6ec883a-f438-11e5-8038-099f03ff0738	cedro	30.15	pó de presa de dragão
e6ec89b6-f438-11e5-8038-099f03ff0738	cedro	30.59	pêlo de cauda de unicórnio
e6ec8b28-f438-11e5-8038-099f03ff0738	cedro	30.59	pêlo de cauda de unicórnio
e6ec8c9a-f438-11e5-8038-099f03ff0738	cedro	30.98	pêlo de cauda de testrálio
e6ec8e34-f438-11e5-8038-099f03ff0738	cedro	30.83	sangue de unicórnio
e6ec8fb0-f438-11e5-8038-099f03ff0738	cedro	30.44	pó de chifre de unicórnio
e6ec9136-f438-11e5-8038-099f03ff0738	macieira	30.43	pó de chifre de dragão
e6ec92da-f438-11e5-8038-099f03ff0738	macieira	30.41	pena de hipogrifo
e6ec95dc-f438-11e5-8038-099f03ff0738	macieira	30.53	escama de dragão
e6ec9762-f438-11e5-8038-099f03ff0738	macieira	30.73	fibra de coração de dragão
e6ec9938-f438-11e5-8038-099f03ff0738	macieira	30.27	pó de presa de dragão
e6ec9a8c-f438-11e5-8038-099f03ff0738	macieira	30.37	coral
e6ec9bea-f438-11e5-8038-099f03ff0738	macieira	30.31	pêlo de cauda de unicórnio
e6ec9d3e-f438-11e5-8038-099f03ff0738	macieira	30.99	pêlo de cauda de testrálio
e6ec9e92-f438-11e5-8038-099f03ff0738	macieira	30.99	pêlo de cauda de testrálio
e6ec9ffa-f438-11e5-8038-099f03ff0738	macieira	30.90	sangue de unicórnio
e6eca158-f438-11e5-8038-099f03ff0738	macieira	30.14	pó de chifre de unicórnio
e6eca2b6-f438-11e5-8038-099f03ff0738	ipê	30.39	pó de chifre de dragão
e6eca400-f438-11e5-8038-099f03ff0738	ipê	30.84	escama de sereiano
e6eca568-f438-11e5-8038-099f03ff0738	ipê	30.29	pena de hipogrifo
e6eca6c6-f438-11e5-8038-099f03ff0738	ipê	30.25	escama de dragão
e6eca810-f438-11e5-8038-099f03ff0738	ipê	31.00	fibra de coração de dragão
e6eca978-f438-11e5-8038-099f03ff0738	ipê	30.93	pó de presa de dragão
e6ecaaea-f438-11e5-8038-099f03ff0738	ipê	30.21	pêlo de cauda de unicórnio
e6ecac48-f438-11e5-8038-099f03ff0738	ipê	30.67	pêlo de cauda de testrálio
e6ecad9c-f438-11e5-8038-099f03ff0738	ipê	30.56	sangue de unicórnio
e6ecaefa-f438-11e5-8038-099f03ff0738	ipê	30.53	pó de chifre de unicórnio
e6ecb06c-f438-11e5-8038-099f03ff0738	salgueiro	30.61	pó de chifre de dragão
e6ecb1b6-f438-11e5-8038-099f03ff0738	salgueiro	30.71	raiz de mandrágora
e6ecb314-f438-11e5-8038-099f03ff0738	salgueiro	30.53	escama de sereiano
e6ecb472-f438-11e5-8038-099f03ff0738	salgueiro	30.70	pena de hipogrifo
e6ecb5da-f438-11e5-8038-099f03ff0738	salgueiro	30.63	escama de dragão
e6ecb724-f438-11e5-8038-099f03ff0738	salgueiro	30.63	escama de dragão
e6ecb878-f438-11e5-8038-099f03ff0738	salgueiro	30.61	fibra de coração de dragão
e6ecb9d6-f438-11e5-8038-099f03ff0738	salgueiro	30.61	fibra de coração de dragão
e6ecbb2a-f438-11e5-8038-099f03ff0738	salgueiro	30.70	pó de presa de dragão
e6ecbc88-f438-11e5-8038-099f03ff0738	salgueiro	30.17	coral
e6ecbdf0-f438-11e5-8038-099f03ff0738	salgueiro	30.85	pêlo de cauda de unicórnio
e6ecbf4e-f438-11e5-8038-099f03ff0738	salgueiro	30.28	pêlo de cauda de testrálio
e6ecc0ac-f438-11e5-8038-099f03ff0738	salgueiro	31.10	pó de chifre de unicórnio
e6ecc20a-f438-11e5-8038-099f03ff0738	sabugueiro	30.69	pó de chifre de dragão
e6ecc368-f438-11e5-8038-099f03ff0738	sabugueiro	30.72	raiz de mandrágora
e6ecc4bc-f438-11e5-8038-099f03ff0738	sabugueiro	30.85	escama de sereiano
e6ecc610-f438-11e5-8038-099f03ff0738	sabugueiro	31.25	pena de hipogrifo
e6ecc782-f438-11e5-8038-099f03ff0738	sabugueiro	30.81	escama de dragão
e6ecc8d6-f438-11e5-8038-099f03ff0738	sabugueiro	31.28	fibra de coração de dragão
e6ecca20-f438-11e5-8038-099f03ff0738	sabugueiro	30.89	pó de presa de dragão
e6eccb92-f438-11e5-8038-099f03ff0738	sabugueiro	30.44	coral
e6ecccfa-f438-11e5-8038-099f03ff0738	sabugueiro	30.44	coral
e6ecce4e-f438-11e5-8038-099f03ff0738	sabugueiro	30.90	pêlo de cauda de unicórnio
e6eccfa2-f438-11e5-8038-099f03ff0738	sabugueiro	30.41	pó de chifre de unicórnio
e6ecd114-f438-11e5-8038-099f03ff0738	sabugueiro	30.51	cabelo de veela
e6ecd272-f438-11e5-8038-099f03ff0738	figueira	31.08	pó de chifre de dragão
e6ecd3c6-f438-11e5-8038-099f03ff0738	figueira	31.15	escama de sereiano
e6ecd51a-f438-11e5-8038-099f03ff0738	figueira	31.14	pena de hipogrifo
e6ecd68c-f438-11e5-8038-099f03ff0738	figueira	30.94	escama de dragão
e6ecd7e0-f438-11e5-8038-099f03ff0738	figueira	30.78	fibra de coração de dragão
e6ecd93e-f438-11e5-8038-099f03ff0738	figueira	30.78	fibra de coração de dragão
e6ecdaa6-f438-11e5-8038-099f03ff0738	figueira	30.60	pó de presa de dragão
e6ecdc04-f438-11e5-8038-099f03ff0738	figueira	30.45	coral
e6ecdd4e-f438-11e5-8038-099f03ff0738	figueira	31.13	pêlo de cauda de unicórnio
e6ecdea2-f438-11e5-8038-099f03ff0738	figueira	31.13	pêlo de cauda de unicórnio
e6ece000-f438-11e5-8038-099f03ff0738	figueira	31.20	cabelo de veela
e6ece14a-f438-11e5-8038-099f03ff0738	cerejeira	30.54	pó de chifre de dragão
e6ece9f6-f438-11e5-8038-099f03ff0738	cerejeira	30.61	escama de sereiano
e6eceb36-f438-11e5-8038-099f03ff0738	cerejeira	30.68	pena de hipogrifo
e6ecec76-f438-11e5-8038-099f03ff0738	cerejeira	30.99	escama de dragão
e6ecedac-f438-11e5-8038-099f03ff0738	cerejeira	30.99	escama de dragão
e6eceeec-f438-11e5-8038-099f03ff0738	cerejeira	31.13	fibra de coração de dragão
e6ecf036-f438-11e5-8038-099f03ff0738	cerejeira	30.37	pó de presa de dragão
e6ecf180-f438-11e5-8038-099f03ff0738	cerejeira	31.20	pêlo de cauda de unicórnio
e6ecf2c0-f438-11e5-8038-099f03ff0738	cerejeira	30.42	pêlo de cauda de testrálio
e6ecf400-f438-11e5-8038-099f03ff0738	cerejeira	30.63	pó de chifre de unicórnio
e6ecf540-f438-11e5-8038-099f03ff0738	carvalho	31.30	pó de chifre de dragão
e6ecf68a-f438-11e5-8038-099f03ff0738	carvalho	30.64	raiz de mandrágora
e6ecf7c0-f438-11e5-8038-099f03ff0738	carvalho	30.91	escama de sereiano
e6ecf8f6-f438-11e5-8038-099f03ff0738	carvalho	30.89	pena de hipogrifo
e6ecfa36-f438-11e5-8038-099f03ff0738	carvalho	31.21	escama de dragão
e6ecfb76-f438-11e5-8038-099f03ff0738	carvalho	30.88	fibra de coração de dragão
e6ecfcac-f438-11e5-8038-099f03ff0738	carvalho	31.25	coral
e6ecfde2-f438-11e5-8038-099f03ff0738	carvalho	31.25	coral
e6ecff18-f438-11e5-8038-099f03ff0738	carvalho	30.45	pêlo de cauda de testrálio
e6ed0058-f438-11e5-8038-099f03ff0738	carvalho	30.81	pó de chifre de unicórnio
e6ed0198-f438-11e5-8038-099f03ff0738	cedro	30.42	pó de chifre de dragão
e6ed02ce-f438-11e5-8038-099f03ff0738	cedro	30.42	pó de chifre de dragão
e6ed0404-f438-11e5-8038-099f03ff0738	cedro	30.61	escama de sereiano
e6ed0562-f438-11e5-8038-099f03ff0738	cedro	31.33	pena de hipogrifo
e6ed0698-f438-11e5-8038-099f03ff0738	cedro	30.68	escama de dragão
e6ed07ce-f438-11e5-8038-099f03ff0738	cedro	31.08	fibra de coração de dragão
e6ed0918-f438-11e5-8038-099f03ff0738	cedro	30.83	pó de presa de dragão
e6ed0a6c-f438-11e5-8038-099f03ff0738	cedro	30.60	pêlo de cauda de unicórnio
e6ed0bac-f438-11e5-8038-099f03ff0738	cedro	30.67	sangue de unicórnio
e6ed0cec-f438-11e5-8038-099f03ff0738	cedro	30.62	pó de chifre de unicórnio
e6ed0e2c-f438-11e5-8038-099f03ff0738	cedro	31.19	cabelo de veela
e6ed0f62-f438-11e5-8038-099f03ff0738	macieira	31.18	pó de chifre de dragão
e6ed10a2-f438-11e5-8038-099f03ff0738	macieira	31.34	pena de hipogrifo
e6ed11d8-f438-11e5-8038-099f03ff0738	macieira	31.06	escama de dragão
e6ed1318-f438-11e5-8038-099f03ff0738	macieira	30.76	fibra de coração de dragão
e6ed1458-f438-11e5-8038-099f03ff0738	macieira	30.76	fibra de coração de dragão
e6ed158e-f438-11e5-8038-099f03ff0738	macieira	30.77	pó de presa de dragão
e6ed16ce-f438-11e5-8038-099f03ff0738	macieira	30.77	pó de presa de dragão
e6ed1804-f438-11e5-8038-099f03ff0738	macieira	31.08	pêlo de cauda de unicórnio
e6ed193a-f438-11e5-8038-099f03ff0738	macieira	30.82	pêlo de cauda de testrálio
e6ed1b60-f438-11e5-8038-099f03ff0738	macieira	30.49	pó de chifre de unicórnio
e6ed1caa-f438-11e5-8038-099f03ff0738	ipê	30.89	pó de chifre de dragão
e6ed1dea-f438-11e5-8038-099f03ff0738	ipê	31.14	escama de sereiano
e6ed2010-f438-11e5-8038-099f03ff0738	ipê	31.19	pena de hipogrifo
e6ed21e6-f438-11e5-8038-099f03ff0738	ipê	30.80	escama de dragão
e6ed24d4-f438-11e5-8038-099f03ff0738	ipê	30.80	fibra de coração de dragão
e6ed2614-f438-11e5-8038-099f03ff0738	ipê	30.80	fibra de coração de dragão
e6ed2754-f438-11e5-8038-099f03ff0738	ipê	30.71	pó de presa de dragão
e6ed288a-f438-11e5-8038-099f03ff0738	ipê	30.49	coral
e6ed29c0-f438-11e5-8038-099f03ff0738	ipê	30.46	pêlo de cauda de unicórnio
e6ed2b0a-f438-11e5-8038-099f03ff0738	ipê	31.06	pó de chifre de unicórnio
e6ed2c4a-f438-11e5-8038-099f03ff0738	salgueiro	31.25	pó de chifre de dragão
e6ed2d80-f438-11e5-8038-099f03ff0738	salgueiro	30.78	escama de sereiano
e6ed2ec0-f438-11e5-8038-099f03ff0738	salgueiro	30.55	escama de dragão
e6ed3000-f438-11e5-8038-099f03ff0738	salgueiro	31.28	fibra de coração de dragão
e6ed3136-f438-11e5-8038-099f03ff0738	salgueiro	31.17	pó de presa de dragão
e6ed326c-f438-11e5-8038-099f03ff0738	salgueiro	31.09	pêlo de cauda de unicórnio
e6ed33a2-f438-11e5-8038-099f03ff0738	salgueiro	30.40	pêlo de cauda de testrálio
e6ed34ec-f438-11e5-8038-099f03ff0738	salgueiro	31.00	pó de chifre de unicórnio
e6ed3622-f438-11e5-8038-099f03ff0738	salgueiro	30.92	cabelo de veela
\.


--
-- TOC entry 2259 (class 0 OID 65919)
-- Dependencies: 189
-- Data for Name: r_house_headmaster; Type: TABLE DATA; Schema: public; Owner: guilherme.platzeck
--

COPY r_house_headmaster (per_id, hou_id, creation_date, updated_date, active) FROM stdin;
\.


--
-- TOC entry 2260 (class 0 OID 65935)
-- Dependencies: 190
-- Data for Name: r_house_notorious_people; Type: TABLE DATA; Schema: public; Owner: guilherme.platzeck
--

COPY r_house_notorious_people (per_id, hou_id, creation_date) FROM stdin;
\.


--
-- TOC entry 2262 (class 0 OID 65968)
-- Dependencies: 192
-- Data for Name: r_person_boggart; Type: TABLE DATA; Schema: public; Owner: guilherme.platzeck
--

COPY r_person_boggart (per_id, bog_id, creation_date, updated_date, active) FROM stdin;
\.


--
-- TOC entry 2255 (class 0 OID 65856)
-- Dependencies: 185
-- Data for Name: r_person_field; Type: TABLE DATA; Schema: public; Owner: guilherme.platzeck
--

COPY r_person_field (fie_id, per_id, points, usage) FROM stdin;
\.


--
-- TOC entry 2257 (class 0 OID 65892)
-- Dependencies: 187
-- Data for Name: r_person_parenting; Type: TABLE DATA; Schema: public; Owner: guilherme.platzeck
--

COPY r_person_parenting (per_id, per_id_parent) FROM stdin;
\.


--
-- TOC entry 2258 (class 0 OID 65905)
-- Dependencies: 188
-- Data for Name: r_person_partner; Type: TABLE DATA; Schema: public; Owner: guilherme.platzeck
--

COPY r_person_partner (per_id, per_id_2, active, updated_date, creation_date) FROM stdin;
\.


--
-- TOC entry 2265 (class 0 OID 82090)
-- Dependencies: 195
-- Data for Name: r_person_patrounous; Type: TABLE DATA; Schema: public; Owner: guilherme.platzeck
--

COPY r_person_patrounous (per_id, pat_id, creation_date, updated_date, active) FROM stdin;
\.


--
-- TOC entry 2254 (class 0 OID 65838)
-- Dependencies: 184
-- Data for Name: r_person_skill; Type: TABLE DATA; Schema: public; Owner: guilherme.platzeck
--

COPY r_person_skill (ski_id, per_id, points, usage) FROM stdin;
\.


--
-- TOC entry 2256 (class 0 OID 65874)
-- Dependencies: 186
-- Data for Name: r_person_spell; Type: TABLE DATA; Schema: public; Owner: guilherme.platzeck
--

COPY r_person_spell (spe_id, per_id, points, usage) FROM stdin;
\.


--
-- TOC entry 2263 (class 0 OID 65984)
-- Dependencies: 193
-- Data for Name: r_person_wand; Type: TABLE DATA; Schema: public; Owner: guilherme.platzeck
--

COPY r_person_wand (per_id, wan_id, creation_date, updated_date, active) FROM stdin;
\.


--
-- TOC entry 2085 (class 2606 OID 65753)
-- Name: d_person_pkey; Type: CONSTRAINT; Schema: public; Owner: guilherme.platzeck; Tablespace: 
--

ALTER TABLE ONLY d_person
    ADD CONSTRAINT d_person_pkey PRIMARY KEY (per_id);


--
-- TOC entry 2087 (class 2606 OID 65755)
-- Name: d_person_username_key; Type: CONSTRAINT; Schema: public; Owner: guilherme.platzeck; Tablespace: 
--

ALTER TABLE ONLY d_person
    ADD CONSTRAINT d_person_username_key UNIQUE (username);


--
-- TOC entry 2097 (class 2606 OID 66098)
-- Name: d_user_email_key; Type: CONSTRAINT; Schema: public; Owner: guilherme.platzeck; Tablespace: 
--

ALTER TABLE ONLY d_user
    ADD CONSTRAINT d_user_email_key UNIQUE (email);


--
-- TOC entry 2099 (class 2606 OID 66100)
-- Name: d_user_login_key; Type: CONSTRAINT; Schema: public; Owner: guilherme.platzeck; Tablespace: 
--

ALTER TABLE ONLY d_user
    ADD CONSTRAINT d_user_login_key UNIQUE (login);


--
-- TOC entry 2101 (class 2606 OID 66096)
-- Name: d_user_per_id_key; Type: CONSTRAINT; Schema: public; Owner: guilherme.platzeck; Tablespace: 
--

ALTER TABLE ONLY d_user
    ADD CONSTRAINT d_user_per_id_key UNIQUE (per_id);


--
-- TOC entry 2103 (class 2606 OID 66094)
-- Name: d_user_pkey; Type: CONSTRAINT; Schema: public; Owner: guilherme.platzeck; Tablespace: 
--

ALTER TABLE ONLY d_user
    ADD CONSTRAINT d_user_pkey PRIMARY KEY (use_id);


--
-- TOC entry 2095 (class 2606 OID 65967)
-- Name: d_wand_pkey; Type: CONSTRAINT; Schema: public; Owner: guilherme.platzeck; Tablespace: 
--

ALTER TABLE ONLY k_wand
    ADD CONSTRAINT d_wand_pkey PRIMARY KEY (wan_id);


--
-- TOC entry 2083 (class 2606 OID 65741)
-- Name: k_blood_status_name_key; Type: CONSTRAINT; Schema: public; Owner: guilherme.platzeck; Tablespace: 
--

ALTER TABLE ONLY k_blood_status
    ADD CONSTRAINT k_blood_status_name_key UNIQUE (name);


--
-- TOC entry 2081 (class 2606 OID 65733)
-- Name: k_boggart_pkey; Type: CONSTRAINT; Schema: public; Owner: guilherme.platzeck; Tablespace: 
--

ALTER TABLE ONLY k_boggart
    ADD CONSTRAINT k_boggart_pkey PRIMARY KEY (bog_id);


--
-- TOC entry 2077 (class 2606 OID 65712)
-- Name: k_field_pkey; Type: CONSTRAINT; Schema: public; Owner: guilherme.platzeck; Tablespace: 
--

ALTER TABLE ONLY k_field
    ADD CONSTRAINT k_field_pkey PRIMARY KEY (fie_id);


--
-- TOC entry 2075 (class 2606 OID 65704)
-- Name: k_gender_name_key; Type: CONSTRAINT; Schema: public; Owner: guilherme.platzeck; Tablespace: 
--

ALTER TABLE ONLY k_gender
    ADD CONSTRAINT k_gender_name_key UNIQUE (name);


--
-- TOC entry 2073 (class 2606 OID 65696)
-- Name: k_house_pkey; Type: CONSTRAINT; Schema: public; Owner: guilherme.platzeck; Tablespace: 
--

ALTER TABLE ONLY k_house
    ADD CONSTRAINT k_house_pkey PRIMARY KEY (hou_id);


--
-- TOC entry 2071 (class 2606 OID 65680)
-- Name: k_marital_status_name_key; Type: CONSTRAINT; Schema: public; Owner: guilherme.platzeck; Tablespace: 
--

ALTER TABLE ONLY k_marital_status
    ADD CONSTRAINT k_marital_status_name_key UNIQUE (name);


--
-- TOC entry 2069 (class 2606 OID 65672)
-- Name: k_patrounous_pkey; Type: CONSTRAINT; Schema: public; Owner: guilherme.platzeck; Tablespace: 
--

ALTER TABLE ONLY k_patrounous
    ADD CONSTRAINT k_patrounous_pkey PRIMARY KEY (pat_id);


--
-- TOC entry 2067 (class 2606 OID 65664)
-- Name: k_role_name_key; Type: CONSTRAINT; Schema: public; Owner: guilherme.platzeck; Tablespace: 
--

ALTER TABLE ONLY k_role
    ADD CONSTRAINT k_role_name_key UNIQUE (name);


--
-- TOC entry 2065 (class 2606 OID 65656)
-- Name: k_skill_pkey; Type: CONSTRAINT; Schema: public; Owner: guilherme.platzeck; Tablespace: 
--

ALTER TABLE ONLY k_skill
    ADD CONSTRAINT k_skill_pkey PRIMARY KEY (ski_id);


--
-- TOC entry 2063 (class 2606 OID 65648)
-- Name: k_species_name_key; Type: CONSTRAINT; Schema: public; Owner: guilherme.platzeck; Tablespace: 
--

ALTER TABLE ONLY k_species
    ADD CONSTRAINT k_species_name_key UNIQUE (name);


--
-- TOC entry 2079 (class 2606 OID 65720)
-- Name: k_spell_pkey; Type: CONSTRAINT; Schema: public; Owner: guilherme.platzeck; Tablespace: 
--

ALTER TABLE ONLY k_spell
    ADD CONSTRAINT k_spell_pkey PRIMARY KEY (spe_id);


--
-- TOC entry 2091 (class 2606 OID 65863)
-- Name: r_person_field_pkey; Type: CONSTRAINT; Schema: public; Owner: guilherme.platzeck; Tablespace: 
--

ALTER TABLE ONLY r_person_field
    ADD CONSTRAINT r_person_field_pkey PRIMARY KEY (fie_id, per_id);


--
-- TOC entry 2089 (class 2606 OID 65845)
-- Name: r_person_skill_pkey; Type: CONSTRAINT; Schema: public; Owner: guilherme.platzeck; Tablespace: 
--

ALTER TABLE ONLY r_person_skill
    ADD CONSTRAINT r_person_skill_pkey PRIMARY KEY (ski_id, per_id);


--
-- TOC entry 2093 (class 2606 OID 65881)
-- Name: r_person_spell_pkey; Type: CONSTRAINT; Schema: public; Owner: guilherme.platzeck; Tablespace: 
--

ALTER TABLE ONLY r_person_spell
    ADD CONSTRAINT r_person_spell_pkey PRIMARY KEY (spe_id, per_id);


--
-- TOC entry 2106 (class 2606 OID 65756)
-- Name: d_person_blood_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guilherme.platzeck
--

ALTER TABLE ONLY d_person
    ADD CONSTRAINT d_person_blood_status_fkey FOREIGN KEY (blood_status) REFERENCES k_blood_status(name);


--
-- TOC entry 2107 (class 2606 OID 65761)
-- Name: d_person_gender_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guilherme.platzeck
--

ALTER TABLE ONLY d_person
    ADD CONSTRAINT d_person_gender_fkey FOREIGN KEY (gender) REFERENCES k_gender(name);


--
-- TOC entry 2108 (class 2606 OID 65766)
-- Name: d_person_hou_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guilherme.platzeck
--

ALTER TABLE ONLY d_person
    ADD CONSTRAINT d_person_hou_id_fkey FOREIGN KEY (hou_id) REFERENCES k_house(hou_id);


--
-- TOC entry 2109 (class 2606 OID 65771)
-- Name: d_person_marital_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guilherme.platzeck
--

ALTER TABLE ONLY d_person
    ADD CONSTRAINT d_person_marital_status_fkey FOREIGN KEY (marital_status) REFERENCES k_marital_status(name);


--
-- TOC entry 2110 (class 2606 OID 65776)
-- Name: d_person_species_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guilherme.platzeck
--

ALTER TABLE ONLY d_person
    ADD CONSTRAINT d_person_species_fkey FOREIGN KEY (species) REFERENCES k_species(name);


--
-- TOC entry 2129 (class 2606 OID 66101)
-- Name: d_user_per_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guilherme.platzeck
--

ALTER TABLE ONLY d_user
    ADD CONSTRAINT d_user_per_id_fkey FOREIGN KEY (per_id) REFERENCES d_person(per_id);


--
-- TOC entry 2130 (class 2606 OID 66106)
-- Name: d_user_role_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guilherme.platzeck
--

ALTER TABLE ONLY d_user
    ADD CONSTRAINT d_user_role_fkey FOREIGN KEY (role) REFERENCES k_role(name);


--
-- TOC entry 2104 (class 2606 OID 65781)
-- Name: k_house_per_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guilherme.platzeck
--

ALTER TABLE ONLY k_house
    ADD CONSTRAINT k_house_per_id_fkey FOREIGN KEY (per_id) REFERENCES d_person(per_id);


--
-- TOC entry 2105 (class 2606 OID 65721)
-- Name: k_spell_fie_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guilherme.platzeck
--

ALTER TABLE ONLY k_spell
    ADD CONSTRAINT k_spell_fie_id_fkey FOREIGN KEY (fie_id) REFERENCES k_field(fie_id);


--
-- TOC entry 2122 (class 2606 OID 65930)
-- Name: r_house_headmaster_hou_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guilherme.platzeck
--

ALTER TABLE ONLY r_house_headmaster
    ADD CONSTRAINT r_house_headmaster_hou_id_fkey FOREIGN KEY (hou_id) REFERENCES k_house(hou_id);


--
-- TOC entry 2121 (class 2606 OID 65925)
-- Name: r_house_headmaster_per_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guilherme.platzeck
--

ALTER TABLE ONLY r_house_headmaster
    ADD CONSTRAINT r_house_headmaster_per_id_fkey FOREIGN KEY (per_id) REFERENCES d_person(per_id);


--
-- TOC entry 2124 (class 2606 OID 65944)
-- Name: r_house_notorious_people_hou_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guilherme.platzeck
--

ALTER TABLE ONLY r_house_notorious_people
    ADD CONSTRAINT r_house_notorious_people_hou_id_fkey FOREIGN KEY (hou_id) REFERENCES k_house(hou_id);


--
-- TOC entry 2123 (class 2606 OID 65939)
-- Name: r_house_notorious_people_per_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guilherme.platzeck
--

ALTER TABLE ONLY r_house_notorious_people
    ADD CONSTRAINT r_house_notorious_people_per_id_fkey FOREIGN KEY (per_id) REFERENCES d_person(per_id);


--
-- TOC entry 2126 (class 2606 OID 65979)
-- Name: r_person_boggart_bog_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guilherme.platzeck
--

ALTER TABLE ONLY r_person_boggart
    ADD CONSTRAINT r_person_boggart_bog_id_fkey FOREIGN KEY (bog_id) REFERENCES k_boggart(bog_id);


--
-- TOC entry 2125 (class 2606 OID 65974)
-- Name: r_person_boggart_per_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guilherme.platzeck
--

ALTER TABLE ONLY r_person_boggart
    ADD CONSTRAINT r_person_boggart_per_id_fkey FOREIGN KEY (per_id) REFERENCES d_person(per_id);


--
-- TOC entry 2113 (class 2606 OID 65864)
-- Name: r_person_field_fie_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guilherme.platzeck
--

ALTER TABLE ONLY r_person_field
    ADD CONSTRAINT r_person_field_fie_id_fkey FOREIGN KEY (fie_id) REFERENCES k_field(fie_id);


--
-- TOC entry 2114 (class 2606 OID 65869)
-- Name: r_person_field_per_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guilherme.platzeck
--

ALTER TABLE ONLY r_person_field
    ADD CONSTRAINT r_person_field_per_id_fkey FOREIGN KEY (per_id) REFERENCES d_person(per_id);


--
-- TOC entry 2117 (class 2606 OID 65895)
-- Name: r_person_parenting_per_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guilherme.platzeck
--

ALTER TABLE ONLY r_person_parenting
    ADD CONSTRAINT r_person_parenting_per_id_fkey FOREIGN KEY (per_id) REFERENCES d_person(per_id);


--
-- TOC entry 2118 (class 2606 OID 65900)
-- Name: r_person_parenting_per_id_parent_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guilherme.platzeck
--

ALTER TABLE ONLY r_person_parenting
    ADD CONSTRAINT r_person_parenting_per_id_parent_fkey FOREIGN KEY (per_id_parent) REFERENCES d_person(per_id);


--
-- TOC entry 2120 (class 2606 OID 65914)
-- Name: r_person_partner_per_id_2_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guilherme.platzeck
--

ALTER TABLE ONLY r_person_partner
    ADD CONSTRAINT r_person_partner_per_id_2_fkey FOREIGN KEY (per_id_2) REFERENCES d_person(per_id);


--
-- TOC entry 2119 (class 2606 OID 65909)
-- Name: r_person_partner_per_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guilherme.platzeck
--

ALTER TABLE ONLY r_person_partner
    ADD CONSTRAINT r_person_partner_per_id_fkey FOREIGN KEY (per_id) REFERENCES d_person(per_id);


--
-- TOC entry 2131 (class 2606 OID 82096)
-- Name: r_person_patrounous_pat_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guilherme.platzeck
--

ALTER TABLE ONLY r_person_patrounous
    ADD CONSTRAINT r_person_patrounous_pat_id_fkey FOREIGN KEY (pat_id) REFERENCES k_patrounous(pat_id);


--
-- TOC entry 2132 (class 2606 OID 82101)
-- Name: r_person_patrounous_per_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guilherme.platzeck
--

ALTER TABLE ONLY r_person_patrounous
    ADD CONSTRAINT r_person_patrounous_per_id_fkey FOREIGN KEY (per_id) REFERENCES d_person(per_id);


--
-- TOC entry 2112 (class 2606 OID 65851)
-- Name: r_person_skill_per_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guilherme.platzeck
--

ALTER TABLE ONLY r_person_skill
    ADD CONSTRAINT r_person_skill_per_id_fkey FOREIGN KEY (per_id) REFERENCES d_person(per_id);


--
-- TOC entry 2111 (class 2606 OID 65846)
-- Name: r_person_skill_ski_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guilherme.platzeck
--

ALTER TABLE ONLY r_person_skill
    ADD CONSTRAINT r_person_skill_ski_id_fkey FOREIGN KEY (ski_id) REFERENCES k_skill(ski_id);


--
-- TOC entry 2116 (class 2606 OID 65887)
-- Name: r_person_spell_per_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guilherme.platzeck
--

ALTER TABLE ONLY r_person_spell
    ADD CONSTRAINT r_person_spell_per_id_fkey FOREIGN KEY (per_id) REFERENCES d_person(per_id);


--
-- TOC entry 2115 (class 2606 OID 65882)
-- Name: r_person_spell_spe_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guilherme.platzeck
--

ALTER TABLE ONLY r_person_spell
    ADD CONSTRAINT r_person_spell_spe_id_fkey FOREIGN KEY (spe_id) REFERENCES k_spell(spe_id);


--
-- TOC entry 2127 (class 2606 OID 65990)
-- Name: r_person_wand_per_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guilherme.platzeck
--

ALTER TABLE ONLY r_person_wand
    ADD CONSTRAINT r_person_wand_per_id_fkey FOREIGN KEY (per_id) REFERENCES d_person(per_id);


--
-- TOC entry 2128 (class 2606 OID 65995)
-- Name: r_person_wand_wan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: guilherme.platzeck
--

ALTER TABLE ONLY r_person_wand
    ADD CONSTRAINT r_person_wand_wan_id_fkey FOREIGN KEY (wan_id) REFERENCES k_wand(wan_id);


--
-- TOC entry 2272 (class 0 OID 0)
-- Dependencies: 5
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- TOC entry 2275 (class 0 OID 0)
-- Dependencies: 183
-- Name: d_person; Type: ACL; Schema: public; Owner: guilherme.platzeck
--

REVOKE ALL ON TABLE d_person FROM PUBLIC;
REVOKE ALL ON TABLE d_person FROM "guilherme.platzeck";
GRANT ALL ON TABLE d_person TO "guilherme.platzeck";
GRANT ALL ON TABLE d_person TO PUBLIC;


--
-- TOC entry 2276 (class 0 OID 0)
-- Dependencies: 194
-- Name: d_user; Type: ACL; Schema: public; Owner: guilherme.platzeck
--

REVOKE ALL ON TABLE d_user FROM PUBLIC;
REVOKE ALL ON TABLE d_user FROM "guilherme.platzeck";
GRANT ALL ON TABLE d_user TO "guilherme.platzeck";
GRANT ALL ON TABLE d_user TO PUBLIC;


--
-- TOC entry 2277 (class 0 OID 0)
-- Dependencies: 182
-- Name: k_blood_status; Type: ACL; Schema: public; Owner: guilherme.platzeck
--

REVOKE ALL ON TABLE k_blood_status FROM PUBLIC;
REVOKE ALL ON TABLE k_blood_status FROM "guilherme.platzeck";
GRANT ALL ON TABLE k_blood_status TO "guilherme.platzeck";
GRANT ALL ON TABLE k_blood_status TO PUBLIC;


--
-- TOC entry 2278 (class 0 OID 0)
-- Dependencies: 181
-- Name: k_boggart; Type: ACL; Schema: public; Owner: guilherme.platzeck
--

REVOKE ALL ON TABLE k_boggart FROM PUBLIC;
REVOKE ALL ON TABLE k_boggart FROM "guilherme.platzeck";
GRANT ALL ON TABLE k_boggart TO "guilherme.platzeck";
GRANT ALL ON TABLE k_boggart TO PUBLIC;


--
-- TOC entry 2279 (class 0 OID 0)
-- Dependencies: 179
-- Name: k_field; Type: ACL; Schema: public; Owner: guilherme.platzeck
--

REVOKE ALL ON TABLE k_field FROM PUBLIC;
REVOKE ALL ON TABLE k_field FROM "guilherme.platzeck";
GRANT ALL ON TABLE k_field TO "guilherme.platzeck";
GRANT ALL ON TABLE k_field TO PUBLIC;


--
-- TOC entry 2280 (class 0 OID 0)
-- Dependencies: 178
-- Name: k_gender; Type: ACL; Schema: public; Owner: guilherme.platzeck
--

REVOKE ALL ON TABLE k_gender FROM PUBLIC;
REVOKE ALL ON TABLE k_gender FROM "guilherme.platzeck";
GRANT ALL ON TABLE k_gender TO "guilherme.platzeck";
GRANT ALL ON TABLE k_gender TO PUBLIC;


--
-- TOC entry 2281 (class 0 OID 0)
-- Dependencies: 177
-- Name: k_house; Type: ACL; Schema: public; Owner: guilherme.platzeck
--

REVOKE ALL ON TABLE k_house FROM PUBLIC;
REVOKE ALL ON TABLE k_house FROM "guilherme.platzeck";
GRANT ALL ON TABLE k_house TO "guilherme.platzeck";
GRANT ALL ON TABLE k_house TO PUBLIC;


--
-- TOC entry 2282 (class 0 OID 0)
-- Dependencies: 176
-- Name: k_marital_status; Type: ACL; Schema: public; Owner: guilherme.platzeck
--

REVOKE ALL ON TABLE k_marital_status FROM PUBLIC;
REVOKE ALL ON TABLE k_marital_status FROM "guilherme.platzeck";
GRANT ALL ON TABLE k_marital_status TO "guilherme.platzeck";
GRANT ALL ON TABLE k_marital_status TO PUBLIC;


--
-- TOC entry 2283 (class 0 OID 0)
-- Dependencies: 175
-- Name: k_patrounous; Type: ACL; Schema: public; Owner: guilherme.platzeck
--

REVOKE ALL ON TABLE k_patrounous FROM PUBLIC;
REVOKE ALL ON TABLE k_patrounous FROM "guilherme.platzeck";
GRANT ALL ON TABLE k_patrounous TO "guilherme.platzeck";
GRANT ALL ON TABLE k_patrounous TO PUBLIC;


--
-- TOC entry 2284 (class 0 OID 0)
-- Dependencies: 174
-- Name: k_role; Type: ACL; Schema: public; Owner: guilherme.platzeck
--

REVOKE ALL ON TABLE k_role FROM PUBLIC;
REVOKE ALL ON TABLE k_role FROM "guilherme.platzeck";
GRANT ALL ON TABLE k_role TO "guilherme.platzeck";
GRANT ALL ON TABLE k_role TO PUBLIC;


--
-- TOC entry 2285 (class 0 OID 0)
-- Dependencies: 173
-- Name: k_skill; Type: ACL; Schema: public; Owner: guilherme.platzeck
--

REVOKE ALL ON TABLE k_skill FROM PUBLIC;
REVOKE ALL ON TABLE k_skill FROM "guilherme.platzeck";
GRANT ALL ON TABLE k_skill TO "guilherme.platzeck";
GRANT ALL ON TABLE k_skill TO PUBLIC;


--
-- TOC entry 2286 (class 0 OID 0)
-- Dependencies: 172
-- Name: k_species; Type: ACL; Schema: public; Owner: guilherme.platzeck
--

REVOKE ALL ON TABLE k_species FROM PUBLIC;
REVOKE ALL ON TABLE k_species FROM "guilherme.platzeck";
GRANT ALL ON TABLE k_species TO "guilherme.platzeck";
GRANT ALL ON TABLE k_species TO PUBLIC;


--
-- TOC entry 2287 (class 0 OID 0)
-- Dependencies: 180
-- Name: k_spell; Type: ACL; Schema: public; Owner: guilherme.platzeck
--

REVOKE ALL ON TABLE k_spell FROM PUBLIC;
REVOKE ALL ON TABLE k_spell FROM "guilherme.platzeck";
GRANT ALL ON TABLE k_spell TO "guilherme.platzeck";
GRANT ALL ON TABLE k_spell TO PUBLIC;


--
-- TOC entry 2288 (class 0 OID 0)
-- Dependencies: 191
-- Name: k_wand; Type: ACL; Schema: public; Owner: guilherme.platzeck
--

REVOKE ALL ON TABLE k_wand FROM PUBLIC;
REVOKE ALL ON TABLE k_wand FROM "guilherme.platzeck";
GRANT ALL ON TABLE k_wand TO "guilherme.platzeck";
GRANT ALL ON TABLE k_wand TO PUBLIC;


--
-- TOC entry 2289 (class 0 OID 0)
-- Dependencies: 189
-- Name: r_house_headmaster; Type: ACL; Schema: public; Owner: guilherme.platzeck
--

REVOKE ALL ON TABLE r_house_headmaster FROM PUBLIC;
REVOKE ALL ON TABLE r_house_headmaster FROM "guilherme.platzeck";
GRANT ALL ON TABLE r_house_headmaster TO "guilherme.platzeck";
GRANT ALL ON TABLE r_house_headmaster TO PUBLIC;


--
-- TOC entry 2290 (class 0 OID 0)
-- Dependencies: 190
-- Name: r_house_notorious_people; Type: ACL; Schema: public; Owner: guilherme.platzeck
--

REVOKE ALL ON TABLE r_house_notorious_people FROM PUBLIC;
REVOKE ALL ON TABLE r_house_notorious_people FROM "guilherme.platzeck";
GRANT ALL ON TABLE r_house_notorious_people TO "guilherme.platzeck";
GRANT ALL ON TABLE r_house_notorious_people TO PUBLIC;


--
-- TOC entry 2291 (class 0 OID 0)
-- Dependencies: 192
-- Name: r_person_boggart; Type: ACL; Schema: public; Owner: guilherme.platzeck
--

REVOKE ALL ON TABLE r_person_boggart FROM PUBLIC;
REVOKE ALL ON TABLE r_person_boggart FROM "guilherme.platzeck";
GRANT ALL ON TABLE r_person_boggart TO "guilherme.platzeck";
GRANT ALL ON TABLE r_person_boggart TO PUBLIC;


--
-- TOC entry 2292 (class 0 OID 0)
-- Dependencies: 185
-- Name: r_person_field; Type: ACL; Schema: public; Owner: guilherme.platzeck
--

REVOKE ALL ON TABLE r_person_field FROM PUBLIC;
REVOKE ALL ON TABLE r_person_field FROM "guilherme.platzeck";
GRANT ALL ON TABLE r_person_field TO "guilherme.platzeck";
GRANT ALL ON TABLE r_person_field TO PUBLIC;


--
-- TOC entry 2293 (class 0 OID 0)
-- Dependencies: 187
-- Name: r_person_parenting; Type: ACL; Schema: public; Owner: guilherme.platzeck
--

REVOKE ALL ON TABLE r_person_parenting FROM PUBLIC;
REVOKE ALL ON TABLE r_person_parenting FROM "guilherme.platzeck";
GRANT ALL ON TABLE r_person_parenting TO "guilherme.platzeck";
GRANT ALL ON TABLE r_person_parenting TO PUBLIC;


--
-- TOC entry 2294 (class 0 OID 0)
-- Dependencies: 188
-- Name: r_person_partner; Type: ACL; Schema: public; Owner: guilherme.platzeck
--

REVOKE ALL ON TABLE r_person_partner FROM PUBLIC;
REVOKE ALL ON TABLE r_person_partner FROM "guilherme.platzeck";
GRANT ALL ON TABLE r_person_partner TO "guilherme.platzeck";
GRANT ALL ON TABLE r_person_partner TO PUBLIC;


--
-- TOC entry 2295 (class 0 OID 0)
-- Dependencies: 195
-- Name: r_person_patrounous; Type: ACL; Schema: public; Owner: guilherme.platzeck
--

REVOKE ALL ON TABLE r_person_patrounous FROM PUBLIC;
REVOKE ALL ON TABLE r_person_patrounous FROM "guilherme.platzeck";
GRANT ALL ON TABLE r_person_patrounous TO "guilherme.platzeck";
GRANT ALL ON TABLE r_person_patrounous TO PUBLIC;


--
-- TOC entry 2296 (class 0 OID 0)
-- Dependencies: 184
-- Name: r_person_skill; Type: ACL; Schema: public; Owner: guilherme.platzeck
--

REVOKE ALL ON TABLE r_person_skill FROM PUBLIC;
REVOKE ALL ON TABLE r_person_skill FROM "guilherme.platzeck";
GRANT ALL ON TABLE r_person_skill TO "guilherme.platzeck";
GRANT ALL ON TABLE r_person_skill TO PUBLIC;


--
-- TOC entry 2297 (class 0 OID 0)
-- Dependencies: 186
-- Name: r_person_spell; Type: ACL; Schema: public; Owner: guilherme.platzeck
--

REVOKE ALL ON TABLE r_person_spell FROM PUBLIC;
REVOKE ALL ON TABLE r_person_spell FROM "guilherme.platzeck";
GRANT ALL ON TABLE r_person_spell TO "guilherme.platzeck";
GRANT ALL ON TABLE r_person_spell TO PUBLIC;


--
-- TOC entry 2298 (class 0 OID 0)
-- Dependencies: 193
-- Name: r_person_wand; Type: ACL; Schema: public; Owner: guilherme.platzeck
--

REVOKE ALL ON TABLE r_person_wand FROM PUBLIC;
REVOKE ALL ON TABLE r_person_wand FROM "guilherme.platzeck";
GRANT ALL ON TABLE r_person_wand TO "guilherme.platzeck";
GRANT ALL ON TABLE r_person_wand TO PUBLIC;


-- Completed on 2016-04-11 01:11:42 BRT

--
-- PostgreSQL database dump complete
--

