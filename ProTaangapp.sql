--
-- PostgreSQL database dump
--

-- Dumped from database version 9.4.8
-- Dumped by pg_dump version 9.4.8
-- Started on 2018-11-09 18:08:37

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 1 (class 3079 OID 11855)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2373 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 173 (class 1259 OID 16394)
-- Name: abogado; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE abogado (
    id_abogado integer NOT NULL,
    id_usuario integer,
    nombre character varying NOT NULL,
    apellido character varying NOT NULL,
    direccion character varying NOT NULL,
    telefono character varying NOT NULL,
    ci numeric(10,0) NOT NULL,
    registro_profesional character varying,
    estado character varying NOT NULL,
    email character varying NOT NULL
);


ALTER TABLE abogado OWNER TO postgres;

--
-- TOC entry 174 (class 1259 OID 16400)
-- Name: abogado_id_abogado_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE abogado_id_abogado_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE abogado_id_abogado_seq OWNER TO postgres;

--
-- TOC entry 2374 (class 0 OID 0)
-- Dependencies: 174
-- Name: abogado_id_abogado_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE abogado_id_abogado_seq OWNED BY abogado.id_abogado;


--
-- TOC entry 175 (class 1259 OID 16402)
-- Name: clase; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE clase (
    nro_clase integer NOT NULL,
    descripcion character varying NOT NULL,
    version integer NOT NULL
);


ALTER TABLE clase OWNER TO postgres;

--
-- TOC entry 176 (class 1259 OID 16408)
-- Name: cliente; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cliente (
    id_cliente integer NOT NULL,
    id_usuario integer,
    estado character varying NOT NULL,
    nombre character varying,
    apellido character varying,
    direccion character varying NOT NULL,
    telefono character varying NOT NULL,
    ci numeric(8,0),
    ruc character varying NOT NULL,
    razon_social character varying,
    tipo_cliente character varying(1) NOT NULL,
    id_pais integer NOT NULL,
    email character varying NOT NULL,
    CONSTRAINT ck_estado_cliente CHECK ((((estado)::text ~~ 'ACTIVO'::text) OR ((estado)::text ~~ 'INACTIVO'::text))),
    CONSTRAINT ck_tipo_cliente CHECK ((((tipo_cliente)::text ~~ 'F'::text) OR ((tipo_cliente)::text ~~ 'J'::text)))
);


ALTER TABLE cliente OWNER TO postgres;

--
-- TOC entry 177 (class 1259 OID 16416)
-- Name: cliente_id_cliente_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cliente_id_cliente_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cliente_id_cliente_seq OWNER TO postgres;

--
-- TOC entry 2375 (class 0 OID 0)
-- Dependencies: 177
-- Name: cliente_id_cliente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE cliente_id_cliente_seq OWNED BY cliente.id_cliente;


--
-- TOC entry 178 (class 1259 OID 16418)
-- Name: documento; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE documento (
    id_documento integer NOT NULL,
    id_expediente integer NOT NULL,
    id_tipo_documento integer NOT NULL,
    descripcion character varying NOT NULL,
    fecha timestamp without time zone NOT NULL,
    documento bytea NOT NULL,
    folio_desde integer,
    nombre_documento character varying NOT NULL,
    folio_hasta integer
);


ALTER TABLE documento OWNER TO postgres;

--
-- TOC entry 179 (class 1259 OID 16424)
-- Name: documento_id_documento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE documento_id_documento_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE documento_id_documento_seq OWNER TO postgres;

--
-- TOC entry 2376 (class 0 OID 0)
-- Dependencies: 179
-- Name: documento_id_documento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE documento_id_documento_seq OWNED BY documento.id_documento;


--
-- TOC entry 220 (class 1259 OID 17049)
-- Name: documento_oposicion_hecha; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE documento_oposicion_hecha (
    id_documento integer NOT NULL,
    id_oposicion_hecha integer NOT NULL,
    id_tipo_documento_oposicion_hecha integer NOT NULL,
    nombre character varying NOT NULL,
    descripcion character varying NOT NULL,
    fecha timestamp without time zone NOT NULL,
    folio_desde integer NOT NULL,
    folio_hasta integer NOT NULL,
    documento bytea NOT NULL
);


ALTER TABLE documento_oposicion_hecha OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 17047)
-- Name: documento_oposicion_hecha_id_documento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE documento_oposicion_hecha_id_documento_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE documento_oposicion_hecha_id_documento_seq OWNER TO postgres;

--
-- TOC entry 2377 (class 0 OID 0)
-- Dependencies: 219
-- Name: documento_oposicion_hecha_id_documento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE documento_oposicion_hecha_id_documento_seq OWNED BY documento_oposicion_hecha.id_documento;


--
-- TOC entry 180 (class 1259 OID 16426)
-- Name: estado_marca; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE estado_marca (
    id_estado integer NOT NULL,
    descripcion character varying NOT NULL,
    tipo character varying
);


ALTER TABLE estado_marca OWNER TO postgres;

--
-- TOC entry 181 (class 1259 OID 16432)
-- Name: estado_marca_id_estado_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE estado_marca_id_estado_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE estado_marca_id_estado_seq OWNER TO postgres;

--
-- TOC entry 2378 (class 0 OID 0)
-- Dependencies: 181
-- Name: estado_marca_id_estado_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE estado_marca_id_estado_seq OWNED BY estado_marca.id_estado;


--
-- TOC entry 206 (class 1259 OID 16794)
-- Name: estado_oposicion; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE estado_oposicion (
    id_estado integer NOT NULL,
    descripcion character varying NOT NULL,
    tipo character varying
);


ALTER TABLE estado_oposicion OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 16792)
-- Name: estado_oposicion_id_estado_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE estado_oposicion_id_estado_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE estado_oposicion_id_estado_seq OWNER TO postgres;

--
-- TOC entry 2379 (class 0 OID 0)
-- Dependencies: 205
-- Name: estado_oposicion_id_estado_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE estado_oposicion_id_estado_seq OWNED BY estado_oposicion.id_estado;


--
-- TOC entry 182 (class 1259 OID 16434)
-- Name: evento; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE evento (
    id_evento integer NOT NULL,
    id_expediente integer NOT NULL,
    descripcion character varying NOT NULL,
    fecha timestamp without time zone NOT NULL,
    nombre character varying NOT NULL,
    prioridad character varying NOT NULL
);


ALTER TABLE evento OWNER TO postgres;

--
-- TOC entry 183 (class 1259 OID 16440)
-- Name: evento_id_evento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE evento_id_evento_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE evento_id_evento_seq OWNER TO postgres;

--
-- TOC entry 2380 (class 0 OID 0)
-- Dependencies: 183
-- Name: evento_id_evento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE evento_id_evento_seq OWNED BY evento.id_evento;


--
-- TOC entry 216 (class 1259 OID 17022)
-- Name: evento_oposicion_hecha; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE evento_oposicion_hecha (
    id_evento integer NOT NULL,
    id_oposicion_hecha integer NOT NULL,
    nombre character varying NOT NULL,
    descripcion character varying NOT NULL,
    fecha timestamp without time zone NOT NULL,
    prioridad character varying NOT NULL
);


ALTER TABLE evento_oposicion_hecha OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 17020)
-- Name: evento_oposicion_hecha_id_evento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE evento_oposicion_hecha_id_evento_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE evento_oposicion_hecha_id_evento_seq OWNER TO postgres;

--
-- TOC entry 2381 (class 0 OID 0)
-- Dependencies: 215
-- Name: evento_oposicion_hecha_id_evento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE evento_oposicion_hecha_id_evento_seq OWNED BY evento_oposicion_hecha.id_evento;


--
-- TOC entry 184 (class 1259 OID 16442)
-- Name: expediente; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE expediente (
    id_expediente integer NOT NULL,
    id_cliente integer NOT NULL,
    id_abogado integer NOT NULL,
    id_estado integer,
    nro_clase integer NOT NULL,
    id_marca integer NOT NULL,
    nro_expediente numeric NOT NULL,
    fecha_solicitud timestamp without time zone NOT NULL,
    fecha_estado timestamp without time zone NOT NULL,
    producto character varying,
    tipo_expediente integer NOT NULL,
    observacion character varying,
    nro_certificado integer,
    comentario_cierre character varying
);


ALTER TABLE expediente OWNER TO postgres;

--
-- TOC entry 185 (class 1259 OID 16448)
-- Name: expediente_id_expediente_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE expediente_id_expediente_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE expediente_id_expediente_seq OWNER TO postgres;

--
-- TOC entry 2382 (class 0 OID 0)
-- Dependencies: 185
-- Name: expediente_id_expediente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE expediente_id_expediente_seq OWNED BY expediente.id_expediente;


--
-- TOC entry 225 (class 1259 OID 17117)
-- Name: factura_cabecera; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE factura_cabecera (
    id_factura integer NOT NULL,
    id_cliente integer NOT NULL,
    fecha time without time zone NOT NULL,
    condicion_venta character varying NOT NULL,
    forma_pago character varying NOT NULL,
    banco character varying NOT NULL,
    numero_cheque character varying,
    numero_cuenta character varying,
    estado character varying NOT NULL,
    numero_factura numeric NOT NULL
);


ALTER TABLE factura_cabecera OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 17134)
-- Name: factura_detalle; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE factura_detalle (
    id_factura_detalle integer NOT NULL,
    id_factura integer NOT NULL,
    item integer NOT NULL,
    descripcion character varying NOT NULL,
    monto numeric NOT NULL,
    iva numeric NOT NULL
);


ALTER TABLE factura_detalle OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 17132)
-- Name: factura_detalle_id_factura_detalle_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE factura_detalle_id_factura_detalle_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE factura_detalle_id_factura_detalle_seq OWNER TO postgres;

--
-- TOC entry 2383 (class 0 OID 0)
-- Dependencies: 226
-- Name: factura_detalle_id_factura_detalle_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE factura_detalle_id_factura_detalle_seq OWNED BY factura_detalle.id_factura_detalle;


--
-- TOC entry 224 (class 1259 OID 17115)
-- Name: factura_id_factura_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE factura_id_factura_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE factura_id_factura_seq OWNER TO postgres;

--
-- TOC entry 2384 (class 0 OID 0)
-- Dependencies: 224
-- Name: factura_id_factura_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE factura_id_factura_seq OWNED BY factura_cabecera.id_factura;


--
-- TOC entry 186 (class 1259 OID 16450)
-- Name: historial; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE historial (
    id_historial integer NOT NULL,
    id_abogado integer NOT NULL,
    id_expediente integer NOT NULL,
    fecha date NOT NULL,
    operacion character varying NOT NULL,
    detalle character varying NOT NULL
);


ALTER TABLE historial OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16965)
-- Name: historial_estado_marca; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE historial_estado_marca (
    id_historial integer NOT NULL,
    id_expediente integer NOT NULL,
    id_estado_marca integer NOT NULL,
    fecha timestamp without time zone NOT NULL,
    fecha_registro timestamp without time zone NOT NULL
);


ALTER TABLE historial_estado_marca OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16963)
-- Name: historial_estado_marca_id_historial_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE historial_estado_marca_id_historial_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE historial_estado_marca_id_historial_seq OWNER TO postgres;

--
-- TOC entry 2385 (class 0 OID 0)
-- Dependencies: 211
-- Name: historial_estado_marca_id_historial_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE historial_estado_marca_id_historial_seq OWNED BY historial_estado_marca.id_historial;


--
-- TOC entry 222 (class 1259 OID 17075)
-- Name: historial_estado_oposicion_hecha; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE historial_estado_oposicion_hecha (
    id_historial integer NOT NULL,
    id_oposicion_hecha integer NOT NULL,
    id_estado_oposicion integer NOT NULL,
    fecha timestamp without time zone NOT NULL,
    fecha_registro timestamp without time zone NOT NULL
);


ALTER TABLE historial_estado_oposicion_hecha OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17073)
-- Name: historial_estado_oposicion_hecha_id_historial_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE historial_estado_oposicion_hecha_id_historial_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE historial_estado_oposicion_hecha_id_historial_seq OWNER TO postgres;

--
-- TOC entry 2386 (class 0 OID 0)
-- Dependencies: 221
-- Name: historial_estado_oposicion_hecha_id_historial_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE historial_estado_oposicion_hecha_id_historial_seq OWNED BY historial_estado_oposicion_hecha.id_historial;


--
-- TOC entry 210 (class 1259 OID 16941)
-- Name: historial_estado_oposicion_recibida; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE historial_estado_oposicion_recibida (
    id_historial integer NOT NULL,
    id_oposicion_recibida integer NOT NULL,
    id_estado_oposicion integer NOT NULL,
    fecha timestamp without time zone NOT NULL,
    fecha_registro timestamp without time zone NOT NULL
);


ALTER TABLE historial_estado_oposicion_recibida OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 16939)
-- Name: historial_estado_oposicion_recibida_id_historial_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE historial_estado_oposicion_recibida_id_historial_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE historial_estado_oposicion_recibida_id_historial_seq OWNER TO postgres;

--
-- TOC entry 2387 (class 0 OID 0)
-- Dependencies: 209
-- Name: historial_estado_oposicion_recibida_id_historial_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE historial_estado_oposicion_recibida_id_historial_seq OWNED BY historial_estado_oposicion_recibida.id_historial;


--
-- TOC entry 187 (class 1259 OID 16456)
-- Name: historial_id_historial_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE historial_id_historial_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE historial_id_historial_seq OWNER TO postgres;

--
-- TOC entry 2388 (class 0 OID 0)
-- Dependencies: 187
-- Name: historial_id_historial_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE historial_id_historial_seq OWNED BY historial.id_historial;


--
-- TOC entry 188 (class 1259 OID 16458)
-- Name: marca; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE marca (
    id_marca integer NOT NULL,
    id_tipo_marca integer NOT NULL,
    denominacion character varying,
    imagen_marca bytea
);


ALTER TABLE marca OWNER TO postgres;

--
-- TOC entry 189 (class 1259 OID 16464)
-- Name: marca_id_marca_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE marca_id_marca_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE marca_id_marca_seq OWNER TO postgres;

--
-- TOC entry 2389 (class 0 OID 0)
-- Dependencies: 189
-- Name: marca_id_marca_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE marca_id_marca_seq OWNED BY marca.id_marca;


--
-- TOC entry 214 (class 1259 OID 16986)
-- Name: oposicion_hecha; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE oposicion_hecha (
    id_oposicion integer NOT NULL,
    denominacion_opositado character varying NOT NULL,
    titular_opositado character varying NOT NULL,
    clase_opositado integer NOT NULL,
    nro_expediente_opositado integer NOT NULL,
    agente_opositado character varying NOT NULL,
    id_abogado_opositante integer NOT NULL,
    id_expediente_opositante integer NOT NULL,
    id_estado_oposicion integer NOT NULL,
    fecha timestamp without time zone NOT NULL,
    comentario_cierre character varying
);


ALTER TABLE oposicion_hecha OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 16984)
-- Name: oposicion_hecha_id_oposicion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE oposicion_hecha_id_oposicion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE oposicion_hecha_id_oposicion_seq OWNER TO postgres;

--
-- TOC entry 2390 (class 0 OID 0)
-- Dependencies: 213
-- Name: oposicion_hecha_id_oposicion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE oposicion_hecha_id_oposicion_seq OWNED BY oposicion_hecha.id_oposicion;


--
-- TOC entry 208 (class 1259 OID 16920)
-- Name: oposicion_recibida; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE oposicion_recibida (
    id_oposicion integer NOT NULL,
    agente character varying NOT NULL,
    clase integer NOT NULL,
    fecha_estado timestamp without time zone NOT NULL,
    marca character varying NOT NULL,
    nro_expediente integer NOT NULL,
    titular character varying NOT NULL,
    id_estado integer NOT NULL,
    id_expediente integer NOT NULL,
    comentario_cierre character varying
);


ALTER TABLE oposicion_recibida OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 16918)
-- Name: oposicion_recibida_id_oposicion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE oposicion_recibida_id_oposicion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE oposicion_recibida_id_oposicion_seq OWNER TO postgres;

--
-- TOC entry 2391 (class 0 OID 0)
-- Dependencies: 207
-- Name: oposicion_recibida_id_oposicion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE oposicion_recibida_id_oposicion_seq OWNED BY oposicion_recibida.id_oposicion;


--
-- TOC entry 190 (class 1259 OID 16466)
-- Name: pais; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE pais (
    id_pais integer NOT NULL,
    pais character varying NOT NULL,
    iso2 character varying(2) DEFAULT NULL::character varying
);


ALTER TABLE pais OWNER TO postgres;

--
-- TOC entry 191 (class 1259 OID 16473)
-- Name: permiso; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE permiso (
    id_permiso integer NOT NULL,
    id_rol integer NOT NULL,
    id_ventana integer NOT NULL
);


ALTER TABLE permiso OWNER TO postgres;

--
-- TOC entry 192 (class 1259 OID 16476)
-- Name: permiso_id_permiso_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE permiso_id_permiso_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE permiso_id_permiso_seq OWNER TO postgres;

--
-- TOC entry 2392 (class 0 OID 0)
-- Dependencies: 192
-- Name: permiso_id_permiso_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE permiso_id_permiso_seq OWNED BY permiso.id_permiso;


--
-- TOC entry 223 (class 1259 OID 17109)
-- Name: prefijo; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE prefijo (
    prefijo character varying(255) NOT NULL,
    fecha timestamp without time zone,
    fin integer,
    id integer,
    inicio integer
);


ALTER TABLE prefijo OWNER TO postgres;

--
-- TOC entry 193 (class 1259 OID 16478)
-- Name: rol; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE rol (
    id_rol integer NOT NULL,
    rol character varying NOT NULL,
    descripcion character varying NOT NULL,
    estado character varying NOT NULL
);


ALTER TABLE rol OWNER TO postgres;

--
-- TOC entry 194 (class 1259 OID 16484)
-- Name: rol_id_rol_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE rol_id_rol_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE rol_id_rol_seq OWNER TO postgres;

--
-- TOC entry 2393 (class 0 OID 0)
-- Dependencies: 194
-- Name: rol_id_rol_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE rol_id_rol_seq OWNED BY rol.id_rol;


--
-- TOC entry 218 (class 1259 OID 17038)
-- Name: tipo_documento_oposicion_hecha; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tipo_documento_oposicion_hecha (
    id_tipo_documento integer NOT NULL,
    descripcion character varying NOT NULL
);


ALTER TABLE tipo_documento_oposicion_hecha OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 17036)
-- Name: tipo_doc_oposicion_hecha_id_tipo_doc_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tipo_doc_oposicion_hecha_id_tipo_doc_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tipo_doc_oposicion_hecha_id_tipo_doc_seq OWNER TO postgres;

--
-- TOC entry 2394 (class 0 OID 0)
-- Dependencies: 217
-- Name: tipo_doc_oposicion_hecha_id_tipo_doc_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tipo_doc_oposicion_hecha_id_tipo_doc_seq OWNED BY tipo_documento_oposicion_hecha.id_tipo_documento;


--
-- TOC entry 195 (class 1259 OID 16486)
-- Name: tipo_documento; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tipo_documento (
    id_tipo_documento integer NOT NULL,
    descripcion character varying NOT NULL
);


ALTER TABLE tipo_documento OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 16492)
-- Name: tipo_documento_id_tipo_documento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tipo_documento_id_tipo_documento_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tipo_documento_id_tipo_documento_seq OWNER TO postgres;

--
-- TOC entry 2395 (class 0 OID 0)
-- Dependencies: 196
-- Name: tipo_documento_id_tipo_documento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tipo_documento_id_tipo_documento_seq OWNED BY tipo_documento.id_tipo_documento;


--
-- TOC entry 197 (class 1259 OID 16494)
-- Name: tipo_expediente; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tipo_expediente (
    id_tipo_expediente integer NOT NULL,
    descripcion character varying NOT NULL
);


ALTER TABLE tipo_expediente OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 16500)
-- Name: tipo_expediente_id_tipo_expediente_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tipo_expediente_id_tipo_expediente_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tipo_expediente_id_tipo_expediente_seq OWNER TO postgres;

--
-- TOC entry 2396 (class 0 OID 0)
-- Dependencies: 198
-- Name: tipo_expediente_id_tipo_expediente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tipo_expediente_id_tipo_expediente_seq OWNED BY tipo_expediente.id_tipo_expediente;


--
-- TOC entry 199 (class 1259 OID 16502)
-- Name: tipo_marca; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tipo_marca (
    id_tipo_marca integer NOT NULL,
    descripcion character varying NOT NULL
);


ALTER TABLE tipo_marca OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 16508)
-- Name: tipo_marca_id_tipo_marca_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tipo_marca_id_tipo_marca_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tipo_marca_id_tipo_marca_seq OWNER TO postgres;

--
-- TOC entry 2397 (class 0 OID 0)
-- Dependencies: 200
-- Name: tipo_marca_id_tipo_marca_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tipo_marca_id_tipo_marca_seq OWNED BY tipo_marca.id_tipo_marca;


--
-- TOC entry 201 (class 1259 OID 16510)
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE usuario (
    id_usuario integer NOT NULL,
    id_rol integer NOT NULL,
    cuenta character varying NOT NULL,
    password character varying NOT NULL,
    estado character varying NOT NULL,
    asociado character varying
);


ALTER TABLE usuario OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 16516)
-- Name: usuario_id_usuario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE usuario_id_usuario_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE usuario_id_usuario_seq OWNER TO postgres;

--
-- TOC entry 2398 (class 0 OID 0)
-- Dependencies: 202
-- Name: usuario_id_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE usuario_id_usuario_seq OWNED BY usuario.id_usuario;


--
-- TOC entry 203 (class 1259 OID 16518)
-- Name: ventana; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ventana (
    id_ventana integer NOT NULL,
    nivel integer NOT NULL,
    id_ventana_superior integer,
    descripcion character varying NOT NULL,
    nombre character varying
);


ALTER TABLE ventana OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 16524)
-- Name: ventana_id_ventana_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE ventana_id_ventana_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ventana_id_ventana_seq OWNER TO postgres;

--
-- TOC entry 2399 (class 0 OID 0)
-- Dependencies: 204
-- Name: ventana_id_ventana_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE ventana_id_ventana_seq OWNED BY ventana.id_ventana;


--
-- TOC entry 2067 (class 2604 OID 16526)
-- Name: id_abogado; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY abogado ALTER COLUMN id_abogado SET DEFAULT nextval('abogado_id_abogado_seq'::regclass);


--
-- TOC entry 2068 (class 2604 OID 16527)
-- Name: id_cliente; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cliente ALTER COLUMN id_cliente SET DEFAULT nextval('cliente_id_cliente_seq'::regclass);


--
-- TOC entry 2071 (class 2604 OID 16528)
-- Name: id_documento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY documento ALTER COLUMN id_documento SET DEFAULT nextval('documento_id_documento_seq'::regclass);


--
-- TOC entry 2092 (class 2604 OID 17052)
-- Name: id_documento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY documento_oposicion_hecha ALTER COLUMN id_documento SET DEFAULT nextval('documento_oposicion_hecha_id_documento_seq'::regclass);


--
-- TOC entry 2072 (class 2604 OID 16529)
-- Name: id_estado; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY estado_marca ALTER COLUMN id_estado SET DEFAULT nextval('estado_marca_id_estado_seq'::regclass);


--
-- TOC entry 2085 (class 2604 OID 16797)
-- Name: id_estado; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY estado_oposicion ALTER COLUMN id_estado SET DEFAULT nextval('estado_oposicion_id_estado_seq'::regclass);


--
-- TOC entry 2073 (class 2604 OID 16530)
-- Name: id_evento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY evento ALTER COLUMN id_evento SET DEFAULT nextval('evento_id_evento_seq'::regclass);


--
-- TOC entry 2090 (class 2604 OID 17025)
-- Name: id_evento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY evento_oposicion_hecha ALTER COLUMN id_evento SET DEFAULT nextval('evento_oposicion_hecha_id_evento_seq'::regclass);


--
-- TOC entry 2074 (class 2604 OID 16531)
-- Name: id_expediente; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expediente ALTER COLUMN id_expediente SET DEFAULT nextval('expediente_id_expediente_seq'::regclass);


--
-- TOC entry 2094 (class 2604 OID 17120)
-- Name: id_factura; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY factura_cabecera ALTER COLUMN id_factura SET DEFAULT nextval('factura_id_factura_seq'::regclass);


--
-- TOC entry 2095 (class 2604 OID 17137)
-- Name: id_factura_detalle; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY factura_detalle ALTER COLUMN id_factura_detalle SET DEFAULT nextval('factura_detalle_id_factura_detalle_seq'::regclass);


--
-- TOC entry 2075 (class 2604 OID 16532)
-- Name: id_historial; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY historial ALTER COLUMN id_historial SET DEFAULT nextval('historial_id_historial_seq'::regclass);


--
-- TOC entry 2088 (class 2604 OID 16968)
-- Name: id_historial; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY historial_estado_marca ALTER COLUMN id_historial SET DEFAULT nextval('historial_estado_marca_id_historial_seq'::regclass);


--
-- TOC entry 2093 (class 2604 OID 17078)
-- Name: id_historial; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY historial_estado_oposicion_hecha ALTER COLUMN id_historial SET DEFAULT nextval('historial_estado_oposicion_hecha_id_historial_seq'::regclass);


--
-- TOC entry 2087 (class 2604 OID 16944)
-- Name: id_historial; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY historial_estado_oposicion_recibida ALTER COLUMN id_historial SET DEFAULT nextval('historial_estado_oposicion_recibida_id_historial_seq'::regclass);


--
-- TOC entry 2076 (class 2604 OID 16533)
-- Name: id_marca; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY marca ALTER COLUMN id_marca SET DEFAULT nextval('marca_id_marca_seq'::regclass);


--
-- TOC entry 2089 (class 2604 OID 16989)
-- Name: id_oposicion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY oposicion_hecha ALTER COLUMN id_oposicion SET DEFAULT nextval('oposicion_hecha_id_oposicion_seq'::regclass);


--
-- TOC entry 2086 (class 2604 OID 16923)
-- Name: id_oposicion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY oposicion_recibida ALTER COLUMN id_oposicion SET DEFAULT nextval('oposicion_recibida_id_oposicion_seq'::regclass);


--
-- TOC entry 2078 (class 2604 OID 16534)
-- Name: id_permiso; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY permiso ALTER COLUMN id_permiso SET DEFAULT nextval('permiso_id_permiso_seq'::regclass);


--
-- TOC entry 2079 (class 2604 OID 16535)
-- Name: id_rol; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rol ALTER COLUMN id_rol SET DEFAULT nextval('rol_id_rol_seq'::regclass);


--
-- TOC entry 2080 (class 2604 OID 16536)
-- Name: id_tipo_documento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipo_documento ALTER COLUMN id_tipo_documento SET DEFAULT nextval('tipo_documento_id_tipo_documento_seq'::regclass);


--
-- TOC entry 2091 (class 2604 OID 17041)
-- Name: id_tipo_documento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipo_documento_oposicion_hecha ALTER COLUMN id_tipo_documento SET DEFAULT nextval('tipo_doc_oposicion_hecha_id_tipo_doc_seq'::regclass);


--
-- TOC entry 2081 (class 2604 OID 16537)
-- Name: id_tipo_expediente; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipo_expediente ALTER COLUMN id_tipo_expediente SET DEFAULT nextval('tipo_expediente_id_tipo_expediente_seq'::regclass);


--
-- TOC entry 2082 (class 2604 OID 16538)
-- Name: id_tipo_marca; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipo_marca ALTER COLUMN id_tipo_marca SET DEFAULT nextval('tipo_marca_id_tipo_marca_seq'::regclass);


--
-- TOC entry 2083 (class 2604 OID 16539)
-- Name: id_usuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuario ALTER COLUMN id_usuario SET DEFAULT nextval('usuario_id_usuario_seq'::regclass);


--
-- TOC entry 2084 (class 2604 OID 16540)
-- Name: id_ventana; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ventana ALTER COLUMN id_ventana SET DEFAULT nextval('ventana_id_ventana_seq'::regclass);


--
-- TOC entry 2311 (class 0 OID 16394)
-- Dependencies: 173
-- Data for Name: abogado; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO abogado VALUES (19, 50, 'Abogado 1', 'Abogado 1', 'Abogado 1', 'Abogado 1', 5555, NULL, 'ACTIVO', 'Abogado@ab.com');
INSERT INTO abogado VALUES (20, 51, 'Abogado 2', 'Abogado 2', 'Abogado 2', 'Abogado 2', 4444444, NULL, 'ACTIVO', 'Abogado@ab.com');
INSERT INTO abogado VALUES (21, 52, 'Agente3', 'Agente3', 'Agente3', 'Agente3', 5454545, NULL, 'ACTIVO', 'Abogado@ab.com');


--
-- TOC entry 2400 (class 0 OID 0)
-- Dependencies: 174
-- Name: abogado_id_abogado_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('abogado_id_abogado_seq', 21, true);


--
-- TOC entry 2313 (class 0 OID 16402)
-- Dependencies: 175
-- Data for Name: clase; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO clase VALUES (1, 'Productos químicos para la industria, la ciencia y la fotografía, así como para la agricultura, la horticultura y la silvicultura; resinas artificiales en bruto, materias plásticas en bruto; abonos para el suelo; composiciones extintoras; preparaciones para templar y soldar metales; productos químicos para conservar alimentos; materias curtientes; adhesivos (pegamentos) para la industria.', 10);
INSERT INTO clase VALUES (2, 'Pinturas, barnices, lacas; productos contra la herrumbre y el deterioro de la madera; materias tintóreas; mordientes; resinas naturales en bruto; metales en hojas y en polvo para la pintura, la decoración, la imprenta y trabajos artísticos.', 10);
INSERT INTO clase VALUES (3, 'Preparaciones para blanquear y otras sustancias para lavar la ropa; preparaciones para limpiar, pulir, desengrasar y raspar; jabones; productos de perfumería, aceites esenciales, cosméticos, lociones capilares; dentífricos.', 10);
INSERT INTO clase VALUES (4, 'Aceites y grasas para uso industrial; lubricantes; composiciones para absorber, rociar y asentar el polvo; combustibles (incluida la gasolina para motores) y materiales de alumbrado; velas y mechas de iluminación.', 10);
INSERT INTO clase VALUES (5, 'Productos farmacéuticos, preparaciones para uso médico y veterinario; productos higiénicos y sanitarios para uso médico; alimentos y sustancias dietéticas para uso médico o veterinario, alimentos para bebés; complementos alimenticios para personas o animales; emplastos, material para apósitos; material para empastes e improntas dentales; desinfectantes; productos para eliminar animales dañinos; fungicidas, herbicidas.', 10);
INSERT INTO clase VALUES (6, 'Metales comunes y sus aleaciones; materiales de construcción metálicos; construcciones transportables metálicas; materiales metálicos para vías férreas; cables e hilos metálicos no eléctricos; artículos de cerrajería y ferretería metálicos; tubos y tuberías metálicos; cajas de caudales; minerales metalíferos.', 10);
INSERT INTO clase VALUES (7, 'Máquinas y máquinas herramientas; motores (excepto motores para vehículos terrestres); acoplamientos y elementos de transmisión (excepto para vehículos terrestres); instrumentos agrícolas que no sean accionados manualmente; incubadoras de huevos; distribuidores automáticos.', 10);
INSERT INTO clase VALUES (8, 'Herramientas e instrumentos de mano accionados manualmente; artículos de cuchillería, tenedores y cucharas; armas blancas; maquinillas de afeitar.', 10);
INSERT INTO clase VALUES (9, 'Aparatos e instrumentos científicos, náuticos, geodésicos, fotográficos, cinematográficos, ópticos, de pesaje, de medición, de señalización, de control (inspección), de salvamento y de enseñanza; aparatos e instrumentos de conducción, distribución, transformación, acumulación, regulación o control de la electricidad; aparatos de grabación, transmisión o reproducción de sonido o imágenes; soportes de registro magnéticos, discos acústicos; discos compactos, DVD y otros soportes de grabación digitales; mecanismos para aparatos de previo pago; cajas registradoras, máquinas de calcular, equipos de procesamiento de datos, ordenadores; software; extintores.', 10);
INSERT INTO clase VALUES (10, 'Aparatos e instrumentos quirúrgicos, médicos, odontológicos y veterinarios; miembros, ojos y dientes artificiales; artículos ortopédicos; material de sutura.', 10);
INSERT INTO clase VALUES (11, 'Aparatos de alumbrado, calefacción, producción de vapor, cocción, refrigeración, secado, ventilación y distribución de agua, así como instalaciones sanitarias.', 10);
INSERT INTO clase VALUES (12, 'Vehículos; aparatos de locomoción terrestre, aérea o acuática.', 10);
INSERT INTO clase VALUES (13, 'Armas de fuego; municiones y proyectiles; explosivos; fuegos artificiales.', 10);
INSERT INTO clase VALUES (14, 'Metales preciosos y sus aleaciones; artículos de joyería, bisutería, piedras preciosas; artículos de relojería e instrumentos cronométricos.', 10);
INSERT INTO clase VALUES (15, 'Instrumentos musicales.', 10);
INSERT INTO clase VALUES (16, 'Papel y cartón; productos de imprenta; material de encuadernación; fotografías; artículos de papelería; adhesivos (pegamentos) de papelería o para uso doméstico; material para artistas; pinceles; máquinas de escribir y artículos de oficina (excepto muebles); material de instrucción o material didáctico (excepto aparatos); materias plásticas para embalar; caracteres de imprenta; clichés de imprenta.', 10);
INSERT INTO clase VALUES (17, 'Caucho, gutapercha, goma, amianto y mica en bruto o semielaborados, así como sucedáneos de estos materiales; productos de materias plásticas semielaborados; materiales para calafatear, estopar y aislar; tubos flexibles no metálicos.', 10);
INSERT INTO clase VALUES (18, 'Cuero y cuero de imitación; pieles de animales; baúles y maletas; paraguas y sombrillas; bastones; fustas y artículos de guarnicionería.', 10);
INSERT INTO clase VALUES (19, 'Materiales de construcción no metálicos; tubos rígidos no metálicos para la construcción; asfalto, pez y betún; construcciones transportables no metálicas; monumentos no metálicos.', 10);
INSERT INTO clase VALUES (20, 'Muebles, espejos, marcos; hueso, cuerno, marfil, ballena o nácar, en bruto o semielaborados; conchas; espuma de mar; ámbar amarillo.', 10);
INSERT INTO clase VALUES (21, 'Utensilios y recipientes para uso doméstico y culinario; peines y esponjas; cepillos; materiales para fabricar cepillos; material de limpieza; lana de acero; vidrio en bruto o semielaborado (excepto el vidrio de construcción); artículos de cristalería, porcelana y loza.', 10);
INSERT INTO clase VALUES (22, 'Cuerdas y cordeles; redes; tiendas de campaña y lonas; velas de navegación; sacos y bolsas; materiales de acolchado y relleno (excepto el papel, el cartón, el caucho o las materias plásticas); materias textiles fibrosas en bruto.', 10);
INSERT INTO clase VALUES (23, 'Hilos para uso textil.', 10);
INSERT INTO clase VALUES (24, 'Tejidos y sustitutivos de tejidos; ropa de cama; ropa de mesa.', 10);
INSERT INTO clase VALUES (25, 'Prendas de vestir, calzado, artículos de sombrerería.', 10);
INSERT INTO clase VALUES (26, 'Encajes y bordados, cintas y cordones; botones, ganchos y ojetes, alfileres y agujas; flores artificiales.', 10);
INSERT INTO clase VALUES (27, 'Alfombras, felpudos, esteras, linóleo y otros revestimientos de suelos; tapices murales que no sean de materias textiles.', 10);
INSERT INTO clase VALUES (28, 'Juegos y juguetes; artículos de gimnasia y deporte; adornos para árboles de Navidad.', 10);
INSERT INTO clase VALUES (29, 'Carne, pescado, carne de ave y carne de caza; extractos de carne; frutas y verduras, hortalizas y legumbres en conserva, congeladas, secas y cocidas; jaleas, confituras, compotas; huevos; leche y productos lácteos; aceites y grasas comestibles.', 10);
INSERT INTO clase VALUES (30, 'Café, té, cacao y sucedáneos del café; arroz; tapioca y sagú; harinas y preparaciones a base de cereales; pan, productos de pastelería y confitería; helados; azúcar, miel, jarabe de melaza; levadura, polvos de hornear; sal; mostaza; vinagre, salsas (condimentos); especias; hielo.', 10);
INSERT INTO clase VALUES (31, 'Productos agrícolas, hortícolas y forestales; granos y semillas en bruto o sin procesar; frutas y verduras, hortalizas y legumbres frescas; plantas y flores naturales; animales vivos; alimentos para animales; malta.', 10);
INSERT INTO clase VALUES (32, 'Cervezas; aguas minerales y otras bebidas sin alcohol; bebidas a base de frutas y zumos de frutas; siropes y otras preparaciones para elaborar bebidas.', 10);
INSERT INTO clase VALUES (33, 'Bebidas alcohólicas (excepto cervezas).', 10);
INSERT INTO clase VALUES (34, 'Tabaco; artículos para fumadores; cerillas.', 10);
INSERT INTO clase VALUES (35, 'Publicidad; gestión de negocios comerciales; administración comercial; trabajos de oficina.', 10);
INSERT INTO clase VALUES (36, 'Servicios de seguros; operaciones financieras; operaciones monetarias; negocios inmobiliarios.', 10);
INSERT INTO clase VALUES (37, 'Servicios de construcción; servicios de reparación; servicios de instalación.', 10);
INSERT INTO clase VALUES (38, 'Telecomunicaciones.', 10);
INSERT INTO clase VALUES (39, 'Transporte; embalaje y almacenamiento de mercancías; organización de viajes.', 10);
INSERT INTO clase VALUES (40, 'Tratamiento de materiales.', 10);
INSERT INTO clase VALUES (41, 'Educación; formación; servicios de entretenimiento; actividades deportivas y culturales.', 10);
INSERT INTO clase VALUES (42, 'Servicios científicos y tecnológicos, así como servicios de investigación y diseño en estos ámbitos; servicios de análisis e investigación industriales; diseño y desarrollo de equipos informáticos y de software.', 10);
INSERT INTO clase VALUES (43, 'Servicios de restauración (alimentación); hospedaje temporal.', 10);
INSERT INTO clase VALUES (44, 'Servicios médicos; servicios veterinarios; tratamientos de higiene y de belleza para personas o animales; servicios de agricultura, horticultura y silvicultura.', 10);
INSERT INTO clase VALUES (45, 'Servicios jurídicos; servicios de seguridad para la protección de bienes y personas; servicios personales y sociales prestados por terceros para satisfacer necesidades individuales.', 10);


--
-- TOC entry 2314 (class 0 OID 16408)
-- Dependencies: 176
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cliente VALUES (40, 49, 'ACTIVO', NULL, NULL, 'Cliente Juridico 2', 'Cliente Juridico 2', NULL, '544', 'Cliente Juridico 2', 'J', 1, 'cliente@ab.com');
INSERT INTO cliente VALUES (39, 48, 'ACTIVO', NULL, NULL, 'direccion 1', 'telefono 1', NULL, '45454', 'Cliente Juridico 1', 'J', 1, 'cliente@ab.com');


--
-- TOC entry 2401 (class 0 OID 0)
-- Dependencies: 177
-- Name: cliente_id_cliente_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('cliente_id_cliente_seq', 40, true);


--
-- TOC entry 2316 (class 0 OID 16418)
-- Dependencies: 178
-- Data for Name: documento; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO documento VALUES (34, 47, 7, 'sdf', '2018-11-08 00:00:00', '\x255044462d312e320a25c7ec8fa20a362030206f626a0a3c3c2f4c656e6774682037203020522f46696c746572202f466c6174654465636f64653e3e0a73747265616d0a789ced5bcb6edb4614ddeb2bb86bb2f064de8fee52c708541871122be89a95189781242a145db45fd545817e5fef3c45528c6d1806422b4c36c90c753873e7dc3be7de1962446886eddff88fe566f675f6ea23cf6ef6b3af9946ccfe713ded7f2f37d92f0b788ce08c28448910d9e2f38cb83e9211c69192325392218e79b6d8cc5eccdf2d3ebe5c7c99718ca831f0d862357b71f5e6d3f9f9dc364b85386119478c4b235ce77fb6fd8c222ab2b376fbd53bdb410de286d200f4fad2b5298499e1a1edf2e2dddb4faf7fbdb03d86c1fc8c0c3defdd482845582a1d877279f5d6b65e2cb20f3091722631ce24a532634a1904132404690e43af8bd9e787988665c40d9bb64da330328a67520b64a4769671f32408536174760616531c5337a6f976552e0bdb0d703223f05b6c8885631419013fbf9cbd20e8e54f332211135a85b9ccb70e92202645b4465357ae512219cdb0ba5d2e4bf776aa91e03a9aa2723f673054157f4ddd5a70ce90540c0609af97caf7a000db7aff795ee7cba6a8dd7a438f1271c1c35c619114094dffee9b7299effd2bc1ce6995de16dba2ced785efe204196adac3019b98b64dce38ac3f15323bb32b2bc2e8881b1f15082b1cc777f1a71b06455a250655ebdb680c0aa4555d63108180d471c87f94fbc6cf442149d2b4ab1a2612cc69709c867bbf465c4b697a4d4a4975ff530f6b9ab026ac012cde6e02ba0a2d227cf069202b96a4eb3474c869f65f6f8b4d1e7c5a7012a16fbc9f4607962cbad4ca852e0882e2e03a4d9dffee7d4422cc5968fd520587e424858a627bfcebf775b5ae6edc9b20625149c760e209ebc928c9022515ec6e3c50d2044eb2014ece37bb75b1f14c01524ad88322cff265596dfdde015b87a65a1eb192b3015ec17645689f5723b6e684354a2673cf640c4289f614090b9a0444b25611f57a7e7edddc7aba82681174909a5a1c51732cb698b04e10abcb6971e0b4227d4ed3014eff363f3bd057dac7313b1de34c58cf16eb8ec02d6d533fdd86cc9723ce4427f3f582a49bf91ee86eeb1c4445d1f1b77b14126a9312cbc2296602f97e52d23bc89b57e58d17d992202592f20daa05b68054df58e701a0f518bcffa6ce3779486525ec3520a94367486515a4b769c097ee39b0005387fcff26e4b144836763d3b3cc40d2dddde2d860d27d5d6e83f0d26d99f657e9f37b82e8217318158546318809eb94b1ee8b47b0e93284c13d7a5e36202417c19f85e111d5b938064f9682c5fdb7a837e5b6f27a5320450c1f831d26ac09eb4eac6ffa0608cb76b9c03ac780228ddba3e3bd15a4fc01b47f2eb699b04e03abcb711d386e932ed18fffec98e2e7d5767fbb6e3cc505447d9544a895974e97c1f33c69ad2023292284c6dd215f36a53b2381d7296c546af6b2123427a3b8272b052254f4e46aa778bb6b3b9f80e113d2f7bee7b24463c5b2abc8486c22d8718719052c388e8ffc983c1f8bfd6d28a7c202818418df1427ac09eb41b4e74077294837640e1d6c5d171b1fd50c32e99420f7410d24f6e19241138f77993dd2fefe96792ecb33619d0656cfcd886d3bae9431036adcf84a99bda2028ffa9da65f292b56e04f2b9f834a060fa7aa90ed2bfed996a19309054a3dca0d22c27bfb7528f88fbd40d3dae5f86021ea755d361bd76ca79dce0007b3e4e4f290231f9a27979fb04e15eb2e8ff70740564f0acedb1b2b1fae455ded1c88adf8ca54f6aec1e7eb70300f89bb4e39439efcd23a5b0a06dff2cb2a5e19635a8a11186ec2fa8e58dd02eab758cb615fe8b176b048d4de998440ec90c33e8ea304098c1fc7d1e7b50c13d693c55a7960ada247aa66a0f0d3a96d0a8e54524c8f232df4b044da7b2fe361a91e703365bc4bf12360dd4537e5e86673666e4437480e5e06f57c6088c834c20676f6fcd575be2e57fe005b224de89395f8c66bd709eb14b17a0ea2938348d28fc7435753cf43591cb261912af00d84cc9fddb30cc9c35dbe7015c4ca8414899755dd1421c8d394a48ec73c13d68475e796420fa70f02bca2b3a50c5e817d634b3ee18489494474fa1460e81b1c77a3ca2066848922655757bbb258e52b9f5d4a8ca4991ce7c7c6ba8ba02411f448f30cde67fdb4f7d21802bde6a9a0b10ad1db7efa921a5df4f608f67bc7348c8b2fc566b70ef76e1492fae808f4b91b7cc27a3ad141ddf730ee8bd40fb3ff0122ccaff6656e6473747265616d0a656e646f626a0a372030206f626a0a313538300a656e646f626a0a32332030206f626a0a3c3c2f4c656e677468203234203020522f46696c746572202f466c6174654465636f64653e3e0a73747265616d0a789cb55b4993dcd691bef7afe8f065a40836fcf6e548d1b483b634a249cef8d2177415ba1b5255a104a034a60efe4b3e3882bf6ff2e1e5cb04aaaa37076d45381868e02db97cf9e552a292ea52a4ffca3f56db8b5f2e7eb90c954eff9b1ecdffbdda5e7ef7e9e2f71fa4be94a6d2c6a9cb4fb71772fa9bbcf4ead25b5119632e3f6d2fbe91d5b79f7eba50a172de5a78e1d3fae29b77bbf40cbeb5524b7c36f6ddf4a2acb4731e1fae0fab55fb253dd7ae72c19797bb69013841bc94a28a22ca74822b2964a58cbabcd2aa0a767af36ddeca57caaab26a338c0dee15432c6baea7fda5ac8230e5d9eab06da605b4a8acf7ae9c35bfaa2be3acc667c3b4a454555432e0b3bea937ed6ff5b480a9e05a06ff70d8d5e5b29a8e75d337bf4e4f45e524ed352d0bd253da467cd4eef2331f247d8ce203992ae3c389f894a9828a6e213e692b054be0b37a83e787efcb9d36cdeeee908f2f2be36dd9eca70645156d2c875a37b8bf7324d27ddfddf5f5b6c643585d6965e4238778df779beeeed5b4a307158ab2fa2abf7d65b4ae64349757207c6b4d96503979002195c56ff0199884a4538f6d117088825e9dde0483b5aec8e7f6b05bd7a8790386278bde469492afbc527279730b8b92356fbb61eceb7e5a4055c2d06eab4912a00d636471876edba18ea28b76694f067c92f539e942baca0ada9d6fef65d9645f0f794557296d5843433e2a2853c4604f1660f181b857cd3e9b3908c03b1d1fb9ec33d40c8a0b950068981467b26f6eb26757029c806471d7ae6a440c25b4c2c7d7d7fb435fff0e91c00bd208f8f261ddd6d9794d042b65c9149409d11c490b9cdcd365c7669b77f495e31deb1dbe29a352f466df763de28108a1d8cbf439ecadc9c30e3bd494a4933ee14c60aade9e38d3ece8cf73262b482dd7d7097f7e37e1afb69589aa1c8540d100a616c9dc36abb17b95952543154d38ef65313e171fe084823c38bb362a50baa08eed5c3955ec7c7f68d05261bb20cae3c979e1225613ea347df95a919faf8a3fc57409491aa973cc00c89cc50ca520ae7064f8fbd8ec068c382a81ee12328f230e88d0196d975a73959004819b1a45e184d32fd064421d5ee4514789f0398933b9c9ab727b4f91a829ab0a1596be700540042288e8998016592bec3c82d0af5d97180d0fddb1ad0a2dcad2bf1c9a7c084015a58ab2ea75b3cdd10894c8d1a81e08c1747864d17d7ae4801e0882ae7edb8e6d8f060ea13c1e4978fa9355096dfd232bd7ab43d3238424c7664bca5248b0424743470023889101b7afd7ed5dc611d0a7918fec8626015217e105269121148c6dee950f5ac6abe295ba68afddadba7e9fc1abbcd9d7783f6dc979999b7847521b00f99aa23a2642140d6661b6d9348534a90a3c95aca7cb7a0e950cce9249b4abb6dbd59b66faa3b51058290caf0e9fd16ab5250cee32d63ae31cc9e785c11ebeb696bece3b27b032a6e8b8bbed9b55c616402b10faa3c2b96f7ad05d8b7cc15736d042638daa8bc066ec22fa916958fd428c97fc01381a5e5271a4189a1a250d9cb7887f5af04a00244f4e8ed719db0d5a400c1c0a889e1b7d64b449c69a8df60bba8256e493f56a04f39b82ce95f401420cb035c0016133b2fca119f6070428e588854c2ba5d301a3d6c79a715684638bd3f118dad326409c99edacfa36db3bac102958a36c815e7a17c2b16ce70941d9ca08cf621830748264cbd957e0fdab91cc253a17e6b7829c445aca13fe3524f90ce55c8e20faaed9357d71846445ec641b54a7d1248727d984f31424afbfc989c5646b84e6dde650920395ae782a0a96f07d3b8c5ff0e270e2b259d717a4b9324a2760585878338079664c34c063ad3dbaea747aa0d24eaaa5c80da0c02c31ac6f6a64b3c21431fed4957b4ae2a62555027c2a0bb6db3dc1910170d18404639d8007a50d96a31c9300b82d2118903242b066b8fe36c7350397250a5a3825d0d2b27a0d11612cac1458b82244d0198192e9d3b933874571044101f3dcca909b4c887995c52e2cd8d0321f2a48046af592b96bc959a5a5b045e2d6818073c6d3267361d560f6007e0ba9b03d3ea2b624dafda1f0cb604f7366e9fd63fbff0ac22fea06ec3bb18cd9ab1448235fe939080a79d66c9147b915987b90a7dc6aaa86142dddd4036a5aa77c8be23cc1e8f92393b8de4f47467d26b45366e1467499b37e9a9246f295efbf648e14663e3abf8ba3f4e60fcd3f776dce278dae145fb22454f94f9007e8d3844af38eac7f23cf245490f23d9d5055e86a36d0121f0f084236f05673720e0a73e440ddee151a5c8c04321c1a2583095569808e9fafd200d5288ebd6d40103b7cae24f3e0b28865256e30d003994e2fcefdf1eb956b24c7e373ec61830ccb01ff149c94ecba6dbb030b9dfe789cffb8944f91ccf63df22311d5a2000578e704d16b206d8533f919bbcf3b004314e9ea2f5b7132c772c465920522f59124f72a5b385002522029d57bcf4a1d0edb062115f671c7363ce33664c396b9cd1180cfc283c9dc06727d701b8ddc66facb7f7718a79df2a7651c4b21a0bec1fd6695c6ae5fd7d98a2193d182be3f4d7aba92f2ce4a501b2a4886c801ae988d5144f830c34f052c4da09493b208890f890f690e6cc2c72e0e05898ba76febcddd6197f506a9930fa785a2a8c4b181c2ee9e985f3decd16aa5a09a4caa450c08b5ced3111e3da9d3acfc0d965281af1af2e7f30854b212cd4762c6150d5de861c6950d22a567dac70574bfcf4c537218aefbc2cd958e9c55a0ac98466718ee8a015bc2ba87459072ed7094f06b087576965da4ca26c0fe7ab22a7031638ef4b5f860c10520eb38aad928e0358165beea12f3c881c3020d8ea2dc0ff2e8e1b019b11e9aea89f6c822207bb7147e87f6eed0120133d61ce90af0cd93a036ed4d8fa602ac4ad219afcbdaa0183561f11c93c73eaf954a19d270d9a0dd36b81ab045eb0818878cc1104c049759796b2d20322b756cfad213c6408ef0a5200f6738943640a80c54fa7d49c0188183679f365387a4e0dc0324b0cfb6024f2d5f9b2365d4c7a008f23754a5389f436ec63617dc00b9a463c2d7d7634d77a3759f707708e1c69e7177ef17c63e65d4101516de962d0f0c95ed0b4b86d242024828f05b0a55d7df4e6efbf6d3e55f2fe4657b91d2391d5cbc8423c03ff3fff7cdc5ed731a61cba2e0656e8445b0477f691c44496da75ed8f715fa98e0bae847b0804dbbbb43049582d2b67ab746b500dc96ebbf2d4b58ae767dbcaff76ddf55e7e23b903b0874e5eb4ff705c2832186f83a8354508eb2ab7e44a474ec68dd2d1a84b6045cef7b7ccf7034e92818cdc8c1ddb9c00e4441063a5b958f219ca1c0cec78d922ab13fbcfb8414297256fd1efc7928352fc515ea37f516ed5d7011e8a66fd7774d09b62150b6f8433d0cd52be4978a6bc703605b5606847d91a8d932cf5db7638b1c14cc5233cb96311a36b3c9c42cdcee6b9b984ae5083599d8dfaa3f56c5913ca1c71bd4094004a3c72ad3303b73979f879650433b7364883211505ab2fa98370239787af58766b36987fbf3a6084a08b37ec019d3c9de2a24b755ef903f0aaba830536fb7c561801a2a82a7b6c43ccda5f3ff8085fac016fa1142c6eeaee9affe773a3a7e89a0d66feabb528b07df2adf7c37397c313fcb5de1dbeed08ff768662a95ef971d98979899fafa66a623b816e82f99d9bb0c43100eb917f31d00fecf687b5252d5e43c2e251c094aff5b5a8283433c315fd99094e51a0b726c48a403657d6761b2fde7aa9d15b2e842ef76630ea0e0492a52ecd9b477cd6ef23be5928711db7ba6f101ab82b4b0acf67abd6e81985cfd6dba6d2a61386e8b6e9acf05ea5d2c8682c953cac5caba1f9a7a0d4278859c4780cc180dafd01813115e12a8a15e153ee249d5f759ecc0d769d4e33034e388c86c52d59e08cd7ddbafd15a542036f1b0912b38dad2c84114feab1bb99d08c464e41f2abca20b24f31fffeb2f4d73db9c0738b8baa0285382171840a080f9a6186bd0d43ea86fc7426bb53c89b68098ffc1681bac73f1e4c04684e3680b59a45667a32de47ccf8eb62e9d92a2edeb524b0dbc34409940e12ec78baeb4053a0219ef95499d42976de2cc70d19b5935de46e0b954c2c46abc07a65d2c76568d37602a0c0d7f9a57e37fff418385a4a29dc541a394eba5324fe209d6e259b279e61a5291dfdb5f3117b09a606356794f2307743eacf384344253ec8d2aefa9e5c42de4a9f27e4ecb5732955d5daa4b00d681e9647dcdf2381d2de74898e9c2e256091a7fe96b04a9548c7ca245f38aee47b6fbfe43c97fb8dbf063aaca6eebe4db1306816b7b7794aca6dc86da72dffff8a7161293eb6f273dcaf918cc6dce5764eab4a9932abc5224e89ccfe1bdd9099f1c6bb2da1da5c526a9f9255d3a93fa7d45ce37a5ba0bc7307259dd2db5e3d452e0591d928888a7652ac1f23f693c9fd6d645e00221759e39523def328e8ff160c13c5b3f64c204321f9bd35b3cd291c1d128355f38c77ba7b95bf260454ccd52e8acf95cc386a4ca139e9d9b21f9ad7cee79fa07f7e5226c227aab76df627520a622dd72a660aa008164970d7aaac942be6de7aba73849abff635a009c4b3a4dd52eacabc90817206e02f114337b9d3a8d144ecb9c89702450762b776a0281e9ceffecda522d9bd50a9a7e289522e036da1d37fd17cbfe50f70350ffd24ff092047efdcd1f912a1aa6270960da1a9b69299327377e50bb3a1972211554d9a447cd2f87dcec4d5d424be410ed2748b69f75dbb77738c9326dfdb465cdf77e5d488175a4bd37dd66db94068ead52d968eee27ddd1cfa7cd5542b36748db14d8d875d3e0b609cf6f4b754bfde8ca5a66e21b828cb35cb52179977b0212260312a811ae5b4f5be287c5e6ca69513c7d2146d1e914070d404475e04f81ec989fe5268080f4bfe5fa618d646ba55bd197e6e914f78e9380e9109ba794d726e82a192562c1d4ea64e03058cb7eb768b4bab407e7173e8ef3aacf54cca1110e6e60efafab0c3fa579a835274499cfd81c828b8ebbe6a1b105d161ce89931640d89c0a42f9c630929e1e3c99b366509182b01f4b40c5c2bbc69a97908fcec086eea0d42a503a546aa458fa558eb39c1a9d1cd240fadd1f0d92c0fda9531e75911fc1c28a2dc530f2f1a0e2aa530ee2409651183205988a917b87080cf78344e44ca61b5b72787353c16d50c40ce4a674ece1ae390763509422681fa2a4a7b621a613e71457d074139d733470340788a87c75aac5e026e9859fbb1bd21ed8a0466d46da2d95abed39343935252658fba47c29963f60351c171bef7f73de0482abf77590b214df42c53b6bec45767b918ba6f79d239a52fc4f6c64cd9530eece938dd4d5f66009ca5bac588535511127ab2eb5270528e070e0b6cc301c86b0f7db7af11898ca1f2503119ab447ce4f33fd7fb32972228bcd208e56cefebf2794c7382443ccb2f0180c67b4292a7cbdce04ee4a8c59455d04789c672ec072d615602238b57dabf848ec1c5ecd9d9504a244acf1f7225401b7bc4388ba1050636009bcde1734e3442eaced1f8c029aacce66b2d4f46a57e29cd8790a3ae48694653597fc4d99fd44974fab4e9e624c1d01edb1e099c88807c3e0357abb1b068e1e4c978a29dfd74a45f37a91b8e0d20c055c7f599731f00b128bd1fcbd305c8b74c8ad954629a72c6f283952446e621340fce0b9fdb8c3ba4c69a53ba4860f1185f9c7e24e1f5b246dd9d50ce33e5df7b1a139e176a6a0c9f699292abc734430eb9527915f4663104035b381911f25e3f1304d3249f3f02c164e281afda6f696ac38a34b8acc83c8bba14bfcf67e0eaddaaebc108f6185d66238cdd84a4783839fbd90ffdc4c7cf12601c8c4b051852d86e9d7b9de97b4769c2bb8f3f56281ec0e75341b2d7d1b4a5e6e3d6abf140534231252bcb44a3e588ad1d4d062c527fcf090eb57003a7e1f7351aa432ea8806c9690af6d141fc321d0e77060f3c992575dc5a9cfdfa4990e6cf0cd112db216620e5497aebccec873843ddc37d37e5c72081532e7e9fcf317454799bcd0d9da3ad39eaa521013ef023d3af280688908b7006012e1a2a969ebb01403fce7aa711b3a34a419d7e92338717cd284d3fffe09f41ec71d420f1614dc48b2ccb70858efbbf8e27d5c8eb24538f87e84ff95c9f19e08f7ca26d16828e1ca91e0cb57b2cbda5945ad00120f4ecdb4d46ef5ccb86dc2e3e35f28217f1ccc1609da6cf9c7c32e534383633798c6fb0b691f2cc8548982df2a1ac2fbbcc2c405a63dfde945a9f814fb9e3dded7212e593df035b4e855448f0d29f54fac354e4feebc5ff03d194c4c4656e6473747265616d0a656e646f626a0a32342030206f626a0a343533360a656e646f626a0a33332030206f626a0a3c3c2f4c656e677468203334203020522f46696c746572202f466c6174654465636f64653e3e0a73747265616d0a789c955a4b8fdb4612becfaf180458c4092c4ebf1fbe04d8c087057cd804b3a79d3d70247a4c831265521ac4f9535e6001ffbead665757f3a5d1c4be0c28aabbabeaabafbeaa162bb8b865e17ffa63bbbff972f3e5d61532fc1b1e8dffdeee6fff7e7f73f7bb64b79c175e6b7e7bfff1860f9ff15b2b6ead668552eaf67e7ff34614a2f8e9fef38d5485d4c2c02bf7bb9b37effb2fe76a5f860fb42d98e01e3f78aa0e555736e103650ae398c50f765578c65dc1acc647a7ae7c1c9690700a2b1d3efedc0e6f6a383197f8ac3a2cbefdcfae6ddaa7f0f8ee77d89eb3c2333f58b211821760d446f882791b0f3c1c89ab823993ce5a6523942cbc316e6984b485d64a4c8d5085968acfad10a6604a4e8d108512ca4f8d987c3b5b010e369676aa7afcbeb5361dab8a3604db44daa7af9fce755c58c2665aa55355efc2b38d18a260075f687071f88c0f01e5be908ecefbbedf76f563dd0dce608593369dfa7cc070585afcd8b54f5d899e0b3e16e9d8cdf7e124059352a440b54ff576f086b0b06eb6f0a23786e36db8e643b437dc16221efcd7763f2c24596154f24a5fa157bce4e9d9a712d796cca4b59febfe148fa121a476760c59186ff9d4d1b08bd5921cba4f5156cca46f9707dc9c671f9caaae6ebbb709d8ccc8a92755e1396d3571a52b205caf73a529bcb733b0c0668ab9c566cca5cdb6ede1737c0e0753369f98c0ea653aecb7437d4a513382bc88193071d7473ca91404d5b6db63c22acf126cce4d391c74a39884ed21b23224d78bd6967d74a4069ea20d216d87930580d0c3aefa6ff539c643fa4218621e8c261099a3508027a27102d0cbd301b7f53ee5122bb4737aea1f55f09ce03b5c16885579ffd2c1fae4326d283abbba3f62125aa5d3d7db43fc3a2bacf1e9d5725b75db12198279699607d0ce67383d3615c1c90416c765c2235f3888a5208ff56df38c3196d2a695ab2e66a0820ce060db1027a56386864f6cc13981a7edd039c2c86472d3a2c94c324aa03211c988124fed10de90e256f0297481b8f28ae33c81eac4189f25302cabc50aabeac28cdeed4f6537204dc0d91c71113ac743c8d3c93e0284cb5d8bc5c10847e4171e99421aa65ff0c0f95022be38339690d0d515529003344e736a62c1b59c224ec19c027ba4bf461d987ed24b282b66927f80dc21124205df52c579ae779410c291754086f1b1705016b4a3c76f31722a93e161871e0ff651aa11185c28dad3ec814a6ee861b92b8f10b498441079e929db306a9040444f4d99caa6b3b944268a67d6537d2cffa87b843eb32e03e488e7d28c6a6cb50dcfdcc098c9d4c1245e08aea942fcef5b4c530885317a99a6428a74f2a63a3c9d93f4515627807cae8888597af7e14d0ca61786087fd89d85eaa689b003b6717b2efc947c2095e12950ca389577d5a96ca2c3204b2cf7e9c8fbefd1b1cc11f62272e0cbd2914a2ac1b492d8d210ca4fd5c34f4961f8fcfa0a730c2185f8d1ce0815e01d2928bd082a3c0b85b207aaeea31a50405edaa7b7ebc3b639d78897bbdf851d2b4315b25e53391cbe5d2820086260c035a0ad6efb3561a921b2c99c77f10569a7cad303df00bb6dc025415c8537ff86c55941754d6aab41d6e38662df7f477740200852fbc7367229683296bcb4b2e0b1abb655e411054b189ddcd1444b80879c1359074ccc345028a49fa9d4c9d9329b39cff914848c01c970f2fff95053b59282447db366dda12a2321811e107222f5ee7e5e9ee243b6259fe22fdbf20cef4638079f2aca944b27ec93315291a2d81febeacf884b50a9ca116182ae581e31dab281ea5070ed26b4fb75194a908ffbfaf0eac57fbe8b6a195c0891982478fc680ee2c1c7fef6fe4374e88f83dca03d529d1dac06bc7b2e1265928e119ec4c9f15ca502117a337ab71ab513f08975c492fb6a57236b40c1e4591ed0ea8a286d7b2e9b2fd0de7498e6cad2c6b0ca29d65d687b4065ccda4c5db05c144ed51fa7167524f4689c12a93c1f52dd53e069c64d06558be5cd5bd24b132e3513573f47ec283dc25e8734ca19f15b990a891909eafe781ef60a929eead33ac3bf45e304e0393d843a76c21080719e744af45095914e9df3852257974d7c5b02cd1b31abca40e626a3ee63b9ad9b1a255df01d58342dc1a14b75720c87d3b98bba34b465d24f032643ef32177b1184a107ce561d96af8fbb46e9a0d042851927d9bf0e5418890456e2f527aeccad179373b78856902f8ba6d8cccffc16f3167a79ff622c4fa955b09ccd5a05011c46ccb9ab1e9344d6ce5e07979719f92032ba5d999a7a95d39c9a6fb09f5fb4e9db16abb1ceddeda7aa6b51287246bae92185dd1482114a20efaa435f7f475081fdb9d3c1fd7ddeff53f9081889631788a380108b49921dcb0820d8dae93c7288c41f442727cd30a731e9b89a9b7e710ae3e44b53988787b5ca0f58529298a2383617a897e782f303caa40d08336830c28c06fa4611312b566634ff80d25ac76806eecc239af5c1509f461640c0ced207976cfd1a0105028f6af9b6ec9e703f70a12217be3012428bac0d2ec382ee87377e3d97875dd232701c39c7bc97d41ed783a543aca195e77e9176ced350636c286856a9a68646da0f533cf9ca7cf479ed7d4c29ebb82029046f4618ca70e49cff83fa58690b2588795af0582645225416cc498603b0bd93d9cb259e486aaa6f31d285030f4f9a81592b82ca2a509e92b9aa45fd005d7d763561075a96eb43452a8000d331c50eddf2a95d15c528ea406ffcb201b9f1821e09a566d023521225d6875d1294d04b0b1afbe56671f4724e04e9d713c1b351513a7dc70849aa8dd853729e4974bd5c7609cda177b236b9881a509e4f10fbcf298c4e5d9a290945d4b23b6fb7912d03c50962f6963a20cb5e813720bb8cb70e71ed0239504949fd87f69415e7fe1c5434fa4958391b4f00611a5ab76c9e109e1be9a1d5d1720207405a7f6e4e910d5460e69c95e1d1a40d445607aee359c7ad9887f27cd42d4661387c916e262e8ce3238d81c52c1f25e783e47e363735a1fb5d1dd2fa4209bd2e10bc180de2aae7bac4294998918f460f342561d6659025f5c129350fd0d3f529268b56365cbba4dd72273bf26a44b2619e7c8364beb82f51cc86be78526c299546adc9353de09820d7761de6cdd007e628423a576904cd2dcd1c4fa47cf27654a941b82c325c2976a1d4313fad00055600a308eb1fd21513b02d8d332e8ef2b10e0141a6d352cdb24c4f5a21344ce551cfa730bfc515007b33d93bb16d874a068ab025961a9835cded58a1a6d27607a6477a01b84b3f1a6ff578ff03610e04be8152204c0ced660d4fd0be31435763f5014c3fa6fe4a320a6c754abc374711741f9a2b338d93007ae3723d8d9c20427a61a6ca885a43e7d8e2899cd4591fd380cdeb2c20562877f8eef5391ad85d45380268b26e5adde7f220af48352363fc7d9ad085094d1e0ab7cd39b1be09809a69641dc4db4c900200f254b9411e76e052399dd65f9ee481f4cb443356de2a74e5347120cd169a784bc3e43ea1773c2bbe584ec3388f1309852b0a5282a1a914797484bce897d41bdb2a583a376c5f716d93f52156df2056490b95a9a642e4b8a1c1749b360324f117ccba7053443551d9cc797168b091162220a6f3f587875413bb1f06534249a04a946f3c84bdd67c1558ceb9be3c59cd25d518ea79bbaa6cea3fcbaea11e15e444f2dc6389e0946c511d9dceb78aa77a580321a1d4fcce14c822cf7a209182788bb1d62c3863994d2a477444e48bc9aa34617e3f1d70a14bd7d8284c3cb84ac87a1bf9c5b8cc70685e9851bf7cc37e68f7e807916bf863977ecee0989b8ffa6d9886bb2b61c49a2914356059d10aaf16138151073a8cc4aaa4ce89df62b776612e0d2a1520bd11e1b67078fb970d9e75341a457f3ebcf971fbee2e16cfbb6377ae1e4b68687fc47675a11ed21ac3e270f04981b5dcbebac08268a7f2911a6fed7370c0eee7248e1535bf6553a5483293af6c93df74ee34d38084e55bbed99c7294927dbd3f36e99a2bdc388a95b5736d23e448f95ae418ee97c819ddaf5c410e1b5585c3f2cd13ee032525bb1064d936f92adf217eaa36584124c079aae44f55bf8aa814ebd4d54d81f4ef5500fd671d3fc3e593c29fa8787159a24035669edcb37a7b73ac9b4bfa048a87d514068a9757ea823ed15c5fd527e1229528702c50b4f04b81c298cdf4339c7517d7d126dcf8db051abc77d7af0c93d2108e06dbf46b27cd6981edf7e830a714272b76f5538bd9a71c75bc74b8088ba0d59c9fc0220fc61455ca17af0d7309e9f01ca046f36f1c8ef52e9dc3c8658b2f728dce0d80cdbfe6b8621a54f33c4e58118651f281bd6f31185250d58c7704a8065d6ef0da8fe1ca0de301b55810080e2d4dd1f344300ecc77e5ae4a234900c3f2a750f959937e93c3b29d781048545e98d96d2e292d6332ab1ccf5d89ea470576900bf5a3e47cf80ccc927f5cd555dfa0d4a40e8ad124e84399aa87536e8a9ab41f84230783b613b9db4937352e3f3ba7e9189362adf90ef7ff793abf7ee041e40c0786a5397bc5cf364cde2ca77018a3a8594682e38170b89ea4c244e40441bb6c192682e00591331dd4467f56d7d5cd7ac9e761e20f7ddbb82caf17fd619bbf56f4b902011a7f61e970be2bc37befef6f7fbbf9ede6ff76783ef7656e6473747265616d0a656e646f626a0a33342030206f626a0a333335300a656e646f626a0a34302030206f626a0a3c3c2f4c656e677468203431203020522f46696c746572202f466c6174654465636f64653e3e0a73747265616d0a789cb55b4b8fdcc611beefaf58e464031aaadf0f5d02c75000038e63cbf24d17ee2c2551e10c579c19c1f69ff221807e5faa5f55cd8746ab24b60043207bd8d5f5f8eaabaa166bb8b865e14ff9cbfe70f3fee6fdad6b64f82f3eaaffbe3fdcfeede5cdd317dcdf72d678e6f9edcbd7373cbee3b7de37c2de5acd1aa5d4edcbc3cd57cf8f5fbf7c77c36dc3b9b5b0e6e5fdcd57fb4b3bbcbff4ddd486775a348a719ddfdd7771bd6ab4543c3f1bc6537c681ac5192ecc0f3d6cc565f9727b1a4f4fc27309c2b9b2e11037e202841065e9d49d1e2edde91c5f29db78eb4986210bad8d71f9e1a93f9dbb435c2d5de32c7e08be928496bc515ee3fa6eca1f615289d5e994e4eb8348fce8b97f880f656384f6f9e1787a161eeea4760dbfdd09d97863e39b5d786e1a2f8cf1286ffc006b0cc70f9cbaac072551ceb76d16c97a812275e76e7f6eefc7a81bb0a9334595edf026af1724d8c728166b24d34a95879764790dd6c5b376d33446b508d348e30cca7acca765d6aba282f855d8474a512cd3eecffd7ecccae6b22ced8e5926ee68ab64435866d03d1ea6f1cdd41edae8219a37d64a7f65f9dce45ab2f2e2c7691cc6a807a9203644316ff26710cc9a22f187fe149f0ade38ee575ece49e9dd308cc9bc8e375ebadb1de8432b1d5f1ebafbbe3de61d054749ce5d569ce5287656bc69ac466d1cba639203e2424a56047ed735d9484ea23572c8828f310c590894e4a6c2c267e7f1161f3bf045d4c3dbf66efa88a7c6306cb347328b7bbdbf74799d7018ef1f921a95961e5d7ff8900fea2543b34fe5f0527f7a0bd0dcb98d2ba5687475a42107836662e9205100f88ac3233db409ad76d202964993aca35552c3384ddd9b3e6ea2e0679295cd2be8228c8b51d0c5171234af855a688335c2a336f663b127a3a83df7ddb1cb8164344af95b78e41bb025bada172a533456cd94e9434c1ab4f7f4a69d86317acd4e0805882c401506946808892cf8184724c2e8d4def2ca71a2f8c173fdd5934eedd48f09d3256ca7e5dc7e3c80f476c4021cd6689f51d61a5bbe3d1eef8b1299c70f6731c00a4cb1b2945208edf6d00ee0e8f1c5d317d2d609510634c7d3fe968cbdca9ae049ca97454f1286db4a73e40f52e3c7fae37dbf6fb33f73cdedb5c55b4aaa9d1c7289681cbcaac106d304d7669526c0d978ed0d2949c07921fec965211e20811c92e9b5852d78f1d173f93a6841d67eeb008f15c27f969c35ce7f029005e110c0d3c7ecd2d2cedcd735ca5853f61ee003c5ef2057793464b2a208d906058523f47729a8c1f3a4aa23f27419ce6d34aa0a2653454d853a402e56e8c297d325f87093d15d358155d4e9fb8731d190e72f6f7f022ed5df3860515a8259b887108313010fb0b0c9d4ddbcfeafc919178075f6d6280db93792b367993618b233fab9825c5a9247b13d04bcaf2db68095292b9cb02b19051296c6e8fa376ec0ac42ade50d207daf499fe5984db30324c5031a509e9da564ef30c38dafc18cc90d65e073128d8258a371cf8c540c900a21f53c4ec7e43280aba0d295c800ec8bc0daf7f1dc1a9c46a02a46a443f483447bc0ef1d17258ccf408b81e5448496c092942b474cec4081c88ecff3cffd58c81ae4136fb55d0a59d18c1c9331c77055db6945e04e85822aa47f9fe12102c2cfcb950599c67414b87f4e7dc00d1885f60635ad6d075eca0cf1f98d2fb7fb7d3f1ed3b715a08b430670f898139943e46fcbd958cd84effa73142ff143b02df0e96bae3175590c23308080c6a58f87f8a68fa7b802eb49f0183383db08a3d9c38c597a18d0498e0ef3c77e2dc5db6eca1ccc430d67903eb7e87014b509fc42e2a73c8ae017563a81f628e58b01e7b9eeaf0f5317fc2f0a01a589608e90f25062074811fff21de1030ffd801f072f083e9fdebdfaea384e8776a02c2324550fdd93ac70a86c81e5d7e1f2ead556ca0e91293153fcbd1fbaa7df26a06f9a662b7d3b1db852d9f02fc9c7b8947a86910135c849bf60eb70f0ee715bbffaba10b210c290cc814f2b80eff0523699f740e22926ffa6004cb080447a5ee8b494a6980a8b388bbbd5f4016a43469e78df9d329f029625b152270ec2e47626778ecf4bab741cc8408d0572bc0b95b848c7f9e5d8e6e072ee4abdd0fd9ecfe23ca6022248c046387a5d39b4520bae0387a6c8abb88e822251f12fe13ab211048b9878a4e0cbcc91804734c68945612a020ddfd25e209afef33c08a0456b43fb752108d3797400cb656cee204b01bada59e0d48c48852a08933502b2b658accf691298903a40d461b1c251be893429fb0450ef82bd5337b42523022907452c511c6a7344f6a22fe164c578ef86ac30e5008a362a2e45dac15ce49573a4b17397cb052c90a0aac8b59408258fc5643195b2da93603f8647a10f46ed82a46aa8b40121f0b7a50da018fc7cc1ccefda13d4b21f31c656a535149386d41fd771800a8ed9e9b49f8a0943a54a240f8a8a92ee295fbccda90c3cde1bb9b46bf156ae2411b43717284db17364b4231f2921692c39f256e3a7fdb52f4d056eac40d11fb252ab82bddb67ce69852867dc229d7fec0bc10720330b2ff4a1258289ba3bbeb9b499a028e252ef524209c99ec9392b8024c30382cf4c85c7d50e759cb603fa66f1545bc21ebb22ac3286842d94a702a55984018e72b92c4442e295d4138cb8d164fa2cd136cf87a25a8d8b5f87e49a0803d02909e8714592d0482d36034bac5ca508289037a4670e80dde0f22d65a4555c284b6d0224159e48458120c05f8bd0173d26b41a31198da7fe2e13d09df43c144f0b88ab79a486a425fd1ab51ed317cefc2b848e58d5be5650ed8a845185462bf58fcb526bc9a8e716561f731682721959fd158a2be9032d1c21d377160e41242e1308031937620e65dc59711a0a53a054e2cf284c95075eeaa830051114f542be1f0b1431b3f0e7e45daa6184435539189c1ab9d5e9d20db9a200c98973f547c8e30f4931c553a64488028fe76e4e889ebe103302174b004b25166a1ed378c4a910d00cdb5dedb13f1d4aba3396919573300acfc8f51e2ea571ce0c529a526a06462f90a18dc72dce182611029333355e016231f9afc2a59b0e7d725a8816113eb0e81401dc4fd99fbc253e53da7bc1a567ddf100d5c66cadc3a4909133f0452236efbafd251f1670d93acc97237617a977705f0ce0ab7e428e076075dead28ca939caf2c751402a40154ec535912de09ace61e2e65ace53466fddc218f7ad6fa8a28e06a676cdea20b76c72da15115ec31aac8350f035e65e696eacefb26331d4848c5ad7ebe149da0f3bcbe1c03feb5873e096480065540510a4849d390bb8fc96d98d6c4c24e794e138ee8ab31c21ad4b6cb834823e211454395ceb97b8650e4e164d200e307ee057f4dffff1f714846375490ef7c40bfc3bc56a5b274bb1b90f142d4556d570aa8aa8a4f411fdb5d08f78931cd6b8ead0e40048212f62a0820b1d585b51af7b4fc2efb24382f5a21e78aaa2028bc30659d300e75d415dba840800e872e742e2058231411c9bc1e92b6120ba44eb8b46e95d3af418bfb6e0bbe76606b60bcf36c4da3856a5abc31ecfd42e225e706987d1e21e3d9d6617606341d06933bb0034b09f4afbb6c026e904dc6636e96f6bbb2b0fac237f944c00eaa96f5b92f532db69a9f43d2f39571bb6c11a05a0a9d3057ac8b465e1ab58010907bd7dc4a39be5ddec582ad38332517b9aaaa80ff4b5f1602db1afadce253b1def4575647e42bf58f0cd8abcbc7db52540b86cf30f42a555c09bdf8dbf9a07e070516a08a9f21e9d5087c9215ed355aea309ec0dab924d2a100e105b02fc7321bf6ae4af5a7874b864eeffdac451bda3b464b2af7b392b4f12bf620059e7a3c4fd835610ac1744c38e09dc013dc672aca42af5faecccf3d322ce0a187f61e6720c2e0f268d4dfcb3ba0d09ce390ea131dc463bb4bfa861877cacd623cbb295432a6aa1171882491376c90fd32d3346689662c8ce3b7bb519c0ab6aa1b25c3450ee46ed78a79ced4ac2c5f5c08c88f2a93b5c7df73ea005066623137059b69b622048aa47f844382177bec01c42642dc0e825662fbaf4c5f3df04e49446738e1f07c4d4b2a29cedd7e2813720d68a66641f3e2f9cb5f5efcd0e410700e19d8cb6434afc97fda438ed16adc74d7affd66332230dd3222a3784107dc85eadb74b49cf020673bdc0c3388a1bb2078bc25e243946a8ff0f9760bd221c40060b17f5a310a869dc2f1eedc1d13d50cb35489f39a0d17faed729fbe107a6a98524ee3dd54baaf8c70835a73551bfa1e1cbe3f969873e0757a66ae3346bca79a6a7cc856070cc16c88a572e069167b44b001cedb155d603ac6e2bbc9a7b4d4acc26b624a2156c414b7bf0ced941a4d32d86375a54b49f3181b498538b1591d01ba384d365a41091542215f1a64a4ed5d80f6638a111d7c763d7b77b29ebd676b40158b9dba0e2f4348371fffa40ca4e6ace76ac03733820c05bdfcff136419a88999f3e3300995d524808698368ceed09d71c8a0aecd07ae52644e6c6cf342dd232872f589ad46cbe5dc871416c5075199b357649d71e1a5eb851e284d378ee327f96decc6a24eb6c9a59420b9d09f239779976d7a19a61706ce53df3ff864360bd5a2c5fe57a12b225c96a48c1e1b8545ddb10e9f372202f40864659fee54e920d8a2d5759fc74c4b8c8bd7d8c4e2ae880cd7a6d083ba3d35583420a5160b8e1c2630faf14e333b057d825872d573328d325acc1c2c8e7e815acc7076eaf66328b4d331c3ecc8a362872ea503b081d74a2d1dd0693ceabe2d9d714e73e8adfae67c49b305483dd6a2f65c32889214a5d4e9f40c1169e8efa6f273c717dd6088548b3fff76282867145a3977c07495c8fe95fbffe08a9cac99c7a656d2bdb37f74c3d09fde66822648b7fb1e6f3e8459be5d70a74035f4aa3054066377938f4e057c04497f7fd967e708482796ed27c8e5b4115dd400e05b5c144c35536a29d986426513045bbcaa41ccf7d262794d8c65ab509dbad7ddd41df77d99d44a4f97a7a9935d955cd767b239f719abd603d5eabae2169c76a7730e506690f96dd2b7640d4596cf480c39365f9f0a0d25c5d388db8bb8466d8cb87f861a642a34cb6c9cfb111dfc7a16ed20e242f1133be35c7db60870060bba138a2241297c3d4d3094f5171718a5deb481d5180044e63d38045b90f97887d16f0dff64c8fa1b7729adde4c6ba1fda9945c8b2efc635a3c7014faf5db76386fa5a6c0a41d617a8960c3ccbab5436256ad9d996745e8c342acb476768a89d0605df0a975f4002e07a7fb4497a7acadbd612b1387a3e6342c8140f1707d25a761156e3a411a96e1da4acae5a2499735c2a572a2c6df1d1e868e6e17784db70bdaf9a4caa8458603626fd7139175c7c9f0c0f321a6c087f23dde6ff3900d68bd95cb7f40a002d42e6e4b402aacef2c976b667ed63dcede148618f4cf2dc0d13ef4e5fe84f2b3517057ea57464cfcd7e068e5469fa7dbd38735945fb6ee4b618bc352dbabaf94ac74b8bd223794ac647dad8c1a9de07c98243f393e2e0868519bc924e59e928e13b7791576ed0a9756d544fed04d00f479b0197804af2ee3e671691c32ad88b3ad9a0b7da92075752324d48a001b1762789ee6efb9de001d48bab2f27df1084ef3e83fe70ea9e4eb3ba4d581ead1aaa6c60addefa0460730cd87ac6f25c24d7584f401f7facc351b607153363ca7db08dffdfccf6461c102eb7231ca1c007ecc5ce14d2cd67ebaf90f0a75d7ae656e6473747265616d0a656e646f626a0a34312030206f626a0a343132340a656e646f626a0a34342030206f626a0a3c3c2f4c656e677468203435203020522f46696c746572202f466c6174654465636f64653e3e0a73747265616d0a789cad5bc98ee4c611bdf757347492806e4eee8b7c921b923186602d33827de80bbb8a1a71504b8b455a1a1dfc4b3a18d0f739921919c1ad7b66048f2e02c9ca2596f75e44668b4aaa6b91fe2bffb33b5efd7cf5f375a874fa373e9afeffee78fdd7d7572fbe97f15a8a2a8a28af5fff7825c777f2daab6b6f45658cb97e7dbcfaf4f1b3d76faf5ca59db0f0faf5feead373971e495599884f0ee7f189ac94091a9ffd3c34e3c358191d257d78191fdacac23f7cf8d89ddf74f5b11e5f595559e50cbefab63b1fce6fd273adab20a37a6ef04b83ab884a057cf6a639355d731a4788952c8bdbe74f75e5bc283faf7743d3edcff8a92f9feece279c4a6a5986ddb7bb3280222bfc94ad602ae5694dcda5ff03bfd4be6cb83eedebd1865a54c24a5fecb0b6f46891ca9be8cac45d1e4e545a091e6f63e2b7cd6ee8eb2e1be5d608b0abd0d7b7b0106b6cfea4fccc6a537eb61beac3cf43db74353ac30869e74683ef8d9eec2fbb54b9ca5b558c76692f7d031eadc6c9a50895829fdc2a05fb8de3175fe6c9435a95e7c1c66915f8dad04eea4bfbe654f7032ec9a4798a39ee3f7d87f124140f73c267514dfdd0e0d08a87de97b80d62628123c68ba8acf765a6fe7cff19ae38dab0083953494f21f7efec34695d2c8f6af49971d62d1f79531e0d7d7b687fc3c880691c85e6a1c618b282e2b23d3e1e1a5caa8118d1a2bce9eb5d9ba3c4439ae9f218e3d8417e910176e763d3eddafa308e12ab6003a7c86d8e1c0dc685654f23e7743eb6a77a9f1d22213e4d8991fbfb572fef5ef5c3050714818c9073f9939bf18da99c265b3cd6d9b710435a7bb5da74e4641cf2529501f02100d9faf287efff7e371a12e22508cedbcb2366b337369265726c48f006a77883e61292cc359cf23a55e5822ae1766877cd096c38ee4b40a0134a6d0d71571f1f879c17c655d1dbb2e02fb2b50d2c22a54ada8d3533048271b42dcbebdb136e5ac8829603393e4ed0e65cd24147bb885bf8b162db34975dd73e20d842f016f78cdf86ca4b4d167be89a31cc95a89ca41c29e108deb18a2022271ed045748643b42cca307ef6e7e2464f414b790bc8113d2d3fc34b41756518ac8fe3202ac006e8f373df9d4bf23b63de37480ed4314eb5afa28971eecf14518e210452a13d67e701929859a2ac217df4cf2dc0b7b086763e3c40109df38c801c5a30e462aa8d133809a842d67ef5cf97b779a96334019dbb299d03eaaa4ac3a66e61135aa90cbbf0a89239fa66a837cd5a70b598db02c79fc985db28121c2940f5987cb31a46418a919926446e81a628c99b4b614747003a9470d7264c80eab13d801d4674b490399a7813dd920ce7b7e7836c5d02de0df29b60e75eea0e7e75606307a39ee1e60e571e7519a23960a44be18a015f9e2e7ddb0f39b6134edb503e7f3534bb2c3712f0cc830c601742d8845934ddb523d014f3466957d4ac635c9006c8214fa87807661c881fd2f66d285b249c1092cc783f7af4feb39bc2498a922179a4eedb87c338b50545e7e94d514c60c030b78d0460f293e47e5e1c794f4e7ef9ea9bdb4962da08d24d6fcc6809c07f846d1eda7dbd6f8ab08c22a80d2bbb3083db7df3085a034d04806ea35664a21bd400caba324f0662489a20295cfaa6fbb1fe0d77e1a25c8849804de1fcca344e90803a34a737434dc141b67d4b1a571018dfdda0f3418b4ef44e37ec7ade08a40cc09359fa5a69c2e96391af41d3def6c3a1ee6e70194e900c7d00bfb7e7bed9a16837404dc4179b9b3ce42f93fc109443bccaf1e5ad8e0eac55b486890bd9c932755f17d909c82d7db1ce71dc6a521d346f4d001368573fd50f9092f5a1b9dc60ec4a1b694dfd0e552be801059bcaaa3573f470c2cac324e566b7d0133e3666038660fd205ce7fc0b3ac287b2aac7a1c95b0553eb4078305c723a0079591653fbb66b767d8d840bb10de44ed2800697c4a3f750def4edbf516545605d4eb7333eb59a69b784a411448b585194849749153218745d93a5156c74529a9c4ffb16e53490d7444ed31a798277a88074e50165a629091500d424b852e02765c8f4b4d26079a517f0526676109a5a845935981564627661174a0d62df1365f55dfd5064292ff2ed1917ee1ded9e0aa910ec260109e978a6a4b2900ec0865c5e3d17bc5e722dd18148ab0b24271d1b166538146d8e3cf981a34234013302f4a27b6f7530a9069ed58be57731e83089ce3cad4e29c6c5f4f829a8e148e54ddf1599ee58c662b164ac266219179c0492b31319b89e7a8fae07e4f58a5cb107db66fa001749b3d208de0816a6bf228a24bdeb8838fef68f1f105abc76c53b5f1eebdd05dd190d7d7bcf2f001224d7779bc62ac28670744356f44d414f902d96965a4653cc9eb3ad72f9fbf4566f50a5fab4b1598295160c7adfa969f5f92e4710a06f5ce90d083ed21b2d5405e3d2211104c53ba86c08d8a1f0a981b4535c92163e05b02d5642844d06e00d4cc1d1b0f9cf0f7d4ae90ca7000c20385749395d628d0922b8cefde1fbafb3bc05034ee46dc2c34095dc4f7dfff8f98b17bffcf24bd5247f57e76e5314cb24c14805dc7f5621a4a94a293b4ba66fd31b0fe4a5ca1c58048331b424d9d31c0eb92e50b3bed894708098fd16ec984a46d2d9ed69771846474269643c4ddae465c4c8b51d194e582eb8068c3fcb4b7b8f678b26714ecec37fd4e3e5d9ef3b040a1b694d3f3554ae01c8ae207ab2acf74a2f29edba8f0702a4c40f67b549d1c659bd1512f009fb36c7c1560ca4a122094d04ea1c037eae344ba4279a95849c8f85d0b83a3b77d818039faa60e6f6741554a3cf8ab8337e07f250cead69a1c6a0670028e84b956627bea0f6c3e4f748f6a991cb4e6f4a27490146723f8ada3bf0d41230ccbbbe294d6963d4c09b2c6e5a94872a482abaf200216507e574ae2a2a05055279f4df1ce8de71a545cd020809b660bddb359733c684b1b48bacb84aa10f4617f3e20c881d110ab82b126f704de8e226720367f85534a6660d715a9df11730dbad80cc7bdaf4aeeeded4445c7ae96819698b64fa2c7f3d880326eeb25ecfeb9d774aaca629e7ba3788b8a97eb421a7bfc36c1794d61b9b43b001ecb0c4dfc79a58d1130b61331010339845df2e5776decef22df72b539b80dcf36ed8d719a4cbf3a9dcbf602a2a4ba9b8155a37790f4a93962b8d4228610d55271b5aa7f90dad1d9c61a8bef475e942189786e5187ceed8c105f37e60bc41bd23fd2242939e67d5f8348ccce66150e6674fe8e65cc5c8d97e986ac266270aa82dea4d6a83ba751641e06c15ff8f4a130a2a19964a33d135998393f8d6005e2ebb085366f18a7e7569bad2f2308cb09804c2d316c82900409c86631584b861ac21c77e3e2e236a201e07c20ea6149072e95deef5a57e702057bc3c01ce638f25599200715c73ce86f442a5e61e249700b138be3e14abcab0a1b72180604b9bc44a16a7ba570b2a3dda7139284d2c7d7a84a173d2a721249f6e9421945d97ab42db27ca5501614b1bbdbfdfe277080ea30998bae194a55ef36bb345f32e2d96da7cf95823f57002ad74786877258d418a08ca700e7b06bdad2d5c8607cc192f350b6ae0a17c3403357f95fad9531a026fb4a5a0170c5b1fb2e3878c1a2b4d0b61cf47669f60a8463f5166253dace53666a64b5c4c3a098adc9cda3878dc0af84925c03fa610f2de7343077f2c5945be5be77b493328d32305df1c6c4199ae826ab2a21cee3945540011a046be484dc7f45a6d64db5dd7d4dd8bf4c39c726e4425eaee14a9e3299d0b3b17bb0572fda4db7f2b938e77f3047d3d8e0f228b0f5af09c656699be00798c76a5d1527f8ebbe569ed9899f0eda28ef595a16a2bb7a15233827ad2433e224a7d7c4b739f510078abddc67e6d22cc69b3fe8c8a4af209daf6523719abfd7d473817f9bc7063fd4f2fe2a9384a9b30d4dc687e4d1aa960b3e776628f7204525449354b553e3ce625a77eca1f18f42092f4624663a88346879ec653c89e376a0794f43eb5b6c24ad21be657eea74445ac79e46e44a4eef1f61916a988b0e812d8541896599818009f02cdf321f8f4557b685e7cf3882d4f4025aeb2d2abaa2ae76033f802e81592cea711a7c16a9154ecf9666dc9fa0072e95463cb743c5f27e395ae2bd43352312ddd148dc0b6cf3e1a9d1f8c5a1cea1e112b04b77900814bbf3ea7f7aa9c56ca2eb417c089a082b86f76d8688722c0485506befbe61fafbf4722129118ea9baf6fff851f074954f4f4c75f55c8f43ec6c2f4af5a743c881722b803c62bc442f9f9296f382bf81249d83102ab85284a64e7839b7e02ca62d9384fed5eaad657cd673ee5c0620052b78ab3dce3330acb12910f1e0565c5b30d0a9076fc74050166111a2ed1d8dc42506a38392717fcbdb07caa71be80a2cdb0a07d42fb856e748a098d8a276bdcf2786c7e81a039b5fbd2b905d4265d4bc7805131e416c4543c2af0e6a1fe4b8955a9e46a804056dcd59762314530b2bd2cd8699b3312dc06d41ae64de8f718235d349ab26b29c3341fe56e9561a7b593fbfa542e234547f8b175b96787b2c2f3b5b3ad2ab1681410dc8b4647ba86b63eb655d62f84d0fbafbbfdf92b64683cc58c36de06693b34b41161218c4051f30a3f8affe74e2ad43b628b857d3b3a93ff1a8f2a52f3593cebacaedee76f75ea938639468e173374980370b98ae8a6f4f0117457fafbb00aeaf77e00897d0949be45532af50048037e92cde405a3f2bbfc28c20fec47cc9798f14fcd77ff69394d8a92ca1c3ec515821cfd0c959d4f74f8aead98b76892f0e19b6833e68a9a3c82c0916e0ab147a05e0477e70b797a6cd497f0fa11aa0ec4e0b12fea9f5bf8542e91e6a43503fca406f45cb3f1d1316e4b327491300511ca11cfca5fa75282ae5b945395e0c89f6f86bac3cb0f265dac627534e1e4c47084ab85c0d35d09be94f93481bf429b25e78755036852e8bc9f32b4707ce24405a023387e8a38f14824951fcaccaa27bd553da5a66687fed48e4aa10fa89be2fc90231d7b08c70d32ee81c05eb4322b63c8e56dd6f1e3003a9a5ecc0ab238de31981564a88d208cfc521bc1b62da5d5b322c3a6ae0e35bb1edaa6cb055c3ac1e60604b1ae0d5eaea63204d48f54fc043bb9dc8a09a9837eb6726c809be9728ea312ae6f1bbc42e9d3fd0d5644103197ac67c1cac24d6e5c6274495eed87a059f578d802b3458ba2e879e9ac7ec6eaef393d9215d0feaa8d6e7dd8e854de82e14042fbf911dfb4090ef372595b48662262a7bd7f1be7a5e68cbeff53d80850d9945f9fea7d8b7563021f024a1488d131aed7437fce9702743a62e612b36f77a5b231e962caf23e492a34b45e0c6c156d8bce24228bfe87baebca99440ceb1b7b864b978fa6de745943ac47e49d3e6152bec42bf8f713fd521eb17e01c698359bf3f9cfa2e1fba42c29a616a4601e8aa5241ffbbda5cbaf13a55382d6c9f82165d43277004a230bbaa7af72ea91b9cb4a26a79252305e3e717e7c5396a8c2028a1696c80e026c8cd4473a837d2ee57699e1e3bb42d63e1dea6d9135f7360a59eb74b5970658cb6000cdf684c220dd7a960c69175c183039fd450a32f9ad11807f8b833e48dfcb70404e373e69d90fa0e93b0c036d89369fa9b391a675ea66d1fd4c148021f245bbf1526c871342c6ae8e0f8ca2045ff2a3500c481f7d7babc2747364b32f0e9895b365943f221036d3fd2461dee4da4226caa0d3bbc5df9fa43b4acb4baeb60a7c2fb8811a348750baf2cdc17e2a67de86bfbde47b0ae9749e6c8a57a680d5ddf290c28053785da30ef903a1ccf3e5cbd29903cdb2303e682ce5b68c6fd30131df803e6dedaa8c20fd860849a709dcbabdb427ba2e41ed774e622768d87adf64e457e9de3d85115ebe34891dc3568712c290755dfdd015aad15b2d4ae9c8fd8cb42ab80da45d578a4ba44de371d87d6ce50e31c7c79c8575653a75094b433b21b7d4de489d5ba7dd7a7a196271374198b51734f742b6c0e9d8f668d4d43a72f3b23c19c192b7baa6e6bf128a5508740df1501c2962faf3bae5df908ca07541d0d2dcc7f938b0cc899ffea02b1daeeb749c9b67b0e9c597afafbfbbfaeeea7fd7848e61656e6473747265616d0a656e646f626a0a34352030206f626a0a343336370a656e646f626a0a34382030206f626a0a3c3c2f4c656e677468203439203020522f46696c746572202f466c6174654465636f64653e3e0a73747265616d0a789c9d5a4d8fdcc611bdefaf18e464233b547f37db97c05104448063d9d606bee8c2e5502b0a33e498c3b1ac1cf2977c30a0df976a76553539c35d4bb1006341f6f447d5ab57afaa290aa93622fea33feac3cd2f37bf6cca42c7ffa647f3bfebc3e6ef7737cf7e926123451144909bbbb737727a27375e6dbc158531667377b8f9eaeeebbbf737ae08d699f8ebbbddcd57d5213e93a650ca047c76dfc66765e14ba93c3efb141f89420b6735fdb6e9f0b7d66849cf4ed3335578ef4b7c764ccb6a272c3ee94fedfdbe898f35cc69a4a1ddd475b36b86e905acef2c4dbb6b4ebb69bc0a85d73ccf8b43554f0b6a5378e568c16a1f9f3dfb09763f378a2aa454b4f9537b1a9b4335fd3814ca7b5e090f65ca40cfaa8fe75d95a65cda59ab42cbf2eaa7168e84cf5ebf7cfe7a3c4f7b34b0be55f4e287a1dff70fdfc4175b6dc029e023f8a310524eefb7f18d2f820f7cac668fb6558a7d70484e50a25081cd38396b1bbd650d7bf53cfd18c0202499efcd9b7428bdb09305bc68a770cc3f9bfdf1d9bfaaee5ced4fcffe3ef41f4ee994704c1d6867f87e3aa58d7ea3153eb4e3bb697f65e184a7fdbdecdef66be654aa289da5517f8943c0dd21b84781d40c87766c1001ceaa352085c2784766af6852c18ff67dc2ac879063d31c2ab6ab0f342b9c31e11b8e23d485dfb7464ad89ade6ca58688b0e917a77335b43d025a69effe1c2bc5349b875725a0720b46b1b2cc9828c15cce9157f7d38160458873c2447f4c1e2a4ac173d7eda704a8d2bb92dcd6a7007631d2e5176202cd60436996b381199df58cf266d7d65572d1a5bbad8459bd9abb1bde7aabc9486fbe7afeeafbbb9f265801dc14b3ccabefb6cf279baa42785eec6f6fbe46a302490536748a1a8871c90fbf346ac0b1aa2468d46c36a12d99726c7e1bcf8977c0d16590e10bec99b8609560809843292f4da42d9928c11436288352bc975302a4883b59e0b16ec76ad7a3e95ce0edf76f87a64e7114a7326a1e2eb690005c3a3e71a18a898469f3d4df0f0d6122133ac5962b8ce4a03d2650ecd23bab81e416ef9adfbb165f3ab1f4e575d024db15683c3737de56050f11e980577d44cf341e18bb50d370b30890d73fbfdc3eee872d0d86390b0189e1fa27168c2d24e746ca8310ab64e473f2952d44ce97757f38b67bb0c5c455d6164edb8b7ca28b32233fafa7a3ddd8e779ace614b3eb0f6d97c807b69fe9f79a46d7a17fbf6feb1e31a13356762da600f0b4a619fe4b3348a70d8dec106bca1641333d35898840207000b487e3bec1a08c09240f26b82a5348c12188ca63715a644219131cfdfadf5dbb4da1101310a4ab792cfc9ab06d005f74e46638b5bb6a87512c5cb8a2ebe0386f7c7b000531ecaac3ed644f8827c1ea22bab51a49e458172368491fc03d469617a95d46199021347ec2636a4f27afba5d35904f0c87dfcbd7afa6492157f0421f53aa2b2181b9ecba23b2a137964edd77acc6e2ef7953c76aa8d07daa644a8039c6b6430600d319f6d409512132b08efb6aacdef6c39609c90b6424c8f329d1a684078b08c582e235d95b647b1fcfcd8e284ac0a168f7f763d3b1669ce57596a7b33918242edb79d702f7617e04391aa4cb8659e3ee29bf789af1dd381ebf79f6ecc3870fc5e943bb3d263aea87551a91a001e16ffc6991e2509579c5ef2aa408936df1084e3f11b19a2cabe9c4b3fdb11321816627fedc763b0a6d5332bb7cc0c411f912fcb3c81c7d771a2b241e6b9dbe8c0c09a9f492e89c61cbaf534c870c13c39340fa7b8d69cee694f6ae19d2b818f2253d6dde37f579ac28caa27660e3fe726e10e965c91b6be319120662c5e0f845751efb032140398e6388e1ba22628208f7b3848f04af95e588a52816a1bca8330a9c016ced362a8a1c08cab95d20cb0b01a96afeeec529ad02be036ae154cb2b3bcda9656cf7ed7f2a8ce120f4a53605150ce1b588bcaa3e037da5f400c6bed23701f28bbf22289b4ba8e604464e2594d1911969f0430c4814433eaea72ec1324be0e350dd93a0101c94ef7b3ca4c97569ae372fd33f3ad4413ae0954ef5d08e743a67b2b2ff947851947c38642ee0d932d790c3d0de57a42bf426d63b061256140350f341420331101dea93af744138f65cfdccc401308e66aafc48d92b6428ef513c2bc935420cdd5dfb902cec0390ed851252306b60b58cdc069955302261070f43055572a28b729201b42626220052c9f9e53bb48ef339b3f60f1004abaa4883dfa306de02e8cac413cffb03118bcf547722792282220bbf63ae331c87bf42b4f40806c814b4535085bfb61c87e0bb5c938dcd2da971cb454cf35b8cba0e0128a4a3d153b763d9d938afd10dca56489399e9d2b90007a56694407591862a5f386938ea1ecb915c6a066dec655094d90ec7a5df40236bc598efbb6bc3ed13794149027c34f7db2d897a4fe74066044e00a6d07ac1096b7e4a877938277bc25620c5667a39126e2dd7c34db76b1bcc2fc6c5fe4e1e4e302f4bc94cda1e7151a7b22649308498b99260333325b4baa2cc4d18062b84a2348c2024c854ba9858d1881599232d07e4d000e84e88a100352d27c93109b078886c24e647d84a16815d8f1126729959b78716a78daccbb49b703f59815d8512ce4b11caa509c17b905ea10c9ce7e84353575d7b4a40855a420b75053291a5c1ae39f427a05f02998c132db54fd412593d3d992511ed80b39c0e9b0728e40a9466a5e75affc59ece2a4bee643480b18a3449aeeadf63bfa9d09ac72e585f09ae23726acc06bbaf4e24800cfb3c6bc36c8e3d72dc45d770a1157f18703350c1c939546d6419a6dd8701738ccda228473320d364fe49869e345709879e4723c31bc8621ed4a8b375e03d5489d7c0c4dc32fdc75446aff236b0762959c9409d71deb5141ab037af2f243424f75c2823d2052cc69ea64e2af8df49cec1ebbd89a1ed875b142a523186d67a7b3dc69935e1a27a026686ea874e50b7cd80e547ac8a2dcbe99549ebf3bead8658e535a754b80177cd4e5231b966e131921801c198751dd9669e8c26870124672c5cd5313a5058c361622db714d60792c0c6b2954f4d0a3470b352e1c96e4f9cfd1667b092c722cd4f3daed9b47892597b1ef81d5434e656388e0d768eaa29dbba0bf32f7b5fd91432b74a11ecd1533e172828a8b4d8c462d75a6cd4c02e45145410041eb09a04952c30c2b555b481d7b8169885d964ac20dd23ce970d200b2e53c62dba36715eb9d200ba4b21649cbbbcf4504ef8dcd8190e6dd7d3724b390415888dbc305feedb3d8956c5a9ac7dc0566154079acf914b96e0c35515ab54f959690fc2459557825bc99025737bc07ad945a4d2ae5e0dbba6bbc5e7c2f01cb9872702d3d098e446508eb7bf7a4594ad052a5c5b6eeeaf1d6bc1eaa0b1ae581df43787fcbe3ab5bfd72920a2c8c8c9254f9dcf3c0ed8b8076f392ea36363fa2175de803774ee1b25e4c20496f3e11fd5e99bb5fc00c4ad0b6f9632aa4e34609c90399f42e9d9616bf68a90011e9e05e1edda3ac0ac56b0eefc15282cd6bdebb359e066b6eac7b5d9a2b2ca718eced486cd4bc8f7da1abbe24b396fb4ac9df6703c435e598f9328e02defef91d6ad14d3d587a0aa6232dfb4102840c97cf08841b7342acd11aef135af1549e022965c26d71d17024673aa5a17ac2b35e45ab95be793c4307339c93409602fee363fdec84d7b130121a36e8490863fd3ff87e6e6ed675c075f68984dba0e0ef1a2730311174bc4e946f8fb447aca082e2da921218d98356a9031d4d48c2e1767be6a72452ee7aaa948ea08ca64cecadcd600031ad6798f9701b0bf59db953bdd3ed77b4f1915b94b65094537984528ed4503a543ad6a4bc1b5676ea009173ebf3c8002367027fc69596135d70cdd9562596f9c813f92f5e1bca5e5cc82dcb72866471a3ab5e15d4ee549776c7500648179e704f6e5db80fa37df6e0e0ddd94c6fbfddcffc17a66ce3d2b1f0724c47833ebbe0f98f4e3bded6c0df0187f2c10b823fc48038b2a75480c3944d7ee4a9b5812f55d3ac0c407acbf86763ca029bdb5176cb9cc7c932e4b77b9ca3b506626dde58a44465b4ce12293faacf9cb85ca53382385155b6cbcee5addf678cb2bf60a79adba1f062a4d55bca0e4a528012b6daffabef3ee3a9260c419df0cfd3f5092a0b83e0bd110d75632f8e94cb3ea2f37fcf3d6bb9e6d17859a95e609dbed1a28d8b197095920e4c67f75dfd295ef16c4701155f63c86de246c4f5be75c93d4466c263aeeaf35ef9bc3714ff774a0d6e9ece216a94eaa409b972bcfb65aa5a1b10b65f8b1d5e196984b72dc37639deec9e3d71682e9b73a77a83fa7525d3149e11742b13ae1f8fec22f846c6173ab9d5b4c337a9cae76987b1ddf54fe39cbc62f104c79bd9ce0ea7c1cb0f8d21e1c6b967780f7d589bfe800052619213891cc4180406830a61d4403940a305bac4f67dfec0010dc2ca611a840307caff6e5110194a9382266e40adac65c363f2621b66258c8fd467dbe6161b80b9f93be62e7e3d2e11096ca65633e1d6eb1bf6157c20d6261768ff55434c116b45f89a6ad767262efb9cb6581b132c95b32ea1602caa4b8886d399b730957e7523f5994fd39ab947970f3db11cf1edcacafdb74758b878f5fb67cc6d163c7f7fae0e0d2e0582383fe7ce1526107a7d4ac83a2c853cd5ff5f4cac00105334ffc70a1d9aa375fa74219541f67d717a95fa5cba8b02f6e94d63e26bcceef2b4a195225f7d1839bdde2dc63869bb797074c6752e4c48c092e772a809ef1a7e5fca7982172b1756ac16ae9d315a85045fe846c459890c973ef7e4f126ef665e1a1c12a29d694f92c7c29eab9089e3e3488f709b9ae9e559e34df1f0f788fa5268b3fd19cc11e9e8a619a3fc1a12f2862b755e47e3075e26dbeb73b9e3bb61973fdd8a38811f1a2c86eb65602efa74b2f17df4c05cb8f37ff03282d30cd656e6473747265616d0a656e646f626a0a34392030206f626a0a333534360a656e646f626a0a35322030206f626a0a3c3c2f4c656e677468203533203020522f46696c746572202f466c6174654465636f64653e3e0a73747265616d0a789cb55bdb8ee3c6117d9faf10f2b2bbc888eefbc56f89b10f0136892f9bc04626587028ce980b8992296a91f14ff921c07e5faad9d5d5a444692ede7801634036bbabaaab4e9daa6eb1828b050bffd21fd5e6ea972bbe68aeacd20b238c58085bc09ff1ff5d7d7577f5cbc21532fc377c30febbda2cfefcfeeaabef855d705678e6f9e2fd1dcc16de7178c40b21c5c26a59086617ef3757af3fbf79fff16ac90b6f04e38ba528ac11de2fdeafae5effa9df6eb6fbf0feabefb91f4f284d2134f3306918578421a650421b878fdec5efb80ff3e2b361255630c6b4b052297c5cd22ad216d2e0d39bd7ed1667e08aa769ab6d7b7768574d175e295768cd46af70bcd5223d5c97510c53706b343ebc1b04918514368ddb769b619c2b9467121f1ef06b210a91851d3ef685b1c6d1d79ba68a43a52e74d260550f53aa4232c6499ee1192f9c75699977dffefde6cdf0312ba4b269a57dfc5c145ac9b4d0a16fd6cdafe5a0a804c348976cbb2bbb61eaa5822de620ee924bf8524749ca0e4da3984be2b5db4165c10a617d5af4b6abd10ed6fb34b28c1a334b4fb6b7281b385452ed63ddc75d143a7c9c66acf7bb612c188689a4725d8567606c2b68ab06bb827b72add3b0fffe566df7d7c934f086e6c4e5ada51d5cd555d30d63056c8ef7169f77f5aeabf73599ccc824705f26879156a7691a70ae4fcdea1055d102424ef1ec615517b41cfc5d4334489b9679fb9f66dfd32ac2ea141b7d17a5858d518531326e8c567146f0b0f83a28e8e9a35dd7b455b32bd7f1a5568576521efb1538061f1bef5c687d3dacef55c182cb2e057824aebfc46d90ce2445aa7255b7d199152fac230def2046ca15be7160489fb66317c35f1a969e6cbb242233e4fa75df95b89bb2f08ac26498b070a0bebee00af70dba970c0eeb92540fc35006164d4fea353a87b164b2f861c19c141796d8a4d86464d7db53d5d6db1421dc4e774483dfe9f4e5fe701b2312c2c171c294415e0d5e257ddaec72b58d7eabc0dc64d45f0e7504de29920b0edfd222abfa1657867d4ff3452f0c90978d5f6f7628b5cf0853ff1a7161296dd066ea9a6d9d2ceb58325a15b74a19c669b17dd935e5a66efb61bc09e0e3ddd83140366ec8c8e419cca834eda18d8602d514c56d7017d44d69826e84226504d960d3b4a89a667a02264b48a910752ac97ad85700e9c55c3e5b720d99ca6930812e38407818ffcd281464611441e7a7cf51310b6e91142bd70d04c7d7717239d9b3e0ee9650e46e6e7d980b902969793d378b01f4c861baab77359f9b49801d1ce5cb7333594b33ad9bdb6e2b6539379902b9247b6c329fd3fe30d987db75d956dbb9090d48e74db2d9b0154b0128cbd0f2465fb63c72021899b1ef05bb61c87bf820f12cc5510578327f4477678c1febbe7caaee6726b44c91313ffcbc5dcf6ecbd3f67824dabb734a4e67c2fdf016c8a1800d0171c04d2851c0e39107568772fdcba1a92315336054123ce6900173013bb93f61445ae6a40ac4a5ea6bcc9221a96ac2dabaadeaae83a4332c11d23a7d862007f0e445c2911ec90bc892794105e46cbda684e614b1887db3d941824d4e68c2ee4cbcf0ed4780cdf576de8d40529e83fad50f7ff9e687fe1075001ccb36fdb6838c71ff6a36ba206173f558d08fa2ebd5bb918bcd4ee9604a4a044f70b157c2312607dbc097ca277dfe5aaeba66f504a9a3f5e460353941cfb7fbc4075d01f13641e68b45006c1fa5973d917a66289b2770974c8fc01da8719dd68314a9b39bb6ab2d4eec0c094ef49a33a2a06d5dd5fba62fd11e400d0cb956791b9394013325413e22af86678c023bd72132cf0c0ff7c837410cc87d440feb54a0802d8e723f4c61b81fa5f006e46b31dc745671c4bfa66976291dd87e08e55c0ce46ccbbd1d67dbc456468c775362c00a41123fc4d598d15e5fdc9021db22dd938698d7f6a49a38cb1fe13bb2c9a145e4b73af9cc3398637453e0ac90385444366b32b205a0cb41510f5c1eb926cf9a03aa6d3e2723895c1ea56ac4592ad4b67dc45b281d3527c2d5373bd40bf88b1fdb0360d86a93695d2249823f89e15fa3c7722e47b8b73bd42906b585444e5175d6e022e0632e7736147b2e0dbc6ddab26ab66d9dea23f00cb2db7ca9d7a43206fc406971aaa4a4f278dfdcb7a8cd521ad8158eaeabfcd90472d8a73e81523cad0a8474bb3ff5bdac9271ecb2f7b689279a294f941678a25d00e41556c488fa67dc41253531df408a6f51ed13ae99862ec5407c86045deec9d649d84f91d6009ece4e2b5de1bccba9123d4be566434c3d6805ad88c623f4712056e42e8f97c9ae10b90fb3a9570dc21980432e6ffa34b5cefd8d514509332b476b4e2a4aa892ac7ab4a2047fe37caea20cca24fd9e5b510a1bf8f9a4a20465017ac9b86b241bd2f82f5952125ac79a72a942fbc84f5b3714255efe8ed25216dcd9f3d6ad133b3c6a1b06d470b9ca3d5f6caac2e4287e61e9c820dca980bb58b00675244d7dbeca049c057a48119df21e94844faa32196072ce840f18a09e4fbb2ef35526461d13c49753de33463f57f024a1cd4019bd0fd2a33b723fced9c8fd6e915cd81c35a981610b95b34574337040b077e811c5460027774b8cc6d2c6970fe56abea4b0b0ef93cef072a80e60d408f09ec1ad7f9c5be5d905f3f7f5feb0ee41e60fb365b309e9db3f8339bf6dfb5499bc8cd78fcab30ffdb62fd7f2cbcc256f9bd9b4f3eca2f1c36cf21210a70e6aa8b897fe287b3947367c2c7d79c0167dca78c1fd268c17bbdd0abc4ad27e678e0d79dc9dc489724771f2251b7f50052b5292e05908f772783ede0711ce2684beb40f33fe1fa4cd7043f58db23c47790bd5701b2d7a0cf61a64a38ee6a7f1562905e14b7548d97e4ef4c1d1c36ddb6ccaf99322095b3a75bba50af58b719344971ab94002fc5405051c9ccaf9c33e4a0f7598d384b9a322cf051fd41766981479221095a715790e9eb1a3220f92c9e810e9118f573c90b35c973e20364b4d1d0c3c3453402d69d6192eb46f288a74e17dee4bce08b0de626b450a60b8c491b091660a9579456ca4bac23a3017113af8bc8c64983efee180d90272887193b6f17042b52a23050b0c20b396e49093439b7dd535b74df719c7839b516583f9d2e62ef606cfde98a31910792060f2acc037d7484e410263b22e4902c173a3109f714e254bd996e194adc34de32eb7f8cad3d14369df1daaaaf98c40050c81363461d2a85f3957c4ecbaed7d57620869d0c6911d1ea2cee17468047f4332dbcfd728d2021dd3669c6edfc79d55c6d0ce624109786ec91a7507f0109d10f4e09e5cee9b4935799214003b3cb77a52d120b766502ad341711fe1d8034c1d1d0a4b0624684e0cc836ce28523c8911118f07f7a543c939540b5d183a6aaa878dea0f1dc63e737a5ac41f2b067f32396dd9862652ce91e4d4de4b37758887e4d28a1c90c8b235942d1ea9a4443829a303e9e44dde9200ff8f04671d3b49705613d8df1d5a74f690a8c6ce7e8d4829fd24e72c235cc0686dfd042e42365acd6e5c60a292822c2cd947723cd3a7876034477b2438ed11728be089b9ef9f374eb9b1a8312f00ac3a47b0fae816392f4eb748e8a987cf766e62f11a50981992ecfed02031083ecae9cda59e3744abce29a3cc458d355331a68136372364c7185e81c92bb2d8852e9de604d1b9ca92c6652ed235353222e6f8f43860283a8c9bb281170185313c5f9e08172256f80aa8a667ea713d72b71180267516806951972511a855c2c1a9cf9a60709d737f446ec3400d7c767f08f5ee3c8aaa70ca4fcd4d3c9630c0a98599b0ed67944e7775f57379f39a5f43f9babd168cf178d3e414e78213ab710ccd543f22b3cbdd01b4b879fde3f54ff3136a1b5a48e6910947e55457573d488af3f26b71f326820948e609a5f1b5bcd6376fe6175e4a206f864f52d1df30aadfbe5f7c7765185b88c031b957c08df5026a6dabdc53ef551dd96d11ef55795d080fb45ef8d05816c3bdaaaf63cae5362311928dd0fe257a9918d0e06be0a8561f41493875a3f07a565c0c632dd4b57ad4ff8cf9f37ab60208b79f2884dad9ea9e873a2c9f3c1cea18c4a1d5c12829fd5cdea2e84e1308d4e9e45f684b9da2a6bd476c7679e5330dd9536bd4fb5d6846a3e97816e01252062509f2ebb4238ceb995c2343cb83063f44b8523274c9277045774eb8a1ecf0fb4178b08c0a049f72c66d53777dda5800165aacab3fa121c0bb9c248f8b1004e504b595d75864d882196a0996dd804c99711167c6db4e01d019b5a4be0d8f6c60c194fb1386fa5c4fd411a8622683379af4b8b999c52ea8dc25c939c43a265d200269132e80ceb4c3f107545de57315ba3d603dcf3e84822ba98e3a099096997871e42d154ce0f894ef500022cff7991c56db2e80e016ab0ec7a67e37ad00765daadf98c9c7eb870a2b2911a2ecb492a29133876975d7c53d14a15bc82e1ed98312cdba4c058f1afa418902e6e374692625c8e83402d8a4a27dee4bba7a99e3e4b689e8392e452fc40ed43bb94a9c6b6f6f9a3ee194f759e731f602da8b7c883bc4d91ea535b9a1f9226262853aad60060f80454f500b6ced0921873392614d1e6e158a936dc943b73b62f9f99a44204150c1c7183450cb5267e0be6ee1ed1ab9390f1780a7a53ce24168b2e50ba299f38e8ef8681384caa1d6270711a1934ece4815b1c8839bf6b78f25324ea3ec49b9349a17919683e264ecaa8c4780505f5875e2b8a38f11d9eb54e0b2dc299a1b5e76a99321c3512cb99388f1c473e461842a9b2f45fe6ea300a4a355c0696d8eb093c5e71a447dfa5484c09d3a5824dc60e5990c06ce93ef3f935dd5a81d4686f2f96cfad8ae124ae493e15cccda55724a42bc40df1addc17e8b27f1208363b9904ea0cd8d72c79ee11c9fd3e034764622a5a408d8e788ed5f0a28cc69ca8eb5eae38dea00abd39b88c7e8d037155d66b5cc6554073af55bdb60796178c1f2a1fdb85a527a12a9115aaf11c678eeb7e4d21756392a7dc1787e749edb8653fd121b717e9c56cae49c3af7d52f75e26c9ef67c27ee1acdcda9db8b31e458be3b3e2bfe39784fe44531964f1827f80e3e4fa5fbf3611c362367cb131837faa463e2b3b9d678373f7413b999041e01fcc93dc5f0530d625c3ffef1a759ca03648dce0ee76609b43813e6e5ec595a684f727982bac09b48fec33d9ebc86eee634908e570c5fe683ca3f5ee06bc3550ab2d153c487c9ce503f4848665a3b071a23c9e3deae512bd034dfb28f4dd755243e0620c6d18dad2f434bb4a5ae59ae9520790991dd0502be4bdcc4e69f7fc4cb84a19926299e40e25db3c5df13041733131cb8045878030adf8d78d93fda04914e1e65436097f9ae79ae1b80e1eb97c71114494e9c8923a0eb3990ce638c0a375fe8171b745340b9514b07afad00187399c94bb2a95634f4016d2688cf3c72bf10a0cc68b240c2281e5830f9f21d50f91a1330e46eaa9b32073685c8a73178cd5184dbaf64b47539db649a6ec0bad9f7f3bdeb50034c3a3af1d8cdca09fcecebea10b0bf4cf7b9b42201b65db8b88317747448aca35669da08474a57788b243485f3af5590af28f9b4631c2b46b5798d14341c5de5ac90baffc15a3e5ffad9b6ab64712589538f12bbc9bf1f3a3f7372f13c7888db38189eb3518bb1c3c1324b31bd140daf58ae1cce5efe838d015c926212cb7385d7b3a26d0878e9c73f2b9a9460261f195cbafc8532cb7ce0957f53a7383bf5c3789b8a26a8dba6c6b359d0127cfeb4da195596873a9dab8e386016229fdbed0ff8cce74bac74bc53a22f734bf2413c1eba7df30963cf1aaa70cbf8f328e98065843d0817fbf8e86ee8f4d6fbdc09e0a03b7abec9bffc9a3b8dadd0f31ff9dd5b5a847991dd0d9f8d8e4f9fb76f8f1e638c8e457399c5a7b078e61c6396c0c842386af0feebdfb3d403365a522ac5de011837e8bd14c37d92e18d0d6f86feed7757ff034b7d0dc9656e6473747265616d0a656e646f626a0a35332030206f626a0a343238300a656e646f626a0a35362030206f626a0a3c3c2f4c656e677468203537203020522f46696c746572202f466c6174654465636f64653e3e0a73747265616d0a789cc55cdb8e1cc7917d9faf68c82f243053ca6b6526fda45d0bf083e09565c2f0c2231835dd45b284be8caabb054b9fe31fd88705f803fe3147566644d425bb67280f77498020aaabb33223234e9c3819d5a2926a25e25ffccf7a77f3e3cd8f2b5fe9f867b834feff7ab7fa8fb7375f7e27c34a8a2a8820576fdfddc8e133b972ae32d6ac9c15953166f57677f3eaeef5db1f6e5c553b5d3bb8e7ede6e6d5e910af852a78a555beb669e235692b6bbcccd7b6ddf1345c56a6125e847c797fc05b75c05b7f8a976c256d1d7cbed4acd35384530aaf7d1cbe592969adce97fe373d585526388313ecda7d3b3cd855c2789ce3799f6623ab5a285cccba791806a8abda387c4efb4b1a3554b25638effb573f9edbbc9ca025de7b6cfb342d5d1941233469f2c69b1a1f746eb63f9ebbb68f9f1857e99a96758a97741554edd478a5a2d2a2b61a97daf6bb6e7fb87f3d0c202b21024eede7f4341764b0b4d8bc2c69f1aebe3da6ad03b3484513fbb5ebd253b3de19612a67d4ea0ebe618d6517b87f7d3b2c50564e5a339e32b8a0acc9318e6d7e9e35649abe7d8469b7c36274dc0e8d2e935c4b46d7a2a9ecda4dd7a47b0d7889c0eb271cd9f8d1b4b381ac0cbf661f867bc1909aee5d1f768f67b4b1056348895eb669b3cf6b41e1d1f4dda6d9e4c93a6170e7d46df668ef9c26e7f939cf565b85cfcb61e80d6de5bbf37e7d3a0c1ea63d38b420873e2e4d9b0c70676013947669db607be2478fd938aef2d6e1e0695d5f7e578b097468401732f43fd22d537481d0b2ceb9a9afea60c957cbabc3296bc7ded7bf3fef92331851793f82a4639e3044150e7b3cec07532a0087da72103ce6d8763507fcfad4fd94ef9522e0b04d7e98026852ec79ed6dde4d0045023bc42109773e075b7ce5ac0b978dd26e87db646505791e47705d39e5eba977194054b39c0f7f7d88c66ad875ed430a56f03d21d4f0f1d73fb4bbc76db2e4d76f577f84b4d0ddd442acac83e40278059161571a7281f1abbebd79f7abf38c8ce82fecaa865968a38744f326a5006743eda76b00c09fad21ef94b3782786def089d595d0e46fc36e8367d5022d9b0224a60cdebeecf0b0cf46e1b521f6ef62f05b6302ddd8add316784023deac36bb8a56b08b8132d1015dc52c5c455632187295c31e669f46a82b51d3f3127441d4e9892165e595c42f37a5a81b4c499e7c8bd61535037c9e86affdb3e1168cc67b0156c77c02808f77dedf9770022c0026c0e02ee2046c9ba2f473ffaab46e4075ad28ea9bdf968681ffd652e03d7ffdfefef517c9e78d1655c49231d27d83bc4505e3172e0633f27374471703a87a868b392b69db3346d9ca3fc7718ec57d0742c35f4eeb9faef7a1641207b94805848b9f4b23fbca0b660feb0ba3d89abc38bb0f008cd71c863de22be08a566c8f7dc2281503c18f9c3e43b1e631283aac0894718fa7febc3e9dfb647cf8cc5bfb7fe56e736f9be5bf89f55fe4410fc5070540770ede1779d0ba183ff0206728ee63fcc4bf184300bb7a7507ff8ac4f07ed76c100ead56e8be9951c2ce42ca58e09ed3847bfbc3a9597703d22ae0fa561af2989cd39ca39c96f071004ea209a7b6ef52b4a9984b243a39c46a7239a09d52d50c70c7f3f6d4f419e06a46e06ebf46be0b2c98a691110e3892276fde20f574352d6eb804395d8a25ce8fd6fbe1d063496462fe9d2570c903b6c775df3d747de6999e673ae0d3118137d0f322426dbb75b3698eb739c97bb0bf9900deb7fd617b783f0c6aa18223786b36bb2ee51a7818905d5ceba9d965ba62980a3e7479b55e92331599326655a0919c69317d5be6c74fb9410de14cc479f731b125e199181e714784e0fcb65f77dbb409b0d5c02cddd43ba110840cc9d6db1fc1b0c32706dc5b107af02a780ef99a8011c815819af60d92efc0d559e9de53df66b3aa2047f0b9ce61230271ea0fed29d17708be98a7dca4c22a16e32979c0fa84230cc5f4e3c1bcee99e90726a2f8e6eca550527a39f3711d99c5c43f6f3328686b1d6dc863d337797200e2508ae0f32e66502849831a397873acb28f1aa2d9ff999c0442aab6165db465ed410a9aee153fbbcd0bf652075a5cc16465e3724802a8287ade26b178a01e36d60093486c13ddceeee905259127610e20b5269be62cacd9f1af9138e2250c89455125574e409814cdeb454b2778fe685b9146064738f1d752fa8acc9e13f2d3b4f7fbe45732c87a526a455c7444889ef1a812d3fa6d8abc715a2ef2264025c55ce4fb2a7d4d01c9cf9746981c650b4b9bfe02d80be59da39cb2e978070de9428724968193eaf8f409bcb07061280d1f4e3dd263cf99f22908876cc3434420c8de0153c6f562bcb94a31754ca1850a92175433338a4b618a282ea34eb540f1d14a9e8e140030ce3254530759a84721a37bb269a6b63180f8fbd7f48005d307c7aa69ad7f29f915ec2d94db135d250a6a6114afa4d94cc68eb481cb81ff2e8d7d670c4c1d52d818b19e90d714201f8132c917866df5e9fa5a0d38413bf87498fea54c9cbd775433fef0e420457b40bc19afe6315c0b62bc5fa31b00b4693b09cc8584b03d75bb269bd1f0463c1d41825d372b7a607347d5fbbbf37e83b86bc0c9688053b3cd8ea79c5ec460946dc9c8854c3ca46bb827b0de84c101748b33511c10e98fe4ef53d408f6846b910038046631884360b65126056c801ad4cf3d3cea61325cd3c358fc8700c1ed61412c0e007c325fffd3391bdc915e7d3e755bd46b21342c572504b445f58dd5c0c7aca78b7161dc40f65c3719dc8cb3332d1c1235ab9ff990c458cdd4b2cf5c18322fae3e4bf482f35b79864764d69266b386abc9b1b488c077c59e8ffde101c863e663102ef5043ea0e201e4833d04a6a6c104f12bba0296516564f68cd990fedef7cdae39968128df7b176302b02d7ee31be260927cfc713c8a3551692fe457c83742a2af1f09a4b50dfac2388a59f1f6630230a1b5a2e878dfadd36c207b0a4bf76edaffd977c01587c465426528cb215073ea042fc6d25313cf6cb0f28182928c7e99262b473439714a19e7c910dd208618c5dae201bf6c469a4c3ec448eb1f92e2e2e9c64d1e0f111b79f3b430e180d3615402f41d0a41522c056ca799ec276b43e5eb589f6cce50bea7add191158dccbd1ce1f7877e9f79250c612fdbf0d82185b5a3f49949473c210aacca23e000f05ac5607c9b7c1792c8384103e7e1af7e68f3c60b4df65b7f3814bd1e26a2f54caf9b8e0df420684ef583970d23d39cd22503fe8efbfd7e5b8eb178cea3699bab6420af5988ff3d56791054763cabe92c909189ca70d1766af7295d403128e888962069bce3e75c3200128691e7e6675b49317aecf2d95524088a145d9986dee52fd4ece90f4dfffe9013ab0f82091d82a01024281ebbf7e78e8a6243192057e17248ac540d76efda3e0a0d192f8041bb79e10f15a86299e19c22312a68a3451e90592a3b51f57d557b6db920cda4ca09f7090a9a66d9022aceb649fa9581fd30a4f394e6ca8f631040b0ce8f0480ac3de5537e240ff2cdc7ec4f92f249c4cc9ceaa3a3cb30018edf0dc8d90ce741c33114942a2b0857bd52b13d21fffb6f9d3f0528bfdcca40ca8d5d0df1f409338a88cc181d21a3bdd713b63a2b9577d9465e10b37a58424c565f628dec683708b47ced38af02c95e6751d58ae898e4f5788a2d0549469b36ee7f627cb1fea6daf13a575f20152cd3d08390b58a81b512eb6d4e50a8170104521fd02fb4db6d5a7ef0dc3272317141945265bec520300c460c29b5221b51078919d92deabd69bd316518029add631e005c922efed2f459220d51a29e3a20e911614c979734787dee938aa7a2ee4bdecd85a6d5738a732d6a2059f0172e450dd6c135979a4f363dc0a8b35e8d083e923667db62413fa90f76a8722bc6d19fd3aca05aa3b4562e718e6bc8d328d529491ffcd7034a6a9655a17211f813924eaecadb23aaa686d9d3c8b7f4d4b9a29e6e26ce056c52575e4daada6bd448c7aaa0e08b4cb6a8cef59eacbc6df7efcf23524fb5271d9905d21827dc14a89e9afbb895f4ac0d942b1d0c9d52bb83742a66ea4651637651842555fcb3809ae22c4ea01658062550bbcd499289c0679a8f91cbf9b021a150be4bee202061c36326e1df158827c5284c0b47c90c08408821e1f231fe111555696887b85d0842b7e6229c3d4db3787745e98f621117d7ed160d015590f58b92d2db679df7e3d9ac31ee995003430b3549223187404e729af09893483c67aab9092d079285f09c9c68755bf09b5466e83a00f7aa27d13b8d89e80fa37ebf6c0660f55ef8b93fc0fc478a66be15d256b05c963ce600527604ef1b6087293f1b3b6df24289421935130223c5d41484a7f6efd489e759c2230e369a1ae18bf473208aa7ab8e6e6c1e9bbe5db7fbfbd703ec5a05be431f7e9b3c5a4a4ee63db62199dab062086cb6eb8f289f2a4f35349e6f5a4b7b366a2093b353a9098bf9f23b3d211b500d873a307fdd3df4eddf66df981d49c7e37cefa68e3ca008c1dab9ddb6b48394da12dfedf372acd033261ddb59c43399f47c19316118212f2ce3cb7d692152a878923b264ab1a323d47cba943b25e64f03a6a217826cf119016240124274fb0d0a4cb1e220d2516a2fdb2f20b59cdc776d9f402bf6fe053b0fac914af49c863d391aa1a0f1914507b7a6820030c5bd7441a0a3300ee0332a08e2812029c31fda3532058ee50f74a370047e9bf6a1841cc44a18d407b13b7ba88975333a0737c7d482f09adad4b4ab99f95e6cd68c05654db424e72ba16ab2f861d79d728b818a6eb3683e94dcbaf0b2993a4f99e9ed73fa78fe598ea9f4df74cb1719a7467d188374fb4b86966864cd9273614b90ab2786a01dac25e849d85d670892ddff128b4fc458541c0f5f1db3dd9435f28a796fd31ed6412cb66a14c8171c1527c8dd3d9f60f4d9f194ae02774a7e55da170fa52ef5767f917d8fa95249e14e3d2f3931d6a3c38eb4a9c6f1a69634edc9396a5d68afb1bcf2527fecbb43bf43daae38559291f465237df5a6e89a43eb2aaef88b198299974730a8712b038c6f40b00681c95115d4b7a801eaa87428b6d035bc1261440b5fe2485a4a790900555802a0d5f51200957a1e007a1f2600e8a1cc36f490e319e8e3e99c30d080334aa2141458c2c9cf8b8184f92f8b81b56691803bcc849a85808450a10526f0cbd0e7eb2ad62a63624712466caae7d7420e9c97dc53e0377cdb4371e4af9c39a23a04a5ca820943e6ffacfbc1022eeec7948a4df7e3cddd85c8377ca49c223f76e9f0ac3e11f18118980579d5fc16ce10d99900fbc502ae4257c9e7623e0984dee51410db0ffc2c054071e086aa24a70033a83777323a637ecd4096068b2a753cd61cdf38f4d718086aeeaf79f349970c77fd14c6c21987e98ca557364c675ca4d9166e98cf386739c026b22e172b523e33cd39611627b78edba538cb414d00db54173b769e3c8efe77925d292a86f8227b6354cc5cc60298520972c16580d9abff2f8f19bd5cf0491e53aba2c7cc8db8f498226d98b4a3e4c66b093c14f2567a6147a693ae3f1cd2e1d84029e28b3a32d24219626ff1cbbca81362c3294c590dfd009e5fd481556bcb86c1f61248f79480fbe60101495011f103f555493e736e4922e14ecd11978bef308a593cc533eb42f11f3927c9adcdd00d8d0dd48a8f0f892f2896288b3a4da9e362df25e5261ad98d8e854b27f89b866a2b472f3850df4d1d8fbe98818dfabda3aee4e744046a396e383d1fb12f3db040bdc13e3e1fbbea2625cb96ea6dc1af4e50698dbd0eb5a583cdfb9102582f6895199f4bc56172b7c39055655c17eb5f7498323a591cdf6fea587d2d9b0c162d0e2c76a3418059ccdb363687fefef5e0a24ec5debb452bba92fc8272d928b9ff2369d5f1b3d181686ec4069f7433dc7d46bf0210ee65bf8267b5331fccc6a648a7cd7c93065b0111d0fabaca506a09227ac64f4b9e36088b04ec8f5141dc741b3accae955ac83b2e50a97ce6c01d6bb6f9183fca7c2cf8347d87ad5a9aefeef6eb6d7afb53c5fa4ef179c606ef564173e0624f0990213abe4aa4c94be7ae91c07d8b4daba3f6e9aca4c2862a3e064465394564932b035133eb3c133b25ed1602125f36a596b864c6b8ef35c568696ac9e59555941a296ae2197d90b3e5c7ce4cc5aa739c667ae70a362c5053cd3595229ed08b45293d3efabf7e8415db3af985fe26be99b5cd38ebb8b9938b0e1eb864bbe832a72e2b7ce0e2ca50347ebdcdb7c3a85725f56b50adc61d1b08bf7726be9d50ab19791aa330105ce9a628bc383897f1806e86ca8b6e1e5129ee2f297727e600e586c379dcd7ac2e52efe7583a211988a773b993e54d89c101c7008bc41724f9f5aeb9ac7dffea377f38ecfedcf47f93b93b4ac45f6dc80357f0279d50c7b7ff28e3e157f6e9b70b162d7e0a76c20f2d7ef1b9b9dff392100e2b91fc623b4ea6346ecca29aeecc5d09ce309fc3d916947dc727b438f9e22362631f05d791148bd1ef0c800573d02a47b203d8f498d148da5133077a86bbfacb187dd73c6cd30046c4df3f98f564192d0baf91dbcf58352f2c08758d2080f84dc97476e82ab2b3dd91dc33323a04e51f0a3976b92f00f232bf71940b272b2dabe2dcddecf92db7741a929b160140623a9c24f18f99f54351c61af9011307771196532f32634719f57c6cf2719a1e7ea2a49e6f8b647dfeca610912403fead3bcfcaa2dc63c8cee98b9d19b428eecd690a4c2d7fab6896a391e02ba28c1f0891f2620cfaf75c533eff84ee52d3257ee3a9dbc8469353757ec32318627334538ef0fcbd1c79c569739eda485f9849105de3c6aa77ea2a76f3884c3214a21b73dc0b86f920581d700e2dd695bc5c88b1ffbf8c15085fdf1e65f5a04c90b656e6473747265616d0a656e646f626a0a35372030206f626a0a343933370a656e646f626a0a37322030206f626a0a3c3c2f4c656e677468203733203020522f46696c746572202f466c6174654465636f64653e3e0a73747265616d0a789cb55b598e1b4712fdef5310020c4b3659ce7dd18fe019cb8601cdc88b0668c96d18d5ec925c0697769114245fca1f03e80273b189dc22b316b229c9b6004b2826b332335ebc78111924156533e2fea47f2cd717bf5ffc3e331577fff947e5bf97ebd93f9e5d7cf103d7334a2a4b2c9d3d7b7941fd6774a67525a49869492a21c4ecd9fae2fee70f9efd06e3a92dc79b4a0bc2057ce7d9cdc5fddbbaabdd28262a26088b4fdbcd4dbbac3bf70197309ea50f7e3f34ee21b595328cc687cdca3f73af203c3eabbb578775b3711f085219a374fc60bff58359a5894d8397dbae6b76b7fe75a2e28cc8f8c116d61126e1b4a25aab34491327a1f98d37cdb57fa82b264d7a9b1fa72b78bd4a5b6876fbba9bfb3ddb8a0afc7e780fe59565b8b3953f1b4a2b99dfb3dc6e7687d5bef653085909851fb51b987bb36ceb1bbf49a92aabb4ccdf8b47c79534f1e1c13f5b08383caad46c01af9742863dfa6dc36a944e4b7fe71e918a1325392ebb5bb79b6d3034eb01032c27354ddf0d63a8a88ca66949afebaeadaf57cd144cc06a52b2f4962b776c7e1c9315b3c22643b4b7f1d41493e9a17f9381614a51344e1c0658a2774364e747abca303cbe5d134d610d9ede29dc206c8ad5fa910ace3f0fec2290a4481eb1dac617c17c69fb6055ff10accdf2de139225377c64649a97093ef62e7e5d2b910c52af9b7d1776bae046544ad0607f70e2e2c8044c2f681fa3601a8b2eb9efea9bfaea41158cd8e7868500080ab0e282c13289f55f584c99db027950cef28a132b5849a7584101ee87acc0009a960f5881568ab0735981c3f9928f6485a11b80814c9e34b94a7ff700354ab944b01e6312031e6510e79e49fcc601a9d4283ca63e0b68e04a8471b420989bf301cbb08ac12226590696a7f1a366173983037db10166966de0360e5180507de78e1c5029bae9aee9e238cd91300f9b80055a196bd3975ffbad55542a6bd0b848260e1e5c4d9087aab431779387856174481e403c5c9d4d1e1038191d9007c04bdbf7200f0852dade491ea22242a32d13291822cf610ff8326703f65808222172b05e38b8934404509db4b27f663df6d8d5abf63855585e710dcf3c5550e3bff1689a2a98625354a13323f4a982e50567aa60448ca802307d3e55b01cbb6f0f4dd8301002b7caa0a7640755108eceb0476fdab1270b63051a6bed9f32409ac2adc4302b0113f8ece43457d19f81826cc66076e405ec078841f5fc7c97f48fd63a6d16e2c03e5802bc5c717a0208e761091753d8cc66304d2cc19b21b88e86b592b4c7c32e9a01e23f41eb9c3603782f1f43cc4884d8d15818a51d313869612a90c874625a8178ee39c9826beb603d5b00b0080d87ff5dd09494e26bb38a406e6b7e6bd6b7ab6da06fe60c27fa6027208534eeb06b9cbf047c08034890e547cd9f9bf6663be5b512349e25c93576db6eff059bf2596038664ddaf93c90b7e5d91859d8cb4c66bbb67b1de30191592887fd6b2ad4f8248955f954000c9103acc3537ad7aa057fd825a8323d1689da646a68d6c8c6dca2db00cdcfe3824d7e258292306a70d6dd22b02ac44438f1d28f965d7b1da385cc2a256e10040e4e9c10343c7fd88010397cc2f95fddfffc89db1ff5cb33047048d3393df29fb0ab0793821b9c91e3194513817240e20b9cba419080e7260f0da7099b600aa568f070a00e8958fa6f9c54586d477667468d3c8357864bd401fb76d5fe517721c4094771b80004b5b00572db75d013803e906967123b9899627a7ad324db811235fd88783d0ac8c970644aa3b97d1fd5680aec6fd23457492f81e411968ac1ec541778eb228559c5877ac9a5f5b8398f79ff98558ae618b25976cd3ed18d003013a4bd133cc3f4285b81687a87de98271565861add550ce824170df1ee60975778826f40111b3a8815b464ff093915d0a90506ea9b18a6889367e9611da04e0a230332134c5c26d78f951eb311cd60bb412a05644325cde6f0a27b174537c8a0cc22693851a3ea00b3285b5e6ebb751d0538d7e83b575753a7495dfaa2901d16916ba99225a35fddff69397f3daf7f9e60944b54738384066601e8c651f7c2913195d7be1d3f3abe46a53f668d3fd573f8ece7232b95e063022b1cf782e611c00c43771f03a6e9b691bc19e7b89a363904a5b68f3f9708b264d076134e00420d4306c2eccc148e532745a291da7ead97c1f35d0989d35ccd4999121338690295c7148700c9551f8220cd8c19e58254a23a28d26b6e479a594a3dc1b8e0e6e7145ac65b43014bf3a28044e340f0df74fa93c5a81486c404d17ad32a520172866175215cfa204ccf718f265cb05e8118083a2bee0dc29f3a8966a0449133dbe368be4cd53dad647a5544f87be0d89991639573523147082b38d94c7b0710ffefa2a06212a3858706085b8d230f89e8b5c428d575db2e8857a6209e00e1ba8c8e04277a9c8febf1b3d9f71774d68249c84cb8421b073543dcdf9572b6e89a8b976754a307c4330bd568ea681184a974553cf025578e7e18021a2f10f824e41bcc4da0f399bceaea75606109d2816222b1f2a70230e41ca5c7f655bb0cb300f9437e30aa6c8344cec139ba0d84d022edf6b3ba2c4060c5a05e2d0fe19c60569af5d24d9c003847e3c397f572bfedda7a157d5c30b4d9db18c028c568852e6e183aceeeb04e790bcb2a25173e72d6b21979855ffdc27922241918128108e2a980d1f2949b7a7fe8ea55aa2111e9e2748f67c1d90f37ce5fc3f9735031591927c662528e888831810aa489db7115f09c606ee2485a646c4dd76e139502ed233776613404ed62863e346069849d090d0ad02854a54fa84206215cf848df38c1392457b3517499bce54cd2240b0a747948f8279364487e0a2d98a88063e93896d9206bc5bb99a6dbb75d244dc814c1374ad27c198f017c19eb72cb76957228377971f671754031230bf39c978d4edde0497ed76d57db5751e30b5de44ba90eae73c56d17fd0c32d1e4ebdb7894c00a085d48e16fa368174e44e5f4ea90345891f2b649c7012d627258bf6977117f8ca008c352082fea88cb43d3dda4f8c18d9ed8404e5c93dd6d2eeeb904e37ad52c6382ee127285d267fd2e52b6d19897d5d1f5b82b72da9eebd51de4a375221d41738de8cfe55898fc9a3c1c6050145bce097c4858d5ed6a2a982998d162fdf65ed80450181edbdbf088db5c713ce7bd8ee68ebc5238c7c1b07eefeac1430c522e40710d2a87c360884d332758006c214249c017574ae0534a204939377ac178eb6aadf0fdfe5daa854f60e9908c86e0f5dd0f116786a12e7afacd0f5ffeeb4b6f76a73dd0324f42a003e940e80cdc8b153c4d0164904241504ecf9f7ef3ed3f9f463e100473b3af1e7ffdedbfbffdea291e83afc81ddb297385b1bffa18384ca141467ee8394c8e7df2f41bdc927045a163abf66677a47bdcec0c309a9e72ebdce0ec0ddba90d1b88366015016e0f2672dbfd3a79cad57d32dfc1ffae1ea4f20de427c51416349645aaf95f18d27fcb228d59380a818db991c50b60fa37570fe6e1afcfde4ebf873ae9816172f23dae886d30cb285ef0661e272df074ec0803a0feea03e640611ab4b6abc5b9b29d3be24fa24402f19238ec655ef3a3cbf9a3e761d58b34c89f5ff49e896f2f5b8891db18ef640ee53135948025cceb9f8fbf1eebf1302cdf6d4591d3fb6a4ff549e612ae41b5a037fc326c41331f654a08bc9cc25895428ddbe793de2018721970027f7de60ee75388e2a03171a70f172796ebb29be7f10585171e33b57743773f37e986e15371829b19c8eabfc349390429773be720f423c415076f327f33ed3590766ac54f7acd228d294d932686b37e1b8efc8f8f20005766a62cad22cdfd76fe47690def96470fcdbbe55f7ea4c92db9813390f4985beefc8abd47ce1fbdf8fb9cf2c5794e1913a9de5731917237fa44dfe58f8397a447d2a447cfc31e9506d52b7ad00887710998bb1c7b6bfa1000f33ce0e685c7cda71716d06b31a19972d4f4dde7f317232f3d6a79e787f0e19160f9a159bc0637036d6ea447c4d3eb74b52e19ca94e99ea4d751aeca7c11d9c464c8b5a9a158cd5913e56c509a059dae732716f604316e07c59f50ae85fc8308cc798ea69a4d4a8a55be4c5ad538b9c0fad6f10e875df06de0cbb2e26d2ba37165975312174614d739f3a959dc3d0420bc04dfc836ae4f04eb196fa766b1ae208aad1a2f2667a170007825735b77cd3256082528385c642cb6dba2d85eaf530d20a722e3ab98682eee46657f8d4505a62b2dd4c039bdb959df229025b9d69a7e8122756db8dc4c6196db2cf7ad3719735d81796bb80e85695cd7bc82f9bd6771d0a61a2f6d1f43da186bc0604e9a6f735396a92a9befa69a759c5a15075177af02c901a20d168896f50e776ea46443a00ba626806ef9f8069ee65bba5c6d26e6dcbe1c201a86795d347bdc2ecbf58d93893a24ae0370685aac29f19928ae49426accb8bb64ed37a88081c113fb1736795fca6215dddb2c9e20a6d7310b35006a0c2787c451da9213774dbb3639329c09d8549d38bf15b286abf1da4147a53b52accaefdb6613010490cb0d58edfa362e4b98a2b4144ae355f43bcb50a13cdec4d356f976a2d9ed11442cf70e646cc1e4b957746a750d3a83c67b900d2060071009251098f9e899359bd8c6e1abf5836ed5894af466bb8ea065b93473dd35f1200c19d6397b3d2a7702598b5c3d8d1db0e0fa429dec5ab9aed335acab67e871b5c7e6da7cd1b5025439101dccddcbf20f586bbd7917439328bc6bd3ae53dd471364c6734a2abf4cb13bbc912a648f7bb197c53581101daf03422fe8f03ec0cb0802d6fa3bee0298843312babc0bd045b7d68f87db77111b34977cb79b57f52e3515b2dca703e60d4ddc10378af27ce21a989a643d928afed2e0b393d7dc929426eb257aa7ef7de6715b2a0771ec3d34dcf69cae8d778210cf735fa52f4da72b3c4259efeec7dd23485274ddc44a30a08610da6756776b60ed844a53e353d158fe4dfde8ae1465fad7af779c1710522e89fe52269bd3ed2e16fc929aa10ea42e871ad155e157451ae1e31e8ae6764a08b996831cc52745992f750b7de295784e9c884948b81b1f5b5c2ec4e3e71c7752af5ea1684221357d6f938486cc01f47dae7cfcc90877299dc6c61b9f10645cfb7cdad77f429c053677d255f4ac9ddb18dcdd0565c3bd19523418168865b4c8d862cfafbb41c2d13d18016c6cee2b4bcd34eebe0da975aa8b092fe473230d56e19bd81f05091bc827dd87d7101e00b7224139060f93c3788487ebf845da3aa4504df22e87f0b01a339e5d0b8c1b822058837332bc2954b97eba3ca476af857091dcf4bbbd9b37a9a9c8fdcc21afe87dd136f21a17b0127c8ee520dc2215efc33e01b4f95efed889f7a2f1f48973975ee2fd4e53c798c0f2a56aee7d20d3242d5c18a5038fecff926237b93ea7b8f27b26f7ee7e3f65588ff015182ddf694790f4eef97d3fefc329ea84684c212fe4e52dfd274921083bcda98f2ee3fd08250c5c2845844c8eee3625f7ffc41a4bafcfe172ea1de361f1a87bcffa854ff8c8b5eaf48eba371ce0f82e3dcdbf2842b7a11ad9374823275ef2e513b21ae8171a72c142bf4c861a4b1d8292111f4e347914df793e3fd643b5a0ae5d47d2d2323fb6f8fb1ecd31401c4b04e73111004937eaf9b18c662c46a6042520f0a9d3f551e0e42b4c443ee43ca86446e1216437fee520641846d923c94d7c37cd0511f4986295287c85b5e709df518944415cc2651f23169d7fb386d118f460eedbba695f365d2c56386189acbb0f8ad0fd982717936e0f2e6f8a61d14a5be8c7981ea8dca888bfded019804788b35de6ce2540562f7a16a907c5d5612f80b245d735786c13e32c90276ac6fa3aeda4684b4ee1d1dd970da8a698f38812728d5ff2b412021923d888c58aa9f3ef34724bc890771523231409c53e5809c962bbef2384e62965b008a7a28a2370914733f32ee6118cc8d25ca12bc5c21b73488f314a83c4c736ffc9ba28387a157ddae469bfdcc5632dda7ca6748fdf92ad204743c65c4509078ee07285fe6fc140972ddb7791832cc58c649b4e16080eed72576f8ee3e42192cb46b63109452e2fdb79c30668df7c93eace5da6b07cefb0dbb7fb435099c2fdec0d83ed54c3ce749c85d85309daeb86fbf8e8f1cbd1e8a1ad532c76b6000a263afc9ccaba813ecffefee2ffa8229272656e6473747265616d0a656e646f626a0a37332030206f626a0a343434380a656e646f626a0a38352030206f626a0a3c3c2f4c656e677468203836203020522f46696c746572202f466c6174654465636f64653e3e0a73747265616d0a789cd55b4b8fdcc611beefaf18e824213b74bf1f0a6043b115e460c0b1ad83630809b833d49ac23cd6e48c60f94fe51040c83d7f2cd5ddd5d52487b33b6b5b306cf9b0e034fb51f5d557af26abb858b0f02fffb1da5efd78f5e3c25532fc171f0dff5e6d177f7975f5c937dc2c38ab3cf37cf1eacd158fbff185150bab59a5945abcda5e3d9515af64f5ecd5db2bc52bc75418f66a7df5f4f3fdae3f6e0e751f7ed2b6b29629fce9aeeeeaf054b84a7921f1e9263ee3b2b246e649ead5a17d1787eaca6bebe971fb210ed615d7224fbbdfc567b692de5b7cb66ee23353394fab77fbdbaedea68dc121fdf0904b01ef0ba9164be12b06d384375e6ce2240a766b0dced2f487ba8b3b3395b4f4f8efdd7eb3bf0dcfa502890a81cf6feabe5eefe3735331cdf2019b1d4ecdbde06341f0203259e68d9bc6836b551967edf8e0aab28e24f7651c07e7e68e86ddb6ab24771be49eb7f645f3ef5dbbaeafa30a4dc595f0b4911ea5278dd6f830cebb6495645aa93cf2b883a9e360292b26599e7b350481b21563cae14f3f1e936a3c28968edea767a25252e78177c7669dc4b454a07023dc620928d14ac79fbba6deb43f275da88070e6a630834319234e20252acb0828690290a1318ed3a91050cc5a3e414fd4025801e0ef54f500566fc5f84ca062e61dc9a5eb9afe2ee344304daac4b3821c15f3bec8316e194c6d30c926eac256ce1a971fd6471038aac257da2935b6045d3963f261feb6ef766888cecbbc875d735ba38c60738215b3ebaf931a00c316b822aa41ab6c0f11de42c2d909854d7ae3936f841d5109d8a8a233d339ac5704b3f1399c967913fb9bb70dec6e3f67bd4a802c0961af9fcead0d2792c23e626943f6b06d0ef5dcb2e1cc46657dbf7e5665100be2a66f330f314bc2e99ad5b1e9d6714aa5c1784922681ba06e27549125da11684b782e2f4041b269319c6530b5a49df4082f3892a589893a9951636a5a2aa07a0e0432b4c337fb2e5985845914b1cbebd74962860d25a6c17d4832c9ffe11039c2880cd3e4855fe010b3b0b047c6e3109083303c6ca33232482f8ce47393a98057b0a6e1c03f47e100b498c9627bfea8478a9b8c8c99b9f28efd78c7dc096dc63bdecd610a88ee64c74faed13138455e93185333fb087609c8d265fc0ea9d872da3f79a1c1628119d003817b044e953431729c2b585967de1305f26fe2bb12f6449b05d8c4712116207797ed6f8a1be06c4100f5739a0ede551127ff34071b5329cbc0321f868d017ae3c0b7c3818fc0c874f763cc3c62fb7ebc7da1989a6cff6e960e2194e2106a0c0766529cdac78014cfd81a0412725e666c7c0280c504b8ff9c5bd383575684965f255660c3bcf90b963a67995ef38b0dd38e85faec7a6e59e049883172bc828ef26eee08aed2829135fd776e5db044cdc840d8dc7a63569de1a4dddcda1025184fc2b9606d9e69480a4fce2250cbdc9e640859c8799fa371ed3802da02742ea2f13cf0f7a3713fdef12c5a80d5ac9dec18bd2d309e5124c0bbae59430cbddef7317ad060e582c2e897bb1c877393819ec2cd6b4c29208d9a46ed0054ee28c61a05e2c06b005ee2e91b0c73410d7976cc4b20192b3ef8d074db768791b682b08052aabe6db670008cd16515d87d181b14072318ad7bcc3e03620e8aae29e4769a72aac3fe1a0f441eeb7d7800f2e3c25342969234060647424d315cc59ccc924c69233811adf3a0ff6cb3a363e4a76e52f2244d719d9b3deac0dafce623629b893de19f69c893741848a8ccc47782f8353f490b076677595a28cb240fa485cc10e6e66191424de34b0ed11ffb437b38b65d8a4474a00a0aa5ef4ee5d8e578c510b07e47d5497baabafcde67cb335ca88aaf7c525140cc2c1f11fd8b1e372734b1ebdc1922b821cf708efc3eaa1ab2194eac9b2d385a1f989832e6f1309c84d82136cba73d47cdc60bfd87a3667301350747ae00eec3814f922e84b56692be0b5882e8a7e9575d7b833633882c1aa425e374de371578ac24bc8f8a44cef1627279ac9a5afd080a25d5022c323e4db5e6302d26989e004107203c10ff856847fce19030efa4a7719339d9f1f339c884dad6c4f4c79af9eaa647d7ae851c197d2898194d25d0a67b87bad666502d41171a0a48868f5c68df52318a5355a1d9a29b30824a713775779b0a8d2ce0383fce797f7848dcbddba363e54297125cf701675525a5ac936130c3cbcbcdaae9ebaedd6348618a9788e6d146a69740218ac80e991e60ebd547647a0b62b3bfc02aee65fa6b5437689b82b6632e7b812103ef8b22ec385a40a6cb5c29e26d53890c8242359037ce6b3555f67ea84ff5026f272e81cc1bdc6fded601cbca4b05d34a337641f50ea5c64bb9f78035394002d833514fbb3a85d20f040f4914f771b46568cdfaaeee005871151feace1412b5f0fc50a31034989d273e3e900c39255144bc5a493e859f2e3aecdbfed0209dbaca593188ad80a5937f072f588532c852880a73be976f21e64d2778f96af1f5155fb45786b185725e2c6488a5c0b58238ad728baeb97a7349bf650cbf45eab7f0104230bbd03efcc663d3e5798ac38452c4815f84dc219e02a246ab7370b0d9e71abeb7e4eb472d102d436be5a437031602a8190b0e0e6f29425b7dc8dcac38954e37ab6392890c82a29c648d1300274b7af8a65e1df65d5b6f7248635cdec5fb4437de94f87e7e63e41e8d73a4d1635267ece0902060b576d31eb2942280caa9bbe65d5b2f932181ac748c798a2121ea20813196b29e4393f312ab8a006e8f3baa1d83600635b65127442a32e19920b96f6f364d8fc462240901c839b350699ccd19609d534c7878dace519c96eadbdb638b454151295d0ed73f9f234eb00088a3c18f2d61670cc2a7c29f60c8dc501441da7dfdb4cfffb3d7cfc23f64525d39c2c25f61b4c4caf949c55ec6880a477efaf9f103ea42088ae7eb1db61f20fab0c4b8efea4df27aa2128e5a3dc402c69f6c3643d191462928536506f9d9ac6824ac1382c1c0129a5b7fb96c58110b83f8913a5023b1cd0a47033b734ada3e7d993a043149a42647db74e8a5204bd13c83a974e02c044a8f104e6915cd094724db559658212119cc49526e2ace485081756b14a0bb447eecfa7b949ce721e852f78bf8fb3362e42204f88ec4f853f00a516436d4f9280cdadce2513450cbd0fe96ace2a12c5b3aa2d977968af82e193ae483c421f3ef6e939943f8e004d54bf629b9b0c6d3c05d7d3876488a821133d7e4e624b9b9a26c56fa4c3d262c5e703f8af4c232340a1822cdb884201970214781699d5d83d0b4d82311c34e1083fccf9d1d88fe57af9340073a6192fab967e864338f4fc100c421bb7c00a0c10565d445701a114a7424f7f2436cd0908ebf3b034f08d68adff9c50cc8f2f6c86b0e64495ed3057acf84c2ffc4cf4842056fc12f94c477a913099eb25c24f8c7f5cce8c7f2ddd74794849e645b20184d1c9e61ce0bf9fd4a5bcc8ce605e5314de48ce449430441e5cb1a5d39182978fd492376ccbefd11512bb83dd58bf17a5c9598b1dc91199d63591d4b6d4977ecbc9b7a00c5e715587478468b16a027087ae76cb0c9cecc94a8b3b4aa19a7a125c83596fd466c9b35ec4a6039d22467339a54460f6487a1a60275962b2e594b920c819f3c59d7f9ba07175409ca41c7e4c292020f0529428ac742e503867e89915ed8911edc2119b5005ca914cfe78990da77188442c6ca799662bb5b6d8eef1193cad21b947131472e2f5639c22d2d53600a844dd12d18ae27b862392214b169827af701f7a67c2959efda2dde6e0833584749c23021079f2e4e54e406d5baec265961c1fd4d8eaf19093ede3741d0b9d2a3467f0cd1018978ee0018fc8861cfbbc7d4490c8e44c930f354eaeaeb1bc4352fddc184d6a552ac52667c09a76f498f9c0a90235a020799d588f631483be6af768179606269c3659849f40832d19c5a19ab23e4c4094d807a98846e13ecb3142459ed69ded3acdb54cd80d44dd0e5a7be4d7205b632feb49ea5859bd45264484c4a7bab6f723a28b5ccdbafd7cdf603dab22a59669dcdde703e48ddf2fa6074597c2b4cc54028a5fb5cf85b50e168ce0436fbaec2c55961ac974555b18de6fdb912a0e01797004b95649f3662159d7655f7ed7e97101a6e6f3af2a273d593d9fc7150572c6fcf8ebc2f03a62b7e80315daaa49169b08e18aa1464030fd00a98061b1425ce5348aaee48cd636be89eea4ea8ec08ab3f4e654706ea0612195476007d249d9759edba34e2288273c68dea0027e6bb39b458dd0a9d5662ca493b0924937f29b51a56aefe35451e2a040fd49c3def3a1080dc0caa17885551a8f0ae6b00f2eb387854689cad6ae0a1b526fcd7880469c9f522389496c416b02148623a4498a210668581472076922d651aba5c70a21476b075f21fbe8c7b0ca9a29d87d6df98c6635a9776019e97170f7bc0adc1026ac600cb2d8e147d64532877697319df924ef8c99335159f8be9cbdcebe0a5c0fa6d9b6b4c802a92c9393aba462396bcc0a145d97b431e8ffc84e20fe07ad7aeb2ab60e65418b2549e4b85ddda39afc0075b3aef70c3fb6a52d1184d39779ca6d411586c2e11c46ec95150f43038a7248f7a44771060ebc6fee0b1580bd29734f6770659f6456e7cb13cb5c9281cc32c479517e5f529126f6aba8c1f1b6ff775263285407c479e9c6ea7f8a2cde3a1a56be5c12959553492801328cfdee7e493434266b34a964cfd9c3f9aafb8ca50833206ddd32f4ed7fef598746dfce907a00e9230484997b015c91572021c60e6c38f6f1ad84833db725fe691c3af2b3ec7b658686613868acd2a8ac3ea557d936f18bbc1f5a51ca9303bc93ac61ea014eb6946f2a2cc1142729425035ca91a5e832147ad87af3d4c69d86fb26b2e2b6d9a1df89a7ca2d2567fdba0d6ada3f2ccf012970d692e11c471873617a26e5e62e1d22da4ef1cc2b725716fa1294e44bc3b154b39ae35971fb75c4b9913f5dc9c702a6ca5840f0b841939b7e17da5605883ae07954c2dd1df03f7959ca552d0e433162d58961984183d4697a1e7590e89079786761e4be57569bc5016b56edf345db35bb5d433b39c7ecc97ad43be6d4a78b0a22f2298a436149223176af825511c07c11c1b97b1e683b92a8bce532af502a1e5cac73b99d5cc909a0f45db447f47fa9a0a12243b5606f89d10069a711e32e34fbb62f46ad41d9e4d0552e6154ad1e582c1a047909fb5db3b8c30941b5c203b607524868b1472a67615ec5384586e540e5922867cb931522a464c96ea5b14ec6fd5dbcec52b55f22232205eaefa3de839a429dc94250f6cf3e05d24fab24c91b13649a0d18d970cf2e77a879fa6858fec18d5524e0f9503216fecd41bb2c052949d34076ad6b272dd24e52131e82148bf4fab80d33fe9a78ca1dfaf8e896b40c1be7052ee8a7046cb5cba71641b5936f81b00409d1674b81dfb2af0823cb486c74675bc2191b972a1e8fda92783982ba5ad3aec94c951093e42dd828be183909a6e0070f531a10eb02ce2a5cfcd981a7c3b87779ce3a1203574536487ce2bbf10d9a18de32e453658bf140f225b0281960423877980ad39607b4dab6f29151a10d53d30a65bdbe57210259d869337a2c61b9c1ff86152cc8c3d21da022a61a958b8cf3f290b7e145e73e5e25a090c4afefee6b8cb9f0a85ac8f962e5ebea497d8ee93be90c0d91212b2bf8cdfa565e901fd27af184ee902fb87cbf526fec6637b315671bebefa3f3acf35c9656e6473747265616d0a656e646f626a0a38362030206f626a0a343131360a656e646f626a0a38392030206f626a0a3c3c2f4c656e677468203930203020522f46696c746572202f466c6174654465636f64653e3e0a73747265616d0a789ce55beb8e1cc515febf4f318914c5889da2ee1723841c6241240782d948809748bdb3eda5ad99e975f78c05284f9317f08f48bc002f9653f7ee9e9af1ec7ab8886009adba6baacee53bdf3955751a234267d8fe8b7f2c56672fcf5ece3462f63ff768f8f76235fbcbc5d97b4f8999118c0c366476f1fc8cb87764a614e282cf94c088733ebb589d3d98bf73f1e24c212ab55430e6e2faecc1b2eaed432211275884878be58f7ea45652ebf0b0daf6db309a699883f0f0e2ba763370243823e1d9276db7b64fdf7b4ad55038aa9050699d4dddad9a75e54672858811f1f77d53af6e3bb716418c631a9ebba5344c27898cc2ba5f232e31d8c13f6add8c442089d35adbf84cabb4caed76bd69bd98631b5289148fb3213b4222298c8cb678745daf9c89a84644c838b2ea1ffad9241ece36a7d280287c36a71409a2ddd8ff94d6b5ab28157d53afa3611927637f4ded3af65fe74d8219576468b8b1956ed25c130081df996461d479d41e27edeba5938b802e340ef3b84058b3e82a671f822811220efaef2afc50e384942b3f3f9349fa76e97c02620821a2b0979725cb0a80369371c59f8ada843ffd903fda21066165227c7a8f5e8ac0ee51c17edb6f9acdf67ba793b23e9163fc71ad9364b7bb0a38fb1306c015bf019331b5df640fe7459b11c41955439bed62da002e3560da2e0a1abc0da6db2330fdadf71376a88ea1ff6d5b4430c5485233013027294e7f5700beaefbeab6eaea458d8a8e2202c4051e3885a38e219f943c94e1223e1c270fce710cb5f6ea45bd695e155998492430d1c7f811b39fd78f92ffee88e89737d92122faf0182272009f33cd90ad21e60c521c21eed5932a5731c978cdcdb6f13066d4d542b1ea0856a13c9960535d2dab90d0991451aaaeeeb7ab3a585f08bc5b3519caa2eed70d38cb2d07e5033326ad1706db5221196add6eaa45d3ae6bf74e30a479aab4209abd2c6228cb114599d26c52940984859c1665a02336344af20ac40e3380c7699ae1db0a9ebbe150bc30a3c600a208d3848d55ebbc3787fa0f716c806a181483c2bf0b440293a86c92d6154a8f2f669f43bdda9c419d3683c288ce98610202600690551cc0ded5678014a367507ed0f49450ecdfdcb736b608d264266d1c50571a7ffad985d39541a1c6a2ae8f82c101cad10b1ffd2d8694046d205825c322c7ccdce5140c6c3b7cf5d9a7595b6ac41e650803309f564f6a6b39609881a24f1f7ffce4d117491e284dd9891765cc2045478b7ef2f8a34f3ecb8b3206cf4fbb288710326ce4d2bf3ff62ee5e02b15a13a501d7ec2f748e1f08881598b78f46ff901b4025e4c9e1582059cfe56ea196ab5124640cd459c768ba58ffd6e0cadbd2b3b74bd855ce37c17e5822d1bc4b51c49f63c6e82d8e817101039fd3d0a43e44c21a31c8b3f87744639b7ec017ca38c710349692e8e14800c0c3518f8bedfe0e8c13ee5e19d1e0dea8af74b29bef0aba95c766b2d389de868c63a126da0a61929b92e4d06863d46c9472559611530761871330ef693638041e831aac718286b34ccf87711dc11c6c905e710bd589bd381d788ff67f4e2297aedb1cd70e0cd987af7fad3f22bbc9407f8551376527e555649a0316de5f548f0e51694c58ca55aa9bd6916be2682bcca53b95cf79b1f6359a0d296677dbd43cefbc4f6e47c7fa5f690b364503e9b9156bae4790955224f85e67725784345cb302547c01b366dc25640c38177c07201b8036cdf417c33169f72cc27e2df96b61c109d924cc47f76f9e0f88091d380016f16ad86c77381b726a4f0afd2a25047433d7a778e28ec58054bc7c06f5e6a1f1f184164910fc666053ee074a2dfe53b654b805593ec7f28d231d47a944ee878bcde28917c33c980a70e34065b2488afd3c41995f2d830234085bfc130e34786199e885f8e328e683e0278b3af3da80655c3a99dcd318c5563567d68f6c094bdd1d91af2dbaf4caa45e17f76523ddedb054a6527a654035cb8634355a05976c8acb6c0cd572e073895cd7e66521d5459fbf0efaa2c4df0812a4b1a75d22a4b4b508dcd845460711738b75d7b836241a5d251e6c1da6b504fed13d0d753f7177f12c7f13405531bd003f18b7b184210c52caaf2d3be04c6a7096c673f2101bf1105ece07e028c341c76f2dd4479cbb9b335a0428ee55d4f12efa93dc2ecdd86dd7adedd25830cf11652953304c7489b1150ee8f02d8701d8781c19ef244286034d587792e3595771705b0c5df8302cf48fbeced18c91eabee6724bb4dbf2723c9e2b99a3dbe9a09c190f22d12ffe8da657b33a1997dab7a9ab9bf4c6550136390d1722855b0f5f802c5ddc5a4388d37b9933905c2f94e6f1fd110ad8fc458ded2ff1699e6f0111acb0b0f28e9d4de630236309a8ebcf7704238f75f7382804838f6eec726d6bce6876f0107ec6ed77e1dceb9371eccd178507bf0e0c9699f6f1c39094b4a25723ac273e02802b389f1b9130085401dedb7110c51570c318e0027b120fda27657af94a3dc39e5ea238cb016cad677f1c4291c42c1ce2ab55885a2695a92cd15454a40ea9cc3de15834dece0c7fe6e4f803ca94b68552faa75d3afdcbdae903041ba4b4e778c526a929eadda7ed3558bc68908f919761193be2cd057a534526d37adefa562184a9ed48f516df2519b92a9eede6e9a65f34375edc4e1021268baefdd7bffcd11575184ccefe0454d543ec20bb633984efa9ca8454bba2b6ffa4dbd72824196c724dd817a63ecb4468c8cf3d40e518899415f56df2eb7c1588c229cafa9bdb1e69cd92b3ce5ef54e1a543c493bf967c4a4123910e6cea7eb3bd6ea2a50c22f9debed4db51ea89899a820b683eed0c302350cb539a46764ddb9d072d00586caf53eaceb708d8b0d5918a9ad5edb20e57c5e055c570be99f71a00fc353113e88d34a816dbba0bea6224746a4869e30db4c99d15c5bec7fd1d037eb0028727116e01b9a1e1cfd18782b860121c4b6de365f8ff91e4408bb40e7500bce0cc80e39523887fae9bd7aedfd1f51da63ea8186dee5c6c02a0424b0594585189d0db48543e0a1c44080717a708d9f655f09be1291c136a304dcfaae54ddb351bcf185c23a1c44eab28e62928b656a7a801e83a8cdf885329060173e8ac1d3884d3c408e310d04812b5130203494acaa41090806a550a01321b86808b5966ec46578e62b618082e6028b66d4ed1447b59ccd2501cd4553fc4d61148fd046b393630835d518ef6d70b00f5a2a9ce83190ca371a2751b19328fefb7f5d24d037c620621ba5e2cb78db732b3a734130c60284106ccd16fa26e9cd01de9488a5a9f576cbb6d6ae8dd769d931705e6123ad5048fb6eb97db3a2045ab647cdfbc030e61598676d5f41e55963bcc0ea8062a7bc1e6dcf51b9151ff0a28e28d0173b381b3937e2044d4ef765bfb99008626f73f2d97f5ab403658a66e9c2aba55274f3b252060786eea4a8a099328b1bdda58fbfc1862d4352a4c0386d0b16e16e9f999ed6b5a5a66ed4392c63a295177dd6e8001dada3ed23ba5a9e40033b4c13a269b738f4f432a61b902edaaae0aaccf5c1922937d512a45225633314180d9d0d36f0cb055e39d078085bd4b9ca88a716e483a89b30751200b98c4b94582097343567282c1625288443728f05ad236b9c1d04438d74d572f7c43159396bcd9d43f2c0feeb7c103caa49eb329ad6a396df6822998bc0bad9a3c7c550351ae03a228c9e93776258a6cabd0af3be7186293b151b8044841b2e59ce4a2e92e79b5035116099bcc16fac377f5eb75731dc028a1d655093481192026a949fc526aab7471ba8e7e1338ca0329ce79df76819934ba542df9f63d4f2e005c41c64917704bf2c710cdfaf58beaa107aecda9c256dd02e256bad7e1ab0cd85cc849939d4dd5b9928a76f1597dbc130496d432d9fb8352e287782432352b866e5a3d58349b8f2b9ed9e315a4835701b6382b151a50ed571131c69bbaf36c60b3700ef2be89c9520c682d965fc06ba9a84bd891b9feabbf03c5fbdc29691d96a42b8a9c3c6e64da38fa84363168d507c4836834958b811b7d290a157986475ffb0a775aafcd99066a607c4447907d368079ef2e61f3012e7857e54888f9441232c9e690aa741a19b8151399a8c8926b309cc02cc3165268090800bd7c6c54e8aaf6cc71b5ac7bdf6f0b9b2480be19359017be242a6d20de8459a9d2d0cbcb226ac71dc0515a5542ed20e8df845aae7062be116ca94ea41f606b3d77f0c3813be858d4d0d8bd7eda5c3daf96a11119888fa478711de030d288c49330b26f4399467422a0cc5659eb45154602afc9e9b608ecc344541a76ee50c5c63e6b2879841871d5e31735ecd47c9cba5d8f06dfd8c627d8fa50bbf9985946e6faedee8908c49dd27c062c606f41fc156bc9bcb03bb68989bb530ca8559d8cfee88bd8eb3f1151f2fcf2c197bed806caca177b37970faece1797eff84b33bbf194e993850f82ab39372ccff2757996affc2c2160982dd7c4282f7eb53b5b6181abf35dd1bf3ef4cb44935fee8efad009a3803df0849bbef75c1a6df6c4d9eccfbfb8c9ae0f9bccef4d4aa23dabceafce9f2dceafbf719d1d52db62cdec37ceb32ffffdd5377e2103a425f8b845bd60bb822655c13707bd9a971f0a6b8f8771da487a1f11602f2249c94725f5d9bbc25914b60e8690fd126bafb23d83c392146ceb66481bbc3fed4a5e5c69ddee1a2215728367fe54cf961d269f0d14c645061f2d12987634705398d07d411acf7c304f3d9a8b7605555ed89d08fb6da98e367ff7f2013b17b1f968722c2a814c8d251428540df6ae2024d1dde767ff03264f3d14656e6473747265616d0a656e646f626a0a39302030206f626a0a333434350a656e646f626a0a39332030206f626a0a3c3c2f4c656e677468203934203020522f46696c746572202f466c6174654465636f64653e3e0a73747265616d0a789cc55b6b8b1cc715fdbebf62310424d869d7fb6108c6711430183f2485f8c38269f5f4aeda999d5975cf3891ff943f18f4fb72ababeadeeac7ceae6d416c9388ee9e7adcc739e7de2ab18a8b4b16fecd7f68ee2ede5dbcbb74950cff8c8fca3f3777977f7b7df1e94b692f39ab3cf3fcf2f5cd051fdff14bef2b612fad669552eaf2f5ddc5b3cf37cf5fff74c16dc58db6f0cdebedc5b31fc6471cbef1323dfaebf2d1cdf5b31fae9f57e1c546b18a191871c365a595fe7da39cf9afaaaaebe7cb7fc761bcaa94156998cfc76508d8076c7c5c8556e38bf7ed105e295d596f78fafa2fcb75ec0f4b3b0cedf259dfd6bbee973a8f69b44e2fdaddf2e3633b1cc353e12ac3ac4a4fb72bc31e9a53dfb7fba61b47fef425f7a5fb3682b14a387eb911b6724e8c3ff9e6701c3f7ef1faf27b707077e1c0b5dac257d134fa5256c62a77d9b717374f8898e9943962b81015acd2785d2923c790f92ccc6a2a26bc7169f9f5eef6b4af474b4b0756b13ebde8eeee77ed5dbbcff6922c1bfc5837dd619fbcc32bee9d99da4756ceebecb1effac3ee707b354e6021d67082e670377a2e1886e3e7f77189d2b0ec9e433f0e2a2acb300cda9f5a58def873e92b03fb492f5e7df5e5abe3292f4d73f9e832ba7d73e8c75925c319eb7d4a0e5e31705a991ca7f115d7100379c97dbbed9a7a3b2e4779181c6333bc6a7fdd77f19d06336a9103a71deed3489a89fc8316e2680c47a12a21d0e4ef4ed1b21e8cc01e3655dbdf75c7f14b29214e5c8edbd3befbb5a9fbec64cfd105fb34ac0ce1360b7d5619e5c5dcb55ee102e2a62aabd0fc980b55b28565321bfa459ccb8057945dba6b231dc48d986240f4dab86e55192705da2e6e53f0ca69c51f7084b168d704081044d63adcd2fe70d7ed53de4e6137fc5a7b4df6bb79ffe37fbae3db1f0f0dec71f8b179db36ff5e4b788838c8e06c8f6a6dec8d648113e40413d6d0fc816901bdaf22846710cf3f2be334c2628077ebf3802be8397c484ee4dee467bfe5cf0c1353fb7d1440d5de3d1d50478cb4b027cd18bb0483c11fe3ff3e111cc5193ad5f07f0c961db0f11f319b84d596a3fd9bee434a0529306b0e19010cc3cc4b1b01f4768c4868d7a690b7221bb219cd154ccb1108e324b078cdfc648e4570f1ca78a5cbe03210a70cd1fc154cd904741e6da7056091444f7780997d9ba3420b357557804bcc971de0481f914886172c47f4ddb856309bc33c8aec01a12729b7eaf4954568d8d5290339cdd2fdf2eed4b5fd36c205ba5a396e3fbaab2d0459144e2fc3642037bc424fb74bafdca60587d8940b374b8f6e8efc0478c1bc2022dcd7c9ad1260543af1fbfdaaa534798e17bbeeb64d64299cf768d32105986422ffbcd97d881b74d638f4c76938ed90e6b9966a11b802d9b56e4ee0948c1fcae655105d38e3dd3c7aa4d7124db28dc20136cf1d7dba5fceb5f673623be7906cc64d411e32a331a40153e29e04a48152f9717d5ff76d1367035a6110bf6e422bb810b0c362214516dcf787dbbebe9b87a7866cfed8e1096ac5403886f87c311cfbb4ff822aeb636660a34df6f56d9783540beee62ee51ec5c69b88f2e078ae4a836ec0418a011f64c81b92f1852ee7d9ae8a5b301668bf6cc0242e25b76632eb44a1e44925d3b349e3146006878a01dd24b8278e3fdc9cf6db6e5b6fc7c1417f5a977f709d790ac2c1231d412c84788ee3838011b82d0a344fa22804d56801802a593eedc105c9e0200f1443b08e5218a04d69999d7017211d443dfae0f43e8a4ab0a01653b26e7f6dbab85b015acc1862cd3c32b1f39aeccb2590b738db11066c536e288e0084612e68c42081f7c9e910fc79cb3fc798814d79f2485e26e40e7db9b64c824aeef8d4de2288127c98ea375579fa102daa0d8635d40b50911cebabec00418263381e92cb4401eac35516d80e3fbd87486b13ad09cb68f0fdf6d47463de295531f25a1d1de98004305e23bd4279a0aa107c25b484559e8e19fc433520919d51387085a6ebf6501ec48083ba446ba6ca7927e27a3d77f29856239f23bad134846e0cd1b3a98768358014b360b8021ac96dc2135efeb74b89122ca97093c938221486c81cc36177ca5a0ad410d3a473b28695a16c0cc694e0441645f17791c84031207ff66979162d10cbc0e002a1a944cd6651023f3c1eae529a588d91d69ceafd36be00ecf1d688d93e44653872fd5a4afc9257444906b5d66d2e430246168a326b0a5a41269971681652280f13895c42084964f7c36dd7c4e5063b59c4a00141df61c614025deaca4ba3ceed0d52003442ce2f1baa986c4e2ac300bd1cbcf113f40abf3cf611de54a81a11bfda983c9cf125e1738ee3276e07850fc02815a640ff26a13994d4390b0ef9f796dc4d8ca7719e976d117412a8d4d8591e862042cfbcfafaef09d794c2719b035422b14c87fa530aea4900032585130808ebbd639b21479283d756379558dc173894a9dfe3c3a444275bbea1e20484379762b1379a8c1640fb1d62a5f021718e95ce2e4690b885c45cc09e0e6c50e21dae8d592b31ee92780e2262e62309014e95545f0a65606187d20b57c119e52a00e5b68ea80e2ad63b04e9b775e0cf644ff094630447989e1e9717fc9a7a3250b9328d223341276c8fb915c5119579d802367fbe18329f521f62dc0e3ce11addf5db55cc042892357a75c8b162899e16e47e18ba37bbc88712809a2983db1880ccb202063262a1ed3649cc2d56e2da20400f80db6d841b30a2a31e49c2cc00dc88b7c8ec567089265d41f88c1e496431854dc101435a49aa2fb1720139a47165b7a79c56414c295cc4f0d944814b25f81f51e0eb8dd2a8c015839c13b1427cd5e1ae31b1a2c288318a4db1b40bd89ae267b716007e481be3565166ae38e80fa0e1a4aa26287364f0552fe0aae6c5c9749537759e456824a248bb739b86260695cb57319acb0ec55a1b002339310f88717dce400f46f0d0f61f32cab033bd88ebebb8f6695f0e785d4924dffdeafe42574c22ec7c322d0cc1b0ee638725e072e82cccc2d22cf5bcd6f64fd029f843b9950022502feb09e370fe787eb01a43a1458ea68aca1aa40c5150d23c300d635837957a188483d3d3c613a03eb362d179f216179fbcad99c533058c39e1f1b3d47a4a14ce0c9df1d4099519caa5a21f212cb6594ef50e875006968062fb3eaa44103dd41119517c9c8d05e5f3b85900d043f933ed8727cf825735b68b40881f576335c83ba83ea6b908d5f53217852f72b1465960c3443361016cc557e0cbaad5ec0ced55410ae03e7d2d34aa0d60ed94b422c4a598b9511887b502ca184b2bc02d4886007cfee4ea43c6136a23ad6d0df8ace95be43340a4457ba558c6e49c024a45318d1c11ba688aa45752d2b2e266d607884d7278028839e999cc3b5f31198237332b1fbb20f641048da0a455a948be08597a88c76222d4807ceaaca8a9208a21d0b088c9e773300dedf4c1f33919cababc3a3a9e0bf580402df0ea5f5f6d8a93382340b214c76803760d19917f9d890b827ea6ea4c450c0b0e1feaf46b29f1e0e2a76cec20bfa7d2151d299c4001d8f787be4aa258911cfdf6d81f92f004af61ebbcb011f7546c63f7829b459b54281cb428c0493ed0aa0850a6a79acef3f5534da85c72ae6053c5d1de7229134c591643a0c1af3074b19439e36886e737a9f60ea770b881a2c923cf9a64df36ed50f7dd38c6465ac8f6595bacdbc7302fbb684770d1e9ee3eb56a02c0c8459d04c24b5228365805f2d0ae41e6c36eb4e2b34a09ca1c7a568c8aa76613b50be0a30cd254bbed62c4cad0b724e8c9429a09e4a02fbffde6f5cb9424cce3a7df7ebdf93245a055d8ffbd865c4d0b063985e21a877578800b2092559044ba4a6d2ce90c9685a7a14e25930c07082bc116cf64c1120f9ec97a857891105b2a3aa63ff6755a88a1dc5de9a1acf7f673b429bb845eba5ff0e2ae6eb02464822dce9ba4a58ed7e16e0c6b1158a128b0e898cf68ec8f132bd0646b0b38b64d3e596150b573fd34ef8673218f34b86ddfac70639f0edb38c3a85db1727bd336c753ddc758d0a10cc41d6f0fb93a34e3414e995d6bcdac269a5d840a985a4b509641a9933a751a3241a0f5feb9cf224e62a3ed5c974c1abcf9732ebba30ad3c1a3524f3d2a431fe529e97d95c00eb27086c2004334c454af78ea4aadb5f0c76380440320061f65c5d08bc836b8af73f74f5087ec58efb057e29c9c9ec98eb485ddb6947f0f12dd6751044e8b1a1156e5c3f1178834394be01099749da3db8fd6bf3f7631f46df0162ad8eb676fd3ea8bb3fa9bb84d509a05cfbc6d77f7d7cf3f5f93a41b11da0b3066b19cf729a2b9f258a934ed7daa0160ffa4961388794fa23037cc403c12c41cbbdcc76198ce27d47ebe80454c726611f08bfe06c3fec6ae4d8e17a15f83bc56b4c6e9aed1b63d869b387bcc477a85a8c40449dd2cb839a808a316821b188e3f6c80313ba364016315f4fa753a1a0df506a6e6f9fe52383220a469e89ad7480481e24bfc18902c2526d878bcb24f680cd50709a5489891b55d4547dbf7a71df210d4fe5ce2312ee53b45e108b6ab716ec18598ba6fd7822f5c7299f5266ce86b996c9cfab44ffe0cdd45e616270c05f03c7c0f02225662ebf66dfda6036c1eb3399c2b219d9f6955f0f17690391be0a15b128b5711625c4e3f86d065e4935daa2783a766f52446f5c29c01bed524ec9e604e5319e3d0b34d3c1108b713b498a984a219f358f8733a884a7a391ceb784ceca6ab235b80082fd68c8ab3b8f155bfc97295e177873e5972bc5a71b64ff5a8969c2c76ed246d6dd49c1ad35e1207e9f7b17b498239d8626c71be402e1274f3ead8e77a84d3e5c1a24ab1d8f6b9cef6858ca59ec8b66dbafe2a6957c78b4840a569cb6b05581419baeaf8879a57c55549343b48b9a79f0569d05df879d9eab27407ee4c45a408a21358843561b900947dc81d7ce5d8fc889187235dec08a5fecfbc9d065160b99c29e6d008c2ced5838da00de830a8cea797bccf5ee4a23cf89d17b9469c3395d738e8eae1f1a27946df3fc45059f1284cfc6ca9708bd2221fa606e2f5f3510e858be5971b50a7060a83f07a13615f784d97e6b0adaad135b449b95ef481b4b09a8e62c68356dc3e7833bfda67c4e26635be8cc539936c069241fa80eab8ceec3cded4c7a6d0f5b34c4a921ab7c5d183c02fc901523cb684e294c0504775ff21a5a9f2c5296177174a82abc46cc2631c16b6c3ac9cb4f83752cbca3bff27ceaa3e66a73ffd45830576860b837854f9c955de141d84459597e940174202d02eaa23092ce948be0d51bf6941d65d3b2c4c5caa2835ff4f74b4910c366682ee8324958e52c807d9314fa17083d2cf5208448776ab29142ecf3c90428075167b1c14aba17fe197270fd2845be0b33b1a2b69940848b9f9df1d31e545c387c31dfb6c76ce603294ed2b0565e87e32ffb48232dca8f24baec17d45b201250ec25a4e73e7d1ca926b452dbb8c11c0aefa8ccd76873e9505e1a614323fc691a31b0e843b8f8c3985334957c609a40cdd02c30283b3e216d8c35732e8e8989717bb32fad12018f7800274d7b3bb6bfbec35af50801734e3e72a2574aca81791f97703f565e8f3cdee9ce6a5844cc2ee769fc5abaf88ddf1bc95d3a1de9bd390ff0a07b099628b4b92daad5d5918e3087258d9e50f8a3b8f1fed14917e4f8043f39c1562116141a2727454ea0d28d86e1129db7cedcc29347e827e2ed452a7187251f9776e5037f58995c666e78c9496a0b98f716d155d2a3cb53f679b688df8b4a2a6baf1a25451581b1582e109872b9457f7757fcc70a86c713ab6c29fa7e1141aec510a8d8c0c2230687320dff09e8bf0662c3abebff81f8db7861d656e6473747265616d0a656e646f626a0a39342030206f626a0a343230310a656e646f626a0a39372030206f626a0a3c3c2f4c656e677468203938203020522f46696c746572202f466c6174654465636f64653e3e0a73747265616d0a789ccd5adb8edcc6117ddfaf1808302201bb4cdf2f7a3112470f018cc496178124ec0b35432f68cc0c57e45080f339f9010708a0ef4bf5adba79d9d95dc97662c3f082d3ecae3a753b554d5251b621eedff4c7f670f1e1e2c3c654dcfde31f957f6f0f9b3f5f5ffcf1b5221b4a2a4b2cdd5cff7841fd6f744399a934d31b2d492584d85c1f2e9effebc5f54ff002b5e50ba66292680b2f5def2e9e0fad5b435925a5c5678d7f262aae8989cfdaa37b0647180a878467a7be8b0b99d069e16edcfad799ae08933c3e1dfdeb54575c681a9ff5cda9eb8f7e0b6e2b9d7708c72b8005d76eebbeef2efd5210950a199f377bbf965794e059433b9c9a43ed7e108085c21fb6dd31ee4cb84ca79d9ae1e4d7027ecc9884c1cd4dc08eeb123b09d072c5e29a9f9b610d60d0920a9b247fe68f2495b244a5f7e223ab11f2fa7d7ddc75472f88a415e33681bcf7cfaeb8b295906c7305ba4a50dffdf4defda22aae4882e3935f4b2a4ea41069ef71f83036bb8007aba814539c4525b948d2de2db6ec86f6fd3e28ca45a5b84d5a782c65a5859169edd87c4c004b9950aa8768229e4d3c74fb71db76c766a80282539fbea29257460bd05656dc50ffceaa33fbf3f3b66d4496283573665a19653edf9901244167ce2c2a837e78870e6ea44e089dba185b82135edade54c2282bd12d83b342c4488996189adbb1dd85e8d0a0af9a8507075be0e21589cae8d2e0d9f2cceb4574017694cda20b9c97f095e8727269763eba02d4701ca1c9efc6e4d1aa12f0b6f76870caecec602ca1f1c0cff0720a2962a1af25a8ef135d97559a9ba5ebfa4d400a899a35495963259d6368b24a5e01409a10c93417e9f5ba7f9f64501866dd7e0909ea549cf3ba09927d8af9542af4e2ee78199d138eb33373599792d3ca7db73c0c608d0b953cabd55d8ca089f85b102b985b1a90894f12588c4d0696c442f3716cf6de144c421a45f336216e0861987eebf048158ffac62730c81a228bd09cdade03c0a074285cbb8b6b2138a4d168c15d0bff79918504412d42935c534109c0e386bb31d50f01f01296dd6e1f772706b33cac1ff7a73a6eaf2ac3f5d4a2c2652eba3891cb2f0a066570cf9b7b0a1b18572b965e0f696351d7c02d38e6cb67c1aa1a30659318c6246c2d4f1b9e9afed01e5349560c4fca3548d1cc0bb65ddf377d5a6d30f136291624b75f104b500473421eda94b989d4399063783055599e9e9efada0bc5a0986892fce8d81e6fc763c2da50fbe42ce31e596030d9f4452883049ac884570c5a088d8cd73151382ded8a50571cb281a16a12797d8d354751749bf6f8cbb13dd5971179ce185688ee70379eea2893b090e39599ca04c5c7e0fab813561f2b10eee81d855280f6185227903bc8b432e39d5823c38a12b562e05f5c25673cabce52882e640e430dcaf031188b4a85115fefbb646e99733c7a2c785b8ed42196345931a227e1b0b671dfd6895301cc50973215e85d4e89648bb3ccc27c5ef2cf694575a6186117e7bd141737c920b22cf1210f3328fc4ace752916deeffa215b7317d808643411ec4a184274c67b6f5e54b11a38c60f8983c39b9026dcafdf74872e6a6811ab9f037c02221eb972881745688e97541099c542022e1b8060b6b20a5de5143c182836c764dd2d776c52a011a966458f958d4de242e0795ae5903ec644452d63b8b26fbb5088406996db925815fc0f90da292abaddd7a1a4c2e6146b74acc71000268b7baa93bc82a1ff47fe093441707e4687aedf45df727b22808f85a0108860c356dfd590c7c3165782003a52cfa85ef25c2191b46ef7de3ac0a27566ebf508f884d590c99855622ea004228f0c66655b6026b72e4504ca2600236c82b6d1e9c04984b10b352510a1054a1428139d55ee8785d8b7e001750a7b579575ce29893a2ba1e60d09301c4eccb9d33292423e0149c7181240c01692ad6073172d65b5688fff1edb3e256882e92af004d7a3d1dcb7a4f8b248aaba482bb51f50cc7214a48719ea0e1abee69b226bf2d8d7b36f8aecc4a56f3a92678b667b88869006b59c317e086ac972390b1800b55468e9537d889613b9197cdf86a253f69c91bb7002c9802f34a3829ed136b24306758de764e46956aad2509117555a3ab3b389375d090e6251b61a9ed0a3e5c20295c1a7aa21f25d9ebd3503cdac98a5656026b9f5ef9b7adffeb33e863a6081043308bb2b009004677bf55373b80b1ef3ea7af3fd05ddb4178a908d50d46cb81b2b69b9812a06bc6ad337173f3e626236e3b19b3831035771d55a426742589898bd0cfc9a69869a7d034ab7bbe8fcc0fde939e3412e6f62dd83f222e79e49a9cabc13fa7b643d0243f1843d515e9bf29787ddb8cc912c7896cff3747e7d84360cf2c950ddedc3ea29220a5a338ba73dbb7971197dc52217cb5da0b126b3bced7ef4159a81af6b2c75cd65d29760faac77cd21500257a39092638b0dbbce929c009a8e478de8be79b476d73757d181814faae92861d76e63a335c706981515989c1cb60dd0c4aebf79fee6f2edcd8b35808c75ddc1b223b62c679fa4882098a5b66dd39f5279b12c3f1feb63920dc42e6573951ee3edcd9a2c6ed8a9b0715c3b36abe4131673713a6db8e6c73aac3586eddb55085c238316be8c7162ad2a948a258b3b2ba0853f2e195cd30f984f5d9fc1712ab16b8738327211948966cc396069c8d7108265754aad36504da93206cdfd1e003164140eae52749cb1bf06324e992a9587e020b90199581a9c4b3f6c691097d9f39686c449e79606729c273b38f7b3b9f18dda786ca13a2822ce9b9e831c4f317d15b437d2a0f6dfc628064e913baa893f506a1ee90f404c2c596bcb3099f5a1908a5c677c5e81644e2592d2ffd447741842e834353c38f951907a444e4769940335075b99929750b1485d4a627f3e8c43a20384676eff003f833aa6d0fd7d8eb59524f95ee02952217f50822dd912232b6c89b0451187c63cf75691d2d9c9ac2f600eaf93bc347161a054d4ac736197bceda3b830286b675847f6321d2c367b80b15a4dfed06fc20ed7df5e3cffeac51ffc4c4bd8b2cea65af0f51b1fe646561a9bd1af213dbc8ce54e11a4ef39f87d374f10b9360a4d954c9abc89a817a7620b5f2c9ba67005e591f159d73e59efe3f60a9894eb42814d014bb276a1d35d7317863b5697574cf0187e4fad79faadc473b609fc112a3c71648416db60839f7e2a45f96aa97bcebd116f9769255291c7016e1f0738390738dedf401dd433e122ed170b86b26602e3667bea21bdfff1eaf50f7f4d8a31681220ad6b4a6899cee203f0d4bfffcdb92a9c9607c6d49f26b54bf0535b25a9a9ab6709d23c6d88156e2afbcbab732e9836322eb0a9ca1b45531be36f6fcb14fb7b09f12e7255c6cae96371fabbf5d3ab6c2cf62b186bcd42ec410bb1ff2938ecb1e0ac98f5b7967ce95b9f61210279fbac85f88316e2ff0f31f4a54214fbbc5bc9b16f0b2fb1943edeb77e8718120f5a48fc4ae088df169c15b37ea9e48ff5ad399bcfbe56ccdeff341e23f91314faaef9cd86a3caf932a260f6c25d8da71377cd2fc7b698940139a43457fae8148b9138f27ea58b5b967de4cc5c3faea7739f3d593ae7156b00c04aa0bcf93e3f9156e8e5d3ebeded98d829f469d266ea35ecd22d88147636df61eec60cb9e4fd5f840065b5c0fbe5ac2989b4b7f8eae9639bbf4d22796c175a0767bce20ae3b6dde20752a2f8966bf4dbba2927c1a6b43bf8068801b74556d9f5a7fa100752d037123bff8c059a4c8a37df48d229c7b1ea773d7405b7113308719c060df1fde273b27bfbfc2e7daa60f3bcf6be3b20f7618ac6ae3c352f148a1d22b8abfb4f11000dcdcfd417a103cfd2efc7db78bb0b0d3c36d82be73cedc23928efd247fef0ad685c941193b476f62b8ea808cf43e0fb610cdd8fbb93e1186edff96c03bd383e09ed853bbfb8f90af3d77009cc2ba1f8ecee1642380f6cb03b84beecece755d8839ae282aa4ec7931cb9c1d870045e53ae4e0c5c88862b09edc60353623e99947f18dbf8b0f886ebfce89d2cc77a857e93110b876e09af03969fcfa58e8b71a86b78a5505ef9492884b30f70ae04646162f5ecbb8a0706c62a279f1b1fe3fd888915dbf155bddf47bb32525c39c441360890673aa07668e7c1dd8a0df0bb967443029934b9d8017276883728168c621396c5e66814bcd30077283e2b03acc76dbad480cc9037c798205cd2b90b0881dae42104a7544ea1785a20bbdb9f95a3f2f1fd2482650546a713697ddc133909fb1fbefd8bdfddddd8141fd43dfd6380d82e534862cc7df201ff77dfb4ba5fa9a7bbfe4ae5fb8bff02156b9e83656e6473747265616d0a656e646f626a0a39382030206f626a0a333039390a656e646f626a0a3130312030206f626a0a3c3c2f4c656e67746820313032203020522f46696c746572202f466c6174654465636f64653e3e0a73747265616d0a789ced59cb8edcb815ddd75714020468035d1abe1f130446e2f12e8b8cd1cbdaa855745b03955496aa8c89837cd32c02f8fb722992975249d30fc3338b60c6c0a0c16291bc97e79c7b2e8b14946d89ff97fea88e9b8f1bbaad375ac8ad628a6d992ee0cff0ffde6dde6f3e6e4dc1fd7fe317a67f57c7eddfef36dfbda3764b496189a5dbbbf7b09aff8c6ead2d98de6a490a21c4f6eeb8b979d3b5c3a53997afee7eda0855106d05ccbc3b6c6eaaaef583d416566b1307f77b3ff6dd3baea7cb4b588e2b16e7946de58673dfd130757e124961ae4e53fff4fdb8052b28b73c8e75ef7b57393fce69c1084f739b721827ab42102ae3e0a11be22185a06985931f520557244deb86fabe71e3542e0ac5ad8a1f0c5d73a9eaae0d9f415eaca12901fff243b6e056dab4ced9f5c7ba2d8bb524ec38e185a474bb8314fbc9af77e3d1744195d4d7b9d9df9cdca9bc1db7a085643cedfac3fed5b8fc8e12532863b73b0acbc2c58f1f8e2bfa1462bafeba1c8295eb7337de282908642b8ebf5e4efdcbb8951605378686ada478e1566d4c2b67dc3cb59382983435b3a0daf1a86fefb63f8e889742f36f8d78256561d6f06eb9b8c23b2385e1ec6bf0ce5e80776bc50ade19dc96bdc6bb2e181c7f8e77382433fa797887c35af12b78a710ab4a09d8dfb8c478c568ca40d71fc230b0914a96801c6edd14da501cfb34ae0957c6ad8d43ae1fc6db65bce002d72c9b94068541546598b91384f988671029db08286a59ca0f70b1eefafdabf16c1c9642febf94b852c046a07bcf212e7b21717f7736fd8e1271455c2135fdd6c405312814614bea6a08585d53d79f5b7c0d75f9b3a9cbe1386a95ba4a9325758dd64bea1a6b9f475d5550a296d41dc1078a260c4df716990b059ce4316499c6fd8ef570ece2da44a6f34e39ae1566f0e3c545464a00349dc1ec5b1b81dba51158e6c6f5e3d9a929a8318999433d8ec1ca4a25d9195c5c4e67eb72aa63900cf44dcb34f5f825a805313833de1e4896516691fda55168ca7478ca788664062b2f48b61c8135541654f074558fca13b3a4d0d2fb0ab062c63c2951fc0f6f8141fd793939d26296baa11eceee182e4b0205b0debaf6dc97cb3344bacdd6b8ac8cdd5faac6dd62b62c9d338bb1c21846e7a09d2d50b7008dfe723c8d9f29e032e332432c2d6291f46feedefd63f766793f797cc785011ce9d98dfcb3ef9aee6179d0b8ffe95c87cdfc6d4ad4bffdcd8774642dd291df77fd32b60fae39ed5fbd5e9eab0c78b45082413ea757f7efb73fbbea92369e875ede77fdd91dfe33ab3f9c430dffc6f547101020be6a1d05654bebc8a9fd9afa235e601d6128e51fa5446895127a8a1a09faae50730e9750a618805ba3f36cebf6e1d2867840bc9844248e62370a2353852628965d7b1b055858f4782b35ac8f00e790911c6d640d29e4c4c5057a01846c4edda186ba7a2e8fe10b92792b973e3bbb28ce44622061de4e78a2133903768c8f79eba81344fb32709df9028dc1d5ed2f6d7dfe15111650213457cf1661f17522fc875efddfebd535cd7750dea985a91068e1dd9bffc2df2e6dccb900e46a9db647c66b818c773f7b3444fbc60449973ea7377899f485de3d3409ff0ce1ffe05ad787ce8c83c192a83ce9f2c1b8fa421e371dce25f8d4cf5519294aa9b173c432ef5ed12aa3c5f491e319478d81041330a33af7e21d5c60f4a960f439e6f1e09277e298926cb609cd586bc6953dbf95415f7701fd0eb32142a370bbb64e868f65b16a82a640fe35148ce94d632ca0053293ece95894a7ca552c1ce88be86ae27316f86daed2c4a63efb8b893d8185908cc03592ef574225409fb102406f6e1ed9cd35908ddba8f292e74e63dc081c31bebd8da101b8a894e942ff3bde3b1c466874dd17d7601f610dbe640cae8f07620a0741e13b10f84399ba1d0ddfd12b8960d8410df5c3a58e1b401d94290b67975e0699c0f49efabaadea531d16821e86c337e636f4fe4ba85c444a92bd7f5d7521299e8e0cdb8cfb7228630b078a00edd0bcf85010042e3226971d01b41f817490594aae5030fbf67effa1ac42ceb8ff0027af3f8364f8e37347d32df77fb4d1c96dd2e0206d4dd305bfb183bae5df5b419c286c10f246c7fa452d680a96e0375dd8136414740d8d51d9c7c381b66a4c4eba2e4ac4b3090b0641e28d4749a2632dce3a78eadd107224041419ae1eddb16b0ff5a4a5032dd4525c5f0bcb42732afbf250462213fee8dc0800d00e8b2f5c80f84b3fd49fea43791881078442ee3c76b560c1b2b2cd9a72c967809e3c91678475e00886a8f69c999493bd97f02e925f4d1add95d6b98282deb824c7923d0efd9533acbf0c62ee81509a6221a211a71aedebca831e5f4c3aa051920aa3713f39387aea5799c2f01f7b510cf68c43628d807612202d891d67b015e4bffd04a63190957bb3710d73595885c71e4bef10eba0e4946530c695a1c8983960be4445550493dca5c42bcb67ce041c25f402ec1a85ca1094a1cf1f4144fb43b0a6c26f88a78b7803b3900f717055dddfc66ac7945e094f9bf5f058ce6c2a5fd080806fb7732c43d446f25c95e2a1493e3488f911055163698d95315c17583201c233e503da05a23175c305318bb15417d79f2215780eb10b18531431e6503029922377183a570ba8acc72816de40304ee777fa29ca08546335bd3fd88d50346af84eae32e7f20b9ef42d1b26c8819841811a890648cfbabf9604ac4f9385abf21ebd0406e73e9709f1449967ad28389fa221f94cd4827d82ce28619c8999b77a91522c45604529c46fa61491143ae3c31720b4b9241b9432b19bebe7b3dbbb5c41e7e89844b1ea3112b9b38841afe31b155fbe619a9ff4838bf72cad5afeb80aad0d56c84b19bd24289b6634edfcf41d4d5e0772b2b9ccd367c9268aea27937d1b6d1f00855f678011ccc098ce1d01b84a813a7369ebd0a7306ffbd35eb9af014b4431e649a9e3792fdfef0cc92ae7e1fcfb3318a549a10fd636bb0b03dd255579b1807f9f29aaaf4af8f25683fa95f1d5207ee4cb12099c799b94986736af3dca24ed12136b907e9d236cf29c7d48a32a5bcad65560aee026c64b0391c8a2980ba0ffc11e5f910eee97766ab00c7c88ae198a4a05deae8f90319054fa383f8773dd74c1942ae8ea957f8cf1bf49024e46d730f27c7c0cfc71f33fd4b2f287656e6473747265616d0a656e646f626a0a3130322030206f626a0a323238310a656e646f626a0a3130352030206f626a0a3c3c2f4c656e67746820313036203020522f46696c746572202f466c6174654465636f64653e3e0a73747265616d0a789cd55a4d6fdc4612bdeb57083e396b0ddddf1f01160b07c86d814db23ac8802ed40c2dd39821657268c4f9533e04f0ef4b35bbba9ae4502339c91e36b9c824a7bbbafad5ab57d5cd0a2e2e59f83ffdb13d5c7cbcf878e90a19fe1b1f4dffde1e2e7fb8be78fd8bb4979c159e797e79fdee828feff8a5159756b3422975797db878f9d0b5f755531fdbeef6e5cdd5dbdbefbebbfe70e179a18554f0fdf5eee2e5f79bf08cdb821b6df1d9fbfa437bfbf2edd5cded774578bbe1cc15c6f9cb0d9785567af2d19bab1fe2a8da1682597166d4a9313f5cbdc1b15fffc2fd74251bab0a6905cc255ce1b58c3f1daafed886cf25bcf5224df371a8c24301cee38ae3c3ed50ee3f0e75d58557ca14d65a975eb54d3fec8fe5f84614ce38836fc647302173dae3a3a1196714bc60dca645ecc6093958a169c27ddb8f0f4d2124d3e9437ce80b61b8241754bb7a5be23b2d0bebe90765337ecf0b9ed777acbabaedaaf16b19b680abecccf1735d286dd3223e8da3c213e9d322daf8c82a9f3eda96dd575c83d652ced7ef3c7dd754dbaa2fbbba3c54a36546c0284e936523309402b0691e81a115fa0d2db33a597b376cf771a75ca14c1aa36ebe04382418c8cbe05665c40803a50ac101121bd8276623e454816318abd3203fcd5cea44c1b555937715cc812f4fa0c6e11f0e5cb0918005d8f7f09b1f1b44ae912c6d7ab51f9f81214293c31ecaee08d322c8c0e5eec98d1cb7911542f1e4e43ec24916029097a2af44ff196d12c40003c3a1c6d920d2a4f5676c7b3734dbba6dca434d5be78d49ab898104733aa00182751cc681af093bfbaab91f4663242f94a540fe50e19452384fae6ef7edfdf8ad86851b4103f73164c2bab5d067ac7e1892eb5d86743476a3a42f1ca0608a330c45c03bb3c94f9fea3e46b70027d9891569792a87066c60b9abef0fe3f75a15d62d827c36f2be448bbd238b61d1f75d7928b7f5571cc338628ab641526079907f8fdf99c2719aabbd07f416e8649badfb6fdd207f184dd0aa0eb87546a8f4e15dd9ddb757c88d00394306f7e84ee164f2fb3bb0755fefca5d9518c8f3e95e6dbbfa187fa7348406233248db0000316a9607fab8d0409399e8fae1cb16c10756c1ce390a841e77c26432093b318e6100661433edddb16a90c503078be445c289a4487f02aa3264443fdf5d03b949a6211f163b2901dbc4ef6d9a8f19969e8d9f6d5801849f471e8ef51e7d6104c55bd59cce8768820420454e0e9197615091b3c2f608f8f87e5c198c20095e0f1149d2d0a7915f80433d316cf5a13a3cec233a368a79d86d318ba1185ef0dc0949304899054ce3cff32f2fbcd70bff4240896ff2ef6cc2dbdbae2af72fc619052098e2654c4b35a670b085510a3fc5b6c88b2288e9824982d8be8af80201e118e5d6cfaf5b7ca80c0d30c6c65ddd612a568a5227ba50982c1d0ed5b66ceafe10f3ce467a09bc6a6761535180080fbb98d9b94a6242727b122010e19a25938287eadfca64126704c4f601b7c531f272d5952129c4e155a0254a6510f407740e245637857840b8c932a10a68ec0bdc166378b2e5a7f008e41e27dfa2c921a5789d3329a25140f6e05ed16344bee364d5939083a956b20f309a23abea66db760f31fd5094ac98b51a0625c258291a6f684ae441403c9b6f680f29be422f72a5cc2c1a5eff22e67a1da203d41c45479cdeb04cdfe3cf6072a01c0aac7a8bac310a6474338a1b98555882704a78163c4734db4372ac62ba5b4a2190718c5472bb66318094d1a2fe7e839f3be2193937aa30dad25ba090fe735870c2bba5bc8d4c097b97bebe1beafd7113532e480dc62829a26487b07c110b1d0368a440c702040001c280db19b7b6ef3ae0aa2651b7e269b232a11dc4763269e80708c358e2401809fa78c96a003c4165d6b63db4a876a47439b9f448a8c2abb4f95be0cc5d7c010acdd166c7470e4a42e39231310f81fed6e4b2dfc7c901ecb9145a9fbc3d76a96cf2100629c0ea07522e7a569b58485772993b205f731a31a9d989172c58321193bf1ebb72b3ff8a5c2138a16a14579183551028a067a6218b510f923741ee501d692410ac96d8208e5424816b89567f84c2b44f340e3e9cc326577adefa646f93122c97340c54b83bc48a85b5b1b4823e26a8203e94ccc43f8d03909d7a52183ea60b2008d5427ef342f389fc88297ad776b1e897e127e030a06ab62c8ea4a784b56f51184b4ff22fd7e5da524aefeb7b7c0c2bccbfa7128869f25e54a27748e8c6538e472d059292e771bf469e103e8b6a340a4a098260b9bf878abec708377ea907676356b4abc1f1ec91fa1de6d459c4e65d19339c813dd74b11089308d2b1dbb6d97655cc3d0aca3147a93777148c23d874d506b9060a083903f27e4ced6457d80b39e9798c63c19a95a2094a0480b55ed2f8a39c40890682c23a02479bccb79ecc7f34b309c6890d1e90eab4e7598860d869e1d3b38934097d0e43ca60a64dcc4c7d8ff1a933a68f986da088904465e56aaa803f9924eebdc290012949dc56571d2240865d967e1d01004e79a2d2962e01d5a639a9b6aa3976a840ac57941376e5eb7ea4b8357b4141823811f33ecbe7e84609cafb34ae993cc1ec083340819d54fd8feca0561409dbd324dca615c0e43a6ff57ed5d31274a9cb1336eda16ed098e5c4905979aefcd726ee8ed5ea240e842e2545ec2781e20b7589d6d1838299316f6f207a3c77e397a0a60bdc62a94976bc499003a25799a712e69ccc1d92510ea34566dec564c0eee0c40da405e62d4d1727543365fe9f07c4ad15d4d602b5be4b9d3f1d904edc9023c28741d4c23cc32c9faaf5c75a5f1066ce46fb38a4c5858a56902b1d35afa05049cad61b375546d3340408b5d40f4a0c06512b69518f9425b4502520ef674ef8b6b284b2b0d134e1e12b52cd52ef40bab29ce78edb5d7d1cca7d15991b785d796a991c207ccad4c910b93e39a62e18c862796ed5980c03010b12357dfa3510036906d2001b15da7fc0d653927fd776072cf60098b9755dfd0a3bd1137feab12ff2279d98248e0cfdedb4d16f68d74cdade6dee6ec9dcdbc19615a472922343ca27812c8829a9e2e75a9c7864d2afc7ac19d207d595c301209384baf4ebe91dfc97b504a62e2d573af68ab3a7c112ea177a561f1e90be959b68ac63b4498caa8e20d27f8f6464e7741e22092c0c671c1068e3c737afdeae452a2473c635396988f59b0882dd99334bbc39ddb42a2a7d95e5eedb55eb7868c52cba7c379b67584773f24927246d4a1093a460d727f650f97835cf7237ff78c6c4e93404e0686871bb618b6746813fd5737c95ed7e968c7ec47d0af8832fdcf7fa19abd8b6847672546a1205b899c5e9cb4862622adf4668840a489c5b2eb5b279fef5aefe54f7315243613e29a12854f300cfc4db5ff0a10881a1e64078fdb80f196def5ff3e11adf1c2b2c68213909feffeed7708e2217d8c41954ae730eed0e97ecb26e5ff57e3828cb8d832e1dd30a1033dc9ff2935a76c04302947fca598fec5599f64ab26785fcdf04d7707c34f36a79d7dfbebc892da313c8867e39253e3cb5e5dae423c47d9c5a044ea2588621dbfd40f5a2c95af9d1159e9253e82e69398bacfe63773c6baba3e577784eacbc9ad5628b66d16fe85d9d85c076287720f562dfde16229ffe7c8bf12a68cc79e9dbde3fd3cff0e5a8865221c40c19d75431a7db50d053c9de81ee8b0944aca37961ef469850639898d65574ee7578135a3a7e29d5e7e2abb92fa302027107358698a31c9ee9c905872a1db9299ff568ea57b37ca494fa30a1f5a597e2078090af2b3c29cd25bca1219ebcabe0cfb7a4aaee501fe322142b6c8ec11ed4d5bec21b0750f780385ef0b584c8a6f585fb1cc76ea8d3550fa7a885b450c550416b88a5f915966f16c757a8640ce8d6338b6b31db005eedb9317b3c6b0d4d264e8fa93d281d353cfadcc4f1f4e139c16aa4730b1000532a1ab00a7edb1e872efe4287e2d3e7def93186397f0ab5b08fa8ef601f010b390d1fe29d9d1e9be6104192f4eaaa4579d99e70d6556113aba4f6b9c960c73a49065c9a199d3575738fc343f69a997f72604bd1950f631ea1e378f524340aa8403d3df3c284116f93a08b2647b0e1ca11a74b31d48333dcca396abf22ced8a4a5d9ac5122843b9489c920f94aafd1a008ab760b3fcf7e58a5a258782a8acfd5ce2e7f96ab5b97e7a03e14cb4b1b21250124863a358f430a89d0392396885a738396e1165272d5abdb97f24aafa704194ec4745e77b8f080771bc29d04313fa34d5d4fed26ee3ba69236b476f48a46f174dfa36ebe7cc0cb1d2cb45fd3b76f7af4cf84d5d7f2e855dc023bb9bd900f0ff234b47d4ed2beaca899bebedba7bb381064c998f7e5164fc121c2149bf48dc7bb723d666cc5582ea9d3e9a211f410f6a68e6df7509c5a9982fdf67615b8903b0ce9977fad5c170430af5e100ca2d490f12fae928c742a5f249adc1634822094694766e8af9ba7c3013ffdf0d5aab8004d60a84bf4227eb23c33e52a4f4f77686ce1ec9cb2700355285f17dc640afdb71d14af0af8c0fcb4595791d2207950dff333ca6c4efeed6b44afcd27f0748aa3051d32bcafa1f2225193b336497f972b87d9cdcc702f52ff39fc5835c10f9602ce9106fc275a0ef1946676ab280bdf486197289b589c57a1274728fd08beb80c070e320b951bce64e912d1ecd21c142c829c99f2c8445f4df82139fdf772d5356092726a86baf3cbc3fb41e1007d5e1aee103450ce19b572ba277219b076f4f0ed946fa64da2a728df2bb34ef9f32894e188999fc80cc8e3a4d8266d3e8abefacb16a5a1cfed851219748d94a4cb27e349adf9492ff37fe12090bf65ba61c00c2589744c72020c2ba95e704f935a41ca5940584d0f821fbfee13c88d9db9a416d5d5e43ef22e82fde4142a0c9449ee53b91fca6e35a3bb703d8c60b868864341a6284f7eb3dec7aca818b9a44a2d6ec3cd4a1803736922fcf749e04da2f87314d6cae6266c5650329f7086ab8474b72b449f5d966fc018f95ee7c9b124cbd7239e5eb599aeba4df725463931a383d5c05febdb3f7d7e0fe6d1ae249d9945f35f3e5e1891eba0b494c68f675cce45e0f23129fc787df9f3c5cf177f00fc9dcb9d656e6473747265616d0a656e646f626a0a3130362030206f626a0a333637340a656e646f626a0a3130392030206f626a0a3c3c2f4c656e67746820313130203020522f46696c746572202f466c6174654465636f64653e3e0a73747265616d0a789ced5b4b8f1bc711beefaf207c922db1ddef8760c550101f0438762cefc10a0804b3e4683d02c959f121d80efc9b7c08e0df97ea57f50ca797bb5256400eb22feb614f4f753dbefaaaaa4d09e333eaffcd7f2c37176f2fdece2c11fe9ff068f8f77233fbebe5c5972f999e314a1c756c76f9fa8285dfd8ccf0995194482967979b8b479230c2c9e7976f2e2423964abfec7275f1e81fbb76d52d9b55bff7bf69419c5236fdd6ecbac3c63fe6cebf22d3e33ffd234ab8a68689f4ac3d74cbb805c8e386f2cc9950c472359bc32ed499b0fcdbb8963962a472698f9b91284a10c59d9a88a2882912265104d54a4c45f1625baa06dbb77f6cbb7c54380115f9dbab36c82309b503d5f4ebfeda3f17927021787abe8f6b39984267418e876eddfdd66cc36a4b1cc3d537cdae09c2482229cf4fdb77610f4a28a53a9f717d6c7661a9219299bcf217107cdff5db36aa4513c751c4bbd5a2076a99fbc7732904314ecfc0304449157e5c36fbe01b1c94c25cdefd9b75105210aa6956d426ec0d96b406dd649ff5a1587ef67373d51d8ecd3a399c4345c553300686e7f86c9d94218d11a7ce1076b0444b2d26860c0a5144709ab5b558441f1466e8830ac240e8acfbaeeaa72092143ceff3d9932426b5f8ddb7c736392dd7968d9d01ce530e7fdc078b330b162ffadf26652a8a2f6ffb43b3ecfe4cbe4a15cb21d66f933bb2b2b8dbfef1267a92264aa07f24cf1dedbb6eb2f445a1fbeefad84521042752a1eb1fdae81692c2163cba8592e1a7d7fd6ed33cad69546ad89b414c7342056761f54fe9a3b09318a99a19c2b4ca02bfaa699f0ba2ad9ccdc1ff9c764a84953f76c9b10cc7707a953e6219e2469bfdcf688b26d8465531c29c3909a5a06f0802eaac19eb5b1126de23b64690d3048fe116d6ba734bf7872899b7813cf1223882c1b0aa43847f06dfb04523e12b73ff192565fef4b1c907e22a7fe4d718b9c22984d514790c2c8f12828a8eeb438abc39bc4ef4c8296ab276db2c17c3103ab4d9892d47b9e2e1613721d0498edbee8f65443e01e2d92cdc3259c51167113f7e22512c0a18290d38a0229cc7a4f23cbb06d56e1c089c30c6f3e77eee1190ad442d620250c503208e231e0360d20182c58801dfb2c58263bc72449bf2c11c8dcc21fe275b482a5d8ef9042f1e822dda0c94d8e69c608b67a16a951479e9f2189f825cd2a1728bc23926eb75426c0d6906d3e3293e489420c7302d8bc134fb6ed5ee00bd7c620a1031179026b514b339bc2f5cc40446920905e83abdfce331f9a6c18f1cf77d5a27258a79736ca355049ca878c02a1ac5af0570ce473a5e37153d352959f97c979d6df2f176b7eb7709580dc3582b3a2e1eb1ee2b9a5b21990177ba0d6e6beac43084f4dbef13cef211ceceb9e6c0260096b9cfa2ae9cea1441bd482c6fb8f83c87bfc4d4b83c36dbe89ec2c099f0e3b51801d2929c1c7258512758bc5da6d81980cdcf08364553db1e25400f2d405d90e38381bae0dafb027535a1cd8154119ffdc08a3692a2afe7d3e455729c3b97e39ac7d1f1e71244b2608221d9faf7dfbefffbf317df05a0809fb5ca96f8e6e5cbef5f06e920175349f301ffc59449c600ce2dcf7f372517eb587e7d3ecdcbcdee7aba8e3f9d6e0896689787761598960f432439d1469e9886c4a74136e1b247bcee8fdb5562ce1013c8147faffab8b0a07a38d750f957351f076d31c6f4ff8d933fa8437f38f348d845393ebe092621422348b5bb3e715266f1e3b5202de9bdb0a911123b759ea14011538f30e149a3b40f1563f28b7f9e89b117dffd78f9fcbbcb17cf2f5f7c1f42cdc22a97253f8934f7fe9126bf80b56a1aabf3a9f08360b31c83edf79a83cfb9f5042da23db85458594ba1cdfa1d722374d13e92300d21821e9a931855e6348929e2241fa5a0944021d9669e122bda317739b4bbae07770e710fa809b52a7e2ef3492a54954f820b58514a9775ce85d64dba008948718aa75eb537693d57e8c3ed1602f6cf1c021aa3bb49caa05c4f381ed5a8a07d977c581611b07cd2e51443b0a01479ef6f6f21cbef564d2440062affb11f466e1b42c7e72ce42bfd8498d46271c0800775c15d9c5d1a224a257905143295ca52fa360e72a3f51412ef6a4b586dc63afa9f003504e03797b31f2ed8acbbb05ccf84807800ae6aa4f1ff01058551b35d7bf1fa1e6db031dae43618e40bc241a1120a6c091cd2f7c2ce834ea5780571b2bbbcdd1d168fe4e2f3043da029a5cda83eaac0d7b3e9e650374f33f0d7b7e2d9af31d5446519eb3e82a6b8a7bf46dca929753f78e68fc5ed3a1a1e872b08c6873f8ef059e67dec7ef634eac9f4d9abfbbdfa53e682908100fbe4fd9d051fddf3eb1537d3d355d1c98c6f470a79ab93090310f2f05691ca8388bed32ce2b19ae6cca176755918b51bd8a91b6b3762ea24c90aed59e96ceef1d0c495df6676a735b2550055203ea95f03a06a2432f56d7bdd1cba7789e17280f171d6b15261864908dc240456864eaa7841dd24832a83b9a7dee1591fba4d9f257012cbd637ede666dd676622f00724764ae21157ed5525a3c633f0c119f2b114ee56ba155423f9c1c4698dc5947217f5956018dc61b100837e96d66ac5c7fdf9b90c5d5a35f25acc44509cd4329115988946e9daa7498e5d8505987b191a135c10274e661d63cebd5bb551992023936aa2113d69ecc13a8109fcb06b520fd010cd0bf1eec06eed263a8502bd72ec841df22eb41cb190272790911f8254c4716df8d9136cba181b420f9babcb7e133cbeaff177e5fd14f3ffe3c523f144c512ec34c0824362333aaf3929fa24942254f17bc42b0ba50d1632d59acbb3acab759b382355f46c13b146a1523052a2464cb74f302439522afb644a7d12018bfd1e300973726c3bdfc41ed82e79fea0b5f480d4ab5404b752af88990274e54f1b3a769687df9eafda38e3819d98c24e2a0e798ce3f6c40535d0537e1b7fa7164710b7171341a3200453881ba3e91bd40738bdd92efb5da80304cd40b2cbf316503ba2cb61970a1a70f182829321a330baf8ca26f90ad5187bc73478e3defdb1fb3198ea01720ee3a7c94dd1a8614b7ddd36f2f2f72def63a1e53b2986615d76dc26bc81ac6cb53849290a3e86acb2595f1fb7f1bc901124c7c5a5e6f3750b2ba7d82620734e9eb63538643b55fa07e7e7571a0c8a62acbafd21ce09c022c295006972161468fc26c782d37aecf580a41cd94d9e323e4d780ed92ecbdb5fe52277d00caf63e1bb1c8cba742ab711b8c1bcda8d11620ed9936860e0c31ce4c3af5b1ed7315a01bc3177978e311493d86b8f304ded788803950a53f8e67f36399952942b64eb515fa74f1ff083388b988beea9bc2bf3b10a21d6cb30b5bb06fdad9ad59790d3f2df51f98a14b75a607693c34127d6aca20c4443af28e3a0295df67d9c6378aa3190a8a69d6cd5765f4d4320bec646ceb35ac270409e8c188d5a4e777190792962ca6251dd27981a12f7d8d49820212225a3798f321d8642969d7338783d03932abe89f44c338484d1ad02df0a61955b05a0fa130333e2d4c9742d45a99faf0d7c679b5aa8b035435ba7d114e7653455db17b12e6c2c21eda80ab33348de81d8c4298b274d055e53cfca3153e6f3de0d9f2450299852f815e3d36ee5406bed7eb9ebae32c19225c3c6f0050e0e4c7e8cc89556c8aeade042dd9e39339686692dc1474e3efec860e6e70a673cb691c9808368e7b0f5800144cbd872eb27f4ebc4e49cc6e7b5e155c9889ef996d159bbbd8ee362dfdd3508ee6fda1c9b0c6d503bd7cdaebfde359bec093ea5960b2ab5f6f6e2512d22fd151b9c1d7f558dc7f1158dd48399b69929f30017480d3dadb2d17d9f3d7d966073d07fa95e4d0085eb728d6209f5430a7f3fa8458b631f113216f6116bd3c2e0552a502b1c8bac7d3b35ede9a442e3c6a5465ac4c6e32619c08af3c461972f41c196c2f07363eeac9dc1dc3c9580b2b4275f4d17ed915a0f86b62178ebc83de71a429fba5b1a20c534098e3fd9e6816d732b03eb6fb19775fe56d128fd55ecf5153e42aa54bfe3e33c0a7c88b16af5da2db60aa7f3d783b87c204b257d512c138a9d4aa7be66a74aa13a4c8242d069eb6090066a87aeb9c8abbaed9c01e66bef8cb5af524eb9c7052d08944fc69b1a6f3aca0918981378c9d51fc1ca0244f16d853b22f42f9f22f4de46ced5282f97d67e8df2f93b93386a8d5c0c1ca1d2ffbbb7798b74b7073190fe3bcdfbec53107f7cfb7ecc383f7184b9b0c0f241663f0ba4e97a63ba8d0d0f94c57b36c7ad6f36359b74d5cc5f16d3d8288cc6f59d1576da7a542047b92480152954eca25c2219b7caa09a53eca40b2bc0a8aef8cda64b1d1028462cc54b390dde23b783597e7c68e1f0a6da3b54be918ec23cd8c5eea759163738689fb820f84e36eeeab8ecd2bd02dfe3c312a8c1d616c31b68c7fccc701cc3e44b857309de21dd786651da746513df8d4b9f2b57c28ab9cac2ec5f0c82b6dc190a4dbea4fbc190a5b641e6bec65fd33cb9c5c87d87b05ca2d85d1fd344425262edc0b5f6c97c9ae225ab6d5623e3830148938828a70808a599c84c193bdd35281aa9fc83ee48f94b97f8b87f32f504ec3b163fa85ca52ad782a53627132ace7c0e15e1ff76b136ded764610a1bc6aa3f5cfc179d941e8d656e6473747265616d0a656e646f626a0a3131302030206f626a0a333333370a656e646f626a0a3131332030206f626a0a3c3c2f4c656e67746820313134203020522f46696c746572202f466c6174654465636f64653e3e0a73747265616d0a789cb55b4b6f1c4792bef357f0b280bc62d7e4fb61ac77b00be836c0eec85ac01ef052ec2ec965f483aaea26acf9533e2ca0dfb79195119159552d52d6ced8172159cc8c8cc7175f44244523d5ad48ffd33fb6879b8f371f6f43a3d37fd352fdefede1f63fdfddfce9ad8cb75234514479fbeefd8d9c7e266fbdbaf55634c698db77879b576337ec4f77dfbdfbf54685c62a9bb678b7bb79753ca535691b299dc4b5b19bd654031b045c7bbc74bb362d6bd50817222e774fd3a7a21142385c6bf7977668a66f451382f4b8fee6387deb1b51d6b6ed3809a074e30c2f9ef297ae11da9200e7a11dfa7c03ad1b5d6ed0eda78f656302af8dfd78ee0e59ded0046bf4b3f2a6b5d0f8a0b4c2b5cf6969231a2dac3174d9cbb4e19fde2a3f5338e84e78d2ddbe1d51760757c7c5dd292f46909135dafdf638e0aaf381051cfbd3b19b3ed71e24d72ce5d09f0f93aa6ce3d954939ca2515e5b6f688b73bf45198ce68db35c4b6fd9181d1babe5ed46eac61a3b7dfa297d191b1d6db47483eee9d2ed27e569308bd12440977567bc6099d820562a3a7de8c6cbfedcee26631b9ff4ca3b4f5f1b385d1725a2034aa1353bc5e1b11dda6d3f5dd9c0913690c3a0bf8021b461273eedfb6d0f47b6932bbe7977fb57888dfec6c6706b3d08064ee48d77b70a141a94bd1dba9bf75f116dda5f8bb6a09b6821e28469b4cb11f7e70dbabb749604fde9b59e4ca89a102549fa6fe4bf26b2ff7e1ccef7afccfd7793ec1b0326f764246ba64f9a66bdfd9bb76fffebedf7937ec0c38da0139a4a054ec47fc2fd95b08d82b8784901fab55d2be087ef7fa0c5a06831e4ab5bdf2869c2ecea9f727c4cf75146fd33eea3051c17c217eee319aae4ebf51d2ddb53903dff7d6de2f661bc7fb50964620b3f8c7e76cd0ccdd32db5015fffc7dfd20040dbe85eb6dafa463fdcdfffb0b6a4fed7f6ffe5b151cd3c16d0cacdd14a01aa687bbb01103222a3956964a3a7cf8d6c826000f8efe1f461680f19f79c6e14434e81d2987e817093b0d4019a331c039666f0d616f29ea42d3aca50219a72defef4e12ac8ca00494fdf6ee03c0146ae92216c509c898113442001288d29d841b07ada237e29a352fc25e4c7e10e73b415b160efbe3df74f9890b5e07c76cad81db463ec6e71c958b70063d0ade32d49b788c6d640b6f30b3436b563fc65fa0e6e2b0b687fe8b774351b255de34377ec86767f873ea1ad227199965808074e97e7cbae6f877ca6d5409d2cd968ba31e404eb622896cfd64cd1e31de5d6c7da55363ac6c6eb304b89fb497e0d5604e6515d007d03a8927266e55e100496090cba9716ceeab97b11a98910e125db9dd04385611ef19895a81dbbf2295308f85dcd94ecd7eef0b83fa1fe825374cb3db290e449c65ebb3ae82f7a4bf748e916af61344b864e9a72b3e3dc9c7332b88de10869f7db4b962231462f490d98efc12e2aacf2bd2f7b8e1774fc085ff21d909ac41039ee5820082dfae5f7edf67c1afaccec360662d1c0cf6a306231b4b624c671a5deeb34f0d00d687760212a926cc7f67c01cfedc6098c00d0a50e74eb1ff938c581058cf6dc3e64920a24cc3159ea8e6bd9da030695522cc8c3da1d46fc4a7a3e3a51ec11893fb8a35adaa13a64ee0cb04b50a4e51703206a6d78ebdf8ffd0efddac4e4f22f39309c658a9fa241a360defef1d26553a693849ec5e6433b9ec9554414cb2a02bcc51600d8b58fe776c0e0b005e5c60b0592e71dc6fe888bc2b3bb9ddbdffaac4eb88777a44e0e1693d232ad9e1ece09ced0c4da9432e14465023074cb120fc093271d6948c825619d8ebb3e3b8506aff29e3475ee689718d597225a3b364c47c86c4bc152d2169ce92c5fe83ee3271427c1f95959b4c4b03603b34acec1b88c910729d9e939ad6941555c09402da11cd30cc8e40a552b348743a9100abb07dccf87ca54dd953a8b5255a1015b08d723e63e5ba9ee44cc4b42951c20c96c80ca20a5f80b068c68802dc72fe8b5620e7f18f1511e6f752983f608ceb12a11c7739fa301621702cc2d35021963ed5141f3ae5fe609586246281d19f031c126aa34abfb517f209ae32b43748dfd0e32f5e4dc5681a6f867cf68aa86110e12869189df89396b7cbc0c25436a0604906b3c9f9098492d6833040a305db0aaf296cf7835ed17ba018b09a629845ce49b9a19cf052cd1ffbd3d66174b6c5d960cf4db767f1991614176558c9a2dfa9e4ae98ecbdb33ebd931d1049d3df6ddaedd65c3b844ccd515a5d5d8dba25ee00a6573ca9090af18b2003cd0867066f1cf1d691d960330ed1a54b7a9d63e237401be3837f36a085469b9ddf2bfe0a7db96a950f42566fae3b67f4c497122f91b671bab006336003649ede9a34de69c42193ee3c7d3f10ed1347a6e6c3c933d801a93022ec4ac6da1173b6c7df946477695999b2ebb3a29fb695f2203aeb1c72d20e32f832eed1b17160810c7846c4fdd307ec66c2402071cd0f27d77b52f0317f791b9d004547046088c956fbbed0551d7d8450533079c015caa43e35b6e7031c75091db0409987b606d18d3108a9cc8ae313ca2a8a976749c7d182f36202efc64cea3318c862c91f1a97315cbf1cc3705d703cfb278d7b802e9c099015dd1a9538496ad773d78e891b276e18e67b45f00aac357d83c6208c50aa39867cb822a73a25df25861a45ee885b321257246ae88982c38c484d8951d2a422c02972e672486a91fc69a78e87348f920955ffb869b134de0c709cee6597aec8727746d6159860e298129dd3eb69a4b65055d0af20bd0ac0dc15361a39fb2398dd59c58f35da1f036cc1309c5412e6b4b266ff71f2f7d97cf83bc0264c52e95e8a22d948ebbaed615dff940842019ad045471051fc4cc9b11d65cd9e432920727182b9de433e71453587ace528051264afd8cb8189113f073ae1edadc7587a21412bb5b60344560327e214157e8d2d8ee7b6cdf03c65841feff0748de11591e9463322e4b4a07fec34ac3b8c84914c428a9e39a688948a4d6f08880a00d9b04b2215325a86f17bd97391fbcd2737e9e686ae27f904e72b90ffccf4299ca2929f11de9c88c3fe6722211ce52637c4bf4159de61c07bfacca40856a0edf78c9aca93b20fab8aaf8034fce596d99ba924f2a49d24002fe4c0ee805b77eb2e7406cd842da774c7ba1368f4b578535ba0da1f8649b9032da2aad386f566016a22a70f819bd5d3a6e0d00e1c8938bc4c4a55ae28328350ea558501c13d50c2c423aa625a7f5d236a731e3849c75c19220a274f77edf02653a5f4fcd4637bea45c4acd46b377fd78a19828f51e58e1b4c140864250cde2f840081174091588d71dfa3e6072558410c214877b4afc8e80c0c4754951edfb4bb7a50dca6ced17de54ea158c54b55421d7d69975e1015e4c67fff1560a4819c3aa9582a060c3aa4611b6829507bca82a332146894afe437bec1f99df282054b4eda1dbf519bc217a94acdaaf98218138036ba83324ba35fc4097bed3e5882d51e0655a32dbe281a6f2bea4a76d3762c33675ae0d07e7274a048a97ae1dd61fb39f6efb9c105dbd07eb09f8eef37ac20420cc7c1e9ace325fdfe17382e375006a3a54e55071540a35550e43284194b680f30c07151f8422a06216a73c884c6c5ef3deb954c996d2f33c797ac4e450b942974689346985ece0af4c07beaa986f29436955f063df51d341cde826770737d2a7cc382f84fee7d822fa85ca1850841da97f9fc62aa5a988cd7a578deebba77ec7ed0e159625a7029b9612bab4ac20101447c2af27acea754cf6d6731794c0fe788d19484a0f85811076a5f90a8ffa3f6569a3f2853e5cd972e6d36018e938db32248932b0485d00aa0554d44bba3d62a4c7529363cf0c0c23b8a218baee90e1d924edbb393e3fee5b4876c46866b9ed998ebc2db5fa19412e4d3a445892dcd49ce60d7f693fb4e439ca15a01c295f3bb56491265185f5fb031b59a6f7e0eb8900627301a8b32a4f1dbed5df6d617ca7f710f3b03f2908d2cd8b1ddf548cce47677794070293aee708b54e12cc3b9b1ba35338d8394e535330963aa6a81e34b77af6023b14c7f8bd1ba802b0913768f7eb4d8b8d54082b1b69af968509549d9a4bd4c483f1bae98545317d69f2066f67f915ec65022f5d684210f4f3461c2a2342aa5b8d9c808f966e4a75d178e5a23eae2f1ae49a1a281094ec7f1d8d77d493346996a016cd1455cd591e0748d65baa0d264205ee3c8bd86f6bc8cad47526310f09844e473ac699261af6cbc3e72c96089ec198462f2214801e86fe214fc4f53470a45bfdc7883a50a56ebbd657bbc384a90bf51d7bc24cef57c9def85892fd489d79088a588600bb3e8f18c07cc0639905e3982275dcac59f52694e13a95fb6bd58c984d32b9a548438d5596b12922eb660626ec847f8be6c3b70ce2001f56ecf10ec5898e87d3d3b068403fb78b075f0bedf354b2240f1c2a25061c4351f5efc77ec04ed03405e1d95b35c6f5a531d17fb874771881d1f1e6eb1e7399bf8d3dd4d4c42ae04ac0ea4837dc4ec6571f9981a0ec525739716ea42a5dee68ba06f0095e5587d2975ef811cf4d8fd4a4612f4a6babe726891df0edfbab55556a41692e97bfbfb60d703b489f60fd9a33fd0b4643fd780a7cebfed5eb9fee5eff7cf7e7bfdd7f376d1665b2369bb1ef863375eeaa8752185cb3272a7f5b9fd08debcf90cbccd6b865076a15decc836afe30ecca21eba59f272b29a08e6ef1642fdff9a7bb9fefe0c253f4c091868bf8efaf3cea29f7e20cd6f3bdcaa3949f5effdc5c33189c9ef8b79d59e30d4d6201ed2c17c4d8c2ad7b7e1d14089f09474c35e844bc89b62a44f7982d7560249ff9f2d251d2b3d7d26b2323ac5aec49fcb060853abd87e2e8854a912638263d4e58871c8849e71c32bfadbb3e972dc64ed5d2e35a3b7ace93cfa51359c9f34c133eb1fdf2a6b2a5331c27d2fb4cc52661ca146038f4676a647a271648440d1e5053e1f640f5ce2d92e5546ccdc775a8aee9516ba97b585d9221e71ff5d862520930a9e5d3acd9538be3e9cc80056a5e0256d294a91aa8dbfed0ee731c19c88771debd4ebda2e8bfd5eae5b5c5b3562f1df35c10a1e8da9586f515a5de93e5c870a63ce0a06c56bdaab842cecf5c7ba55fd772de609f32841766de867ebe370008a398e5fe5162869f465f116aea6a01f366f63240d59b282436752d48a9b847f78efa6389f0b249a8d39a869bfec54e2bfdba5671a950612a123c3e6138ba6a6a72adb3cf538f42a17fa51d7569d4d28390c4d61cfb098460560d981368182917fd49bae5e3bdf4b28135f80d702c02a7c82f4df05b647329eef472824f7d86189c9c3954e2cbe50d039665726a1b30b7ecd308733a144ae2f262a2340fb47dfe6a69cc4a2d099bdad07aeed5202b609f7cce1721af35e88ba23c8ee0479cce7093a27b9f8c430f16bc72abfacaa776d6aae8d48b3717183b427212bf7a39fc6dc5449efb9e7593848a38a14a47ef7460548915aaa4e12aded4869ae03fe5f589b0cb30efb06127ca2ab97e360adf94f000a28c389cde3b96e90abf19b5de2d133f8976ade64576ead23b51f64614468b757d7287cc3a9817ccddd1fb032dc5a2df56df72d7bfef86d2ae0ae0b8227c41fe971fedca580a24045515cb8359ec64b8f4fc71e93e4ac6b5fb00d929839c34b49ceea4a128e08fb717aa37d22b0f5fcacc0bbd0d81a85d9467e5cf5942a9961e879e53756a0199a2b69747aea23c597afead8eb5d54825f54b40f320ce44f15d821e530a26d4b60eeba6b88cdc65ce59609ec1cf657850b59da805ef4bb392750a195b5586c7df8ee5e9eee98c20a8d3e085847c7f1af0af9400c60a545c9393263fa937c42c6877d9f6799206124089656b4f8dc08235e3c2853a641e0498774bba6138e53fd8022ca88af437f8c22abd6934656040fd531baa0af8a1472f3269543bcb48101471ddf28d8ac30d390b010364f652cb333044b39c94436cdaf50058977db7976e9892677af4515a00f4ec3d8a7532d2c6ae002ceaeacf983eece9b54335a7664aa283bb5aa198f4975fb3423c3f344b3f5b552fa9e7cd7b7f4db57c97699cf191dfb07cc40603a03544a90f5ff16ea0fcd59f679e81989f46888ec5bf8e63b9d902b94114241ebae9bd467eeb93fe7263ddfa56b108c04f70033b5b1ae1f368d3b333ef60d32dba66552cfc42758facfe406d3ce3b6c28559a9b104fdec16a68c270ac2b4f4542015de72faf393e032184a9f7e34fd95ce5f6ffe0ffd78d0af656e6473747265616d0a656e646f626a0a3131342030206f626a0a343437360a656e646f626a0a3131372030206f626a0a3c3c2f4c656e67746820313138203020522f46696c746572202f466c6174654465636f64653e3e0a73747265616d0a789cc55a496f1dc711bef357f012408ef546bd2f0e602389ed9393d8b20e3440c018ce1bd163bc859ef78689fca77408a0df97eaa5aa6723454948225d88793dddb57ef555f5b08a8b4b16fee31fcdfee2b78bdf2e5d25c3bff868fc77b3bffccbab8b172fb9bfe4acf2ccf3cb57af2f78fc8d5f5a716935ab945297aff617cfbe6e3f7bf5eb05d795533eecfe6a7bf1ecf5b1dfd7e1b1649530161f9fba7db7abfbe7f1175b39ef54fe6538c4e502966b61f3c36dfbf6d035ddbbb85c569e1b9f7f391ee299aae2cef3fc6c1fd7f98a39ebf2a3fa1497894a4981cfdab74dd7c6d785afa43178d839a9c12b6baccccf36f570f86d883f285669250d9ed51e8e716f097b7387fab5bbf6b6a6bdb576b4f726db48916abbf8c45446705c76d7b7dbaea9b7c7f0d38b97d28eadaf5c650549f6ba6ecec7beab7769e9d4511be95dc5bcbedc700952eb64fbb6cfc6e05ee036d164bc125c6b7cf4ef3a2f635ea0b43b7cc639bd7aea6e876cc86004ad48d72fd6c4df285b71c34126f024b72aaefd4336b9527ea1d8f5b3cfaf62a038062ee568f9af7ebafe2c1e205c6598c553c1a7fdf9981dc514e324653c229cadd1d33f2d4f6d4fcb65d943936713b36b5b0946b1bd6d97cbafaaf06c23bcad947713778cf464514dab201ac90bfcfab3f42e3e8eef6a357ff76ae55db0d052942f62046e0c582da4511245f924e6d2205f26a184a89c1368cc2bbedcb75bb1dcd5863f5fba682c355ff1ecb7f0fb15e81d7fd2208da3c458f1d8eab97f4c7b54eb49c12460914b01689217be8fd60b618d6e3cf619599cb67c1a09b2629c8cbcef4efb186fd240a6a004fbe3b9bb8faa436c68868be34290457bd236c38a00bcf17450c20e50145254503e9d9ee795da28f1884813f8000372a7e4a31bf75dd25602024892ec14414155c23b54ebb84b1a00b86a84e0539b0d2500c65182f0c8402c323dd65c575679dc7edbbfcbd6908296d54b030da73a0a273464199dd00cf5212928411825f4c21e42157b74fb047a1bc068586d275954f7b7c33e0118608673a5121cf35ebed8b63d9df100e3f0d0a808e8c120f768612e4246a122dde174ae0f4d078e898e34606d66c891a7bcaf3454a2b66dd3e52209f5d0cb19220568b6eb4e0fe5d3cac5d69632e9fe5d7608b8888263d7a5d743d00a2a6677755f6707284930d7d4bb66d825d7288827cb312028bf73c06a78cf30ff6068b47db233d4354725ff704cfe92e02f29a705acebef73ceb3925ad1de0ee2d718cca2374945a5a5f7e3f872951bad22f514801411973abdcba53528e7fd723bc89cdb21d900d2dfaac26f721c5b2171ed70c8a55f738e671f16c6886ed984588aa89c5fdd671b0162314f02b5c86ab454e8d7e352c1644a4850cfd80cc92002cdb2e246978652ee0a4bc11cf7247bbdbbc58782c0605dfc15cd8fe7a4111416eba8347c883daa6c752e189afd1b48b0ec4aeb1586520f39db770df2475b195d00ed50c24ce9092c64b3692066442d1f81c4b00105cfebb649920023124613ba61de6aefd0eac30921d51756b7ed7ad801cb8a93b41ae9229ca605a514a67e4a37a86a45e0ee806626e03dd7fbbc87d2161fde742970ace39483abb086be64c52a75823a6d34c5dc69c8b1a11ca15653dfd54db7adb7b92c49458619418c94043cc8546da58b8fa11c64dc071a005b2ce5a2204f6c75a3009e989b92e0f7761450cc2d6db4c5ce46956721804f5f60d574e4a195d2874c42380afff6d7767fb74b0e53f08ba414206c57d2af62fb9c5003d61be60ad6fffc684b6081fb30aa8c857c0859a8729bcb85e5b254a253d37737d960a65225e591d33066ccdc19237b15bd14090b01d19fb35a1bc56ca822931c8446a31231d145c88f69bc79254988b051871c06725f2f3cc7ec342c78c8084ab8556c3f25752116942ade44ddbc77b463324ba85444448eb7e03124bfde95ee00135849f6a47e0ffcaba57952bf07951680058f7aa8fc4d2d473037d2e7d3e8db74ff98697d8a290599a688410ce76ed7fd8e340efc2f602b3549d316015d846e65523583308e006468ef316db59ec58950e5d50ff173951d2539adfdc7cd293fd440941f83c94c5114a0222d6c4fd81a5aab30dfeb300bc92d840a48b7e80c18884b0ab438f030de2c025a94deef7f64a31c3ba208937584ec2af1fd4bbd5cd71d960527738200958a6637db018a4642ca172fc52435a06a4b214b6f734e8c4804fe536a29721723a9148d2a43ec044790b34ba92ca5b79e56efeb6d9dc903749ee8a0c47d21eb55e910d323e0bb44879b018c775fafe52b541e678892a7a600d89435533981a69942189ae3feae3fded4b97a6908314e399f3c32871050de96b278f5255b1326b4d08a6a3a0aa39541f90e6dd3422fd6459994a946b408e9ae56d2cfe300b0cb5144776ddf665ec43825cb7d77ce241a187361983901801a3937af4eb0af56053f8f18d9a600d4f07b83a347456d56992f5a571c59ef73400402c2cc0483ba0300d819ddcf3da34a4db347ab16bc9a2b8acb8c0f8c0165b3b2247e7fb314fa88ef5b2d16013c3ae7657b3aee062430817b51bed048d496e53f7ef775e6c500bf25907aa0c611eba51aa3f8f1b0c5815e68ec88239e8be969936bd806fada3e132963295cd699fb9bac9f66d43dd787e45301d541d04a08f3634e66e6d58837f50d10b7049760a662e65d1ac4467863faa36c9fe003ba010ee82526b0404e805eebe94e080d242daf4f586a21cdcabc12ca3e4e90474ecfb8cc2c8987911b6637963835187fd8a5e884eaca9433e597a66fe917c3c8314d160eeab42581dfa4f3a4d71e6d774a101dda6cc11f9b003f019182251415c287a75079da0900c62ee177af759ed9016fb571660725d22597a84c0d43f06a817a7f43fc8c512c9d7bc0ef173f86f9c62a0e6fd2bc045a04a09961881737c249121013aa04ed01fafd9c19cad2c0f157bc33e09270fffb1e5ac3db2c2063c4008fafa1b76b3330694e8d4d6af7c0294e90f192b8a18dd204b605c1b4a0ca09ad52d7e614178288f816a9bc2bef13d98c5107dda2f0a50f83df025fc31f419ad1e4a60c4ab82175a844a95272fbb60ecc0e33230e76e4341e4025c5f952ccd25fdde57d5de9abdbbede50864a3e1da403281c520287f4f57e019f72d47e1db0608d023006c92906498c2ba342078416fe91b6f12423bc92f969181dcfdbc5c9890bab3b6ed1ea85e8f1629332b5199d07b04c372d5a535d3d512972a53c9d719807bc50eb1211a7241e44bab624028d6880b890c803e6bf2b73029a8972671eb3f07d97a93bd45453b92998de0d5071f3c41502c7cf2b0ce49c2726fb5073952821f8dac83276cbd30e086a2222a5c765e32458650c0d59571862af034e0434e576fb9ac633106b8adacde6b8ab01c8f2080d7c67c947d7cf620b7d06d55fece0ed21259383f2e6c42c5f03512ed3950f9db38d050561f66094e7c913ccc76c19674d3d4a33ca8e3e4a19aed2125b834cf07ad9530beef8fc684558f9b659e6d82f6d9f648184814a43e63c3719f8817f41f1c610fe73ae35cab3420b683e23cbb56aae54e116842e92117ea0ce49bbe85880fc2de61d4a8bd9bc03598d778bd1c64879f0d090af81c3a5a3f7fe114b214db181d68c7177840ed0abcccd1d4794464ff3e87d30167d07ae95689487afc6a1e371c4106ee2b2d827b2b20e52eeb47ea5eb83d7f8f446ed78d71eae9f7dfef7e3fea66fbfed1a723d0f3847e5e0f3bf1d737337bdafdde457d215e6a260f3d0fac57b9cf0f5804808ddad09c7233b40eb4cc459dbd9faca706a0cf2843d80be9dc1810583c902d6fb8ce0c27a34f64d4ffdbb70b30c3715d7946f0f654a4e0867e9e983b736888550cb69d683e7c30e0522e97e0c189afce0f33fb66580b58acb594007ce20fcf42aae19da7e5bc8fd88cc22f795ce4d5511953134d0dc63d584fca65c46a8072f9451cc5d4e4dcdc80e6dd3bdc5299c824650d350f8a1a1ee4ab0a9728b1b427b2dc6c265ba21904b17f761c84f6dff1bf4872a4117448bf60d7ab09961e6724c0df548b8438d728218ff9a45bb6d8bed8229b17d4e96ea739de3a5f3c9034e2836ae0ae93c2e368f069a0a5ffcd058ea267ec791f87de0c428e27709220386d0154c1e5871f017a1d5eed86732c842ed5adc6582de6a9e14d09516607acfadf0c2f300a08242fc41cfc7da8c46bc1bda6cdcd0d568626e40e6d771161c0f151f500fb2328cfc33d7de3ee1a855bd0122d2d01c169bd254167330f9248c98b88eb8e8a8537e242d272d722646d5aaf6d074549ecb88f94227edff098caa5d535f86b257be4728eaab32801eab2f195fa8cf997d92fa40e6cba6652a24dd13d4871ea3ac238698d34a97c9f3350ed9601356ead34788aa6916765813e15f40dcdbe799f88802c1f99a1350b91cd540f0fd295709ea39cb30d0126b7bf826deb87255303a7b03860a1f0c4eaa43be5494d0128d07202b7cb03de4e6077490cc942e39e39b2d838fb5ef11b66dbadc08816d4bb694e1c42c30e3d4904f02b3be03feb39a98327c5c41cc61dc5473b58c4c1d78f2ace2b130da7ba2bb814dcf22134280e92745a62aebe69109257e253295e1e613442dfa1fd6441845a680a68b2f225396a3c6912969c24ea129847b7f684acdcccae13934a7970635ce1e152f1461b5b5aacb9c4205d49d11c3096cceadeef9fcabab4928e7b14b8a5da9c36d2a0d3c690a2774695bf216a351dedb437a1ac7487cfe912a54294361f290371fca12285cc0e8a6c5ab816ea8852ee151b20f64267c1c38a6fa7f0dad698d095ea6a69f56b91e1ed0c6b5e17b0972cdea1075edf8f7f3a7c507bef163bea7903716fa5d0cb775ab8bd0d084b6318c81640e9df3cfdde16e38cf0dcf019a242f5f5f9c7f3e0ee79575cb6e2c9a6ce62232102bd3a3fbc0ea70f6690a0a9650fc18bfadfae2bf69f770cf61675f9e4c13f793e2700d0a462323e8002617308412c93b3ab4f225f1e1b57ab71e1b611e1466102936d227c0cd001dde8102e4ab69809840bba9f7c84b3148a66b538b3eedd09f6e53fcb2cd3e9e5cff779b6e78fed42cdc1c38976cc85df8e99b57973f5cfc70f11f451fdd5b656e6473747265616d0a656e646f626a0a3131382030206f626a0a333635350a656e646f626a0a3132312030206f626a0a3c3c2f4c656e67746820313232203020522f46696c746572202f466c6174654465636f64653e3e0a73747265616d0a789ccd59db8a1b47107dd7578840b037b6da7dbff825106343600964b30f0b9631b3526f3261349247528243fe290f067f5faaaf333d1a6d769d3cc47e31a59eeaead3a74e55b53122748edddff48fd566f661f661ae11737fbc69f8efd566feddf5ecc51531738291c186ccafef66c4ff46e6c620aae64a60c4399f5f6f664f7fd81eaa8beb5f67afafe73fc2b27aa66181a40c3e371c7125e60c49c5f5bcb3b3bb2fde97508a44b9f14bb7ab445a09a961cdf57af6d436ce46085254b368fb6be56d18094369b4fd62bbadb3520810ccd1ba0b0e99c4225ab69dff9621210989b6b5bdb3abc3f6b9fb8543348aa5dd0f55eb970bc42937c9b84d2e984a21edaace434605c2fdf60db83d861f98841df30956db4d8856039098dcebc4ee575deddc84f8342202604bbff95028329aa7989b2ada588fd82e9e4321caa5ca876b9ae014c2c0caa43056c78f7e31e02632be3edc0507a32672be70a7e7c2ff52af6d706ee02c8627e7f55fab6a1dd0e60c61227411f38b2ba60a5650a4944a6b8e7bdb8555257780325a8ab4079a72b42014f202d62c1cbf88f62b3b5bad974fbfbdb6dda66eb7cb8bc01f804da54b0d2b9ebda9578e491e152d90c609acf2db715c0b222538035c004926fd1797d67a6c315258f392ced4e19d2e675fff7cac03868c027b338436f28c9accb3835f850c952addcc6767c2886129585a16628dbc330ca7b54be0ba8f00b06190650f4b284d3219d736e6032199b625cb4dcfba0aec95df8ec1212435432e015b04e460f61b80017633661e1d96ddef625c02d30cc22a7030e48d82cbe4e936779dfdadae169ed34c83001a53707a3349691ba5486b9e8f785bdbee90902644e4cddb78790ae743869c271039cbfab64e36b8e411a0816acc2095f3dd27a6464268934cc7d69dd2af04279aca9269184e9083eaecfed81caab02797a074c9cb6adb4e66a54184e314eb754fab7102806c62c293c8c6c4a4852fc826a1b3f8bc6e223eac27522437e35497dca68a89ecbce0b6d4996d6b7b1b398045a69a0d80114689caac8cc06096f950ddf6b6b477d545c9a3c85daba707e4a647cbe387b8c424733a150a8973ad39261b14b4acf1c736d2056e86cbe1bd02d65a697dcfc7414d7de0c9640fdb2ea2c11133f9f398a810644f9589b0abae4bfcc385d48f2f18324b7141cb0b1e2baf8133511294171bbff277a85df6547a35e445caabb8a4d05e4390a02cadf827f1551ac13515eafbda55cddb08340560878400a4719f96599309635facb363309c121a461f90392ef5752677ba7522f9697c9c3eb005d28a9d2af6c0636a293c21e06a99cc84186a362359a7a2662b6ce48342eda17c78a8f7aa78d46a6804392db47a19d53c6ab67061d32c293606a42899d66c23e848b339e0c11fa0d97072760ae9f2e24c724803dc51455bd27ab8a44b864cd0b6e953e10cdf41b9b5a1ea317c878c4ff716854502ed527e750315816072de65ee60cd72770892917a57ce7201c96c182ced9b1df150e2aade3ab5f998b85c8849e2522646c495e494b8ff59a80f242ee591b8dcfc8f990b720a8703755c4045c13024797afd6a37bb66eb5b773f1642999b7398abe64c421b4dffa391d02328e6822a84a1380e6642c54d3ec54fa9b6499a4f51b7ab26cc2d8e97aabf9a848c24b98c56b106c84c89d8fe4052e09e39873af570d0daa4e4a956f5e7d81a42033d2efe94654655cdcfc73600062ddc207a3b8012c45ff23cf5c4a283892a8b0e818416b989fbb4ab57d12fccaa34771bb9e20f4e0afc5ad78e847ebd80fbec27e10fc7349fb0418761aba6fe234c8bd0d3c95eff77a9f9c53d734203cd39719d6f21ca1de0b46dc3a8073f6b49f838cc0155e325159976e8aa75f5620fe1acfd7d49f0928569999213d8dd0fe683e4a4fde4ba5c4ee9316807d0b76789df6e11b643bb664a778d42d069a498bf5a5ebc9c147aaae01cb4c89eaf237690f8792287b1f97d7bdc38957fbab8094abf486b86504e7c7c934d382b4078098010a5e847836453b9d36d3da30452a087e95b1f456a21697efc68ece7b40f4b89f2292808d430837ba14e23a536f94de52e54b0a8d3306a8e685a04359820cbc5bda82fa8648898a20d2f308c10c2d0ae4c3ac1cb4050e9222b418d3de793efe1e2b7ebe31f6182f24f02529cc0d7437a16be97316330cfef284f9617cfc3ad4ae8e24d197bdb3c8fe2e243ba4c2f10374e859fcc161e61c829a784c69c2382d7ee5bfb7e75acd6406080e1d92495e2a6e73d24e861262f2b6271fab48dc700dc68a24f6eb55f7d33b1db04a4531b8dd8d34735b54fd11408f8c9687aca1f063387016e0f59700a5f448f103f4c95348299841baa0b446fe8693cf5fe94e137dfdc042eb814e3984f9231ccc470028a7301781ce43de5a81bb745116bdce626aec9db02dd46573fa125d9b32bf78cd049cf34b510057bef93c058b085c92f64ff52b43e3e82e2fbe36328be0b8f994ee674eed27655eb9f51c3a9a131c7a47c2938eb2e92ca1d5ec99296635dcb4ae19c5e9ea1ed2354a3deecba7a63df37f5fe508d066fc2807e997dcf2e939a70980b28fda7c2f4537d8ae89b73b91c68e6f134a7256b904f6b28cff55d9ddf9335c8ac7b853e9f0767f563821e97f715d39e83c7b63abd7e8f604c6cd74819f1c57a1b3bc2d2bf6d2c0c0787d8be15c23075eca9a33c4e719f27a21adc3f446d2778df27435ff39b8934fdd4da2aea2f8c65b4ec1247447c7f42c4dc6dbd7d97a793681fe23cf253ba21b02c71e5edab3fafde054a97b53a66a3a7f994369ffd7f81574917a3b5acf1f9c34112c7727f2ee62721e4dc855ce50785b21b859e022be9fa4cb099f008408c5be9e7b31f677f034105bfd0656e6473747265616d0a656e646f626a0a3132322030206f626a0a323035380a656e646f626a0a3132352030206f626a0a3c3c2f4c656e67746820313236203020522f46696c746572202f466c6174654465636f64653e3e0a73747265616d0a789cd558c98edb4610bdeb2b8400816610b1ddfb329720097c08a043eccccd320c9a6adb3428522629c70ef24f3e04c8f7a5d89b48913336728be7e0417775b39657af5e0f4684aef1f0137f298eab0fab0f6b8dd8f0cf2d8d7f2f8eeb9fef574f9e33b52618196cc8fafecd8ab83db25674ad9844da98f5fd7175f3fdedfdfb15218873339cbe3fac6ecae3a92d8ff65555767dbebff961b7bf1d8cb26895118684e0ce76e1f8efa55b538848a1c2da2e99e16866bb68a678343bd7f9b04829d29a92b0e8dcd80eeb1c23cc3199bae93604525288b0716ada788b21d1fa94d77d5e55ee7e018e68a2c34e77eee61fb5953ddaba6f3af7614991a14c242f9b85fb2f1f1db9fe8ffb1c52c4c818f7dfb5754e644c2924b4f1e9e46229f521f34621ca4c4cd25de68e2b0e2587cc8dab7175fcdcd976eb33cf11c7a918fb5b34f775a192c37967a891309a3f52385bcd6b5e1e2081e59bb2c80f3e371acaa7890cdb073b3fe2cb335d1b172e635c2363c43aa30ae101c1cb8e9f4a7ffbd4f111ba2e7573a91a9619e493b2088acff34b979c7b1083b69e1b9f17d6203def6cebf094512c90517c0288537bb6aff357839903a2469241dc13240c5f66dc4c90f0475bf6767fb3f9b5eedbe670feb3f0ce6300b2145fedb6bbd46d26ae6ff6b7dbb9755d6d3d35688d94d213d75b9b1f00c20e8afe6cdcdcad6e9a93adc13d1f1eea3ff59beded06fc83f874bcdcc5b09dbbf29b3b14eecc08404231f2581ff803de052a9066318163e7b2b8358e21a631f006f42156f471e4740bb87eb7001ddb157079f36dd059eaaf1174aef8ef92d4181b05ca53544c9254544d67f7299b8e129e3c27663c343228b7c1700e62c4d033c3b99f426b682c631e8bc6fb2c11662226a22feb50744c520be645e9389118c45474389c16888884ac90460ab052f1c6d69e7cbc5029a2744cc4e15cd8b0ca29bb6a578a08a169e6bcb7c53978c02023dac8990b8c4717024371242e6b79f516e8df312033889314ed9271e50d212d9ce04b75ecc171a2db130c5a3eede575c82d3134c2acb76dd9b4b6bbf3f5990e75a80b040831bb0261ea4efc98cdc1529cf3430b1f451eea616f0c8729535c4fbcf98df5c26c3b1f0190ced14c4333e1abe9f6d7ddfc1af6b0474f17401fe38863dce0ab024c2f7f4c765ccc4c90373024e994c33e7bf30cc2a403ef8efb6029cd57c4f3c2767db3b5dd16a876ebd65e86469b061cbe3658479e1c72b073ee6ec6bc3970f6666ce05968b38a0371e79ddeac222076ced3cdf554bdcc95ff0a89478787afbf905fadff8b77db665b6df3970fbbb13478ff07e4eb8917d027355b02d535d7466841c176aec8a00674e2be6fa02e4ae7d425194b92b6eb6d2819154945bb0b338c1816a0756271abbe3c3621bd926879cd5d2e6e0371276aed4b5bfbeb25523cb157d1f87b0625c6937bf68d2d7cf621142a13ff154d9503dfe52ee11c2a8bd5953404dff185ce5d15cf6d1eca80b130b304d0053a16d8a4823ba1ef5ca1085a3c4eaade1b679c0900e214c78b5cbf306e1248af699b322455f235b5c0122a048c24906d53784ebe1ce04990b87cf94be1e51ec8df548a8857ca11e52caeeef74b0ec224e54cd2454ccf3c1c1a8345887c17740483b726414688a82340b8832bf0ea1926863385faa2d8c282c60b7ef1788614099ca43bf050e5c883826e30584e4387f3fc02a1d6c37c266508861441d764700786d79413804d68453aad0f1ed48949e10f3606496c92975ef2232e3149902b8b40de4cd1b818e73c6813e04e3e43a72069b2cd6f6c807fa35812e9c5d2544be1c167a951b1fe5d2005709a92f42a9a2a0f0e72cb8c5589fd529761536290c249267f38fbcec6f06c4e74727276885dbad7b64750cb7510ece49240dfcfd01b0c8f9c69deb6f931be0da5184b47af1c41d76b42637e80173eba6b60d9a4ab6d5db6a14f091a103b1e1c3632a332d7dd32e8cad42d475be475d979a602386396620a959a5cf17a16f932897690b783e726060a905f5fa9714a66d75440ee4ded278300965bb01fb9f01bf443f3d6770f34964c4afc691d72c494ba0cbb40fc0ca8e4a2644f79db472a87878d96d1be8be8c42c8d9f8f5eec11214d5c0a2f4a0438910f2f2d96d213111988287d01547c2c25344bfacb4694469f8aeadc95ce0da0100cb32e7e33d0f7f026a029a17d7a3ee0f422887fb719e4754ace1297dbaa0a7ff80155c5c835dd4c98f660ebe658d6219112ee16eaa17129d5e8d812ef0c6ef014c312233c406e50707d79997a29a534c863ed18d7c0ffc306c5c3ced3fbf5b3d5b3d5bf5d10e67f656e6473747265616d0a656e646f626a0a3132362030206f626a0a313636350a656e646f626a0a3132392030206f626a0a3c3c2f4c656e67746820313330203020522f46696c746572202f466c6174654465636f64653e3e0a73747265616d0a789ccd5b498f64c771f622db74dbb0a57f50f44533c0f473ee8b2e866df136204c73005ffa52ac7eec29e275d5ccab2e2dfe53bae9f7f98b5c22dfc6567328039c05e88eca8c8c8ce58b88cc2cd149b513f4b7fe7078bcf978f371173a4d7f1269faf3e171f71fef6efef5bfa5db49d14511e5eeddb737327d26775eedbc159d3166f7eef1e695e97427bbd7efbebb31b20bc2d0b077f737af7eddffe1743c1cff583f9146954fce27a249df19e57ca1fd3e9144e7a30f85f4613c7f38f6f7fbfbfe421f429c3815e7564a70357a77ab6227a24f73be18f250e567929b4e69110bdf4392a8334ec84a3a8f4ffdd61a4a7746b82a779643aa2e2a5985bce6bd584cf19205efef8f87fdfd392d14bba0ac9e7c447ac99f59d79918ab0a3e5e930c8a54cbbc2efd7acdfbfe747eda135ddb2e7851193c62d97d924763c352d4459f2a8fe08d5eca1d6260b9afd530c17a57272749251411b4660112cd742eb0a0fdef0ec3fe715f0deee04ed2cc0d6e3be579b1bb5759e17a66293294aafbf97ccb24b6f3d2695bb9bc7e9358cb4e385d973b25916f8d0ef077b3bb85f0d6d8bc9b637fca5af69dd7aa5a763f3e5c1ffb24a5115d08ec964fe74b5a40c90e3eaf16ce6a8261a7ba6622f66d1bdb324e7a5667ff9b42134254da7eb856bd29d2fd526fae534acbb913ea2e38571de272ec1fe15925d2a41595c1e1d88f4ffbaeb88491b1eaedebbe58c435ce1fae7d36ac569d6d3b3b9e0ec3f538263540a3c233f3f3635234c2cf1ae672ad3207ab3603e2d608d8c3eb6c176bb2eba6dd238e0387ff3e6b1e9c8c1455ee6c23789ed50c34fd505cc04aa5d91cfdf821090783385fcd792eab78e1e4d297277b18f697bab49075e9b17f28740d6f745a2d7946f78c9013966d3787f3e9721d9ef247c677dab0e3ddbdfa501cc5c6b6d4586caf0d2be43b987e386fc6928393493ff345096c895549bfba2de12e9dadc3be79b3a61d36689f6fd0eebbad80a5355b4cdfbd4e836e7544001a0ff0569dc8b1f9f67c29f867ade5b82268ce5a975d6c392469876cdb5c637c3c3e710cebc6623f14f8335e351c3e3f8c80abfbac520768121c4ec7c42474002b96fba91f73e4821c6d604b1fd37c6c424666cef60f71eda4a10971e0f8169a593e8de7a1a8217adedc7d99ef91075c586c2299c2d2fe78cf88e54b466ec47d6c40d7728cb32cdbe55ae4d52678e6dddf16144552366e16ad97fe7438ee0b5448c379e1fdfe90d963eb84bccb35d5863e4ce49c74395e9efac7fd560607f04c14777c3865bb6121112cc75d365b4470575206c04bc99500c62ad4988b00a15baa8526b30306c42873689a574e557324b4ba2510b788a7491af9a62646c53079aeeea73497015fbffd755ac9a27061b4dfac4bc6c2508956857c2834135d15e87cba4766db2e62281a82adab743970805f8c355fd4b42f05db1fbe7918fba7f39b92cd9d6e813664c740aa71c1cdd26bff6d7f286e27a1af89fbb25e1a229e2b225a3141c449b83bcbc8c721e5f404a58b6265d49390ba3c8dd7432d43102f522fea4ec47a63f2fb8cde26d8d8801e528ca544c3d6a5b7ab64f1a7f691564f49de2aafd9ebaa8320e21da78bf390778c1a03239f5b6aec2fe7e15af646b59f64c9dadedaf0ea654000c5b1c305258a9c0990acc5babfe660be35a956323304385cf7a7ac208d4ceff5dc37e07cc1b88db046182bc951300cfdc3be48e8a92298642ac4a0525c7973b52a021790b9ca93b39e238b44a1e17d53e450361785089f641f4e9daed5171be5deb9082e75c3e1f1f8d88f0587ad6ce47987209a52b8c9407bb36a3226db4f91f2a6d45f4e739edf9a7fdf1f4a0147ad92d67e83ef8656d54caba99ea626671af0ad7a9a963a2c017bddb7e7b1780070417044dedd6d152e169ad66cfb7fdba8523e7fb3976fbaee4dee76562d028dd5d57cddbf74659732c82ae316e451c6bc949ad1db96a5f79742f6abb20fcd88613f395cc7b1f616b1b1cdc519a943e816120fd763c6346450c3e0cc9d9a57b28ebda3f2be069bef9ce0cafc4b3695aba4560bb7c59e09144bd99bf3dfa98c932da3a1ec399ec7bbd7bfca1e20a01904cbadd600679946e4d65f46e4184ee4b90b273751e1fb5c1e55f0a29dd42878dcccbdab31b8c39d343a3a52e95015c7a886b6978bb3cd56ab96768a2d5993b94ec9bc86c6be3ab6f34da6d2f0a0498b4d522a31729e842dbde5d27c5da296fa1da35adf3c54eb60625548a998a054afdda262829bb781cf62a06ddaac9ea20cdb03a5f2fdf8c7528598d67316f445f3c6b31926d03ac86795763a1e3256e8486941ce72c6fbe377594d541eda18e79ba5925432ba5dfa2c1b9d3b88d612e664ada3a9f6441c6593c24da2f36a3e109da69d070ba250f3ca5b3d44565ea0f8694e57c1425b76b856cf2bafa73e9b1d019b514b48d6f0f90d48c658a1da622fdc38036f68fec9c06b9a4c53e0b50d543f15789f835d0334d41c7d0d764d73f6b7fb8c231494667e32d3ffeec3fe74e1d2c6b4838073adfd7c54abea48361af0bb2f7514acf7a23261c29111c4b45e6cecf7c3f17ff7257dc33bcd86dba9b8ecae10b7d12ccb54d979cf27729fbad9c05c51800d1f9143c652a43ac9529f9fb217a329755e981fa88749bfa338b07f58b9d49572010d9f4e0dbe113957a88d5cf12e0761b48e499b89a81e43a2a6e0267e3fd6f2d135b7458ed91758539245bde6fd53571d383059b15a4df0b896f33232946f2bef5276a37413fd72e8532b96cc62a90ea9e34b5f43276342af1aa3890415ac01916b8c147e52016e1d1ff4a78772066ca9e0e4deb8e2958a6e865725a1b5aa82b31c6af5d61ccf75ad675c11cf74b8380be749e14b7d777c897e8a85c52a11ce73c3a9d62ec62db32845af7bfe78850f801d951b8c8788ff7d099a4972fef297b54c6af524aa9822a86b01f27e43a66da7b97b5dbcc635f35eead62709229d71144b462a81584fe5c0314e4a98fb7df545ef587997eba52433279fc979e7cbf19bd281226da30785734ed3f658cf45e8acc7b743a3e3d3755fd6358ace5eeb279b67b96583da2f73dae4dc74ab71b8efd18e17c79b541aeff7d5307add31ff895e843654cbb87662b6794a850ef5378c705c0fb1e4624de2cd7c995110cc10db6e5632e72c4840e0443bc27fb623c0e406997f78b88e35a70717d96386ebe569acd92a5a2ef5868a9dc2db67313615fbf9b640a305e105dfeeeb0185647d35b780dbeae69dfb43b182e26cf9befa493ac29593d3ef0ac946b456b786a1747c3336b67a6e766e43856b2be7ea6d0b1ad76a840b2f6144c368987a189ae7f2dad5050092964bc94b390431e0a1e618370f51dd626302a1c64ea8a74b7fb8f2d9a9a3cb2ed667cbbbb65dec24844e06f9e2ddeeab9baf6e3e62808b289f77da93abaadd23b41a005a9e290353a427e8b0a0d4598df2fee67f76a797dc010364d0cf2270cdf4125821a674503b037e1109f5dde30d3216e209aaf9edcdabdd5ce6dd11e958a1c1333bada9b495905b598226ec44e313ac3a40f31ef8839d486a1162a6a0b671a0c0a3e00fc38acf70f32df44c9f461e05de01567453463c8d17b354d1ab09a3259bcc3ac0eb31cfc3b374e2ec6d17cc44db608d7e01525bba250c89a2e97e0e14427f9b58cfd810672d3d1d5df22032a40f5d98f2e159bc56f0c037d5f82cb92499cb5e558cb68b534da37e43c332d1b40a024a08134d2b1f3db2d8446585cd54d175102b7ac2a72abaad5514cd7c965c126729e056419b9dd4f46fec774c94624df4502f11d58c083c26a299118d27629dad1d82126b3b60a448aea22d2a456c0199b38b4960251c0a899d420a449a4e144ad81883d4520cbae0537c459121d27a9472f38a5659724431a74a2aba2ce67b3a5d253924999de4089e8c45410b639bb0a3ae1d709a2991021b8519283940e67c921c06e6963c08ac0d9db0aa09a336ad2e060a3d3c98305ab021ce72f700329288a22a5c3a91fea70d519ca31e023a620a1c163d45f23cfc8400ac94a151a04b926968b398f2426cfaf75dea3bf955cb6dfa096e96d488d071f985ca5fccc0e8cf2b24c35b80bbc30f54a4384c5c7da4f729a020ed013cc1835a1c15e87a3db174d651870449a9534b813167928c898a8e224b2b850498f85a443c5c0a22215125464227249316d92f99ced175048250a20993292ce76cd89874ce08040c3bcaec7363c271c911b4b1709104d89a4a40c994a151b406042659ea2ca6fc38637aba4ad819e803955532e65ffde5dc9c7f56311347a928e690e4a11ba5a7610c03a944154551c9f40e70e1d4d4f416ce828913d31b43478953eb937470b689f5177c1aa418676708988946ce103013a59b216022eaa8d6d335324c83454da65fae5388f3750a71be4e262ed629c4d93a19409229d09291720918d347227d844e511bc497ddb9226d2621942dfe4e49d6ae4848264b1292dc9217c06c394ac6d52808b91c25d492a4a35e4ed4c1ac487e2597766e350a1a9990a06190661395c924d7485aaf4619b52259b926c5152f1757a3a8ac5c8c0a6bb9a25d8ea227488b5156ae44a51742cb895aac492bb92cb2e27294f5ab516e25aaf52b15daa057a4b852a1132b153ab152a1932b519d5aa990ce1296246357130d4d741aa3cc8c845ecbb19b645210335e89145724748a0b92116ec9cb48bb1a05bf5b8ed27a350a7eb72459b19a68e38ae4c25213c64f633be98b486eaed50549c6d5441157a3c88ef351c9da0b12f9c47c62f29c05c9b9d544eb5724f2d5c544bd1235f9fd6294922b92d4ab89c22c49291ee71353d42e46f9950a13022c46d9950a139a2c4699950a13322d486aa5c28472b3519fde91d2490b12aa412762b5fcfe8e54d2db00c8a7a619ac10e130930c968904e86ba2131b44e316b94e0611a87353d83c95f20ebf22caa9509396a2e086debc3a4d27c2bf7dc1e8af539afcd4624aa167cf95712e8cfffa6f7ef6777f9bcf86ea21c567f9bca4fcf6f7ff7077fac7cffee92edf5bf243abbbf2e86dfbd7058b9ffff3cff380761c102cbdf1a37a5b507b4b259bd7d4f256cad028a892a11fea7dea2ca64c4b366088a6177c524d1ac544444fb326d2cd959a348a20527bba1aa9e8753488b3de330d9c1581d9d06855e100043ab0582ba441a5674898e74b3b8e7a80facb42181a213847bdcbd0e630e5c795d1e454f428bcd87d618e9f807cae0b53097ff6ff26e14f65c7749060a65b7e3ed6f4ecd79f94ed6ca0de6cb293cff25d4405805f6c00c04fd79e5fbdec9b31f17bbe19233d5d51a6ecf3ea8bf6363b271e348b8e00243540740083c4a7d1fc01ea5326f8d475e99b304af8d9e2f59da76b5f66f8cff3e972bcaf570c66fe96839e7238cb77abfdd85ff8fdcdf2ede7fcad7d7d869cced3e9da87afa5fe6b3c0fe7877221e1c2e4ba2adf3cabf40e95f9acafa6d6efdd37dfd17fffe5c9a59ca98bf6d587c390f64b973f8e9fbdedaf972b58a7674ecb5711b7a4564b6fd5296683995c36d09b40bed47ff173fa723f6e3b140d7e76a3f042ae1dfee4dba5d039317f9bfdcdcb58dcbff04d7fbe7db8758a0aaef98b8d6fdac584229a47f145377c06d1841a918e155fe8d5737d57afa6937aba1597f46a54a72b86c9ee9efd16c34c41d2ce9f2c76c5a992c6de82f0fa973f9265ffc3a45a7d93cd21f8a05bba2e82ee68a89213c0fc3f445f54c4656e6473747265616d0a656e646f626a0a3133302030206f626a0a343038330a656e646f626a0a3135352030206f626a0a3c3c2f4c656e67746820313536203020522f46696c746572202f466c6174654465636f64653e3e0a73747265616d0a789cad5bc9921cb711b56cca96c60a79b7af6d9fa4080e847dd1c5110aeba68b2846f8c24bb1a7386c4675f7b017daf24fe9a6eff34b1496aa428b8b861cc670980d6426724f24863321579cbef20febedd5cbab972bcf14fd89a0e9cfebedeaabc7575f3c126125380b3c88d5e36757227e26564eae9ce14c6bbd7abcbdfaec9beef3c72fae84659a0b8f058f6fae3efbe1f67c88602508ec1278b35b0fe7cd4dfc440b667d481f444860c62b9341ebfd2ee1e5ca64bca7cd08548c0b9d60e76ebdf931420353ce2468da6d98355624d896409e392f64e6e8dc1f4f8953c5a47779693fc4ed9271ee548245221c106ea4533ad3ef0e4f33a336d84c3eefb7c2e6fd377d62892b9fe93cea8ffbe19c0ea02001eb7c7382bafcbb6ffe454069a0ac82f7d01fcfc3a98bcb95634184ccdaa94fd292d2e4d5dd05ce0e7d376cfed71d8e71fdb5e6864948ed1a3b8d3671c9d0a56d424855551429d3275f3c526e6a2c1a2ad23e8be39fd769d1c2a21c133ae4c3315a6299b5de66f57cd31de37961b8a158c6a1db8e60056e9ccedb4fdd3ab2a8992cb6f1bcbb494b4154fb6c1cc724db002316f934c3b8920c59f0bcf2e5b94f0c486f32a5514c908573455b37fd68058e49e333fbfd2e7164b4ca9b37b7bbfda13b246519672b82cdcd3e820ddcb488aee86b26f8c3a98fe2fafaf1ea5b38e6ed950c86af8c13f8066b91f0c443bf7a76f52dfc5cc186191cc3f8e09956abed95d24e321d0a64a8100723e482207957813cbffaf76af7e6a8f1d52aeab6c49aebf893b282216e7068c7c7b0f18b5f7ef0e0570f3e2c87204ec56a03db0e924970228225ba5b403cec101029104d1c3891dc59a6f44a0789282222c4c3af08c22d1386200b3cc3d5339c09fa81c1e4559004978e71479838b37aba4fc25047441ece22278896680875d4810c0efbb85a69a855c2d6a30e603be3877a6534963b7cc50f1208eb17201520aa959d813c6f5659df808c6b40baa1a820ba257a299b55a2a128436840bea12871f8057a6975b3caa8661564ba5c255b8aa239b6e4760282e51268cabd82054690ad2078d37295320d48db06846cb40439dea087172e578586a2e6ba018986a2967e895eabd0ac320d456d6503722d456f1bf4a3214f57191e96abf0df66956a2822f63520d3081a89af41ef1a419bd050b4bc39b6150d452bcd12bd558da0ad6e285ad308daba96a2570dfad008daf186a2138da09d6c2852925ba077a611b4b32dc5d130ed746304c1879620905d8240760982d7dae2b523086497ab9c6d5679d7ac0a0d458a394b1022d312a4f4123d45b9e52ad350a488b904f99662904bf414a317ab28924f40c84200f999d24203527e044d364adbac12ba0181fe02644343d17ade80ac6f4090cb82090be92d57a9962234b1048986a20961899e0aa2e52ad75034b639b6310d45a345835e368236a2a5c81b41ebd050d45e2dd16bd7085a9b86a2d68da0b56a294ad3a0178da0356f28aad0085ab986a2b28d6a956904ad744351a946d04ab61479a3da58f1cc56511d07aa81ea4a7857403d4c359ca35e2a14c85021584ce5d5507715c8bd2a4e89aa11c7b2e844e45871fefa838f7ef364f7f127bf6dcace5bb47f63d2c037176aed16eb67a477aa112930a4aad12bcd28c127c850211025b38120795781dceb34a814a83ea5d3189b0be827870f3fc5d7efda2a5a0974e90661038d1c318c5e8fa105418380fe370a1b7d318b2e213d43014010abd9e8968a51253cc311cb6713d0b0a9bc02682d0a604746812a3ad42d22760ef45f2ba94eaf48162872e52c2cea2c542ba812839f772f82f6a2dad1e8dac7ee05b59561880c19325488358a05ea10caae02b99f2d91f4a91562c1665b7af0fb071ffff10f9f7efcc99f1ec0a4fedc9a14529eff8943c900134755570f85fe083dc5f45005528e5076bd9f4329034a7a71aa8fa245e1eb929ba03be3600f09445bf4c988bbd00687a43d31a5c4a875b4f496fc572b2d9827b310861bf245ada425924383870c0101137653166d29a83a86200a4468dfd56c1b1a7a1722844b865458112dd01413e3165c39722445364932149ada344f340e3dd619e074a8bffff316abbf1b652260f9067d272221f3124c0be457067d67c85021d4b58a288fbcab40eea54841f1726560a342e6d0f097d75a2647a8c2d12e59a6509e09625f49e662fbedd11a237664c85021dce9d1adcbae02b99fbb2136f978205d2e0bfe9accb2badc05f314cac24360da5023f36443021d1cc5b70c1908e218d23c8257a0a041101bd53083ccf04c8d68a5627bdec4292115590cda43ce0cb9b4f0b07a083a43860a817130ee474b187715c8bd2d8192054c5fea2cb9bf5d9216bc042208600b793e67bb0484070088bf13a0f7bc5de9f56cbbe288ecda724390bc7d041ad4a12d1021812e0467db753033a0a1ae59f84b403dc73902856881dccdb6934d408b4e4d8f9980ca4d4f94809cb74054c833e07875e5d878d3a0988b110c3d2c73b640e836c90506ca3a881836e3859327d5cf20333ce57e4939312614c3976e4b699c2e9e6a96cc4e5ab36486d4849277bda72c19c4224bfef28307cbf813dbfa6824531b8b40329216a8e4ccf022908c64297cc51d851e6c88377a9000123043890fbc2875cc786fc863dcd55210c3f1de10519ab205557251410b3c313305aa4c355917ea1d4fb8838e478611226944593a7830553f9cf33164a003944457c72012e92ff044dcd6d2e083a29da61cb9a5d28c1307305be49e31a3498a613a405d6a541c72b7a0a228042a7386060da1bec7804719ba721fb5f8f590e716d6e53bf8fe59bf3eedf325bc2df7e565c6112f0ff87474a050edab7c83ddff77733cf5bbf5267e6604431ad7afc171dec58510b1f02e5faf1ffadb1137b2291590efc6c2b3fd61dbe513042513f8c9934be30c03b5299bd7745f5e77e221630fbbcdc3bfc77f7717c71bdc332b320fff882c40ac081df341029cdcf83c48b83becdb71d2cd793dce2150d2c83206b81b0726485b3a8b647f1827380a568dc66436c1d9276282ba9c3c33c943268d6e3803f7696aa1d0d5e489c3b9dba5e98407c632662b733298745e7b24d526d1820d1fca8465e86fbb7c0c55d6774930dc976148d1d784d7fe555ec7791d8e94e91f6cc09b32f829c34301572f8631328b03385dc78c8753ff308d2a652893a7ef1331baa1add32e3a591e5e0691cda1cf4234a668fb79b7ee0f69f2c47d1960e67992608a17c6468107d488b298e14d997c21d82d4654502f6a1a0826aa17f12c9e385a8340a4e1c5ecd79bfdae3fa6c3195b2699a7fd360fc6684e4737a15944c7d17d50bb0a329c999661d9a258c476bf1dcfad68e0562d6a9f67637540d9e7a16d305ebc0665128e4082e4652ad8dd75877eb47e45b3dbb0f0691c4c9683ad87680b3005678b4775e7e379c8335ee57c16f1fe699eacf1a2b617fd69f32a09de8772aafd383936fc4df3e97eb7e993a340b25684bcfc9c6d44d899e98dfa9406fdcd7ce0fa643e2d47ff24ca89ca3096a33d29aa5b6f8ec91560f6bc305ae6c85c9649781d6b0a5f8070cf5725f41468371e3d5859c35f02796ec56b388a0e73d31fb28752caa214ffd36ca5d08db25f95616b7f3ce5d08fba4bbc59d14f3e4fb6c24311f5f32e6309e030b8866ba1ee13667008e1966106cdbbf18daebf7824678965d43d6a82a92f8f790112962294c39520134479e4f074d8dc76a7fd61333af332011948b2c8e0611aafc75bc2ec849bed66f763168cd745c3b0e191093414ce97e135d2c0f0f2bc19231b1aab60ca00bc1b4efd61d725f7a1aa4855c5b0e26945ce5fef92948428091d16b33ef4a7fd97a56274f0060841ac2489337d8fbdfacf2d6e50304103b03916727d931dd90a552593c353086f1bf1bc5c3ef5d0880d5cbcc1b00ec9ac26f17248918df39a804b9e82a69cd7fe356ba70998ae2bca0731a921d71b15662f6f2823d66732cfbbc4bc5525d8a2541b6d1db125a8f2bee4d08db10e75299adc8c737cd292530f3d15f2366f41341f1d91ca8b90ed6dd81f9375076eab75d7f89c17527cbe1e63265d29ce53e0abf678fbe3a56a8ed2538d44b994bbe441d18e795e995c082c96cddf8ff273d684ccf72ed74f46a8e6c9c8240296f878881ea8a9b02a51bb2b4f476a3adf43dec7a4041b262f445ee379c79c8e2bdd890aa42805c76eb3bb3d8faca3ba11562e8232b2773d4e3f248dd1ed45c5fc24a77a8fbacb2c4c1409d597d2b57fd16fefc68af49a2e6fede2b9513a3e1809327388536ef68787a96477a6204b02476ed5adc0276f748ac023f2d8f296c66504a1dbf62683ce351dd2206a26502a24de2ef45d583f5180d74501c5934d7de8f3ae25cad2d029a8fb62533717730473c2aa7ce6279fd76745147b0571fdbe632fcea3d04952ec7d3c7a5430b6940dddf6ae9cae26daac9ed212ad733b634d116151ba0efeddbc0c01aaf532f4ff95de5b299957ba1325e3708d92a52a99f0eed0df6cd62992ea8096a3e8ffd01fef72493c7d1978ec9e0eb92446f95b149cd38eb4cbd6177d41a538bea29cbf843c1d72d892babe6a3baf73b445c7835262eaa3a9229ad760a522124ab71591b193e8972a2249d72dc5fe6a047175ed25d79844104dd725351cbe4be8a898f9657d34ef1a03b3beb4ae4fdfdaa3aea5b38c66d0d7a81ec899630d34e432c197326d690dd6c9a6aa3055b697c5784217922f0c6c0d313729cdd298b560bd9035930e386acd2ac2dca6c3dcf2d617e5c92498cc1c3d3bef6eba5429692aaa4ab5d00dfd715eda091ede7b7811e8b87d1a847c774efc95cba5f36933a0a7ba49798edb52e23cfd3165776378756ca862341b1c5c14f9dee4ba87ee694bf759bb2ae74bd90775a6cb1b45bd8ed34bcb0ba1d467f076f419f99a857bb1706c4250103f1dd955f5f22d1ee09a33c58d2e171ce723d84a4da464b6b9649b60ac755b3cb2a1e2a396af39c6a1cacde2d9f62ff25b564df3b87290213df75df63a74c31dd42c8af43fac37e522b029bf02bc582c2e175198d687dab9728473559fbb3bec6fe32be1f11cf4597dd9fd6a73ca77591aa86ca9664b37083faaf7948831a583d574c3cb9b27e69377e39758442638f5f9c17250b60d8baede13fcac47e613862f3170983d32a70954e9ae7ffa0c509660f438655a61bfe98d74d0afabbf90b5d26e51535c6a75b50b7679844998bb1cd4b7dd2e3b8b33e5d5fb457e6a8d388d9d3bf8e626150614ed949cd39b9594e9971478e574ac99f3af334cfae4b7ae2613ca499136511582b79bdee38c8984260e1ef64289c4500b8bcfa42c61f5dbabff030468028d656e6473747265616d0a656e646f626a0a3135362030206f626a0a333831370a656e646f626a0a3138332030206f626a0a3c3c2f4c656e67746820313834203020522f46696c746572202f466c6174654465636f64653e3e0a73747265616d0a789cad5a4b73e44412befb5778f702c4daa2de8fd9131bcb8d030bb3375f64596344f4c3a8bb2718fecdfe82391031bf6fb3aa32b324b5daf6004304e1504b5559f9f8f2cbcc128d54d722fd477f74dbab5faee4f570e58dbd76caa96be51bf8b3fc7fecafde5dfd721d1a9dfee50fa67f77dbeb7fbdbdfafa0719afa568a288f2faed3b582dfd26af636c94bff65634c698ebb7dbab2fbfffeaedcf57be9152a5cddf3e5c7db91fd323a91a13233d3a8efbf450a9463a67f0e9a67dd8dfe4c7b6f1d1d3f7fd267f2f1a67bdc667dd7e3cf6f955d718890f8fed36bf19e058dee1c3fb213d0b8d0f12242dcf3ea547a2d1c2594d2bf6bbfcad6e5c08b4e0537ae41aed84a5b7c6ed5036d6ba1181456f4fdbb280968df4bcf9b12d67778d3722f031d3b3af7f0071a61a958daae7eb7f7d2a5fc6c6f9c04f0fc3fbe1a17d28dfcf2d6264e3bd27c91f5069b0b194bc71bf7b3cb528a5f196d4f173ff06cf1ea326d10f277c260debed7440fbc8c649b2e56e3fdea687b746a826447f7d0b1f5970acf4e3b6dd90627ca38c6653651dc2997db0e716107c8e6ebf453508172c9b74d7764336a2025b3b452beccb0aa651d31576b482614d24ff3ba0fbe8a8e8cc4f63ff3074e085f9370b1636da4e7eeb3fee06f831ebc029b0a924cdb44f789e20d81dc1455b7472110d794a9606fcdb044b4b9ffaf7682c612d797d7ba0a8b1ec397096c3713c75ddb0dff5f9f75b0d527ae38ad2ad41e3a31aac66611ec736efac4c132c87e6e9386c9243e51399a47957f7daee49c3d65c8e088c6edd68c341f273bf7ddae4af8d68940b6ee6f970264007b2d9ae7f646382b39f19d336527fdef6efda4dd95c81434b4b7e0ab63bee9bac3495600b9470ab4d2384ca3fff38909f98104809fd965c52195ae7be1d1f4b18a4af0143e630a51a25cd394cf9263a7296623a5875b2d369872e60ac934b77cc2e03781518adb6e7a076fa802b48cfda21e707cfd296b642ec4da7aa0fdf17b734563348f7e311bc3d6b4c5b0027452efccd062d632d9ffe38b60076877c588022ed34bd8dde082b182bf9b42de24814810ef0533f8eed762830607c6303ebbc041278b4508b7597307a6b74002f9ac543971704a0100c5afbdd91f0555bc911bb5943d6e45c9251eaeecb81704a4892e5d88fef41703abd97620e6a67606f127830447d2aca17604c4e9a25fa96b240f85a1fc96845dde0723198c06ab9cf0f016e2dabb62fee0291c8ce35f687fde63dfaa6d69cb27acad691358d9e9dce1535fbe6fe7ed36fdbbbaf7228589b2803cb754273c96827b983129a8e0bc8178d8d8c49e04978001f79c59e907daab64d5b5e05100f4e3feff22d4412c28c4ee81b1d7b42495ee0361036d3dc852b29012bd51c5a72430a543fc90dc3ae1b9e86f29b89900538a7dc7f2a9805d0ce38de1e86aebc0b8958545a54813b72feaa98e9dc44f980e75bc24d48015ad5b4c3b85989cca61c1c0ea21523e723600bda3f54b6f5741adb1b047e5b49cb2fa71e95a14d9800142869f82d2f63e07d69c9676a842bcb59f2d03f81c9c80c0130d8c667a42e40d0041dd96bf397b0266c448bfe0e28d5161bc2493c24da69ecaf7b588f36543ace59994cd0c5b1fe92da44748a4d47842ba810ab9d729020a0c90a5e7729fe9e4a42660d1cdafb928eb35161253301bbf5e5b31b3cecc7bbafb297017137923cef03063d00867be690eff663915003897756cd7d11d8457c056660c2cd2b3c7b46a48a903a35d8791a6eb3d31b70846ab07a7ae798a06cfbaedd0d87829316dcc447bb94dd55eaf0d06ff7409e386664da78e17d664a51dbd371bffd848a519597b4477080bbaf4a5e4c498051e69b036a5755c2541d9615fefb0d26ef58cb0a2e71845e2b71c05c1c9e7d399d4e2f738284307c3875c3883c4e2be65c6dd90cc2ca2efd06192490211f674173c9ef11b3008b349bf4617887a79691fd6cedd4ddb0e98973fb9af5d7c8eaa62f5908fcc949de29fb33e4ebe09686868fabdd90c948eb38b6dbe457e30d5a2cd630a425a38de70a861a29b26d9f9034d9696db9429a8a374e134c873560b6019d7a8dbf75e748f513661b20a54672d21cc7fd585409a92c545eb6a6ca175245e1c34608c8edfafa36952a251abfdd61128e156973fd731cde237a43e1c5e5ef0d910653733bf1616d444d5c73466b25d7b64c13b5af199e43009427d4d99b41d09bdf8ffbcdfe115502844ef10a50310dc7c28d538163dc8c1381edb5214b51ce022568f339ac54d653af09071ef0892c531b0e6d77442f07e651b5f62b601482a44a38ed5e1799378809c13de7621fd887abbf177a322da98e3d111f558bee23714dafd813d7fa237b72761f69dbca1d549ce0f1659e6a6ac63a1da8aa00d8494c6041f32270df9a125e1b55c4352a6a74a7947aa866b59e5f5e810826a39338ebda03761452a5a7d5e719014ed38dfd717fc8f108a4dfcd6a1aed53c90cf1a921edcae20990401b955f37b3aec37f498ea4195399e586e89b37bc2944179777d19380df96f2fd80a2ccea8f5b999a864008a08606aff525ef9d76686293bb5f240a238014ee1202286fcf42476a7f8e00405239811da9d652a9a9c41cec444737a918b12f9a0048b9e3285a4b1be340bda0445625f3d83b7201f00bc7d0ff08428dede68614116a25cde456857ab23fd0d94a89c5c97908804d6d10679d2d800f480e802b53f85834b80c9043b3d2e0ca612d138b884bdb2819e6985b98a78e106082de3eed0a1d04c70cd29f2d917c09133de6b744a5599042ba402fc1d78209234e38aec47e02be783cb5482a2ca08364cbd50e8b550b820f0016b8cd7a18b6e809937ef569c336508d112c04db20541dace9a5cf3dba23d45144b052fb572f6b4b30c4b0df91fc2e5588fe5952b4d23ccbdc3d376f6f5d4ae141610e8f78bc12c3107dd3e603fc093501b91cbee2ae01b8bc90a599dcb89008c7ad040a1db04326d700012a0e9f1c7dfae26acd0508d71fd6c40146a62d9fa85b17c77b0595c9cbe2c09b4037d44c9c7f66fd78c02dafe615c780724ed4b1dbbfe104c6e4efb21e9d7b418ff0975908ae2e09ae177a2c7d6688d1e8167d90cf50ad932fab36f83f286151ad1411847433dd36f00f633083cf77598b5ffcd5da8e17b5ed638981ddda592cbc4067a11749dbae52a8bf42db4b09abb65f921052d3f435d435145a66a1eb67fcf84c8b334d7717ecac34e7d45220389b9a118980d85475ce2b04ef992c979470831913684bac98d823a25ac5c4f8383ca18fb84927a8a0bf9f34c227a943aca06cb19c68a49b701bca8dcee8c9f8a4802ea60cc8e986bf58a309905e707a05f9dcb84afca9bf00d05e897bb729bc2233af609ff3a1bec80ce27911e9e98156359abbb9630f69f98013b40827a4ed8e2df52d756a09cdb2fc16927cf9591b484c5c7db1d8c03ce9599d3b447569ee60e4a4bcc90c0155029fbc3899819c5d574e92ed99ccdb30b3ef99af82bdbd9a350397be1a1317250bfe23ef27d3408fc495c597829af6bd1f37e8323ab97aa5c8e01d5c6818f65cd0033599a58d66ba0a32d05adea6a96d7f68d158215425f3b843db798e2ff38a384f4c9b969bccce3c53a81d867ba40f3a676c2a8e322da00681b5f6bc41509bac5dbbe980f18c58f938c32c8edbfeb6cea5d935de20e9f224cc5a9f9ab5b4346d6a019100c39a61352ccc7198cbe1d4b870dca55e9de0039ba346a6aea3f9b9517802346968eb285f73e4ac21002655639e66b4a10e08baa11f8f7b64e069203eef4723568327385bb19a48a861776730f0be8e644f5097f508aed672aad90dbb477431031689f20c374149954612e5064b4feacf29322ecd054809250629f402d309460433cf6c1729da6aeef5907b3de75ee00f37aba800ae6359251778800bd2c4b92ce466907d27af8281a05e2543fc6fed640eceae6780728e42daa7e430ddaee06fee8a4e607f1cb87307f8e0e2ac0f9926f3824b185289ad74a47de84b6d04951d001477780b9acd2d7ad97f4a3e031d49863ef409c02228c4fc7aa172c13352434c2e3d63c97974ee18ac5963a647d85ccd94f8616dcb792fe612cd526934fdf296802a7e4eb30ae1090e625acd1aa21bc44e2975edbad7ee84169753e1ecd6109079d21700d6d366f8881de254c28a502f43119ed671e9391ba8579fb064052f98f418eb54cdb378973d13c98bb77636428224abd4b4f176e81f4f386a48fd6159cb7edc0d48144ffa79ec6b3c43eae50a1fb889ac43df8f1df65d556ab4701cd456a45ef65dd3787c4a1129c7ca34ae9a01f173dc53d4fee35a253ea19ed95b6c6cac6478fcf1445ab0e6cfdbadee9aefeafcd6ee9896052fce26f4766d7ee41bc5f3234e59defbb3ce88ac5f1f06b0314a9cee20d59b0e5857e8f9b50b2d02b8892e576a52143ee0e829d52bb53dfee6160f2b1d13a17b7983a541a8a9eb6f37e72f7612ab11604c5e86194ebd762ff5dabdd4ca5ee83ad3da366dff5ddafe8bd7ecbe7bedeebb3f7dd28e5ac9f3fe6d9a7baa9995fedde3c793cb67e0e1340af182a9739d14a71ad49ed52d42c549a9953ca8348501f304f75981771525c0897c58744801b8833b2363be4e11b77bba4e38af6ce84613d036fdcc9295f4d9da475d977ffb349eca88c2380039eee8e388c26bf9ea55b939bb7ac92ae13f8699f672398bca76669b266e49771dd2b04dcdef39955cfd09138d168bf9f63268e7f872bf9a2093a36966e2d423f195a7ed78985297e27b49139029b7a6e605f6916d14d4b2b89e0d9a5a48939825d3ed9dda2e9c52df749954cfcabcacc1d4d279ae862ab90f2f06a6ab6b564ef3fe37e8845ad49270f58ad1cab5b013a37bcc3c6306eec0c0ea4d1ad698f2ba56c5876e1ceed19a2ef248bf2fd4303a771e2b42d4aaf340b3b8a87dcd931b0a77a7ce794c22d73cbb7abe8d902e3ad6463add160650f233a34d2e5da9652b1d545069135e54b0bef67dd6673238e4499d28c72a99ccac4c1a1370dbff8ec0219d81ef0de0dc0154636a35b7d9f0e8047e58c0eebad17b9e9700759edcc7581b11d6245d1bf81fd7c693384455f93a0a3dbdbb5b0b610013539b7565a2f7b47a8bd180013423d1dff1028bd550b7010adfa6eba5c6e5df944ebf7cfbf6fa3f57ffb9fa3fdbcc6c1f656e6473747265616d0a656e646f626a0a3138342030206f626a0a333639310a656e646f626a0a3139302030206f626a0a3c3c2f4c656e67746820313931203020522f46696c746572202f466c6174654465636f64653e3e0a73747265616d0a789cc55adb8edcc6117d9faf98f825123043f5fdb2911420b1df04c4963680652c10505cae446166b8e2cc08b27f4a0f0194df4b35bbab9a1c726f969cd82f2b4eb3bbaea74e5593155c2c59f81fffa8b68b0f8b0f4b57c8f05fff68f877b55dfeed7cf1e425f74bce0acf3c5f9e5f2d78ff1b5f5ab1b49a154aa9e5f976f1e887f7f5f67ad33e3e7fbf50a2704a8623ce2f178ff85978c645c1b990e959f5a55f07cb14d7e959b9a98ef17dc90be58c4bcf2febfe7d5568a9787a76dc95e1a1e005f7d6a68757c75dd5f41b0b59484e02b4bbf0ec87f3e54f207bb3308c2d8d1062c9a5f205bc2d0b63955b76f5e2eaab8c2160b98fc67875bcee05e1aee0466541de96fb5e1b690aad1d3eff70ac9336c67254718f6a73add014bbbaaaf7cda14c46365c5932d2e75dd3f55b6bd0dd293254bf8b2d383eb9eeeacba62a2f7b4b6b5e30e5d12b755cac0b2f188af163d76edab74966a6f98ccc8e165f8747a69086a153eb6e9be405b97c96abeabd5df6122b5e78237dfa65d3afe612428004db376f8f4d944e8a4269dce5d0cbb0568a159ab9e51aded2f0e3ddc1f0e4a59123376a30904435aea21a9a29e547769c785f14d6913467733b3b0b19c2ed72adc07cde7dcdfe178fe60e50859002c3e0d3dc2ea610c2335c72f138acb185309a52ec19bea646a773b0a6364b21c0a3ba5fe8c2425f38eebc599ebf583c7afaf8cf0bee0b235dffcf33f8e744090561ed97821546c75dd89c1e1aec240dbae92fb3e6307010b71414b39e843fb5f5637b18365ce24177c14c5af29fd9934075c630fc782ff05acbc27ab0471f662aaac2bfa12a63d1f9ac95e068484edcfa69ff5a909552e5268db5a408b85963da45448d2dbc28b418692cfeb7ce1b3bebf9ddce4aa2c35b9018e02c610b2378ffd33f53d5808024c4ea9a6ddd95084352e249e575d723a408e770b26eb32d13ac4091128c702ec20ae8a8a4a7bdcbb8b130002e04f619df98c36dbb7adf6e8eb8b186fcd2fc968d2feb4d2a2ece084f9ab46f36f536aae2a1ec18c48d7297c2847b81521ceaae69bba407130ad5aef7a9ea302772011ed416583aa92d4c672106c5e5c94b69877e5a2b066104020fc3e9eae2d1cfabd711944e1d2b01dbbc43ad5711358d33068fab9aba3b44cac00ae19cbb33baf2bbaf6f005ce9a85e276300085b8b5b43252a37c9ab26939c72ee405f30ebd1b27f1ce8ff3cb70b80b4b32683fe0a118633dc7a0bbe8ab1110ccd298362550d62080afc4db9c738e414f4872e5a084880b014033717eb3dc60bf79a22ff2d6c7d361b2ee07b800cb95cf7212a73b8b0182e50f581bc60789cad91e9183db20c04beca1ce7d9d3e93238b4c70c079907874ee393dffbc0e79cad9245a590ee6172882407873f80f58df94c90437c85e2cfe9d1002a8bb9d0594328148cf991e15f94c9ffd67047ce837cdf275707c8210675409404b1b49678208119e384c077a013303b2f3087126bec7f007dbdc230aadaaeabab43b98dc2680bc8c8c5389ec1964e533cb7188cc2d22e1ffb77c1f4c6a38ae5a64d410eb670c2e29ea92981bac72ca71c4979e3adc1731e48434796f99d88b18afc4e2b4e5837c7cb7bd804eac60c15e503a46d64f5f03a271d62b501960d5cdf8cc9c0edc43cf47cb93037bb2a6a2dc0c4824225195d69e951dc7a97f6844aadf3ca435d24a373490fefecb4600bc34eba96c058ad3ce9b444707c0eed72d3fc16230d2817a7f6293979443940affd71436d99121603f6e2620ed9c66ce9af33f90bd9ce56bf24d4561a924ea3e77e79ce67b31658ba33e480ef8aa9982985a186db819efbeb63bd8fb2438106dbfa712345916ed55c530890e9bc204b765f88dd50c92c53e9114e3fc42ebbf606b2a772e9fb6e958e8347f21ec10efd39be3a60672cb7e29b4dfdb644e4715edda203109d74b81194a0ef1026650668088f6a73dc2776077494a909bb1b2c4fe40e729a0d1ae0fd01b91d80bf23658729eb949f76e7e07f4ebeee61127b6e67fc697507d98037a6873265bd0a2c6694f5530bb7fb06c867c44960bb994f76e536ee0d5964343b65b03e8c14d0c6bd7d403b60d5e04d45f4b57b8355c3109b6a3784e9c4a253a4060c2563be1c316b0f58406149b63779f9ab17dfa798805625a77717d284cafa80f45f22f841f9b294f5071add78dae402e2e50d628fa32d7ab9d6ac904c0f50fe7d1d3149b84279aa3955bb8d2d898746854c59bfafbbaaa99a387903835872eb7c84b6d1afd215a1740dfdfa30075c3c2e12f03a4578f2a24d6821ada6dcb9b5c2833660a693fe43843e03df9f09b75833ac2271aa967087ea7efdb9c23a02996f880c1fea1502619e8a05106c938b991e168c7e31a02bf4fe991520ba7a42d77d4c2cb092e622377bfb7414342713dacc0a4b801d8970021e40b869c5b2995e5dd6fbaa8be114f2ca3b32df2e451e58e1044f00421dd1f97bf46963f6390bc5c0cd32bfdc86250e880827743e1e8ec8c8006fa071f4e481e42d2f33cbf80420f92bc677b65652a9e781397af6ab846f400ff0290e85c510e6e7e8c56fc9489acf8c3301884f88018869a910648097b4ae2666634023e2405db26fe84dc16653291dd5fb0148c11e3637d4b940e4e3f0b0803924d7acf2b9760f84dda438031aa61c8d5d77191678e8b906b0906b0c747f7e50ec31d89ca79ef2d0449d410ea1a95486d944891304406731d60482db496a966a4c2ea9fd604072688b141c260f4e7e40f3784db6acafa01368b10b03539e4c5e382cf6f7e3e7a09bf7541c3046a03953a7312242a74a1aec0f48830006870cc2417c6822f8a99dd9a559bc043791b063a3b3db743825e1729c66fd785c393e4a6810b13b568763e4401ab8aff5b99982ba060565576efac67c1d3406b9976bf02a43e21f11e1b6f95d9a4b8c4791a13d12feee51e4c9f095f79d0021fb1c2600cb8ab87a2a1540a434047df3731fde03575af26cca9d593fd35cf3fe26c58c4c3937bcddb567a936f25c07ef3395bad966f718df0e1afb55e2735a6bff7f331a4f46533ea4d649e378a3d126061a19f14649ac984a92e7d969c0a3023f0813251d5878ffd38fe1171b2e2729f73be4123cf7f66d4a73ee1471ef12efcb54a6570979c2a04c50a2e7eb4a6128f6afda2e327ad98fcf4e260b0a043499b9f7b3bac8dc75a1659e639453b99a5d643e5513931be0df3a94ef4e32663d9f9031e82ca8ce1c9ad0182366b1303347f027e4d656cf328d70dfaa949cd13457840e510bea53b8b51a460d316017660d13081e8c69df61afcbf3a571b31b482243009051b0e51a5c515f770d58f03af1eac020887ecedd4803a022837059b412bacc031c393fe084f0826a082a863ac5e31dc5701efe0d079c48629d235ef8a7d574e1eb67348204ca6add7404f9ad4513f7178dcf8896a7b4ffeac7a3f3034dd8dd83f78676fe7b8b1326ce750ef83808012e00551aa5892345885c47439863fd316539d394b93823e08e7ae839f6d9a54940800835e82557890a89cc93e9ae48f02115ca131b15ae18ec495c02b6657e321ad5d84c2448d8dcb6ce9d361a6d856f111e34c2f963465b28b927596e9f3b0d3bf372bb4ee80242897110bd6922451bb630a92596cce429367d26c1245d4e7de38116d0499121343c9a1d68b9c23889af96efdaae8cb457164ed04de6dbae844a80b319cfd9c83ebed04eea93800b9f96985c4ea66639240114f4e964efcb63855c5a858b141a15ec282cede900c885f9b3a3604be00fceb1c6df62ee3939c757b93c1ba06fada36142d490123468637993c1a04d026bc983fc7dfa624940b38d1bb41b6c9a029d1877cc877a77198332f4599a060dc9e80c1a5c5430f715c2e77af2e97a03fe8c251f4a9b34a7aa8f6b15a9cec23c6b387e4b0675f9860e8d0ff4d098af98be8d6478f5e2fb88cf42846f14ecb05bf8c79b7df2f6609c3f9b5add472cad79da91866121da355d3ee7865d0a7fcab3c2f8884f7956784cd3b4ed17f444060cbcfc569c2ebfe7be54431612c6c19914e060805b0a539a3187f90f9d7cdbb559879a0a3ee826b12829e77f7751caf9f090a234d52954044892f4418003138c4308c82c540974e8bfb1a67049aeab53a9032d191f8fd4fa4b2666c528956eb8729f4f1becdb07d4ec4119f3f08a1d2e9e4eef8dd038d6b909b40ea438ee9acf5599a7d3c31127a2dee0bbb4cb6674c919463dd417e54bfbbcfd7d8d519598e326a3791d6fbf403d6b6efd1673f6d380dbeef5a55791c085eb653ee096dffe5e7f8e5b2616c95c30d594e0deffaeff6b08ee8c10f7a2b210a881ddf59f13dac864850a0bfbcf5b7f5afc175c0026f4656e6473747265616d0a656e646f626a0a3139312030206f626a0a333130350a656e646f626a0a3139372030206f626a0a3c3c2f4c656e67746820313938203020522f46696c746572202f466c6174654465636f64653e3e0a73747265616d0a789cbd5adb8edcc6117ddfaf98e4490666e8be5f843881e3e82d4062651f24650d81cba1641a33e48a9c1114c3ffa48700fabe54dfaac92167762419b15f841eb2595d75ead4a9ea2505652be2fe4fffa8f637ef6edead4cc1dd7f7e69fcef6abffaebedcdb7cfa95d51525862e9eaf6cd0df5bfd195662b2d49218458ddee6f9efcab69bfb9fde5869a42296be089dbedcd937aefd778a198b071edbeecdf766bb7ce79c1085371fde7d23f4b0b6a198b6bff714bb66046dbf4d8bb63ed16191c426b1a17b7f57028abb277bf08565867d485c7ddd37e95154af0b4fac92d6d48c1891468ed717768f6fe612e0a416932e3bd5b928590dca647eb7e68fc1e548157888ccb5dbb8e8e21029ff53b9ac22aa6d2591fdc922ab8c237eb219c08cce40a5fddfa0351b086a964fa50f7f1c396eab4e1fe53f01e313ac5a31c623c588e51e51f13851182a2cdfb2e7a8d1934671b02240b42478e4fc6d09177abbeb96f7a7fec0df8acb08caf36f05529a47fe2d0d46d088b2a8cb4c9e07a1711a0a9e571ad69abce038b49402dc66ac9fd2decea9f1485cc4f1e8285000a66f8a9d500603a030aaca5c5b68b47e6f9c1a1a9f70fbd7f58807fb41678eef42523d0b95ddfd7d5a1f4be10e03aa9e5d978777d3482c3be94b00b46bc39b655d3b53e22421494cab449b9adab63b92df7c1198a174651367306d7c9190f655f864831487e15232545b0bfa9fb4337c46c3552635e0c6195f18210c4cd368610c2ca4c7a149cb56daa72db3df5410338281d7feaebe158ef7c30392b744e7c6fa72eb4a088f1e4ca7830a9170e067b6bc1f1857680f40d9817aa50c000530070f824eebf4bfcc3f3166fba3e263f109d16e96b77776eeddbe75c8f8911e02838a6f35f367e3b5d5025d367dfdc3d91eb5777df14e1f529af02980815c9937f5c476b04a1fc2c62eabe8b5f11926804681be2c9954b9949e69d25e47848ad993d859da27419fb921bb18c47ae95cc51887925e4282dc6a18148328e25a34596a13934438295c1fcc9090bc49e9e2cf731b3d9e87cf3444b3468147e179c708cd082a31983188df077fc6d55a6e6c3a7b807478bca64ba6298a84d0bb5067c03f01f3cfe37dc409a4d926c8909123e25d2db2fe0fa5d289c027ea0524c81cb80f554820a24d6c3319539011f34e2344735f0143118d8e15047a8bb7a8b1bc5334daaf221650fe5925f302245399a2c14d6faaf4820b266d72550287e9291599564ee30c9c81046e05b8967f92f9e85a8e4e4f22330c1a1791f1586a6c9a440ed27073f96edb68be50fe000c5689c84dbfa3e1e8d4993f609b6412a5841af308d58264e8ea541607024d0f7cd36a0d91513332a8711e440f65a4a330d291c8c21ddb4f5db7462d03e8c20f797457223e1e9e16743d8028aafe0c8b30f7d77bf8bb8129eb093d1c82e948b1c9f648446c582a28366a1162902ca7c7e375384a0984667445ad786520d80d144d98b48ef9b0e72a90899ab21624caf361c624a42ee3e0b691961617200d8d3e4248a585b925ae5ae3a86f73990bd5178704c5399abee92a4fbd004b106055410fc3c4a9c918fb691c92ce4598ef28c7c9675f01e6a8d7ffdd9edea4768029a1b45c84ac27b2b6a34a054aea0aa68a0f8bebe79f3355d8502a94784f65dc5b35de273cbb39ee862a8217889512ad018fb2800857764e6efc856320bc0a479dc97b2feac7c2c6217013580602d5c52a68fc4426501b72437732c94305f1c0bae1d96920fdaf270eccb5d9daaaa64b3ccb2160b1ed4876018e04ee7a33600e7c41120583527c9ba43997846db93720d5a03fa3e6829c665ed9f7db7ebde46fa102af72510aa906c8e5668de3f192909f2dd31955429b0bf403db9544304805b2211ef7d44ee9ebc58bf74ba6ba96a68502b140bd33a4440588df809123832293134cb2c6f1a71514dce7b15978891b3ae406aacb6082766d59570821c9bc18953937cf2226e286d663ab764a0d3e3a8215e16f14dc5783af1f729c314472f346f8fa55f86fe4c30fc70545c106cd74db1a9b05ce0643ca6cc14588ff8120a9332e99be7e9771d5da025cbb008e9eb9e1e159b0612a38c5b2b6abfa4579f5725e40a31a67740e05c49ff8c452d17ab095a019d9007e7f57c172cd5026ddff60116744a0967540125f4a22ad8e507b1720f10ed489cae8420700ff5d3a50403fdea5a025705899741a779f622e499f1c9928ef17441cc25cc02b1255bfefcddfcb100da0d05ae368a4d1866fcd9975ff1d93fcd975e2e4acc0d04162a06c839687298027e75cffe2d46172495a5643e79627651a65854e44b75b97b884619826f57285d1c23e47418226e271bec43fe6b43593afaf1704cedb3ab910a819be51f470fd41faaddd10fe0988556c160ebd3469293e3441dd6f1b023b4e52c05118e121e5b6a876176cdb08a6739f8f9c3aa512ac66922b7125d5f7facd2d4087e5059342ce8e16d623f702a30fe1888f50748f338ad739d4e9e8804aa9bcac0f354170dd199bbb07c8c34f1f1d0ec9a5f538b2141a968445de6dc9ce155d79f4b660abda1abcce792f9d5ef9dccebf9da1f16d65e7df722a6bd22e02631a935c9c0d731ef97539541910238f84cd52151ff7188540ea4283343cf697868eec1c5db72eb4d93d0e90a9d4e3f80ce8c2291abc2d05cc152f1d7b8b44bda93528451e20580bf396d7da0afd72a0f49f6084d3b82664c01c6399bd40daf3bd04c9ca348ce4f0ab253588b05194c52fada82ec861378a87a98db1fd2122481e1b9ab693ec6313d683fce300f6361024765cb46653b37c993b29d4cedb2087575728c95cfc9b5a59ee90c5d9d21f779753db6eec455b09adb09ca506c648a5a6a81fbbadc35551d9d6e1917e8ccc940943966bbd4d02ff7cd737eaacafbe86325d08afad7f0a41b1be8d95dc4639d78b5f30e807605f081047f1ca0dd1acec80c05c40fadcdff4d662c3153e42057f49959941ed77310689791de065ce75ccd7a5b43a747e620b3829d0c3f003596cef21ad87259685b86877a3caf05414fb9017d9ce001d98138b473db64b623ddabb93dcc648c75e15e0d8e62e45768756dd0393855d2d939b9cff59a295f6094fd90926a148b0869ef5f1c0c4078368162a0235264aa42df817cee63f42c9fde1dac23d5498d3973f9de870b895fc5c939679833be1b0d1906db5a8edb9e8ed421cd963a7d93dfd8c67edefa6b9694bdc7b7f1d2d1f859d7a8b481ba64f93a2622236a5777ab23f17ea4eefbf9741ca46b1c8183c3891517baa034fd56265f2a8ec6df1b002810c9f4660389cc703642ef640aae2c399d821b37ec5e9e824bfb88628b568e34f792112753709d5bdeeba6e08969f89aacc919a2b14ecde364228ebe4793212ccfc26679fde8447b7c089c68438d65593f7ff5281ba891166e443fcea8df77a29d0bdb23136de831dd6d26bb6ec0cb1706bc4b377487baaddd0550acd1243b65a97ae2c04be70912cee3b82bf1161bf4242ef9a8b508a127f9ef25164725bb2626851fe6ba412e750c48ad05d8ff5e735c68fa0a97e66e8efbf7d48ed9dcdf8da5152757758222abcba6f573c4700ce881acc21e6834b181c299f6ed6bd7a345475a2895194138d854797f144b8a617026134d283bb3b10a239f03056ae6505059ad23148cb81a0a22f719110a541b9cff8d1a7233c7021437883e99f65a4bfde79266fcec2992bb27827f6fa0182819dab387e0a1aabe7bf283e720379b554818fffee1b7d73f4502dca49fc6b63ef6feebdf9eff1454a3bb2a1436397a49354ef67a7e4edf5109c73072728a676dd42a942223e2df16400791c7091fdb263506a0eb29de4475097a3437a98fa9360a84c173191a92c864e474ca64203ad74e99e0732ab367eae7a838ed5be1eb395b5dc103aaeecbd496d83c96f992a1120814e8d6cfff9954976e75b93c99ba80f9949ff4ddb01bcf670d437c3065d4961c93fbb5ba2eefa0f1841de834714a60a13a766da0b02c2a99a870a9cc7f8255f64d8818a84b88e2252d5c85c8406391f51d5295552a93474a75c5c824d5d751aa528e151f8746365fe84fe6d6c0af9488dc472669aa9ce04dbee8cba8fa8c2bad78b6e0606812d0b6e035177f96e7e9659a811a851f1a8e09b29a9a0bfa7968eee3ad17146e92ffcc603e4eaf8e7def29385ce94ae91abb64d7f74374039317854b10a190c9707a603040b201ebdc4f4c6251fdf1e67f1640dca2656e6473747265616d0a656e646f626a0a3139382030206f626a0a333032320a656e646f626a0a3230312030206f626a0a3c3c2f4c656e67746820323032203020522f46696c746572202f466c6174654465636f64653e3e0a73747265616d0a789cd5584b6f1b3710beeb57a83d2580c5f0fd485104689a5b0f8de30201e22258af36890269a5acb4055ce43ff596dfd75992335c3d6c2beea9c9c5e052e4cc37df7c3343ce849cf2e13ffe51af265f265fa69ea9e15f5c1aff5dafa6bf5c4d9e5d8a30159c051ec4f4eac344c46f62eae4d419ceb4d6d3abd5e449b37c7af579222453c60f3fbf9a4f9e6cba66bea8abf97af8047b8db2f8a96ae376c1449032afed9a6eb1ee8675057b9db678ccb06499b2dce4957420733ae09e79f72d1ec89992b4ad1a96020b8a8eea778be5e2efaadb36c327ed98b1e05dfad6c6538561217891d7b6f154cd64f00eef5ea67d9e69c1f1b79baa8b9749c36cf0727cbf6142398b26fd9596b451017f0b5e7fecabe4b7635ee3d58b8c909764629f50b3ccd2cdcdb25935715901f621e0cf77c94acd8475ea4e209b6ed7b44d9dd0504c1a198eb0338e6e8f8b33ad040b10fe9950cc6813bf2d17db5d424031af3c46a58198ae166d358fdfac026b94220713e25232ab3040bb6a85e81a878b37110acf9c17128d89818168736be8c48403f8ecb811c791e1426364baa65e775d1341d79c7941c44cb881e35e2adc3d5f6fe3c10170a7cb9679d132e38579301a69b363ce4943e81c9b9b319602f228a0af115c16d72df38ee3faefc3926342500aa5f419e2c21d1ed97c6e569be5fa22c7585b85562d733cb5601cc08ef1343a03b4ddf44d8ee990276164f632fb221c91780b2636abb85b41ec82be3fd1512b14ed4bb6c03ec007d7ea75bbed97d906608915c888ebeb61edd9a572636982bcd2cae22d1b24f7f593b717efaa8b9b8bfacfeba72cfdf040d324675c232c3f66b659928d668b0607eeef31780b99bca0f86ba3ef71f81adc5b6dba3e6e066639e38fa94db46c6ef26d926b0a6c5231c847c38c547bf93840b7ebfadb4c7070c55192243d062a71c3e9fc653edf1486673b38e7463a45f054dd4d263eb7a4bf6b947f20a33ae4b7516433f06abdeceb453c1bec86d4c14feb36ebaf90b4f6e6b75fa3ad1a4445165a74033de3097aacf7eb768ee803df1ce9c7aea1b8ef1366260179097a3d8383b81071f78b19d2db92f4ddc3a519ee1cc3ff36a3a97540ab7f3e5eaa8e975ed01285e6a7146428771e8ac33849cfbbe5e6b1b77c972ff57ff425d582c3c49c41710810df181f2ee3ce3fb244ca418def2babdbc432202a5860f659a699561259b6fa96349f7b87395861c68ff2b2f9a7cef492018a286514653717bc707f99eff656539730ee87b48722cacfeb87e03e2e88ce5bbaafd836e43b884f93a532688f0e2fdae3e2b9ebb03b909a5c9ef7837bd9380379a5f14b8f99c9a1f497244c7e838e8c64aacdf5c7177433125065b920b6f44db7c9bf56964c58e77a045d0b177bf4202dd1a539cb0a3ce040066cbac5aa49151f640f5a5104ad6b3e2eab8b0ca63504c5a9833facbb5ccac4d03e613cbe2478a156481d0ebc03968f8d18c7390ced8d2a31857ea8c9a21f4ce9e3da633b4e9dbd5a638301c12b7ccbed1eb470de1ce9eff8c8b64e1900c0076a04765dea3fa1edf09cfc7d00df99864fc6993db138eecceb1ed4baad17d84948475dd8a902415c73543d81965df20fe602e93de5e39dcdd6f393620f9589f160f6c47e24ec2f233b1c54144b10be7bf9f53d087da6132f617f7ea248fc90eb01b006f272ccde876e79fff5f2ec5bf6cebabca3a199090361f7fbc2f932471ef036b6b436095a19f7d1dc839151f2b4c440950e24313d29b22bd3c2774b324c359e0cc0c901c70aab41ede9ecdbac28819a92bb255cb320cf957048291b0e253c8018d10194da117600b9347f6f92d2823c40974717ae725e5a4965e0a6ea3ea6761c520844005bb74c969c76a0a12595bf47c4737335f44cb2f467887110561c39a84a8c8aae0398340dde6275b2b872cacacc908c3014381708b85d11236a81cf1aec2b34bc4c34270d7f44b7ba677c162330a75c74b9d7ad062874a5549d0014bbd5613ea7733f5535d5c9c257ac2520aea5c024b7e23ce6f47e137658524469876f8f13ad4a6c313042a06d2d92058c38c872c9a4245185a96f8eb5cf180a5fbfadba8bec8628f32e8c30493d1ce0a04b6fd0e6f8e87230cd4ba63c013ca26d1b997f77cf74918b822cc30cbd0380a6719aec73d5e5c37c8b6bfd50e0f039866b62fc7d2f039ef94001c1970133ccea67be0ca421cee8d34d0f10faf08100c44fd9930f045ad15bd52b24a93765fefbd0d4bb243f4ac121e44bf5699d20822acb15a91591c4705792b9cd0f6e72889ed0fbbcf3d2d1147ed6985b5e70ee1e73a10a8250e842b187e6db61c82031a7564a6a8ad3231403fa237d3cdfca52b71e9e6ff530111c28c60cf26478f03918e11f31e69eee7c6022300128f4ff1c734f8f862280cc0290331962871bb74a3b6c7d75357d3d793df917564070d8656e6473747265616d0a656e646f626a0a3230322030206f626a0a313734340a656e646f626a0a352030206f626a0a3c3c2f547970652f506167652f4d65646961426f78205b30203020353935203834325d0a2f526f7461746520302f506172656e742033203020520a2f5265736f75726365733c3c2f50726f635365745b2f504446202f546578745d0a2f457874475374617465203230203020520a2f466f6e74203231203020520a3e3e0a2f436f6e74656e74732036203020520a3e3e0a656e646f626a0a32322030206f626a0a3c3c2f547970652f506167652f4d65646961426f78205b30203020353935203834325d0a2f526f7461746520302f506172656e742033203020520a2f5265736f75726365733c3c2f50726f635365745b2f504446202f546578745d0a2f466f6e74203331203020520a3e3e0a2f436f6e74656e7473203233203020520a3e3e0a656e646f626a0a33322030206f626a0a3c3c2f547970652f506167652f4d65646961426f78205b30203020353935203834325d0a2f526f7461746520302f506172656e742033203020520a2f5265736f75726365733c3c2f50726f635365745b2f504446202f546578745d0a2f466f6e74203338203020520a3e3e0a2f436f6e74656e7473203333203020520a3e3e0a656e646f626a0a33392030206f626a0a3c3c2f547970652f506167652f4d65646961426f78205b30203020353935203834325d0a2f526f7461746520302f506172656e742033203020520a2f5265736f75726365733c3c2f50726f635365745b2f504446202f546578745d0a2f466f6e74203432203020520a3e3e0a2f436f6e74656e7473203430203020520a3e3e0a656e646f626a0a34332030206f626a0a3c3c2f547970652f506167652f4d65646961426f78205b30203020353935203834325d0a2f526f7461746520302f506172656e742033203020520a2f5265736f75726365733c3c2f50726f635365745b2f504446202f546578745d0a2f466f6e74203436203020520a3e3e0a2f436f6e74656e7473203434203020520a3e3e0a656e646f626a0a34372030206f626a0a3c3c2f547970652f506167652f4d65646961426f78205b30203020353935203834325d0a2f526f7461746520302f506172656e742033203020520a2f5265736f75726365733c3c2f50726f635365745b2f504446202f546578745d0a2f466f6e74203530203020520a3e3e0a2f436f6e74656e7473203438203020520a3e3e0a656e646f626a0a35312030206f626a0a3c3c2f547970652f506167652f4d65646961426f78205b30203020353935203834325d0a2f526f7461746520302f506172656e742033203020520a2f5265736f75726365733c3c2f50726f635365745b2f504446202f546578745d0a2f466f6e74203534203020520a3e3e0a2f436f6e74656e7473203532203020520a3e3e0a656e646f626a0a35352030206f626a0a3c3c2f547970652f506167652f4d65646961426f78205b30203020353935203834325d0a2f526f7461746520302f506172656e742033203020520a2f5265736f75726365733c3c2f50726f635365745b2f504446202f546578745d0a2f466f6e74203730203020520a3e3e0a2f436f6e74656e7473203536203020520a3e3e0a656e646f626a0a37312030206f626a0a3c3c2f547970652f506167652f4d65646961426f78205b30203020353935203834325d0a2f526f7461746520302f506172656e742033203020520a2f5265736f75726365733c3c2f50726f635365745b2f504446202f546578745d0a2f466f6e74203833203020520a3e3e0a2f436f6e74656e7473203732203020520a3e3e0a656e646f626a0a38342030206f626a0a3c3c2f547970652f506167652f4d65646961426f78205b30203020353935203834325d0a2f526f7461746520302f506172656e742033203020520a2f5265736f75726365733c3c2f50726f635365745b2f504446202f546578745d0a2f466f6e74203837203020520a3e3e0a2f436f6e74656e7473203835203020520a3e3e0a656e646f626a0a38382030206f626a0a3c3c2f547970652f506167652f4d65646961426f78205b30203020353935203834325d0a2f526f7461746520302f506172656e742033203020520a2f5265736f75726365733c3c2f50726f635365745b2f504446202f546578745d0a2f466f6e74203931203020520a3e3e0a2f436f6e74656e7473203839203020520a3e3e0a656e646f626a0a39322030206f626a0a3c3c2f547970652f506167652f4d65646961426f78205b30203020353935203834325d0a2f526f7461746520302f506172656e742033203020520a2f5265736f75726365733c3c2f50726f635365745b2f504446202f546578745d0a2f466f6e74203935203020520a3e3e0a2f436f6e74656e7473203933203020520a3e3e0a656e646f626a0a39362030206f626a0a3c3c2f547970652f506167652f4d65646961426f78205b30203020353935203834325d0a2f526f7461746520302f506172656e742033203020520a2f5265736f75726365733c3c2f50726f635365745b2f504446202f546578745d0a2f466f6e74203939203020520a3e3e0a2f436f6e74656e7473203937203020520a3e3e0a656e646f626a0a3130302030206f626a0a3c3c2f547970652f506167652f4d65646961426f78205b30203020353935203834325d0a2f526f7461746520302f506172656e742033203020520a2f5265736f75726365733c3c2f50726f635365745b2f504446202f546578745d0a2f466f6e7420313033203020520a3e3e0a2f436f6e74656e747320313031203020520a3e3e0a656e646f626a0a3130342030206f626a0a3c3c2f547970652f506167652f4d65646961426f78205b30203020353935203834325d0a2f526f7461746520302f506172656e742033203020520a2f5265736f75726365733c3c2f50726f635365745b2f504446202f546578745d0a2f466f6e7420313037203020520a3e3e0a2f436f6e74656e747320313035203020520a3e3e0a656e646f626a0a3130382030206f626a0a3c3c2f547970652f506167652f4d65646961426f78205b30203020353935203834325d0a2f526f7461746520302f506172656e742033203020520a2f5265736f75726365733c3c2f50726f635365745b2f504446202f546578745d0a2f466f6e7420313131203020520a3e3e0a2f436f6e74656e747320313039203020520a3e3e0a656e646f626a0a3131322030206f626a0a3c3c2f547970652f506167652f4d65646961426f78205b30203020353935203834325d0a2f526f7461746520302f506172656e742033203020520a2f5265736f75726365733c3c2f50726f635365745b2f504446202f546578745d0a2f466f6e7420313135203020520a3e3e0a2f436f6e74656e747320313133203020520a3e3e0a656e646f626a0a3131362030206f626a0a3c3c2f547970652f506167652f4d65646961426f78205b30203020353935203834325d0a2f526f7461746520302f506172656e742033203020520a2f5265736f75726365733c3c2f50726f635365745b2f504446202f546578745d0a2f466f6e7420313139203020520a3e3e0a2f436f6e74656e747320313137203020520a3e3e0a656e646f626a0a3132302030206f626a0a3c3c2f547970652f506167652f4d65646961426f78205b30203020353935203834325d0a2f526f7461746520302f506172656e742033203020520a2f5265736f75726365733c3c2f50726f635365745b2f504446202f546578745d0a2f466f6e7420313233203020520a3e3e0a2f436f6e74656e747320313231203020520a3e3e0a656e646f626a0a3132342030206f626a0a3c3c2f547970652f506167652f4d65646961426f78205b30203020353935203834325d0a2f526f7461746520302f506172656e742033203020520a2f5265736f75726365733c3c2f50726f635365745b2f504446202f546578745d0a2f466f6e7420313237203020520a3e3e0a2f436f6e74656e747320313235203020520a3e3e0a656e646f626a0a3132382030206f626a0a3c3c2f547970652f506167652f4d65646961426f78205b30203020353935203834325d0a2f526f7461746520302f506172656e742033203020520a2f5265736f75726365733c3c2f50726f635365745b2f504446202f496d61676542202f546578745d0a2f466f6e7420313533203020520a3e3e0a2f436f6e74656e747320313239203020520a3e3e0a656e646f626a0a3135342030206f626a0a3c3c2f547970652f506167652f4d65646961426f78205b30203020353935203834325d0a2f526f7461746520302f506172656e742033203020520a2f5265736f75726365733c3c2f50726f635365745b2f504446202f496d61676542202f546578745d0a2f466f6e7420313831203020520a3e3e0a2f436f6e74656e747320313535203020520a3e3e0a656e646f626a0a3138322030206f626a0a3c3c2f547970652f506167652f4d65646961426f78205b30203020353935203834325d0a2f526f7461746520302f506172656e742033203020520a2f5265736f75726365733c3c2f50726f635365745b2f504446202f546578745d0a2f466f6e7420313838203020520a3e3e0a2f436f6e74656e747320313833203020520a3e3e0a656e646f626a0a3138392030206f626a0a3c3c2f547970652f506167652f4d65646961426f78205b30203020353935203834325d0a2f526f7461746520302f506172656e742033203020520a2f5265736f75726365733c3c2f50726f635365745b2f504446202f546578745d0a2f466f6e7420313935203020520a3e3e0a2f436f6e74656e747320313930203020520a3e3e0a656e646f626a0a3139362030206f626a0a3c3c2f547970652f506167652f4d65646961426f78205b30203020353935203834325d0a2f526f7461746520302f506172656e742033203020520a2f5265736f75726365733c3c2f50726f635365745b2f504446202f546578745d0a2f466f6e7420313939203020520a3e3e0a2f436f6e74656e747320313937203020520a3e3e0a656e646f626a0a3230302030206f626a0a3c3c2f547970652f506167652f4d65646961426f78205b30203020353935203834325d0a2f526f7461746520302f506172656e742033203020520a2f5265736f75726365733c3c2f50726f635365745b2f504446202f546578745d0a2f466f6e7420323033203020520a3e3e0a2f436f6e74656e747320323031203020520a3e3e0a656e646f626a0a332030206f626a0a3c3c202f54797065202f5061676573202f4b696473205b0a35203020520a3232203020520a3332203020520a3339203020520a3433203020520a3437203020520a3531203020520a3535203020520a3731203020520a3834203020520a3838203020520a3932203020520a3936203020520a313030203020520a313034203020520a313038203020520a313132203020520a313136203020520a313230203020520a313234203020520a313238203020520a313534203020520a313832203020520a313839203020520a313936203020520a323030203020520a5d202f436f756e742032360a3e3e0a656e646f626a0a312030206f626a0a3c3c2f54797065202f436174616c6f67202f50616765732033203020520a3e3e0a656e646f626a0a342030206f626a0a3c3c2f547970652f4578744753746174652f4e616d652f52342f54522f4964656e746974793e3e0a656e646f626a0a32302030206f626a0a3c3c2f52340a34203020523e3e0a656e646f626a0a32312030206f626a0a3c3c2f5231390a3139203020522f5231360a3136203020522f5231330a3133203020522f5231300a3130203020523e3e0a656e646f626a0a33312030206f626a0a3c3c2f5233300a3330203020522f5232370a3237203020522f5231390a3139203020522f5231330a3133203020523e3e0a656e646f626a0a33382030206f626a0a3c3c2f5233370a3337203020522f5233300a3330203020522f5232370a3237203020522f5231390a3139203020523e3e0a656e646f626a0a34322030206f626a0a3c3c2f5233370a3337203020522f5233300a3330203020522f5232370a3237203020522f5231390a3139203020523e3e0a656e646f626a0a34362030206f626a0a3c3c2f5233370a3337203020522f5231390a3139203020522f5231360a3136203020523e3e0a656e646f626a0a35302030206f626a0a3c3c2f5233370a3337203020522f5233300a3330203020522f5232370a3237203020522f5231390a3139203020522f5231360a3136203020522f5231330a3133203020523e3e0a656e646f626a0a35342030206f626a0a3c3c2f5233370a3337203020522f5232370a3237203020522f5231390a3139203020522f5231360a3136203020523e3e0a656e646f626a0a37302030206f626a0a3c3c2f5236390a3639203020522f5236360a3636203020522f5236330a3633203020522f5236300a3630203020522f5233370a3337203020522f5232370a3237203020522f5231390a3139203020522f5231360a3136203020523e3e0a656e646f626a0a38332030206f626a0a3c3c2f5238320a3832203020522f5237390a3739203020522f5237360a3736203020522f5236330a3633203020522f5233370a3337203020522f5232370a3237203020522f5231390a3139203020523e3e0a656e646f626a0a38372030206f626a0a3c3c2f5236390a3639203020522f5236360a3636203020522f5236330a3633203020522f5236300a3630203020522f5233370a3337203020522f5232370a3237203020522f5231390a3139203020522f5231360a3136203020523e3e0a656e646f626a0a39312030206f626a0a3c3c2f5236390a3639203020522f5236360a3636203020522f5236330a3633203020522f5236300a3630203020522f5233370a3337203020522f5233300a3330203020522f5232370a3237203020522f5231390a3139203020522f5231360a3136203020523e3e0a656e646f626a0a39352030206f626a0a3c3c2f5233370a3337203020522f5232370a3237203020522f5231390a3139203020523e3e0a656e646f626a0a39392030206f626a0a3c3c2f5236330a3633203020522f5236300a3630203020522f5233370a3337203020522f5231390a3139203020523e3e0a656e646f626a0a3130332030206f626a0a3c3c2f5233370a3337203020522f5231390a3139203020523e3e0a656e646f626a0a3130372030206f626a0a3c3c2f5233370a3337203020522f5233300a3330203020522f5232370a3237203020522f5231390a3139203020522f5231360a3136203020522f5231330a3133203020523e3e0a656e646f626a0a3131312030206f626a0a3c3c2f5233370a3337203020522f5232370a3237203020522f5231390a3139203020522f5231360a3136203020523e3e0a656e646f626a0a3131352030206f626a0a3c3c2f5233370a3337203020522f5232370a3237203020522f5231390a3139203020522f5231360a3136203020523e3e0a656e646f626a0a3131392030206f626a0a3c3c2f5233370a3337203020522f5233300a3330203020522f5232370a3237203020522f5231390a3139203020523e3e0a656e646f626a0a3132332030206f626a0a3c3c2f5233370a3337203020522f5232370a3237203020522f5231390a3139203020523e3e0a656e646f626a0a3132372030206f626a0a3c3c2f5233370a3337203020522f5233300a3330203020522f5232370a3237203020522f5231390a3139203020523e3e0a656e646f626a0a3133332030206f626a0a3c3c2f547970652f456e636f64696e672f446966666572656e6365735b300a2f61302f61312f61322f61332f61342f61352f61362f61372f61382f61392f6131302f6131312f6131322f6131332f6131342f6131350a2f6131362f6131372f6131382f6131392f6132302f6132312f6132322f6132332f6132342f6132352f6132362f6132372f6132382f6132392f6133302f6133310a2f6133322f6133332f6133342f6133352f6133362f6133372f6133382f6133392f6134302f6134312f6134322f6134332f6134342f6134352f6134362f6134370a2f6134382f6134392f6135302f6135312f6135322f6135332f6135342f6135352f6135362f6135372f6135382f6135392f6136302f6136312f6136322f6136330a2f6136342f6136352f6136362f6136372f6136382f6136392f6137302f6137312f6137322f6137332f6137342f6137352f6137362f6137372f6137382f6137390a2f6138302f6138312f6138322f6138332f6138342f6138352f6138362f6138372f6138382f6138392f6139302f6139312f6139322f6139332f6139342f6139350a2f6139362f6139372f6139382f6139392f613130302f613130312f613130322f613130332f613130342f613130352f613130362f613130372f613130382f613130392f613131302f613131310a2f613131322f613131332f613131342f613131352f613131362f613131372f613131382f613131392f613132302f613132312f613132322f613132332f613132342f613132352f613132362f613132370a2f613132382f613132392f613133302f613133312f613133322f613133332f613133342f613133352f613133362f613133372f613133382f613133392f613134302f613134312f613134322f613134330a2f613134342f613134352f613134362f613134372f613134382f613134392f613135302f613135312f613135322f613135332f613135342f613135352f613135362f613135372f613135382f613135390a2f613136302f613136312f613136322f613136332f613136342f613136352f613136362f613136372f613136382f613136392f613137302f613137312f613137322f613137332f613137342f613137350a2f613137362f613137372f613137382f613137392f613138302f613138312f613138322f613138332f613138342f613138352f613138362f613138372f613138382f613138392f613139302f613139310a2f613139322f613139332f613139342f613139352f613139362f613139372f613139382f613139392f613230302f613230312f613230322f613230332f613230342f613230352f613230362f613230370a2f613230382f613230392f613231302f613231312f613231322f613231332f613231342f613231352f613231362f613231372f613231382f613231392f613232302f613232312f613232322f613232330a2f613232342f613232352f613232362f613232372f613232382f613232392f613233302f613233312f613233322f613233332f613233342f613233352f613233362f613233372f613233382f613233390a2f613234302f613234312f613234322f613234332f613234342f613234352f613234362f613234372f613234382f613234392f613235302f613235312f613235322f613235332f613235342f613235350a5d203e3e0a656e646f626a0a3133352030206f626a0a3c3c2f4c656e677468203136392020203e3e73747265616d0a302030203020302034362034372064310a3436203020302034372030203020636d0a42490a2f494d20747275650a2f572034360a2f482034370a2f42504320310a2f46202f4343460a2f4450203c3c2f4b202d310a2f436f6c756d6e732034360a2f426c61636b49733120747275650a3e3e0a49442026a8e80c7affaf5ff5ebfebd7affaf5ff5ebfebd7fd1d17afebc57fd7affaf5ff5ebfebd7fd7af5ff5ebfeb00100100a45490a656e6473747265616d0a656e646f626a0a3133362030206f626a0a3c3c2f4c656e677468203134342020203e3e73747265616d0a3020302030202d312031342032352064310a3134203020302032362030202d3120636d0a42490a2f494d20747275650a2f572031340a2f482032360a2f42504320310a2f46202f4343460a2f4450203c3c2f4b202d310a2f436f6c756d6e732031340a2f426c61636b49733120747275650a3e3e0a49442026b171283ef41f71c9aef0defbf77e3fff0010010a45490a656e6473747265616d0a656e646f626a0a3133372030206f626a0a3c3c2f4c656e6774682031363e3e0a73747265616d0a3533203020302030203020302064310a656e6473747265616d0a656e646f626a0a3133382030206f626a0a3c3c2f4c656e677468203137342020203e3e73747265616d0a302030203020302033362034382064310a3336203020302034382030203020636d0a42490a2f494d20747275650a2f572033360a2f482034380a2f42504320310a2f46202f4343460a2f4450203c3c2f4b202d310a2f436f6c756d6e732033360a2f426c61636b49733120747275650a3e3e0a49442026a14861fffffffffffe3f90a47f7ffdedf7b0f6f6f6f6f6f7dbc8577cc76c6e4d57dfb5dad8afdafdadadadac30b060a00200200a45490a656e6473747265616d0a656e646f626a0a3133392030206f626a0a3c3c2f4c656e677468203132392020203e3e73747265616d0a30203020302032362032302033362064310a323020302030203130203020323620636d0a42490a2f494d20747275650a2f572032300a2f482031300a2f42504320310a2f46202f4343460a2f4450203c3c2f4b202d310a2f436f6c756d6e732032300a2f426c61636b49733120747275650a3e3e0a494420ffc00400400a45490a656e6473747265616d0a656e646f626a0a3134302030206f626a0a3c3c2f4c656e6774682031363e3e0a73747265616d0a3339203020302030203020302064310a656e6473747265616d0a656e646f626a0a3134312030206f626a0a3c3c2f4c656e677468203135312020203e3e73747265616d0a302030203020312031352034382064310a3135203020302034372030203120636d0a42490a2f494d20747275650a2f572031350a2f482034370a2f42504320310a2f46202f4343460a2f4450203c3c2f4b202d310a2f436f6c756d6e732031350a2f426c61636b49733120747275650a3e3e0a49442026abffffffff90c1afcb9ebdffffffebdffffffebdffffffffff0010010a45490a656e6473747265616d0a656e646f626a0a3134322030206f626a0a3c3c2f4c656e6774682031363e3e0a73747265616d0a3639203020302030203020302064310a656e6473747265616d0a656e646f626a0a3134332030206f626a0a3c3c2f4c656e677468203134342020203e3e73747265616d0a30203020302033352031342036312064310a313420302030203236203020333520636d0a42490a2f494d20747275650a2f572031340a2f482032360a2f42504320310a2f46202f4343460a2f4450203c3c2f4b202d310a2f436f6c756d6e732031340a2f426c61636b49733120747275650a3e3e0a49442026b171283ef4fb8b935de1bdf7efdc7ffe0020020a45490a656e6473747265616d0a656e646f626a0a3134342030206f626a0a3c3c2f4c656e677468203138342020203e3e73747265616d0a30203020302031332033392034392064310a333920302030203336203020313320636d0a42490a2f494d20747275650a2f572033390a2f482033360a2f42504320310a2f46202f4343460a2f4450203c3c2f4b202d310a2f436f6c756d6e732033390a2f426c61636b49733120747275650a3e3e0a49442026a219837823a96107d35a75c7afc4e83d3efbc9aafdfdfb07ec88fb1ef83e4393c8305f21b2bc1f2161f391f7f6971efd6fb5b0b0c2c87aa00200200a45490a656e6473747265616d0a656e646f626a0a3134352030206f626a0a3c3c2f4c656e677468203135342020203e3e73747265616d0a302030203020302032372034382064310a3237203020302034382030203020636d0a42490a2f494d20747275650a2f572032370a2f482034380a2f42504320310a2f46202f4343460a2f4450203c3c2f4b202d310a2f436f6c756d6e732032370a2f426c61636b49733120747275650a3e3e0a49442026a0fffffffffffffffffff0783c3c3de1e3e4d561e0f0f787bdefef7e0020020a45490a656e6473747265616d0a656e646f626a0a3134362030206f626a0a3c3c2f4c656e6774682031363e3e0a73747265616d0a3437203020302030203020302064310a656e6473747265616d0a656e646f626a0a3134372030206f626a0a3c3c2f4c656e6774682031363e3e0a73747265616d0a3433203020302030203020302064310a656e6473747265616d0a656e646f626a0a3134382030206f626a0a3c3c2f4c656e677468203132392020203e3e73747265616d0a30203020302033352031342034382064310a313420302030203133203020333520636d0a42490a2f494d20747275650a2f572031340a2f482031330a2f42504320310a2f46202f4343460a2f4450203c3c2f4b202d310a2f436f6c756d6e732031340a2f426c61636b49733120747275650a3e3e0a494420fff80080080a45490a656e6473747265616d0a656e646f626a0a3134392030206f626a0a3c3c2f4c656e6774682031363e3e0a73747265616d0a3434203020302030203020302064310a656e6473747265616d0a656e646f626a0a3135302030206f626a0a3c3c2f4c656e677468203136302020203e3e73747265616d0a30203020302031332033372034382064310a333720302030203335203020313320636d0a42490a2f494d20747275650a2f572033370a2f482033350a2f42504320310a2f46202f4343460a2f4450203c3c2f4b202d310a2f436f6c756d6e732033370a2f426c61636b49733120747275650a3e3e0a49442026a88613fffffffffffffffffffffffffbfaefc30b8febf9217daf6bdaf0d621850010010a45490a656e6473747265616d0a656e646f626a0a3135312030206f626a0a3c3c2f4c656e6774682031363e3e0a73747265616d0a3435203020302030203020302064310a656e6473747265616d0a656e646f626a0a3135322030206f626a0a3c3c2f4c656e6774682031363e3e0a73747265616d0a3436203020302030203020302064310a656e6473747265616d0a656e646f626a0a3135332030206f626a0a3c3c2f410a313334203020522f523133320a313332203020522f5233370a3337203020522f5232370a3237203020522f5231390a3139203020522f5231360a3136203020523e3e0a656e646f626a0a3135382030206f626a0a3c3c2f4c656e677468203138332020203e3e73747265616d0a302030203020302034352035382064310a3435203020302035382030203020636d0a42490a2f494d20747275650a2f572034350a2f482035380a2f42504320310a2f46202f4343460a2f4450203c3c2f4b202d310a2f436f6c756d6e732034350a2f426c61636b49733120747275650a3e3e0a49442026a086b0c7fffffffffffffc7f20faff7ffdf7fb0fbdbdbdbdbdbdbdbd87be43f07cbd1b82fb7fefbaed71daffdadaeb6b6b0c2dac182c8304400400400a45490a656e6473747265616d0a656e646f626a0a3135392030206f626a0a3c3c2f4c656e677468203133342020203e3e73747265616d0a30203020302033312032342034342064310a323420302030203133203020333120636d0a42490a2f494d20747275650a2f572032340a2f482031330a2f42504320310a2f46202f4343460a2f4450203c3c2f4b202d310a2f436f6c756d6e732032340a2f426c61636b49733120747275650a3e3e0a49442026abffffffffe00200200a45490a656e6473747265616d0a656e646f626a0a3136302030206f626a0a3c3c2f4c656e6774682031363e3e0a73747265616d0a3438203020302030203020302064310a656e6473747265616d0a656e646f626a0a3136312030206f626a0a3c3c2f4c656e677468203139372020203e3e73747265616d0a30203020302031352034382035392064310a343820302030203434203020313520636d0a42490a2f494d20747275650a2f572034380a2f482034340a2f42504320310a2f46202f4343460a2f4450203c3c2f4b202d310a2f436f6c756d6e732034380a2f426c61636b49733120747275650a3e3e0a49442026a10a032e0819135841ae1f4d69d687faf230fd3f41fdffedffdbf83f60fe0fd8f7df2082790200b20dd5e4328be0f907c7c9ebe0bfaec34b8ff6bf6bf6b6161ac30b20bd700100100a45490a656e6473747265616d0a656e646f626a0a3136322030206f626a0a3c3c2f4c656e6774682031363e3e0a73747265616d0a3535203020302030203020302064310a656e6473747265616d0a656e646f626a0a3136332030206f626a0a3c3c2f4c656e677468203133352020203e3e73747265616d0a30203020302034312031382035382064310a313820302030203137203020343120636d0a42490a2f494d20747275650a2f572031380a2f482031370a2f42504320310a2f46202f4343460a2f4450203c3c2f4b202d310a2f436f6c756d6e732031380a2f426c61636b49733120747275650a3e3e0a49442026abfffffffffffe0020020a45490a656e6473747265616d0a656e646f626a0a3136342030206f626a0a3c3c2f4c656e6774682031363e3e0a73747265616d0a3439203020302030203020302064310a656e6473747265616d0a656e646f626a0a3136352030206f626a0a3c3c2f4c656e677468203138322020203e3e73747265616d0a302030203020312034362035392064310a3436203020302035382030203120636d0a42490a2f494d20747275650a2f572034360a2f482035380a2f42504320310a2f46202f4343460a2f4450203c3c2f4b202d310a2f436f6c756d6e732034360a2f426c61636b49733120747275650a3e3e0a49442026a060cc12554081f841fa0fd3e2ffbefbfe441fa6f4fa7fffbffffffffffffafffb5daed2e3febafebaeb9af0bc30bc185e3fffffffffffff0010010a45490a656e6473747265616d0a656e646f626a0a3136362030206f626a0a3c3c2f4c656e6774682031363e3e0a73747265616d0a3537203020302030203020302064310a656e6473747265616d0a656e646f626a0a3136372030206f626a0a3c3c2f4c656e677468203135322020203e3e73747265616d0a30203020302034312031382037352064310a313820302030203334203020343120636d0a42490a2f494d20747275650a2f572031380a2f482033340a2f42504320310a2f46202f4343460a2f4450203c3c2f4b202d310a2f436f6c756d6e732031380a2f426c61636b49733120747275650a3e3e0a49442026b180f87df0f4fbd3eff0de1f6f7fdbfe557fffffffffffe00200200a45490a656e6473747265616d0a656e646f626a0a3136382030206f626a0a3c3c2f4c656e677468203138352020203e3e73747265616d0a30203020302031352034382035382064310a343820302030203433203020313520636d0a42490a2f494d20747275650a2f572034380a2f482034330a2f42504320310a2f46202f4343460a2f4450203c3c2f4b202d310a2f436f6c756d6e732034380a2f426c61636b49733120747275650a3e3e0a49442026a0e4187820f083d07a7a7a7a7debc8c374107efde97d82ea6c3f1fffffffef721efe437b45386ffba5c30bb15fb5d6d6d6d61ad85830b204070010010a45490a656e6473747265616d0a656e646f626a0a3136392030206f626a0a3c3c2f4c656e6774682031363e3e0a73747265616d0a3532203020302030203020302064310a656e6473747265616d0a656e646f626a0a3137302030206f626a0a3c3c2f4c656e6774682031363e3e0a73747265616d0a3835203020302030203020302064310a656e6473747265616d0a656e646f626a0a3137312030206f626a0a3c3c2f4c656e6774682031363e3e0a73747265616d0a3237203020302030203020302064310a656e6473747265616d0a656e646f626a0a3137322030206f626a0a3c3c2f4c656e6774682031363e3e0a73747265616d0a3236203020302030203020302064310a656e6473747265616d0a656e646f626a0a3137332030206f626a0a3c3c2f4c656e677468203137352020203e3e73747265616d0a302030203020312034372035382064310a3437203020302035372030203120636d0a42490a2f494d20747275650a2f572034370a2f482035370a2f42504320310a2f46202f4343460a2f4450203c3c2f4b202d310a2f436f6c756d6e732034370a2f426c61636b49733120747275650a3e3e0a49442026a10ea5a0f84fa7d3f1fad7e539e93f7d3febe9ffffffffffffb5bffdaf5b6b8fdeffdec83586170c2e182e3ffffffffff00100100a45490a656e6473747265616d0a656e646f626a0a3137342030206f626a0a3c3c2f4c656e677468203135362020203e3e73747265616d0a302030203020312031392035382064310a3139203020302035372030203120636d0a42490a2f494d20747275650a2f572031390a2f482035370a2f42504320310a2f46202f4343460a2f4450203c3c2f4b202d310a2f436f6c756d6e732031390a2f426c61636b49733120747275650a3e3e0a49442026baffffffffffffffc7f2c8fd7bffffffeffffff5fffffd3ffffffffffff00100100a45490a656e6473747265616d0a656e646f626a0a3137352030206f626a0a3c3c2f4c656e6774682031363e3e0a73747265616d0a3534203020302030203020302064310a656e6473747265616d0a656e646f626a0a3137362030206f626a0a3c3c2f4c656e677468203138372020203e3e73747265616d0a30203020302031352034382035392064310a343820302030203434203020313520636d0a42490a2f494d20747275650a2f572034380a2f482034340a2f42504320310a2f46202f4343460a2f4450203c3c2f4b202d310a2f436f6c756d6e732034380a2f426c61636b49733120747275650a3e3e0a49442026a0c1d01890409841e107a7a7a7a7c3d3d79186f083d59d1e99b04e3a5fc8506ffffffcd60fbfb5fdb4bd786bb15bf5d6d6d6d61ac30b0c164080e00200200a45490a656e6473747265616d0a656e646f626a0a3137372030206f626a0a3c3c2f4c656e6774682031363e3e0a73747265616d0a3536203020302030203020302064310a656e6473747265616d0a656e646f626a0a3137382030206f626a0a3c3c2f4c656e6774682031363e3e0a73747265616d0a3834203020302030203020302064310a656e6473747265616d0a656e646f626a0a3137392030206f626a0a3c3c2f4c656e6774682031363e3e0a73747265616d0a3538203020302030203020302064310a656e6473747265616d0a656e646f626a0a3138302030206f626a0a3c3c2f4c656e6774682031363e3e0a73747265616d0a3832203020302030203020302064310a656e6473747265616d0a656e646f626a0a3138312030206f626a0a3c3c2f420a313537203020522f5233370a3337203020522f5232370a3237203020522f5231390a3139203020523e3e0a656e646f626a0a3138382030206f626a0a3c3c2f523138370a313837203020522f5236390a3639203020522f5236360a3636203020522f5236330a3633203020522f5233370a3337203020522f5232370a3237203020522f5231390a3139203020522f5231360a3136203020523e3e0a656e646f626a0a3139352030206f626a0a3c3c2f5236330a3633203020522f5236300a3630203020522f5233370a3337203020522f5231390a3139203020522f523139340a313934203020523e3e0a656e646f626a0a3139392030206f626a0a3c3c2f5233370a3337203020522f5231390a3139203020523e3e0a656e646f626a0a3230332030206f626a0a3c3c2f5233370a3337203020522f5231390a3139203020523e3e0a656e646f626a0a31382030206f626a0a3c3c2f547970652f466f6e7444657363726970746f722f466f6e744e616d652f4c445643484a2b434d5231302f466f6e7442426f785b2d3430202d3235302031303039203735305d2f466c61677320340a2f417363656e74203735300a2f436170486569676874203735300a2f44657363656e74202d3235300a2f4974616c6963416e676c6520300a2f5374656d56203135310a2f4d697373696e675769647468203439390a2f43686172536574282f71756f746564626c72696768742f71756f746572696768742f706172656e6c6566742f706172656e72696768742f706c75732f636f6d6d612f68797068656e2f706572696f642f736c6173682f7a65726f2f6f6e652f74776f2f74687265652f666f75722f666976652f7369782f736576656e2f65696768742f6e696e652f636f6c6f6e2f73656d69636f6c6f6e2f657175616c2f7175657374696f6e2f412f422f432f442f452f462f472f482f492f4a2f4b2f4c2f4d2f4e2f4f2f502f522f532f542f552f562f572f582f592f5a2f627261636b65746c6566742f71756f746564626c6c6566742f627261636b657472696768742f612f622f632f642f652f662f672f682f692f6a2f6b2f6c2f6d2f6e2f6f2f702f712f722f732f742f752f762f772f782f792f7a2f74696c64652f66692f666c2f646f746c657373692f6163757465290a2f466f6e7446696c6533203137203020523e3e0a656e646f626a0a31372030206f626a0a3c3c2f537562747970652f5479706531432f46696c7465722f466c6174654465636f64652f4c656e67746820323034203020523e3e73747265616d0a789cad7a077854d5d6f60943e61c919af19804f00c4de9482f0a4200e9105aa829a487f436a427933299b26626bd979949671292400825d20541902b202a414051da5510e58afb849dabff3e3301f5bf5ebfefbbdff7e479f23c99d967f6de6bbdefbbdeb5263654ef5e948d8d4dbf558b372d5ab662fca2d5eba74c165e18ce0fb1e187f6e25f13e12cac7fa678e666db3c74cc683b7eec209431004d1e48896c6c96acdcb6282c3c2e72a77f40f4b0318bc60e9b3267ceac614e21be913bbd3d4387adf68c0ef00df18c267f040fdb10e6bdd3373a6ed230a7e0e061eb8527a286adf78df28ddce5eb63d975515848b82cda3772d8ea301fdfc8508aa2d6af728a0bf5deb27a617c98cfd6358bc27db7392f8ef05bfb6ea4ff92a880f54ba3776e58260bdcb87c5790cb8a9860cf4d2b6343bc361f98326feae864d76963e64f1f3b63c4f699e35b664d68759b3d71cea4b7de7c7b721b454da44650db28676a3135879a448da4b6536ba977a9b7a837a951d43a6a09f53635997a9d5a4f2da5a6506f501ba865d4686a23b59c9a468da15ca815d4746a2cb5895a49cda0c6519ba955d44c6a3cb5855a4d2da4665113a8add41a6a11359b4aa2ec288e92500c9542eda45ea15ea286512cd5877a958aa1e652f6545f2a8472a0fa51a1d43b9423d59f1a4c0da0865003a9a1d4202a87da407242d1941b75db26ae976d2f3fd104d199de4b7b9b6c6d6d73c48e6203cdd2150cc56c67f6be34e4a5b23eb67d22fbdc79d9a5efbcbecdfdbcfa3de85f3f60f980dc018f069a072d19546fd7df2eddee53c94ac977aff8bc729695b3475fddfaea45fb2487f98ebd1d7583970d960d3e364434246ac8d121bf0e4d7d4dfa5af26bbf70ae5c873448fa6858bf6195c31e0e2f1afecf11f347dc1cf1cf91ba91b5a3de1ee53aaa60d495d7df7cbdf1f507bfdaac7659dbbfcb16ccc8dbc073669b2777d0573522fe3a2a6423c5f2d793f020bc1898396257756e9394df4def81926fb926b3d85f3519bcc007e641809e09aea6afe9e4fed2ee6ada5f2d7f878b0ae62bc4fdbbd2c8a76e35f3cb0d36d0e524e24774ad62338bd5b90990002a456612f6eefed6216e8b77a28b8609a6abb407742d6086e3ea460d63a6b746d6d4eab5055a9df430b2b745203e81276a953a05281d43364038174cb7e82fc35e38008735ed6ac61c473b4352aebc89c126be8045b6b8d316cbc4fd7fed35e0ec40ec69aaf89297996de04b113f0ddd616bcf1fd39601d9255a1daa89863870d5c9b4e40c664d593c4442aa469d99f206d638601132290bd45990e558db0a959c998ed02c57c74338786b4374e481f7a0124a02d0b86e1b87cce4a44045b26c63d892959009d1105b61ceca334119531b5b161d234b0e716ff73fca9d87fda7ab4f33e45ce3f593c1ccdbb6cb4c769de7575d42be97ec254da8177ac86223ed2e8765e48acdda63ba3aa82531d923c464991c0e49d12afa1f57debf70bed0653d8793fecdcacde4169add0cda40c36d3007b72495071ad6c14270dd11b69a915cfd89c6c3e5b6c1f4e5bc8c6dd2febfda1c893821af414df75b6b6ce016da7c5f8430ff2aeba552844032135111535f6b28dffdf1fc7defe0416f620a0fc4af7c3f0631687023ea5b50900a2a2e0dd44ab52274d28a143f60364d3b8066a05937db4fe49fd7f8374b2d40e8b221e1ef5a2fe2df209f8c5e436ea6c63d8d77b48e66da47e3aa8e046fd80ede0449749bc62423e14b55ab33e4588ce7396016b9a8f59979240950642a3fa025f70b502d045f0886d55a3f92864afa1454665486a155d8ec8067e3cca49810b737c0916044dbae6b825638052d2af2989b36be0e2a205f9f955b8846203f073415a7eb947a25a81c214516bf430062b3fe2ac1557b0fae62492c7765ef32939489f2cd46eb459ed4f3d5374448d135964d33a9c869193c2fb85a6ce5808a0e07d751969c1c219b37c11175b3909351d05127e55bb43452fcb3577672765a013816823e2fab1069bafa3968bbaf887bc8236ed57f0cfbc8cfdfa0951c3b8a7e475dd822e5abe9165de135aeda8ce789230034197138acfbac03c1d26997b5846a174d689fd9eec92d74e6e1c2c7f6121e45f2bd58a4a19b74b91d1c1a287ed83c73d3ca6db3b0487a2f8d7d5879e9027cca7cfde64dfc2ad7ddebc5e9ab69c94fcf393c548c1cefdef9fbd7733ec3a222e96a7c9dc583ac42806ad15afafbf649cb166f9e33aa074150c3bf62b201fe25113f987f9dcd2f041d6431c5e910c7e1ab62399e615b23cef9b1b215f5020689c5b8b1bb5f9a1cd490e998944bb8856e89cb91b36da4380df7d9e5811912d33ee2febc4a5ec34f3609b0dc7d4bc407a14016bd32fa29ee87078dc336449cd87f8c472fa17e3f3c42120e47605776077818c30f471e8473d0424278b2fa60dde10e631b1c8403b2da1db53b601d418e3fb8c83c64ee1ea15ba1878b7293ac9d773421bf763bb257e5457b49223ff014bb9c46a30b6dcdf4bbe9b947a4fc3f683cea056f70302d39d212baa3d66508ee33622c66b1e4d11824be70684f638d14197b634f9a288b5a1e1fb2dd5db603dcc1bf366a6fc47ed569d80fadbab30d878ce6bd4d27a119da13cdee85f1241271cc0baaa0abb745fccffc976cebb90fb21a05a90a567b6bc209e4d7e92204a9da5f161b2357242b15523c071bf172f45e46010978b6a3b126eb10112a7fc2101ff00437ad27614805fd31e4c9cb22901ffed6016f7eaed2e216fd150bd0ae58f8114dbfa32ad827452ef48b7310a4cfa917a1c4aea96c5a91461b4bb2f24e7083b8140c9a524d954aab8158a6bbf22f115f4e67676a35590a7e42f74387fc14ad26179812c8ad94f247e83ae878420e1ba0d9a60e8440d8a60b10eef6045cc3a5ddf36992992bb3bf9299bb2612ed78c287ef16754dec9ac79643ae9c538212d253b63a39f8b56c393a9e1ccb19cfc0d3f00eec8d66e229680d9af50849115300b9c97250a46aa4e978e4b039d806983578cb1e740c1d479bf79c43367726e3370c525d12a84a802903bd516ac503de6446134cbc637b648d5de7255476cb5e72032d4277d98663471a8e0173f5dc346c8bfbbd3bcbc9dbd7b03f5c9a64042d18988dbdb313da5d3e27087ff91f8f108b24e3bec7bde7797ac862a49287177be0732557e121ed0e78aedd7bb4c775b55007c7ac51b3aafc5cfa852e8718d1420b03d22e126aa104d6a407e3f72e0f09fa99374791df837f1a8768d4ff10125516a4eb32d3d48a74b53460d4144885ade0bd3bba35e43db8082d8cd6c8e6a0b15fd6ec01e649011ee2235cd57b6838ece17f2101e6b522fe60d75036b790dc24972953400cd7bd91105746889b8b6c77df40b3c9bda688bb1dbb71861c3490ee189f0d468ef724cc3510e6a66369ec44bc9a246336a9bca297ce0e94d576cdae1172e7f144d4e58beeb368071e4f12b4022fc513f174ec853dd1243c192d412bd078340db973f82bfc0d3b1e0ffe0695a022f4c6c7b7be462317e37c5c815f9bf5a67060fc8dbc079ab779c9635173d77cf64fec472f319a8b383406ad45ebf1103405cf97e257fe398cb5da98bd564d7c2cfe102ec98e2d3eb0367f0631325814ebecbf2d267cfdba372caa2038072b0ac6d5c4180459282335fa063ff01c8b97fe55f2f8d332da77b2ade4617db2d7f9b7876066c438fc2a1ef4f00dc45cde7fa0c124d5a360160fa721282e4c16959c1414ee0accc2357748125fbe7cebd32fdaa76f1234758ad52198d1f42ff34c36d72fdeff5a8496f0a3582436e3971023fee6bdf70e727a2885d28c14655c324432d16531750da586ea56bfa64defcedc349cc3f4dce0ebf8daf3c3eed376e8eaa10d3aa08dd07d17ed24d41572d3066127b4b7169d17c28a8e3e11a118748945f3c4a82fa26e3c7e34e61bfc9a143ffd5d9578ae20cdfa4f49b5dc0b9f41f36fa54a85ca5954650df21d319a06c3b7b902310ed37edbecac1935ed11dce6b61a51d7308bdb8cc493a217e205043e8e3d55c670977e581834535a832a22c533e4c1e3b82928436cad67ac184d84ba8d6558cad488c390ccb6fbec8be3195fe0e05302441ba550b77bacd6c5a7b7ed2587d0824e164d2215eccee75c2e914d9d46a58949810826cc9868aaa8296a6c0c6ed8c12d04ff65493b18c935d48bc6d2df84dff8d7f1e455d8ab0aad3ff36515822a3b381ef3195af859f3717bc9cf28122d60a7c3e3aa3a6d63698d34afa8aabe0d98af617474b8262831529a9e121de60dcc983c765fd87e5525300f2e5dbad69ad01a59256dd9d3925d21083ce8357265a61c5298f8e294b282cadcaaf294461f2e063c149e5e9e4d9e7a193093962c79c7c3e45bb34b9a9c181708018ca40b828b7dcd31cef1413bc09b59f4fd46d41ff5f9c7b14e0e9a938e6da9df54bf0ed610cfb80332b44159bbccd0085950556e609004ffcabeb1e4d889c37b5b0feaa51f886fa3de30c365f1d6b1422ab5670792547698d1614b2a37d6a09142efd03597ed3efcafc92058e924b5663fdcb3549b407a0214374b91e636fd5dc1f324cf4a0d1ccfcd40393d49ee2b46e3a0664319e6489249263544104dfccc4a3ba88a7e0f25905ff6923bc8076d624dca9b09b088d912e03d8f9b05fea763bf52156bb2528149868c382976a0e321a390cb06adb6b25247125e5179d0f390c648048d3efcb74f4e84ec4e29920636fae479e6917c6f285c567c667073edfedb1c712bd95374c1dab47c127ca618b22ba53fd0960a94492a76728a4a999aa654f9d67b4122016e7fdf651b02cac2ea64d2c6887ac52749bf197d8bb5b0e9147cbe887743d9ecef8df92cf0704ef06734e807f1ef0c4677f9ff551f404ef1d5d070998924eb84091d2726f136d220dbf94fbeabb597c4a368f49445453454117fad2fd035800198bba8b712bfbe24ea2d3c46fa38997d58dd790e3a99efb0f84b3c9ac37ffb1325f8a397e8510294434b8e225a5c460c75f3cebdfec4c02c8315e0bddf77bfff29c56e603acb6fd6e7402129d269191aa96271405c246c83f463490f92bf7088bbb0ad6963a560bd071e223e20cd8022cdfceb663b525066de096a143cdaddf36cb1accdbb10987cc82b95a285f4beacec8f88a7f0d36c548790b66226f893b6a291beab97fb4957d2920edc1b4bd2c256e06dcd1617b0b5e92cf733dc9b62c0a37fef02502afd479f11d4e872720c49f11a3c134fc59ea4704dc7d3d0faab5fd47eb04750eb8c6fe4a4568f36a030339a6db0f9ea121a5c23424e825e8f34e3916855a458332764d8582523fb0a37d078c08394962bf5572e70a72337d24e21be7ecbe05e39473e88154845d40af57b6ad7fef45de2441fa077f9352c1e2620e3a37c055120d3f37c376a4feaaa89876cb6e67bb9327b9f54f24316bf976d8c348605cbc223c24d11e6fa1a6323678522715393ebeda036e202faf8c22692feabe847de81c5af985797fa9c84338e974f9eebe4d0db60c2b373dcb50a5014f6c01eb9592392011a4d464ac07a879006affd53494444b3a60d9f7d626167b8b450792ce5723c23795097b13ba3decf1851405c1db378eba2595c28cccfde7464dd49d5054d8ba6201d54cf99e96a65662e687582f3d0eb9b4e98775ef0bf4398f9d2178f50afc7cb6fce32587b48f4a119edb18c288edf11f15dfc8f6c4f43240e50391157ef0b0b7e3f8dc0c9f8384aa6ff72cd7f55c950293a8e4bff7acdef1a08db76bb4e6b2b1fcb0fb9ce4ea1d1a817dd03a93a88c6a37f2b234be8e9db972e9ca5ec38cea1af7adee904d554291e47cf83c96802f73e1cac6ff890b17a01ec692afb868fb2e002ee1fff690541c633e427206382f0e8b57c413386d1ee69335672c20422a2b834cb5002754c6d9c212c2c2e2662f3fb61a73ffbf0c23d4ed2dd35a9774354756868545468687554434375750367b5db047b738cc8a9d5066a50de1d9447caf3a4ae396c3712c75a9c60099a51da84c69336ba160ad44625c8219a2161dc09492338ef60f17efd8f7098fc3c81fd2444def40828d923f4ae44544a2ab20a893a550279bc34b004cfb08afa4e6241ad4d0f75478464425af585d7b95a21657349c27c60ae2565b5f4757d4fca54f2b95c84908eeb2419fbe0ba251d11f45c95351dc4b9c98dfc60c1d42689f8e9e8369b5f557ee0a2f6c5c4270adc74f142abd1aa298c865848532b95f2d7719e03ee8d1a15c5822370acdd0715444742341bd4d1bf4d7cce4396a238188dc2c821274997590cc590959f55d0e31749f0e806144184fea208b5a13256a3cbcc013d645d395b9077fe58bbce289c2154950c61a4075dad4b12ce50a929904332c424a5a467e0e1b8bf031f4dff6919682276a30176439ba64dfdbc0c3ca12f9cba36bc7d03c439c6c62b63c9aa7aed073a23344083a64158e50732f03d21749684faf616f6749985015f028b478c7b7b822bee5383d673fca0ff8228fd683c1c31d8060de5100d771f9423b1de00f9d0c6a0ab74131c12fa387fcd76f54e0880ed3aff177d1c098ccd377299e90ceacdef221941bdd1d8db22740a8d61dfdcba6113a780a5e07f86395eb4bbb625cc1026db99e4e174c5f9ce8f572f7f5628d5e69154ec61f8b5f4fe12384f76f050fb6a5c495b3b0d7cc9d95ae847901c20b502b727e3c2a4f1577487ad386a2e6e16a22d2319974128b8eb628543b5684c71e42f05a8339327e37c8731a85159a4113ae7ba7d60205b846ab6a8a3200442ad096f8532754172b6a23024377606ce7498800c9945c268e3f97a2b4094b049eb2fac3f0a45aaa22064877f76c84ed2a70b00d1e56497fc805a1c7ec4ad5972e125c762d05b416355fb2e1b2b62deed5ac1fe9bcc9fd0d5400d69ac5b5f18006136628a37a32063ddddf74c76706dfb7d34ebd2d51a7b49821cddfe9ccdf2aef3ec00c678aee486f4fdc80df4ba48853c5079289b43ae34a9c6fbfc5b7df66d2ddb0ecc9c25aecb430cf1b5f51586daa2cc2637adb4aef948612330474efb4c95fa91022edfa27a57b52a64c1cec8cde0c1bcf530f23c77110eb75576301968363b9a9eb068a7fb36afe6a31c9c6abf85e6e458d066ec1a2ea463bba8cb86bfc996b4d6357caced99634490f0f6cc318e6b8c1144abd2550ab502afecdee58037f03a458985810da7a1c632ca5842d0b81d765851f5913073f54589ddcf1c7263b355c5500ebaecec12c6da71f6f486a43e8ce267b1681972cacb3b71ec8630688c5005111efbc37ad8691d34e644431a24a4a612da5dc4c71dd095ff65ad58442306f542cbb131272d3f19521c437c480f2d4c1485497533ecb54c146917d8951572f037c5b0b536df442f52d8dd7bf71ea9ae35b7ec2fed108215a10eb1046b932e59b8ba519d970c09e4c8c9998ad5f31ce6fd9026cc7c721ca1b434df6059af59ae4e805de0aa0d17b07819b49a0ee7ef31ebe0ea0c6ad7f5dbd7ad55ef02f246adceacad251ad1aeae16f024d36714933ed2d4d074ee93069f3cf9bead79f2e204c291b4b4c4706126ba5bfbbece44badc7d9addd61bc4e9a21b84883b0993c73f4cb12dd5aff9ff6a90fdbf1d790bce3ade37e96ba742f717e3efcffebff1b7b57acb0dfc28cbf8aff322aabc652f398216f0fd5874f90f52fca086d66af34aea3a1849627469fbd64f873c9ff38cfd1e8be7ed708d4b90ea71198bbc6882526d61d9bef74fe555c3216889a8f6adf5d2af072ff0533b87baef0af60d74116682d551ad494652212a48347b8bce0eeca1cdb328d1b3e1843615a70f14ec13c67f21ea600dd1245869a5cddf34864052b714aa74429b71dd5e0e783a9facc952e7101ddb7d066a2db4596ac1f00e9d97f0c469304291bfe95d072ced76c23378b946afc905fdbf59fd19646516f921d7ee2e077d9a3eb518082373b38ad11c3edb01bdd59d637dd1d1fa2a43a488cf3512f34be47d8d887fb9ab2f9b9f9b5708454c455c451c970872b95281fbe2890ee571b66431814cabf9a0c106d97f2a421d5dafb0d5a08be656af9c0641023a0df0011caf65ba89ef52a54ce18204be7d4ddaec36f8dac2b7207a8aaab0556a253c726c4393da88d04c14752d425fb0a5956030c44292b4fb3b71522cc4c45442a994ff166f624bacef244abbff2e4eb4be5322a8285c433ffdf40309fa4fc8e39e8877410bd94871664886476a6246fa72523e19bc4cfcf4099a8cb8b327e1b123124ff902f7c7b64e6f4edd7014f4e5cd45fb6be36a03b874d210aa34551f9d6c3d03ccbd036fcd797bebdc8daba578230e940b83ee28479e165b259f971ad182a7368f4c22e4c5df66cf461dda1110171e11511edec2119f549093a3d569b55a607490a40cca58b46ab5342545f87826235b995d78eb73d4871382fec90312f1db44ebba26b31a5f570f2e1a224be30bc2cbe272e3493263655b3694253a68f7761ce4aaa026b13cb52ea122a39c8851a5e9d8fb96b4714f9113499b092d2067a9e137b0b5f175fe5c0c24a52a141ab546a301460d25598db99f9cff505a24143e3d939b9995299f3d1ff771ae763fd05c5157cba14daffe47cf9113c8eaaf10d51c5585fafcf0618d1db107337f446fdf9fffc45e82297400fdc4deac3b7319ae3337a7bd3ffe8df9cef3034db10d6683a9e1a82b2472e623178b5b80d97f4a362545bd2ec2431ab27da72a5293ae89526740ba264303a98ca45b2ecf8572eea0f866ebd2b178e892508f1d0bca3f089036679a4db09769093784460525794c7eb01cd9a0fef7eefdc8c1cd559d238d8cb5abc37ae3b30d24446744e84b9cc112aeeae2cbf120641784d6019a0868e15eb4100d40838a7b6ea9d42bb85498b2742d966cc1bd52b088a8d0bc42dcef14b63d8b07dc5e51004c4e963e57681aaf11bffdf486115dbaf731a9e0f78d4f57d43c24da83510ad2b180ec1e5e69aead33185ba09d39e37d0d8fc5d4eaa52b7656255509b5fa90272471e613674adb49af64034b7dd626c4c5c549972f92bd096b18773a0e1445c5905fc149fed98667b0ffeaf70522a2c166ded360872aaf2dbe622ff9a11ecd6151e574e19b28276e97e0e68f13afd00e272c6ebe67c2f5f5635af2c03c9adf4e989a93c0a591662e3d059feddee9806a5ec52a3152f12fd9fe21786821895e3bd2b3d02947fd36225b673460c647a9c028944a850ad49571d247634ee369807d01cff7c38bf1406c976c45bc224b99c315c0dd8f3f409263a8571112c1978c0538a8d723b4ca84ec6fd9c1f7dbcd28f68ebde467425f3716bd3ce731a638621912fc0318b49936289a3288a141032edf2bce51656768c807674a63d2b6c52c036f70cb7535a6ebd564372615d213a4f808895d7a893019d467e51496b59ebc01c7a1c62d2faecc4fe7035b19c93362729da33ca37cfc22dc485d597f22fe033dd153d22a3795d75457c7d704260564b8cdb8348eb85de6c7ef9044d09917a4b7706de27fca7bc2b5ff4c2f2cca83f56dcf2610b96c13a13cac67dbc63d9bf0b00dbff64b226d09293fa2ead6bd36c2c3bbc8e7fe8abbf6926ee4806eb0d534ca41035b8e71d5d0ae30ed6412bdc13db83ad154b63b7fdf598ff766e357f010cce208a9e419362066f10324faf6efe449c9d4efb0885b0a7e5b62b633e865fc19bb0a42ce2a4ae33ae00b52f23a1b1fdfe5ca48b3685e5de1075b601b71795be3fd439cdd32a3a1c7d0cd36a2436de830c1d0c536113f11c5b3a8515cf25ce471236a129740654c0cc42671b80937d149cfa51d91bfc449106b30406509f7db57eee67403a2efb498ecae5f44abee0b6df451748b1fc51ece4df692e2aabff2dcbc88c67669091a41df1cd5044549c0486ee13ec856fcfdedb60fb9ddd0926a88f6522bc2208109ac4daeacaa2adbfdc1c676a749f8e52dd886c3e23fcce3ff6c0b74cd920923ffd1b52272e9bef7457c38ff94cd17c4c5c860a518f70775b1b292891407622fd290ebcbf2cf1717e5e674924e8341de6279c25c6c230b9c8287046229bc4e20ed7ef8301c2ae08ed1704a7f2aef645655c9ed831ff6341fd8c502ca6f09229796b15aad266965d81a0f572951710d282df029ba7e1dd117a2f67bbf805c1914e514e4fdeebf18cc4869905b02ea4fc2f990979070fef535f95f687f85ade48612345aa52ea8c40be4c08cc0361b464aff7b4142fe66160792c03ff8fcf0a75c3e31a7f56969ca84548880b8bcc47205f307bc3f24789fd695c6e2d7bc1ffe32619c377a4d6cc17bd70082f5a3d10751edc1e8a3f6926b6816efc6baed56ee8172e6dc47ed57ae5ed8bc8883f53edb9d03185322fb49eb91e37091b93ff5f4e4d16f394de2880f766f772d4c698dac89672477d685ced83066f0f01f97fd846cbfbdf533072df243beedb1c68482956dcc684fb63ebe23e4bde0fad88e1022d04e0b36cf99b1e8c35b1c9c69bcf0558770ded52e6b91f31952d22b44a80139b36770c53a2b2f5bee7f59c58f1278b9e23ef2b92b089d085d6183689c3cd26d1d170f2ebaf03dccc1bc86727354a92c2124cd67d949afaf8831ed8f86a220424b64c2f4c753b98db02d6e87bb977bb4272c60f0a06fc6a2dedc39d8df5e7586c103df6113c00d82cfc7b5c251380227a1c3d85a77746f71336168d3ce72f7a2a0ac55e0c6ccde396edaf341e5531b782a421b4ffc4975e95980c27ad6f0fdff7511eefc933114af7a5e72797b11bfa2cb95cd2e16aa2e5398962fe7924099aa4ac57fff65a1436632a93c6a469e9f56c895405681bee00fa0fecb9d63bb452c84c1bc954e19e9bf09e5275f20a641fda9cb0ba46713d669b5b9da425d5eaea5e898ba1c2cdfc5e6dd12f13bd05516bec8fc22e053b7efe6947982332c8cf09a14b424731ebc0d0bb2a6ec9f7fe0adab3142203f371efcb6f1527627f131d81f5f657d606d4ddc77f2b3709f58dd0b7031ef64257af9b3fc1a68828b7195630a36c07c5845bacfa5f2958913d687b803f3bbc1b07554f03f9908f727c79e6fc275e528b4508cbd8a68739f4b2f737d7acf32f47dc994dfb7ef2543df7e14f5ff009ebaa58d0a656e6473747265616d0a656e646f626a0a3230342030206f626a0a373838310a656e646f626a0a31352030206f626a0a3c3c2f547970652f466f6e7444657363726970746f722f466f6e744e616d652f444b5744484a2b434d425831302f466f6e7442426f785b2d3536202d3230312031313634203730345d2f466c61677320340a2f417363656e74203730340a2f436170486569676874203730340a2f44657363656e74202d3230310a2f4974616c6963416e676c6520300a2f5374656d56203137340a2f4d697373696e675769647468203537350a2f43686172536574282f68797068656e2f706572696f642f6f6e652f74776f2f74687265652f666f75722f666976652f7369782f432f442f452f472f492f4c2f4f2f502f522f532f542f552f562f572f612f622f632f642f652f672f692f6a2f6c2f6d2f6e2f6f2f702f722f732f742f752f762f792f66692f646f746c657373692f6163757465290a2f466f6e7446696c6533203134203020523e3e0a656e646f626a0a31342030206f626a0a3c3c2f537562747970652f5479706531432f46696c7465722f466c6174654465636f64652f4c656e67746820323035203020523e3e73747265616d0a789c8d58095414d7b6adb6a5ab348a4aa78253aa501147224e31c6c401448db3a8a0d0206300516650149141b0bb4f3708028a28348382a0b48c4289034413d10c6a7c467f468d498c313f3e63720a2f7979b74133bce4adff572da8d5d5b7eeb9779f7df6d9b7154cef5e8c42a1b09ebfc463fea2c5135c9639af9bec647932521ea69087f7925f5492369239bcb7e1c902abfae1cf3fb2416910fa0dc0a90319a542b160a9974b44644274687048acdd589771769367ce9c61376f73507468805fb8dd32bfd890a0cd7eb1f4c326bbd51101a141b1092fd9cddbb4c9cecdf2468c9d5b504c50747c50604f5c9788cd9171b141d176cb220283a2c3198699b834213c2022d0253268c5fc95aed1c1316e0b634357c76d5cf346fcda4d7eee9bfd3d9a264f993a6dfacb66c797ea19c691f1645630f399958c2b63cfac6216304ecc686632e3c0ac6616316b98a9cc58662db39899c6b8334b98e9cc78c683799959c638333398e58c0bf30ab383b161d4ccf30ccfbcc0d8329b196b660093cd3852901896bef29ee2358549f1a4d7f65ebf2a4189bd837bb75b4db0d2593d505d6063393beedd3e367d82fb0a7d77f5fdf139d7e7329efbae5f583f53ff29fdf75bbf62dd3460f58094019706ce1e787bd0ac419fd984dbfc4bfd827aa63afc57c5ceb52bad7fed555f650249be2b2990c191f88ea4ecb4c523bc4695b6601b99421602672fdfc561926a839628c0133680030465721a64baee1246235f65e91c3e0f57128d59be20290059a59c29f7e3730a32732e0327b131bacdfa6888061f63bc81d3b0c666d8a9df9da2d78b84257aa2c652ab3649b5513759af87083ac89f0ebacce28aae11b15e715e610be7c3901da033a465e6669516400d772ca62c34227c6be03ac9ff1de1265ce838729ea32b48fa3219247cd81e6cb6b9822af44595adbab959e2356c85e11d632dd4c1dbba0a3d272dc0201615b75b2f1d37c5cf1148e982bf0ed8c73e5e5b37469800ee6e51eb38f54d64583237cd4ac376e440a0483ae88615bf0e8f4caf9707d4d3fd3e8fce3848895df2043e61bb2e1e52b90d355b8f54559b1a6f132e7b1559388f6e942343be9d882fe1cb4791cb29d801294202e8751949514bbdb6ae038e8880635ade027c01f99a835aed7ed15afe9006509bbb03e4e0f34ab90ec3791c3ae92199415e711a4d8690815f8ec159f8da9d873840207bc9529ea801993bcd70e6e071b1e844a3a9151aa1717b49882914d68017370d0843d4420f58e9e6cd92ac34e3aa761b4b843da8220c32b6ea6df2f712bf6c17d489f26396b8febe6d0f56dd5ab7de237be330e230722a1941067f3311c75e3c55565e257ab2b824db8a2cc19f7892c92625f8af9943f7640dd8ffea29683b5c2756364a7955701eeac34ac269b694b30dbec992fcc442174759dbaaeccce99ccc17416e82900a3a5ddaae37560e5e767ad1214a3e62248e641cf1237e48ef68c415688503902dde65d896940adbf4e22e3294f45fee00afc38c328f8b9af33b6fc057f056263297de7bf7bd3bf9672926707f4e0951676e35e84a813b6c301e167b4020ee128e30cb8af6807aca1a8622a0a2483c6fabbe8191f8290f45064341417dc3d9ec12e0de7f6b39b121235c3d16efd0409b8f98bc1f0c50c45d219779ca99e56c53c8c99406e070fc3fbf421187387d4bece7ba6f4a8815d5f75b7f073248ec32fc27e5e85a063c4fe9844b8fe1ab3d094fbbaf94fd69be4bf2e04855faf5f5a7c537cdee87165038a64db32783c8d01fc6e3749cd2f4d3c1435b21639b2e637bba18efe516b6988e18a1c72167c463bd8d758646d3b1c3f5f5fb2a01fb8091d81a422cd86fb8fd457263a7aabe1bfb79e8a8ecacc76f78dc4446e348124d128848c692374900da9151b805b7a180a3d14fe8ea4d2ef22bc1b9c2ffa38d1d69d7e0365ccefce2e4070d17df2f7f1b2ec39588fa376a9764cd8685e0ba7b8adf021f67d7b8b5608917f590f94d5f86cbb6384689633ad57c8f7ab8b0b81ec7d3846ec448321e79e22976396b54a8edbacb53d97160df83cfb6b6bad6acdbbb105e02a2d8e91ee6e3b570eaf6e5dd53db0c7d488b7e6f03b64a3696d9c970aa60d5e868ab7e808dd8cea3ab8ae682fb10fb60afb15f9057c5aee9cf744b559bf93d34d1eb7ba8d572126158f5630a7c2b4f86622b0e53e17898e3321f66930916aefc98e94403d5489877ae4726a753990cee96c93822444c21cb28f013b1a65df55d9eef3c51c2e31ad5bc54dff1c21accc3892a9c0e879d0b497f4e526dc274ab5f1496557c4657d169a3a26272ab700f9d7d3f8e5ad36ea1e14f686d4b55a7ed05691abab057cbd1fa0741af4fd80ee19c7ff596caca6a53fdb9b5951e822b04ac8f5dcaa99bd18a25affe41a028c16a0ccdc616a8a589316b39aa25c4db8c13bfbb66c6d8061bf8d61595381f95f0a5eb6d5bf5cfc9b817ddf8a9f07e7333bcffe597b0c8c707164d1589750adf127346574e496ddf7eebaa147d2cb1503c5a6832e61b7419ba5448e7a20f261c3e7cb0a8ac745b8db790081aed8690847d7ea679140cfb35afbbfa17fb57c78a1121e91b211e12b33cebc338752793a4758e5f3a745dfb5cd4a0ebadb7af0a7034edd2a2e3ab2b56c00488026fc8306cc849ae8543909775207b2fd741d6f2d847558556b02c38702d7981f4f36c6979e71214d0cc282e14ee4937cbc3aa6da0d1ef1aeea4ff2cd805a3c4bf99b3381f24aee31e140937a0367ccf1a43a221c3045c19ec29153f66bbe56637e820706bd4fe90ec00e036134a31db80e2c8e26d627d486dfacd1d9cfaae39fd46d2caa17327419c3002a2aeef6cca28c8801dc0c5407aac4814ec56483d24e480114c070c507220d3d81276168a81abc297001d9ab6d4845488819561d9afefb730d627994936474b5865c6aa1ece622a8eb743c7af4fdbaab7a3197fe1b10afbb238ddf8faf2d5f00a9929e284781eb9a367de85f7b887a4d7e764a5d035f0371a9b298da9ca531a9bbb698c55acfa3485ab004e42556875086c056778033caf869e8cebd84d05eae7fd5f1596d00614af4f49d28b199af0b8cdb00252af6534eaf2d3aee8f7ecb8baa6cab7d0b256edd887c952b0090325b9af6463518bf138d2b3d5569dd839e21c5f15f94e540e7005b0ff8088de1f4b6c88761a04c22a5aa66b2df6c0de81554b347a78606c5462587a184c87e9959e1dbeed49d7e06bc0dec5174eb4d69fbe79e23bf8f9aff28c61ec9fbb81f305973c0f4a2b3d9944c69000e285a3c924cc3ff6c8d871da4283b333ae5001fd55c239c58a4fa98af79594b8591ec1a383441c70b546a51fe33976ac960bfe941c61edeec45dfba8f9fc75e19c661dbb302c2662155c2ea57d513127ea5cb789b88b4e3655e844fa5a3ae23d8c95dd79e26c29b0b77f2bb02a43abb1118ec2199d999a8665acfa619efc3e7f32f8b89f6f4888af6f4d4853a3f9f8c9a7cd96f6ba7f35d9408bf703bcf26076b3adfabaec204fe1c9e8aa80dcd5c7e1e290a68a8e1f848fe1616829199e1503ba672cc5253d38a4815e9f9ce2b361f0aa96c5b95e16ad71993072f1316f539cd8ea797c172a6238f5bd2fb71ed496c41f482ca745c479452d1825cc0132b1380dc7e90fc19eb867945ddc43d95c301af7e6b4b40c7ecff35ebaa571cdec40ab87a87cf513a722f19947083e47d17866a87a0c42acbcf843fe75165db3ad24b6db28a89b65ea9096fc2e40abd999ebdc9d676bcbdb04fcf64fdfec60ed3e89fb5fe1307c082db728c7141bfc232dc6f1ad6ec801073552d4bbc33cfe4c5e4ecddb41288103ba92dd9004f15cd708767da2cb0a613ba41913b38a0af698e0005713752438283a32d8ed9dd04f6fdf3ffb932027b36a1967f56e0aa9f17d968ba69a9a26c1bab38136a25b171434c7bba886a7510d8fed9cc1ff325d154fd2ad24552e5ae57d82f6c0ddecba451c35aab64caa916fd38bdeda2cd5e528dffa88c55190372b8fa8a898d30d340c7be69e553852898db4b3a14a52f96bc75125f38671e06f2906152d5695866da0c5da42afefa1c1329deaa975de6d9207522b249fe971ced905593dce395a17fe47e75c54a94dd3833e2345a47632933ae7c37feb9c5dbafaed8bde0ffb61c841c8cbcc33594a39b6e90ae5e00f3d1e5f16cf293be3e49f792831182a32cb328d50015cb9a40ad2bad10af6038fee4597b387e0a0fe90ae526bd0431cd7d59fa5be40e14914c44587b66f09f234642436886ed4975ee39e1d0a26b26408b5520a0c40b72f68e31df05b61c977db15b4bd2931b67331ff076bd9759ad653b5e194d1d28e5b74c72d26dc82cc24ab1316978a2b8ea2a39992a3cf6c1c84d32cc63e5eee7b93df04de3f0aa754c5fba0ac340992c4e506bae7528e4ac7ddf9ef92716ec47af7d4674e9cf6185a1cc68aec6ac33ee06ed4f8cd1143a93ccdd7929c54327ae8041c987085d69fd450d2c86dc3c9fc4476c2a4a4e875013527056a1f714ac1e94c0b8c41914c9aa9534573d5795ed9b955fe85cfde9f957b1db8220a9ede4b17090114bc400a049bfb3fb073b73643af15894f9717099563acbeb5203c816215083320840efa86c5ca5f147b13b2d22a6048215d7d7e9925ca99b52bff7894f1ebf9b355b7fed7e3cc9dd68ee3255b66fffd71e6ff1cb08f7db4aec15e70028ff551de5bee4dca0c8269e0e61346adc5277f73f6797a7a30c92f769f1efee49bb7e14679348f2d7f3c39743d90d8c2a283870a8b387553daded6b57787e1b847dd26d9f15b32da797df89618319b50b796c51ea93955d94eb5c81a487f570dac890a14c3fdbd93c3c01502db520e50747a97df9efb3407c37bc72a9fb4c984cf3e68305665161b4d5068299b487d88ce07826019045b32510ea7a03299cced5a3d98b8ca3e56df59d2e0d89d86d7bad3709b6d18418693c7ffed5bdcf58b227b7b564a390c2987acbcec427496dd07a37397fb9f9e5a6c969c6dc2978aa9b38e50ca33e43b7c616e493e547355115561422cec4cda991415be7c5e74f8d13707d3d1b424d2a593c50a6a809f53e2cf9d4abe04f2a28464ea495277cd76b3a7ae89dba229561542bbe1ed22aeab80881af664e64fd04aaf9fe0a44543ec58cb44b430cee3885acb79ca1e17a0a0940b309a9a53ed96d4253b7625a7cf85edb4698c514975679b9a8fa1eaf3cb12dce7901df50f7a90ebefb86cf2ca538965d5f525a70538eb5798985559569b6f06ee76cbc2b90b8216bace178937f14bda4917b66548823ccf1233b9891a6db4aafb105facadb3b803d29fa654c017e99d1a70ca89c7f898bf62ba7e1e6e7337e774d040cfbdbe64966f55646d7379f509012eaccddf6da8a938b9b70ab8cf32976c4cd213db51e9a2bf4ea7cfd0a7e87529d460aabb9213f2e0907052850a18b74e03a3474579641df5128fe596974303d71c56b5c12f2472dde4072b90c785d77ff85a80f6f0dbb4b172ddf8a242925d8b6db001071195a5861ecaabd0897f208d9767aa8ee8f64408f1b4b3ee4c24ffec7a63b0061ba8b8f5d6b0b5995f5325aa873b5043211ecfaaefd1979d78022a04bc64d5bdf98bd4b9d99bbfc28174eb435f3947cf2f23a995a6b07bf3c8be768f8c15c2c15dab09e370305b9191af3b4e59edf00d5a95e7e8f2776af5b03b59748b734ff78539e05e14959b9aa9376881db01c9db45d2cc26405289b01f8c59397beb5adaf2687bbe0b536789ea27ce3086f4136260e91ebff366636519c5e09cef8198448fd4e52fdf7a1907e2b4efbf426ba17b89f8c87c0a071eb62447c0e538c80e87dbaabb7029dee78b584095a929e74099d466be48adf6716d696c704642246ce6424b23eaeaca0ed776f85db294c5cce9648fa07e02afe5ce6a5820cdf928e62add89f8dda73814ed1cae93fe71ab618e9ff8985ce23d20b22ead707b355c87431c0e6a93daefc3dc310e30cf41f8ed079a47d23f505d64b6b941557509da8eb2b4fa27275ef80ff5c747b8882dcb8610917cf0d7de204f60c9fc74daf4f4a01b4249adeefa9efdfc83da6f844a306594266d4b8fdc06015c606594f9446579c3d90d97492f3290d807923ec298b99a1be491a5bb587efc42e707b4602e28f11a3af30fc885f1ecd356854ef4b99312536ef17f7511bfdbc4a7ddecffe10ead93f33b9df349762efa9854c43b8795faa2ea39a16fef19c5fdfad4e7f4eb87aa8a7efd0dfdac19e6dfeebc5c250a656e6473747265616d0a656e646f626a0a3230352030206f626a0a343435350a656e646f626a0a31322030206f626a0a3c3c2f547970652f466f6e7444657363726970746f722f466f6e744e616d652f4d4c4544484a2b434d425831322f466f6e7442426f785b2d3533202d32353020393133203735305d2f466c61677320340a2f417363656e74203735300a2f436170486569676874203735300a2f44657363656e74202d3235300a2f4974616c6963416e676c6520300a2f5374656d56203133360a2f4d697373696e675769647468203536320a2f43686172536574282f706572696f642f6f6e652f74776f2f74687265652f666f75722f432f472f492f4c2f502f612f632f642f652f672f692f6c2f6d2f6e2f6f2f702f722f732f742f752f792f66692f646f746c657373692f6163757465290a2f466f6e7446696c6533203131203020523e3e0a656e646f626a0a31312030206f626a0a3c3c2f537562747970652f5479706531432f46696c7465722f466c6174654465636f64652f4c656e67746820323036203020523e3e73747265616d0a789c8d566954145716aea6a1ab40c4c4582a51ab2011354a44d0899a1917445a45511415125cba5b10904d6840596493b52f681a171415da0611b011d91ac50c12892611272e512693d1c49364424e42608e8ede228f739cd7a0494e329999f34efda8aaf7de7df7bbdff7dd2763acad18994ce6e0bbca7be9729f195ebe4b02dd3d2c5f9ca5093269a2953449be91ec9f68ad1dc8b2699a68df371a0b5fc4b5a3d0e305462e9329570579c5ec4c8a0b0f0d8b779ae6f59a93fbfcf9739d3ca342e2c2b7a9a39d7cd5f1612151ea78fa12e9e41fb32d3c243e69a6936764a4d33acb0aadd3ba106d485c6248f07058af98a89d09f121714ebe31c12171d10cc34c5a9514bd2d26d86b67885f5ca876597c78c28a487594d9dd63f69cfa994d0cf33af336b38659caf831decc64662da364dc197f6639b39e99c66c607c988dcc74c69759c2ac66f630a3999798310ccf4431a3183d23d0b4196bfaeb43d92cd961d923ab60ab1e79a0bcd37aa275928db74d9f0214b7d889ac966d66bfe5c26d6d6cff609b6afbc86e9fdd83115b47648d304b231c9e5a55fcc08059ea35cb1ee378f90087465eadc856a6100fb21c3827a9171dcd8ab70b3c60236c07a280e8224ef578b0d759255d61e9eab51d0cd96492ae9b658032b9b4571ac5eb8fee3fd0059c990d2fc8030dec8402584717b1856d90969f9fa3cb17892d79878cc11a9bcb6685b66019c44034f8412c9dd4c5a2efa04b6efa9ee8dc74c7c42d114a6fc88374c8d01715d694400367d21aa222b589e19b5ad51f08f7e1bdbbe5ad9cc3800d4dc0ce24bb8932dc6239c569bcca7fa7799758095ee01b16be98d3a195822cd86ba3623f2a866091dc52aa5863d127709a8e3b602ce0cc4a0c6791f97b47d73983769140aa7e3b817590f273eaa571f534537b5c867672290c6df9920cc8145240a7cb4dcfdebd73b91b70c419d0f5fcd5421c87e38aaf16e4ea74ba029d989f9f960a719cba2eb9d2d070a4ed3e61f51b88d29b70842513bf73c3a9e85e8b5cb14031f5c86068a0974d43814ad05e2e55610c8f13dcfa883b993be75532968ceb791ddd71ee977d385a2045642d4fc602dade6f833f97d58b279bce9f30c3fb50bff3784c7928044010370f68205ea050e598e8ceb8a17d68733d450bfb0796f0cf81d9c226946dad56d2245e99329b389157fbde40c7cb6d65a646318045a5dec6ccfa6643a328492c910dfe8357af0e4c0ba5b35f007ce92f34fac906b1b6f3aade08cdd09a64daca393c95bb6630e9660c28471f036a2c3471960a5be4039903737823ec4b10167bf95f5c5ee1098e642f99495cc876a2c1d7c86b58804a64d101ed8ee714a6666642864ecc22ae840f70071f987dc2ff5a5843c46540017e28bdd3d6d9d5dd7fe82274038e54d790a5455907a10438231455883467b2d18c2e264be92c14d15344f12c99c12b71bda232a135ee03e070d293cf710a0a33bf2613fc0277456c132fb1c4f327c20c1ef8351f9452337fee62c7b146e0ae5ff523e3898b57e04a95ea645ba4482b285bdd91538ffed5b870b888593d7229106379a31e2a6bb2bb37b789ea16ff236b2970b3de7021a389d3c3593803679c7f7cbc3415725274f9693962accf8ac4203ac34587133ac56aeba2e6c246437dd999b327cdf0040e12fbc2b72cf032d937c18ca50dd86151f04bd886ce72acc62b3c2e54e01fbf7df01019d70764be38e83a2c5b4575d113a8a7e30954535a3bb3f8b2d4cba31bcc5fb602e612379188d8a170782aebdab3f399ac1e3d444e8ec198c09b8a7136da0a7b32b2932189d398922b2b4dc79bdb034e07097f8270e51e35559a5c41e6fd5a69dd14b66ab8071534e21c7698e264f319f4e8e93e83697532b88fdac7fafb721c8b3efcc5d84e28a525112e7f7aab3dba3efd90587dac62fff1a2fcdcfc3c48e3128fee3e75ea6899a122e98c5a50812631314953117c30904225ac5fe81d7948d3122e26ef4e0a83505019b71b52b439bef1b08ef3bbbe1c57e19b5fbcd72dc0576babe34a822a56c26c8883ad905ba82a4e6f80323850587af8088723f4fc1cb879e102dcfcf24b506ede0cca39622709e2efdc4a0b080b5b4bab3d3eb4b3a1eb1a94d262cb2e763054544e3532b8812937e4d24869115f06c5a9420e75bed4acbcfc8cecdcfc9863dbf5542851643a90b1afe00b09b5b96255ae29673f346535c5819a5b380b12854058752ca637a75c57980c5c22e4c78b8465774376a9500c45507eec54d9f8f361efc109e02ee38b25e87831d6b4eb84a8a90bd76f38b4f2f09ac37091bbfe3518049483debb28ae30ed80450606d867a40795c77bdea44a0c324ba38765e86131fc4c4ce6ff66b161278880d5b00256531b466717161221665bdcaeb4c84c35ac8369477def049fd77e48d90c0f8fdf3adff1fb82c368f6bf0bfbe3cf4a3b9ac5ba88f7b5fb802b8143c72c28b60c991e6bc645e5b27b54a5235be4182ab9f038d94c26a3bf5aa19b16346d5a3eb7e31ea9659defc77f72b7b5f3aed0a10e6057444547ae818f8dd43a65f332683343a9fd9f3899f2568eda0139dfbca3365813191e12521bdedc68aa6d16c852b2823aded55f10f42654518a760d11d4579ac10e1b25d7fe534fc1c7d2ea9f5c32905db465f582c579959705fc9e25ca9fe99ec94efd38fa89500177c17c8f2b7c53819e3f7ba63565becc48bd72a8dda235851f4f0f8ce3d1daac082d980a6a3aa642a8057febc15e62ad62eb8bfaa1858e7ea8a70723431b0ca528f5b60fe51735e0c3ffd2a7ae0c65739b665305b79ff7ada756af3ca014454d15ceb1f8911c35962ea9c24b7ccf928f88b33fb1cb9dab3e935455536d6810a02cfb44f261d3c10aaa07ee4673c87c711b4b2f03b3b712f92ce476ddfcf4dd96d672713ba8fe29b42b0c07e0a4210bf688ab0ae118183922ebe45f9f9b14f1b6c67441806f90a9fde11d8b4bd50c1dfa598fde3afcc8071ed03edd137c89580b5360d3b294889407cb4a57c20c08f04d0cfa7f7bb6ecdea56be74e262cf88f3dfb7f4e78e645d20103ba96536876c82537a9873f526c3c02d55c4d4c4d94100f7b9273b2890d9938be6a87cdf07c9acb3e736bb98c766d1b39f60db07c750144089e2b891c1280dbad2a539c850e7dd3116ef02411556c4bd1bfa08d8ec7d062a9e3a4676101edb00b1ddb2d7274443f1c23978a3082debff213b3fd5233f7662f80546a6b6e8a8633dffcb5f430ca3fbfd10edf7368e7749b7a90cdf495ae1bcda9c6da7a03c5ba25d210b9bfe942c77e03703dad8bbd166cf4d2a8441245766566511f4a724c96e63d0b9bded488028e3efb058e69a997d5a215fa5a9ac651fc8252115e0dda02ce84495cb1af2e48341f2cad851aae39ba5aa38e8e56bbf56fc05138ffb36ffa057837ee3be256f555d5871fc1675cb7d7352212ebf97e6fbed59872aafa6c193d9131b36e53714bf30dd003f73528a3a2f2364768c4d8f0d882908274dd2e5d5e414e3e64431e97ac8772e139b0a8304b3e14d90b168a7aa33bdf6b9e2e792a2a75fbe384249a487a2ae91d5c335e85e78882c8546c75511f6d6675d0075514dae9f45a22c5f0e4360176e85e883f5eba83f60693ecee230ca682e997d6f37964723f8b366877a849384c17d7ec8acc4cd3422cb7bd4a5b673a6d6cb8bce5ca14babb6b3819294cf154dd253ffe5656f8237ab3957a5d9848ba7ffb579af95caad488e823c7dd9f0c1951f08e488dc614d9386444bf30ac61354b1b79b2d042f9dff526d621bd64604909293e885bcb156473316bb643d908c1ce7a6eb9bd6ddd417b7b9419ed4716da3b30ccbf012ade4f500a656e6473747265616d0a656e646f626a0a3230362030206f626a0a323734340a656e646f626a0a392030206f626a0a3c3c2f547970652f466f6e7444657363726970746f722f466f6e744e616d652f43484945484a2b434d5231372f466f6e7442426f785b3138202d313620373334203730375d2f466c61677320340a2f417363656e74203730370a2f436170486569676874203730370a2f44657363656e74202d31360a2f4974616c6963416e676c6520300a2f5374656d56203131300a2f4d697373696e675769647468203435380a2f43686172536574282f412f432f442f452f472f492f4a2f4c2f4e2f4f2f502f522f542f552f6163757465290a2f466f6e7446696c65332038203020523e3e0a656e646f626a0a382030206f626a0a3c3c2f537562747970652f5479706531432f46696c7465722f466c6174654465636f64652f4c656e67746820323037203020523e3e73747265616d0a789c7d947b4c547716c7ef9d61eebdad96b2a5b7c547e78e2d3ea822bad582b215c9f840b7564bd5a0b5c501274a458679b801a93ce571e7cce52532c8380308b78e1a8bcadab85294b44dd51aa3aba5a4a53e9a26bb0bcb664d9add73a73f36f637501bbbd96c7e7fdd9b9cdff7f73ddfcf392c13a16358967dca9cb66665dadab9e675e90b13c33f4cda34569baed35ed0bf476a7f5c192a337c389d2f7f06337f83cb9fc6842846cfb2ab7ebfd56ccb2f74e4ecdce532cd31c799162e5992684add6375e4645bf24ceb2cae5dd63d1617fdc835bd65cbceb1ba0ae79b5273734de9e10aa729ddeab43afe60dd312e6ab6edc9dfebb23a4ceb6c3bac8e3c86619e7e3df50df3fa151b56a6afdeb866d3da8f18269e79914960629905cc4c6621338b798599c32c665e665e65e632fb9928ea84e1990ce65b36931dd025e81a753feadf8b3045fcc930cbe0348c705bb8830fd9f8efa3221fea52fe7d13d4d024951dbaaed7ce628358c855cc2926cf921410e673d972fd2949fb88ef560e0d1a3b542e4b7e1bb22017de823c45b0f3379be15d69ec0cff6e29ac32dab59d3cbdf0dc060654dcad6a496d2c3e0cad16ab5ae4da322803b9a6aa98ec1a1b8d29d8945dba0b68b95fe9810074410f74ca82ca6f530e9c042f3429f54a433fc6c5602b77992cab2f0119aaa7e46f8702a39d0f2a97e004a8d03751b2190aa1f8b4405ab5f32246925103a9e11ebd61dc549b36b54d8f96d02be28166b7a70004126d0f703de0afaa750b637dbc03b625d36b8f2ae7e83bbae01c1c0d5f9b0c17ba24ad9b6fac04b9b14ce3c77e88692ca9857a100e416d40d22ef35d7061c8a8f22ed9020e7a2ce00af76308b639a4b1ec701b7cdee5456a68aecac2a0e66cd387d850b2e8777b2a8dd5e0761f28c94c8cd97a757df732faa0149240e6922cb20313c8cbb81ce347701af287a0aebc026acadd520531cd5e4c18106692c4dbd8828771e99f47d170278e480149a1dd6902a11914bf44556f0cf417f943c9feb0aa6d501f5a8c7f13d14266e37cb2942c23b16401c92499388bc46332a6e04bb800b719c975f2179170240a392cc3529cfed707ffc29879643fa924d1444774e19b3f697cf0734baf695307f4974229e27fe78fb7785c8c22cec10df82689c6df924489c4fc67a63841511f7f4aa9ef3162047717e3b7922e32232bbd205f72e6a66f9a070295702d2aa5e4f4b6e38db00a5e1dd4e3561c10711187e2f0bd919184efc9f312f9dccefd5a9632d14f993801fd100c87b7aa14ce4b32768a189c507c40eb4fa7262dc84c2391d22f3a3754fce3314a3d6ef1ebb51fc6c1df4b6617279315341369827c0c0ef3c34d3949921f5b0ab9a4f29c78633c2adc848f17384c00ffbac3648ae0e79c68378cd53e7a5af7a38938124621e8cc2ff251c52b3ebcac3e439df50e8efa9f8f2ed6a6e3b0381218ba0643c2f08cfbc464241dffc3dca57173971e33873e3efa023ec17d06275d878b7b76403eac8634c8399e7326eb6275070803cd778f3440637985bbb25aaa5a9bb737173642e51795576adae556b9a3b2afe24b32a95b58d24463c7f6093f5f727747f348141167389687bbf495f966918aefab5adc38c32baf5386f16df14c6dfd550abe53de44556df09ac7ea11ecc7f9ef94d29dd21a9ed2f25c796e2c79ed16c5741c54231ae04e5c80fc8a542ce3ffff2c58701e4574c5b7df043f3b211dc93a66a3a357eff18c334e278b9228045954e99b74a1df896303dc3e6237f8b9165c7a3888f3c10f4138e80ed44009b884b1b3fcce9ad224a3cdcef57afa3c1fc3c7d0e7ee750baa8d4faa69ee96b4b33c7480d75f77d013a495180fad792d64290d35f221bbda679ac0fede753d6ed134f1bc176e53ffbbe50cc8a12703768707ffb6f7e7d04ac04c433ba95c8453f45c8493e1d0cc2534b489b54477c2b4f0aec5bfb7ebb5d3582892a98b5e9d67cc80773eb09ddbdd5b7d153e14b418fe7c33dca42a79f266ba6c7361f3e3eb369a27b1c8ce42019ffb0aa7fcc3a845f19f5e6c083eb68db63fb68da887c17d5145be5bf7359906791f175ed3632fce1613b66ccc30da61bdd77ea5ce5defae0321d0d972bc739fdfe12c783f2fedca1b77bebefde93dafe46904054e095a120f47e098d25017384a71a4ae6458218737df3b60a16a9dfcd76104a8dc17fe52ada91d5f6a630153f5f8cfd014d1db5cab40b3d05aecdd6f2c81eaaab2126220b13107cac11d3e4de58a2c4416f942293ed2e145db418e6c6fe2d527fb27199f8c28b44d7ec27768f2e4fe96c94f31cc4f81ae9d690a656e6473747265616d0a656e646f626a0a3230372030206f626a0a313635340a656e646f626a0a33362030206f626a0a3c3c2f547970652f466f6e7444657363726970746f722f466f6e744e616d652f444c5844484a2b434d545431302f466f6e7442426f785b2d34202d32323920353337203639345d2f466c61677320340a2f417363656e74203639340a2f436170486569676874203639340a2f44657363656e74202d3232390a2f4974616c6963416e676c6520300a2f5374656d562038300a2f4d697373696e675769647468203532340a2f43686172536574282f6578636c616d2f6e756d6265727369676e2f70657263656e742f71756f746572696768742f706172656e6c6566742f706172656e72696768742f617374657269736b2f706c75732f636f6d6d612f68797068656e2f706572696f642f736c6173682f7a65726f2f6f6e652f74776f2f74687265652f666f75722f666976652f7369782f736576656e2f65696768742f6e696e652f636f6c6f6e2f73656d69636f6c6f6e2f6c6573732f657175616c2f677265617465722f7175657374696f6e2f412f422f432f442f452f462f482f492f4c2f4d2f4e2f4f2f502f522f532f542f562f582f592f5a2f627261636b65746c6566742f6261636b736c6173682f627261636b657472696768742f756e64657273636f72652f612f622f632f642f652f662f672f682f692f6a2f6b2f6c2f6d2f6e2f6f2f702f712f722f732f742f752f762f772f782f792f7a2f62726163656c6566742f6261722f627261636572696768742f646f746c657373692f6163757465290a2f466f6e7446696c6533203335203020523e3e0a656e646f626a0a33352030206f626a0a3c3c2f537562747970652f5479706531432f46696c7465722f466c6174654465636f64652f4c656e67746820323038203020523e3e73747265616d0a789c9d59075c14d7b79e656176ec0a8e829a19ec891a638f1a1bb604151bd81515457a5b7a59fa02bb67e9bdeed29b12b0172c11cba22659eb3f269aa2184d3526e6dd3597bcdfbbc302bbbef87feffd1eecfe60e6cede7bcf39dff9ce77ee8a2873334a24120d5cbe66ebf28f564d5ee6e0e4347d9a70c7563f52a41f65a67f4b9c8c635ef9bd3a6a513f6a9cc452ffee109434084d1f4c8945a2956b762cf3f30f977ab8b907d9bebdec1ddbe9f3e6bd6f6be7e32af5d8b7d7d7d6616f90bbabcfde2072e16debe8b7cfc335287caaad9db7b7ed46e11381b61b5d035da521aefb0dab2ef3f3f10f0e7295da3af8ed7795fa5214e5b8c62edc77df5687a5117efbb7ad5de6efba7dddf28003eb5748dd5606ba6f0cf270fc28d8d3c93ec42bd47befe6301f97e3910ba6472d9c3151b668e6db8b67bd337bd28e399377be3f65f4aeb9efce9b3a76f7fcf73e9836fe0845bd4b8da1b653eba8e5d43c6a2a3596da41ada75650f3a9f7a871d4066a25f501358d1a4f6da43ea4a653132847ea236a22e544d95333a94dd42a6a16f50eb5995a4dcda626515ba835d456ca815a4abd4f6da3d652cb2819b5937a8bb2a476511c6545319433c55343a93e942dc5527da961543f6a01359cea4f2da4aca9019419b588b2a1065223a8419439b5841a490da6465143289acaa49c485cc84d27eaaac849f499d938b306f11af165f3f1e6eee6f72d965b1ca3c7d285f4ef92f592238c840960eef599d9a7a5eff0be2ffbedeff79ffd4306700322077c31503ea8dfa08841bf0cb61f9c35f8c59010cbfe966b2dbfb25a687579a8cfd07fb1966c31fbd3b045c3f60fab1e3e64f8c6e177adc7599fb031b789b6f97ec4ac112d23578e8c1bd56fd4e65169a33adeb27d2be4ad166e12b78efb92fb8b3fccdfb51d68bbcab6c8f6e9e8b8d117f5e503f5e5a0d5cbb4a22f7448ae13a395fad36c1b5d5803f50d0110c5e33974642078fb544111dfdc293b60bcd2f7a70f66e534f21d1235683cdc2134845b89e592aef9fed022dd0311e83dc548a77fc0c6b7c854dee00b9110ef8a07746aac6510047245ac5c1e07d18c4f3594702fe8d24ab26428b8f1157f58a03974c5580bb750b2542594f22fe8926aa82f48ca8dc9e0e569c110050c5ea60f643fc59f59606b9a2c89c3b4fa435a51c923b17ea99e66ebe9a22a325b2044f2b80f1d25051fef4a28e66be965d823fa803c3cd1db46492795c56b12cba6a244ebaad71eefb5b0814663f0abf4385080d20614d279d1525f27374594125419d950c05485974afd23c203f61edad7ca3d8793c83a3d8fe9b21fb56b9db496dfea90936eb8d51768be7e28db0845fbb8a574a4944c5e0d85fc49dcbedb788566d285c4c40629d9c26eb482b63af9fc6ecbb90b857eeb381cba5fd2f55c8df0dcbba6cf45d1bf6d3dbe80fb089c3dc2c28495e55af48556043a14d821d61f4022b6d617e45c24c4291243e5d1613bed8099b3ece6f7676a91048dd41c86785ee55e26ab04a652535277672c38e325ebf0a899b8ff0fe39125e20ffd52c2f7e2234fef2c4627d0972cb2404116e57451753744c61a1c5c0115fc723c61119a60a1ae80867aa96128800c55136756d0a83f0ec636b8c422d8e8e23f0cd3044210ff146dfe156fb6080a7e7d48582188367875ac0ed56b4517da50559b181dd75bb0316ef1be725f4649c79d9e89f215997195529001e368d891061af94e99c42ba47bc6878630878017af0f5049f2765dc74ee9d1d94105ae19899909f989f9500085d9d9856999dfa2ccfc0b8caa33807ee3876592464db7858eb40b24cbe203bae31ea245ce5acbcf75284ab783845e8f6691744243e86fcb1d3c5dbcec27f1e368b4c98fbd5e7ee23cb43377d63ec4620e87d032c14b5504a1359d32daeaa5bf09309434b2b8da715fb7e3c6fc32de1ee7b3d80a85208efeb67ea9f3f6fdeb67f13d801315ebd0519d58bf09bd62356a551a94308782218cc3cf68cf84044f7e97240c820f358146cd55a35409be815b434295291061e3510e659c7e105d9e096a28622e4bcaa09c24744828e78acb25a6b0aa22f3bb216f62d1d45fb139369ffa361e82ad7e9c82cc90d98f3f214b0eefc5b3593b877bcfbebf71e3d6edebaba64d755862c7774de1a4459f6b9185d692cc93497c1385fe3acbba81ec0877872eae22ee0c0019efaccfa41be4b91eaf67ca0cdaaab5ced3a578cf482c9a3c055be1c14f26fdd976aca6ae96475ee6cb258ece73172d5f77abe3a79b376e5e6f7574e27a418b5cc98ed79318688c29de8dd772a8e4c7e058d9b9f9686e9cc6a6b2dc88d91ebed0d0e86d7cc502af964a7aefa17ec699a46835ddbbd48d36144260b9517f9b8d391895e60fcc87c699aa3a6552e3d59f2653e8fd54345ad39952e05eacac069bfafcb4165e9f5925e97d62b4315baa3afd94c282b15a7d76573c3ebf2ad687e9efb3c550e5c38543525c52a2221914d152cfda5deaad84255912a51178155e8dc85f340c31df753c391808b1f141e0abe013df991fe802ccb4d97fa249e89d477f765cbdb86b7e219f16911a590f8c0015217458aa45ef09c133509a10bb07683e2a61af5cbe70edeee5a5b326af58b562a1fbe3331c9e607e74eff1f8466090e8e71f91151a34e397d13b9cc3bd3d78ab9feb1485aeaf85b5b3f6df11206dc0dca8ab682831f3362abb25d62f408eaca60c9a11bdfa173c0cf79b3c110fc2037f9b8058647dfa49954074e1092961897cf0d64df17eb004969c8dfc8e515d650bef5cb9781348ba4973c631bdd1cad7a18f09340ee88fb3b9459009b9ddc9f2c8902c4b8dc97201e549f0c3cef0b82890439c2159d04b43ed7b6a4c9565b856621a9a1a32bb3bbacca26321b5d8013b84f8e3e3f898c61f39a035e535e818875d70363b13a49a98b331e7e0115c8476f83cef54c19586fc87700f9ae28b9cf277123bd682032c8fdd14eb181032038c065cd3a1529df8aa1eb1dd3e2ce2cb3b65c174ef1572a1d1f0c7c816cd46b366a349d886c792ced3ac5ef6930459b4112266709f0dc487629318dfedda7a05d9ba93de9635d816e1caf9d7b9546f2468321fdf957c3f4c42669f9f6aaed0f0d86bbb49667c6084f5767a2542ecc6edf3e6d9adbaf9e4e94ddd57f74e2eb2e77ab80a0d21a93946f7f32331ca24e51a0d3429c0034fd3f73f837a2e39677f93baa2b8f6ea0710f9c1a25db3b8cd130d7550c884df70fb04636d4195c65a31a1bb56acd1a214ade8960e2988a8998f14020b23e6ce9367cfec9e60098f838c1fafef94f998f88d354ee643eb65e67fd23f1d5fb979f39e9593492e1a260fd6a2dd5a4b32f970dd49dd4e92107ffdac654de6d0f33ddaa8171f2bb15a62d58982d170890b44361d82f232ee59f770a40b8787a3dd48b199ee85dd1d49170f76f631d9276d222ed0001d5af968b8d54924456bd91faefc840670aac092d02a60cad5c535ea986373b7ae0e5fe3c45be90e19a6c26646067a80dbe71baf50a1d1642ceed253e15791dda58b57d1aeab9670394c1032872f6fb83ddcea3f62910c2d6737ed3d7de1d28913e73f39b673f3c6ddbbb7f0d3ddd934454b502b304fefdceea88faf8ba8e535f995e905aa4cff8ac45c604a2af2eb2ac21a36c56e577aece223f3dccb7601f3eef22573f694781685f156988a8d8c0ff61901ee85d29c183b67f8106299d92fd7a2a168e8cbf66f39680e3fbbb5263a6b6ff9746056d009100d09a9424ac614c6162ad5900ae9a985e9b90cea87afb113971c3f519ad3d8a8e6ab8a73e00e301dc80266ef5eb2676277b9f4145ea2bb3a348a04508c16a35a168da2df189851c813a5bd2130438ce13ed829f33401d054239ab7d03de5d392ac1aa3f5d60eb7fa0d9d43d96c507a689a34c337fdc37c38cc543736fcc87d0d853e6901aa88d488866ef2d549ba883d90280c45e26ecd6e082349f841d03cb7f75e463c95f156cf5a13be8ade3ce2c001cf69dc4e70cc93de4f2a4dce0b0046401c3f491209d27a2e078a55f9cdad6e1714b5849767347e7de60fcc6abc32ba3dd15593455d5255ac5f8c4eb1a69212ad95fca31a77cafe07ddfa7f50ad8602b6ad3b06963774c85eb757a726491489a6914a7d9b7e7a62fd8eedce1ba6f1cb68e4e4c57eda5ca685a3cc778b1fe2be1c5e615a0e4951edbd7abd307bd25667efd365500f8d7ee521100c7b6115f8947995f8d4461e02e65ae5a72d8da40ec605818f924f501c88f083531738b806d9f1153175411a595eb79efe5cfbbb5a8486ead00c8213a94056734dc86aee43ba37c3e7cd32f2d3639c424ffedcedcedd07c73b4a41e3eea90c89e0940e1bc97acc22385fd5abda1e3cb744c39faf24d63f43edfa11ac2153c798709b056ec7034cd075c698ab6368abdff40af3dae0723fbfe0603fbff2e0dadaf2f25aaea70e59c20d547cc3f58630792baa616be55f87c22c66cb9ef50b383fd89ebeaf666f4df23165a9b24459ead58d1a6c6d804d396416e6341ef1d1465e27b0616e3feeb8ee762ca6807739e29fb5b094b1fa6d7ee9de7cd726386d73aef5cc2d0ef585a27733bdd382f3e4ea6ef422eb1ef8264524f8b8346dca7726f0152f5930e7a353f65f07f2e9ca9f830a534c85b38880c19dc0d09ec0c0b427eb6722a4b0337647ceaf8ffe9f101182dc718889087b6d94ee91a8edbd6d5b18faab91557969a0141853858a1ebe41a17a908e6dfafc18af0570b0914315ffcc1a9c434fd605dee18ec2d1dce65aa6b76525f1878e6e04bcd49bf7226006dd8b2534acf35d1a22c035c0dddfd59b74cebe10931a954a147e2a6431b541252141c111be8b7f81a368fcc7a8ff75ce4aaffffd8da030280752e16d74c89ac0f9acd09c58bf81db46be4105d974cab698147bbbff4672dd7afb9d9e69299392d2620267aa53862993eb1693e72861a2e4f3e81ed9a4deff7f69e5b108dfc32274cfa2f6cddd7b3d8d24f859be871a34605306159077b0b73947fdb4a20e22d68f1022468390c4a2c96417534d4e3c683c074fb1402f0d7e59655cbfb553b6dd044b2694bffd01fdd55d5285de339c5f7445b0af717aef2e1b35c84e87c48299b162fd2ec14ca1a10c847022d2e8f0c0ae76ba8c6fa5b7e173164a3ab93afa54ccd1f06b2979ee10478a406c704ae23ecc258792ce770b3a67d16a383c0982b0de8f6ba09ebf8a3bd283d2a28e80cd1148cb29d5563d5615a695332a3a634b33ee939e901f510af9d00c69c5e9e5466189167585f0b3d781d845f6c348ec5893eb87269e1fd69b42d3b5cf85266f4f077220a00ed19b35b2e5de67942dc0d476f7587be332d21278e42db9b5e91b3c6ecf7858eaa389ace48aa03647d50cd92a953ab550550039c0fcebbcf772deea345e9182076d9b3c62e5b5552fb86668cf3addc0c412d9f3be84a443c8fe70b708674800c6c1e5d0e1d6ef9ad1f874815f1334c29110e8a3484f4c10f9b1a62b83a3f8f106f469a0895f84af446f0e5b9cb847380e6a4a2e896f9ea4b7b16efac7931f1332eb2cc9752d863ab0a98132c869eec51259c14340929445a45db438627276d6a7a7d3ace1ed262cfecda2baa7c7c45daace501c8fd0a82f7e1b0fc6b32df619efa23e3de70ddefc776850071e64e1d7733242c67ad7d867aa092fb5a17ec24b68d044faf1aca23e14c281f1329a81db256e21dd4b3c36803204dc78f4a1c4aab5e3e8e9a3158511ab382c9384f594ee7baf3df4bf3e92245103a267703ee012edb73fea905fa92778818f2c30d8504e9d3408751d027cdb7308305f6fcda2556f9019997428841039a6aee2ac5af71e256de5c87f7495789bf91dc93fda50b2923e40f34c2d02e42ed60fd2b7b09579e90590c7a8a38a423905d18cb149d8669db54c1e9b04e14c42965735970519a99969c226e76ad159e125428bbb12a184852a3892965ddaf238b509984c756625417cf80a2c8a9e19c12be5b00dfc98e912708328b748b7a86d4a52e2e5a1f2409f4a652e5fad44a294d44d0c9e2f011f703eef7b2ce862e2196048be36d44955f13c1e95061f430383664ba02ae5a853fdb1aaa283aa2a61236d1afd6e62837e9a708211c9e665156443195311961fc9c5438a52168f1fe27dd6f1f2e8044209d1d9b1b989e83bec6a5d189fa62499535c965f5146ee66f1f808b2b730a4f740ed0b2266de22765def39350803794c528ceb9c2db1618a4865888218232d4d2ae2cae068e68916a673fe3489b1a0a61b137e9a00bcb99a5741648b37899f5e8d64f3a1c9dd1ddc63b8bf174b62c0bda9099af28560a02d371fde24863889f50ee8399b7f109a9a0e90528a7fa56507c0ddfd20e4f3e8259ec2163693114f88e1f15f748c271969264830ec9cf472a44e16e9c49f5d66e313e44920638403330e3d35745ad5dd8a3dcc8fc3f1f495733fdd3b7ee45adba9ebf01583fa4fb88707e2be0be6cd39501b5ba2a928a9e5203fa9203eabe8d4e9868bc03cfc62d7cc15db37d83b096ba18b1ab4feb9e8b9568c7ed0cbd92f0e34bb78860704faab83ea0590a852814987787958cab205bbf884a4b8248864c24b6485957fea9025f706fc5c61a1164e6ea9db51bd26dd1d980882f080b26492e104896ee0c96012f97d455ec7831cbd143b2199c12b25a4c2bbe1f18a2e18112b4b1efda87e50c4ab32e12cd4324f240430451f177f5c74465569c0637da02a8e0f5461b35445db7f43ce4654cde6640ac8818284bcb82cfc1d72b596e5a4a8e281890c8b090a237713797404db63f28e4d14c064135416534cfa863455610ed3a52551ea55e15c133ad675207fdd3e92b83febc5e811dbf671ed25f884b9bbf4332cc1fd57ec58e95925531b1c5c28cf4d496b68b825b0f8e767dd9c7da2dcfd8379af00a9c24db131390ac097b1fa5d289edc29fad7731f6d58ebb866dabe4579a703f88c8cac4c503395616a69507094d78c9f3790123dfcdba7cf38b8b5f38a7dbdb0a5799a5781c442412b6e62a128313d3c1f0ffe6617b201640ecf5b108f467c5f9c97950e454c76923ac017efc1d6388703dcefd4f4a66d1796de7324aeabce506777c1ebf9371af48760dea9e7d3bffa9358f71f84cfe52c9c2ebef4ec5c5d71731d9c679aa58fb0031ebdddded1ab324ad303a2dca4ccaadad35987817971d8cb3b2038262c8ec7e33f8019b08fd90fd147ea73330f71567fe5e2a5ec9b0519a2b4fa3e24274fb6895b500a1b1f0d0a08653c73121b38948129071335fb9131f91c1075df78b550388e4accf6e0fc68a2b595d1a1a449ec645824452f2cf00b49afbbd01602c897880012f5dbf5c4fdece63b4bda028191ca4313a2f21233527834178b8af06cd2294d3c80793c725a545c421244310999a15575680fb2463986de023568d16cc1619b754829a001d5eb6d5877d89de812cca08d28d1787c89cb69cfc4782f1e9749c221a8912b85f48cecdc9ac6a3a59781b17af9f0e4d2551f2c5ff7bedfeaec8b7e24f4d95924f47541c521513ef1fbe77eb30299a321bf3e41e2df16fd42ba3fb2f8138d7e043165ee55b17e999e62f3b30ab2082ba643dd3e0e0f5e965aadfa14ea6c72e0a0a72778c673e0abb24f0dc0d4358279052402131a1d1e1596272f209817adc7d4fa98c4683984da2483ef110e0dbead0850da83af4d3c781e3c08070960ea949f2aaab51e07d437f7d644a6423630ea82d2a292981c858a97967c7830a0d050335e8dd576c171ddab01acd1767b83ed7faf967867c61de290bd89609af26aaca11546cded681e71e69748d6b1a5eb4b83c1e87bb6108dfee1e1633804c5b11949e4474e2a556069687595baa4bed5ed93497804f91d809d39ab97380e992ffd15897ef906f547f4cc0e6cc66d812d11ce2e0cb2c547d955b0bf3554abc854669277bab52a4799a528812c9bf6ab67fff5e0c24776b3ed372e133cfb408316de448b88733708848e2a593486ce2724dee42e50f2183496ee65783c168f91c4907fdd9b04f21e83c7d2a68cdf5d17f453c468e8abf7d8a4dc849260e2fba888f084f4b834398fbef9fbc38cb8ec8872b0511795946627e7a6640a9918abd1370b7ebc443c398068366c87d778607fc0668c0c3c9b4a4af2eab80cd48cde454bb557d4a5a9a950c808dee4f0d7b4bc385cd0801e101cc6efed6e5ccabab20cf31ad4170d11bdb82e464d696c94c3cec898e4b894f0249269514511258d2f3e4166dafd8777ef0bf2f172ad931ee432214b9595ca7473837e34b1e5b918ddd0b7b3175cd2e3e35d923773e09181df4b7556b9c0fe541755403514105a4ecb4e3d92fa89ea86ea13d5f9f48b7081e9cc7f632366c08b70e4822ebe1addadb4ed4dfa89297f8fc5534caeed0d55ae9b8cb56897a0b09d84a35aa7aef42b429dec5287936de7dbce7c79ffd28e2d1b1d762fe5bff466bfaa39d90a97988773eee37eb8fffb0be673b0f1d4b62f0308f72e0959bd7ec98849cf66a221c8f2e9e39f39b8b7ea8a9d8659801bd9b9f66d3aede56bdf3fbdb466ed4a7bc7b95d85b1f2a6a1a4cc23c830c2e216dd0b03c3eee6b5a36661775b3a50f47da1508c2325280e0f5ef8f6648807375548717a464626943095e1ea006968848f57e972349470cb20b291ed04ce488ec5ba29583c612ec137fd780632e3cec3f9929347193c2e9d9dbff9b3bb8f6eb5dd3e5e1b145acc577be66f257a4ea154401224a547423ce3b469e3dc2e6e2511276f31badfce36fb547bb94abdbd0fd40734b6543534748d6bd0989b68c24d344640ea76b1de0cbdcffecb08787bba144db03863bce14a1722494673606e14d87843b2af32260a0fb01ef7c6bb8b8c5ef98c0ec7132cb61b6f1ca623f120480625135e18a1e11a20ad2e35bf180db4fefd4d030c1e46d8e0f7ae49c6098431a5270c53fe6d1488d9c8bed77cbdf93fedc757ccdfe41363deea9d5f0d62b38a5500d94c69544928170c8951f268fcf5df2bad13239500094c7851849a2b87aca2cc02c698655d0babffedc2eb3bcdd9e84dae615109f2145922d14e420296fff40932ffd4a7d1d52dc0cfc3afc4bdb5f7044b38ac384cc8c057f82665ed78341c9b61f3895d5f69ad7d8187233364fe1c8d40a42171c7d9ecc25564076fa309ba5fefdeb9f90e9e88df5e85fb2e143c32b71d8d694729ed686cbb08dadadbfe246f52405e0d61d373533320cb606320248625c5e0eabf575827c729922091092b8e2ce32a21ab343d8f41dffec1de3d7065dbb603ebedec9ad79f3ddb7ce52e376b391b135673e244594d7e7e99ffeedd61fe241a9b88b8bebfbf6dc776d70d4b161e763cd3da72f99ee1c9da13474beb0b0a4a7d5c7687f9c518bfbb45730815fc3fceff06c6e6e9511e76cca171789644db57d78feb6b1eeed7bf8fb67f7f5dff0114f55f2feed1300a656e6473747265616d0a656e646f626a0a3230382030206f626a0a363730350a656e646f626a0a32392030206f626a0a3c3c2f547970652f466f6e7444657363726970746f722f466f6e744e616d652f51495344484a2b434d425831327e31642f466f6e7442426f785b2d3533202d32353020393133203735305d2f466c61677320340a2f417363656e74203735300a2f436170486569676874203735300a2f44657363656e74202d3235300a2f4974616c6963416e676c6520300a2f5374656d56203133360a2f4d697373696e675769647468203536320a2f43686172536574282f706572696f642f736c6173682f6f6e652f74776f2f74687265652f666f75722f636f6c6f6e2f412f432f452f492f502f532f612f622f632f642f652f672f682f692f6a2f6c2f6d2f6e2f6f2f702f712f722f732f742f752f762f782f6163757465290a2f466f6e7446696c6533203238203020523e3e0a656e646f626a0a32382030206f626a0a3c3c2f537562747970652f5479706531432f46696c7465722f466c6174654465636f64652f4c656e67746820323039203020523e3e73747265616d0a789c9d5769545457b6be4541dd2be21093ab10f55e701e03281d878e238a82a2201188385415202093320928a30552b5299041404028069149094395033610ed90174d47a3c6eed7add16562ec4e88a693e8bef461bdbc5338242bc95addabd759f5a3aa769d7df7b7bfefdbbb648ca5052393c95ef176f759b3de63aeabe76a7fe705a9ce41e60f1da489326992853459ee4bf22759c60e665a754e1a533c0e6b5ec16d63f0776319b94ce6b631c0357a6f524c5848689cfd2cd7d9f6ce4b962cb25f15191c1316a88ab2f754c5850647aae2e89b087b9fe8c0b0e0b8a437ec574544d86f31ff22d67e4b706c704c4270d0b3ccaed1917be3e38263ec3da3838263a2188699ba2a2a303ac8756ff03eafb53121b1a171613ef17bdc13225489916a93f382852e6f2c75649829cc66660de3c5ac65a631de8c1bb385716666303ecc7ae66dc69dd9ca78302e8c2fb38199c3f8319ecc6ae61d6613e3caa430e3985799d7189e19c34c64c632d328168c2593c63c9479ca9a2d265a54c9c7c893e59f5bbe65596af983559f224c71937d9d0de6c67221dcb511af8c8819d1603dd3fac248ff91ef8dfca7cd629bb6511ea32a47f58e22a37f2f8d1cfda3dc5b6b0f267432491ed53269e7e0125e735c7b241662409bad4922b9434f6d3507401b9d13937318e2814b522a4ee83f804668809b50abe54c6c3c044374495e31e8f5f97d38de160d8acbc4c96abe52d1a21f807668817f423d0d9cc792fbd2011e39d265455214a307adc02459b7caaea10c77a24c2e9dc47efe2bf5056221b8826768d84a4e87160ab2ec909592fdb0108244f2899b92add5df8093f43c4bee86612c327febbbf2ae217685401a7e1dc08e9672b2daa4096d32401b5c87d672291447f0a5e990211c009d2e3b4d93b877bd2370c40170ded9fe5c9c80130afbb5d93a9d4eab137372520f420ca73a955c6f682f3b7f87b0055b89db5ac211964cfaca1167a273337285c2e81f2d16a43334d1ebadc3894ad1462e3560348f131d1f1167b2c8652a194f263c9c8fceb8e8fe231c27103df1e6c978c01177cec31faadac49aceb3c74df04768db5b195d1d027e10c02d069a8817285459adf466dcda337c7901450b1f0faee65f00b3938dafdad5e8468b98326321b127531fbd897617cf57b576887e2cba155899584f0d748892c412d9d0035eb5c93f3584468f057cf54f347b4dbbd87ca9bfa016bae04c52eb2e8ed2625e3a936642bf6af430a0da44d33a48b946f960c6a00b5f0b79f1c24a579feef575abc08e1c226f90e9643751e36c321bb5e8862c8e46ebcaacdc83191990ae1333c93cc2fb3983072c3cee7339b43dfc22a000df94df3c7fe9caadc747bbe116e028551359a3cf2c8652e06a415f27d29a89af09a7b79a5b67a6480145144f93b9bc1bbeada88f3f13f3017038f9e96738038537be2013bdfcf787078abd2c59f592304345bfe4839bd4c5bfdbdd57d101dc47fd5ec4964c77f5dfa054d69c8f106907659bfab2dad0a711973f6b62e643b9e48ffbf8da02a86fd2dcda715e54197dcabc29704e6f4e27e388fd774e3817e79e7d52597e10b20ee87252b3c47d1eee09013462ba0e275e121b2df55db91d86b6aa96d33526780ac5c426f71d0aaf85771ff353792f7a2a554abefc6e85efe2d09e6d2dee145a61eaefc81432f5f19b68dbde5374a19776fa37183e156b79d55b5ea97b80dbb0b91f27e28c3f9fefffdfb34b77d09ae48ce61a9577793bf699644ff0553c8f0e726cc4f7795caec0dffffdde77c8ccbb47968843f3944f86061c948a46fd5368a3e72934d2db1d587c5d1ae0d11196ac738745c4512422f6296805f723d2e9c546135674d38b6d71096587aff949140964f6ee6564b5192634f62bbe3eaa5e211ab149a55899a19a2b7861053a29703eb47a94139e332aa230c36ae8079afda18372d08a5e2dbb92b2f7b9357cff1d72720cc278beb51017e20821255d930c499cba35b9bebeb5b2abc7ef6480f01684b9a5a8a85bc81564f12fdde21605aa116e431d2dc6857d2653b2a305173cbcd582a9a7647007639f14dc91e378f4e0bbf75d82724a2be1e25f3ee9896a4b3b2a3656d4e557ea73b2a9f9a57209c7124f9c385665a84b6a51094a50272424a9eb828afd69a5c2dbcbd7461c551bc3c4e4c4a450080165ed6ec381d82ccf38d8c2797db41e37e2d2bbefdd12e073efc698d280ba0db0905aec2ec8ce5516a6b5431514e59697947138b28077816be7cec1b5fbf7c16dc70e7073112f9100fee627a97ea1a1de94b1b62197daaf5c8672da5c59771f438dc1be490657f1c055b9344a5ac15741e141210bb47030f3704eba263b27ba627701157b24990364fc141c1bdf9c2d3664b766e5436766670ca8b8e54e9020f8c3c68ae881ac6a5d6e32700990132712964d044db950087aa8ae3851657b36f43d380edc457ca514edbaf7b5ee3f2eaa4f85156c3dbaa164730974731f7d010601e550b0561f939b5a6496b201f26ac5174e6fb6afdf30fb19b06d4d4a246ddf378a9f6bf7fdffcaec7f9419876d9835e18a6ad96d9a6d94518e21d2741ea799c834f4512974b30266cdcae1f6dc26cdacc39db81b9f9eb9f4a9d0a7f263dd23a32236c3c7b5d4cc658bd319ca6ea9e75b9c465928c7d84139dfb5a739481d11161cdc1cd6d5d1dadc259035c49d7a70ffcfe8768dcec5937065986e9ed25c96d69e661a643b65f0006f3e9063a1b4919f559373038e713dadfd03c200dcdf6e2013f2124057f51c2ef462877ba8811c5d6686729b6d8ce19d8e39946353573813d9fab6edc752c45ebf9359dfc73d8e2fd5d62494a53646833fa74c788b580a0b81884d877086ee38e4ed7fd148af178dcccd3d5a5c52525c565ffffe8e3ba9660375fad39327fff07c4064f5e2b329c3fdd4237c226d7a3962fcd9153b372d5b79b8fea2805fb3c4ed279d65b0333f8e7a2ad4c1a760bacde52e55e0aa9f068ea5b9257ed4ecb6b74a9787d104b4fe82025a4201ed0c6f090c0c0f0f0c6c09efec6c69e914c8fa61402ba106cab535547290c00dcd6277a62ddf2424426a7ea6fe485e750534716dfb6af784c5c4867a7f1879e3eedf7bbf13a443e644b574a299a401930c2dd1568e270727f0686952846867828a9e9910a2e794683934402c956c9bfe3118e9790c6db459c4fca4665bce3648bc49261d9246f385e5f9459781ae38215a2da8612f15d5167a01db5093add1812e3b432423c851c2e329ab8b26459c762d0d89026fd847832eb3b866685c71a23ebb16ec2aa0485f5ccdbde09534d0334caac8410ffed794bf4e29d400d75f32da62ca3daa725437a08b792cc9516dd68f127bf987ab3f240e3ec43a7b91aa25a9a1a9d1d02e4095e67872496b711db514ee6a57f0123190250bc8c25d44ee84dcfe6b7fb9603c532dee06e5b7428fc2500435864c481137e64205d4724476899fbf28297c9bbaf59c005f22d3fccd91e7c38a8ae15f14d60708748143bb92b2e2a2cfc0cec4fa5064c268d14a8836235365c8d6d0bd51ab155d66cfc2515646332ceb282c91b07538e23a8b4e640b5d8566a6a568348bc14ec97ea0d74333f568239c34af938909470a7321b7b0487c8c56282713ad544a459dfe632aab26e81b8e594b5191370d23f97c7fdcf5ec251fbc476de561502f55c20cd8beee40f8817bebca37c05cf0f34c08f84ff749d9eddecbefd6c42ffb4d8bf9b701eccfb7b56bdf6389796f09fa45a7bf35b29555955515d53dbe17d33bcd13e7c95d9c8e93e73f2093bdb62786abc52301fce9eedee346fadd5820afbaef842db1bbc58880ed19e1b00e7677a7d470cf86995464c079d594187be492a3f4902f2bac2d8346ae29ba2952888394e42c0db122936c1bf6583d8ba7a0e599ce54cbe8ea6a25c747832cdfa8857061d5062237eff789ca2ac569e82be82ce3866a88a8648dfa1fe03c3d4fc06896c9e4e73394ca18afa05d8f7935b4432f7c4d2ee9319c4eff9c048dd7c18c439a6570907a96a3a2bde5cb3f9797a0fcb3ab3df03587d6f6d7e910b39ab3619eafe9606d739b8132cd186188c8ef3cd7976f00eee19995aecb7c5dd54a914492fd199954734976c9d2e2e769d33a3b50c071a7efe26bc63659335aa0a779a1398677a9d2616ac04e70204c827bdea900d1545cde4cada22baa51ad8a8a52393ede8a6370c95fbf7c2cc08598af8863c3e70dfff321fc95bbe57a9988c47289d7d2773a0e9c683c5d459fa836e3d4f64263d7552800ee0b708b8c3cbc83f6645fd83e6db0364db75f77589b95031a38cc251740b5f00258540cff8bc2736681ae45677ec034475aa5a8d7e5c70849b490b483646068b3ad12df250a2253b28dfa4774d13a058fa081423b87eee652344fae13609f3bc5b05d4e9363e28de1e113b42742ad6e8de8181e3e2f43d0e96598c4fd3a8ef459fec66f87d7a03cc3bf7c28732477b99439f8367fa414f241cf1d4f399a4addf6705a56ca90cdffb9d866a7c161d07249c732ca842ac82f2928e746a7950eae2e2585c5b8ab5a417614b2266b948d14ac2d1755db8c38556c6383b25a9b51b936a319e6ff0162cc903e0a656e6473747265616d0a656e646f626a0a3230392030206f626a0a333237390a656e646f626a0a32362030206f626a0a3c3c2f547970652f466f6e7444657363726970746f722f466f6e744e616d652f49424d44484a2b434d544931302f466f6e7442426f785b2d3335202d32353020383532203735305d2f466c61677320340a2f417363656e74203735300a2f436170486569676874203735300a2f44657363656e74202d3235300a2f4974616c6963416e676c6520300a2f5374656d56203132370a2f4d697373696e675769647468203531310a2f43686172536574282f706c75732f706572696f642f736c6173682f7a65726f2f6f6e652f74776f2f74687265652f7175657374696f6e646f776e2f7175657374696f6e2f412f432f442f452f462f492f4c2f4e2f502f512f522f532f542f552f612f622f632f642f652f662f672f682f692f6a2f6c2f6d2f6e2f6f2f702f712f722f732f742f752f762f782f792f7a2f66692f646f746c657373692f6163757465290a2f466f6e7446696c6533203235203020523e3e0a656e646f626a0a32352030206f626a0a3c3c2f537562747970652f5479706531432f46696c7465722f466c6174654465636f64652f4c656e67746820323130203020523e3e73747265616d0a789cbd5977745347babf42202e2524400432b0f712428084c0521208c912420c814088e960aa7b2fb2dc2dab777d92acee2a5bc272933b362ef412d3374020b0b440c8a690dd7dfb366547cef5dbbc910d0969e7246ff7bca3e33f5c743533dfaf8e59c4e041048bc51af5e6eb6b96ad5c353378cdc637e7ce09fc648a7f22cb3f6990ff776c6621639a3438ef9b9d437c93e8bd63d0f9d128f67134ff0982cd62bdf1d6f6e0547eae203e362e63f28ce06727cf5db468e1e4a5c9d182f8c8f094c96bc233e2a293c333f037499337a446c64767e4ce9ebc342969f2fac03bd227af8f4e8f166445470d7c6e706a323f33235a30794d6a54b420852088796f2dcd4d89cc4b8d7a3b981fbd2c2d66ed7241ecba37d2e3d667c46fc84cd8f866d6a6a4f09ce4888eb9f3e62f99d93cfbd5dfcf69238859c414621b11422c23b6136b89e5c4ef89a9c43ae20de219623db182984b4c2336102b8979c4746223f126319fd844ac225e203613ab891789e7882dc402620df13a114abc4d041322620c31967892984c8c249289c70921f104319ab010f3f1b11143093b6b3eebf341956c0efbf8e00983af0e31721ee79c1c3a7ba89b0c26ef0ce30f0f1d7e6b8468e4ab8f3df69861d49ac7e73c5ef7c4cad14f8fbe3c2672ecccb1ee27273e799cfb2af7bd71f6f105bc29bc08de8741d513de9ef0d1c49593664e5a33e9a3df3dfdbb02ea896f59d127e78cfa7650fac2b5e0eb65f958e03fc9f68ff37fc9b537591cb7807470ca9c505e2805cdae1d5ad8494740b8291248951872243628f755439e16741a11cd4cec6b53c4ab142b204828c5bfb44329ed7f8de30183c152760d25f2c050e004035928012d2501bd569993382f8c21993940becc490293d56272182c345ecca79bf062d0369f7f65050b7a1f63a38d6808376c4998264e27d5ebf3404f6a0d7227e5855a5315f8a05e5b07a4b908ca9d0a5018689521d6887f6a3717dacbf6ecf3eeabdc47a21c8e9379794876ba244c2ac16b2b0413d5026da6566882666d2390964270152940b8456babd2d161bd1cbd476f12e29d8046a99292490c9bbb87b9398489e68cfa96f5b19160c24b8edeecf6f8a756483d634aefa69c2e39317eecd7a8b78a1bcd2c5aba3b14c8eda256b3c160b01a689fb9b01a4a49b7d0992b89526dd8d21e7f9cfa123ef9c2fb5f7ff3533c83c5680613e954946453c9a04cd1295e67f6f3c6fe25451919b276e22e7967c3e9868fbd17689bdb5c0ce5e4a1045fd8ec3866864ae600335504066341b1cd57fd790f904ea7362d5dc61745d169cbd396c216f2859e94635437f82a8b8a487caaf3165e947afcb33c2c74f484eb341be5a160aed963719b3d4587c150565b5cd975f51a909dc65d596b7633234491b4385e2b872c72774dec81cf1ad1b3668702949418f0b8f3157cfeb3eb80ccd297147b1d55b64abae2683b1a0c3de4ed8d9e6dd422d81e22ce511e8caf0b8358c8ce1026e7448ad7828e7cb86a83d9e3ba547ed0076415a44885da1c8d907e8d39aa53e9d5a00d92daf22ba84228b35acbc951fe30a907b5dee8f2b0e0120abfcbf6aff03fc60d5541047e9cd029dc535de9693d18d6b29a7982e132539869334ebef9117af283bf9798154e05a501bd5e215b3a6b9e260fc84d82ae9ea3d55f551da09bcf1f6aea022774e94a22f0d9b08aeef1a5e79c1e54e8719ec31498c646bd681ff764cf816b6027f1b65501c4ea559284f562b5107241e6c8a99294e6ed49047269d8ac6cb955672b34180bcdb4cd53eb6d810a70293cb2867c2794407e9e5c2a14322f310b791b366e5f0a325266070be50c8cce5aecaeee6a050fd8a42e416976490e3e90bf1e43e32a1d982412bd56aca17343b7c787413608add9f6e422494136a841016abdd5e6f6d6d404d6feed24fec05cf1f9145e62fb2dc8c7fd7cedc5171e1ec8d4b36b3e404f202e9a82a6538c85a9e046c5f82e1faa42ecfa6374cbe903757b813c58b37b6d58e6d4c4103a65e3d65ddbe0d1e7a2987d2cb8c0f61feb9dcb35988c363092769549416941a6d7ea67287812bd540f39a4d401c5078c4a19055aad18f4eb18312fdfc7af0e07926133c399e799690bba975f6dee741f6ca39ddb5ab29aa005dcde129fabb5b0073fb31f5cfda79c29da90f3563c9069505d6c85124b25bdb692ab487afb958d40ee509cac3be443c35cfb68efe9ee43ed60833d7a57aa43e848811cd0ea353a15f95041fae5acd7c7eecdf0dfe2969e3b61aa3590a64243994d639627256821914e84785312906a2c6652bbde4e1fd1d9b2210be43aa54ec10cea5bcd6342fc65aa52bd210b8298d19c7e5dc3a2673d060a3de8b4329ae1f5558b36c68877ea8214527daedca2b5d6359ac047d74393d637a02b854a83845e6fd455613098c052508ab8fe421e4aecbb6fce37e88a21c8090506737960d9e70c47337dbdb3f0b2efb17b0ff72ee61a0a0c1628208d7a9b8cd2e1c9cba56f2de5855d5c578a1586896012994c46c2bcf4cfa988425b100b251c70c840ad5282424b6f651633a357bf04e4c2f927d094335e34f7261a445ff8f4d3ee3f01f975f3cc17d2d489a0a5fb19e90493a1a0ecc1d099cd3ef47c3fa0fc4bdf657fcc3c89cf5ea18dd293722c9d4ab3da5a5d6b821abcc3c6fe1d62dd2d9481682b581c166b554129dd8ca659f3bc11472008af68049a819efd67c8c1906d61b1f129b4a46757a1e0d748820a84ca54fa6406d7d678e6c67120bb1ceb13c3f9cc8894d5b44410b67c2b90eb64776da6001ee90189e07bd02b98031791ba958d1448c8ad83774d07ca6fd4c379b092dd317b574f619e9ec62c9f7b60c1e7bfa00faba4efed6d757459ab698b87db815efac2e400b26d0f3ffe29661124d0a37a3503a0ea1df6011bbd76853b6077e47776874e71d03ab401c5a34cf4f4cbff60b83473fe3bd07cef9437c6d99bac86064c75cead1bbb98f16b53989005d3e96deb9785bf02e4d447bdd01ff6fd34021c94fb5ffc8e830aa39692426c9c3055529bd6b4fd87346b6fa9aaaea1b3171b20fb0fd230bd66b59e14e38504005adf648206ba011b5ffd0fc767359af167ea50c16f231b6b9ecfcd847bca6ffa737c68d675375ee91d74e60e1bd5f9a7726f73ca1cfdd69a472fe614bf6f72955cb2b5388f36e347b97545c264b5281db2c94c97acd4ebad68ea88d813413d0b02669c323e8b19c47b33707ad958584ae8339cd7fb8649d6c8225459418a78f1965890418e495a52672eae840ad293eb100a04d971bb3ab25ab0bbb6a3186b738051d5fd51a2b50a9df5b1fcd73e62a377d1452efa3d078d4113ff8186dd59718e61d1ccd19f99d28ff30ce6486bbb09f6d26dd0aec592690d44062564af039bbd00b00dd328c8dfc5b5375b018ff643cea5c369abb3f39f8dde4dc74585e684e0f18ce17cb7a0533ed4d088c56909bb770992700d46931d472367201a493122e519eb182a6e15331fbf6bd42378b8886a86dce35cb00af94a7dbe2285069d4e055a52e2e8371493b1c0751cf1790f0082839626e0d65a5556ceb29ccc970331eb34d2db1a02d80b42a33988f0262fe3ebc4da745aafd6cb030fc2524415e3a06674ed41cb79a62a155643b22f969327835cb1152a7a4021d78352934f3313fa1a7e12f7d2391598c8d692002aaaeaf85237ba78a304078eab180d4ed48ea1db85b81f82196aa0421427d526829a14db73aa5cbee2bd47563913a83720365498293d1a559ef07f0e0e7560ad35da02c101a3b2f04ff73dfe511e9d670cdce15f183ff62bf4c9516ed64249a82a2b353e28724724e483189280efacb015baa18c2c9297a7e52689a2225b72ef505fc1b53f965f432cff2a5e410918b112bbf3cc32ec52190a4d0a39f6f35a11bf266c22339819cacc609e5ab07fc5d5c31ded8585f47954ccddc5ac5224bebd7823046dd25d731ea843c3dcfb69efb1ce2e8c9d53f6858a40d0fd1766cee6fbd7bde8718fbfd6cb82bb7ff6a0be3b6cbfdec2458b2ea3c75008a015247ae999bf3263987026929131f9ccccfb93d124aa099a6c6eab628b2e0544e446774c0f22dbd106a3556d56510ad0a974ca8ce5a1a931100fe925ba4f4826d8ce5dd690711b2ec3392f9a79150d3dfdd9dde3ef03f9e9c9979911f3773306e6c567685dbdeafd60203786afdf2e34298d6a1a4d7372d32589529c73a4c9d0d65cbfbff318ec4c538044dfbf0143cf458ce6fd3ed41d40f37c36ba88ae733fe09cb7e7f3f334423c1b9d52af7908ac80cb98cbfb118a0d0fcc0378c75141abcecd5d261460af5acc39870a1f227418e79f9ea437d2b539da0c5a2f1cf20be0dcfe2bc0893fb96d9f09dae86ed8afed02d25e88554f0e425ac6791d6c4501fa96d00f62a0e79d9b68f685431ed6f51368cc3b812e34949ba851f07170935af22acbaa0a3bba23f6bec90c8b98b9858257cf8b6a549db22e196c2213f9af4ca532619d5978f8b019f6610a968b8bb23252f376bddd13fb1e7aae158deaa6e0de6257843dd5126b830eb2d27de126550d2d3267d48f131772f487f413bf2d743133faeef1f43a4c661d29b5e797536e282a33390b4aead1386bcd40dab7371b8caefa8afa8eb397fe33697f25c4c5252507d4f63a3f2cd3830171d4838ef8c6f85f46acc68fc78fcdc067d8c7b5d6d98c56fcaa877220cffd0d66a934b3376da293534233b0874ee3a010118ea8cd17eec115f2c6928bcc688a29fb95b2dc6682567aef2fc9f279543a04119cb15dfb8e0883455ab968032ddda111e1c35b7a3af1ec9dbaaf6d569d451cc0a15a2bc9db909c881361b2b6babeca5469aaa24d7bcc9de0861371fbb6ba02337a6be1513ca3201f0aae60d59c62a3226c7277073a720050af705ad08c8262ac15e6a07ead10802c4b931fc5cce72de0e43d14ca9b9c60a64dafd108411414da1079e4bf0f3f3c6f09805e919bbb3df2b5f540f2c15b6a85526b0d3de0b203e008ba35a6ebc4fee3e1b7c78ff5a33be869eea3834ae1cfc48352880cd555450d452db4e71d377e39b020e2f2783cda1b332b9e7956fd4879b437547dd65f1ed519e9d214650e2d4d92a62832c40912fc12456bb0ff9251951147ee37a0e70aa8b15fa9fd195c6fb64d94c5cf4e1554288a2b6aca6ba9817689a3eb9c1a161a7d01edbec0ee1dfea3f8aa0ef89a74d7065ed4bbcb0cd9d8d81e6758f86be816cfe61e3e6dd17a54259a8322de917c9bb62cd7297266422c3967f1f479afbdd6fc25057bccd52627180d464c04a7bcbf8fe9f07eb730d13c2c315a2c312ab3c64259f19e6c0e676155bda3a865d3b9fc234062a767a309684cadb23dad9e16f824a6e76b72cc4976b531be24af1edac9db7ffaf3ddfb352b965290a6576a32f522de0f33f120de8393675dc6359fed77f827728d16c34f5a7b174f9d0b3ab938273525793790ff7e753f0a8d759575ae4d1daaf25f5795be470a763efb4dbfb31f2c388dc59ddaf1c1f8b17d589d2f633529288562727f72c786199b99e9ca07ab0183a5d47bb6ed0c3e31af313377c0599fef1b2dde1cb5780d04e582c8a63334394df558b71f7a644c4b5627750d6e9e77df25c77e8326f42ee2d6645a2482f4f474b123bbb2d2ebf15203ad067c7ea6053bc408b6ffa01ff56b81cd6033564319905fee11adc1cd42b696d6494187854b3cb022a3c9e4aa432bb059e0c0504006e845f53938d9a00555ee5a66050fd7b6c09f4b03b7390550002693d1683038aaf6a3a76adc880b6423670f68944a9d5ca70a5842a33c4e2e9b8f7563808885603e7cd40487e923704c7bb8df142a9c32c8a7f3394248326a21d5a42e8062dcd9f0a002d49719898777646bd9fef1781fb67a8bfd22906e477f88d644866b21828e80305304904ac9802b35d662e9d289f55a9a99d4d7ae48902b564250961c72a5569d35e04aed743b7468dbb07405b2b802b2d780d569c045b164a0d9049077e574f10934eccf6cbfcc3f92db24f1a56408323228105b951665659a2911eb76ea0ea68019ba497aa881829efa7bd597cda596925f0bbba405d921b0839c732ee524fa4337fa9f2a6aa044634a8fc7fbbdfab31d3a1977e824dca1137eb143cf63fcbc4486fbd49c59406ed9d8f889c75c6ff6d07ff74fb3d5db6c6721c86d0797536954464768218a8e840853d4cf5d2dceec1ba748844c90053123efacb84fa1b180393dae1a0dc26321be35ce917a7ab9fb5870eab7fbe5e83e2d4faf5167433eb9b939e600d50a15d545deb2a6e27398defd3c53038ed86aa58097b73c273cf5d15b891fdcbde07296ed1fc11d90fe81989808ca78bd3aa723b134f1dfbc0309107bad9bab485cf3f2cfd532b2d3bb255ca7576398e3355d088498d2eb28ed66717f153b8403658aff396ea40c6240ff5dde3ebcae3085da0809db643999a7b6d904404edfc48ccf08a00483a4d44c577f78642f46656d794664ba649b3c869646e835d29dc25559af84600ea6435e719dcdee8512b22acb221608b212a2f665745307a0a1b5acae62fd416915905f1c46132a02bb92e8f54235cd7f31342a1cc86c7ee1914a6787ad9176ee2b39636b283e527d7c3fe699174a4578a2ecb93d0f6e2afd3fb9a93c08c64277eda10e9c3bc96ed89acfc7da2ba75731453fbd3a6c432ff07ee15dff46e2b9b3ae6207b51c427727ef565cdc52be0b42605b42fcceffdc5de7c31bb77710ffdddf8ce7197d344faf95454034b970df8a2b68301a869e43d30317305434c467c52792dabe515c4182fb6aa7bda91671686b25184b2a6adb5a1b5b7fee966500e37ea31b3d57c10214cbf6d7f43ec1b55b9c76dc955c4287841281422197335398293c990c0bb29654d8e5560aab26d86d0fde8fe53fd58758152cffae5eeec3fdd854052a4a85c12ec97f75ea72658a561dd8521e8985b9802a818396fd4dccf0be149e2251215b8c33cd806ae312d0d165820eba13bab59d0f44538693978223863c83d890695219b06a5b8c7643c1838fcfbc640d5ceda2bd1ed6ad3a34d2839e7e8f8d9e7f9f7be8c32bed3e179a7def933380b8241abaf8d86266c62266d7aa6c4b58d78d7d6864ab4bde2456a9d52a2a6035069d45522006099912f3d4db1299b9e6fc55b4168d6adfcf7f8902e6991716ce58bb8b1f9e1ebe65f942e9724cb57e041482d16872da6a5ccd75500f35d9debcaa5c5f2626161ada8d5e773e248786164544ad5c09a910651316c4daa2ec4920c52aaad33fdc84e7cb9b68a2ef0c468787f565dd3dcfa5cb1e2c78efa02fb87918c5321b94d1359cf21eddcbb9f2195b42e8d4f89d825d100aa175baf73b34452d98a7a5d2d28cadba90dc150742eee25834e62b34928272cd95254d5f36f57c02d7c8bbab0e2e66464c9bb220ae3ca5a5a5bbe950b9d42719d8bed6a0c307abb78ab152c627a6a664abca5d373eb9ffd79603b9c14219b39659443d98f5d7b73c48700badf28c7123d6e22624691a3ff69fe802164741d6ee78788b4c70c5ec7bb7ebbdcac05d6540ed741ab128322e159b48aed255bad7557cee107dfd6c7bfdc5e3f097a0f7761c7d9d99b59089094b73ab8aaaf6eca92a56b892a9e6bfbf7ffb3626f3dee475cbb646a4a4d363bf6106f7cde456e4ef494e4a48891794e77a1b7df53e6aa065af7723ac071518c27e3fdb1f81f2b8c8c1292e878a8a1cc09d02386790014bb7010a829c0abb84128246a893af624a788c9323ca81ecec7228a69181b38601ad48af074d90c8a174609816149b9c0ffebbd27f0976a5bf1c3c7db3b65f7b3f3b75e42e1bd5e28e80763c92f9fbade6572bff35f44eff7f898c414e25e4518c82636b3316d9da2afe5274168d821adc69bd82dd72887aa0ee9e1a57eb55663808288684a5517ce6a9dc59bc55dfb78f339c37985ed936e936c9b620659a78732cc6763a885d3fba4adbd199d3447d0c9d685a0d7ae6c13d1f7c8d4580c54682b35c8fd09d9a98909c90e6caab6af435d43d183f93e441ab6e2181e7d6d763a0096d42ac9578fedfa0f7d168aed7ddd90867c986dc96f095bb83331ed0030792a2e2b6a69a3a205dd65c6154ae687528bdf8ad88c43736c2cca065fb375f41b3eea0988e80cba46564a4896cb97554ecf4a58b1601b933aaaee7bdc3edb595344eb702ff12ae37c725884f4a4cca2ec9a8f335d4363e5c95c9fdcd86c0f43f63fbbfeeddcec5aa51d0df24ec324a012aad3cbfaff35fc13ca51834fdcd59eea06c6031d94bbe235f2f0f0ff41c3a7f86ed3fe25772dbd4681cc3a582e1951d210c67dbec302618e69149c0d06802f547b8df7e1e3dd3fe592b9a07b748e6489f929b185671fdf65574a0e932dd72f598a711c8f6e6e4d54b9733cd61cfd3993b42b76e01f29196c70a543cf6ff77bd1b85f7b9c4c3543b51ba91c3843b87fa865f18410d1fbcb062e4308f7de44882f85f7512c7770a656e6473747265616d0a656e646f626a0a3231302030206f626a0a363031360a656e646f626a0a37352030206f626a0a3c3c2f547970652f466f6e7444657363726970746f722f466f6e744e616d652f414e4d45484a2b434d5231307e34622f466f6e7442426f785b2d3430202d3235302031303039203735305d2f466c61677320340a2f417363656e74203735300a2f436170486569676874203735300a2f44657363656e74202d3235300a2f4974616c6963416e676c6520300a2f5374656d56203135310a2f4d697373696e675769647468203439390a2f43686172536574282f412f432f442f452f462f472f492f4c2f4d2f4e2f4f2f502f522f6163757465290a2f466f6e7446696c6533203734203020523e3e0a656e646f626a0a37342030206f626a0a3c3c2f537562747970652f5479706531432f46696c7465722f466c6174654465636f64652f4c656e67746820323131203020523e3e73747265616d0a789c7d947d5014f719c7f7eeb8dd4d420891ec888dee5ee21b91602028840e4809681212d0224ef5c6b4e279027ac8797089970839d193bb7bee4e3de1f0053c11f06585bb608c53195fd2fe51f23689759a4e2069ab15934e34e39499f4d9cdef32f6c741693bcd74f6afdd997dbedfe7fbfb7c7f1a2641cb68349ae4a2f2b2e52f96a61797556465362fd938f1ed09e5718d325babccd1917d24f0bdebfb57f591d95ce50cdcf028163f82d9c98c4ea359f1b2b1b8deeab0d556d7341ad28a9f3264e5e5e51a8aeaccb65a53d536435955638db9aeaa91be580cabeb4db5e646c7624391c562a898f8a3c150616e30db5e336f8a0b17d7d759ed8d669ba1ac7e93d9b68d6198a4578acaca8b5796ac5abea2e285972e304c06f324b398798699c76432f3992c6601b390c966d298454c13f3085d85e19857999b9a37b48cf635edc7ba1c5d4f8290b057bf5cff359bc76ebeaf295bb32a49d5838ca6b022ca9af131bcd1ab53463124d858e7fc26f22829013e8f5def09f64bca196e000e7f23f6cb6cb53b1336c22628809a006fe9e13ef73baba5580f57ed712e131b2c4a179ba4b6d0a9eb64e5a5b006d4229df2a4fa8ab0f79027f826bc096ed7de26628a7d93ea586bdab9c6cb5bb813be0bfe28c870d573d6cbcbdc3a5b6f5fc0d7eef34b1771a61e817d8f64f85afd2e689d55b71aaca2858b067e0f8370012e7adff5f0b2835b094d41673f4fba957601f564444fec6cd27d5d9b7c1c645543373ba5f47ca94397fa94d0d2ed8646e04981a5879d34eee6acb07e1e9d1af15df2f7433f5cf244266ccc83a1939212f571e8fa41bbbf797f4b3bcc0a41e0e0be107ad587537db1ebecd4c6ecdb814fe11c7d3e81b7ddbcdcc02df384a292d2c345fda1cfc51e9914b0db01bc7b1ca43e369c1a0f67ca55de291dee549f155a3abcbe1dd4d532cb69f60884bd47bc27dc3e2fece063c7feafbb4e6eff5e9f779f4b793a7637b5ed2d9f3708fc61081e93944bdc49181a1765aec66bf46c812d60f4d7f868d6e3b0de2ac50ab9a4fbdaebcfddb0cb6a86ac8171c57a46a766a8054227049d622bb4c2eeb7d615a56e8eaebd9c4e6dad244b4936d9404c9843b2b01c73bf4509f97608363bc1b5cb2bed26730d7944037c39593b8057f02afe62e07dd48c65920561c9df04eec3c01f85c071891eca03c3c9f63ef5b9de09d55f8deb54337e2de006924e479792174806594236922a5c4c32710596623a66e32f457283dc12d2c94f6ee161ecc0059ffef9af38b784b4912e3227f7193a554b6e39a742bda9a4dcd345d442e147c8d4b2988f22a6e12aac208f63162994c8633f188449c207b97e7f7048bcc77e00d7ec574a2eac6a5b4a1927ba1d2bab8daf5b2b7ebe0078aa743a9049d91eecc30f27c4f0f2b80e5fc76b0216b09888cc97f7be4dbb45e648e4bb69bea6e5d948e0338aed20fc1122ffc6c48d9d029e98941e63311b9e30ae07c2906c695a6c58c6fe81897a1a7b75aa215e4f1b59dcf83cf9193d9b5993fdc4f06dee6e686b8ed48b5d3676a9d3b248ccc23d6c7c2c0a2c66c0c9caa344e27bd97ab4eb63c3d3f68e4fa7f319ed8cd6379c4c158764bc1857acecc5b91377829a2fc42efeef3f74a511cafd79f80aa274a52ddcd3702822a1f72677a7fd5f5e72776d491797e281292f892c2e82ded5478948bd50c11bb3adf66e2af95e375e9567d044bda82f1cbfd33733e50d6cc4ef04ece0e004747407dafda7210cfc6d4c6825f35734fc94a449f79a85bb3d23efc3087f87b07f210b45f2c98fc41e0d5c8fb7f37adce354ec78804bb98c1c7b14de8548ed603558e0452805d379f3f9eadfbace003fd2f9a753072044096fd9e3955c25350e1b1861f795a6bf357f91eaf8c8d85f798ce2a04bfe352d514b186db2325f9e4199ce19db7a7666ca4ee5f687c221fb3ba610f06d70f08884cf73e7f6edff981672b3b7d2530726c8816a7a7d9ee56e079c9ba597b994219240525aea4b893112afd0bafe61f11ff05556982cfccf0ae12eeebf4bbaf5ec9adfa45110ca490e799654d1ee2c21d958f1872ffa7e374019d2d4ceb64e560399311dda95bf0bd1406854ec93d91a773e98e9459e1fbfc8fbb8d1c054706e67beb87de2704729ade76034ceeb762edf4d834b52dc4af0382ea4373b96eb9487d444a12d7830041d7c97a3cb21ee04a7b3d5451249466aa7439f64ef560bbbc9c94edc1662c9c60e4e7ef0da43e28309b9e1c407badb1213af85131f66987f02d2ae8fcc0a656e6473747265616d0a656e646f626a0a3231312030206f626a0a313632310a656e646f626a0a36382030206f626a0a3c3c2f547970652f466f6e7444657363726970746f722f466f6e744e616d652f57594945484a2b434d4d49382f466f6e7442426f785b2d3234202d32313520383336203731345d2f466c61677320340a2f417363656e74203731340a2f436170486569676874203731340a2f44657363656e74202d3231350a2f4974616c6963416e676c6520300a2f5374656d56203132350a2f4d697373696e675769647468203333330a2f43686172536574282f692f6e2f70290a2f466f6e7446696c6533203637203020523e3e0a656e646f626a0a36372030206f626a0a3c3c2f537562747970652f5479706531432f46696c7465722f466c6174654465636f64652f4c656e67746820323132203020523e3e73747265616d0a789c5d915d4853711887cf71967fcd8f8ad64db573108a4a10a20bbf2e4286e594e147993a459bf33867eec3ed38b439e7dcdc5cafce393d3aa7b33975363545302d51cbbeaea24ca9f0aebb40aabb38b305a662105dbc17ef0b3fdee7e18763e161188ee33185c5828cccac04be502848de3f10c13378f06c58f01c4713b2ffdade693d12d8a93ec9a69e60afc6b189c7310e8e5fcf16f195aa46b54c5a4d9317f997c82b29294964ba9c52cb2462052914d3d5945c4cef2db5e44da54446d18d89647a6d2d99bf9fd090f99486526ba9ca839f7ca55c554f536a52a8aca4d40a0cc3380a950cc372b03c2ceb00128bc0dee3b6b0f85d5c58901bbb1b669e69314e0489099cfdb9eed8e4b0a56c32d7ee66e6ecee8135e8f04d4f2f2f2dbe0334ebd596de12878e368888e61a68836694bfa45cf83ecf922ec66437f30c6033b71b3529e24a0a90cec4f87c3d23cc18e19e5b6423e025fa5438cbe7a542a14841995f944f158114d4b4ae56536a2c061b6a755a7b782ee8e8728ef72f7bde3c0634deadae6fb434986a089ba929d7aad709cc75fa3c6b539b1aac881e36b9781e70f73bfbeddd3d8f1c5eb4e771faf37ae8f6349b70e012acdae23c0bc5704d776d260920bd011a5a7b2d0ea6cb0e1f894df0b63b0175b96178400f8612e8ee757a36026c24e1a227a56b80d838f6141bcf9eff91fd362da7a442ae20b41b99603c64a6cb5a8aa0fd5f66d7aae7d53ca03127ad315a353613b1a9e33a86a0d3ed997bb2e09b05b4322c2aabaa27e5b9445d41497929a01bba2d6767675f879d88ddc5652b5f0e1a60b95ff1d7ebd31f38ecea4e3877443748d72934f2fa419d6ffce1688017baf09bc35509c0a6cab034590c700f89e6a4cfbffdd7009d5651b1676c3038fca34e8f6b9260fc8cbfef707a7dfd9330845624334597c521b2f9af43b79d99d87eea0f001a602c4ae37dbd514ec46abd3bd7bca171a6afef68e80e133115b5758c17159ef4203a72a22b3a1ac3fe0079a353880a656e6473747265616d0a656e646f626a0a3231322030206f626a0a3732390a656e646f626a0a36352030206f626a0a3c3c2f547970652f466f6e7444657363726970746f722f466f6e744e616d652f55474645484a2b434d52382f466f6e7442426f785b3238203020383333203731345d2f466c61677320340a2f417363656e74203731340a2f436170486569676874203731340a2f44657363656e7420300a2f4974616c6963416e676c6520300a2f5374656d56203132340a2f4d697373696e675769647468203335340a2f43686172536574282f6f6e652f74776f290a2f466f6e7446696c6533203634203020523e3e0a656e646f626a0a36342030206f626a0a3c3c2f537562747970652f5479706531432f46696c7465722f466c6174654465636f64652f4c656e67746820323133203020523e3e73747265616d0a789c6364606162606464e409757773f5f0d276f60db200f1e57f4833fe9061fa21cb9cfebbefd7a19f4daceb7e300b7d3715fc6ec0ff5d4780819991d1cd2bd239bfa0b228333da34441c35953c1d0d2d25cc13137b5283339314fc137b124233537b104c8c95108ce4fce4c2da9d45370ccc9510802e92856084a2d4e2d2a4b4d0159e99c9f5b505a925aa4e09b9f925a94c7c0c0c06468c4c020c4200cb2893df8c47fc624ad057cff99841d18bad7fc58bd66fb7cc6eff2b798bf9ffb2928baacb3a7402e2939ac58a79b238b7d59f7c1eea3cb38fe4c654feba8d791cbc862dbd2f7b07b07103eeaded2c1b126835da763fa0679a85977bfbffff2760d63f797ef25af98bfaffb9e203a7bd6d635b3679e3c72ec50f7338eefdcea377e0bfee6b131308adad43273c1aa591bf74776d7cbadb8726ec99e6e8e17bb6dcc959dec7f73fde695ff2df45bacbea1bbb3bb48f2873cdb8aefeeac396c1de5cd91f515adcdf6ddd5dd1cbfddd8f8ca16fcb45ff07be9aceff953d97e274e635fc3759d5b8e8bc57c3e0fe7f2093c3cd767f3f0323000008a7aa1ba0a656e6473747265616d0a656e646f626a0a3231332030206f626a0a3431300a656e646f626a0a36322030206f626a0a3c3c2f547970652f466f6e7444657363726970746f722f466f6e744e616d652f484e4444484a2b434d4d4931302f466f6e7442426f785b2d3332202d32313520383531203731365d2f466c61677320340a2f417363656e74203731360a2f436170486569676874203731360a2f44657363656e74202d3231350a2f4974616c6963416e676c6520300a2f5374656d56203132370a2f4d697373696e675769647468203333330a2f43686172536574282f706572696f642f636f6d6d612f6c6573732f677265617465722f412f582f592f5a2f612f622f632f662f692f6e2f702f752f78290a2f466f6e7446696c6533203631203020523e3e0a656e646f626a0a36312030206f626a0a3c3c2f537562747970652f5479706531432f46696c7465722f466c6174654465636f64652f4c656e67746820323134203020523e3e73747265616d0a789c7556697013e7195e59d87c26c4904cd5b12744ab361749490b3f3a94980987493004270e2106038eb1918d2db06c4bb22cc9d67dadf4ea3e56876dc9b27cca3706e2842304489c421cae66a64927694b981032fdd1a4653eb9eb96ae6c9a69a7ed8ffdb13bdfbefb3ecffb3ccfbb1c624916c1e170f28a5fddb6ad78e7cf8a4a4a76ac5b9b7922483fc649afca4a3fce3dcab8fe363267c81e5ab5ec378fe2238fe06d2bf0ba950497c37979d781a2c626a5a4fe489d4cb0bae859c1ba0d1bd60bb634d448ea0f5789052555b2ba9a862a197b734cf046e3e1fa1a99f2e7822dc78e097667de900a76d7486b24f21ae1e2578b1a1b9a5a6435124149a3b046222608e2912de2c3fbca9bf6d7d6b75429aa37be58f80241fc94788dd8466c205e205e270a89edc44ea28cd84a941345c4e304493c4cac201e6511114b893e8e90733deb16776a8978c977d974ceb339b796dad1667439f7f1dcc6dce9dccfee734ade2ccd9b33400a57a4d22fc539783b5eca3b5c2c5457525abb014081cc1e8b9fdf0f29d7008cc018350cc81b86186d7098489953ea875e0879697fc41772c0558c1076e738e5116615e851c35eaa55ad87565d089cfc1370ca75823d7c99ea652b84204eeb415302be418a7c752edb1607b70a0adac06a32eb11a398dfc1c3e5f8cb61e6cbecbcfb59fb0a277489f4f3090efe62267a85fbd5873caadd2c030b52460c517e08bafcbeb8c3197ad7dbeb1bf20ff986bc096fc2d3e3eef40f3adcd1d4f9afbf05341da81595ec677ed4768834c8ec5ad0a1836375efde9dc04ffb8306a0f87a00cad2deba5df4c67e402a53b0a737900c24c8d8f993380b2ea14f0e4d15f1d7c1fe575432cbc5ea5405548042a857b6d5ab4bc18af4411660101c0e6fa2f346fcf438a038ad11c9299d662f99779f33f1fe665d028f7e3595e0c0a758fc0d372d48afe4b5811ad4eab6769b0a4c48daa58b0df627a7ce1c9cd8c63cc614304f303f59f7c1c6bfe0277e7f2fe435fbcc7c0bd86c66e3c6d50c07b48076359d993911ffd3e8afc9d4a50ba72ec0284c6a224d28ef3e77a3e20f909ae3a4386965fa17bcf5f800e5b7b9c15100deced84977d0117440270a6959c8d57088aa020994b82480cc5a764e4108cf78f52d01122f638699234cabd962b79b2d05fbcb0eb6eda3348b7ab0833ecc1f8211570a26e03835be38cda0de61230d8e634e18808e684728fc1d26f287468e9fe84efe9931e6bb750e3bd8c0a85009ad3abbc10e2aa4a5c1cd1f80ebacae7ae1a38c2a7c218885f460248b1d36976a4af84d315e2b9bb97afdaff8a1e181c1e46472c61576040062c801410dbf0144d431a8851ad711b67f0db49a3c94cf4e06ec291b34825aa7311a5842b2b6b9d63e20e46e7a9617890c0d8d8c5ef514d0994a5dc86f711bf9cd20a69a400475aea30b9514baa0dde31bb4c955b266ab8564da99389385cf9a23e064994c9e816024c80a38436223bc4435fe40a2e601896e8384257105f3858372e9802a00ea30f34b8b52b3c74e15da91c2b8e88981eb2e182007e02635b0003e4e1b406153805345ca9d662784c01718f37477cebaa2d1194fcce1f20758401c2c2098b2145eb3e08874d94dee3493c733d6db4c9580b43a50183d567fff60a6f4088c66fcea092fb84d5dced60b9dc4eb7dbd64583c50770e1046f811fc347ee6eeeed94de5078e0845a4fefd43ddb50bea362895f59ad780fa1feaee8c186b6494ceaa22afe878befefe81aee8586ad0d709682a59575a2a62962a6bc8fa970e886a01edd07ce97582d315629d90954a1e82d1f43f529c39e1dc333c87dbe9012f0a58a0953fff428e1458b129f630c5f9368bdd04b68cd242fc00387d4ed7245ef6de2c5ecb76bc3e67fee2dfb3c16e55b3bc1a7cd0c54f6fcf4966ba8bddc0cdf90eb7cb076ee4b17a0d7c037bca24af64561d28625e04c46cca61d9bb1b2c65aa12b1afd24d29fcd4ed2ed69277f0d53bdc3437fd24ef8f39f1e002552af25739f407761bfd81bb3b72c31b0ac43aa3dde0863e88292badfa3a6847b22e6dac6f3031f94e454f35bf1e76291b569be5945eca3c8a5ece51b063d0062046cee66c9e2795cfa9d6ee85022b2b1345d73baec03844518f32a46816b7d4bcf5b6f404ff024c7dd835397cb9073fecf06546bccf706d21f0f08f6f73cecd9c9ae1e289b96c5e5cdd216b6a6a6e524454c99ea19e21fea6f9e5bcd0203883fdfeb827c2fa62fae844f9f335cc53867fcdcce9e9e8bf3b35340ac8df0947e526b9554f1a9bdf6250db217db34604727470b4ee341b834f05fe2d0695bb44afee7b1083de48cf4799d16d949d5fcce0cfafd06c3fdf5fe4d1d563cda7600c7a7a3a863bc7c31f81133da861b7526af51b8aed5580e4faf04822f4ae7f8c0c8c07c703e3ae6870d21df5f40427d9c977a903ed6cb035db8df58aad954c91b6cc6e3d5cb815d05efdf4c4c581cffbae91a1a11f80ada9fd4f60bdb726272601053aec47a53ab1b99dac5d2d2f81fd68cd35c9fbfc59189fee4c64fcbf92f62c360e37b8e9dc741e4f3921ee7f8b95432eb392798679faf90b3b3e8b9f75df9821fd5563a2d3ff17906aa7b2b41a5013d5174f38fdf4db247dd2190c4c765e71c7a2977c036c34b851a736a8e24ba1bd856a413b9910cfa2045bbbaa724f755b23a072f585e36787f18a9e77c8d487d31353803e8e6c309b6d66bb254370a1855d72e1dbb8ea767841949fdce1e25bf802cfdbd773e73a782009dd9a464bab04a4a88d56f42786bba6de2b8dd4f35f87ba32ad4c32fb66500ce889dd0c4f92e1c8ef72069ce4e8bdd95e76f6b131c3ebc754c5b58c806c2ba9abaa0433c8401eeef524ba6100f5b7f8db1b24cd472bceb6be9de1edbacb1baa1d17ce00fafe12e6f5662830d8ac261b29126c97b201296c1b1e65172ccb00abd4d1e7ba17955a7b9203335877938b8d739b780b012d83adc6669bd1aeb38312b176889e769af47c3019ea2df20dcce7f9da726b1bd4a135e74b3ec5cbf00afc2c7ef2ebb26b85fc0aa816371c43ad2ff2bc097006e8331f4f47fb008df737bcf2205b44c515478480ea45fd9fc620d67199ed849b3bb352d89d1e8d73208db973ebd3165ec8ebf3008d684340c7a7d8eda331cd9f6322f93a8bd1c2ee50addf425bd299076193135c80e84080a64d1ead979c4f6047f67f97c40a1eedf17bd85c0e193d3acffc391cc9d7f86c4001d2190c3a83c71c3191e904e398672fb5c9620643812e60a0f92e561ce10563f36656326f76e3cdf738df26b8b8d2c19b951c178a5a258d4df1e611f64f26ec0e065c4e87c301c8e1b0abb7d4bd2612913a1ddb3c854c1eab87fedd6f712e7fb110dce3c03d2ede739e37284d8ac552a9589c940e0e269383fcbc96c4dca604d34fd3e11ca68a5e9a5a76f321feb225ebe3cb737bbdcb9713c43f012b7e59ce0a656e6473747265616d0a656e646f626a0a3231342030206f626a0a323436350a656e646f626a0a35392030206f626a0a3c3c2f547970652f466f6e7444657363726970746f722f466f6e744e616d652f4a534b45484a2b434d535931302f466f6e7442426f785b30202d32353020393939203735305d2f466c61677320340a2f417363656e74203735300a2f436170486569676874203735300a2f44657363656e74202d3235300a2f4974616c6963416e676c6520300a2f5374656d56203134390a2f4d697373696e675769647468203939390a2f43686172536574282f6172726f7772696768742f756e6976657273616c2f6578697374656e7469616c2f6c6f676963616c6e6f742f6c6f676963616c616e642f62726163656c6566742f627261636572696768742f6261722f706572696f6463656e74657265642f6c657373657175616c2f67726561746572657175616c2f6172726f776c656674290a2f466f6e7446696c6533203538203020523e3e0a656e646f626a0a35382030206f626a0a3c3c2f537562747970652f5479706531432f46696c7465722f466c6174654465636f64652f4c656e67746820323135203020523e3e73747265616d0a789c75937d6c13651cc7ef5ad61d734c3469b245b856039948244c13368889908a41067fc0868222a1b0db56e8daadd7d255d7b75bdbebf6ebf5fa72bdbee0d68e0ea8bc6313444d06c1178c6f8962206a42482421fe23c6049febaea05706913f34b93fee79ee79bedfcff7f7fb1d8ecd5361388e376decea5cbf61e372c3e6ae1d6d2b6b3b7ae9295c5aa49216ab2df7ba67ffa81cac9b5e54677b121d7e02451e479e8558038ebfbae92dca3a1ce0c4298375d06533f5f5dbf5cf1a96e9db56af6ed7af1ba06ca6bd468b7eb3d1de4f0d18edcac2acefb2ee355176d70afd3ab359bfb57683d66fa568ca7680ea9933375807061d76caa6df6ceda16c16a3cd6675de97365bfb6a12464b8f99a2696ac86134f7d928a372f4febbc3623a40d968e540ed8699eab553c326da4e59ec26a319c3b0c643bdfbfad63cbdebc3f31d9faec6301bb6137b1bdb85a5f1711cf008cee1519cc763d802a51e980a5b8a7d84fd8a3bf1e32ab56a9bea0bf52a754efde73c43d3dfb8f6f242b4e30e0e77d4a81b45b525ba68b1d0b4c552a44ba562b144364961395a907a8b92298fa325dfa9d169e9b216aec054717a62e250f17b3e16e1798813e22878c9567861fb9881903bebe1797877c8ea760f0e6e62894060dcef8f436a5c772e7ce300b412f29bf5b0054c177acf0d7c337a0c887412c45410fc11dd4bb1def3cce9b0081c9c22d073f5f03ecc8ca53cdf761eee1151c349f8018e1273d80ad66c571e87b21abd58316ab330e974c2b09bbcb7a6de0dc3f93c4c661fd2f7172453e121fd2f5af81c4ebe716677a953d80f84df0fbe39b69f436776097d511f8c413f212bd603b09df3675efb7ae8039fdc608257c04ac81beac1000edae672d9e9f56c689c652148f85290226fc3cd19ee0a8194ecbfc1c1c347b3d92347bee2894422929a8bb63bbaaa00b7157a55ee58e16601ed29e39258564b7fa16bda12cb5bc8ea88c63d0c4ee724647592437e5d33022e25c7448e6c9a1db952408bcb88cce395dfd13bdab5ddfb3a60946092e10499062ecef1b993c77fbcfd713ace4520412482d17172dbf496337b6eb1c258cc07446034cc8c9ee8b8daadbb9bd28cb8149709c8e9e6581c05e99a524869468d907455cba642290f30100805dd3257fdb239e8554a12267c02239209487289f790572a35236ff568ccc73319681105418c02174c2b8aeaf94a6f14d41505e9544d15a92b1dd22d6d8a4ff290214446f0916145cf17ac5e9473cdfe10c38207bca990c04a17940d31c8010f444d311d887ae3baea148ad449c9aa539b9d847c7e184674d5b2c6ed7c50a8ff346c473f69053e1583346418de1fabcea06cb327a1a400c2c7303e6f3c9c09eaa42939523d24730c5b6368b99f8f57064f8c13d25979e7fff9a99647572a255b594674cdeea25afaa4b2441b4b430c22ca6f2078490fb07ed6bf4aa69be5cf34ed682894090b6e68f1fb199f8210f3ea107f7769cc1365b2d092015ee045426e93dab4685a232f92a5ba47db3dfb8cd2eedc8442e2524894e65dbd74e23a240961341a2095c604c7d891fefd86d69dbe60781c0210888d25d8eb3d67b71dd9c2335c480422918c0ac97dd7d75e7ac00e6554ae3db8d4aa4c1f5b59f660fa163c327d1ab92c4bffae912497ab9a47be2fd09478bea46b724c555e9ed2c80b63f5e5861b8f910df3daf38df3cbb9c6460cfb07aa2da4d00a656e6473747265616d0a656e646f626a0a3231352030206f626a0a313232390a656e646f626a0a3139332030206f626a0a3c3c2f547970652f466f6e7444657363726970746f722f466f6e744e616d652f484e4445484a2b434d455831302f466f6e7442426f785b313730202d31383130203731382031305d2f466c61677320340a2f417363656e742031300a2f4361704865696768742031300a2f44657363656e74202d313831300a2f4974616c6963416e676c6520300a2f5374656d56203130370a2f4d697373696e675769647468203333330a2f43686172536574282f62726163656c65667474702f62726163656c65667462742f62726163656c6566746d6964290a2f466f6e7446696c653320313932203020523e3e0a656e646f626a0a3139322030206f626a0a3c3c2f537562747970652f5479706531432f46696c7465722f466c6174654465636f64652f4c656e67746820323136203020523e3e73747265616d0a789c6364606162606464e4f3f07371f5f0d276f6758d3034008928fe9066fc21c3f44396b958e64b810cebba9f335897fd2817fa9e2cf83d86ff7bb800031b23a39b4f745a51ad737e416551667a46898286b3a682a1a5a5b982636e6a516672629e826f6249466a6e62099093a3109c9f9c995a52a9a7e09893a31004d251ac10945a9c5a54969a02b1d9393fb7a0b424b548c1373f25b5282fa9283139352735ada4a400cecccd4c81b3934a181818982d6cac1818bb18bb197bc0be616067f06338c0c8f19fd1373480ef3f73c5e3867f120b7ebe9bcfd8fd9d87f947cf9f48d1eebb0bbf077f77fb2e34636a4f4ff75c8e455d3d4572d56cbfb37f73d8fd0eecfeadcef1c789bdb0a76b99dc69b6653d3d4be521c6c8fcf8b14086edfe7cc6ef596093647ead17edfece1bf13de177c97799ef65df65f77c4feafecec5f1c38a7d69574f819c375b415757a1fc1f6bf66ef3cadf29bf7d7e2b3434757575577657f6744d6b5a5a7e216cb7da26ebf946dd461c40459836fe1347727895288aa14eecddbf356efc0efc9efd9b9d6336db929e9e4573bb7adafbe4731639ef8b799e72bdfc46f7230ebef2f96c32bf2be7b3efe2dac52dc7c55299cfc3b979120f0f10f332300000a5c7cf5f0a656e6473747265616d0a656e646f626a0a3231362030206f626a0a3436310a656e646f626a0a3138362030206f626a0a3c3c2f547970652f466f6e7444657363726970746f722f466f6e744e616d652f425a5444484a2b434d5359382f466f6e7442426f785b3839203020383236203237335d2f466c61677320340a2f417363656e74203237330a2f436170486569676874203237330a2f44657363656e7420300a2f4974616c6963416e676c6520300a2f5374656d56203132330a2f4d697373696e675769647468203832360a2f43686172536574282f6d696e7573290a2f466f6e7446696c653320313835203020523e3e0a656e646f626a0a3138352030206f626a0a3c3c2f537562747970652f5479706531432f46696c7465722f466c6174654465636f64652f4c656e67746820323137203020523e3e73747265616d0a789c6364606162606464e4758a0a71f1f0d276f60d8eb4000928fc9066fc21c3f4439639f79fbf0ccbc29ff359e77e4f11fa6e2af8dd88ffbbbe00033323a39b7794737e416551667a46898286b3a682a1a5a5b982636e6a516672629e826f6249466a6e62099093a3109c9f9c995a52a9a7e09893a31004d251ac10945a9c5a54969a02b6d4393fb7a0b424b548c1373f25b5288f818181712103c33206264646262dbeffcc566909dfcb773276ff9466fe19f0bd5c74e6c2ee458b4abb6be5ff5c66ab2ded2e2959d83d539eaf78f14ffb056cbf8526b3efe47ac2bd73160f0f03030087da4d770a656e6473747265616d0a656e646f626a0a3231372030206f626a0a3233320a656e646f626a0a38312030206f626a0a3c3c2f547970652f466f6e7444657363726970746f722f466f6e744e616d652f5a554a44484a2b434d535931307e35312f466f6e7442426f785b30202d3235302031303030203735305d2f466c61677320340a2f417363656e74203735300a2f436170486569676874203735300a2f44657363656e74202d3235300a2f4974616c6963416e676c6520300a2f5374656d56203135300a2f4d697373696e67576964746820313030300a2f43686172536574282f6172726f776c656674290a2f466f6e7446696c6533203830203020523e3e0a656e646f626a0a38302030206f626a0a3c3c2f537562747970652f5479706531432f46696c7465722f466c6174654465636f64652f4c656e67746820323138203020523e3e73747265616d0a789c6364606162606464148c0af572f1f0d276f60d8e3434a833350409caff9066fc21c3f4439639ef5fc8af0f3f67b32ef9be48e8bbb3e07707feefb6020c2c8c8c6e3ed129cef905954599e919250a1ace9a0a869696e60a8eb9a94599c989790abe892519a9b98925404e8e42707e72666a49a59e82634e8e42104847b142506a716a51596a0ac462e7fcdc82d292d42205dffc94d4a2bcc4a2a2fcf29cd4b412060606c6c30c8c5d0c4c8c8c4c517cbf6a2e2ff82ebbf9bbdc7cc65f4adfab4467cded9e3fbfb2bb46feef54b66b87d6dceb9ecc31a5b9af45aebebbb3b5b3bd2623db593da6a1b5a3abbba5bb6542e7a4f67b291b439705f637f5b64debe69834b96fcae4ac7b0e87e4f94a17feb45fc8f65b6002fb66ae07dc725c2ce6f3793837cfe2e161600000bb386faf0a656e6473747265616d0a656e646f626a0a3231382030206f626a0a3330330a656e646f626a0a37382030206f626a0a3c3c2f547970652f466f6e7444657363726970746f722f466f6e744e616d652f54555643484a2b434d545431307e34652f466f6e7442426f785b2d34202d32323920353337203639345d2f466c61677320340a2f417363656e74203639340a2f436170486569676874203639340a2f44657363656e74202d3232390a2f4974616c6963416e676c6520300a2f5374656d562038300a2f4d697373696e675769647468203532350a2f43686172536574282f70657263656e742f706172656e6c6566742f706172656e72696768742f617374657269736b2f636f6d6d612f68797068656e2f706572696f642f7a65726f2f636f6c6f6e2f7175657374696f6e2f462f532f582f592f5a2f612f632f642f652f662f692f6c2f6d2f6f2f722f732f742f752f782f792f7a290a2f466f6e7446696c6533203737203020523e3e0a656e646f626a0a37372030206f626a0a3c3c2f537562747970652f5479706531432f46696c7465722f466c6174654465636f64652f4c656e67746820323139203020523e3e73747265616d0a789c85566954145716aea6a1ba04372015414d1563e29298386a4c026e117189188c1396a8890b4bb376d3d26ccd2eb27341f67deb666bf6206834889a19136da2495a45679cb82406a359d13199dbe665e64cb50d3439c939734ed58f57efbebb7cdf776f3d116569418944225b2f6f1fb7d7dc17bb7978792d5b9abc426afce864982332ccb5303c25ce22298f148f8e58b5cf9d76dd0e4b6dd17b06ae98498945a24dafbfeda6d81fa70c090a8e725ae4f6acd3321797579c5ce5526588bf6fb893876f54b054ee1b252c644e9e0aff106954dc12275799cce94de38948a737a59152658c34c014d84d21df1f1d25553a792802a4ca708aa2f838ff1df18a809dd25d81ca4d9151219ed1325f957cd1abcf3ef7fc0b4b562e9d4f51bba80d940bf536b59dda48ada43651aba8cd9427b590f2a2bc29776a05e5437950eba99dd4366a0ae544595336d4346a3a35839a43d95234e524944f595245d45d915cf489c54c8b548befc51bc54d968c65b8e54d2b95d5157a397d4bb24d52c83cc5b44cf198526dfd84b59f35dabc68b3c3466573d8e6bf532b0d9ae9060d51e90cdd3a51ed6db161bd8166dbe9ea6668ef8884049e4ca11395209735410dafa5dd48487260465cbacc3197ceac3fa84eaf5f82e90ecdbf314f880499bc19aaf90e1ae7914705a99003b98e90a3744956867b05e524e6425e61095432cd7175cafdf17111beddfe83dc281c478782724648264387ffd089408f91236243208a586d38647009909a931e9b91ac7ac7159897dd2e7e7d428b129ca3ee83837c5e707d5213304deadab6e1a7610f59f70699fb2299facd7cb443befb875a5ef00a3a43924e546ed823c663f84f16ad30ca4a4357b70889474022ffb4a9cc4668e43790056b718155432374b42b4d5b11c2568b5052238d5349347124b556d1e6421f9adc4442147f177d7e243e5651d1bfdd324688a21f6781433a518d1e8fe8c5066f7cc4aa1bf20e412dd31d0d2a8edca343d3d242f9dd12154477f780ba816bc17c09b94006636273b321de314403f59c6106ad298206a8663e92d48326241862623929d1482663d72cf80f42198bb64b7e2496c472c922624becbf7d1e2dd0e2dbefd08e23bee425d6d5e3eabdaf2f5cb874f9bcfbd2251eeb5cf9c72ebc74f8990ead7476829f22fd2cfb44fce5241b0449fddc305dd32ca0120149fc1e4311dd915116c2ada7139442b52d50c51f27cb69fbc1b650bf9a7d738868f1f3c49eccbcf3dccf678eb6b669790cb3dc20f1dce3bc76c31b9746bebb78e1e2f9414f2f6e8219940a196f370cb06ab39ac648d140133f8f1c483ab5129d53d58e4d1a3331e3d254d3b8889cb5225b9592896f6863f6a4c4adb4099eb9e7f00901a1cb587f496c588d9eacba1e7a91defa037992d82c5e486690e9f717208b0e03779a8dc28b4bcb56a5f3d13bbc0f2a601dac3b99f02593778ead1a3efbb78b701a8694a5cf30133554e8f15da18a40c37b6c59351441d918afb74dbcae37f3fa01964bc88d5fe352132103524dbce24f74577169277fd7ccaa1bd14ac65583b60248f3f4dfdf166391d0a3387d52d74d1fa0af7d0aed5c5669404f43638df6dc2a4858b576f70ace67a1e4313b462dde27430bcc52c626b334174c48d34b6787d3f4b8e9f62cfbe3a8c46dec3767bfc3695c5e646d6c33309a869ad68694a3ce3bb6c6bdeec5dbebbb258f15402ccc445c27432bcd2bac320721e2b128a1c64774458f73f5c7f5627c15b52ccea5fd20a1a71b34f5dcbdb1f213fc38321743f1900f3d01dbb029e0afb6e39aabe6bb7e4d0a35af70891995b7e8f186b013a2a6e864ba59f6f7f11496b05105b1879485e1059b2ba08f69e9ecf896bb0955f2431179f1f9f11dc01843f17a490d34cbb948c84aca49dfabde0b2a60c8aa2897a03fff147f3789b7bf3798f679b2cfecc0c0d0a5dc3be059aebc965997551e018c9138fe39490228dbb952a8c9abe81d0cfa20470b0c2eefbc79e22161d56185a63e13baec5f0d227c428fcb051c9446529d2791ea7c839e1082cb0a338f5f916c7af16741c357aebf375207eae0d0dc98782ed7e3cdd42860d6c2e9667e9ccceba376386b7493d0c1f770c8309b3591356f9206acc810993609bd1366bae6d1f6f70d3996da688d42111dad5068a2b55a8d466b6cd8033a438980e905acb920bd60743e88adac36e3662cac60dedab77d35a7805d05feadbead594773eb726b73ebc2c650210e265834505455dad92fd7259c1760612e7f35723ee8684a25efd7bfbf784d1d637f7f659d6f85b407061c4f0d9eb8c4a13554bf50243b145d9ed130c60e3a8cd393199f26f7ebf1aed823d0235eb7fae5d7dedf7233922fc8fd3eaa2a9b191f67433abb2ff4e82520a1c25f3ad9bc3035d40133799ae18d3f986621b4fdf1652b53c256435727878d92df5b94d28bf591c3dc113852d6ab350f025c2b107ad2f0e918e4cbcd47f0c95f93083b697d6312e34fd2e3092fd38d1ac7efbe11f410928e315874b21ad989dcc3c068c7a69f6f6ae1a1341e65924bdeb7c833fbe6c37ab93aa189ab066d695e2f94e4e535e457e5554229307f3f2ddbc0db0f908dd964c6cec5b3377decfe80eb85a1e2810ee680d0e1af48200a6202e282e2f7401a301e7edd7d835ff6e2fc82091d89c01022c67e54b2288c59ab7ebaaa75bca7a78c4fe856de75c1abf7ad5ac667b3712742a8b155a8b19f466bb288cc242f59f99bbfe21453e53120e3bfc4192364869562fcb729ec4dc4f09f3c9c3e3c8336c66796fd751419e6b339edb110074c9849d36a7897274392a098b1105f99e41c03413c6e96d80f8e1c1938d25815efce9124894a396674f53746ffd72453d200482fe7e4e097ac0848ec56d4854218c89322a38df4bba81f453608ff5fb1618b370bd5e905711564e6addde8086809a38791c7d95fd7941717083fef92cc868870b28f3890520e88cdfbcb7a767eb0feaaa7708f69296c28790cfee82d353e147430f2fee8b2cf7f1684f06f81850c16066a3ebc77aaada6b70d4e33bdcadbc483fc69d716cfb0a644b5bab156cb414566596651b376a0b80f98077d61b288e814552a4fe6af82e5e0cf0440727f7b59513767ff4b1959cffe51879bcac0b70415ff846759409bdd77824ffa0caf3b13098c3223362db13cbd309b476722aa262f813b2c0c243c99b33431352d131299b4a2d8e636dc870e586af476476d982d78733e2736b81928b6a2b8b218ea990268f3e7c84cb7fc96bc4fa0cdb114ba424321f42007e1795bf22308f5b14352690ea403139b1c97a82acfa84ce751b49d50db53d2933320d6310bc2fb399c79392722770b843b1e84d0ae2ee812b06ccbfd24a7451712d870d1b735211f4a8069a8acabae4d29cdc9e395b59bbb22aa8c4c115e8dd6682b7a705e8c3d87d8448f771252b252b3e332219649ac8eafed7cf057b4d005f4edf58f928749db945d5c1114e715e71bcf62d345a127968a0d2ed8c456f4404f4f30a4f0e4129d120cc1c13d50f1983dc1b9f08af1da10db2b6f09932a65b2c0f688cec3cd1d1d9c691fb74cd8182c7f6f44ce5afed1c1c7e3d778c7eb1364168e1fb1b86d3ece2216c47221994ddcc9b607649670cdb31cc5d928e8389894b06bdc855a17e102fd8f57862f3e4b169245eec47a8d314be7219c3784d943f8f49008ce0c9df95978059a1ed9b20565f98550ccd425d6c60a63365d9599425afeb3d1212b352713d219554d423dd704c575c29d1dbf78c85e093cbb7367e07657d7deed274ff69ebdc2add8c0a6a85a8f1dab6fada8a8dfbf77af6abf8090b7e11a7b2de0ccdbbba47f59b7a6cff3c4e0e18fae9a2cb5c78ed4b55756d6c9fdf6aa1429fcf403e5062c279ea534892b96e8acf5369cb5659c62ea14ddd4a9faa9d328ea7f2588ca950a656e6473747265616d0a656e646f626a0a3231392030206f626a0a323739390a656e646f626a0a3138372030206f626a0a3c3c2f537562747970652f54797065312f42617365466f6e742f425a5444484a2b434d5359382f547970652f466f6e742f4e616d652f523138372f466f6e7444657363726970746f7220313836203020522f466972737443686172203136312f4c61737443686172203136312f5769647468735b203832365d0a3e3e0a656e646f626a0a3135372030206f626a0a3c3c2f547970652f466f6e742f4e616d652f422f537562747970652f54797065332f456e636f64696e6720313333203020522f4368617250726f63733c3c2f6131390a313736203020522f6131370a313734203020522f6131360a313733203020522f6131310a313638203020522f61390a313637203020522f61370a313635203020522f61350a313633203020522f61330a313631203020522f61310a313539203020522f61300a313538203020522f6131350a313732203020522f6131340a313731203020522f61320a313630203020522f61360a313634203020522f6131320a313639203020522f6131300a313337203020522f6131380a313735203020522f61340a313632203020522f6132300a313737203020522f61380a313636203020522f6132320a313739203020522f6132330a313830203020522f6132310a313738203020522f6131330a313730203020523e3e2f466f6e7442426f785b30202d34312034382035385d2f466f6e744d61747269785b31203020302031203020305d2f46697273744368617220302f4c617374436861722032332f5769647468735b0a302030203438203020353520302034392030203537203020353320302035322038352032372032360a30203020353420302035362038342035382038325d0a3e3e0a656e646f626a0a3133342030206f626a0a3c3c2f547970652f466f6e742f4e616d652f412f537562747970652f54797065332f456e636f64696e6720313333203020522f4368617250726f63733c3c2f6131350a313530203020522f6131330a313438203020522f6131300a313435203020522f61390a313434203020522f61380a313433203020522f61360a313431203020522f61340a313339203020522f61330a313338203020522f61310a313336203020522f61300a313335203020522f61350a313430203020522f6131320a313437203020522f6131340a313439203020522f6131360a313531203020522f6131370a313532203020522f6131310a313436203020522f61320a313337203020522f61370a313432203020523e3e2f466f6e7442426f785b30202d33352034362034385d2f466f6e744d61747269785b31203020302031203020305d2f46697273744368617220302f4c617374436861722031372f5769647468735b0a302030203533203020302033392030203639203020302030203437203433203020343420300a34352034365d0a3e3e0a656e646f626a0a38322030206f626a0a3c3c2f537562747970652f54797065312f42617365466f6e742f5a554a44484a2b434d535931307e35312f547970652f466f6e742f4e616d652f5238322f466f6e7444657363726970746f72203831203020522f4669727374436861722033332f4c61737443686172203139352f5769647468735b2031303030203130303020313030302031303030203130303020313030302031303030203130303020313030302031303030203130303020313030302031303030203130303020313030300a313030302031303030203130303020313030302031303030203130303020313030302031303030203535352035353520363636203130303020313030302031303030203130303020313030300a313030302031303030203130303020313030302031303030203130303020313030302031303030203130303020313030302031303030203130303020313030302031303030203130303020313030300a3130303020313030302031303030203130303020313030302031303030203130303020313030302031303030203130303020313030302031303030203130303020313030302036363620313030300a313030302031303030203130303020313030302031303030203130303020353030203530302031303030203130303020323737203130303020313030302031303030203130303020313030300a313030302031303030203130303020313030302031303030203130303020313030302031303030203130303020313030302031303030203130303020313030302031303030203130303020313030300a313030302031303030203130303020313030302031303030203130303020313030302031303030203130303020313030302031303030203130303020313030302031303030203130303020313030300a313030302031303030203130303020313030302031303030203130303020313030302031303030203130303020313030302031303030203130303020313030302031303030203130303020313030300a31303030203737372032373720313030302031303030203130303020313030302031303030203130303020313030302031303030203130303020313030302031303030203130303020313030300a31303030203130303020313030302031303030203130303020313030302031303030203737372037373720313030302031303030203130303020313030302031303030203130303020313030300a313030302031303030203130303020313030305d0a3e3e0a656e646f626a0a3133312030206f626a0a3c3c2f547970652f466f6e7444657363726970746f722f466f6e744e616d652f54696d65732d526f6d616e3e3e0a656e646f626a0a3133322030206f626a0a3c3c2f537562747970652f54797065312f42617365466f6e742f54696d65732d526f6d616e2f547970652f466f6e742f4e616d652f523133323e3e0a656e646f626a0a37392030206f626a0a3c3c2f537562747970652f54797065312f42617365466f6e742f54555643484a2b434d545431307e34652f547970652f466f6e742f4e616d652f5237392f466f6e7444657363726970746f72203738203020522f4669727374436861722033332f4c61737443686172203139352f5769647468735b2035323520353235203532352035323520353234203532352035323520353234203532342035323420353235203532342035323420353234203532350a3532342035323520353235203532352035323520353235203532352035323520353235203532352035323420353235203532352035323520353235203532340a3532352035323520353235203532352035323520353235203532342035323520353235203532352035323520353235203532352035323520353235203532350a3532352035323520353235203532342035323520353235203532352035323520353234203532342035323420353235203532352035323520353235203532350a3532352035323420353235203532342035323420353234203532342035323520353235203532342035323520353235203532342035323420353235203532340a3532352035323520353234203532342035323420353234203532352035323520353234203532342035323420353235203532352035323520353235203532350a3532352035323520353235203532352035323520353235203532352035323520353235203532352035323520353235203532352035323520353235203532350a3532352035323520353235203532352035323520353235203532352035323520353235203532352035323520353235203532352035323520353235203532350a3532352035323520353235203532352035323520353235203532352035323520353235203532352035323520353235203532352035323520353235203532350a3532352035323520353235203532352035323520353235203532352035323520353235203532352035323520353235203532352035323520353235203532350a3532352035323520353235203532355d0a3e3e0a656e646f626a0a37362030206f626a0a3c3c2f537562747970652f54797065312f42617365466f6e742f414e4d45484a2b434d5231307e34622f547970652f466f6e742f4e616d652f5237362f466f6e7444657363726970746f72203735203020522f4669727374436861722033342f4c61737443686172203139352f5769647468735b20353030203439392034393920343939203439392032373720333838203338382034393920373737203237372033333320323737203530300a3530302035303020353030203530302035303020353030203530302035303020353030203530302032373720323737203439392037373720343939203437320a3439392037343920373038203732312037363420363830203635332037383520373530203336312035313320373737203632352039313620373439203737370a363830203439392037333620353535203732322037353020373530203130323720373530203735302036313120323737203530302032373720343939203439390a3439392035303020353535203434342035353520343434203330352035303020353535203237372033303520353237203237372038333320353535203530300a3535352035323720333931203339342033383820353535203532372037323220353237203532372034343420343939203439392034393920353030203439390a3439392034393920343939203439392034393920343939203439392034393920343939203439392034393920343939203439392034393920343939203439390a3439392034393920343939203439392034393920343939203439392034393920343939203439392034393920343939203439392034393920343939203439390a3439392036323520383333203439392034393920343939203439392034393920343939203439392034393920343939203439392034393920343939203535350a3535352034393920343939203237372034393920343939203530302035303020353030203439392034393920343939203439392034393920343939203439390a3439392034393920343939203237375d0a3e3e0a656e646f626a0a36392030206f626a0a3c3c2f537562747970652f54797065312f42617365466f6e742f57594945484a2b434d4d49382f547970652f466f6e742f4e616d652f5236392f466f6e7444657363726970746f72203638203020522f466972737443686172203130352f4c61737443686172203139352f5769647468735b203336312033333320333333203333332033333320363434203333330a3533352033333320333333203333332033333320333333203333332033333320333333203333332033333320333333203333332033333320333333203333330a3333332033333320333333203333332033333320333333203333332033333320333333203333332033333320333333203333332033333320333333203333330a3333332033333320333333203333332033333320333333203333332033333320333333203333332033333320333333203333332033333320333333203333330a3333332036343220383835203333332033333320333333203333332033333320333333203333332033333320333333203333332033333320333333203539360a3534372033333320333333203436372033333320333333203337362036313220363139203333332033333320333333203333332033333320333333203333330a3333332033333320333333203639345d0a3e3e0a656e646f626a0a36362030206f626a0a3c3c2f537562747970652f54797065312f42617365466f6e742f55474645484a2b434d52382f547970652f466f6e742f4e616d652f5236362f466f6e7444657363726970746f72203635203020522f4669727374436861722034392f4c61737443686172203139352f5769647468735b2035333020353330203335342033353420333534203335342033353420333534203335342033353420333534203335342033353420333534203335340a3335342033353420333534203335342033353420333534203335342033353420333534203335342033353420333534203335342033353420333534203335340a3335342033353420333534203335342033353420333534203335342033353420333534203335342033353420333534203335342033353420333534203335340a3335342033353420333534203335342033353420333534203335342033353420333534203335342033353420333534203335342033353420333534203335340a3335342033353420333534203335342033353420333534203335342033353420333534203335342033353420333534203335342033353420333534203335340a3335342033353420333534203335342033353420333534203335342033353420333534203335342033353420333534203335342033353420333534203335340a3335342033353420333534203335342033353420333534203335342033353420333534203335342033353420333534203335342033353420333534203335340a3335342036363320383835203335342033353420333534203335342033353420333534203335342033353420333534203335342033353420333534203539300a3539302033353420333534203239352033353420333534203533312035333120353331203335342033353420333534203335342033353420333534203335340a3335342033353420333534203239355d0a3e3e0a656e646f626a0a36332030206f626a0a3c3c2f537562747970652f54797065312f42617365466f6e742f484e4444484a2b434d4d4931302f547970652f466f6e742f4e616d652f5236332f466f6e7444657363726970746f72203632203020522f4669727374436861722035382f4c61737443686172203139352f5769647468735b2032373820323738203737372033333320373737203333330a3333332037343920333333203333332033333320333333203333332033333320333333203333332033333320333333203333332033333320333333203333330a3333332033333320333333203333332033333320333333203333332033333320383238203538302036383220333333203333332033333320333333203333330a3333332035323820343239203433332033333320333333203438392033333320333333203334342033333320333333203333332033333320363030203333330a3530332033333320333333203333332033333320353732203333332033333320353731203333332033333320333333203333332033333320333333203333330a3333332033333320333333203333332033333320333333203333332033333320333333203333332033333320333333203333332033333320333333203333330a3333332033333320333333203333332033333320333333203333332033333320333333203333332033333320333333203333332033333320333333203333330a3333332036313520383333203333332033333320333333203333332033333320333333203333332033333320333333203333332033333320333333203536350a3531372033333320333333203433372033333320333333203335332035373620353833203333332033333320333333203333332033333320333333203333330a3333332033333320333333203635315d0a3e3e0a656e646f626a0a36302030206f626a0a3c3c2f537562747970652f54797065312f42617365466f6e742f4a534b45484a2b434d535931302f547970652f466f6e742f4e616d652f5236302f466f6e7444657363726970746f72203539203020522f4669727374436861722033332f4c61737443686172203139352f5769647468735b2039393920393939203939392039393920393939203939392039393920393939203939392039393920393939203939392039393920393939203939390a3939392039393920393939203939392039393920393939203939392039393920353535203535352036363620393939203939392039393920393939203939390a3939392039393920393939203939392039393920393939203939392039393920393939203939392039393920393939203939392039393920393939203939390a3939392039393920393939203939392039393920393939203939392039393920393939203939392039393920393939203939392039393920363636203939390a3939392039393920393939203939392039393920393939203439392034393920393939203939392032373820393939203939392039393920393939203939390a3939392039393920393939203939392039393920393939203939392039393920393939203939392039393920393939203939392039393920393939203939390a3939392039393920393939203939392039393920393939203939392039393920393939203939392039393920393939203939392039393920393939203939390a3939392039393920393939203939392039393920393939203939392039393920393939203939392039393920393939203939392039393920393939203939390a3939392037373720323737203939392039393920393939203939392039393920393939203939392039393920393939203939392039393920393939203939390a3939392039393920393939203939392039393920393939203939392037373720373737203939392039393920393939203939392039393920393939203939390a393939203939392039393920313030305d0a3e3e0a656e646f626a0a33372030206f626a0a3c3c2f537562747970652f54797065312f42617365466f6e742f444c5844484a2b434d545431302f547970652f466f6e742f4e616d652f5233372f466f6e7444657363726970746f72203336203020522f4669727374436861722033332f4c61737443686172203139352f5769647468735b2035323420353234203532342035323420353234203532342035323420353234203532342035323420353234203532342035323420353234203532340a3532342035323420353234203532342035323420353234203532342035323420353234203532342035323420353234203532342035323420353234203532340a3532342035323420353234203532342035323420353234203532342035323420353234203532342035323420353234203532342035323420353234203532340a3532342035323420353234203532342035323420353234203532342035323420353234203532342035323420353234203532342035323420353234203532340a3532342035323420353234203532342035323420353234203532342035323420353234203532342035323420353234203532342035323420353234203532340a3532342035323420353234203532342035323420353234203532342035323420353234203532342035323420353234203532342035323420353234203532340a3532342035323420353234203532342035323420353234203532342035323420353234203532342035323420353234203532342035323420353234203532340a3532342035323420353234203532342035323420353234203532342035323420353234203532342035323420353234203532342035323420353234203532340a3532342035323520353235203532342035323420353234203532342035323420353234203532342035323420353234203532342035323420353234203532340a3532342035323420353234203532352035323420353234203532352035323520353235203532342035323420353234203532342035323420353234203532340a3532342035323420353234203532355d0a3e3e0a656e646f626a0a33302030206f626a0a3c3c2f537562747970652f54797065312f42617365466f6e742f51495344484a2b434d425831327e31642f547970652f466f6e742f4e616d652f5233302f466f6e7444657363726970746f72203239203020522f4669727374436861722034362f4c61737443686172203139352f5769647468735b20333132203536320a3536322035363220353632203536322035363220353632203536322035363220353632203536322033313220353632203536322035363220353632203536320a3536322038343920353632203831322035363220373338203536322038383420353632203431392035363220353632203637352035363220353632203536320a3736382035363220353632203632342035363220353632203536322035363220353632203536322035363220353632203536322035363220353632203536320a3536322035343620363234203439392036323420353133203536322035363220363234203331322033343420353632203331322039333720363234203536320a3632342035393320343539203434332034333720363234203539332035363220353933203539332035363220353632203536322035363220353632203536320a3536322035363220353632203536322035363220353632203536322035363220353632203536322035363220353632203536322035363220353632203536320a3536322035363220353632203536322035363220353632203536322035363220353632203536322035363220353632203536322035363220353632203536320a3536322036373520393337203536322035363220353632203536322035363220353632203536322035363220353632203536322035363220353632203632350a3632352035363220353632203331322035363220353632203536322035363220353632203536322035363220353632203536322035363220353632203536320a3536322035363220353632203331325d0a3e3e0a656e646f626a0a32372030206f626a0a3c3c2f537562747970652f54797065312f42617365466f6e742f49424d44484a2b434d544931302f547970652f466f6e742f4e616d652f5232372f466f6e7444657363726970746f72203236203020522f4669727374436861722034332f4c61737443686172203139352f5769647468735b20373636203531312035313120333036203531310a3531312035313120353131203531312035313120353131203531312035313120353131203531312035313120353131203531312035313120353131203531310a3531312037343320353131203731352037353420363738203635322035313120353131203338352035313120353131203632372035313120373433203531310a3637382037363620373239203536312037313520373433203531312035313120353131203531312035313120353131203531312035313120353131203531310a3531312035313120343630203436302035313120343630203330362034363020353131203330362033303620353131203235352038313720353631203531310a3531312034363020343231203430392033333220353337203436302035313120343633203438352034303920353131203531312035313120353131203531310a3531312035313120353131203531312035313120353131203531312035313120353131203531312035313120353131203531312035313120353131203531310a3531312035313120353131203531312035313120353131203531312035313120353131203531312035313120353131203531312035313120353131203531310a3531312036323720383137203531312035313120353131203531312035313120353131203531312035313120353131203531312035313120353131203536320a3538372035313120353131203330362035313120353131203531312035313120353131203531312035313120353131203531312035313120353131203531310a3531312035313120353131203235355d0a3e3e0a656e646f626a0a31392030206f626a0a3c3c2f537562747970652f54797065312f42617365466f6e742f4c445643484a2b434d5231302f547970652f466f6e742f4e616d652f5231392f466f6e7444657363726970746f72203138203020522f4669727374436861722033342f4c61737443686172203139352f5769647468735b20343939203439392034393920343939203439392032373820333838203338382034393920373737203237382033333320323738203439390a3439392034393920343939203439392034393920343939203439392034393920343939203439392032373820323738203439392037373720343939203437310a3439392037343920373038203732312037363320363830203635322037383420373439203336312035313320373737203632352039313620373439203737370a363830203439392037333520353535203732312037343920373439203130323720373439203734392036313120323738203439392032373820343939203439390a3439392034393920353535203434342035353520343434203330352034393920353535203237382033303520353238203237382038333320353535203439390a3535352035323820333931203339342033383820353535203532382037323120353238203532382034343420343939203439392034393920343939203439390a3439392034393920343939203439392034393920343939203439392034393920343939203439392034393920343939203439392034393920343939203439390a3439392034393920343939203439392034393920343939203439392034393920343939203439392034393920343939203439392034393920343939203439390a3439392036323520383333203439392034393920343939203439392034393920343939203439392034393920343939203439392034393920343939203535350a3535352034393920343939203237372034393920343939203530302035303020353030203439392034393920343939203439392034393920343939203439390a3439392034393920343939203237375d0a3e3e0a656e646f626a0a31362030206f626a0a3c3c2f537562747970652f54797065312f42617365466f6e742f444b5744484a2b434d425831302f547970652f466f6e742f4e616d652f5231362f466f6e7444657363726970746f72203135203020522f4669727374436861722034352f4c61737443686172203139352f5769647468735b2033383320333139203537350a3537352035373520353735203537352035373520353735203537352035373520353735203537352035373520353735203537352035373520353735203537350a3537352035373520353735203833302038383120373535203537352039303420353735203433362035373520353735203639312035373520353735203836330a373836203537352038363220363338203830302038383420383639203131383820353735203537352035373520353735203537352035373520353735203537350a3537352035353920363338203531312036333820353237203537352035373520353735203331392033353120353735203331392039353820363338203537350a3633382035373520343733203435332034343720363338203630372035373520353735203630372035373520353735203537352035373520353735203537350a3537352035373520353735203537352035373520353735203537352035373520353735203537352035373520353735203537352035373520353735203537350a3537352035373520353735203537352035373520353735203537352035373520353735203537352035373520353735203537352035373520353735203537350a3537352036393120393538203537352035373520353735203537352035373520353735203537352035373520353735203537352035373520353735203633380a3633382035373520353735203331392035373520353735203537352035373520353735203537352035373520353735203537352035373520353735203537350a3537352035373520353735203331395d0a3e3e0a656e646f626a0a31332030206f626a0a3c3c2f537562747970652f54797065312f42617365466f6e742f4d4c4544484a2b434d425831322f547970652f466f6e742f4e616d652f5231332f466f6e7444657363726970746f72203132203020522f4669727374436861722034362f4c61737443686172203139352f5769647468735b20333132203536320a3536322035363220353632203536322035363220353632203536322035363220353632203536322033313220353632203536322035363220353632203536320a3536322038343920353632203831322035363220373338203536322038383420353632203431392035363220353632203637352035363220353632203536320a3736382035363220353632203632352035363220353632203536322035363220353632203536322035363220353632203536322035363220353632203536320a3536322035343720363235203439392036323420353133203536322035363220363235203331322033343320353632203331322039333720363234203536320a3632342035393320343539203434332034333720363234203539332035363220353933203539332035363220353632203536322035363220353632203536320a3536322035363220353632203536322035363220353632203536322035363220353632203536322035363220353632203536322035363220353632203536320a3536322035363220353632203536322035363220353632203536322035363220353632203536322035363220353632203536322035363220353632203536320a3536322036373520393337203536322035363220353632203536322035363220353632203536322035363220353632203536322035363220353632203632350a3632352035363220353632203331322035363220353632203536322035363220353632203536322035363220353632203536322035363220353632203536320a3536322035363220353632203331325d0a3e3e0a656e646f626a0a3139342030206f626a0a3c3c2f537562747970652f54797065312f42617365466f6e742f484e4445484a2b434d455831302f547970652f466f6e742f4e616d652f523139342f466f6e7444657363726970746f7220313933203020522f4669727374436861722035362f4c617374436861722036302f5769647468735b20383838203333332038383820333333203838385d0a3e3e0a656e646f626a0a31302030206f626a0a3c3c2f537562747970652f54797065312f42617365466f6e742f43484945484a2b434d5231372f547970652f466f6e742f4e616d652f5231302f466f6e7444657363726970746f722039203020522f4669727374436861722036352f4c61737443686172203139352f5769647468735b2036393320343538203636372037303620363238203435382037323620343538203332372034373120343538203537362034353820363933203731390a3632382034353820363830203435382036363720363933203435382034353820343538203435382034353820343538203435382034353820343538203435380a3435382034353820343538203435382034353820343538203435382034353820343538203435382034353820343538203435382034353820343538203435380a3435382034353820343538203435382034353820343538203435382034353820343538203435382034353820343538203435382034353820343538203435380a3435382034353820343538203435382034353820343538203435382034353820343538203435382034353820343538203435382034353820343538203435380a3435382034353820343538203435382034353820343538203435382034353820343538203435382034353820343538203435382034353820343538203435380a3435382035373520373732203435382034353820343538203435382034353820343538203435382034353820343538203435382034353820343538203439390a3439392034353820343538203234392034353820343538203435382034353820343538203435382034353820343538203435382034353820343538203435380a3435382034353820343538203234395d0a3e3e0a656e646f626a0a322030206f626a0a3c3c2f50726f647563657220284146504c2047686f737473637269707420372e30290a2f43726561746f72202864766970735c286b5c2920352e383620436f707972696768742031393939205261646963616c2045796520536f667477617265290a2f5469746c65202870726f6c6f672e647669290a2f4372656174696f6e446174652028547565204170722032302031333a33303a32342032303034290a3e3e656e646f626a0a787265660a30203232300a303030303030303030302036353533352066200a30303030303937313639203030303030206e200a30303030313637353430203030303030206e200a30303030303936393231203030303030206e200a30303030303937323137203030303030206e200a30303030303933313036203030303030206e200a30303030303030303135203030303030206e200a30303030303031363635203030303030206e200a30303030313232393030203030303030206e200a30303030313232363539203030303030206e200a30303030313636383833203030303030206e200a30303030313139383036203030303030206e200a30303030313139353037203030303030206e200a30303030313635393931203030303030206e200a30303030313134393433203030303030206e200a30303030313134363033203030303030206e200a30303030313635323531203030303030206e200a30303030313036363133203030303030206e200a30303030313036303735203030303030206e200a30303030313634343638203030303030206e200a30303030303937323732203030303030206e200a30303030303937333032203030303030206e200a30303030303933323636203030303030206e200a30303030303031363835203030303030206e200a30303030303036323933203030303030206e200a30303030313336313235203030303030206e200a30303030313335373539203030303030206e200a30303030313633373231203030303030206e200a30303030313332333731203030303030206e200a30303030313332303537203030303030206e200a30303030313632393833203030303030206e200a30303030303937333637203030303030206e200a30303030303933343130203030303030206e200a30303030303036333134203030303030206e200a30303030303039373336203030303030206e200a30303030313235323433203030303030206e200a30303030313234363632203030303030206e200a30303030313632313936203030303030206e200a30303030303937343332203030303030206e200a30303030303933353534203030303030206e200a30303030303039373537203030303030206e200a30303030303133393533203030303030206e200a30303030303937343937203030303030206e200a30303030303933363938203030303030206e200a30303030303133393734203030303030206e200a30303030303138343133203030303030206e200a30303030303937353632203030303030206e200a30303030303933383432203030303030206e200a30303030303138343334203030303030206e200a30303030303232303532203030303030206e200a30303030303937363136203030303030206e200a30303030303933393836203030303030206e200a30303030303232303733203030303030206e200a30303030303236343235203030303030206e200a30303030303937373033203030303030206e200a30303030303934313330203030303030206e200a30303030303236343436203030303030206e200a30303030303331343535203030303030206e200a30303030313439313931203030303030206e200a30303030313438383532203030303030206e200a30303030313631343038203030303030206e200a30303030313436323738203030303030206e200a30303030313436303133203030303030206e200a30303030313630373231203030303030206e200a30303030313435343935203030303030206e200a30303030313435323833203030303030206e200a30303030313630303030203030303030206e200a30303030313434343436203030303030206e200a30303030313434323238203030303030206e200a30303030313539353031203030303030206e200a30303030303937373638203030303030206e200a30303030303934323734203030303030206e200a30303030303331343736203030303030206e200a30303030303335393936203030303030206e200a30303030313432343938203030303030206e200a30303030313432323530203030303030206e200a30303030313538373135203030303030206e200a30303030313532383735203030303030206e200a30303030313532353431203030303030206e200a30303030313537393235203030303030206e200a30303030313532313330203030303030206e200a30303030313531393034203030303030206e200a30303030313536383433203030303030206e200a30303030303937383737203030303030206e200a30303030303934343138203030303030206e200a30303030303336303137203030303030206e200a30303030303430323035203030303030206e200a30303030303937393735203030303030206e200a30303030303934353632203030303030206e200a30303030303430323236203030303030206e200a30303030303433373433203030303030206e200a30303030303938303834203030303030206e200a30303030303934373036203030303030206e200a30303030303433373634203030303030206e200a30303030303438303337203030303030206e200a30303030303938323034203030303030206e200a30303030303934383530203030303030206e200a30303030303438303538203030303030206e200a30303030303531323239203030303030206e200a30303030303938323538203030303030206e200a30303030303934393934203030303030206e200a30303030303531323530203030303030206e200a30303030303533363035203030303030206e200a30303030303938333233203030303030206e200a30303030303935313431203030303030206e200a30303030303533363237203030303030206e200a30303030303537333735203030303030206e200a30303030303938333637203030303030206e200a30303030303935323838203030303030206e200a30303030303537333937203030303030206e200a30303030303630383038203030303030206e200a30303030303938343535203030303030206e200a30303030303935343335203030303030206e200a30303030303630383330203030303030206e200a30303030303635333830203030303030206e200a30303030303938353231203030303030206e200a30303030303935353832203030303030206e200a30303030303635343032203030303030206e200a30303030303639313331203030303030206e200a30303030303938353837203030303030206e200a30303030303935373239203030303030206e200a30303030303639313533203030303030206e200a30303030303731323835203030303030206e200a30303030303938363533203030303030206e200a30303030303935383736203030303030206e200a30303030303731333037203030303030206e200a30303030303733303436203030303030206e200a30303030303938373038203030303030206e200a30303030303936303233203030303030206e200a30303030303733303638203030303030206e200a30303030303737323235203030303030206e200a30303030313537373835203030303030206e200a30303030313537383438203030303030206e200a30303030303938373734203030303030206e200a30303030313536343239203030303030206e200a30303030313030303133203030303030206e200a30303030313030323334203030303030206e200a30303030313030343330203030303030206e200a30303030313030343935203030303030206e200a30303030313030373231203030303030206e200a30303030313030393032203030303030206e200a30303030313030393637203030303030206e200a30303030313031313730203030303030206e200a30303030313031323335203030303030206e200a30303030313031343331203030303030206e200a30303030313031363637203030303030206e200a30303030313031383733203030303030206e200a30303030313031393338203030303030206e200a30303030313032303033203030303030206e200a30303030313032313834203030303030206e200a30303030313032323439203030303030206e200a30303030313032343631203030303030206e200a30303030313032353236203030303030206e200a30303030313032353931203030303030206e200a30303030303936313738203030303030206e200a30303030303737323437203030303030206e200a30303030303831313338203030303030206e200a30303030313535393235203030303030206e200a30303030313032363830203030303030206e200a30303030313032393135203030303030206e200a30303030313033313031203030303030206e200a30303030313033313636203030303030206e200a30303030313033343135203030303030206e200a30303030313033343830203030303030206e200a30303030313033363637203030303030206e200a30303030313033373332203030303030206e200a30303030313033393636203030303030206e200a30303030313034303331203030303030206e200a30303030313034323335203030303030206e200a30303030313034343732203030303030206e200a30303030313034353337203030303030206e200a30303030313034363032203030303030206e200a30303030313034363637203030303030206e200a30303030313034373332203030303030206e200a30303030313034393539203030303030206e200a30303030313035313637203030303030206e200a30303030313035323332203030303030206e200a30303030313035343731203030303030206e200a30303030313035353336203030303030206e200a30303030313035363031203030303030206e200a30303030313035363636203030303030206e200a30303030313035373331203030303030206e200a30303030303936333333203030303030206e200a30303030303831313630203030303030206e200a30303030303834393235203030303030206e200a30303030313531353633203030303030206e200a30303030313531333530203030303030206e200a30303030313535373833203030303030206e200a30303030313035373936203030303030206e200a30303030303936343830203030303030206e200a30303030303834393437203030303030206e200a30303030303838313236203030303030206e200a30303030313530373830203030303030206e200a30303030313530353239203030303030206e200a30303030313636373236203030303030206e200a30303030313035393038203030303030206e200a30303030303936363237203030303030206e200a30303030303838313438203030303030206e200a30303030303931323434203030303030206e200a30303030313035393837203030303030206e200a30303030303936373734203030303030206e200a30303030303931323636203030303030206e200a30303030303933303834203030303030206e200a30303030313036303331203030303030206e200a30303030313134353831203030303030206e200a30303030313139343835203030303030206e200a30303030313232363337203030303030206e200a30303030313234363430203030303030206e200a30303030313332303335203030303030206e200a30303030313335373337203030303030206e200a30303030313432323238203030303030206e200a30303030313434323036203030303030206e200a30303030313435323632203030303030206e200a30303030313435393932203030303030206e200a30303030313438383330203030303030206e200a30303030313530353037203030303030206e200a30303030313531333239203030303030206e200a30303030313531383833203030303030206e200a30303030313532353230203030303030206e200a30303030313535373631203030303030206e200a747261696c65720a3c3c202f53697a6520323230202f526f6f74203120302052202f496e666f2032203020520a3e3e0a7374617274787265660a3136373731360a2525454f460a', 1, 'doc', 3);


--
-- TOC entry 2402 (class 0 OID 0)
-- Dependencies: 179
-- Name: documento_id_documento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('documento_id_documento_seq', 34, true);


--
-- TOC entry 2358 (class 0 OID 17049)
-- Dependencies: 220
-- Data for Name: documento_oposicion_hecha; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2403 (class 0 OID 0)
-- Dependencies: 219
-- Name: documento_oposicion_hecha_id_documento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('documento_oposicion_hecha_id_documento_seq', 6, true);


--
-- TOC entry 2318 (class 0 OID 16426)
-- Dependencies: 180
-- Data for Name: estado_marca; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO estado_marca VALUES (5, 'A imprimir acta de registro', NULL);
INSERT INTO estado_marca VALUES (6, 'Abandonada', NULL);
INSERT INTO estado_marca VALUES (8, 'Con observaciones de Forma', NULL);
INSERT INTO estado_marca VALUES (9, 'Con vista a notificar', NULL);
INSERT INTO estado_marca VALUES (10, 'Para dictamenes de marcas', NULL);
INSERT INTO estado_marca VALUES (12, 'En resolucion de concesión', NULL);
INSERT INTO estado_marca VALUES (13, 'En espera plazo oposición', NULL);
INSERT INTO estado_marca VALUES (15, 'Desistida', NULL);
INSERT INTO estado_marca VALUES (16, 'En Apelación en Dirección General', NULL);
INSERT INTO estado_marca VALUES (18, 'En Despacho para Firma', NULL);
INSERT INTO estado_marca VALUES (19, 'Concedida', NULL);
INSERT INTO estado_marca VALUES (14, 'Esperando recurso de rechazo', NULL);
INSERT INTO estado_marca VALUES (20, 'Con rechazo a notificar', NULL);
INSERT INTO estado_marca VALUES (4, 'Con resol. apel. a notificar', NULL);
INSERT INTO estado_marca VALUES (23, 'En espera publicaciones', NULL);
INSERT INTO estado_marca VALUES (17, 'En Asuntos litigiosos', 'O');
INSERT INTO estado_marca VALUES (7, 'Archivada', 'F');
INSERT INTO estado_marca VALUES (25, 'Pase a marcas', 'F');
INSERT INTO estado_marca VALUES (26, 'Caso cerrado', 'F');
INSERT INTO estado_marca VALUES (11, 'Informe de fondo inicial', 'I');
INSERT INTO estado_marca VALUES (24, 'Con observaciones de forma', NULL);


--
-- TOC entry 2404 (class 0 OID 0)
-- Dependencies: 181
-- Name: estado_marca_id_estado_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('estado_marca_id_estado_seq', 26, true);


--
-- TOC entry 2344 (class 0 OID 16794)
-- Dependencies: 206
-- Data for Name: estado_oposicion; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO estado_oposicion VALUES (6, 'Caso cerrado
', 'F');
INSERT INTO estado_oposicion VALUES (5, 'Acusar reb por no cont. trasl. reconst.
', NULL);
INSERT INTO estado_oposicion VALUES (7, 'Contencioso-administrativo
', NULL);
INSERT INTO estado_oposicion VALUES (8, 'Convalidar personería
', NULL);
INSERT INTO estado_oposicion VALUES (9, 'Desistir solicitud
', NULL);
INSERT INTO estado_oposicion VALUES (10, 'Esc. c.p.p.
', NULL);
INSERT INTO estado_oposicion VALUES (11, 'Esc. exp. agravios
', NULL);
INSERT INTO estado_oposicion VALUES (12, 'Not. autos oponente
', NULL);
INSERT INTO estado_oposicion VALUES (13, 'Not. autos solicitante
', NULL);
INSERT INTO estado_oposicion VALUES (14, 'Not. exp. agravios
', NULL);
INSERT INTO estado_oposicion VALUES (15, 'Not. pruebas oponente
', NULL);
INSERT INTO estado_oposicion VALUES (16, 'Not. pruebas solicitante
', NULL);
INSERT INTO estado_oposicion VALUES (17, 'Ofrecer pruebas oponentes
', NULL);
INSERT INTO estado_oposicion VALUES (18, 'Ofrecer pruebas solicitante
', NULL);
INSERT INTO estado_oposicion VALUES (19, 'Pase a marcas
', NULL);
INSERT INTO estado_oposicion VALUES (23, 'Prov. desist. solicitud
', NULL);
INSERT INTO estado_oposicion VALUES (24, 'Prov. desistimiento
', NULL);
INSERT INTO estado_oposicion VALUES (25, 'Prov. exp. agravios
', NULL);
INSERT INTO estado_oposicion VALUES (26, 'Solic. desistimiento
', NULL);
INSERT INTO estado_oposicion VALUES (27, 'Solic. prosecución de trámites
', NULL);
INSERT INTO estado_oposicion VALUES (20, 'Prom. opo.
', NULL);
INSERT INTO estado_oposicion VALUES (21, 'Prov. apertura causa a prueba
', NULL);
INSERT INTO estado_oposicion VALUES (22, 'Prov. autos
', NULL);
INSERT INTO estado_oposicion VALUES (28, 'Providencia de traslado', 'I');
INSERT INTO estado_oposicion VALUES (1, 'A dirección c/ apelación', NULL);
INSERT INTO estado_oposicion VALUES (4, 'Acusar reb por no cont tras
', NULL);


--
-- TOC entry 2405 (class 0 OID 0)
-- Dependencies: 205
-- Name: estado_oposicion_id_estado_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('estado_oposicion_id_estado_seq', 28, true);


--
-- TOC entry 2320 (class 0 OID 16434)
-- Dependencies: 182
-- Data for Name: evento; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO evento VALUES (20, 48, '11/11/2018 19:00 abogado2', '2018-11-11 19:00:00', 'evento', 'ALTA');
INSERT INTO evento VALUES (21, 48, '10/11/2018 00', '2018-11-10 00:00:00', 'evento', 'MEDIA');
INSERT INTO evento VALUES (22, 48, 'sad', '2018-11-10 00:00:00', 'evento', 'BAJA');
INSERT INTO evento VALUES (23, 47, 'sdf', '2018-11-12 00:00:00', 'evento', 'MEDIA');
INSERT INTO evento VALUES (24, 47, 'jh', '2018-11-08 00:00:00', 'jh', 'BAJA');
INSERT INTO evento VALUES (25, 49, 'kj', '2018-11-09 00:00:00', 'evento 5656', 'MEDIA');


--
-- TOC entry 2406 (class 0 OID 0)
-- Dependencies: 183
-- Name: evento_id_evento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('evento_id_evento_seq', 25, true);


--
-- TOC entry 2354 (class 0 OID 17022)
-- Dependencies: 216
-- Data for Name: evento_oposicion_hecha; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO evento_oposicion_hecha VALUES (8, 11, 'Oposicion', 'oposicion', '2018-11-10 03:00:00', 'MEDIA');
INSERT INTO evento_oposicion_hecha VALUES (9, 12, 'Abogado 3', 'Agente3', '2018-11-09 19:00:00', 'BAJA');


--
-- TOC entry 2407 (class 0 OID 0)
-- Dependencies: 215
-- Name: evento_oposicion_hecha_id_evento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('evento_oposicion_hecha_id_evento_seq', 9, true);


--
-- TOC entry 2322 (class 0 OID 16442)
-- Dependencies: 184
-- Data for Name: expediente; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO expediente VALUES (47, 39, 19, 11, 1, 43, 1, '2018-11-08 00:00:00', '2018-11-08 00:00:00', 'sad', 1, NULL, NULL, NULL);
INSERT INTO expediente VALUES (48, 40, 20, 11, 1, 44, 2, '2018-11-08 00:00:00', '2018-11-08 00:00:00', 'sd', 1, NULL, NULL, NULL);
INSERT INTO expediente VALUES (49, 40, 19, 11, 20, 43, 5656, '2018-11-08 00:00:00', '2018-11-08 00:00:00', 'mueble', 1, NULL, NULL, NULL);


--
-- TOC entry 2408 (class 0 OID 0)
-- Dependencies: 185
-- Name: expediente_id_expediente_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('expediente_id_expediente_seq', 49, true);


--
-- TOC entry 2363 (class 0 OID 17117)
-- Dependencies: 225
-- Data for Name: factura_cabecera; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO factura_cabecera VALUES (1, 39, '00:00:00', 'Contado', 'Cheque', 'itau', '4545', NULL, 'Pagado', 1);
INSERT INTO factura_cabecera VALUES (2, 39, '00:00:00', 'Contado', 'Cheque', 'itau', '4545', NULL, 'Pagado', 1);


--
-- TOC entry 2365 (class 0 OID 17134)
-- Dependencies: 227
-- Data for Name: factura_detalle; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO factura_detalle VALUES (1, 1, 1, 'honorario', 1000000, 90909);
INSERT INTO factura_detalle VALUES (2, 2, 1, 'honorario', 1000000, 90909);


--
-- TOC entry 2409 (class 0 OID 0)
-- Dependencies: 226
-- Name: factura_detalle_id_factura_detalle_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('factura_detalle_id_factura_detalle_seq', 2, true);


--
-- TOC entry 2410 (class 0 OID 0)
-- Dependencies: 224
-- Name: factura_id_factura_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('factura_id_factura_seq', 2, true);


--
-- TOC entry 2324 (class 0 OID 16450)
-- Dependencies: 186
-- Data for Name: historial; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2350 (class 0 OID 16965)
-- Dependencies: 212
-- Data for Name: historial_estado_marca; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO historial_estado_marca VALUES (15, 47, 11, '2018-11-08 00:00:00', '2018-11-08 01:29:12.975');
INSERT INTO historial_estado_marca VALUES (16, 48, 11, '2018-11-08 00:00:00', '2018-11-08 01:30:18.692');
INSERT INTO historial_estado_marca VALUES (17, 49, 11, '2018-11-08 00:00:00', '2018-11-08 16:09:25.926');


--
-- TOC entry 2411 (class 0 OID 0)
-- Dependencies: 211
-- Name: historial_estado_marca_id_historial_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('historial_estado_marca_id_historial_seq', 17, true);


--
-- TOC entry 2360 (class 0 OID 17075)
-- Dependencies: 222
-- Data for Name: historial_estado_oposicion_hecha; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO historial_estado_oposicion_hecha VALUES (25, 11, 28, '2018-11-08 00:00:00', '2018-11-08 21:52:01.363');
INSERT INTO historial_estado_oposicion_hecha VALUES (26, 12, 28, '2018-11-08 00:00:00', '2018-11-08 22:57:29.04');


--
-- TOC entry 2412 (class 0 OID 0)
-- Dependencies: 221
-- Name: historial_estado_oposicion_hecha_id_historial_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('historial_estado_oposicion_hecha_id_historial_seq', 26, true);


--
-- TOC entry 2348 (class 0 OID 16941)
-- Dependencies: 210
-- Data for Name: historial_estado_oposicion_recibida; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2413 (class 0 OID 0)
-- Dependencies: 209
-- Name: historial_estado_oposicion_recibida_id_historial_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('historial_estado_oposicion_recibida_id_historial_seq', 45, true);


--
-- TOC entry 2414 (class 0 OID 0)
-- Dependencies: 187
-- Name: historial_id_historial_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('historial_id_historial_seq', 1, false);


--
-- TOC entry 2326 (class 0 OID 16458)
-- Dependencies: 188
-- Data for Name: marca; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO marca VALUES (43, 1, 'marca 1', NULL);
INSERT INTO marca VALUES (44, 1, 'marca 2', NULL);


--
-- TOC entry 2415 (class 0 OID 0)
-- Dependencies: 189
-- Name: marca_id_marca_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('marca_id_marca_seq', 44, true);


--
-- TOC entry 2352 (class 0 OID 16986)
-- Dependencies: 214
-- Data for Name: oposicion_hecha; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO oposicion_hecha VALUES (11, 'OPosicion', 'Oposicion', 5, 4545, 'Oposicion', 19, 47, 28, '2018-11-08 00:00:00', NULL);
INSERT INTO oposicion_hecha VALUES (12, 'OPosicion', 'Prueba', 6, 54, 'OPOdfdf', 21, 49, 28, '2018-11-08 00:00:00', NULL);


--
-- TOC entry 2416 (class 0 OID 0)
-- Dependencies: 213
-- Name: oposicion_hecha_id_oposicion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('oposicion_hecha_id_oposicion_seq', 12, true);


--
-- TOC entry 2346 (class 0 OID 16920)
-- Dependencies: 208
-- Data for Name: oposicion_recibida; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2417 (class 0 OID 0)
-- Dependencies: 207
-- Name: oposicion_recibida_id_oposicion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('oposicion_recibida_id_oposicion_seq', 21, true);


--
-- TOC entry 2328 (class 0 OID 16466)
-- Dependencies: 190
-- Data for Name: pais; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO pais VALUES (1, 'Afganistán', 'AF');
INSERT INTO pais VALUES (3, 'Albania', 'AL');
INSERT INTO pais VALUES (4, 'Alemania', 'DE');
INSERT INTO pais VALUES (5, 'Andorra', 'AD');
INSERT INTO pais VALUES (6, 'Angola', 'AO');
INSERT INTO pais VALUES (7, 'Anguila', 'AI');
INSERT INTO pais VALUES (8, 'Antártida', 'AQ');
INSERT INTO pais VALUES (9, 'Antigua y Barbuda', 'AG');
INSERT INTO pais VALUES (10, 'Antillas Holandesas', 'AN');
INSERT INTO pais VALUES (11, 'Arabia Saudí', 'SA');
INSERT INTO pais VALUES (12, 'Argelia', 'DZ');
INSERT INTO pais VALUES (13, 'Argentina', 'AR');
INSERT INTO pais VALUES (14, 'Armenia', 'AM');
INSERT INTO pais VALUES (15, 'Aruba', 'AW');
INSERT INTO pais VALUES (16, 'Australia', 'AU');
INSERT INTO pais VALUES (17, 'Austria', 'AT');
INSERT INTO pais VALUES (18, 'Azerbaiyán', 'AZ');
INSERT INTO pais VALUES (19, 'Bahamas', 'BS');
INSERT INTO pais VALUES (20, 'Bahréin', 'BH');
INSERT INTO pais VALUES (21, 'Bangladesh', 'BD');
INSERT INTO pais VALUES (22, 'Barbados', 'BB');
INSERT INTO pais VALUES (23, 'Bielorrusia', 'BY');
INSERT INTO pais VALUES (24, 'Bélgica', 'BE');
INSERT INTO pais VALUES (25, 'Belice', 'BZ');
INSERT INTO pais VALUES (26, 'Benin', 'BJ');
INSERT INTO pais VALUES (27, 'Bermudas', 'BM');
INSERT INTO pais VALUES (28, 'Bhután', 'BT');
INSERT INTO pais VALUES (29, 'Bolivia', 'BO');
INSERT INTO pais VALUES (30, 'Bosnia y Herzegovina', 'BA');
INSERT INTO pais VALUES (31, 'Botsuana', 'BW');
INSERT INTO pais VALUES (32, 'Isla Bouvet', 'BV');
INSERT INTO pais VALUES (33, 'Brasil', 'BR');
INSERT INTO pais VALUES (34, 'Brunéi', 'BN');
INSERT INTO pais VALUES (35, 'Bulgaria', 'BG');
INSERT INTO pais VALUES (36, 'Burkina Faso', 'BF');
INSERT INTO pais VALUES (37, 'Burundi', 'BI');
INSERT INTO pais VALUES (38, 'Cabo Verde', 'CV');
INSERT INTO pais VALUES (39, 'Islas Caimán', 'KY');
INSERT INTO pais VALUES (40, 'Camboya', 'KH');
INSERT INTO pais VALUES (41, 'Camerún', 'CM');
INSERT INTO pais VALUES (42, 'Canadá', 'CA');
INSERT INTO pais VALUES (43, 'República Centroafricana', 'CF');
INSERT INTO pais VALUES (44, 'Chad', 'TD');
INSERT INTO pais VALUES (45, 'República Checa', 'CZ');
INSERT INTO pais VALUES (46, 'Chile', 'CL');
INSERT INTO pais VALUES (47, 'China', 'CN');
INSERT INTO pais VALUES (48, 'Chipre', 'CY');
INSERT INTO pais VALUES (49, 'Isla de Navidad', 'CX');
INSERT INTO pais VALUES (50, 'Ciudad del Vaticano', 'VA');
INSERT INTO pais VALUES (51, 'Islas Cocos', 'CC');
INSERT INTO pais VALUES (52, 'Colombia', 'CO');
INSERT INTO pais VALUES (53, 'Comoras', 'KM');
INSERT INTO pais VALUES (54, 'República Democrática del Congo', 'CD');
INSERT INTO pais VALUES (55, 'Congo', 'CG');
INSERT INTO pais VALUES (56, 'Islas Cook', 'CK');
INSERT INTO pais VALUES (57, 'Corea del Norte', 'KP');
INSERT INTO pais VALUES (58, 'Corea del Sur', 'KR');
INSERT INTO pais VALUES (59, 'Costa de Marfil', 'CI');
INSERT INTO pais VALUES (60, 'Costa Rica', 'CR');
INSERT INTO pais VALUES (61, 'Croacia', 'HR');
INSERT INTO pais VALUES (62, 'Cuba', 'CU');
INSERT INTO pais VALUES (63, 'Dinamarca', 'DK');
INSERT INTO pais VALUES (64, 'Dominica', 'DM');
INSERT INTO pais VALUES (65, 'República Dominicana', 'DO');
INSERT INTO pais VALUES (66, 'Ecuador', 'EC');
INSERT INTO pais VALUES (67, 'Egipto', 'EG');
INSERT INTO pais VALUES (68, 'El Salvador', 'SV');
INSERT INTO pais VALUES (69, 'Emiratos Árabes Unidos', 'AE');
INSERT INTO pais VALUES (70, 'Eritrea', 'ER');
INSERT INTO pais VALUES (71, 'Eslovaquia', 'SK');
INSERT INTO pais VALUES (72, 'Eslovenia', 'SI');
INSERT INTO pais VALUES (73, 'España', 'ES');
INSERT INTO pais VALUES (74, 'Islas ultramarinas de Estados Unidos', 'UM');
INSERT INTO pais VALUES (75, 'Estados Unidos', 'US');
INSERT INTO pais VALUES (76, 'Estonia', 'EE');
INSERT INTO pais VALUES (77, 'Etiopía', 'ET');
INSERT INTO pais VALUES (78, 'Islas Feroe', 'FO');
INSERT INTO pais VALUES (79, 'Filipinas', 'PH');
INSERT INTO pais VALUES (80, 'Finlandia', 'FI');
INSERT INTO pais VALUES (81, 'Fiyi', 'FJ');
INSERT INTO pais VALUES (82, 'Francia', 'FR');
INSERT INTO pais VALUES (83, 'Gabón', 'GA');
INSERT INTO pais VALUES (84, 'Gambia', 'GM');
INSERT INTO pais VALUES (85, 'Georgia', 'GE');
INSERT INTO pais VALUES (86, 'Islas Georgias del Sur y Sandwich del Sur', 'GS');
INSERT INTO pais VALUES (87, 'Ghana', 'GH');
INSERT INTO pais VALUES (88, 'Gibraltar', 'GI');
INSERT INTO pais VALUES (89, 'Granada', 'GD');
INSERT INTO pais VALUES (90, 'Grecia', 'GR');
INSERT INTO pais VALUES (91, 'Groenlandia', 'GL');
INSERT INTO pais VALUES (92, 'Guadalupe', 'GP');
INSERT INTO pais VALUES (93, 'Guam', 'GU');
INSERT INTO pais VALUES (94, 'Guatemala', 'GT');
INSERT INTO pais VALUES (95, 'Guayana Francesa', 'GF');
INSERT INTO pais VALUES (96, 'Guinea', 'GN');
INSERT INTO pais VALUES (97, 'Guinea Ecuatorial', 'GQ');
INSERT INTO pais VALUES (98, 'Guinea-Bissau', 'GW');
INSERT INTO pais VALUES (99, 'Guyana', 'GY');
INSERT INTO pais VALUES (100, 'Haití', 'HT');
INSERT INTO pais VALUES (101, 'Islas Heard y McDonald', 'HM');
INSERT INTO pais VALUES (102, 'Honduras', 'HN');
INSERT INTO pais VALUES (103, 'Hong Kong', 'HK');
INSERT INTO pais VALUES (104, 'Hungría', 'HU');
INSERT INTO pais VALUES (105, 'India', 'IN');
INSERT INTO pais VALUES (106, 'Indonesia', 'ID');
INSERT INTO pais VALUES (107, 'Irán', 'IR');
INSERT INTO pais VALUES (108, 'Iraq', 'IQ');
INSERT INTO pais VALUES (109, 'Irlanda', 'IE');
INSERT INTO pais VALUES (110, 'Islandia', 'IS');
INSERT INTO pais VALUES (111, 'Israel', 'IL');
INSERT INTO pais VALUES (112, 'Italia', 'IT');
INSERT INTO pais VALUES (113, 'Jamaica', 'JM');
INSERT INTO pais VALUES (114, 'Japón', 'JP');
INSERT INTO pais VALUES (115, 'Jordania', 'JO');
INSERT INTO pais VALUES (116, 'Kazajstán', 'KZ');
INSERT INTO pais VALUES (117, 'Kenia', 'KE');
INSERT INTO pais VALUES (118, 'Kirguistán', 'KG');
INSERT INTO pais VALUES (119, 'Kiribati', 'KI');
INSERT INTO pais VALUES (120, 'Kuwait', 'KW');
INSERT INTO pais VALUES (121, 'Laos', 'LA');
INSERT INTO pais VALUES (122, 'Lesotho', 'LS');
INSERT INTO pais VALUES (123, 'Letonia', 'LV');
INSERT INTO pais VALUES (124, 'Líbano', 'LB');
INSERT INTO pais VALUES (125, 'Liberia', 'LR');
INSERT INTO pais VALUES (126, 'Libia', 'LY');
INSERT INTO pais VALUES (127, 'Liechtenstein', 'LI');
INSERT INTO pais VALUES (128, 'Lituania', 'LT');
INSERT INTO pais VALUES (129, 'Luxemburgo', 'LU');
INSERT INTO pais VALUES (130, 'Macao', 'MO');
INSERT INTO pais VALUES (131, 'ARY Macedonia', 'MK');
INSERT INTO pais VALUES (132, 'Madagascar', 'MG');
INSERT INTO pais VALUES (133, 'Malasia', 'MY');
INSERT INTO pais VALUES (134, 'Malawi', 'MW');
INSERT INTO pais VALUES (135, 'Maldivas', 'MV');
INSERT INTO pais VALUES (136, 'Malí', 'ML');
INSERT INTO pais VALUES (137, 'Malta', 'MT');
INSERT INTO pais VALUES (138, 'Islas Malvinas', 'FK');
INSERT INTO pais VALUES (139, 'Islas Marianas del Norte', 'MP');
INSERT INTO pais VALUES (140, 'Marruecos', 'MA');
INSERT INTO pais VALUES (141, 'Islas Marshall', 'MH');
INSERT INTO pais VALUES (142, 'Martinica', 'MQ');
INSERT INTO pais VALUES (143, 'Mauricio', 'MU');
INSERT INTO pais VALUES (144, 'Mauritania', 'MR');
INSERT INTO pais VALUES (145, 'Mayotte', 'YT');
INSERT INTO pais VALUES (146, 'México', 'MX');
INSERT INTO pais VALUES (147, 'Micronesia', 'FM');
INSERT INTO pais VALUES (148, 'Moldavia', 'MD');
INSERT INTO pais VALUES (149, 'Mónaco', 'MC');
INSERT INTO pais VALUES (150, 'Mongolia', 'MN');
INSERT INTO pais VALUES (151, 'Montserrat', 'MS');
INSERT INTO pais VALUES (152, 'Mozambique', 'MZ');
INSERT INTO pais VALUES (153, 'Myanmar', 'MM');
INSERT INTO pais VALUES (154, 'Namibia', 'NA');
INSERT INTO pais VALUES (155, 'Nauru', 'NR');
INSERT INTO pais VALUES (156, 'Nepal', 'NP');
INSERT INTO pais VALUES (157, 'Nicaragua', 'NI');
INSERT INTO pais VALUES (158, 'Níger', 'NE');
INSERT INTO pais VALUES (159, 'Nigeria', 'NG');
INSERT INTO pais VALUES (160, 'Niue', 'NU');
INSERT INTO pais VALUES (161, 'Isla Norfolk', 'NF');
INSERT INTO pais VALUES (162, 'Noruega', 'NO');
INSERT INTO pais VALUES (163, 'Nueva Caledonia', 'NC');
INSERT INTO pais VALUES (164, 'Nueva Zelanda', 'NZ');
INSERT INTO pais VALUES (165, 'Omán', 'OM');
INSERT INTO pais VALUES (166, 'Países Bajos', 'NL');
INSERT INTO pais VALUES (167, 'Pakistán', 'PK');
INSERT INTO pais VALUES (168, 'Palau', 'PW');
INSERT INTO pais VALUES (169, 'Palestina', 'PS');
INSERT INTO pais VALUES (170, 'Panamá', 'PA');
INSERT INTO pais VALUES (171, 'Papúa Nueva Guinea', 'PG');
INSERT INTO pais VALUES (172, 'Paraguay', 'PY');
INSERT INTO pais VALUES (173, 'Perú', 'PE');
INSERT INTO pais VALUES (174, 'Islas Pitcairn', 'PN');
INSERT INTO pais VALUES (175, 'Polinesia Francesa', 'PF');
INSERT INTO pais VALUES (176, 'Polonia', 'PL');
INSERT INTO pais VALUES (177, 'Portugal', 'PT');
INSERT INTO pais VALUES (178, 'Puerto Rico', 'PR');
INSERT INTO pais VALUES (179, 'Qatar', 'QA');
INSERT INTO pais VALUES (180, 'Reino Unido', 'GB');
INSERT INTO pais VALUES (181, 'Reunión', 'RE');
INSERT INTO pais VALUES (182, 'Ruanda', 'RW');
INSERT INTO pais VALUES (183, 'Rumania', 'RO');
INSERT INTO pais VALUES (184, 'Rusia', 'RU');
INSERT INTO pais VALUES (185, 'Sahara Occidental', 'EH');
INSERT INTO pais VALUES (186, 'Islas Salomón', 'SB');
INSERT INTO pais VALUES (187, 'Samoa', 'WS');
INSERT INTO pais VALUES (188, 'Samoa Americana', 'AS');
INSERT INTO pais VALUES (189, 'San Cristóbal y Nevis', 'KN');
INSERT INTO pais VALUES (190, 'San Marino', 'SM');
INSERT INTO pais VALUES (191, 'San Pedro y Miquelón', 'PM');
INSERT INTO pais VALUES (192, 'San Vicente y las Granadinas', 'VC');
INSERT INTO pais VALUES (193, 'Santa Helena', 'SH');
INSERT INTO pais VALUES (194, 'Santa Lucía', 'LC');
INSERT INTO pais VALUES (195, 'Santo Tomé y Príncipe', 'ST');
INSERT INTO pais VALUES (196, 'Senegal', 'SN');
INSERT INTO pais VALUES (197, 'Serbia y Montenegro', 'CS');
INSERT INTO pais VALUES (198, 'Seychelles', 'SC');
INSERT INTO pais VALUES (199, 'Sierra Leona', 'SL');
INSERT INTO pais VALUES (200, 'Singapur', 'SG');
INSERT INTO pais VALUES (201, 'Siria', 'SY');
INSERT INTO pais VALUES (202, 'Somalia', 'SO');
INSERT INTO pais VALUES (203, 'Sri Lanka', 'LK');
INSERT INTO pais VALUES (204, 'Suazilandia', 'SZ');
INSERT INTO pais VALUES (205, 'Sudáfrica', 'ZA');
INSERT INTO pais VALUES (206, 'Sudán', 'SD');
INSERT INTO pais VALUES (207, 'Suecia', 'SE');
INSERT INTO pais VALUES (208, 'Suiza', 'CH');
INSERT INTO pais VALUES (209, 'Surinam', 'SR');
INSERT INTO pais VALUES (210, 'Svalbard y Jan Mayen', 'SJ');
INSERT INTO pais VALUES (211, 'Tailandia', 'TH');
INSERT INTO pais VALUES (212, 'Taiwán', 'TW');
INSERT INTO pais VALUES (213, 'Tanzania', 'TZ');
INSERT INTO pais VALUES (214, 'Tayikistán', 'TJ');
INSERT INTO pais VALUES (215, 'Territorio Británico del Océano Índico', 'IO');
INSERT INTO pais VALUES (216, 'Territorios Australes Franceses', 'TF');
INSERT INTO pais VALUES (217, 'Timor Oriental', 'TL');
INSERT INTO pais VALUES (218, 'Togo', 'TG');
INSERT INTO pais VALUES (219, 'Tokelau', 'TK');
INSERT INTO pais VALUES (220, 'Tonga', 'TO');
INSERT INTO pais VALUES (221, 'Trinidad y Tobago', 'TT');
INSERT INTO pais VALUES (222, 'Túnez', 'TN');
INSERT INTO pais VALUES (223, 'Islas Turcas y Caicos', 'TC');
INSERT INTO pais VALUES (224, 'Turkmenistán', 'TM');
INSERT INTO pais VALUES (225, 'Turquía', 'TR');
INSERT INTO pais VALUES (226, 'Tuvalu', 'TV');
INSERT INTO pais VALUES (227, 'Ucrania', 'UA');
INSERT INTO pais VALUES (228, 'Uganda', 'UG');
INSERT INTO pais VALUES (229, 'Uruguay', 'UY');
INSERT INTO pais VALUES (230, 'Uzbekistán', 'UZ');
INSERT INTO pais VALUES (231, 'Vanuatu', 'VU');
INSERT INTO pais VALUES (232, 'Venezuela', 'VE');
INSERT INTO pais VALUES (233, 'Vietnam', 'VN');
INSERT INTO pais VALUES (234, 'Islas Vírgenes Británicas', 'VG');
INSERT INTO pais VALUES (235, 'Islas Vírgenes de los Estados Unidos', 'VI');
INSERT INTO pais VALUES (236, 'Wallis y Futuna', 'WF');
INSERT INTO pais VALUES (237, 'Yemen', 'YE');
INSERT INTO pais VALUES (238, 'Yibuti', 'DJ');
INSERT INTO pais VALUES (239, 'Zambia', 'ZM');
INSERT INTO pais VALUES (240, 'Zimbabue', 'ZW');


--
-- TOC entry 2329 (class 0 OID 16473)
-- Dependencies: 191
-- Data for Name: permiso; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO permiso VALUES (213, 1, 1);
INSERT INTO permiso VALUES (214, 1, 2);
INSERT INTO permiso VALUES (215, 1, 3);
INSERT INTO permiso VALUES (216, 1, 4);
INSERT INTO permiso VALUES (217, 1, 5);
INSERT INTO permiso VALUES (218, 1, 6);
INSERT INTO permiso VALUES (219, 1, 7);
INSERT INTO permiso VALUES (220, 1, 8);
INSERT INTO permiso VALUES (221, 1, 9);
INSERT INTO permiso VALUES (222, 1, 10);
INSERT INTO permiso VALUES (223, 1, 11);
INSERT INTO permiso VALUES (224, 1, 12);
INSERT INTO permiso VALUES (225, 1, 13);
INSERT INTO permiso VALUES (226, 1, 14);
INSERT INTO permiso VALUES (227, 1, 15);
INSERT INTO permiso VALUES (228, 1, 16);
INSERT INTO permiso VALUES (229, 1, 17);
INSERT INTO permiso VALUES (230, 1, 18);
INSERT INTO permiso VALUES (231, 1, 19);
INSERT INTO permiso VALUES (232, 1, 20);
INSERT INTO permiso VALUES (233, 1, 21);
INSERT INTO permiso VALUES (234, 1, 22);
INSERT INTO permiso VALUES (235, 1, 23);
INSERT INTO permiso VALUES (236, 1, 24);
INSERT INTO permiso VALUES (237, 1, 25);
INSERT INTO permiso VALUES (238, 1, 26);
INSERT INTO permiso VALUES (239, 1, 27);
INSERT INTO permiso VALUES (240, 1, 28);
INSERT INTO permiso VALUES (241, 1, 29);
INSERT INTO permiso VALUES (242, 1, 30);
INSERT INTO permiso VALUES (243, 1, 31);
INSERT INTO permiso VALUES (244, 1, 32);
INSERT INTO permiso VALUES (245, 1, 33);
INSERT INTO permiso VALUES (246, 1, 34);
INSERT INTO permiso VALUES (247, 1, 35);
INSERT INTO permiso VALUES (248, 1, 36);
INSERT INTO permiso VALUES (249, 1, 37);
INSERT INTO permiso VALUES (250, 1, 38);
INSERT INTO permiso VALUES (251, 1, 39);
INSERT INTO permiso VALUES (252, 1, 40);
INSERT INTO permiso VALUES (253, 1, 41);
INSERT INTO permiso VALUES (254, 1, 42);
INSERT INTO permiso VALUES (255, 1, 43);
INSERT INTO permiso VALUES (256, 1, 44);
INSERT INTO permiso VALUES (257, 1, 45);
INSERT INTO permiso VALUES (258, 1, 46);
INSERT INTO permiso VALUES (259, 1, 47);
INSERT INTO permiso VALUES (260, 1, 48);
INSERT INTO permiso VALUES (261, 1, 49);
INSERT INTO permiso VALUES (262, 1, 50);
INSERT INTO permiso VALUES (263, 1, 53);
INSERT INTO permiso VALUES (266, 1, 54);
INSERT INTO permiso VALUES (267, 1, 55);
INSERT INTO permiso VALUES (268, 1, 56);
INSERT INTO permiso VALUES (269, 1, 57);
INSERT INTO permiso VALUES (270, 1, 58);
INSERT INTO permiso VALUES (271, 1, 59);
INSERT INTO permiso VALUES (272, 1, 60);
INSERT INTO permiso VALUES (275, 1, 61);
INSERT INTO permiso VALUES (276, 1, 62);
INSERT INTO permiso VALUES (277, 1, 63);
INSERT INTO permiso VALUES (278, 1, 64);
INSERT INTO permiso VALUES (318, 1, 70);
INSERT INTO permiso VALUES (319, 23, 70);
INSERT INTO permiso VALUES (320, 22, 6);
INSERT INTO permiso VALUES (321, 22, 8);
INSERT INTO permiso VALUES (322, 22, 9);
INSERT INTO permiso VALUES (284, 1, 67);
INSERT INTO permiso VALUES (285, 1, 68);
INSERT INTO permiso VALUES (286, 1, 69);
INSERT INTO permiso VALUES (287, 23, 1);
INSERT INTO permiso VALUES (288, 23, 2);
INSERT INTO permiso VALUES (289, 23, 3);
INSERT INTO permiso VALUES (290, 23, 4);
INSERT INTO permiso VALUES (291, 23, 5);
INSERT INTO permiso VALUES (292, 23, 6);
INSERT INTO permiso VALUES (293, 23, 7);
INSERT INTO permiso VALUES (294, 23, 8);
INSERT INTO permiso VALUES (295, 23, 19);
INSERT INTO permiso VALUES (296, 23, 20);
INSERT INTO permiso VALUES (297, 23, 9);
INSERT INTO permiso VALUES (298, 23, 10);
INSERT INTO permiso VALUES (299, 23, 11);
INSERT INTO permiso VALUES (300, 23, 12);
INSERT INTO permiso VALUES (301, 23, 13);
INSERT INTO permiso VALUES (302, 23, 14);
INSERT INTO permiso VALUES (303, 23, 15);
INSERT INTO permiso VALUES (304, 23, 16);
INSERT INTO permiso VALUES (305, 23, 17);
INSERT INTO permiso VALUES (306, 23, 18);
INSERT INTO permiso VALUES (307, 23, 26);
INSERT INTO permiso VALUES (308, 23, 27);
INSERT INTO permiso VALUES (309, 23, 28);
INSERT INTO permiso VALUES (310, 23, 29);
INSERT INTO permiso VALUES (311, 23, 30);
INSERT INTO permiso VALUES (323, 22, 11);
INSERT INTO permiso VALUES (324, 22, 49);
INSERT INTO permiso VALUES (325, 22, 54);
INSERT INTO permiso VALUES (326, 22, 57);
INSERT INTO permiso VALUES (327, 22, 64);
INSERT INTO permiso VALUES (328, 1, 71);
INSERT INTO permiso VALUES (329, 1, 72);
INSERT INTO permiso VALUES (330, 1, 73);


--
-- TOC entry 2418 (class 0 OID 0)
-- Dependencies: 192
-- Name: permiso_id_permiso_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('permiso_id_permiso_seq', 330, true);


--
-- TOC entry 2361 (class 0 OID 17109)
-- Dependencies: 223
-- Data for Name: prefijo; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO prefijo VALUES ('001-001-', '2018-11-09 00:00:00', 50, 2, 1);


--
-- TOC entry 2331 (class 0 OID 16478)
-- Dependencies: 193
-- Data for Name: rol; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO rol VALUES (1, 'Administrador del Sistema', 'Administrador del sistema', 'ASIGNADO');
INSERT INTO rol VALUES (22, 'Cliente', 'cliente', 'ASIGNADO');
INSERT INTO rol VALUES (23, 'Abogado', 'abogado', 'ASIGNADO');


--
-- TOC entry 2419 (class 0 OID 0)
-- Dependencies: 194
-- Name: rol_id_rol_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('rol_id_rol_seq', 23, true);


--
-- TOC entry 2420 (class 0 OID 0)
-- Dependencies: 217
-- Name: tipo_doc_oposicion_hecha_id_tipo_doc_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tipo_doc_oposicion_hecha_id_tipo_doc_seq', 3, true);


--
-- TOC entry 2333 (class 0 OID 16486)
-- Dependencies: 195
-- Data for Name: tipo_documento; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO tipo_documento VALUES (1, 'Informe de Fondo');
INSERT INTO tipo_documento VALUES (2, 'Informe de Forma');
INSERT INTO tipo_documento VALUES (3, 'Acta de registro');
INSERT INTO tipo_documento VALUES (6, 'Dictamen Marca');
INSERT INTO tipo_documento VALUES (5, 'Publicación');
INSERT INTO tipo_documento VALUES (4, 'Orden publicación');
INSERT INTO tipo_documento VALUES (7, 'Hoja Descriptiva');
INSERT INTO tipo_documento VALUES (8, 'Resolución de concesión');
INSERT INTO tipo_documento VALUES (9, 'Escritos');
INSERT INTO tipo_documento VALUES (10, 'Providencias');


--
-- TOC entry 2421 (class 0 OID 0)
-- Dependencies: 196
-- Name: tipo_documento_id_tipo_documento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tipo_documento_id_tipo_documento_seq', 10, true);


--
-- TOC entry 2356 (class 0 OID 17038)
-- Dependencies: 218
-- Data for Name: tipo_documento_oposicion_hecha; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO tipo_documento_oposicion_hecha VALUES (1, 'Resolución de concesión');
INSERT INTO tipo_documento_oposicion_hecha VALUES (2, 'Escritos');
INSERT INTO tipo_documento_oposicion_hecha VALUES (3, 'Providencias');


--
-- TOC entry 2335 (class 0 OID 16494)
-- Dependencies: 197
-- Data for Name: tipo_expediente; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO tipo_expediente VALUES (1, 'Registro de marcas');
INSERT INTO tipo_expediente VALUES (2, 'Renovación de marcas');


--
-- TOC entry 2422 (class 0 OID 0)
-- Dependencies: 198
-- Name: tipo_expediente_id_tipo_expediente_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tipo_expediente_id_tipo_expediente_seq', 2, true);


--
-- TOC entry 2337 (class 0 OID 16502)
-- Dependencies: 199
-- Data for Name: tipo_marca; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO tipo_marca VALUES (1, 'Denominativo');
INSERT INTO tipo_marca VALUES (2, 'Figurativo');
INSERT INTO tipo_marca VALUES (3, 'Mixto');


--
-- TOC entry 2423 (class 0 OID 0)
-- Dependencies: 200
-- Name: tipo_marca_id_tipo_marca_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tipo_marca_id_tipo_marca_seq', 3, true);


--
-- TOC entry 2339 (class 0 OID 16510)
-- Dependencies: 201
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO usuario VALUES (47, 1, 'Adm', '827ccb0eea8a706c4c34a16891f84e7b', 'ACTIVO', NULL);
INSERT INTO usuario VALUES (50, 23, 'abogado1', '6a5b75898f1ab0c79a76e4c59477b241', 'ACTIVO', 'ABOGADO');
INSERT INTO usuario VALUES (51, 23, 'abogado2', '6a5b75898f1ab0c79a76e4c59477b241', 'ACTIVO', 'ABOGADO');
INSERT INTO usuario VALUES (48, 22, 'clientejuridico1', '6a5b75898f1ab0c79a76e4c59477b241', 'ACTIVO', 'CLIENTE');
INSERT INTO usuario VALUES (49, 22, 'clientejuridico2', '6a5b75898f1ab0c79a76e4c59477b241', 'ACTIVO', 'CLIENTE');
INSERT INTO usuario VALUES (52, 23, 'abogado3', '6a5b75898f1ab0c79a76e4c59477b241', 'ACTIVO', 'ABOGADO');


--
-- TOC entry 2424 (class 0 OID 0)
-- Dependencies: 202
-- Name: usuario_id_usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('usuario_id_usuario_seq', 52, true);


--
-- TOC entry 2341 (class 0 OID 16518)
-- Dependencies: 203
-- Data for Name: ventana; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO ventana VALUES (1, 1, NULL, 'Menú Marca', 'marcas.jsp');
INSERT INTO ventana VALUES (6, 1, NULL, 'Menú Expediente', 'expedientes.jsp');
INSERT INTO ventana VALUES (21, 1, NULL, 'Menú Agente', 'abogados.jsp');
INSERT INTO ventana VALUES (26, 1, NULL, 'Menú Titular', 'clientes.jsp');
INSERT INTO ventana VALUES (31, 1, NULL, 'Menú Usuario', 'usuarios.jsp');
INSERT INTO ventana VALUES (36, 1, NULL, 'Menú Rol', 'roles.jsp');
INSERT INTO ventana VALUES (40, 1, NULL, 'Menú Permiso', 'permisos.jsp');
INSERT INTO ventana VALUES (9, 3, 8, 'Menú Documento', 'documentos.jsp');
INSERT INTO ventana VALUES (14, 3, 8, 'Menú Evento', 'eventos.jsp');
INSERT INTO ventana VALUES (22, 2, 21, 'Agregar Agente', 'agregarAbogado.jsp');
INSERT INTO ventana VALUES (23, 2, 21, 'Ver Agente', 'verAbogado.jsp');
INSERT INTO ventana VALUES (24, 2, 21, 'Editar Agente', 'editarAbogado.jsp');
INSERT INTO ventana VALUES (25, 2, 21, 'Eliminar Agente', 'eliminarAbogado');
INSERT INTO ventana VALUES (27, 2, 26, 'Agregar Titular', 'agregarCliente.jsp');
INSERT INTO ventana VALUES (28, 2, 26, 'Ver Titular', 'verCliente.jsp');
INSERT INTO ventana VALUES (29, 2, 26, 'Editar Titular', 'editarCliente.jsp');
INSERT INTO ventana VALUES (30, 2, 26, 'Eliminar Titular', 'eliminarCliente');
INSERT INTO ventana VALUES (10, 4, 9, 'Agregar Documento', 'agregarDocumento.jsp');
INSERT INTO ventana VALUES (11, 4, 9, 'Ver Documento', 'verDocumento.jsp');
INSERT INTO ventana VALUES (12, 4, 9, 'Editar Documento', 'editarDocumento.jsp');
INSERT INTO ventana VALUES (13, 4, 9, 'Eliminar Documento', 'eliminarDocumento');
INSERT INTO ventana VALUES (15, 4, 14, 'Agregar Evento', 'agregarEvento.jsp');
INSERT INTO ventana VALUES (16, 4, 14, 'Ver Evento', 'verEvento.jsp');
INSERT INTO ventana VALUES (17, 4, 14, 'Editar Evento', 'editarEvento.jsp');
INSERT INTO ventana VALUES (18, 4, 14, 'Eliminar Evento', 'eliminarEvento');
INSERT INTO ventana VALUES (7, 2, 6, 'Agregar Expediente', 'agregarExpediente.jsp');
INSERT INTO ventana VALUES (8, 2, 6, 'Ver Expediente', 'verExpediente.jsp');
INSERT INTO ventana VALUES (19, 2, 6, 'Editar Expediente', 'editarExpediente.jsp');
INSERT INTO ventana VALUES (20, 2, 6, 'Eliminar Expediente', 'eliminarExpediente');
INSERT INTO ventana VALUES (2, 2, 1, 'Agregar Marca', 'agregarMarca.jsp');
INSERT INTO ventana VALUES (3, 2, 1, 'Ver Marca', 'verMarca.jsp');
INSERT INTO ventana VALUES (4, 2, 1, 'Editar Marca', 'editarMarca.jsp');
INSERT INTO ventana VALUES (5, 2, 1, 'Eliminar Marca', 'eliminarMarca');
INSERT INTO ventana VALUES (42, 2, 40, 'Ver Permiso', 'verPermiso.jsp');
INSERT INTO ventana VALUES (41, 2, 40, 'Editar Permiso', 'editarPermiso.jsp');
INSERT INTO ventana VALUES (37, 2, 36, 'Agregar Rol', 'agregarRol.jsp');
INSERT INTO ventana VALUES (38, 2, 36, 'Editar Rol', 'editarRol.jsp');
INSERT INTO ventana VALUES (39, 2, 36, 'Eliminar Rol', 'eliminarRol');
INSERT INTO ventana VALUES (32, 2, 31, 'Agregar Usuario', 'agregarUsuario.jsp');
INSERT INTO ventana VALUES (33, 2, 31, 'Ver Usuario', 'verUsuario.jsp');
INSERT INTO ventana VALUES (34, 2, 31, 'Editar Usuario', 'editarUsuario.jsp');
INSERT INTO ventana VALUES (35, 2, 31, 'Eliminar Usuario', 'eliminarUsuario');
INSERT INTO ventana VALUES (43, 2, 36, 'Ver Rol', 'verRol.jsp');
INSERT INTO ventana VALUES (44, 3, 8, 'Oposiciones Recibidas', 'oposicionesRecibidas.jsp');
INSERT INTO ventana VALUES (45, 4, 44, 'Agregar oposición recibida', 'agregarOposicionRecibida.jsp');
INSERT INTO ventana VALUES (46, 4, 44, 'Ver oposición recibida', 'verOposicionRecibida.jsp');
INSERT INTO ventana VALUES (47, 4, 44, 'Editar oposición recibida', 'editarOposicionRecibida.jsp');
INSERT INTO ventana VALUES (48, 4, 44, 'Eliminar oposicion recibida', 'eliminarOposicionRecibida');
INSERT INTO ventana VALUES (49, 1, NULL, 'Menú Oposiciones Hechas', 'oposicionesHechas.jsp');
INSERT INTO ventana VALUES (50, 1, NULL, 'Configuraciones', 'configuraciones.jsp');
INSERT INTO ventana VALUES (53, 49, NULL, 'Agregar Oposiciones Hechas', 'agregarOposicionHecha.jsp');
INSERT INTO ventana VALUES (54, 49, NULL, 'Ver Oposiciones Hechas', 'verOposicionHecha.jsp');
INSERT INTO ventana VALUES (55, 49, NULL, 'Editar Oposicion Hecha', 'editarOposicionHecha.jsp');
INSERT INTO ventana VALUES (56, 49, NULL, 'Eliminar Oposicion Hecha', 'eliminarOposicionHecha');
INSERT INTO ventana VALUES (57, 54, NULL, 'Menu Documento Oposiciones Hechas', 'documentosOposicionesHechas.jsp');
INSERT INTO ventana VALUES (58, 54, NULL, 'Menu Evento Oposiciones Hechas', 'eventosOposicionesHechas.jsp');
INSERT INTO ventana VALUES (59, 58, NULL, 'Agregar Evento OH', 'agregarEventoOposicionHecha.jsp');
INSERT INTO ventana VALUES (60, 58, NULL, 'Ver Evento de Oposiciones H', 'verEventoOposicionHecha.jsp');
INSERT INTO ventana VALUES (61, 58, NULL, 'Editar Evento Oposiciones Hechas', 'editarEventoOposicionHecha.jsp');
INSERT INTO ventana VALUES (62, 58, NULL, 'Eliminar Evento Oposicion Hechas', 'eliminarEventoOposicionHecha');
INSERT INTO ventana VALUES (63, 54, NULL, 'Agregar Doc', 'agregarDocumentoOposicionHecha.jsp');
INSERT INTO ventana VALUES (64, 54, NULL, 'Ver doc', 'verDocumentoOposicionHecha.jsp');
INSERT INTO ventana VALUES (68, 54, NULL, 'Eliminar', 'eliminarDocumentoOposicionHecha');
INSERT INTO ventana VALUES (67, 54, NULL, 'Editar doc', 'editarDocumentoOposicionHecha.jsp');
INSERT INTO ventana VALUES (69, 1, NULL, 'Menú Facturación', 'facturaciones.jsp');
INSERT INTO ventana VALUES (70, 1, NULL, 'notificaciones', 'notificaciones.jsp');
INSERT INTO ventana VALUES (72, 69, NULL, 'verFactura', 'verFactura.jsp');
INSERT INTO ventana VALUES (73, 69, NULL, 'anularFactura', 'anularFactura.jsp');
INSERT INTO ventana VALUES (71, 69, NULL, 'agregar factura', 'agregarFactura.jsp');


--
-- TOC entry 2425 (class 0 OID 0)
-- Dependencies: 204
-- Name: ventana_id_ventana_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('ventana_id_ventana_seq', 73, true);


--
-- TOC entry 2097 (class 2606 OID 16542)
-- Name: abogado_ci_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY abogado
    ADD CONSTRAINT abogado_ci_key UNIQUE (ci);


--
-- TOC entry 2099 (class 2606 OID 16544)
-- Name: abogado_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY abogado
    ADD CONSTRAINT abogado_pkey PRIMARY KEY (id_abogado);


--
-- TOC entry 2101 (class 2606 OID 16716)
-- Name: clase_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY clase
    ADD CONSTRAINT clase_pkey PRIMARY KEY (nro_clase);


--
-- TOC entry 2103 (class 2606 OID 16548)
-- Name: cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (id_cliente);


--
-- TOC entry 2159 (class 2606 OID 17057)
-- Name: documento_oposicion_hecha_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY documento_oposicion_hecha
    ADD CONSTRAINT documento_oposicion_hecha_pkey PRIMARY KEY (id_documento);


--
-- TOC entry 2109 (class 2606 OID 16550)
-- Name: documento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY documento
    ADD CONSTRAINT documento_pkey PRIMARY KEY (id_documento);


--
-- TOC entry 2111 (class 2606 OID 16552)
-- Name: estado_marca_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY estado_marca
    ADD CONSTRAINT estado_marca_pkey PRIMARY KEY (id_estado);


--
-- TOC entry 2145 (class 2606 OID 16802)
-- Name: estado_oposicion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY estado_oposicion
    ADD CONSTRAINT estado_oposicion_pkey PRIMARY KEY (id_estado);


--
-- TOC entry 2155 (class 2606 OID 17030)
-- Name: evento_oposicion_hecha_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY evento_oposicion_hecha
    ADD CONSTRAINT evento_oposicion_hecha_pkey PRIMARY KEY (id_evento);


--
-- TOC entry 2113 (class 2606 OID 16554)
-- Name: evento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY evento
    ADD CONSTRAINT evento_pkey PRIMARY KEY (id_evento);


--
-- TOC entry 2115 (class 2606 OID 16556)
-- Name: expediente_nro_expediente_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY expediente
    ADD CONSTRAINT expediente_nro_expediente_key UNIQUE (nro_expediente);


--
-- TOC entry 2117 (class 2606 OID 16558)
-- Name: expediente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY expediente
    ADD CONSTRAINT expediente_pkey PRIMARY KEY (id_expediente);


--
-- TOC entry 2167 (class 2606 OID 17142)
-- Name: factura_detalle_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY factura_detalle
    ADD CONSTRAINT factura_detalle_pkey PRIMARY KEY (id_factura_detalle);


--
-- TOC entry 2165 (class 2606 OID 17122)
-- Name: factura_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY factura_cabecera
    ADD CONSTRAINT factura_pkey PRIMARY KEY (id_factura);


--
-- TOC entry 2151 (class 2606 OID 16970)
-- Name: historial_estado_marca_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY historial_estado_marca
    ADD CONSTRAINT historial_estado_marca_pkey PRIMARY KEY (id_historial);


--
-- TOC entry 2161 (class 2606 OID 17080)
-- Name: historial_estado_oposicion_hecha_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY historial_estado_oposicion_hecha
    ADD CONSTRAINT historial_estado_oposicion_hecha_pkey PRIMARY KEY (id_historial);


--
-- TOC entry 2149 (class 2606 OID 16946)
-- Name: historial_estado_oposicion_recibida_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY historial_estado_oposicion_recibida
    ADD CONSTRAINT historial_estado_oposicion_recibida_pkey PRIMARY KEY (id_historial);


--
-- TOC entry 2121 (class 2606 OID 16560)
-- Name: historial_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY historial
    ADD CONSTRAINT historial_pkey PRIMARY KEY (id_historial);


--
-- TOC entry 2123 (class 2606 OID 16562)
-- Name: marca_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY marca
    ADD CONSTRAINT marca_pkey PRIMARY KEY (id_marca);


--
-- TOC entry 2153 (class 2606 OID 16994)
-- Name: oposicion_hecha_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY oposicion_hecha
    ADD CONSTRAINT oposicion_hecha_pkey PRIMARY KEY (id_oposicion);


--
-- TOC entry 2147 (class 2606 OID 16928)
-- Name: oposicion_recibida_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY oposicion_recibida
    ADD CONSTRAINT oposicion_recibida_pkey PRIMARY KEY (id_oposicion);


--
-- TOC entry 2125 (class 2606 OID 16684)
-- Name: pais_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY pais
    ADD CONSTRAINT pais_pkey PRIMARY KEY (id_pais);


--
-- TOC entry 2127 (class 2606 OID 16566)
-- Name: permiso_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY permiso
    ADD CONSTRAINT permiso_pkey PRIMARY KEY (id_permiso);


--
-- TOC entry 2163 (class 2606 OID 17113)
-- Name: prefijo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY prefijo
    ADD CONSTRAINT prefijo_pkey PRIMARY KEY (prefijo);


--
-- TOC entry 2105 (class 2606 OID 16568)
-- Name: restriccion_ci_unico; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cliente
    ADD CONSTRAINT restriccion_ci_unico UNIQUE (ci);


--
-- TOC entry 2107 (class 2606 OID 16570)
-- Name: restriccion_ruc_unico; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cliente
    ADD CONSTRAINT restriccion_ruc_unico UNIQUE (ruc);


--
-- TOC entry 2129 (class 2606 OID 16572)
-- Name: rol_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY rol
    ADD CONSTRAINT rol_pkey PRIMARY KEY (id_rol);


--
-- TOC entry 2131 (class 2606 OID 16574)
-- Name: rol_rol_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY rol
    ADD CONSTRAINT rol_rol_key UNIQUE (rol);


--
-- TOC entry 2157 (class 2606 OID 17046)
-- Name: tipo_doc_oposicion_hecha_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipo_documento_oposicion_hecha
    ADD CONSTRAINT tipo_doc_oposicion_hecha_pkey PRIMARY KEY (id_tipo_documento);


--
-- TOC entry 2133 (class 2606 OID 16576)
-- Name: tipo_documento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipo_documento
    ADD CONSTRAINT tipo_documento_pkey PRIMARY KEY (id_tipo_documento);


--
-- TOC entry 2135 (class 2606 OID 16578)
-- Name: tipo_expediente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipo_expediente
    ADD CONSTRAINT tipo_expediente_pkey PRIMARY KEY (id_tipo_expediente);


--
-- TOC entry 2137 (class 2606 OID 16580)
-- Name: tipo_marca_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipo_marca
    ADD CONSTRAINT tipo_marca_pkey PRIMARY KEY (id_tipo_marca);


--
-- TOC entry 2119 (class 2606 OID 16700)
-- Name: unico_titular_clase_marca; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY expediente
    ADD CONSTRAINT unico_titular_clase_marca UNIQUE (id_cliente, id_marca, nro_clase);


--
-- TOC entry 2139 (class 2606 OID 16584)
-- Name: usuario_cuenta_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT usuario_cuenta_key UNIQUE (cuenta);


--
-- TOC entry 2141 (class 2606 OID 16586)
-- Name: usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id_usuario);


--
-- TOC entry 2143 (class 2606 OID 16588)
-- Name: ventana_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ventana
    ADD CONSTRAINT ventana_pkey PRIMARY KEY (id_ventana);


--
-- TOC entry 2168 (class 2606 OID 16589)
-- Name: abogado_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY abogado
    ADD CONSTRAINT abogado_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario);


--
-- TOC entry 2170 (class 2606 OID 16692)
-- Name: cliente_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cliente
    ADD CONSTRAINT cliente_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES pais(id_pais);


--
-- TOC entry 2169 (class 2606 OID 16594)
-- Name: cliente_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cliente
    ADD CONSTRAINT cliente_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario);


--
-- TOC entry 2171 (class 2606 OID 16599)
-- Name: documento_id_expediente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY documento
    ADD CONSTRAINT documento_id_expediente_fkey FOREIGN KEY (id_expediente) REFERENCES expediente(id_expediente);


--
-- TOC entry 2172 (class 2606 OID 16604)
-- Name: documento_id_tipo_documento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY documento
    ADD CONSTRAINT documento_id_tipo_documento_fkey FOREIGN KEY (id_tipo_documento) REFERENCES tipo_documento(id_tipo_documento);


--
-- TOC entry 2196 (class 2606 OID 17058)
-- Name: documento_oposicion_hecha_id_oposicion_hecha_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY documento_oposicion_hecha
    ADD CONSTRAINT documento_oposicion_hecha_id_oposicion_hecha_fkey FOREIGN KEY (id_oposicion_hecha) REFERENCES oposicion_hecha(id_oposicion);


--
-- TOC entry 2197 (class 2606 OID 17063)
-- Name: documento_oposicion_hecha_id_tipo_documento_oposicion_hech_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY documento_oposicion_hecha
    ADD CONSTRAINT documento_oposicion_hecha_id_tipo_documento_oposicion_hech_fkey FOREIGN KEY (id_tipo_documento_oposicion_hecha) REFERENCES tipo_documento_oposicion_hecha(id_tipo_documento);


--
-- TOC entry 2173 (class 2606 OID 16609)
-- Name: evento_id_expediente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY evento
    ADD CONSTRAINT evento_id_expediente_fkey FOREIGN KEY (id_expediente) REFERENCES expediente(id_expediente);


--
-- TOC entry 2195 (class 2606 OID 17031)
-- Name: evento_oposicion_hecha_id_oposicion_hecha_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY evento_oposicion_hecha
    ADD CONSTRAINT evento_oposicion_hecha_id_oposicion_hecha_fkey FOREIGN KEY (id_oposicion_hecha) REFERENCES oposicion_hecha(id_oposicion);


--
-- TOC entry 2174 (class 2606 OID 16614)
-- Name: expediente_id_abogado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expediente
    ADD CONSTRAINT expediente_id_abogado_fkey FOREIGN KEY (id_abogado) REFERENCES abogado(id_abogado);


--
-- TOC entry 2175 (class 2606 OID 16619)
-- Name: expediente_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expediente
    ADD CONSTRAINT expediente_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente);


--
-- TOC entry 2176 (class 2606 OID 16624)
-- Name: expediente_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expediente
    ADD CONSTRAINT expediente_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES estado_marca(id_estado);


--
-- TOC entry 2177 (class 2606 OID 16629)
-- Name: expediente_id_marca_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expediente
    ADD CONSTRAINT expediente_id_marca_fkey FOREIGN KEY (id_marca) REFERENCES marca(id_marca);


--
-- TOC entry 2178 (class 2606 OID 16634)
-- Name: expediente_id_tipo_expediente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expediente
    ADD CONSTRAINT expediente_id_tipo_expediente_fkey FOREIGN KEY (tipo_expediente) REFERENCES tipo_expediente(id_tipo_expediente);


--
-- TOC entry 2179 (class 2606 OID 16717)
-- Name: expediente_nro_clase_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expediente
    ADD CONSTRAINT expediente_nro_clase_fkey FOREIGN KEY (nro_clase) REFERENCES clase(nro_clase);


--
-- TOC entry 2201 (class 2606 OID 17143)
-- Name: factura_detalle_id_factura_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY factura_detalle
    ADD CONSTRAINT factura_detalle_id_factura_fkey FOREIGN KEY (id_factura) REFERENCES factura_cabecera(id_factura);


--
-- TOC entry 2200 (class 2606 OID 17123)
-- Name: factura_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY factura_cabecera
    ADD CONSTRAINT factura_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente);


--
-- TOC entry 2186 (class 2606 OID 16929)
-- Name: fk_oposicion_recibida_id_estado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY oposicion_recibida
    ADD CONSTRAINT fk_oposicion_recibida_id_estado FOREIGN KEY (id_estado) REFERENCES estado_oposicion(id_estado);


--
-- TOC entry 2187 (class 2606 OID 16934)
-- Name: fk_oposicion_recibida_id_expediente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY oposicion_recibida
    ADD CONSTRAINT fk_oposicion_recibida_id_expediente FOREIGN KEY (id_expediente) REFERENCES expediente(id_expediente);


--
-- TOC entry 2191 (class 2606 OID 16976)
-- Name: historial_estado_marca_id_estado_marca_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY historial_estado_marca
    ADD CONSTRAINT historial_estado_marca_id_estado_marca_fkey FOREIGN KEY (id_estado_marca) REFERENCES estado_marca(id_estado);


--
-- TOC entry 2190 (class 2606 OID 16971)
-- Name: historial_estado_marca_id_expediente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY historial_estado_marca
    ADD CONSTRAINT historial_estado_marca_id_expediente_fkey FOREIGN KEY (id_expediente) REFERENCES expediente(id_expediente);


--
-- TOC entry 2199 (class 2606 OID 17086)
-- Name: historial_estado_oposicion_hecha_id_estado_oposicion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY historial_estado_oposicion_hecha
    ADD CONSTRAINT historial_estado_oposicion_hecha_id_estado_oposicion_fkey FOREIGN KEY (id_estado_oposicion) REFERENCES estado_oposicion(id_estado);


--
-- TOC entry 2198 (class 2606 OID 17081)
-- Name: historial_estado_oposicion_hecha_id_oposicion_hecha_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY historial_estado_oposicion_hecha
    ADD CONSTRAINT historial_estado_oposicion_hecha_id_oposicion_hecha_fkey FOREIGN KEY (id_oposicion_hecha) REFERENCES oposicion_hecha(id_oposicion);


--
-- TOC entry 2188 (class 2606 OID 16947)
-- Name: historial_estado_oposicion_recibida_id_estado_oposicion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY historial_estado_oposicion_recibida
    ADD CONSTRAINT historial_estado_oposicion_recibida_id_estado_oposicion_fkey FOREIGN KEY (id_estado_oposicion) REFERENCES estado_oposicion(id_estado);


--
-- TOC entry 2189 (class 2606 OID 16952)
-- Name: historial_estado_oposicion_recibida_id_oposicion_recibida_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY historial_estado_oposicion_recibida
    ADD CONSTRAINT historial_estado_oposicion_recibida_id_oposicion_recibida_fkey FOREIGN KEY (id_oposicion_recibida) REFERENCES oposicion_recibida(id_oposicion);


--
-- TOC entry 2180 (class 2606 OID 16644)
-- Name: historial_id_abogado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY historial
    ADD CONSTRAINT historial_id_abogado_fkey FOREIGN KEY (id_abogado) REFERENCES abogado(id_abogado);


--
-- TOC entry 2181 (class 2606 OID 16649)
-- Name: historial_id_expediente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY historial
    ADD CONSTRAINT historial_id_expediente_fkey FOREIGN KEY (id_expediente) REFERENCES expediente(id_expediente);


--
-- TOC entry 2182 (class 2606 OID 16659)
-- Name: marca_id_tipo_marca_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY marca
    ADD CONSTRAINT marca_id_tipo_marca_fkey FOREIGN KEY (id_tipo_marca) REFERENCES tipo_marca(id_tipo_marca);


--
-- TOC entry 2192 (class 2606 OID 17015)
-- Name: oposicion_hecha_id_abogado_opositante_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY oposicion_hecha
    ADD CONSTRAINT oposicion_hecha_id_abogado_opositante_fkey FOREIGN KEY (id_abogado_opositante) REFERENCES abogado(id_abogado);


--
-- TOC entry 2193 (class 2606 OID 17068)
-- Name: oposicion_hecha_id_estado_oposicion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY oposicion_hecha
    ADD CONSTRAINT oposicion_hecha_id_estado_oposicion_fkey FOREIGN KEY (id_estado_oposicion) REFERENCES estado_oposicion(id_estado);


--
-- TOC entry 2194 (class 2606 OID 17096)
-- Name: oposicion_hecha_id_expediente_opositante_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY oposicion_hecha
    ADD CONSTRAINT oposicion_hecha_id_expediente_opositante_fkey FOREIGN KEY (id_expediente_opositante) REFERENCES expediente(id_expediente);


--
-- TOC entry 2183 (class 2606 OID 16664)
-- Name: permiso_id_rol_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY permiso
    ADD CONSTRAINT permiso_id_rol_fkey FOREIGN KEY (id_rol) REFERENCES rol(id_rol);


--
-- TOC entry 2184 (class 2606 OID 16669)
-- Name: permiso_id_ventana_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY permiso
    ADD CONSTRAINT permiso_id_ventana_fkey FOREIGN KEY (id_ventana) REFERENCES ventana(id_ventana);


--
-- TOC entry 2185 (class 2606 OID 16674)
-- Name: usuario_id_rol_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT usuario_id_rol_fkey FOREIGN KEY (id_rol) REFERENCES rol(id_rol);


--
-- TOC entry 2372 (class 0 OID 0)
-- Dependencies: 7
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2018-11-09 18:08:40

--
-- PostgreSQL database dump complete
--

