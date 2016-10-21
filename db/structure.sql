--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.4
-- Dumped by pg_dump version 9.5.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: exports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE exports (
    id integer NOT NULL,
    hscode_id integer,
    year integer NOT NULL,
    months integer[] DEFAULT '{}'::integer[] NOT NULL,
    code integer NOT NULL,
    description character varying NOT NULL,
    destination character varying NOT NULL,
    net_mass numeric(13,2) NOT NULL,
    fob_usd numeric(13,2) NOT NULL,
    fob_etb numeric(13,2) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: exports_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE exports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: exports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE exports_id_seq OWNED BY exports.id;


--
-- Name: hscodes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE hscodes (
    id integer NOT NULL,
    code integer NOT NULL,
    description character varying NOT NULL,
    unit character varying DEFAULT 'UN'::character varying NOT NULL,
    special_permission character varying DEFAULT 'None'::character varying NOT NULL,
    duty integer DEFAULT 0 NOT NULL,
    excise integer DEFAULT 0 NOT NULL,
    vat integer DEFAULT 0 NOT NULL,
    sur integer DEFAULT 0 NOT NULL,
    withhold integer DEFAULT 0 NOT NULL,
    ss1 integer DEFAULT 0 NOT NULL,
    ss2 integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: hscodes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE hscodes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: hscodes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE hscodes_id_seq OWNED BY hscodes.id;


--
-- Name: imports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE imports (
    id integer NOT NULL,
    hscode_id integer,
    year integer NOT NULL,
    months integer[] DEFAULT '{}'::integer[] NOT NULL,
    code integer NOT NULL,
    description character varying NOT NULL,
    country_origin character varying NOT NULL,
    country_consignment character varying NOT NULL,
    net_mass numeric(13,2) NOT NULL,
    cif_usd numeric(13,2) NOT NULL,
    cif_etb numeric(13,2) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: imports_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE imports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: imports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE imports_id_seq OWNED BY imports.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY exports ALTER COLUMN id SET DEFAULT nextval('exports_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY hscodes ALTER COLUMN id SET DEFAULT nextval('hscodes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY imports ALTER COLUMN id SET DEFAULT nextval('imports_id_seq'::regclass);


--
-- Name: ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: exports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY exports
    ADD CONSTRAINT exports_pkey PRIMARY KEY (id);


--
-- Name: hscodes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hscodes
    ADD CONSTRAINT hscodes_pkey PRIMARY KEY (id);


--
-- Name: imports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY imports
    ADD CONSTRAINT imports_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: index_exports_on_code; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_exports_on_code ON exports USING btree (code);


--
-- Name: index_exports_on_destination; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_exports_on_destination ON exports USING btree (destination);


--
-- Name: index_exports_on_hscode_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_exports_on_hscode_id ON exports USING btree (hscode_id);


--
-- Name: index_exports_on_months; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_exports_on_months ON exports USING btree (months);


--
-- Name: index_exports_on_year; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_exports_on_year ON exports USING btree (year);


--
-- Name: index_hscodes_on_code; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_hscodes_on_code ON hscodes USING btree (code);


--
-- Name: index_hscodes_on_description; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_hscodes_on_description ON hscodes USING btree (description);


--
-- Name: index_imports_on_code; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_imports_on_code ON imports USING btree (code);


--
-- Name: index_imports_on_country_origin; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_imports_on_country_origin ON imports USING btree (country_origin);


--
-- Name: index_imports_on_hscode_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_imports_on_hscode_id ON imports USING btree (hscode_id);


--
-- Name: index_imports_on_months; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_imports_on_months ON imports USING btree (months);


--
-- Name: index_imports_on_year; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_imports_on_year ON imports USING btree (year);


--
-- Name: fk_rails_e23c39e1b1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY imports
    ADD CONSTRAINT fk_rails_e23c39e1b1 FOREIGN KEY (hscode_id) REFERENCES hscodes(id);


--
-- Name: fk_rails_efa612816a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY exports
    ADD CONSTRAINT fk_rails_efa612816a FOREIGN KEY (hscode_id) REFERENCES hscodes(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO schema_migrations (version) VALUES ('20161021133943'), ('20161021133947'), ('20161021133952');


