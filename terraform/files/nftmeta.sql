--
-- PostgreSQL database dump
--

-- Dumped from database version 12.15 (Debian 12.15-1.pgdg110+1)
-- Dumped by pg_dump version 12.15 (Debian 12.15-1.pgdg110+1)

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
-- Name: schoolgrade; Type: TYPE; Schema: public; Owner: kingbarz
--

CREATE TYPE public.schoolgrade AS ENUM (
    'ELEMENTARY_SCHOOL',
    'MIDDLE_SCHOOL',
    'JUNIOR_HIGH_SCHOOL',
    'SENIOR_HIGH_SCHOOL',
    'PREPARATORY_SCHOOL'
);


ALTER TYPE public.schoolgrade OWNER TO kingbarz;

--
-- Name: sporttype; Type: TYPE; Schema: public; Owner: kingbarz
--

CREATE TYPE public.sporttype AS ENUM (
    'BASEBALL',
    'BASKETBALL',
    'CHEERLEADING',
    'CROSS_COUNTRY',
    'FIELD_HOCKEY',
    'FOOTBALL',
    'GYMNASTICS',
    'ICE_HOCKEY',
    'SOCCER',
    'SOFTBALL',
    'SWIMMING',
    'TENNIS',
    'VOLLEYBALL',
    'WRESTLING',
    'TEAKWONDO',
    'TRACK_FIELD',
    'LACROSSE',
    'KARATE',
    'JUDO',
    'GOLF'
);


ALTER TYPE public.sporttype OWNER TO kingbarz;

--
-- Name: usertype; Type: TYPE; Schema: public; Owner: kingbarz
--

CREATE TYPE public.usertype AS ENUM (
    'ATHLETE',
    'COACH',
    'REFEREE',
    'FAN',
    'CAPTAIN'
);


ALTER TYPE public.usertype OWNER TO kingbarz;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: kingbarz
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO kingbarz;

--
-- Name: nft_athlete_card; Type: TABLE; Schema: public; Owner: kingbarz
--

CREATE TABLE public.nft_athlete_card (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    city character varying(100) NOT NULL,
    nft_uuid character varying(100) NOT NULL,
    kind public.usertype NOT NULL,
    sport public.sporttype NOT NULL,
    birthdate timestamp without time zone NOT NULL,
    weight double precision NOT NULL,
    height double precision NOT NULL,
    "schoolGrade" public.schoolgrade NOT NULL,
    image_url character varying,
    "cardMinted" boolean NOT NULL
);


ALTER TABLE public.nft_athlete_card OWNER TO kingbarz;

--
-- Name: nft_athlete_card_id_seq; Type: SEQUENCE; Schema: public; Owner: kingbarz
--

CREATE SEQUENCE public.nft_athlete_card_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nft_athlete_card_id_seq OWNER TO kingbarz;

--
-- Name: nft_athlete_card_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kingbarz
--

ALTER SEQUENCE public.nft_athlete_card_id_seq OWNED BY public.nft_athlete_card.id;


--
-- Name: nft_athlete_card_marketplace; Type: TABLE; Schema: public; Owner: kingbarz
--

CREATE TABLE public.nft_athlete_card_marketplace (
    id integer NOT NULL,
    wallet_id character varying(36) NOT NULL,
    tier character varying(50) NOT NULL,
    price double precision NOT NULL,
    athlete_card_id character varying(100) NOT NULL
);


ALTER TABLE public.nft_athlete_card_marketplace OWNER TO kingbarz;

--
-- Name: nft_athlete_card_marketplace_id_seq; Type: SEQUENCE; Schema: public; Owner: kingbarz
--

CREATE SEQUENCE public.nft_athlete_card_marketplace_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nft_athlete_card_marketplace_id_seq OWNER TO kingbarz;

--
-- Name: nft_athlete_card_marketplace_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kingbarz
--

ALTER SEQUENCE public.nft_athlete_card_marketplace_id_seq OWNED BY public.nft_athlete_card_marketplace.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: kingbarz
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying NOT NULL,
    password character varying NOT NULL,
    did character varying,
    wallet_id character varying(36) NOT NULL
);


ALTER TABLE public.users OWNER TO kingbarz;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: kingbarz
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO kingbarz;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kingbarz
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: verifiable_credentials; Type: TABLE; Schema: public; Owner: kingbarz
--

CREATE TABLE public.verifiable_credentials (
    id integer NOT NULL,
    user_id integer NOT NULL,
    credential json NOT NULL,
    vc_label character varying NOT NULL
);


ALTER TABLE public.verifiable_credentials OWNER TO kingbarz;

--
-- Name: verifiable_credentials_id_seq; Type: SEQUENCE; Schema: public; Owner: kingbarz
--

CREATE SEQUENCE public.verifiable_credentials_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.verifiable_credentials_id_seq OWNER TO kingbarz;

--
-- Name: verifiable_credentials_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kingbarz
--

ALTER SEQUENCE public.verifiable_credentials_id_seq OWNED BY public.verifiable_credentials.id;


--
-- Name: nft_athlete_card id; Type: DEFAULT; Schema: public; Owner: kingbarz
--

ALTER TABLE ONLY public.nft_athlete_card ALTER COLUMN id SET DEFAULT nextval('public.nft_athlete_card_id_seq'::regclass);


--
-- Name: nft_athlete_card_marketplace id; Type: DEFAULT; Schema: public; Owner: kingbarz
--

ALTER TABLE ONLY public.nft_athlete_card_marketplace ALTER COLUMN id SET DEFAULT nextval('public.nft_athlete_card_marketplace_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: kingbarz
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: verifiable_credentials id; Type: DEFAULT; Schema: public; Owner: kingbarz
--

ALTER TABLE ONLY public.verifiable_credentials ALTER COLUMN id SET DEFAULT nextval('public.verifiable_credentials_id_seq'::regclass);


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: kingbarz
--

COPY public.alembic_version (version_num) FROM stdin;
2bcc2c7c595a
\.


--
-- Data for Name: nft_athlete_card; Type: TABLE DATA; Schema: public; Owner: kingbarz
--

COPY public.nft_athlete_card (id, name, city, nft_uuid, kind, sport, birthdate, weight, height, "schoolGrade", image_url, "cardMinted") FROM stdin;
1	string	string	a56ae492-2dfc-4da6-ad5a-09abba7a19a2	ATHLETE	BASEBALL	2020-09-09 00:00:00	0	0	ELEMENTARY_SCHOOL	278edcb8-ebd6-4683-b9fa-0066210d6feb.jpg	t
\.


--
-- Data for Name: nft_athlete_card_marketplace; Type: TABLE DATA; Schema: public; Owner: kingbarz
--

COPY public.nft_athlete_card_marketplace (id, wallet_id, tier, price, athlete_card_id) FROM stdin;
1	c90d5f63-16c8-4643-bf6b-20d4b066ecda	Standard	0	a56ae492-2dfc-4da6-ad5a-09abba7a19a2
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: kingbarz
--

COPY public.users (id, username, password, did, wallet_id) FROM stdin;
1	David	$2b$12$KktspuRntAAhTEES7P51UO8D6kXegsGOsXb4TMR7L.NWi6lnDUXo.	did:key:z6MkfsbkJjfJpxUB4MLYuRHrtdwW8QBwDcAKormnKU2ZMq5r	c90d5f63-16c8-4643-bf6b-20d4b066ecda
\.


--
-- Data for Name: verifiable_credentials; Type: TABLE DATA; Schema: public; Owner: kingbarz
--

COPY public.verifiable_credentials (id, user_id, credential, vc_label) FROM stdin;
1	1	{"type": ["VerifiableCredential", "PythonCredential"], "@context": ["https://www.w3.org/2018/credentials/v1", "https://www.w3.org/2018/credentials/examples/v1", "https://w3id.org/security/suites/jws-2020/v1"], "id": "urn:uuid:6074c15a-bdd5-4d29-9c45-0165c913e681", "issuer": {"id": "did:key:z6MkwGzSc39Hff2Y9ZtmzLp8d46RcP6v6gc1R3r6C4AipRWS"}, "issuanceDate": "2023-06-07T00:51:18Z", "issued": "2023-06-07T00:51:18Z", "validFrom": "2023-06-07T00:51:18Z", "credentialSubject": {"id": "did:key:z6MkfsbkJjfJpxUB4MLYuRHrtdwW8QBwDcAKormnKU2ZMq5r", "firstName": "default_user_name", "lastName": "default_wallet_id", "birthday": "default_user_name", "city": "default_wallet_id", "country": "default_user_name", "height": "default_wallet_id", "weight": "default_user_name", "userImg": "default_wallet_id"}, "nft_uuid": "string", "kind": 0, "sport": 0, "firstName": "default_user_name", "lastName": "default_wallet_id", "birthday": "default_user_name", "city": "default_wallet_id", "country": "default_user_name", "height": "default_wallet_id", "weight": "default_user_name", "schoolGrade": 0, "ageVerificationImg": 0, "nftImg": "default_wallet_image", "proof": {"type": "JsonWebSignature2020", "creator": "did:key:z6MkwGzSc39Hff2Y9ZtmzLp8d46RcP6v6gc1R3r6C4AipRWS", "created": "2023-06-07T00:51:18Z", "verificationMethod": "did:key:z6MkwGzSc39Hff2Y9ZtmzLp8d46RcP6v6gc1R3r6C4AipRWS#z6MkwGzSc39Hff2Y9ZtmzLp8d46RcP6v6gc1R3r6C4AipRWS", "jws": "eyJiNjQiOmZhbHNlLCJjcml0IjpbImI2NCJdLCJhbGciOiJFZERTQSJ9..-xEWymLlGze6d2aGDbWM4fG6FL1-u0drv0PhXgiu-I5bbTIJuTIhMCJO_BUT8YQgAo36oR8ebkUi5lw1QYFJCw"}}	DavidVCLabel_1
\.


--
-- Name: nft_athlete_card_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kingbarz
--

SELECT pg_catalog.setval('public.nft_athlete_card_id_seq', 1, true);


--
-- Name: nft_athlete_card_marketplace_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kingbarz
--

SELECT pg_catalog.setval('public.nft_athlete_card_marketplace_id_seq', 1, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kingbarz
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- Name: verifiable_credentials_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kingbarz
--

SELECT pg_catalog.setval('public.verifiable_credentials_id_seq', 1, true);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: kingbarz
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: nft_athlete_card_marketplace nft_athlete_card_marketplace_pkey; Type: CONSTRAINT; Schema: public; Owner: kingbarz
--

ALTER TABLE ONLY public.nft_athlete_card_marketplace
    ADD CONSTRAINT nft_athlete_card_marketplace_pkey PRIMARY KEY (id);


--
-- Name: nft_athlete_card nft_athlete_card_nft_uuid_key; Type: CONSTRAINT; Schema: public; Owner: kingbarz
--

ALTER TABLE ONLY public.nft_athlete_card
    ADD CONSTRAINT nft_athlete_card_nft_uuid_key UNIQUE (nft_uuid);


--
-- Name: nft_athlete_card nft_athlete_card_pkey; Type: CONSTRAINT; Schema: public; Owner: kingbarz
--

ALTER TABLE ONLY public.nft_athlete_card
    ADD CONSTRAINT nft_athlete_card_pkey PRIMARY KEY (id);


--
-- Name: verifiable_credentials uq_user_vc_label; Type: CONSTRAINT; Schema: public; Owner: kingbarz
--

ALTER TABLE ONLY public.verifiable_credentials
    ADD CONSTRAINT uq_user_vc_label UNIQUE (user_id, vc_label);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: kingbarz
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: kingbarz
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: users users_wallet_id_key; Type: CONSTRAINT; Schema: public; Owner: kingbarz
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_wallet_id_key UNIQUE (wallet_id);


--
-- Name: verifiable_credentials verifiable_credentials_pkey; Type: CONSTRAINT; Schema: public; Owner: kingbarz
--

ALTER TABLE ONLY public.verifiable_credentials
    ADD CONSTRAINT verifiable_credentials_pkey PRIMARY KEY (id);


--
-- Name: ix_nft_athlete_card_id; Type: INDEX; Schema: public; Owner: kingbarz
--

CREATE INDEX ix_nft_athlete_card_id ON public.nft_athlete_card USING btree (id);


--
-- Name: ix_users_id; Type: INDEX; Schema: public; Owner: kingbarz
--

CREATE INDEX ix_users_id ON public.users USING btree (id);


--
-- Name: ix_verifiable_credentials_id; Type: INDEX; Schema: public; Owner: kingbarz
--

CREATE INDEX ix_verifiable_credentials_id ON public.verifiable_credentials USING btree (id);


--
-- Name: nft_athlete_card_marketplace nft_athlete_card_marketplace_athlete_card_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kingbarz
--

ALTER TABLE ONLY public.nft_athlete_card_marketplace
    ADD CONSTRAINT nft_athlete_card_marketplace_athlete_card_id_fkey FOREIGN KEY (athlete_card_id) REFERENCES public.nft_athlete_card(nft_uuid);


--
-- Name: nft_athlete_card_marketplace nft_athlete_card_marketplace_wallet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kingbarz
--

ALTER TABLE ONLY public.nft_athlete_card_marketplace
    ADD CONSTRAINT nft_athlete_card_marketplace_wallet_id_fkey FOREIGN KEY (wallet_id) REFERENCES public.users(wallet_id);


--
-- Name: verifiable_credentials verifiable_credentials_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kingbarz
--

ALTER TABLE ONLY public.verifiable_credentials
    ADD CONSTRAINT verifiable_credentials_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

