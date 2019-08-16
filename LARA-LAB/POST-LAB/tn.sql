--
-- PostgreSQL database dump
--

-- Dumped from database version 11.3
-- Dumped by pg_dump version 11.3

-- Started on 2019-08-13 11:44:14 BRT

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
-- TOC entry 1330 (class 1255 OID 14562659)
-- Name: get_criterio_final(bigint, bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_criterio_final(p_emp bigint, p_ser bigint, p_tur bigint) RETURNS SETOF record
 LANGUAGE plpgsql
 AS $$
DECLARE
 var_id_turma BIGINT;
 criterio_final RECORD;
BEGIN
 var_id_turma := NULL;

 SELECT id_sge_turma INTO var_id_turma FROM sge_criterio_final WHERE id_bas_empresa = p_emp AND id_sge_turma = p_tur LIMIT 1;
 
 IF var_id_turma IS NOT NULL THEN
 /*
 RETURN QUERY 
 SELECT 
 des.*,
 tde.nome
 FROM sge_serie_desconto AS des
 INNER JOIN sgf_tipo_desconto tde ON des.id_sgf_tipo_desconto = tde.id
 WHERE des.id_bas_empresa = p_emp AND des.id_sge_turma = p_tur;
*/
FOR criterio_final IN
 SELECT 
 *
 FROM sge_criterio_final AS cri
 WHERE cri.id_bas_empresa = p_emp AND cri.id_sge_turma = p_tur
LOOP
 RETURN NEXT criterio_final;
END LOOP;

 ELSE
 /*
 RETURN QUERY 
 SELECT 
 des.*,
 tde.nome
 FROM sge_serie_desconto AS des
 INNER JOIN sgf_tipo_desconto tde ON des.id_sgf_tipo_desconto = tde.id
 WHERE des.id_bas_empresa = p_emp AND des.id_sge_serie = p_ser;
 */
 FOR criterio_final IN 
 SELECT 
 *
 FROM sge_criterio_final AS cri
 WHERE cri.id_bas_empresa = p_emp AND cri.id_sge_serie = p_ser AND cri.id_sge_turma IS NULL
LOOP 
 RETURN NEXT criterio_final;
END LOOP;
 END IF;
END;
$$;


ALTER FUNCTION public.get_criterio_final(p_emp bigint, p_ser bigint, p_tur bigint) OWNER TO postgres;

--
-- TOC entry 1331 (class 1255 OID 14562660)
-- Name: get_disciplinas(bigint, bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_disciplinas(p_emp bigint, p_ser bigint, p_tur bigint) RETURNS SETOF record
 LANGUAGE plpgsql
 AS $$
DECLARE
 var_id_turma BIGINT;
 disciplinas record;
 
BEGIN
 var_id_turma := NULL;

 SELECT id_sge_turma INTO var_id_turma FROM sge_grade WHERE id_bas_empresa = p_emp AND id_sge_turma = p_tur LIMIT 1;
 
 IF var_id_turma IS NOT NULL THEN

 FOR disciplinas IN 
 SELECT gra.id AS id_sge_grade, 
 grd.optativa AS optativa,
 grd.id_sge_modulo AS id_sge_modulo,
 dis.id AS id_sge_disciplina, 
 dis.nome AS nome_disciplina,
 dis.sigla AS sigla
 FROM sge_grade AS gra
 INNER JOIN sge_grade_disciplina grd ON grd.id_bas_empresa = gra.id_bas_empresa AND gra.id = grd.id_sge_grade
 INNER JOIN sge_disciplina dis ON dis.id = grd.id_sge_disciplina
 WHERE gra.id_bas_empresa = p_emp AND gra.id_sge_turma = p_tur
 LOOP
 RETURN NEXT disciplinas;
 END LOOP;
 
 ELSE
 
 FOR disciplinas IN 
 SELECT gra.id AS id_sge_grade, 
 grd.optativa AS optativa,
 grd.id_sge_modulo AS id_sge_modulo,
 dis.id AS id_sge_disciplina, 
 dis.nome AS nome_disciplina,
 dis.sigla AS sigla
 FROM sge_grade AS gra
 INNER JOIN sge_grade_disciplina grd ON grd.id_bas_empresa = gra.id_bas_empresa AND gra.id = grd.id_sge_grade
 INNER JOIN sge_disciplina dis ON dis.id = grd.id_sge_disciplina
 WHERE gra.id_bas_empresa = p_emp AND gra.id_sge_serie = p_ser
LOOP
 RETURN NEXT disciplinas;
END LOOP;
 END IF;
END;
$$;


ALTER FUNCTION public.get_disciplinas(p_emp bigint, p_ser bigint, p_tur bigint) OWNER TO postgres;

--
-- TOC entry 1332 (class 1255 OID 14562661)
-- Name: get_disciplinas_8_3(bigint, bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_disciplinas_8_3(p_emp bigint, p_ser bigint, p_tur bigint) RETURNS SETOF record
 LANGUAGE plpgsql
 AS $$
DECLARE
 var_id_turma BIGINT;
BEGIN
 var_id_turma := NULL;

 SELECT id_sge_turma INTO var_id_turma FROM sge_grade WHERE id_bas_empresa = p_emp AND id_sge_turma = p_tur LIMIT 1;
 
 IF var_id_turma IS NOT NULL THEN
 RETURN QUERY 
 SELECT gra.id AS id_sge_grade, 
 grd.optativa AS optativa,
 grd.id_sge_modulo AS id_sge_modulo,
 dis.id AS id_sge_disciplina, 
 dis.nome AS nome_disciplina,
 dis.sigla AS sigla
 FROM sge_grade AS gra
 INNER JOIN sge_grade_disciplina grd ON grd.id_bas_empresa = gra.id_bas_empresa AND gra.id = grd.id_sge_grade
 INNER JOIN sge_disciplina dis ON dis.id = grd.id_sge_disciplina
 WHERE gra.id_bas_empresa = p_emp AND gra.id_sge_turma = p_tur;
 
 ELSE
 RETURN QUERY 
 SELECT gra.id AS id_sge_grade, 
 grd.optativa AS optativa,
 grd.id_sge_modulo AS id_sge_modulo,
 dis.id AS id_sge_disciplina, 
 dis.nome AS nome_disciplina,
 dis.sigla AS sigla
 FROM sge_grade AS gra
 INNER JOIN sge_grade_disciplina grd ON grd.id_bas_empresa = gra.id_bas_empresa AND gra.id = grd.id_sge_grade
 INNER JOIN sge_disciplina dis ON dis.id = grd.id_sge_disciplina
 WHERE gra.id_bas_empresa = p_emp AND gra.id_sge_serie = p_ser;
 END IF;
END;
$$;


ALTER FUNCTION public.get_disciplinas_8_3(p_emp bigint, p_ser bigint, p_tur bigint) OWNER TO postgres;

--
-- TOC entry 1351 (class 1255 OID 14562662)
-- Name: get_disciplinas_ano(bigint, bigint, bigint, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_disciplinas_ano(p_emp bigint, p_ser bigint, p_tur bigint, p_ano integer) RETURNS SETOF record
 LANGUAGE plpgsql
 AS $$
DECLARE
 var_id_turma BIGINT;
 disciplinas record;
 
BEGIN
 var_id_turma := NULL;

 SELECT id_sge_turma INTO var_id_turma FROM sge_grade WHERE id_bas_empresa = p_emp AND id_sge_turma = p_tur AND ano = p_ano LIMIT 1;
 
 IF var_id_turma IS NOT NULL THEN

 FOR disciplinas IN 
 SELECT gra.id AS id_sge_grade, 
 grd.optativa AS optativa,
 grd.id_sge_modulo AS id_sge_modulo,
 dis.id AS id_sge_disciplina, 
 dis.nome AS nome_disciplina,
 dis.sigla AS sigla,
 max(gra.ano) AS ano
 FROM sge_grade AS gra
 INNER JOIN sge_grade_disciplina grd ON grd.id_bas_empresa = gra.id_bas_empresa AND gra.id = grd.id_sge_grade
 INNER JOIN sge_disciplina dis ON dis.id = grd.id_sge_disciplina
 WHERE gra.id_bas_empresa = p_emp AND gra.id_sge_turma = p_tur AND gra.ano = p_ano
 GROUP BY gra.id, grd.optativa, grd.id_sge_modulo, dis.id, dis.nome, dis.sigla, gra.ano
 LOOP
 RETURN NEXT disciplinas;
 END LOOP;
 
 ELSE
 
 FOR disciplinas IN 
 SELECT gra.id AS id_sge_grade, 
 grd.optativa AS optativa,
 grd.id_sge_modulo AS id_sge_modulo,
 dis.id AS id_sge_disciplina, 
 dis.nome AS nome_disciplina,
 dis.sigla AS sigla,
 max(gra.ano) AS ano
 FROM sge_grade AS gra
 INNER JOIN sge_grade_disciplina grd ON grd.id_bas_empresa = gra.id_bas_empresa AND gra.id = grd.id_sge_grade
 INNER JOIN sge_disciplina dis ON dis.id = grd.id_sge_disciplina
 WHERE gra.id_bas_empresa = p_emp AND gra.id_sge_serie = p_ser AND gra.ano = p_ano
 GROUP BY gra.id, grd.optativa, grd.id_sge_modulo, dis.id, dis.nome, dis.sigla, gra.ano
LOOP
 RETURN NEXT disciplinas;
END LOOP;
 END IF;
END;
$$;


ALTER FUNCTION public.get_disciplinas_ano(p_emp bigint, p_ser bigint, p_tur bigint, p_ano integer) OWNER TO postgres;

--
-- TOC entry 1333 (class 1255 OID 14562663)
-- Name: get_disciplinas_criterio(bigint, bigint, bigint, date); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_disciplinas_criterio(p_emp bigint, p_ser bigint, p_tur bigint, p_data date) RETURNS SETOF record
 LANGUAGE plpgsql
 AS $$
DECLARE
 var_id_turma BIGINT;
BEGIN
 var_id_turma := NULL;

 SELECT id_sge_turma INTO var_id_turma FROM sge_grade WHERE id_bas_empresa = p_emp AND id_sge_turma = p_tur LIMIT 1;
 
 IF var_id_turma IS NOT NULL THEN
 RETURN QUERY 
 SELECT gra.id AS id_sge_grade, 
 grd.optativa AS optativa,
 grd.id_sge_modulo AS id_sge_modulo,
 dis.id AS id_sge_disciplina, 
 dis.nome AS nome_disciplina,
 dis.sigla AS sigla,
 grd.id_sge_criterio_final
 FROM sge_grade AS gra
 INNER JOIN sge_grade_disciplina grd ON grd.id_bas_empresa = gra.id_bas_empresa AND gra.id = grd.id_sge_grade
 INNER JOIN sge_disciplina dis ON dis.id = grd.id_sge_disciplina
 INNER JOIN sge_criterio_grade_disciplina cgd ON grd.id_bas_empresa = cgd.id_bas_empresa AND
 grd.id_sge_grade = cgd.id_sge_grade AND grd.id_sge_disciplina = cgd.id_sge_disciplina
 AND cgd.data_inicio = (SELECT data_inicio FROM sge_criterio_grade_disciplina WHERE id_bas_empresa = p_emp AND data_inicio >= p_data)
 WHERE gra.id_bas_empresa = p_emp AND gra.id_sge_turma = p_tur;
 
 ELSE
 RETURN QUERY 
 SELECT gra.id AS id_sge_grade, 
 grd.optativa AS optativa,
 grd.id_sge_modulo AS id_sge_modulo,
 dis.id AS id_sge_disciplina, 
 dis.nome AS nome_disciplina,
 dis.sigla AS sigla,
 cgd.id_sge_criterio_final
 FROM sge_grade AS gra
 INNER JOIN sge_grade_disciplina grd ON grd.id_bas_empresa = gra.id_bas_empresa AND gra.id = grd.id_sge_grade
 INNER JOIN sge_disciplina dis ON dis.id = grd.id_sge_disciplina
 INNER JOIN sge_criterio_grade_disciplina cgd ON grd.id_bas_empresa = cgd.id_bas_empresa AND
 grd.id_sge_grade = cgd.id_sge_grade AND grd.id_sge_disciplina = cgd.id_sge_disciplina
 AND cgd.data_inicio = (SELECT data_inicio FROM sge_criterio_grade_disciplina WHERE id_bas_empresa = p_emp AND data_inicio >= p_data)
 WHERE gra.id_bas_empresa = p_emp AND gra.id_sge_serie = p_ser;
 END IF;
END;
$$;


ALTER FUNCTION public.get_disciplinas_criterio(p_emp bigint, p_ser bigint, p_tur bigint, p_data date) OWNER TO postgres;

--
-- TOC entry 1334 (class 1255 OID 14562664)
-- Name: get_disciplinas_pai_ano(bigint, bigint, bigint, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_disciplinas_pai_ano(p_emp bigint, p_ser bigint, p_tur bigint, p_ano integer) RETURNS SETOF record
 LANGUAGE plpgsql
 AS $$
DECLARE

 var_id_turma BIGINT;

 disciplinas record;

BEGIN

 var_id_turma := NULL;

 SELECT id_sge_turma INTO var_id_turma FROM sge_grade WHERE id_bas_empresa = p_emp AND id_sge_turma = p_tur LIMIT 1;

 IF var_id_turma IS NOT NULL THEN

 FOR disciplinas IN 

 SELECT gra.id AS id_sge_grade, 
 grd.optativa AS optativa,
 grd.id_sge_modulo AS id_sge_modulo,
 dis.id AS id_sge_disciplina, 
 dis.nome AS nome_disciplina,
 dis.sigla AS sigla,
 max(gra.ano) AS ano, 
 dis_pai.nome AS nome_disciplina_pai,
 dis_pai.sigla AS sigla_disciplina_pai

 FROM sge_grade AS gra

 INNER JOIN sge_grade_disciplina grd ON grd.id_bas_empresa = gra.id_bas_empresa AND gra.id = grd.id_sge_grade
 INNER JOIN sge_disciplina dis ON dis.id = grd.id_sge_disciplina
 LEFT JOIN sge_disciplina dis_pai ON dis_pai.id = grd.id_sge_disciplina_pai

 WHERE gra.id_bas_empresa = p_emp 
 AND gra.id_sge_turma = p_tur 
 AND gra.ano <= p_ano
 AND grd.quadro = 'S'
 AND grd.recebe_nota = 'S'

 GROUP BY gra.id, grd.optativa, grd.id_sge_modulo, dis.id, dis.nome, dis.sigla, gra.ano
 , dis_pai.nome , dis_pai.sigla

 LOOP

 RETURN NEXT disciplinas;

 END LOOP;

 ELSE

 FOR disciplinas IN 

 SELECT gra.id AS id_sge_grade, 
 grd.optativa AS optativa,
 grd.id_sge_modulo AS id_sge_modulo,
 dis.id AS id_sge_disciplina, 
 dis.nome AS nome_disciplina,
 dis.sigla AS sigla,
 max(gra.ano) AS ano,
 dis_pai.nome AS nome_disciplina_pai,
 dis_pai.sigla AS sigla_disciplina_pai

 FROM sge_grade AS gra 

 INNER JOIN sge_grade_disciplina grd ON grd.id_bas_empresa = gra.id_bas_empresa AND gra.id = grd.id_sge_grade
 INNER JOIN sge_disciplina dis ON dis.id = grd.id_sge_disciplina
 LEFT JOIN sge_disciplina dis_pai ON dis_pai.id = grd.id_sge_disciplina_pai

 WHERE gra.id_bas_empresa = p_emp 
 AND gra.id_sge_serie = p_ser 
 AND gra.ano <= p_ano
 AND grd.quadro = 'S'
 AND grd.recebe_nota = 'S'

 GROUP BY gra.id, grd.optativa, grd.id_sge_modulo, dis.id, dis.nome, dis.sigla, gra.ano, dis_pai.nome, dis_pai.sigla

LOOP

 RETURN NEXT disciplinas;

END LOOP;

 END IF;

END;
$$;


ALTER FUNCTION public.get_disciplinas_pai_ano(p_emp bigint, p_ser bigint, p_tur bigint, p_ano integer) OWNER TO postgres;

--
-- TOC entry 1335 (class 1255 OID 14562665)
-- Name: get_documentos(bigint, bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_documentos(p_emp bigint, p_ser bigint, p_tur bigint) RETURNS SETOF record
 LANGUAGE plpgsql
 AS $$
DECLARE
 var_id_turma BIGINT;
 documentos RECORD;
BEGIN
 var_id_turma := NULL;
 SELECT id_sge_turma INTO var_id_turma FROM sge_serie_documento WHERE id_bas_empresa = p_emp AND id_sge_turma = p_tur LIMIT 1;
 
 
 IF var_id_turma IS NOT NULL THEN

 FOR documentos IN 
 SELECT 
 sge_tipo_documento.id AS id, 
 sge_tipo_documento.nome AS nome, 
 sge_tipo_documento.reaproveitavel AS reaproveitavel, 
 sge_serie_documento.quantidade AS quantidade, 
 sge_serie_documento.obrigatorio AS obrigatorio,
 sge_serie_documento.id_bas_empresa AS id_bas_empresa
 FROM sge_serie_documento 
 INNER JOIN sge_tipo_documento ON 
 sge_tipo_documento.id_bas_empresa = sge_serie_documento.id_bas_empresa AND 
 sge_tipo_documento.id = sge_serie_documento.id_sge_tipo_documento 
 WHERE sge_serie_documento.id_bas_empresa = p_emp AND sge_serie_documento.id_sge_turma = p_tur
 LOOP
 RETURN NEXT documentos;
 END LOOP;
 
 ELSE
 FOR documentos IN
 SELECT 
 sge_tipo_documento.id as id, 
 sge_tipo_documento.nome as nome, 
 sge_tipo_documento.reaproveitavel as reaproveitavel, 
 sge_serie_documento.quantidade as quantidade, 
 sge_serie_documento.obrigatorio as obrigatorio,
 sge_serie_documento.id_bas_empresa as id_bas_empresa 
 FROM sge_serie_documento 
 INNER JOIN sge_tipo_documento ON 
 sge_tipo_documento.id_bas_empresa = sge_serie_documento.id_bas_empresa AND 
 sge_tipo_documento.id = sge_serie_documento.id_sge_tipo_documento 
 WHERE sge_serie_documento.id_bas_empresa = p_emp AND sge_serie_documento.id_sge_serie = p_ser
LOOP
 RETURN NEXT documentos;
END LOOP;
END IF;
END;
$$;


ALTER FUNCTION public.get_documentos(p_emp bigint, p_ser bigint, p_tur bigint) OWNER TO postgres;

--
-- TOC entry 1337 (class 1255 OID 14562666)
-- Name: get_documentos_8.3(bigint, bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."get_documentos_8.3"(p_emp bigint, p_ser bigint, p_tur bigint) RETURNS SETOF record
 LANGUAGE plpgsql
 AS $$
DECLARE
 var_id_turma BIGINT;
BEGIN
 var_id_turma := NULL;
 SELECT id INTO var_id_turma FROM sge_serie_documento WHERE id_bas_empresa = p_emp AND id_sge_turma = p_tur LIMIT 1;
 
 
 IF var_id_turma IS NOT NULL THEN
 RETURN QUERY SELECT sge_tipo_documento.id, sge_tipo_documento.nome, sge_tipo_documento.reaproveitavel, sge_serie_documento.quantidade, sge_serie_documento.obrigatorio 
 FROM sge_serie_documento 
 INNER JOIN sge_tipo_documento ON sge_tipo_documento.id_bas_empresa = sge_serie_documento.id_bas_empresa AND 
 sge_tipo_documento.id = sge_serie_documento.id_sge_tipo_documento 
 WHERE sge_serie_documento.id_bas_empresa = p_emp AND sge_serie_documento.id_sge_turma = p_tur;
 
 ELSE
 RETURN QUERY SELECT sge_tipo_documento.id, sge_tipo_documento.nome, sge_tipo_documento.reaproveitavel, sge_serie_documento.quantidade, sge_serie_documento.obrigatorio 
 FROM sge_serie_documento 
 INNER JOIN sge_tipo_documento ON sge_tipo_documento.id_bas_empresa = sge_serie_documento.id_bas_empresa AND 
 sge_tipo_documento.id = sge_serie_documento.id_sge_tipo_documento 
 WHERE sge_serie_documento.id_bas_empresa = p_emp AND sge_serie_documento.id_sge_serie = p_ser;
 END IF;
END;
$$;


ALTER FUNCTION public."get_documentos_8.3"(p_emp bigint, p_ser bigint, p_tur bigint) OWNER TO postgres;

--
-- TOC entry 1338 (class 1255 OID 14562667)
-- Name: get_documentos_ano(bigint, bigint, bigint, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_documentos_ano(p_emp bigint, p_ser bigint, p_tur bigint, p_ano smallint) RETURNS SETOF record
 LANGUAGE plpgsql
 AS $$
DECLARE
 var_id_turma BIGINT;
 documentos RECORD;
BEGIN
 var_id_turma := NULL;
 SELECT id_sge_turma INTO var_id_turma FROM sge_serie_documento WHERE id_bas_empresa = p_emp AND id_sge_turma = p_tur AND ano_letivo = p_ano LIMIT 1;

 IF var_id_turma IS NOT NULL THEN

 FOR documentos IN 
 SELECT 
 sge_tipo_documento.id AS id, 
 sge_tipo_documento.nome AS nome, 
 sge_tipo_documento.reaproveitavel AS reaproveitavel, 
 sge_serie_documento.quantidade AS quantidade, 
 sge_serie_documento.obrigatorio AS obrigatorio,
 sge_serie_documento.id_bas_empresa AS id_bas_empresa
 FROM sge_serie_documento 
 INNER JOIN sge_tipo_documento ON 
 sge_tipo_documento.id_bas_empresa = sge_serie_documento.id_bas_empresa AND 
 sge_tipo_documento.id = sge_serie_documento.id_sge_tipo_documento 
 WHERE sge_serie_documento.id_bas_empresa = p_emp AND sge_serie_documento.id_sge_turma = p_tur AND sge_serie_documento.ano_letivo = p_ano
 LOOP
 RETURN NEXT documentos;
 END LOOP;

 ELSE
 FOR documentos IN
 SELECT 
 sge_tipo_documento.id as id, 
 sge_tipo_documento.nome as nome, 
 sge_tipo_documento.reaproveitavel as reaproveitavel, 
 sge_serie_documento.quantidade as quantidade, 
 sge_serie_documento.obrigatorio as obrigatorio,
 sge_serie_documento.id_bas_empresa as id_bas_empresa 
 FROM sge_serie_documento 
 INNER JOIN sge_tipo_documento ON 
 sge_tipo_documento.id_bas_empresa = sge_serie_documento.id_bas_empresa AND 
 sge_tipo_documento.id = sge_serie_documento.id_sge_tipo_documento 
 WHERE sge_serie_documento.id_bas_empresa = p_emp AND sge_serie_documento.id_sge_serie = p_ser AND sge_serie_documento.ano_letivo = p_ano
LOOP
 RETURN NEXT documentos;
END LOOP;
END IF;
END;
$$;


ALTER FUNCTION public.get_documentos_ano(p_emp bigint, p_ser bigint, p_tur bigint, p_ano smallint) OWNER TO postgres;

--
-- TOC entry 1339 (class 1255 OID 14562668)
-- Name: get_professores_disponiveis(bigint, bigint, bigint, integer, time without time zone, time without time zone); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_professores_disponiveis(p_emp bigint, p_tur bigint, p_dis bigint, p_dia integer, p_inicio time without time zone, p_fim time without time zone) RETURNS SETOF record
 LANGUAGE plpgsql
 AS $$
DECLARE

professores_disponiveis RECORD;

BEGIN

/*
RETURN QUERY
SELECT 
 DISTINCT pro.id AS id_sge_professor, 
 pes.nome AS nome,
 pdt.id AS id_sge_professor_disciplina_turma
 
FROM 
 sge_professor AS pro

INNER JOIN bas_colaborador AS col ON pro.id = col.id
INNER JOIN bas_pessoa AS pes ON col.id_bas_pessoa = pes.id
INNER JOIN sge_professor_disciplina_turma AS pdt ON pro.id = pdt.id_sge_professor
INNER JOIN sge_disciplina AS dis ON dis.id = pdt.id_sge_disciplina
INNER JOIN sge_turma AS tur ON tur.id = pdt.id_sge_turma
LEFT JOIN sge_grade_horario AS gdh ON pdt.id = gdh.id_sge_professor_disciplina_turma
LEFT JOIN sge_faixa_horario_item AS fhi ON fhi.id = gdh.id_sge_faixa_horario_item

WHERE 
 pro.id_bas_empresa = p_emp AND
 pdt.id_sge_turma = p_tur AND
 pdt.id_sge_disciplina = p_dis AND
 pro.id NOT IN(
 
 SELECT 
 pro.id 
 FROM 
 sge_professor as pro 

 INNER JOIN sge_professor_disciplina_turma AS pdt ON pro.id = pdt.id_sge_professor
 INNER JOIN sge_disciplina AS dis ON dis.id = pdt.id_sge_disciplina
 INNER JOIN sge_turma AS tur ON tur.id = pdt.id_sge_turma
 INNER JOIN sge_grade_horario AS gdh ON pdt.id = gdh.id_sge_professor_disciplina_turma
 INNER JOIN sge_faixa_horario_item AS fai ON gdh.id_sge_faixa_horario_item = fai.id
 
 WHERE 
 gdh.dia_semana = p_dia AND 
 (
 (fai.hora_inicial <= p_inicio) AND
 (fai.hora_final >= p_inicio) OR
 (fai.hora_inicial >= p_inicio) AND
 (fai.hora_inicial <= p_fim)
 )
 );
*/

FOR professores_disponiveis IN
 SELECT 
 DISTINCT pro.id AS id_sge_professor, 
 pes.nome AS nome,
 pdt.id AS id_sge_professor_disciplina_turma
 
 FROM 
 sge_professor AS pro

 INNER JOIN bas_colaborador AS col ON pro.id = col.id
 INNER JOIN bas_pessoa AS pes ON col.id_bas_pessoa = pes.id
 INNER JOIN sge_professor_disciplina_turma AS pdt ON pro.id = pdt.id_sge_professor
 INNER JOIN sge_disciplina AS dis ON dis.id = pdt.id_sge_disciplina
 INNER JOIN sge_turma AS tur ON tur.id = pdt.id_sge_turma
 LEFT JOIN sge_grade_horario AS gdh ON pdt.id = gdh.id_sge_professor_disciplina_turma
 LEFT JOIN sge_faixa_horario_item AS fhi ON fhi.id = gdh.id_sge_faixa_horario_item

 WHERE 
 pro.id_bas_empresa = p_emp AND
 pdt.id_sge_turma = p_tur AND
 pdt.id_sge_disciplina = p_dis AND
 pro.id NOT IN(
 
 SELECT 
 pro.id 
 FROM 
 sge_professor as pro 

 INNER JOIN sge_professor_disciplina_turma AS pdt ON pro.id = pdt.id_sge_professor
 INNER JOIN sge_disciplina AS dis ON dis.id = pdt.id_sge_disciplina
 INNER JOIN sge_turma AS tur ON tur.id = pdt.id_sge_turma
 INNER JOIN sge_grade_horario AS gdh ON pdt.id = gdh.id_sge_professor_disciplina_turma
 INNER JOIN sge_faixa_horario_item AS fai ON gdh.id_sge_faixa_horario_item = fai.id
 
 WHERE 
 gdh.dia_semana = p_dia AND 
 (
 (fai.hora_inicial <= p_inicio) AND
 (fai.hora_final >= p_inicio) OR
 (fai.hora_inicial >= p_inicio) AND
 (fai.hora_inicial <= p_fim)
 )
 )
LOOP
 RETURN NEXT professores_disponiveis;
END LOOP;
END;
$$;


ALTER FUNCTION public.get_professores_disponiveis(p_emp bigint, p_tur bigint, p_dis bigint, p_dia integer, p_inicio time without time zone, p_fim time without time zone) OWNER TO postgres;

--
-- TOC entry 1340 (class 1255 OID 14562669)
-- Name: get_professores_disponiveis_8.3(bigint, bigint, bigint, integer, time without time zone, time without time zone); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."get_professores_disponiveis_8.3"(p_emp bigint, p_tur bigint, p_dis bigint, p_dia integer, p_inicio time without time zone, p_fim time without time zone) RETURNS SETOF record
 LANGUAGE plpgsql
 AS $$
DECLARE


BEGIN

RETURN QUERY
SELECT 
 DISTINCT pro.id AS id_sge_professor, 
 pes.nome AS nome,
 pdt.id AS id_sge_professor_disciplina_turma
 
FROM 
 sge_professor AS pro

INNER JOIN bas_colaborador AS col ON pro.id = col.id
INNER JOIN bas_pessoa AS pes ON col.id_bas_pessoa = pes.id
INNER JOIN sge_professor_disciplina_turma AS pdt ON pro.id = pdt.id_sge_professor
INNER JOIN sge_disciplina AS dis ON dis.id = pdt.id_sge_disciplina
INNER JOIN sge_turma AS tur ON tur.id = pdt.id_sge_turma
LEFT JOIN sge_grade_horario AS gdh ON pdt.id = gdh.id_sge_professor_disciplina_turma
LEFT JOIN sge_faixa_horario_item AS fhi ON fhi.id = gdh.id_sge_faixa_horario_item

WHERE 
 pro.id_bas_empresa = p_emp AND
 pdt.id_sge_turma = p_tur AND
 pdt.id_sge_disciplina = p_dis AND
 pro.id NOT IN(
 
 SELECT 
 pro.id 
 FROM 
 sge_professor as pro 

 INNER JOIN sge_professor_disciplina_turma AS pdt ON pro.id = pdt.id_sge_professor
 INNER JOIN sge_disciplina AS dis ON dis.id = pdt.id_sge_disciplina
 INNER JOIN sge_turma AS tur ON tur.id = pdt.id_sge_turma
 INNER JOIN sge_grade_horario AS gdh ON pdt.id = gdh.id_sge_professor_disciplina_turma
 INNER JOIN sge_faixa_horario_item AS fai ON gdh.id_sge_faixa_horario_item = fai.id
 
 WHERE 
 gdh.dia_semana = p_dia AND 
 (
 (fai.hora_inicial <= p_inicio) AND
 (fai.hora_final >= p_inicio) OR
 (fai.hora_inicial >= p_inicio) AND
 (fai.hora_inicial <= p_fim)
 )
 );

END;
$$;


ALTER FUNCTION public."get_professores_disponiveis_8.3"(p_emp bigint, p_tur bigint, p_dis bigint, p_dia integer, p_inicio time without time zone, p_fim time without time zone) OWNER TO postgres;

--
-- TOC entry 1341 (class 1255 OID 14562670)
-- Name: get_serie_descontos(bigint, bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_serie_descontos(p_emp bigint, p_ser bigint, p_tur bigint) RETURNS SETOF record
 LANGUAGE plpgsql
 AS $$
DECLARE
 var_id_turma BIGINT;
 serie_descontos RECORD;
BEGIN
 var_id_turma := NULL;

 SELECT id_sge_turma INTO var_id_turma FROM sge_serie_desconto WHERE id_bas_empresa = p_emp AND id_sge_turma = p_tur LIMIT 1;
 
 IF var_id_turma IS NOT NULL THEN
 /*
 RETURN QUERY 
 SELECT 
 des.*,
 tde.nome
 FROM sge_serie_desconto AS des
 INNER JOIN sgf_tipo_desconto tde ON des.id_sgf_tipo_desconto = tde.id
 WHERE des.id_bas_empresa = p_emp AND des.id_sge_turma = p_tur;
*/
FOR serie_descontos IN
 SELECT 
 des.*,
 tde.nome
 FROM sge_serie_desconto AS des
 INNER JOIN sgf_tipo_desconto tde ON des.id_sgf_tipo_desconto = tde.id
 WHERE des.id_bas_empresa = p_emp AND des.id_sge_turma = p_tur
LOOP
 RETURN NEXT serie_descontos;
END LOOP;

 ELSE
 /*
 RETURN QUERY 
 SELECT 
 des.*,
 tde.nome
 FROM sge_serie_desconto AS des
 INNER JOIN sgf_tipo_desconto tde ON des.id_sgf_tipo_desconto = tde.id
 WHERE des.id_bas_empresa = p_emp AND des.id_sge_serie = p_ser;
 */
 FOR serie_descontos IN 
 SELECT 
 des.*,
 tde.nome
 FROM sge_serie_desconto AS des
 INNER JOIN sgf_tipo_desconto tde ON des.id_sgf_tipo_desconto = tde.id
 WHERE des.id_bas_empresa = p_emp AND des.id_sge_serie = p_ser
LOOP 
 RETURN NEXT serie_descontos;
END LOOP;
 END IF;
END;
$$;


ALTER FUNCTION public.get_serie_descontos(p_emp bigint, p_ser bigint, p_tur bigint) OWNER TO postgres;

--
-- TOC entry 1342 (class 1255 OID 14562671)
-- Name: get_serie_descontos_8.3(bigint, bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."get_serie_descontos_8.3"(p_emp bigint, p_ser bigint, p_tur bigint) RETURNS SETOF record
 LANGUAGE plpgsql
 AS $$
DECLARE
 var_id_turma BIGINT;
BEGIN
 var_id_turma := NULL;

 SELECT id_sge_turma INTO var_id_turma FROM sge_serie_desconto WHERE id_bas_empresa = p_emp AND id_sge_turma = p_tur LIMIT 1;
 
 IF var_id_turma IS NOT NULL THEN
 RETURN QUERY 
 SELECT 
 des.*,
 tde.nome
 FROM sge_serie_desconto AS des
 INNER JOIN sgf_tipo_desconto tde ON des.id_sgf_tipo_desconto = tde.id
 WHERE des.id_bas_empresa = p_emp AND des.id_sge_turma = p_tur;

 ELSE
 RETURN QUERY 
 SELECT 
 des.*,
 tde.nome
 FROM sge_serie_desconto AS des
 INNER JOIN sgf_tipo_desconto tde ON des.id_sgf_tipo_desconto = tde.id
 WHERE des.id_bas_empresa = p_emp AND des.id_sge_serie = p_ser;
 END IF;
END;
$$;


ALTER FUNCTION public."get_serie_descontos_8.3"(p_emp bigint, p_ser bigint, p_tur bigint) OWNER TO postgres;

--
-- TOC entry 1336 (class 1255 OID 14562672)
-- Name: get_serie_plano_pagamento(bigint, bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_serie_plano_pagamento(p_emp bigint, p_ser bigint, p_tur bigint) RETURNS SETOF record
 LANGUAGE plpgsql
 AS $$
DECLARE
 var_id_turma BIGINT;
 serie_plano_pagamento RECORD;
BEGIN
 var_id_turma := NULL;

 SELECT id_sge_turma INTO var_id_turma FROM sge_serie_plano_pagamento WHERE id_bas_empresa = p_emp AND id_sge_turma = p_tur LIMIT 1;
 
 IF var_id_turma IS NOT NULL THEN
 /*
 RETURN QUERY 
 SELECT 
 spp.id_bas_empresa AS id_bas_empresa,
 spp.id_sge_serie AS id_sge_serie,
 spp.id_sge_turma AS id_sge_turma,
 spp.id AS id_sgf_plano_pagamento,
 ppa.nome AS plano_pagamento_nome,
 ppa.ano AS plano_pagamento_ano
 ---ppp.id AS id_sgf_plano_pagamento_parcela,
 ---ppp.numero_parcela AS numero_parcela,
 ---ppp.valor AS valor
 FROM sge_serie_plano_pagamento AS spp
 INNER JOIN sgf_plano_pagamento ppa ON spp.id_sgf_plano_pagamento = ppa.id
 ---INNER JOIN sgf_plano_pagamento_parcela ppp ON ppa.id = ppp.id_sgf_plano_pagamento 
 WHERE spp.id_bas_empresa = p_emp AND spp.id_sge_turma = p_tur;
 */
 FOR serie_plano_pagamento IN
 SELECT 
 spp.id_bas_empresa AS id_bas_empresa,
 spp.id_sge_serie AS id_sge_serie,
 spp.id_sge_turma AS id_sge_turma,
 ppa.id AS id_sgf_plano_pagamento,
 ppa.nome AS plano_pagamento_nome,
 ppa.ano AS plano_pagamento_ano
 ---ppp.id AS id_sgf_plano_pagamento_parcela,
 ---ppp.numero_parcela AS numero_parcela,
 ---ppp.valor AS valor
 FROM sge_serie_plano_pagamento AS spp
 INNER JOIN sgf_plano_pagamento ppa ON spp.id_sgf_plano_pagamento = ppa.id
 ---INNER JOIN sgf_plano_pagamento_parcela ppp ON ppa.id = ppp.id_sgf_plano_pagamento 
 WHERE spp.id_bas_empresa = p_emp AND spp.id_sge_turma = p_tur
 LOOP
 RETURN NEXT serie_plano_pagamento;
END LOOP;
 ELSE
 /*
 RETURN QUERY 
 SELECT 
 spp.id_bas_empresa AS id_bas_empresa,
 spp.id_sge_serie AS id_sge_serie,
 spp.id_sge_turma AS id_sge_turma,
 spp.id AS id_sgf_plano_pagamento,
 ppa.nome AS plano_pagamento_nome,
 ppa.ano AS plano_pagamento_ano
 ---ppp.id AS id_sgf_plano_pagamento_parcela,
 ---ppp.numero_parcela AS numero_parcela,
 ---ppp.valor AS valor
 FROM sge_serie_plano_pagamento AS spp
 INNER JOIN sgf_plano_pagamento ppa ON spp.id_sgf_plano_pagamento = ppa.id
 ---INNER JOIN sgf_plano_pagamento_parcela ppp ON ppa.id = ppp.id_sgf_plano_pagamento 
 WHERE spp.id_bas_empresa = p_emp AND spp.id_sge_serie = p_ser;
*/
FOR serie_plano_pagamento IN

 SELECT 
 spp.id_bas_empresa AS id_bas_empresa,
 spp.id_sge_serie AS id_sge_serie,
 spp.id_sge_turma AS id_sge_turma,
 ppa.id AS id_sgf_plano_pagamento,
 ppa.nome AS plano_pagamento_nome,
 ppa.ano AS plano_pagamento_ano
 ---ppp.id AS id_sgf_plano_pagamento_parcela,
 ---ppp.numero_parcela AS numero_parcela,
 ---ppp.valor AS valor
 FROM sge_serie_plano_pagamento AS spp
 INNER JOIN sgf_plano_pagamento ppa ON spp.id_sgf_plano_pagamento = ppa.id
 ---INNER JOIN sgf_plano_pagamento_parcela ppp ON ppa.id = ppp.id_sgf_plano_pagamento 
 WHERE spp.id_bas_empresa = p_emp AND spp.id_sge_serie = p_ser
 
LOOP
 RETURN NEXT serie_plano_pagamento;
END LOOP;
 END IF;
END;
$$;


ALTER FUNCTION public.get_serie_plano_pagamento(p_emp bigint, p_ser bigint, p_tur bigint) OWNER TO postgres;

--
-- TOC entry 1343 (class 1255 OID 14562673)
-- Name: get_serie_plano_pagamento_8.3(bigint, bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."get_serie_plano_pagamento_8.3"(p_emp bigint, p_ser bigint, p_tur bigint) RETURNS SETOF record
 LANGUAGE plpgsql
 AS $$
DECLARE
 var_id_turma BIGINT;
BEGIN
 var_id_turma := NULL;

 SELECT id_sge_turma INTO var_id_turma FROM sge_serie_plano_pagamento WHERE id_bas_empresa = p_emp AND id_sge_turma = p_tur LIMIT 1;
 
 IF var_id_turma IS NOT NULL THEN
 RETURN QUERY 
 SELECT 
 spp.id_bas_empresa AS id_bas_empresa,
 spp.id_sge_serie AS id_sge_serie,
 spp.id_sge_turma AS id_sge_turma,
 spp.id AS id_sgf_plano_pagamento,
 ppa.nome AS plano_pagamento_nome,
 ppa.ano AS plano_pagamento_ano
 ---ppp.id AS id_sgf_plano_pagamento_parcela,
 ---ppp.numero_parcela AS numero_parcela,
 ---ppp.valor AS valor
 FROM sge_serie_plano_pagamento AS spp
 INNER JOIN sgf_plano_pagamento ppa ON spp.id_sgf_plano_pagamento = ppa.id
 ---INNER JOIN sgf_plano_pagamento_parcela ppp ON ppa.id = ppp.id_sgf_plano_pagamento 
 WHERE spp.id_bas_empresa = p_emp AND spp.id_sge_turma = p_tur;
 
 ELSE
 RETURN QUERY 
 SELECT 
 spp.id_bas_empresa AS id_bas_empresa,
 spp.id_sge_serie AS id_sge_serie,
 spp.id_sge_turma AS id_sge_turma,
 spp.id AS id_sgf_plano_pagamento,
 ppa.nome AS plano_pagamento_nome,
 ppa.ano AS plano_pagamento_ano
 ---ppp.id AS id_sgf_plano_pagamento_parcela,
 ---ppp.numero_parcela AS numero_parcela,
 ---ppp.valor AS valor
 FROM sge_serie_plano_pagamento AS spp
 INNER JOIN sgf_plano_pagamento ppa ON spp.id_sgf_plano_pagamento = ppa.id
 ---INNER JOIN sgf_plano_pagamento_parcela ppp ON ppa.id = ppp.id_sgf_plano_pagamento 
 WHERE spp.id_bas_empresa = p_emp AND spp.id_sge_serie = p_ser;

 END IF;
END;
$$;


ALTER FUNCTION public."get_serie_plano_pagamento_8.3"(p_emp bigint, p_ser bigint, p_tur bigint) OWNER TO postgres;

--
-- TOC entry 1344 (class 1255 OID 14562674)
-- Name: get_serie_plano_pagamento_old(bigint, bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_serie_plano_pagamento_old(p_emp bigint, p_ser bigint, p_tur bigint) RETURNS SETOF record
 LANGUAGE plpgsql
 AS $$
DECLARE
 var_id_turma BIGINT;
 serie_plano_pagamento RECORD;
BEGIN
 var_id_turma := NULL;

 SELECT id_sge_turma INTO var_id_turma FROM sge_serie_plano_pagamento WHERE id_bas_empresa = p_emp AND id_sge_turma = p_tur LIMIT 1;
 
 IF var_id_turma IS NOT NULL THEN
/*
 RETURN QUERY 
 SELECT 
 spp.id_bas_empresa AS id_bas_empresa,
 spp.id_sge_serie AS id_sge_serie,
 spp.id_sge_turma AS id_sge_turma,
 spp.id AS id_sgf_plano_pagamento,
 ppa.nome AS plano_pagamento_nome,
 ppa.ano AS plano_pagamento_ano,
 ppp.id AS id_sgf_plano_pagamento_parcela,
 ppp.numero_parcela AS numero_parcela,
 ppp.valor AS valor
 FROM sge_serie_plano_pagamento AS spp
 INNER JOIN sgf_plano_pagamento ppa ON spp.id_sgf_plano_pagamento = ppa.id
 INNER JOIN sgf_plano_pagamento_parcela ppp ON ppa.id = ppp.id_sgf_plano_pagamento 
 WHERE spp.id_bas_empresa = p_emp AND spp.id_sge_turma = p_tur;
 */

 FOR serie_plano_pagamento IN
 SELECT 
 spp.id_bas_empresa AS id_bas_empresa,
 spp.id_sge_serie AS id_sge_serie,
 spp.id_sge_turma AS id_sge_turma,
 spp.id AS id_sgf_plano_pagamento,
 ppa.nome AS plano_pagamento_nome,
 ppa.ano AS plano_pagamento_ano,
 ppp.id AS id_sgf_plano_pagamento_parcela,
 ppp.numero_parcela AS numero_parcela,
 ppp.valor AS valor
 FROM sge_serie_plano_pagamento AS spp
 INNER JOIN sgf_plano_pagamento ppa ON spp.id_sgf_plano_pagamento = ppa.id
 INNER JOIN sgf_plano_pagamento_parcela ppp ON ppa.id = ppp.id_sgf_plano_pagamento 
 WHERE spp.id_bas_empresa = p_emp AND spp.id_sge_turma = p_tur

 LOOP
 RETURN NEXT serie_plano_pagamento;
 END LOOP;

 ELSE
 /*
 RETURN QUERY 
 SELECT 
 spp.id_bas_empresa AS id_bas_empresa,
 spp.id_sge_serie AS id_sge_serie,
 spp.id_sge_turma AS id_sge_turma,
 spp.id AS id_sgf_plano_pagamento,
 ppa.nome AS plano_pagamento_nome,
 ppa.ano AS plano_pagamento_ano,
 ppp.id AS id_sgf_plano_pagamento_parcela,
 ppp.numero_parcela AS numero_parcela,
 ppp.valor AS valor
 FROM sge_serie_plano_pagamento AS spp
 INNER JOIN sgf_plano_pagamento ppa ON spp.id_sgf_plano_pagamento = ppa.id
 INNER JOIN sgf_plano_pagamento_parcela ppp ON ppa.id = ppp.id_sgf_plano_pagamento 
 WHERE spp.id_bas_empresa = p_emp AND spp.id_sge_serie = p_ser;
*/
FOR serie_plano_pagamento IN
 SELECT 
 spp.id_bas_empresa AS id_bas_empresa,
 spp.id_sge_serie AS id_sge_serie,
 spp.id_sge_turma AS id_sge_turma,
 spp.id AS id_sgf_plano_pagamento,
 ppa.nome AS plano_pagamento_nome,
 ppa.ano AS plano_pagamento_ano,
 ppp.id AS id_sgf_plano_pagamento_parcela,
 ppp.numero_parcela AS numero_parcela,
 ppp.valor AS valor
 FROM sge_serie_plano_pagamento AS spp
 INNER JOIN sgf_plano_pagamento ppa ON spp.id_sgf_plano_pagamento = ppa.id
 INNER JOIN sgf_plano_pagamento_parcela ppp ON ppa.id = ppp.id_sgf_plano_pagamento 
 WHERE spp.id_bas_empresa = p_emp AND spp.id_sge_serie = p_ser
LOOP
 RETURN NEXT serie_plano_pagamento;
END LOOP;

 END IF;
END;
$$;


ALTER FUNCTION public.get_serie_plano_pagamento_old(p_emp bigint, p_ser bigint, p_tur bigint) OWNER TO postgres;

--
-- TOC entry 1345 (class 1255 OID 14562675)
-- Name: get_serie_plano_pagamento_old_8.3(bigint, bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."get_serie_plano_pagamento_old_8.3"(p_emp bigint, p_ser bigint, p_tur bigint) RETURNS SETOF record
 LANGUAGE plpgsql
 AS $$
DECLARE
 var_id_turma BIGINT;
BEGIN
 var_id_turma := NULL;

 SELECT id_sge_turma INTO var_id_turma FROM sge_serie_plano_pagamento WHERE id_bas_empresa = p_emp AND id_sge_turma = p_tur LIMIT 1;
 
 IF var_id_turma IS NOT NULL THEN
 RETURN QUERY 
 SELECT 
 spp.id_bas_empresa AS id_bas_empresa,
 spp.id_sge_serie AS id_sge_serie,
 spp.id_sge_turma AS id_sge_turma,
 spp.id AS id_sgf_plano_pagamento,
 ppa.nome AS plano_pagamento_nome,
 ppa.ano AS plano_pagamento_ano,
 ppp.id AS id_sgf_plano_pagamento_parcela,
 ppp.numero_parcela AS numero_parcela,
 ppp.valor AS valor
 FROM sge_serie_plano_pagamento AS spp
 INNER JOIN sgf_plano_pagamento ppa ON spp.id_sgf_plano_pagamento = ppa.id
 INNER JOIN sgf_plano_pagamento_parcela ppp ON ppa.id = ppp.id_sgf_plano_pagamento 
 WHERE spp.id_bas_empresa = p_emp AND spp.id_sge_turma = p_tur;
 
 ELSE
 RETURN QUERY 
 SELECT 
 spp.id_bas_empresa AS id_bas_empresa,
 spp.id_sge_serie AS id_sge_serie,
 spp.id_sge_turma AS id_sge_turma,
 spp.id AS id_sgf_plano_pagamento,
 ppa.nome AS plano_pagamento_nome,
 ppa.ano AS plano_pagamento_ano,
 ppp.id AS id_sgf_plano_pagamento_parcela,
 ppp.numero_parcela AS numero_parcela,
 ppp.valor AS valor
 FROM sge_serie_plano_pagamento AS spp
 INNER JOIN sgf_plano_pagamento ppa ON spp.id_sgf_plano_pagamento = ppa.id
 INNER JOIN sgf_plano_pagamento_parcela ppp ON ppa.id = ppp.id_sgf_plano_pagamento 
 WHERE spp.id_bas_empresa = p_emp AND spp.id_sge_serie = p_ser;

 END IF;
END;
$$;


ALTER FUNCTION public."get_serie_plano_pagamento_old_8.3"(p_emp bigint, p_ser bigint, p_tur bigint) OWNER TO postgres;

--
-- TOC entry 1346 (class 1255 OID 14562676)
-- Name: remove_accents(character varying, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.remove_accents(stexto character varying, upper_case boolean) RETURNS character varying
 LANGUAGE plpgsql
 AS $$
/**Remove acentos e converte uma string em maiúscula ou minúscula**/
DECLARE
 stextonovo varchar;
BEGIN
 stextonovo := translate(stexto, 'ÁÀÂÃÄáàâãä','aaaaaaaaaa');
 stextonovo := translate(stextonovo, 'ÉÈÊËéèêë','eeeeeeee');
 stextonovo := translate(stextonovo, 'ÍÌÎÏíìîï','iiiiiiii');
 stextonovo := translate(stextonovo, 'ÓÒÔÕÖóòôõö','oooooooooo');
 stextonovo := translate(stextonovo, 'ÚÙÛÜúùûü','uuuuuuuu');
 stextonovo := translate(stextonovo, 'Çç','cc');
 stextonovo := translate(stextonovo, 'º',' ');
 stextonovo := translate(stextonovo, 'ª',' ');
 if upper_case = true then
 stextonovo := rtrim(ltrim(upper(stextonovo)));
 else
 stextonovo := rtrim(ltrim(lower(stextonovo)));
 end if;
 return stextonovo;
END;
$$;


ALTER FUNCTION public.remove_accents(stexto character varying, upper_case boolean) OWNER TO postgres;

--
-- TOC entry 1347 (class 1255 OID 14562677)
-- Name: set_nota(bigint, bigint, bigint, numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.set_nota(p_emp bigint, p_cri_eta_ava bigint, p_tade bigint, p_nota numeric) RETURNS numeric
 LANGUAGE plpgsql
 AS $$
DECLARE
 var_id_nota_avaliacao BIGINT;
 var_nota_maxima NUMERIC;
 var_nota NUMERIC;
BEGIN
 var_id_nota_avaliacao := NULL;
 var_nota_maxima := NULL;
 var_nota := NULL;

 SELECT nota_maxima INTO var_nota_maxima
 FROM sge_criterio_etapa_avaliacao
 WHERE id_bas_empresa = p_emp
 AND id = p_cri_eta_ava LIMIT 1;

 IF (var_nota_maxima IS NOT NULL) AND (p_nota > var_nota_maxima) THEN
 var_nota := var_nota_maxima;
 ELSE
 var_nota = p_nota;
 END IF;

 SELECT id INTO var_id_nota_avaliacao 
 FROM sge_nota_avaliacao 
 WHERE id_bas_empresa = p_emp 
 AND id_sge_criterio_etapa_avaliacao = p_cri_eta_ava
 AND id_sge_turma_aluno_disciplina_etapa = p_tade LIMIT 1;

 IF var_id_nota_avaliacao IS NOT NULL THEN
 UPDATE sge_nota_avaliacao 
 SET 
 nota = var_nota, 
 data_inclusao = CURRENT_DATE 
 WHERE 
 id = var_id_nota_avaliacao ;
 ELSE 
 INSERT INTO sge_nota_avaliacao
 (id_bas_empresa,nota,id_sge_criterio_etapa_avaliacao,id_sge_turma_aluno_disciplina_etapa,data_inclusao)
 VALUES
 (p_emp,var_nota,p_cri_eta_ava,p_tade,CURRENT_DATE);
 END IF;
 RETURN var_nota;
END;
$$;


ALTER FUNCTION public.set_nota(p_emp bigint, p_cri_eta_ava bigint, p_tade bigint, p_nota numeric) OWNER TO postgres;

--
-- TOC entry 1317 (class 1255 OID 14562678)
-- Name: set_nota(bigint, bigint, bigint, numeric, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.set_nota(p_emp bigint, p_cri_eta_ava bigint, p_tade bigint, p_nota numeric, p_login character varying) RETURNS numeric
 LANGUAGE plpgsql
 AS $$
DECLARE

 var_id_nota_avaliacao BIGINT;
 var_nota_maxima NUMERIC;
 var_nota NUMERIC;

BEGIN

 var_id_nota_avaliacao := NULL;
 var_nota_maxima := NULL;
 var_nota := NULL;

 SELECT nota_maxima INTO var_nota_maxima
 FROM sge_criterio_etapa_avaliacao
 WHERE id_bas_empresa = p_emp
 AND id = p_cri_eta_ava LIMIT 1; 
 IF (var_nota_maxima IS NOT NULL) AND (p_nota > var_nota_maxima) THEN
 var_nota := var_nota_maxima;
 ELSE
 var_nota = p_nota;
 END IF;

 SELECT id INTO var_id_nota_avaliacao 
 FROM sge_nota_avaliacao 
 WHERE id_bas_empresa = p_emp 
 AND id_sge_criterio_etapa_avaliacao = p_cri_eta_ava
 AND id_sge_turma_aluno_disciplina_etapa = p_tade LIMIT 1;
 IF var_id_nota_avaliacao IS NOT NULL THEN

 UPDATE sge_nota_avaliacao 

 SET 

 nota = var_nota, 

 data_inclusao = CURRENT_DATE 

 WHERE 

 id = var_id_nota_avaliacao ;

 ELSE 

 INSERT INTO sge_nota_avaliacao
 (id_bas_empresa,nota,id_sge_criterio_etapa_avaliacao,id_sge_turma_aluno_disciplina_etapa,data_inclusao)
 VALUES
 (p_emp,var_nota,p_cri_eta_ava,p_tade,CURRENT_DATE);

 SELECT currval('sge_nota_avaliacao_id_seq') INTO var_id_nota_avaliacao;

 END IF;

 INSERT INTO 
 public.sge_nota_avaliacao_log
 (
 id_bas_empresa, id_sge_nota_avaliacao, login, nota, data, hora
 )
 VALUES (p_emp,var_id_nota_avaliacao, p_login, var_nota, CURRENT_DATE, NOW()); 

 RETURN var_nota;

END;
$$;


ALTER FUNCTION public.set_nota(p_emp bigint, p_cri_eta_ava bigint, p_tade bigint, p_nota numeric, p_login character varying) OWNER TO postgres;

--
-- TOC entry 1348 (class 1255 OID 14562679)
-- Name: set_nota_etapa(bigint, bigint, bigint, numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.set_nota_etapa(p_emp bigint, p_cri_eta bigint, p_tad bigint, p_nota numeric) RETURNS numeric
 LANGUAGE plpgsql
 AS $$
DECLARE
 var_id_tade BIGINT;
 var_nota_maxima NUMERIC;
 var_nota NUMERIC;
BEGIN
 var_id_tade := NULL;
 var_nota_maxima := NULL;
 var_nota := NULL;

 SELECT nota_maxima INTO var_nota_maxima
 FROM sge_criterio_etapa
 WHERE id_bas_empresa = p_emp
 AND id = p_cri_eta LIMIT 1;

 IF (var_nota_maxima IS NOT NULL) AND (p_nota > var_nota_maxima) THEN
 var_nota := var_nota_maxima;
 ELSE
 var_nota = p_nota;
 END IF;

 SELECT id INTO var_id_tade 
 FROM sge_turma_aluno_disciplina_etapa 
 WHERE id_bas_empresa = p_emp 
 AND id_sge_criterio_etapa = p_cri_eta
 AND id_sge_turma_aluno_disciplina = p_tad LIMIT 1;

 IF var_id_tade IS NOT NULL THEN
 UPDATE sge_turma_aluno_disciplina_etapa
 SET 
 nota = var_nota
 WHERE 
 id = var_id_tade ;
 ELSE 
 INSERT INTO sge_turma_aluno_disciplina_etapa
 (id_bas_empresa,id_sge_turma_aluno_disciplina,id_sge_criterio_etapa,nota)
 VALUES
 (p_emp,p_tad,p_cri_eta,var_nota);
 END IF;
 RETURN var_nota;
END;
$$;


ALTER FUNCTION public.set_nota_etapa(p_emp bigint, p_cri_eta bigint, p_tad bigint, p_nota numeric) OWNER TO postgres;

--
-- TOC entry 1349 (class 1255 OID 14562680)
-- Name: set_nota_etapa(bigint, bigint, bigint, numeric, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.set_nota_etapa(p_emp bigint, p_cri_eta bigint, p_tad bigint, p_nota numeric, p_login character varying) RETURNS numeric
 LANGUAGE plpgsql
 AS $$
DECLARE

 var_id_tade BIGINT;
 var_nota_maxima NUMERIC;
 var_nota NUMERIC;

BEGIN

 var_id_tade := NULL;
 var_nota_maxima := NULL;
 var_nota := NULL; 

 IF (p_nota IS NOT NULL) THEN
 SELECT nota_maxima INTO var_nota_maxima
 FROM sge_criterio_etapa
 WHERE id_bas_empresa = p_emp
 AND id = p_cri_eta LIMIT 1; 

 IF (var_nota_maxima IS NOT NULL) AND (p_nota > var_nota_maxima) THEN
 var_nota := var_nota_maxima;
 ELSE
 var_nota = p_nota;
 END IF;
 END IF;

 SELECT id INTO var_id_tade 
 FROM sge_turma_aluno_disciplina_etapa 
 WHERE id_bas_empresa = p_emp 
 AND id_sge_criterio_etapa = p_cri_eta
 AND id_sge_turma_aluno_disciplina = p_tad LIMIT 1;

 IF var_id_tade IS NOT NULL THEN
 UPDATE sge_turma_aluno_disciplina_etapa
 SET 
 nota = var_nota
 WHERE 
 id = var_id_tade ;
 ELSE 
 INSERT INTO sge_turma_aluno_disciplina_etapa
 (id_bas_empresa,id_sge_turma_aluno_disciplina,id_sge_criterio_etapa,nota)
 VALUES
 (p_emp,p_tad,p_cri_eta,var_nota);

 SELECT currval('sge_turma_aluno_disciplina_etapa_id_seq') INTO var_id_tade;

 END IF;

 INSERT INTO 
 public.sge_turma_aluno_disciplina_etapa_log
 (
 id_bas_empresa, id_sge_turma_aluno_disciplina_etapa, login, nota, data, hora
 )
 VALUES (p_emp,var_id_tade, p_login, var_nota, CURRENT_DATE, NOW()); 

 RETURN var_nota;

END;
$$;


ALTER FUNCTION public.set_nota_etapa(p_emp bigint, p_cri_eta bigint, p_tad bigint, p_nota numeric, p_login character varying) OWNER TO postgres;

--
-- TOC entry 1350 (class 1255 OID 14562681)
-- Name: set_nota_etapa(bigint, bigint, bigint, numeric, character varying, bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.set_nota_etapa(p_emp bigint, p_cri_eta bigint, p_tad bigint, p_nota numeric, p_login character varying, p_desc_i bigint, p_desc_o bigint) RETURNS numeric
 LANGUAGE plpgsql
 AS $$
DECLARE
 var_id_tade BIGINT;
 var_nota_maxima NUMERIC;
 var_nota NUMERIC;
BEGIN
 var_id_tade := NULL;
 var_nota_maxima := NULL;
 var_nota := NULL;

 IF (p_nota IS NOT NULL) THEN
 SELECT nota_maxima INTO var_nota_maxima
 FROM sge_criterio_etapa
 WHERE id_bas_empresa = p_emp
 AND id = p_cri_eta LIMIT 1;

 IF (var_nota_maxima IS NOT NULL) AND (p_nota > var_nota_maxima) THEN
 var_nota := var_nota_maxima;
 ELSE
 var_nota = p_nota;
 END IF;
 p_desc_i := NULL;
 p_desc_o := NULL;
 END IF;

 IF (p_desc_i IS NOT NULL) THEN
 SELECT id INTO var_id_tade 
 FROM sge_turma_aluno_disciplina_etapa 
 WHERE id_bas_empresa = p_emp 
 AND id_sge_criterio_etapa = p_cri_eta
 AND id_sge_conceito_descritivo_item = p_desc_i 
 AND id_sge_turma_aluno_disciplina = p_tad LIMIT 1;
 ELSE
 SELECT id INTO var_id_tade 
 FROM sge_turma_aluno_disciplina_etapa 
 WHERE id_bas_empresa = p_emp 
 AND id_sge_criterio_etapa = p_cri_eta
 AND id_sge_turma_aluno_disciplina = p_tad LIMIT 1;
 END IF;

 IF var_id_tade IS NOT NULL THEN
 UPDATE sge_turma_aluno_disciplina_etapa
 SET 
 nota = var_nota,
 id_sge_conceito_descritivo_item = p_desc_i,
 id_sge_conceito_descritivo_opcao = p_desc_o
 WHERE 
 id = var_id_tade ;
 ELSE 
 INSERT INTO sge_turma_aluno_disciplina_etapa
 (id_bas_empresa,id_sge_turma_aluno_disciplina,id_sge_criterio_etapa,nota,id_sge_conceito_descritivo_item,id_sge_conceito_descritivo_opcao)
 VALUES
 (p_emp,p_tad,p_cri_eta,var_nota,p_desc_i,p_desc_o);

 SELECT currval('sge_turma_aluno_disciplina_etapa_id_seq') INTO var_id_tade;
 END IF;

 INSERT INTO 
 public.sge_turma_aluno_disciplina_etapa_log
 (
 id_bas_empresa, id_sge_turma_aluno_disciplina_etapa, login, nota, data, hora, id_sge_conceito_descritivo_item, id_sge_conceito_descritivo_opcao
 )
 VALUES (p_emp,var_id_tade, p_login, var_nota, CURRENT_DATE, NOW(),p_desc_i,p_desc_o);

 RETURN var_nota;
END;
$$;


ALTER FUNCTION public.set_nota_etapa(p_emp bigint, p_cri_eta bigint, p_tad bigint, p_nota numeric, p_login character varying, p_desc_i bigint, p_desc_o bigint) OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 196 (class 1259 OID 14562682)
-- Name: bas_afastamento_tipo; Type: TABLE; Schema: public; Owner: infocraftread
--




ALTER TABLE public.bas_afastamento_tipo OWNER TO infocraftread;

--
-- TOC entry 197 (class 1259 OID 14562685)
-- Name: bas_afastamento_tipo_id_seq; Type: SEQUENCE; Schema: public; Owner: infocraftread
--

CREATE SEQUENCE public.bas_afastamento_tipo_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_afastamento_tipo_id_seq OWNER TO infocraftread;

--
-- TOC entry 11644 (class 0 OID 0)
-- Dependencies: 197
-- Name: bas_afastamento_tipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: infocraftread
--

ALTER SEQUENCE public.bas_afastamento_tipo_id_seq OWNED BY public.bas_afastamento_tipo.id;


--
-- TOC entry 198 (class 1259 OID 14562687)
-- Name: bas_alocacao; Type: TABLE; Schema: public; Owner: pgadmin
--


ALTER TABLE public.bas_alocacao OWNER TO pgadmin;

--
-- TOC entry 11645 (class 0 OID 0)
-- Dependencies: 198
-- Name: COLUMN bas_alocacao.ativo; Type: COMMENT; Schema: public; Owner: pgadmin
--

COMMENT ON COLUMN public.bas_alocacao.ativo IS 'S=sim N=NAO';


--
-- TOC entry 199 (class 1259 OID 14562693)
-- Name: bas_alocacao_equipamento; Type: TABLE; Schema: public; Owner: pgadmin
--


ALTER TABLE public.bas_alocacao_equipamento OWNER TO pgadmin;

--
-- TOC entry 200 (class 1259 OID 14562696)
-- Name: bas_alocacao_id_seq; Type: SEQUENCE; Schema: public; Owner: pgadmin
--

CREATE SEQUENCE public.bas_alocacao_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_alocacao_id_seq OWNER TO pgadmin;

--
-- TOC entry 11646 (class 0 OID 0)
-- Dependencies: 200
-- Name: bas_alocacao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgadmin
--

ALTER SEQUENCE public.bas_alocacao_id_seq OWNED BY public.bas_alocacao.id;


--
-- TOC entry 201 (class 1259 OID 14562698)
-- Name: bas_alocacao_log_id_seq1; Type: SEQUENCE; Schema: public; Owner: pgadmin
--

CREATE SEQUENCE public.bas_alocacao_log_id_seq1
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_alocacao_log_id_seq1 OWNER TO pgadmin;

--
-- TOC entry 202 (class 1259 OID 14562700)
-- Name: bas_alocacao_log; Type: TABLE; Schema: public; Owner: pgadmin
--



ALTER TABLE public.bas_alocacao_log OWNER TO pgadmin;

--
-- TOC entry 203 (class 1259 OID 14562707)
-- Name: bas_alocacao_sala; Type: TABLE; Schema: public; Owner: pgadmin
--


ALTER TABLE public.bas_alocacao_sala OWNER TO pgadmin;

--
-- TOC entry 204 (class 1259 OID 14562710)
-- Name: bas_alocacao_status; Type: TABLE; Schema: public; Owner: pgadmin
--




ALTER TABLE public.bas_alocacao_status OWNER TO pgadmin;

--
-- TOC entry 205 (class 1259 OID 14562713)
-- Name: bas_alocacao_status_id_seq; Type: SEQUENCE; Schema: public; Owner: pgadmin
--

CREATE SEQUENCE public.bas_alocacao_status_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_alocacao_status_id_seq OWNER TO pgadmin;

--
-- TOC entry 11647 (class 0 OID 0)
-- Dependencies: 205
-- Name: bas_alocacao_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgadmin
--

ALTER SEQUENCE public.bas_alocacao_status_id_seq OWNED BY public.bas_alocacao_status.id;


--
-- TOC entry 206 (class 1259 OID 14562715)
-- Name: bas_alocacao_tipo; Type: TABLE; Schema: public; Owner: pgadmin
--




ALTER TABLE public.bas_alocacao_tipo OWNER TO pgadmin;

--
-- TOC entry 207 (class 1259 OID 14562718)
-- Name: bas_alocacao_tipo_id_seq; Type: SEQUENCE; Schema: public; Owner: pgadmin
--

CREATE SEQUENCE public.bas_alocacao_tipo_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_alocacao_tipo_id_seq OWNER TO pgadmin;

--
-- TOC entry 11648 (class 0 OID 0)
-- Dependencies: 207
-- Name: bas_alocacao_tipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgadmin
--

ALTER SEQUENCE public.bas_alocacao_tipo_id_seq OWNED BY public.bas_alocacao_tipo.id;


--
-- TOC entry 208 (class 1259 OID 14562720)
-- Name: sge_anamnese_id_seq; Type: SEQUENCE; Schema: public; Owner: pgadmin
--

CREATE SEQUENCE public.sge_anamnese_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_anamnese_id_seq OWNER TO pgadmin;

--
-- TOC entry 209 (class 1259 OID 14562722)
-- Name: bas_anamnese; Type: TABLE; Schema: public; Owner: pgadmin
--



ALTER TABLE public.bas_anamnese OWNER TO pgadmin;

--
-- TOC entry 210 (class 1259 OID 14562727)
-- Name: sge_anamnese_categoria_pergunta_id_seq; Type: SEQUENCE; Schema: public; Owner: pgadmin
--

CREATE SEQUENCE public.sge_anamnese_categoria_pergunta_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_anamnese_categoria_pergunta_id_seq OWNER TO pgadmin;

--
-- TOC entry 211 (class 1259 OID 14562729)
-- Name: bas_anamnese_categoria_pergunta; Type: TABLE; Schema: public; Owner: pgadmin
--


ALTER TABLE public.bas_anamnese_categoria_pergunta OWNER TO pgadmin;

--
-- TOC entry 212 (class 1259 OID 14562733)
-- Name: bas_anamnese_pergunta; Type: TABLE; Schema: public; Owner: pgadmin
--


ALTER TABLE public.bas_anamnese_pergunta OWNER TO pgadmin;

--
-- TOC entry 213 (class 1259 OID 14562736)
-- Name: bas_anamnese_pergunta_id_seq; Type: SEQUENCE; Schema: public; Owner: pgadmin
--

CREATE SEQUENCE public.bas_anamnese_pergunta_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_anamnese_pergunta_id_seq OWNER TO pgadmin;

--
-- TOC entry 11649 (class 0 OID 0)
-- Dependencies: 213
-- Name: bas_anamnese_pergunta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgadmin
--

ALTER SEQUENCE public.bas_anamnese_pergunta_id_seq OWNED BY public.bas_anamnese_pergunta.id;


--
-- TOC entry 214 (class 1259 OID 14562738)
-- Name: bas_area_conhecimento; Type: TABLE; Schema: public; Owner: postgres
--



ALTER TABLE public.bas_area_conhecimento OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 14562741)
-- Name: bas_area_conhecimento_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bas_area_conhecimento_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_area_conhecimento_id_seq OWNER TO postgres;

--
-- TOC entry 11650 (class 0 OID 0)
-- Dependencies: 215
-- Name: bas_area_conhecimento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bas_area_conhecimento_id_seq OWNED BY public.bas_area_conhecimento.id;


--
-- TOC entry 216 (class 1259 OID 14562743)
-- Name: bas_pessoa_secretario_id_seq; Type: SEQUENCE; Schema: public; Owner: pgadmin
--

CREATE SEQUENCE public.bas_pessoa_secretario_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_pessoa_secretario_id_seq OWNER TO pgadmin;

--
-- TOC entry 217 (class 1259 OID 14562745)
-- Name: bas_assinatura_documento; Type: TABLE; Schema: public; Owner: pgadmin
--


ALTER TABLE public.bas_assinatura_documento OWNER TO pgadmin;

--
-- TOC entry 11651 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN bas_assinatura_documento.tipo; Type: COMMENT; Schema: public; Owner: pgadmin
--

COMMENT ON COLUMN public.bas_assinatura_documento.tipo IS '''S'' = secretário(a)
''D'' = diretor(a)
''SC'' = secretario curso';


--
-- TOC entry 218 (class 1259 OID 14562750)
-- Name: bas_atendimento_suporte; Type: TABLE; Schema: public; Owner: postgres
--


ALTER TABLE public.bas_atendimento_suporte OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 14562756)
-- Name: bas_atendimento_suporte_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bas_atendimento_suporte_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_atendimento_suporte_id_seq OWNER TO postgres;

--
-- TOC entry 11652 (class 0 OID 0)
-- Dependencies: 219
-- Name: bas_atendimento_suporte_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bas_atendimento_suporte_id_seq OWNED BY public.bas_atendimento_suporte.id;


--
-- TOC entry 220 (class 1259 OID 14562758)
-- Name: bas_atendimento_suporte_log; Type: TABLE; Schema: public; Owner: postgres
--


ALTER TABLE public.bas_atendimento_suporte_log OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 14562764)
-- Name: bas_atendimento_suporte_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bas_atendimento_suporte_log_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_atendimento_suporte_log_id_seq OWNER TO postgres;

--
-- TOC entry 11653 (class 0 OID 0)
-- Dependencies: 221
-- Name: bas_atendimento_suporte_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bas_atendimento_suporte_log_id_seq OWNED BY public.bas_atendimento_suporte_log.id;


--
-- TOC entry 222 (class 1259 OID 14562766)
-- Name: bas_atestado_tipo; Type: TABLE; Schema: public; Owner: infocraftread
--



ALTER TABLE public.bas_atestado_tipo OWNER TO infocraftread;

--
-- TOC entry 223 (class 1259 OID 14562769)
-- Name: bas_atestado_tipo_id_seq; Type: SEQUENCE; Schema: public; Owner: infocraftread
--

CREATE SEQUENCE public.bas_atestado_tipo_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_atestado_tipo_id_seq OWNER TO infocraftread;

--
-- TOC entry 11654 (class 0 OID 0)
-- Dependencies: 223
-- Name: bas_atestado_tipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: infocraftread
--

ALTER SEQUENCE public.bas_atestado_tipo_id_seq OWNED BY public.bas_atestado_tipo.id;


--
-- TOC entry 224 (class 1259 OID 14562771)
-- Name: bas_bairro; Type: TABLE; Schema: public; Owner: postgres
--


ALTER TABLE public.bas_bairro OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 14562774)
-- Name: bas_bairro_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bas_bairro_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_bairro_id_seq OWNER TO postgres;

--
-- TOC entry 11655 (class 0 OID 0)
-- Dependencies: 225
-- Name: bas_bairro_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bas_bairro_id_seq OWNED BY public.bas_bairro.id;


--
-- TOC entry 226 (class 1259 OID 14562776)
-- Name: bas_cargo; Type: TABLE; Schema: public; Owner: infocraftread
--


ALTER TABLE public.bas_cargo OWNER TO infocraftread;

--
-- TOC entry 227 (class 1259 OID 14562779)
-- Name: bas_cargo_id_seq; Type: SEQUENCE; Schema: public; Owner: infocraftread
--

CREATE SEQUENCE public.bas_cargo_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_cargo_id_seq OWNER TO infocraftread;

--
-- TOC entry 11656 (class 0 OID 0)
-- Dependencies: 227
-- Name: bas_cargo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: infocraftread
--

ALTER SEQUENCE public.bas_cargo_id_seq OWNED BY public.bas_cargo.id;


SET default_with_oids = true;

--
-- TOC entry 228 (class 1259 OID 14562781)
-- Name: bas_centro_custo; Type: TABLE; Schema: public; Owner: postgres
--


ALTER TABLE public.bas_centro_custo OWNER TO postgres;

--
-- TOC entry 11657 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN bas_centro_custo.codigo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_centro_custo.codigo IS 'XX.XX.XX.XX';


--
-- TOC entry 11658 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN bas_centro_custo.id_bas_centro_custo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_centro_custo.id_bas_centro_custo IS 'id do centro de custo pai';


--
-- TOC entry 11659 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN bas_centro_custo.agrupamento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_centro_custo.agrupamento IS 'S=sim N=nao';


--
-- TOC entry 11660 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN bas_centro_custo.cota_financeira; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_centro_custo.cota_financeira IS 'Campo para cota financeira mensal';


--
-- TOC entry 11661 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN bas_centro_custo.cota_quantidade; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_centro_custo.cota_quantidade IS 'Campo para cota da quantidade mensal, por material';


--
-- TOC entry 229 (class 1259 OID 14562784)
-- Name: bas_centro_custo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bas_centro_custo_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_centro_custo_id_seq OWNER TO postgres;

--
-- TOC entry 11662 (class 0 OID 0)
-- Dependencies: 229
-- Name: bas_centro_custo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bas_centro_custo_id_seq OWNED BY public.bas_centro_custo.id;


SET default_with_oids = false;

--
-- TOC entry 230 (class 1259 OID 14562786)
-- Name: bas_cid; Type: TABLE; Schema: public; Owner: postgres
--


ALTER TABLE public.bas_cid OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 14562789)
-- Name: bas_cid_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bas_cid_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_cid_id_seq OWNER TO postgres;

--
-- TOC entry 11663 (class 0 OID 0)
-- Dependencies: 231
-- Name: bas_cid_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bas_cid_id_seq OWNED BY public.bas_cid.id;


SET default_with_oids = true;

--
-- TOC entry 232 (class 1259 OID 14562791)
-- Name: bas_colaborador; Type: TABLE; Schema: public; Owner: postgres
--

ALTER TABLE public.bas_colaborador OWNER TO postgres;

--
-- TOC entry 11664 (class 0 OID 0)
-- Dependencies: 232
-- Name: COLUMN bas_colaborador.ativo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_colaborador.ativo IS 'S = sim / N = não';


--
-- TOC entry 11665 (class 0 OID 0)
-- Dependencies: 232
-- Name: COLUMN bas_colaborador.gestor; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_colaborador.gestor IS 'Descontinuado. Use o campo gestor da tabela bas_colaborador_estabelecimento.';


SET default_with_oids = false;

--
-- TOC entry 233 (class 1259 OID 14562794)
-- Name: bas_colaborador_afastamento; Type: TABLE; Schema: public; Owner: infocraftread
--


ALTER TABLE public.bas_colaborador_afastamento OWNER TO infocraftread;

--
-- TOC entry 234 (class 1259 OID 14562800)
-- Name: bas_colaborador_afastamento_id_seq; Type: SEQUENCE; Schema: public; Owner: infocraftread
--

CREATE SEQUENCE public.bas_colaborador_afastamento_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_colaborador_afastamento_id_seq OWNER TO infocraftread;

--
-- TOC entry 11666 (class 0 OID 0)
-- Dependencies: 234
-- Name: bas_colaborador_afastamento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: infocraftread
--

ALTER SEQUENCE public.bas_colaborador_afastamento_id_seq OWNED BY public.bas_colaborador_afastamento.id;


--
-- TOC entry 235 (class 1259 OID 14562802)
-- Name: bas_colaborador_atestado; Type: TABLE; Schema: public; Owner: infocraftread
--


ALTER TABLE public.bas_colaborador_atestado OWNER TO infocraftread;

--
-- TOC entry 236 (class 1259 OID 14562808)
-- Name: bas_colaborador_atestado_falta; Type: TABLE; Schema: public; Owner: infocraftread
--


ALTER TABLE public.bas_colaborador_atestado_falta OWNER TO infocraftread;

--
-- TOC entry 237 (class 1259 OID 14562814)
-- Name: bas_colaborador_atestado_falta_id_seq; Type: SEQUENCE; Schema: public; Owner: infocraftread
--

CREATE SEQUENCE public.bas_colaborador_atestado_falta_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_colaborador_atestado_falta_id_seq OWNER TO infocraftread;

--
-- TOC entry 11667 (class 0 OID 0)
-- Dependencies: 237
-- Name: bas_colaborador_atestado_falta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: infocraftread
--

ALTER SEQUENCE public.bas_colaborador_atestado_falta_id_seq OWNED BY public.bas_colaborador_atestado_falta.id;


--
-- TOC entry 238 (class 1259 OID 14562816)
-- Name: bas_colaborador_atestado_id_seq; Type: SEQUENCE; Schema: public; Owner: infocraftread
--

CREATE SEQUENCE public.bas_colaborador_atestado_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_colaborador_atestado_id_seq OWNER TO infocraftread;

--
-- TOC entry 11668 (class 0 OID 0)
-- Dependencies: 238
-- Name: bas_colaborador_atestado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: infocraftread
--

ALTER SEQUENCE public.bas_colaborador_atestado_id_seq OWNED BY public.bas_colaborador_atestado.id;


--
-- TOC entry 239 (class 1259 OID 14562818)
-- Name: bas_colaborador_beneficio; Type: TABLE; Schema: public; Owner: infocraftread
--


ALTER TABLE public.bas_colaborador_beneficio OWNER TO infocraftread;

--
-- TOC entry 240 (class 1259 OID 14562824)
-- Name: bas_colaborador_beneficio_id_seq; Type: SEQUENCE; Schema: public; Owner: infocraftread
--

CREATE SEQUENCE public.bas_colaborador_beneficio_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_colaborador_beneficio_id_seq OWNER TO infocraftread;

--
-- TOC entry 11669 (class 0 OID 0)
-- Dependencies: 240
-- Name: bas_colaborador_beneficio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: infocraftread
--

ALTER SEQUENCE public.bas_colaborador_beneficio_id_seq OWNED BY public.bas_colaborador_beneficio.id;


--
-- TOC entry 241 (class 1259 OID 14562826)
-- Name: bas_colaborador_capacitacao; Type: TABLE; Schema: public; Owner: infocraftread
--


ALTER TABLE public.bas_colaborador_capacitacao OWNER TO infocraftread;

--
-- TOC entry 242 (class 1259 OID 14562829)
-- Name: bas_colaborador_capacitacao_id_seq; Type: SEQUENCE; Schema: public; Owner: infocraftread
--

CREATE SEQUENCE public.bas_colaborador_capacitacao_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_colaborador_capacitacao_id_seq OWNER TO infocraftread;

--
-- TOC entry 11670 (class 0 OID 0)
-- Dependencies: 242
-- Name: bas_colaborador_capacitacao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: infocraftread
--

ALTER SEQUENCE public.bas_colaborador_capacitacao_id_seq OWNED BY public.bas_colaborador_capacitacao.id;


--
-- TOC entry 243 (class 1259 OID 14562831)
-- Name: bas_colaborador_dias_trabalhados; Type: TABLE; Schema: public; Owner: infocraftread
--


ALTER TABLE public.bas_colaborador_dias_trabalhados OWNER TO infocraftread;

--
-- TOC entry 244 (class 1259 OID 14562834)
-- Name: bas_colaborador_dias_trabalhados_id_seq; Type: SEQUENCE; Schema: public; Owner: infocraftread
--

CREATE SEQUENCE public.bas_colaborador_dias_trabalhados_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_colaborador_dias_trabalhados_id_seq OWNER TO infocraftread;

--
-- TOC entry 11671 (class 0 OID 0)
-- Dependencies: 244
-- Name: bas_colaborador_dias_trabalhados_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: infocraftread
--

ALTER SEQUENCE public.bas_colaborador_dias_trabalhados_id_seq OWNED BY public.bas_colaborador_dias_trabalhados.id;


--
-- TOC entry 245 (class 1259 OID 14562836)
-- Name: bas_colaborador_estabelecimento; Type: TABLE; Schema: public; Owner: postgres
--

ALTER TABLE public.bas_colaborador_estabelecimento OWNER TO postgres;

--
-- TOC entry 1314 (class 1259 OID 25007795)
-- Name: bas_colaborador_estabelecimento_chamadas; Type: TABLE; Schema: public; Owner: postgres
--


ALTER TABLE public.bas_colaborador_estabelecimento_chamadas OWNER TO postgres;

--
-- TOC entry 11672 (class 0 OID 0)
-- Dependencies: 1314
-- Name: COLUMN bas_colaborador_estabelecimento_chamadas.visualiza; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_colaborador_estabelecimento_chamadas.visualiza IS '''S''=Sim, ''N''=Não';


--
-- TOC entry 11673 (class 0 OID 0)
-- Dependencies: 1314
-- Name: COLUMN bas_colaborador_estabelecimento_chamadas.altera; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_colaborador_estabelecimento_chamadas.altera IS '''S''=Sim, ''N''=Não';


--
-- TOC entry 11674 (class 0 OID 0)
-- Dependencies: 1314
-- Name: COLUMN bas_colaborador_estabelecimento_chamadas.cria; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_colaborador_estabelecimento_chamadas.cria IS '''S''=Sim, ''N''=não';


--
-- TOC entry 1313 (class 1259 OID 25007793)
-- Name: bas_colaborador_estabelecimento_chamadas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bas_colaborador_estabelecimento_chamadas_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_colaborador_estabelecimento_chamadas_id_seq OWNER TO postgres;

--
-- TOC entry 11675 (class 0 OID 0)
-- Dependencies: 1313
-- Name: bas_colaborador_estabelecimento_chamadas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bas_colaborador_estabelecimento_chamadas_id_seq OWNED BY public.bas_colaborador_estabelecimento_chamadas.id;


--
-- TOC entry 246 (class 1259 OID 14562839)
-- Name: bas_colaborador_estabelecimento_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bas_colaborador_estabelecimento_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_colaborador_estabelecimento_id_seq OWNER TO postgres;

--
-- TOC entry 11676 (class 0 OID 0)
-- Dependencies: 246
-- Name: bas_colaborador_estabelecimento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bas_colaborador_estabelecimento_id_seq OWNED BY public.bas_colaborador_estabelecimento.id;


--
-- TOC entry 247 (class 1259 OID 14562841)
-- Name: bas_colaborador_funcao; Type: TABLE; Schema: public; Owner: postgres
--


ALTER TABLE public.bas_colaborador_funcao OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 14562844)
-- Name: bas_colaborador_funcao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bas_colaborador_funcao_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_colaborador_funcao_id_seq OWNER TO postgres;

--
-- TOC entry 11677 (class 0 OID 0)
-- Dependencies: 248
-- Name: bas_colaborador_funcao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bas_colaborador_funcao_id_seq OWNED BY public.bas_colaborador_funcao.id;


--
-- TOC entry 249 (class 1259 OID 14562846)
-- Name: bas_colaborador_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bas_colaborador_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_colaborador_id_seq OWNER TO postgres;

--
-- TOC entry 11678 (class 0 OID 0)
-- Dependencies: 249
-- Name: bas_colaborador_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bas_colaborador_id_seq OWNED BY public.bas_colaborador.id;


--
-- TOC entry 250 (class 1259 OID 14562848)
-- Name: bas_colaborador_outros_documentos; Type: TABLE; Schema: public; Owner: infocraftread
--


ALTER TABLE public.bas_colaborador_outros_documentos OWNER TO infocraftread;

--
-- TOC entry 251 (class 1259 OID 14562851)
-- Name: bas_colaborador_outros_documentos_id_seq; Type: SEQUENCE; Schema: public; Owner: infocraftread
--

CREATE SEQUENCE public.bas_colaborador_outros_documentos_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_colaborador_outros_documentos_id_seq OWNER TO infocraftread;

--
-- TOC entry 11679 (class 0 OID 0)
-- Dependencies: 251
-- Name: bas_colaborador_outros_documentos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: infocraftread
--

ALTER SEQUENCE public.bas_colaborador_outros_documentos_id_seq OWNED BY public.bas_colaborador_outros_documentos.id;


--
-- TOC entry 1287 (class 1259 OID 17129539)
-- Name: bas_colaborador_treinamento; Type: TABLE; Schema: public; Owner: postgres
--


ALTER TABLE public.bas_colaborador_treinamento OWNER TO postgres;

--
-- TOC entry 1286 (class 1259 OID 17129537)
-- Name: bas_colaborador_treinamento_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bas_colaborador_treinamento_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_colaborador_treinamento_id_seq OWNER TO postgres;

--
-- TOC entry 11680 (class 0 OID 0)
-- Dependencies: 1286
-- Name: bas_colaborador_treinamento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bas_colaborador_treinamento_id_seq OWNED BY public.bas_colaborador_treinamento.id;


--
-- TOC entry 252 (class 1259 OID 14562853)
-- Name: bas_config_dias_letivos; Type: TABLE; Schema: public; Owner: infocraftread
--


ALTER TABLE public.bas_config_dias_letivos OWNER TO infocraftread;

--
-- TOC entry 253 (class 1259 OID 14562856)
-- Name: bas_config_dias_letivos_id_seq; Type: SEQUENCE; Schema: public; Owner: infocraftread
--

CREATE SEQUENCE public.bas_config_dias_letivos_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_config_dias_letivos_id_seq OWNER TO infocraftread;

--
-- TOC entry 11681 (class 0 OID 0)
-- Dependencies: 253
-- Name: bas_config_dias_letivos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: infocraftread
--

ALTER SEQUENCE public.bas_config_dias_letivos_id_seq OWNED BY public.bas_config_dias_letivos.id;


--
-- TOC entry 254 (class 1259 OID 14562858)
-- Name: bas_configuracao; Type: TABLE; Schema: public; Owner: postgres
--


ALTER TABLE public.bas_configuracao OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 14562864)
-- Name: bas_configuracao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bas_configuracao_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_configuracao_id_seq OWNER TO postgres;

--
-- TOC entry 11682 (class 0 OID 0)
-- Dependencies: 255
-- Name: bas_configuracao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bas_configuracao_id_seq OWNED BY public.bas_configuracao.id;


--
-- TOC entry 256 (class 1259 OID 14562866)
-- Name: bas_emails_enviados; Type: TABLE; Schema: public; Owner: infocraftread
--


ALTER TABLE public.bas_emails_enviados OWNER TO infocraftread;

--
-- TOC entry 257 (class 1259 OID 14562869)
-- Name: bas_emails_enviados_id_seq; Type: SEQUENCE; Schema: public; Owner: infocraftread
--

CREATE SEQUENCE public.bas_emails_enviados_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_emails_enviados_id_seq OWNER TO infocraftread;

--
-- TOC entry 11683 (class 0 OID 0)
-- Dependencies: 257
-- Name: bas_emails_enviados_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: infocraftread
--

ALTER SEQUENCE public.bas_emails_enviados_id_seq OWNED BY public.bas_emails_enviados.id;


SET default_with_oids = true;

--
-- TOC entry 258 (class 1259 OID 14562871)
-- Name: bas_empresa; Type: TABLE; Schema: public; Owner: postgres
--


ALTER TABLE public.bas_empresa OWNER TO postgres;

--
-- TOC entry 11684 (class 0 OID 0)
-- Dependencies: 258
-- Name: COLUMN bas_empresa.id_bas_grupo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_empresa.id_bas_grupo IS 'Grupo de empresas';


--
-- TOC entry 11685 (class 0 OID 0)
-- Dependencies: 258
-- Name: COLUMN bas_empresa.tipo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_empresa.tipo IS '1=Privada e 2=Pública';


--
-- TOC entry 11686 (class 0 OID 0)
-- Dependencies: 258
-- Name: COLUMN bas_empresa.pasta; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_empresa.pasta IS 'nome da pasta para armazenar todos os recursos de uma determinada empresa(fotos,documentos,icones...)';


--
-- TOC entry 11687 (class 0 OID 0)
-- Dependencies: 258
-- Name: COLUMN bas_empresa.portal; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_empresa.portal IS 'site da instituição';


--
-- TOC entry 11688 (class 0 OID 0)
-- Dependencies: 258
-- Name: COLUMN bas_empresa.implantacao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_empresa.implantacao IS 'S = Sim
N = Não
Verifica se a empresa está no periodo de implatanção.';


--
-- TOC entry 11689 (class 0 OID 0)
-- Dependencies: 258
-- Name: COLUMN bas_empresa.envia_email; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_empresa.envia_email IS 'S = Sim
N = Não

Valida se envia e-mail ou não para o responsavel ao finalizar a matricula de um aluno.';


--
-- TOC entry 259 (class 1259 OID 14562877)
-- Name: bas_empresa_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bas_empresa_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_empresa_id_seq OWNER TO postgres;

--
-- TOC entry 11690 (class 0 OID 0)
-- Dependencies: 259
-- Name: bas_empresa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bas_empresa_id_seq OWNED BY public.bas_empresa.id;


SET default_with_oids = false;

--
-- TOC entry 260 (class 1259 OID 14562879)
-- Name: bas_equipamento; Type: TABLE; Schema: public; Owner: pgadmin
--


ALTER TABLE public.bas_equipamento OWNER TO pgadmin;

--
-- TOC entry 11691 (class 0 OID 0)
-- Dependencies: 260
-- Name: COLUMN bas_equipamento.codigo; Type: COMMENT; Schema: public; Owner: pgadmin
--

COMMENT ON COLUMN public.bas_equipamento.codigo IS 'Codigo identificacao do equipamento';


--
-- TOC entry 11692 (class 0 OID 0)
-- Dependencies: 260
-- Name: COLUMN bas_equipamento.nome; Type: COMMENT; Schema: public; Owner: pgadmin
--

COMMENT ON COLUMN public.bas_equipamento.nome IS 'nome do equipamento no estabelecimento';


--
-- TOC entry 11693 (class 0 OID 0)
-- Dependencies: 260
-- Name: COLUMN bas_equipamento.ativo; Type: COMMENT; Schema: public; Owner: pgadmin
--

COMMENT ON COLUMN public.bas_equipamento.ativo IS 'S= sim, N= nâo';


--
-- TOC entry 11694 (class 0 OID 0)
-- Dependencies: 260
-- Name: COLUMN bas_equipamento.login; Type: COMMENT; Schema: public; Owner: pgadmin
--

COMMENT ON COLUMN public.bas_equipamento.login IS 'Login do usuário que fez o registro';


--
-- TOC entry 261 (class 1259 OID 14562887)
-- Name: bas_equipamento_id_seq; Type: SEQUENCE; Schema: public; Owner: pgadmin
--

CREATE SEQUENCE public.bas_equipamento_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_equipamento_id_seq OWNER TO pgadmin;

--
-- TOC entry 11695 (class 0 OID 0)
-- Dependencies: 261
-- Name: bas_equipamento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgadmin
--

ALTER SEQUENCE public.bas_equipamento_id_seq OWNED BY public.bas_equipamento.id;


--
-- TOC entry 262 (class 1259 OID 14562889)
-- Name: bas_equipamento_tipo; Type: TABLE; Schema: public; Owner: postgres
--


ALTER TABLE public.bas_equipamento_tipo OWNER TO postgres;

--
-- TOC entry 263 (class 1259 OID 14562892)
-- Name: bas_equipamento_tipo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bas_equipamento_tipo_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_equipamento_tipo_id_seq OWNER TO postgres;

--
-- TOC entry 11696 (class 0 OID 0)
-- Dependencies: 263
-- Name: bas_equipamento_tipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bas_equipamento_tipo_id_seq OWNED BY public.bas_equipamento_tipo.id;


SET default_with_oids = true;

--
-- TOC entry 264 (class 1259 OID 14562894)
-- Name: bas_estabelecimento; Type: TABLE; Schema: public; Owner: postgres
--


ALTER TABLE public.bas_estabelecimento OWNER TO postgres;

--
-- TOC entry 11697 (class 0 OID 0)
-- Dependencies: 264
-- Name: COLUMN bas_estabelecimento.sms_usuario; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_estabelecimento.sms_usuario IS 'Usuário para envio do SMS';


--
-- TOC entry 11698 (class 0 OID 0)
-- Dependencies: 264
-- Name: COLUMN bas_estabelecimento.sms_senha; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_estabelecimento.sms_senha IS 'Senha para envio do SMS';


--
-- TOC entry 11699 (class 0 OID 0)
-- Dependencies: 264
-- Name: COLUMN bas_estabelecimento.sms_proxy_porta; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_estabelecimento.sms_proxy_porta IS 'Porta do Proxy';


--
-- TOC entry 11700 (class 0 OID 0)
-- Dependencies: 264
-- Name: COLUMN bas_estabelecimento.sms_proxy_user; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_estabelecimento.sms_proxy_user IS 'Usuário do Proxy';


--
-- TOC entry 11701 (class 0 OID 0)
-- Dependencies: 264
-- Name: COLUMN bas_estabelecimento.sms_proxy_senha; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_estabelecimento.sms_proxy_senha IS 'Senha do Proxy';


--
-- TOC entry 11702 (class 0 OID 0)
-- Dependencies: 264
-- Name: COLUMN bas_estabelecimento.sms_proxy_ip; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_estabelecimento.sms_proxy_ip IS 'IP do proxy';


--
-- TOC entry 11703 (class 0 OID 0)
-- Dependencies: 264
-- Name: COLUMN bas_estabelecimento.mail_smtp_server; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_estabelecimento.mail_smtp_server IS 'Servidor de envio de e-mail smtp';


--
-- TOC entry 11704 (class 0 OID 0)
-- Dependencies: 264
-- Name: COLUMN bas_estabelecimento.mail_smtp_user; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_estabelecimento.mail_smtp_user IS 'Usuário do servidor smtp';


--
-- TOC entry 11705 (class 0 OID 0)
-- Dependencies: 264
-- Name: COLUMN bas_estabelecimento.mail_smtp_pass; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_estabelecimento.mail_smtp_pass IS 'Senha do servidor smtp';


--
-- TOC entry 11706 (class 0 OID 0)
-- Dependencies: 264
-- Name: COLUMN bas_estabelecimento.mail_from; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_estabelecimento.mail_from IS 'Remetente do e-mail';


--
-- TOC entry 11707 (class 0 OID 0)
-- Dependencies: 264
-- Name: COLUMN bas_estabelecimento.id_bas_colaborador_recebe_email_atendimento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_estabelecimento.id_bas_colaborador_recebe_email_atendimento IS 'Colaborador que receberá um e-mail de notificação de atendimento médico do aluno.';


--
-- TOC entry 11708 (class 0 OID 0)
-- Dependencies: 264
-- Name: COLUMN bas_estabelecimento.id_sgf_nfse_estabelecimento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_estabelecimento.id_sgf_nfse_estabelecimento IS 'Configuração para NFS-e Municipal';


--
-- TOC entry 11709 (class 0 OID 0)
-- Dependencies: 264
-- Name: COLUMN bas_estabelecimento.matriz; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_estabelecimento.matriz IS 'Campo para indicar qual o estabelecimento matriz. Esse campo indicará por exemplo, qual o servidor smtp utilizado para envio de e-mail na pré-matricula';


--
-- TOC entry 11710 (class 0 OID 0)
-- Dependencies: 264
-- Name: COLUMN bas_estabelecimento.tipo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_estabelecimento.tipo IS 'E=Escola, A=Almoxarifado, B=Biblioteca...';


SET default_with_oids = false;

--
-- TOC entry 265 (class 1259 OID 14562901)
-- Name: bas_estabelecimento_dias_letivos; Type: TABLE; Schema: public; Owner: infocraftread
--

ALTER TABLE public.bas_estabelecimento_dias_letivos OWNER TO infocraftread;

--
-- TOC entry 266 (class 1259 OID 14562904)
-- Name: bas_estabelecimento_dias_letivos_id_seq; Type: SEQUENCE; Schema: public; Owner: infocraftread
--

CREATE SEQUENCE public.bas_estabelecimento_dias_letivos_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_estabelecimento_dias_letivos_id_seq OWNER TO infocraftread;

--
-- TOC entry 11711 (class 0 OID 0)
-- Dependencies: 266
-- Name: bas_estabelecimento_dias_letivos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: infocraftread
--

ALTER SEQUENCE public.bas_estabelecimento_dias_letivos_id_seq OWNED BY public.bas_estabelecimento_dias_letivos.id;


--
-- TOC entry 267 (class 1259 OID 14562906)
-- Name: bas_estabelecimento_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bas_estabelecimento_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_estabelecimento_id_seq OWNER TO postgres;

--
-- TOC entry 11712 (class 0 OID 0)
-- Dependencies: 267
-- Name: bas_estabelecimento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bas_estabelecimento_id_seq OWNED BY public.bas_estabelecimento.id;


--
-- TOC entry 268 (class 1259 OID 14562908)
-- Name: bas_estabelecimento_resumo_ano; Type: TABLE; Schema: public; Owner: postgres
--


ALTER TABLE public.bas_estabelecimento_resumo_ano OWNER TO postgres;

--
-- TOC entry 269 (class 1259 OID 14562911)
-- Name: bas_estabelecimento_resumo_ano_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bas_estabelecimento_resumo_ano_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_estabelecimento_resumo_ano_id_seq OWNER TO postgres;

--
-- TOC entry 11713 (class 0 OID 0)
-- Dependencies: 269
-- Name: bas_estabelecimento_resumo_ano_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bas_estabelecimento_resumo_ano_id_seq OWNED BY public.bas_estabelecimento_resumo_ano.id;


--
-- TOC entry 270 (class 1259 OID 14562913)
-- Name: bas_estabelecimento_setor_mes_falta; Type: TABLE; Schema: public; Owner: infocraftread
--


ALTER TABLE public.bas_estabelecimento_setor_mes_falta OWNER TO infocraftread;

--
-- TOC entry 271 (class 1259 OID 14562919)
-- Name: bas_estabelecimento_setor_mes_falta_id_seq; Type: SEQUENCE; Schema: public; Owner: infocraftread
--

CREATE SEQUENCE public.bas_estabelecimento_setor_mes_falta_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_estabelecimento_setor_mes_falta_id_seq OWNER TO infocraftread;

--
-- TOC entry 11714 (class 0 OID 0)
-- Dependencies: 271
-- Name: bas_estabelecimento_setor_mes_falta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: infocraftread
--

ALTER SEQUENCE public.bas_estabelecimento_setor_mes_falta_id_seq OWNED BY public.bas_estabelecimento_setor_mes_falta.id;


SET default_with_oids = true;

--
-- TOC entry 272 (class 1259 OID 14562921)
-- Name: bas_estado_civil; Type: TABLE; Schema: public; Owner: postgres
--


ALTER TABLE public.bas_estado_civil OWNER TO postgres;

--
-- TOC entry 273 (class 1259 OID 14562924)
-- Name: bas_estado_civil_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bas_estado_civil_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_estado_civil_id_seq OWNER TO postgres;

--
-- TOC entry 11715 (class 0 OID 0)
-- Dependencies: 273
-- Name: bas_estado_civil_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bas_estado_civil_id_seq OWNED BY public.bas_estado_civil.id;


SET default_with_oids = false;

--
-- TOC entry 274 (class 1259 OID 14562926)
-- Name: bas_fabricante; Type: TABLE; Schema: public; Owner: postgres
--


ALTER TABLE public.bas_fabricante OWNER TO postgres;

--
-- TOC entry 275 (class 1259 OID 14562929)
-- Name: bas_fabricante_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bas_fabricante_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_fabricante_id_seq OWNER TO postgres;

--
-- TOC entry 11716 (class 0 OID 0)
-- Dependencies: 275
-- Name: bas_fabricante_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bas_fabricante_id_seq OWNED BY public.bas_fabricante.id;


--
-- TOC entry 276 (class 1259 OID 14562931)
-- Name: bas_feriado; Type: TABLE; Schema: public; Owner: postgres
--


ALTER TABLE public.bas_feriado OWNER TO postgres;

--
-- TOC entry 277 (class 1259 OID 14562934)
-- Name: bas_feriado_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bas_feriado_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_feriado_id_seq OWNER TO postgres;

--
-- TOC entry 11717 (class 0 OID 0)
-- Dependencies: 277
-- Name: bas_feriado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bas_feriado_id_seq OWNED BY public.bas_feriado.id;


--
-- TOC entry 278 (class 1259 OID 14562936)
-- Name: bas_fornecedor; Type: TABLE; Schema: public; Owner: postgres
--


ALTER TABLE public.bas_fornecedor OWNER TO postgres;

--
-- TOC entry 11718 (class 0 OID 0)
-- Dependencies: 278
-- Name: COLUMN bas_fornecedor.ativo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_fornecedor.ativo IS 'S = Sim, N = Não';


--
-- TOC entry 11719 (class 0 OID 0)
-- Dependencies: 278
-- Name: COLUMN bas_fornecedor.pessoa_contato; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_fornecedor.pessoa_contato IS 'Pessoa para contato do Fornecedor';


--
-- TOC entry 279 (class 1259 OID 14562939)
-- Name: bas_fornecedor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bas_fornecedor_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_fornecedor_id_seq OWNER TO postgres;

--
-- TOC entry 11720 (class 0 OID 0)
-- Dependencies: 279
-- Name: bas_fornecedor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bas_fornecedor_id_seq OWNED BY public.bas_fornecedor.id;


SET default_with_oids = true;

--
-- TOC entry 280 (class 1259 OID 14562941)
-- Name: bas_funcao; Type: TABLE; Schema: public; Owner: postgres
--


ALTER TABLE public.bas_funcao OWNER TO postgres;

--
-- TOC entry 11721 (class 0 OID 0)
-- Dependencies: 280
-- Name: COLUMN bas_funcao.tipo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_funcao.tipo IS 'F=usado em funcionario e R=usado em responsável';


--
-- TOC entry 11722 (class 0 OID 0)
-- Dependencies: 280
-- Name: COLUMN bas_funcao.cbo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_funcao.cbo IS 'Código Brasileiro de Ocupação';


--
-- TOC entry 281 (class 1259 OID 14562944)
-- Name: bas_funcao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bas_funcao_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_funcao_id_seq OWNER TO postgres;

--
-- TOC entry 11723 (class 0 OID 0)
-- Dependencies: 281
-- Name: bas_funcao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bas_funcao_id_seq OWNED BY public.bas_funcao.id;


--
-- TOC entry 282 (class 1259 OID 14562946)
-- Name: bas_grau_instrucao; Type: TABLE; Schema: public; Owner: postgres
--


ALTER TABLE public.bas_grau_instrucao OWNER TO postgres;

--
-- TOC entry 11724 (class 0 OID 0)
-- Dependencies: 282
-- Name: COLUMN bas_grau_instrucao.cso_professor_escolaridade; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_grau_instrucao.cso_professor_escolaridade IS 'Codigos de Escolaridade do censo:

1 - Fundamental Incompleto
2 - Fundamental Completo
3 - Ensino Médio Normal / Magistério
4 - Ensino Médio Normal / Magistério - Indígena
5 - Ensino Médio
6 - Ensino Superior';


--
-- TOC entry 283 (class 1259 OID 14562949)
-- Name: bas_grau_instrucao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bas_grau_instrucao_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_grau_instrucao_id_seq OWNER TO postgres;

--
-- TOC entry 11725 (class 0 OID 0)
-- Dependencies: 283
-- Name: bas_grau_instrucao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bas_grau_instrucao_id_seq OWNED BY public.bas_grau_instrucao.id;


SET default_with_oids = false;

--
-- TOC entry 284 (class 1259 OID 14562951)
-- Name: bas_grau_parentesco; Type: TABLE; Schema: public; Owner: postgres
--


ALTER TABLE public.bas_grau_parentesco OWNER TO postgres;

--
-- TOC entry 285 (class 1259 OID 14562954)
-- Name: bas_grau_parentesco_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bas_grau_parentesco_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_grau_parentesco_id_seq OWNER TO postgres;

--
-- TOC entry 11726 (class 0 OID 0)
-- Dependencies: 285
-- Name: bas_grau_parentesco_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bas_grau_parentesco_id_seq OWNED BY public.bas_grau_parentesco.id;


SET default_with_oids = true;

--
-- TOC entry 286 (class 1259 OID 14562956)
-- Name: bas_grupo; Type: TABLE; Schema: public; Owner: postgres
--

ALTER TABLE public.bas_grupo OWNER TO postgres;

--
-- TOC entry 11727 (class 0 OID 0)
-- Dependencies: 286
-- Name: COLUMN bas_grupo.imagem; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_grupo.imagem IS 'Nome da imagem da empresa';


--
-- TOC entry 11728 (class 0 OID 0)
-- Dependencies: 286
-- Name: COLUMN bas_grupo.img_login; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_grupo.img_login IS 'Imagem que fica localizada na tela de login';


--
-- TOC entry 287 (class 1259 OID 14562962)
-- Name: bas_grupo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bas_grupo_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_grupo_id_seq OWNER TO postgres;

--
-- TOC entry 11729 (class 0 OID 0)
-- Dependencies: 287
-- Name: bas_grupo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bas_grupo_id_seq OWNED BY public.bas_grupo.id;


SET default_with_oids = false;

--
-- TOC entry 288 (class 1259 OID 14562964)
-- Name: bas_idioma; Type: TABLE; Schema: public; Owner: postgres
--


ALTER TABLE public.bas_idioma OWNER TO postgres;

--
-- TOC entry 289 (class 1259 OID 14562967)
-- Name: bas_idioma_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bas_idioma_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_idioma_id_seq OWNER TO postgres;

--
-- TOC entry 11730 (class 0 OID 0)
-- Dependencies: 289
-- Name: bas_idioma_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bas_idioma_id_seq OWNED BY public.bas_idioma.id;


--
-- TOC entry 290 (class 1259 OID 14562969)
-- Name: bas_marca_equipamento; Type: TABLE; Schema: public; Owner: postgres
--


ALTER TABLE public.bas_marca_equipamento OWNER TO postgres;

--
-- TOC entry 291 (class 1259 OID 14562972)
-- Name: bas_marca_equipamento_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bas_marca_equipamento_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_marca_equipamento_id_seq OWNER TO postgres;

--
-- TOC entry 11731 (class 0 OID 0)
-- Dependencies: 291
-- Name: bas_marca_equipamento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bas_marca_equipamento_id_seq OWNED BY public.bas_marca_equipamento.id;


--
-- TOC entry 292 (class 1259 OID 14562974)
-- Name: bas_mensagem; Type: TABLE; Schema: public; Owner: postgres
--


ALTER TABLE public.bas_mensagem OWNER TO postgres;

--
-- TOC entry 11732 (class 0 OID 0)
-- Dependencies: 292
-- Name: TABLE bas_mensagem; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.bas_mensagem IS 'Tabela para registro de mensagens entre usuários do sistema';


--
-- TOC entry 11733 (class 0 OID 0)
-- Dependencies: 292
-- Name: COLUMN bas_mensagem.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_mensagem.id IS 'Chave primária composta ao lado de id_bas_empresa, sequencial';


--
-- TOC entry 11734 (class 0 OID 0)
-- Dependencies: 292
-- Name: COLUMN bas_mensagem.id_bas_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_mensagem.id_bas_empresa IS 'Chave estrangeira da tabela bas_empresa e chave primária ao lado do campo id';


--
-- TOC entry 11735 (class 0 OID 0)
-- Dependencies: 292
-- Name: COLUMN bas_mensagem.login; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_mensagem.login IS 'Chave estrangeira da tabela seg_user ao lado do campo id_bas_empresa';


--
-- TOC entry 11736 (class 0 OID 0)
-- Dependencies: 292
-- Name: COLUMN bas_mensagem.assunto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_mensagem.assunto IS 'Assunto da mensagem';


--
-- TOC entry 11737 (class 0 OID 0)
-- Dependencies: 292
-- Name: COLUMN bas_mensagem.conteudo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_mensagem.conteudo IS 'Conteúdo da mensagem';


--
-- TOC entry 11738 (class 0 OID 0)
-- Dependencies: 292
-- Name: COLUMN bas_mensagem.data_hora; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_mensagem.data_hora IS 'Data e hora da gravação do registro (envio da mensagem)';


SET default_with_oids = true;

--
-- TOC entry 293 (class 1259 OID 14562981)
-- Name: bas_mensagem_email; Type: TABLE; Schema: public; Owner: postgres
--


ALTER TABLE public.bas_mensagem_email OWNER TO postgres;

--
-- TOC entry 294 (class 1259 OID 14562987)
-- Name: bas_mensagem_email_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bas_mensagem_email_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_mensagem_email_id_seq OWNER TO postgres;

--
-- TOC entry 11739 (class 0 OID 0)
-- Dependencies: 294
-- Name: bas_mensagem_email_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bas_mensagem_email_id_seq OWNED BY public.bas_mensagem_email.id;


SET default_with_oids = false;

--
-- TOC entry 295 (class 1259 OID 14562989)
-- Name: bas_mensagem_enviada; Type: TABLE; Schema: public; Owner: postgres
--


ALTER TABLE public.bas_mensagem_enviada OWNER TO postgres;

--
-- TOC entry 11740 (class 0 OID 0)
-- Dependencies: 295
-- Name: COLUMN bas_mensagem_enviada.erro; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_mensagem_enviada.erro IS '"S" = Sim, "N" = Não';


--
-- TOC entry 11741 (class 0 OID 0)
-- Dependencies: 295
-- Name: COLUMN bas_mensagem_enviada.tipo_mensagem; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_mensagem_enviada.tipo_mensagem IS '"E" = e-mail, "S" = sms';


--
-- TOC entry 296 (class 1259 OID 14562995)
-- Name: bas_mensagem_enviada_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bas_mensagem_enviada_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_mensagem_enviada_id_seq OWNER TO postgres;

--
-- TOC entry 11742 (class 0 OID 0)
-- Dependencies: 296
-- Name: bas_mensagem_enviada_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bas_mensagem_enviada_id_seq OWNED BY public.bas_mensagem_enviada.id;


--
-- TOC entry 297 (class 1259 OID 14562997)
-- Name: bas_mensagem_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bas_mensagem_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_mensagem_id_seq OWNER TO postgres;

--
-- TOC entry 11743 (class 0 OID 0)
-- Dependencies: 297
-- Name: bas_mensagem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bas_mensagem_id_seq OWNED BY public.bas_mensagem.id;


SET default_with_oids = true;

--
-- TOC entry 298 (class 1259 OID 14562999)
-- Name: bas_mensagem_sms; Type: TABLE; Schema: public; Owner: postgres
--


ALTER TABLE public.bas_mensagem_sms OWNER TO postgres;

--
-- TOC entry 299 (class 1259 OID 14563002)
-- Name: bas_mensagem_sms_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bas_mensagem_sms_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_mensagem_sms_id_seq OWNER TO postgres;

--
-- TOC entry 11744 (class 0 OID 0)
-- Dependencies: 299
-- Name: bas_mensagem_sms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bas_mensagem_sms_id_seq OWNED BY public.bas_mensagem_sms.id;


--
-- TOC entry 300 (class 1259 OID 14563004)
-- Name: bas_mensagem_tipo; Type: TABLE; Schema: public; Owner: postgres
--


ALTER TABLE public.bas_mensagem_tipo OWNER TO postgres;

--
-- TOC entry 301 (class 1259 OID 14563007)
-- Name: bas_mensagem_tipo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bas_mensagem_tipo_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_mensagem_tipo_id_seq OWNER TO postgres;

--
-- TOC entry 11745 (class 0 OID 0)
-- Dependencies: 301
-- Name: bas_mensagem_tipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bas_mensagem_tipo_id_seq OWNED BY public.bas_mensagem_tipo.id;


SET default_with_oids = false;

--
-- TOC entry 302 (class 1259 OID 14563009)
-- Name: bas_mensagem_usuario; Type: TABLE; Schema: public; Owner: postgres
--


ALTER TABLE public.bas_mensagem_usuario OWNER TO postgres;

--
-- TOC entry 11746 (class 0 OID 0)
-- Dependencies: 302
-- Name: TABLE bas_mensagem_usuario; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.bas_mensagem_usuario IS 'Ligação entre a tabela de mensagens e os usuários destinatários.';


--
-- TOC entry 11747 (class 0 OID 0)
-- Dependencies: 302
-- Name: COLUMN bas_mensagem_usuario.id_bas_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_mensagem_usuario.id_bas_empresa IS 'Chave estrangeira da tabela bas_empresa e chave primária ao lado dos campos id_bas_mensagem e login';


--
-- TOC entry 11748 (class 0 OID 0)
-- Dependencies: 302
-- Name: COLUMN bas_mensagem_usuario.id_bas_mensagem; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_mensagem_usuario.id_bas_mensagem IS 'Chave estrangeira da tabela bas_mensagem ao lado do campo id_bas_empresa e chave primária ao lado dos campos id_bas_empresa e login';


--
-- TOC entry 11749 (class 0 OID 0)
-- Dependencies: 302
-- Name: COLUMN bas_mensagem_usuario.login; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_mensagem_usuario.login IS 'Chave estrangeira da tabela seg_users e chave primária ao lado dos campos id_bas_empresa e bas_mensagem';


--
-- TOC entry 11750 (class 0 OID 0)
-- Dependencies: 302
-- Name: COLUMN bas_mensagem_usuario.lida; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_mensagem_usuario.lida IS 'Indica se a mensagem foi lida. ("S" = "Sim" e "N" = "Não)';


--
-- TOC entry 303 (class 1259 OID 14563016)
-- Name: bas_nivel_servidor; Type: TABLE; Schema: public; Owner: infocraftread
--



ALTER TABLE public.bas_nivel_servidor OWNER TO infocraftread;

--
-- TOC entry 304 (class 1259 OID 14563019)
-- Name: bas_nivel_servidor_id_seq; Type: SEQUENCE; Schema: public; Owner: infocraftread
--

CREATE SEQUENCE public.bas_nivel_servidor_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_nivel_servidor_id_seq OWNER TO infocraftread;

--
-- TOC entry 11751 (class 0 OID 0)
-- Dependencies: 304
-- Name: bas_nivel_servidor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: infocraftread
--

ALTER SEQUENCE public.bas_nivel_servidor_id_seq OWNED BY public.bas_nivel_servidor.id;


--
-- TOC entry 1291 (class 1259 OID 17129573)
-- Name: bas_ocorrencia_reclamacao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bas_ocorrencia_reclamacao (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 data_registro date,
 hora_registro time without time zone,
 nome_reclamante character varying(100),
 rg_reclamante character varying(50),
 cpf_reclamante character varying(11),
 profissao_reclamante character varying(100),
 telefone_reclamante character varying(11),
 email_reclamante character varying(150),
 data_ocorrencia date,
 hora_ocorrencia time without time zone,
 local_ocorrencia character varying(150),
 assunto_ocorrencia character varying(200),
 descricao_ocorrencia text,
 status_ocorrencia character(1),
 id_bas_centro_custo bigint NOT NULL,
 id_seg_login character varying(32) NOT NULL
);


ALTER TABLE public.bas_ocorrencia_reclamacao OWNER TO postgres;

--
-- TOC entry 1290 (class 1259 OID 17129571)
-- Name: bas_ocorrencia_reclamacao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bas_ocorrencia_reclamacao_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_ocorrencia_reclamacao_id_seq OWNER TO postgres;

--
-- TOC entry 11752 (class 0 OID 0)
-- Dependencies: 1290
-- Name: bas_ocorrencia_reclamacao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bas_ocorrencia_reclamacao_id_seq OWNED BY public.bas_ocorrencia_reclamacao.id;


--
-- TOC entry 1293 (class 1259 OID 17129584)
-- Name: bas_ocorrencia_reclamacao_parecer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bas_ocorrencia_reclamacao_parecer (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_ocorrencia_reclamacao bigint NOT NULL,
 data_acao date NOT NULL,
 acao text NOT NULL
);


ALTER TABLE public.bas_ocorrencia_reclamacao_parecer OWNER TO postgres;

--
-- TOC entry 1292 (class 1259 OID 17129582)
-- Name: bas_ocorrencia_reclamacao_parecer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bas_ocorrencia_reclamacao_parecer_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_ocorrencia_reclamacao_parecer_id_seq OWNER TO postgres;

--
-- TOC entry 11753 (class 0 OID 0)
-- Dependencies: 1292
-- Name: bas_ocorrencia_reclamacao_parecer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bas_ocorrencia_reclamacao_parecer_id_seq OWNED BY public.bas_ocorrencia_reclamacao_parecer.id;


--
-- TOC entry 305 (class 1259 OID 14563021)
-- Name: bas_outros_documentos; Type: TABLE; Schema: public; Owner: infocraftread
--

CREATE TABLE public.bas_outros_documentos (
 id bigint NOT NULL,
 nome character varying(50) NOT NULL,
 sigla character varying(3) NOT NULL
);


ALTER TABLE public.bas_outros_documentos OWNER TO infocraftread;

--
-- TOC entry 306 (class 1259 OID 14563024)
-- Name: bas_outros_documentos_id_seq; Type: SEQUENCE; Schema: public; Owner: infocraftread
--

CREATE SEQUENCE public.bas_outros_documentos_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_outros_documentos_id_seq OWNER TO infocraftread;

--
-- TOC entry 11754 (class 0 OID 0)
-- Dependencies: 306
-- Name: bas_outros_documentos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: infocraftread
--

ALTER SEQUENCE public.bas_outros_documentos_id_seq OWNED BY public.bas_outros_documentos.id;


--
-- TOC entry 307 (class 1259 OID 14563026)
-- Name: bas_pergunta; Type: TABLE; Schema: public; Owner: pgadmin
--

CREATE TABLE public.bas_pergunta (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(300) NOT NULL,
 tipo_resposta character(1) NOT NULL,
 id_bas_anamnese_categoria_pergunta bigint
);


ALTER TABLE public.bas_pergunta OWNER TO pgadmin;

--
-- TOC entry 11755 (class 0 OID 0)
-- Dependencies: 307
-- Name: COLUMN bas_pergunta.tipo_resposta; Type: COMMENT; Schema: public; Owner: pgadmin
--

COMMENT ON COLUMN public.bas_pergunta.tipo_resposta IS 'S para select e T para texto';


--
-- TOC entry 308 (class 1259 OID 14563029)
-- Name: bas_pergunta_id_seq; Type: SEQUENCE; Schema: public; Owner: pgadmin
--

CREATE SEQUENCE public.bas_pergunta_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_pergunta_id_seq OWNER TO pgadmin;

--
-- TOC entry 11756 (class 0 OID 0)
-- Dependencies: 308
-- Name: bas_pergunta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgadmin
--

ALTER SEQUENCE public.bas_pergunta_id_seq OWNED BY public.bas_pergunta.id;


--
-- TOC entry 309 (class 1259 OID 14563031)
-- Name: bas_pergunta_resposta; Type: TABLE; Schema: public; Owner: pgadmin
--

CREATE TABLE public.bas_pergunta_resposta (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_pergunta bigint NOT NULL,
 id_bas_resposta bigint NOT NULL
);


ALTER TABLE public.bas_pergunta_resposta OWNER TO pgadmin;

--
-- TOC entry 11757 (class 0 OID 0)
-- Dependencies: 309
-- Name: COLUMN bas_pergunta_resposta.id_bas_resposta; Type: COMMENT; Schema: public; Owner: pgadmin
--

COMMENT ON COLUMN public.bas_pergunta_resposta.id_bas_resposta IS 'para tipo select';


--
-- TOC entry 310 (class 1259 OID 14563034)
-- Name: bas_pergunta_resposta_id_seq; Type: SEQUENCE; Schema: public; Owner: pgadmin
--

CREATE SEQUENCE public.bas_pergunta_resposta_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_pergunta_resposta_id_seq OWNER TO pgadmin;

--
-- TOC entry 11758 (class 0 OID 0)
-- Dependencies: 310
-- Name: bas_pergunta_resposta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgadmin
--

ALTER SEQUENCE public.bas_pergunta_resposta_id_seq OWNED BY public.bas_pergunta_resposta.id;


--
-- TOC entry 311 (class 1259 OID 14563036)
-- Name: bas_pessoa_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bas_pessoa_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_pessoa_id_seq OWNER TO postgres;

SET default_with_oids = true;

--
-- TOC entry 312 (class 1259 OID 14563038)
-- Name: bas_pessoa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bas_pessoa (
 id bigint DEFAULT nextval('public.bas_pessoa_id_seq'::regclass) NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(100) NOT NULL,
 email character varying(60),
 tipo_pessoa character(1) DEFAULT 'F'::bpchar
);


ALTER TABLE public.bas_pessoa OWNER TO postgres;

--
-- TOC entry 11759 (class 0 OID 0)
-- Dependencies: 312
-- Name: COLUMN bas_pessoa.tipo_pessoa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_pessoa.tipo_pessoa IS 'F=fisica e J=juridica';


SET default_with_oids = false;

--
-- TOC entry 313 (class 1259 OID 14563043)
-- Name: bas_pessoa_cnh; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bas_pessoa_cnh (
 id bigint NOT NULL,
 registro character varying(12),
 categoria character varying(11),
 validade date,
 primeira_habilitacao date,
 observacao character varying(200),
 permissao character varying(20),
 acc character varying(10),
 data_emissao date,
 numero_espelho character varying(10),
 numero_renach character varying(12),
 id_bas_pessoa bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_cso_uf bigint NOT NULL,
 id_cso_municipio bigint NOT NULL
);


ALTER TABLE public.bas_pessoa_cnh OWNER TO postgres;

--
-- TOC entry 314 (class 1259 OID 14563046)
-- Name: bas_pessoa_cnh_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bas_pessoa_cnh_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_pessoa_cnh_id_seq OWNER TO postgres;

--
-- TOC entry 11760 (class 0 OID 0)
-- Dependencies: 314
-- Name: bas_pessoa_cnh_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bas_pessoa_cnh_id_seq OWNED BY public.bas_pessoa_cnh.id;


SET default_with_oids = true;

--
-- TOC entry 315 (class 1259 OID 14563048)
-- Name: bas_pessoa_conta_bancaria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bas_pessoa_conta_bancaria (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_pessoa bigint NOT NULL,
 id_sgf_banco bigint,
 agencia character varying(7) NOT NULL,
 agencia_dv character(2) NOT NULL,
 conta character varying(20) NOT NULL,
 conta_dv character(2) NOT NULL,
 tipo character(1) NOT NULL,
 operacao character varying(4),
 contato_nome character varying(100),
 contato_cargo character varying(64),
 contato_ddd integer,
 contato_telefone integer
);


ALTER TABLE public.bas_pessoa_conta_bancaria OWNER TO postgres;

--
-- TOC entry 11761 (class 0 OID 0)
-- Dependencies: 315
-- Name: COLUMN bas_pessoa_conta_bancaria.agencia_dv; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_pessoa_conta_bancaria.agencia_dv IS 'digito da agencia';


--
-- TOC entry 11762 (class 0 OID 0)
-- Dependencies: 315
-- Name: COLUMN bas_pessoa_conta_bancaria.conta_dv; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_pessoa_conta_bancaria.conta_dv IS 'digito da conta';


--
-- TOC entry 11763 (class 0 OID 0)
-- Dependencies: 315
-- Name: COLUMN bas_pessoa_conta_bancaria.tipo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_pessoa_conta_bancaria.tipo IS 'C=corrente e P=poupanca';


--
-- TOC entry 316 (class 1259 OID 14563051)
-- Name: bas_pessoa_conta_bancaria_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bas_pessoa_conta_bancaria_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_pessoa_conta_bancaria_id_seq OWNER TO postgres;

--
-- TOC entry 11764 (class 0 OID 0)
-- Dependencies: 316
-- Name: bas_pessoa_conta_bancaria_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bas_pessoa_conta_bancaria_id_seq OWNED BY public.bas_pessoa_conta_bancaria.id;


SET default_with_oids = false;

--
-- TOC entry 317 (class 1259 OID 14563053)
-- Name: bas_pessoa_coordenador; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bas_pessoa_coordenador (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_pessoa_coordenador bigint NOT NULL,
 id_bas_pessoa_coordenado bigint NOT NULL,
 id_sge_curso bigint,
 data_inicial date NOT NULL,
 data_final date,
 data_registro timestamp without time zone
);


ALTER TABLE public.bas_pessoa_coordenador OWNER TO postgres;

--
-- TOC entry 318 (class 1259 OID 14563056)
-- Name: bas_pessoa_coordenador_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bas_pessoa_coordenador_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_pessoa_coordenador_id_seq OWNER TO postgres;

--
-- TOC entry 11765 (class 0 OID 0)
-- Dependencies: 318
-- Name: bas_pessoa_coordenador_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bas_pessoa_coordenador_id_seq OWNED BY public.bas_pessoa_coordenador.id;


SET default_with_oids = true;

--
-- TOC entry 319 (class 1259 OID 14563058)
-- Name: bas_pessoa_endereco; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bas_pessoa_endereco (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_pessoa bigint NOT NULL,
 tipo_endereco character(1),
 logradouro character varying(100),
 numero character varying(15),
 bairro character varying(50),
 cidade character varying(50),
 cep character varying(10),
 uf character(2),
 complemento character varying(50),
 id_cso_municipio bigint
);


ALTER TABLE public.bas_pessoa_endereco OWNER TO postgres;

--
-- TOC entry 11766 (class 0 OID 0)
-- Dependencies: 319
-- Name: COLUMN bas_pessoa_endereco.tipo_endereco; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_pessoa_endereco.tipo_endereco IS 'R=residencial / C=comercial';


--
-- TOC entry 11767 (class 0 OID 0)
-- Dependencies: 319
-- Name: COLUMN bas_pessoa_endereco.complemento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_pessoa_endereco.complemento IS 'Ponto de referencia do endereco';


--
-- TOC entry 320 (class 1259 OID 14563061)
-- Name: bas_pessoa_endereco_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bas_pessoa_endereco_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_pessoa_endereco_id_seq OWNER TO postgres;

--
-- TOC entry 11768 (class 0 OID 0)
-- Dependencies: 320
-- Name: bas_pessoa_endereco_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bas_pessoa_endereco_id_seq OWNED BY public.bas_pessoa_endereco.id;


--
-- TOC entry 321 (class 1259 OID 14563063)
-- Name: bas_pessoa_fisica; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bas_pessoa_fisica (
 id_bas_pessoa bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_grau_instrucao bigint,
 id_bas_raca_cor bigint,
 tipo_sanguineo character varying(3),
 sexo character(1),
 id_bas_estado_civil bigint,
 data_nascimento date,
 id_cso_municipio bigint,
 nacionalidade character(1),
 id_cso_pais bigint,
 cpf character varying(16),
 rg character varying(255),
 id_cso_orgao_emissor bigint,
 id_cso_uf_identidade bigint,
 rg_data_expedicao date,
 titulo_numero character varying(20),
 titulo_zona character varying(10),
 titulo_secao character varying(10),
 titulo_uf character(2),
 reservista_numero character varying(20),
 reservista_tipo character varying(10),
 reservista_data date,
 reservista_rm character varying(10),
 reservista_csm character varying(10),
 foto text,
 ctps character varying(20),
 ctps_serie character varying(20),
 ctps_uf character(2),
 pis character varying(20),
 conjuge character varying(100),
 id_bas_religiao bigint,
 id_seg_login character varying(32),
 nome_reduzido character varying(50),
 altura numeric(3,2),
 peso numeric(5,2),
 habilidades character varying(100),
 numero_dependentes smallint,
 cnh character varying(11),
 categoria character(1),
 calca numeric(2,0),
 saia numeric(2,0),
 camisa numeric(2,0),
 sapato numeric(2,0),
 coturno numeric(2,0),
 cobertura numeric(2,0),
 superior_tecnico character varying(100),
 rg_complemento character varying(4),
 numero_bolsa_familia character varying(50),
 cartao_sus character(15),
 artao_sus character(15),
 falecido character(1) DEFAULT 0,
 mao_escrita character(1)
);


ALTER TABLE public.bas_pessoa_fisica OWNER TO postgres;

--
-- TOC entry 11769 (class 0 OID 0)
-- Dependencies: 321
-- Name: COLUMN bas_pessoa_fisica.tipo_sanguineo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_pessoa_fisica.tipo_sanguineo IS 'a+, a-, b+, b-, ab+, ab-, o+ e o-';


--
-- TOC entry 11770 (class 0 OID 0)
-- Dependencies: 321
-- Name: COLUMN bas_pessoa_fisica.sexo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_pessoa_fisica.sexo IS 'F=feminino e M=masculino';


--
-- TOC entry 11771 (class 0 OID 0)
-- Dependencies: 321
-- Name: COLUMN bas_pessoa_fisica.nacionalidade; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_pessoa_fisica.nacionalidade IS '1=Brasileira, 2=Brasileira: nascido no exterior ou naturalizado e 3=Estrangeira';


--
-- TOC entry 11772 (class 0 OID 0)
-- Dependencies: 321
-- Name: COLUMN bas_pessoa_fisica.id_cso_pais; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_pessoa_fisica.id_cso_pais IS 'Identificador da tabela cso_pais';


--
-- TOC entry 11773 (class 0 OID 0)
-- Dependencies: 321
-- Name: COLUMN bas_pessoa_fisica.id_cso_orgao_emissor; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_pessoa_fisica.id_cso_orgao_emissor IS 'identificador da tabela cso_orgao_emissor';


--
-- TOC entry 11774 (class 0 OID 0)
-- Dependencies: 321
-- Name: COLUMN bas_pessoa_fisica.id_cso_uf_identidade; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_pessoa_fisica.id_cso_uf_identidade IS 'identificador da tabela cso_uf';


--
-- TOC entry 11775 (class 0 OID 0)
-- Dependencies: 321
-- Name: COLUMN bas_pessoa_fisica.ctps; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_pessoa_fisica.ctps IS 'Carteira de trabalho';


--
-- TOC entry 11776 (class 0 OID 0)
-- Dependencies: 321
-- Name: COLUMN bas_pessoa_fisica.numero_bolsa_familia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_pessoa_fisica.numero_bolsa_familia IS 'Número do bolsa família.';


--
-- TOC entry 11777 (class 0 OID 0)
-- Dependencies: 321
-- Name: COLUMN bas_pessoa_fisica.cartao_sus; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_pessoa_fisica.cartao_sus IS 'Número do cartão do sus';


--
-- TOC entry 11778 (class 0 OID 0)
-- Dependencies: 321
-- Name: COLUMN bas_pessoa_fisica.falecido; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_pessoa_fisica.falecido IS '1=Falecido, 0=Não Falecido';


--
-- TOC entry 322 (class 1259 OID 14563070)
-- Name: bas_pessoa_juridica; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bas_pessoa_juridica (
 id_bas_pessoa bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_ramo_atividade bigint,
 razao_social character varying(100) NOT NULL,
 cnpj character varying(16),
 inscricao_estadual character varying(50),
 inscricao_municipal character varying(50),
 site character varying(60)
);


ALTER TABLE public.bas_pessoa_juridica OWNER TO postgres;

--
-- TOC entry 323 (class 1259 OID 14563073)
-- Name: bas_pessoa_telefone; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bas_pessoa_telefone (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_pessoa bigint NOT NULL,
 tipo_telefone character(1),
 telefone character varying(11)
);


ALTER TABLE public.bas_pessoa_telefone OWNER TO postgres;

--
-- TOC entry 11779 (class 0 OID 0)
-- Dependencies: 323
-- Name: COLUMN bas_pessoa_telefone.tipo_telefone; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_pessoa_telefone.tipo_telefone IS 'R=residencial, C=comercial, L=celular, E=recado';


--
-- TOC entry 324 (class 1259 OID 14563076)
-- Name: bas_pessoa_telefone_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bas_pessoa_telefone_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_pessoa_telefone_id_seq OWNER TO postgres;

--
-- TOC entry 11780 (class 0 OID 0)
-- Dependencies: 324
-- Name: bas_pessoa_telefone_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bas_pessoa_telefone_id_seq OWNED BY public.bas_pessoa_telefone.id;


--
-- TOC entry 325 (class 1259 OID 14563078)
-- Name: bas_profissao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bas_profissao (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(100),
 tipo character(1),
 cbo character varying(8)
);


ALTER TABLE public.bas_profissao OWNER TO postgres;

--
-- TOC entry 11781 (class 0 OID 0)
-- Dependencies: 325
-- Name: COLUMN bas_profissao.tipo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_profissao.tipo IS 'F=usado em funcionario e R=usuado em responsavel';


--
-- TOC entry 11782 (class 0 OID 0)
-- Dependencies: 325
-- Name: COLUMN bas_profissao.cbo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_profissao.cbo IS 'Código Brasileiro de Ocupação';


--
-- TOC entry 326 (class 1259 OID 14563081)
-- Name: bas_profissao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bas_profissao_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_profissao_id_seq OWNER TO postgres;

--
-- TOC entry 11783 (class 0 OID 0)
-- Dependencies: 326
-- Name: bas_profissao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bas_profissao_id_seq OWNED BY public.bas_profissao.id;


--
-- TOC entry 327 (class 1259 OID 14563083)
-- Name: bas_raca_cor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bas_raca_cor (
 id bigint NOT NULL,
 nome character varying(50) NOT NULL,
 codigo_censo character(1)
);


ALTER TABLE public.bas_raca_cor OWNER TO postgres;

--
-- TOC entry 328 (class 1259 OID 14563086)
-- Name: bas_raca_cor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bas_raca_cor_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_raca_cor_id_seq OWNER TO postgres;

--
-- TOC entry 11784 (class 0 OID 0)
-- Dependencies: 328
-- Name: bas_raca_cor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bas_raca_cor_id_seq OWNED BY public.bas_raca_cor.id;


--
-- TOC entry 329 (class 1259 OID 14563088)
-- Name: bas_ramo_atividade; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bas_ramo_atividade (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(100) NOT NULL
);


ALTER TABLE public.bas_ramo_atividade OWNER TO postgres;

--
-- TOC entry 330 (class 1259 OID 14563091)
-- Name: bas_ramo_atividade_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bas_ramo_atividade_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_ramo_atividade_id_seq OWNER TO postgres;

--
-- TOC entry 11785 (class 0 OID 0)
-- Dependencies: 330
-- Name: bas_ramo_atividade_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bas_ramo_atividade_id_seq OWNED BY public.bas_ramo_atividade.id;


SET default_with_oids = false;

--
-- TOC entry 331 (class 1259 OID 14563093)
-- Name: bas_relatorio_personalizavel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bas_relatorio_personalizavel (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(100),
 imagem_direita character(1),
 imagem_esquerda character(1),
 borda character(1),
 rodape text,
 texto text,
 titulo character varying(200),
 cabecalho text
);


ALTER TABLE public.bas_relatorio_personalizavel OWNER TO postgres;

--
-- TOC entry 11786 (class 0 OID 0)
-- Dependencies: 331
-- Name: COLUMN bas_relatorio_personalizavel.imagem_direita; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_relatorio_personalizavel.imagem_direita IS 'G=Grupo, E=Empresa';


--
-- TOC entry 11787 (class 0 OID 0)
-- Dependencies: 331
-- Name: COLUMN bas_relatorio_personalizavel.imagem_esquerda; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_relatorio_personalizavel.imagem_esquerda IS 'G=Grupo, E=Empresa';


--
-- TOC entry 332 (class 1259 OID 14563099)
-- Name: bas_relatorio_personalizavel_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bas_relatorio_personalizavel_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_relatorio_personalizavel_id_seq OWNER TO postgres;

--
-- TOC entry 11788 (class 0 OID 0)
-- Dependencies: 332
-- Name: bas_relatorio_personalizavel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bas_relatorio_personalizavel_id_seq OWNED BY public.bas_relatorio_personalizavel.id;


--
-- TOC entry 333 (class 1259 OID 14563101)
-- Name: bas_religiao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bas_religiao (
 id bigint NOT NULL,
 nome character varying(50) NOT NULL
);
ALTER TABLE ONLY public.bas_religiao ALTER COLUMN id SET STATISTICS 0;


ALTER TABLE public.bas_religiao OWNER TO postgres;

--
-- TOC entry 334 (class 1259 OID 14563104)
-- Name: bas_religiao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bas_religiao_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_religiao_id_seq OWNER TO postgres;

--
-- TOC entry 11789 (class 0 OID 0)
-- Dependencies: 334
-- Name: bas_religiao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bas_religiao_id_seq OWNED BY public.bas_religiao.id;


SET default_with_oids = true;

--
-- TOC entry 335 (class 1259 OID 14563106)
-- Name: bas_responsavel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bas_responsavel (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_pessoa bigint NOT NULL,
 id_bas_funcao bigint,
 id_bas_profissao bigint,
 salario numeric(9,2),
 empresa_trabalha character varying(60),
 nome_pai character varying(100),
 nome_mae character varying(100),
 tipo character(1),
 trabalha character(1) DEFAULT 'N'::bpchar
);


ALTER TABLE public.bas_responsavel OWNER TO postgres;

--
-- TOC entry 11790 (class 0 OID 0)
-- Dependencies: 335
-- Name: COLUMN bas_responsavel.tipo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_responsavel.tipo IS '"C" = "Civil", "M" = "Policial militar, "S" = "Servidor com direiro a cota"';


--
-- TOC entry 11791 (class 0 OID 0)
-- Dependencies: 335
-- Name: COLUMN bas_responsavel.trabalha; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_responsavel.trabalha IS 'Informa se o responsável está trabalhando atualmente';


--
-- TOC entry 336 (class 1259 OID 14563110)
-- Name: bas_responsavel_aluno; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bas_responsavel_aluno (
 id_bas_responsavel bigint NOT NULL,
 id_sge_aluno bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 parentesco character varying(30),
 financeiro character(1),
 acompanhante character(1),
 didatico character(1),
 fiador character(1),
 debito_conta character(1),
 ativo character(1),
 convenio character(1),
 id_bas_grau_parentesco bigint
);


ALTER TABLE public.bas_responsavel_aluno OWNER TO postgres;

--
-- TOC entry 11792 (class 0 OID 0)
-- Dependencies: 336
-- Name: COLUMN bas_responsavel_aluno.parentesco; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_responsavel_aluno.parentesco IS 'avô, avó, tio...';


--
-- TOC entry 11793 (class 0 OID 0)
-- Dependencies: 336
-- Name: COLUMN bas_responsavel_aluno.financeiro; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_responsavel_aluno.financeiro IS 'S=Sim ou N=Nao';


--
-- TOC entry 11794 (class 0 OID 0)
-- Dependencies: 336
-- Name: COLUMN bas_responsavel_aluno.acompanhante; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_responsavel_aluno.acompanhante IS 'S=Sim ou N=Nao';


--
-- TOC entry 11795 (class 0 OID 0)
-- Dependencies: 336
-- Name: COLUMN bas_responsavel_aluno.didatico; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_responsavel_aluno.didatico IS 'S=Sim ou N=Nao';


--
-- TOC entry 11796 (class 0 OID 0)
-- Dependencies: 336
-- Name: COLUMN bas_responsavel_aluno.fiador; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_responsavel_aluno.fiador IS 'S=Sim ou N=Nao';


--
-- TOC entry 11797 (class 0 OID 0)
-- Dependencies: 336
-- Name: COLUMN bas_responsavel_aluno.debito_conta; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_responsavel_aluno.debito_conta IS 'S=Sim ou N=Nao';


--
-- TOC entry 11798 (class 0 OID 0)
-- Dependencies: 336
-- Name: COLUMN bas_responsavel_aluno.ativo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_responsavel_aluno.ativo IS 'S=Sim ou N=Nao';


--
-- TOC entry 11799 (class 0 OID 0)
-- Dependencies: 336
-- Name: COLUMN bas_responsavel_aluno.convenio; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_responsavel_aluno.convenio IS 'S = SIm, N = Não';


--
-- TOC entry 337 (class 1259 OID 14563113)
-- Name: bas_responsavel_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bas_responsavel_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_responsavel_id_seq OWNER TO postgres;

--
-- TOC entry 11800 (class 0 OID 0)
-- Dependencies: 337
-- Name: bas_responsavel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bas_responsavel_id_seq OWNED BY public.bas_responsavel.id;


SET default_with_oids = false;

--
-- TOC entry 338 (class 1259 OID 14563115)
-- Name: bas_resposta; Type: TABLE; Schema: public; Owner: pgadmin
--

CREATE TABLE public.bas_resposta (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 resposta character varying(200) NOT NULL
);


ALTER TABLE public.bas_resposta OWNER TO pgadmin;

--
-- TOC entry 11801 (class 0 OID 0)
-- Dependencies: 338
-- Name: TABLE bas_resposta; Type: COMMENT; Schema: public; Owner: pgadmin
--

COMMENT ON TABLE public.bas_resposta IS 'para resposta do tipo select';


--
-- TOC entry 339 (class 1259 OID 14563118)
-- Name: bas_resposta_id_seq; Type: SEQUENCE; Schema: public; Owner: pgadmin
--

CREATE SEQUENCE public.bas_resposta_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_resposta_id_seq OWNER TO pgadmin;

--
-- TOC entry 11802 (class 0 OID 0)
-- Dependencies: 339
-- Name: bas_resposta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgadmin
--

ALTER SEQUENCE public.bas_resposta_id_seq OWNED BY public.bas_resposta.id;


SET default_with_oids = true;

--
-- TOC entry 340 (class 1259 OID 14563120)
-- Name: bas_sala; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bas_sala (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_estabelecimento bigint NOT NULL,
 nome character varying(200) NOT NULL,
 bloco character varying(60),
 andar character varying(30),
 largura integer,
 profundidade integer,
 metro numeric(6,2),
 sala_aula character(1) DEFAULT 'S'::bpchar,
 ativo character(1) DEFAULT 'S'::bpchar,
 acessivel character(1) DEFAULT 'N'::bpchar
);


ALTER TABLE public.bas_sala OWNER TO postgres;

--
-- TOC entry 11803 (class 0 OID 0)
-- Dependencies: 340
-- Name: COLUMN bas_sala.sala_aula; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_sala.sala_aula IS 'S=sim N=nao';


--
-- TOC entry 11804 (class 0 OID 0)
-- Dependencies: 340
-- Name: COLUMN bas_sala.ativo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_sala.ativo IS 'S=sim N=nao';


--
-- TOC entry 11805 (class 0 OID 0)
-- Dependencies: 340
-- Name: COLUMN bas_sala.acessivel; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_sala.acessivel IS 'S=sim N=nao';


--
-- TOC entry 341 (class 1259 OID 14563126)
-- Name: bas_sala_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bas_sala_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_sala_id_seq OWNER TO postgres;

--
-- TOC entry 11806 (class 0 OID 0)
-- Dependencies: 341
-- Name: bas_sala_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bas_sala_id_seq OWNED BY public.bas_sala.id;


SET default_with_oids = false;

--
-- TOC entry 342 (class 1259 OID 14563128)
-- Name: bas_situacao_funcional; Type: TABLE; Schema: public; Owner: infocraftread
--

CREATE TABLE public.bas_situacao_funcional (
 id bigint NOT NULL,
 nome character varying(50) NOT NULL,
 sigla character varying(3) NOT NULL,
 situacao_funcional character varying(1) NOT NULL
);


ALTER TABLE public.bas_situacao_funcional OWNER TO infocraftread;

--
-- TOC entry 343 (class 1259 OID 14563131)
-- Name: bas_situacao_funcional_id_seq; Type: SEQUENCE; Schema: public; Owner: infocraftread
--

CREATE SEQUENCE public.bas_situacao_funcional_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_situacao_funcional_id_seq OWNER TO infocraftread;

--
-- TOC entry 11807 (class 0 OID 0)
-- Dependencies: 343
-- Name: bas_situacao_funcional_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: infocraftread
--

ALTER SEQUENCE public.bas_situacao_funcional_id_seq OWNED BY public.bas_situacao_funcional.id;


--
-- TOC entry 344 (class 1259 OID 14563133)
-- Name: bas_tipo_assunto_suporte; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bas_tipo_assunto_suporte (
 id integer NOT NULL,
 tipo_assunto_correncia character varying(100) NOT NULL,
 id_bas_tipo_ocorrencia integer NOT NULL,
 notifica character(1) NOT NULL,
 email_notifica character varying(100)
);


ALTER TABLE public.bas_tipo_assunto_suporte OWNER TO postgres;

--
-- TOC entry 345 (class 1259 OID 14563136)
-- Name: bas_tipo_beneficio; Type: TABLE; Schema: public; Owner: infocraftread
--

CREATE TABLE public.bas_tipo_beneficio (
 id bigint NOT NULL,
 nome character varying(50) NOT NULL,
 sigla character varying(3) NOT NULL
);


ALTER TABLE public.bas_tipo_beneficio OWNER TO infocraftread;

--
-- TOC entry 346 (class 1259 OID 14563139)
-- Name: bas_tipo_beneficio_id_seq; Type: SEQUENCE; Schema: public; Owner: infocraftread
--

CREATE SEQUENCE public.bas_tipo_beneficio_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_tipo_beneficio_id_seq OWNER TO infocraftread;

--
-- TOC entry 11808 (class 0 OID 0)
-- Dependencies: 346
-- Name: bas_tipo_beneficio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: infocraftread
--

ALTER SEQUENCE public.bas_tipo_beneficio_id_seq OWNED BY public.bas_tipo_beneficio.id;


--
-- TOC entry 347 (class 1259 OID 14563141)
-- Name: bas_tipo_fonte_pagadora; Type: TABLE; Schema: public; Owner: infocraftread
--

CREATE TABLE public.bas_tipo_fonte_pagadora (
 id bigint NOT NULL,
 nome character varying(50) NOT NULL,
 sigla character varying(3) NOT NULL
);


ALTER TABLE public.bas_tipo_fonte_pagadora OWNER TO infocraftread;

--
-- TOC entry 348 (class 1259 OID 14563144)
-- Name: bas_tipo_fonte_pagadora_id_seq; Type: SEQUENCE; Schema: public; Owner: infocraftread
--

CREATE SEQUENCE public.bas_tipo_fonte_pagadora_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_tipo_fonte_pagadora_id_seq OWNER TO infocraftread;

--
-- TOC entry 11809 (class 0 OID 0)
-- Dependencies: 348
-- Name: bas_tipo_fonte_pagadora_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: infocraftread
--

ALTER SEQUENCE public.bas_tipo_fonte_pagadora_id_seq OWNED BY public.bas_tipo_fonte_pagadora.id;


--
-- TOC entry 349 (class 1259 OID 14563146)
-- Name: bas_tipo_punicao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bas_tipo_punicao (
 id_bas_empresa bigint NOT NULL,
 id bigint NOT NULL,
 nome character varying(100),
 descricao text,
 pontuacao numeric(4,2)
);


ALTER TABLE public.bas_tipo_punicao OWNER TO postgres;

--
-- TOC entry 350 (class 1259 OID 14563152)
-- Name: bas_tipo_punicao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bas_tipo_punicao_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_tipo_punicao_id_seq OWNER TO postgres;

--
-- TOC entry 11810 (class 0 OID 0)
-- Dependencies: 350
-- Name: bas_tipo_punicao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bas_tipo_punicao_id_seq OWNED BY public.bas_tipo_punicao.id;


--
-- TOC entry 1285 (class 1259 OID 17129531)
-- Name: bas_treinamento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bas_treinamento (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(50) NOT NULL
);


ALTER TABLE public.bas_treinamento OWNER TO postgres;

--
-- TOC entry 1284 (class 1259 OID 17129529)
-- Name: bas_treinamento_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bas_treinamento_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_treinamento_id_seq OWNER TO postgres;

--
-- TOC entry 11811 (class 0 OID 0)
-- Dependencies: 1284
-- Name: bas_treinamento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bas_treinamento_id_seq OWNED BY public.bas_treinamento.id;


--
-- TOC entry 351 (class 1259 OID 14563154)
-- Name: bas_veiculo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bas_veiculo (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 codigo character varying(10) NOT NULL,
 placa character varying(10) NOT NULL,
 capacidade integer,
 descricao character varying(100),
 ano smallint,
 modelo character varying(50),
 conservacao character(1),
 chassi character(30),
 id_bas_veiculo_tipo bigint,
 prefixo character(2),
 revisao_preventiva character varying(50),
 pneu_estado character varying(50),
 sit_atual_funcionamento character varying(300),
 insp_ccv character varying(20),
 hor_km character varying(20),
 local character varying(10),
 licenciamento character varying(10),
 tag_smec character varying(10),
 marca character varying(50),
 tipo character varying(20),
 cor character varying(20),
 motor character varying(10),
 renavam character varying(20),
 combustivel character varying(10),
 empresa character varying(10),
 tacografo character varying(20),
 tipo_propriedade character(1),
 observacao text,
 quantidade_em_pe smallint,
 quantidade_sentado smallint
);


ALTER TABLE public.bas_veiculo OWNER TO postgres;

--
-- TOC entry 11812 (class 0 OID 0)
-- Dependencies: 351
-- Name: TABLE bas_veiculo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.bas_veiculo IS 'Cadasttra os veículos para o transporte';


--
-- TOC entry 11813 (class 0 OID 0)
-- Dependencies: 351
-- Name: COLUMN bas_veiculo.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_veiculo.id IS 'Identificador sequencial da tabela, chave primaria composta com o campo id_bas_empresa';


--
-- TOC entry 11814 (class 0 OID 0)
-- Dependencies: 351
-- Name: COLUMN bas_veiculo.id_bas_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_veiculo.id_bas_empresa IS 'Identificador da tabela bas_empresa, chave primaria composta com o campo id';


--
-- TOC entry 11815 (class 0 OID 0)
-- Dependencies: 351
-- Name: COLUMN bas_veiculo.codigo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_veiculo.codigo IS 'Código do veículo fornecido pelo usuário';


--
-- TOC entry 11816 (class 0 OID 0)
-- Dependencies: 351
-- Name: COLUMN bas_veiculo.placa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_veiculo.placa IS 'Placa do carro';


--
-- TOC entry 11817 (class 0 OID 0)
-- Dependencies: 351
-- Name: COLUMN bas_veiculo.capacidade; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_veiculo.capacidade IS 'Capacidade do veículo';


--
-- TOC entry 11818 (class 0 OID 0)
-- Dependencies: 351
-- Name: COLUMN bas_veiculo.descricao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bas_veiculo.descricao IS 'Descrição do veículo';


--
-- TOC entry 352 (class 1259 OID 14563157)
-- Name: bas_veiculo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bas_veiculo_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_veiculo_id_seq OWNER TO postgres;

--
-- TOC entry 11819 (class 0 OID 0)
-- Dependencies: 352
-- Name: bas_veiculo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bas_veiculo_id_seq OWNED BY public.bas_veiculo.id;


--
-- TOC entry 1289 (class 1259 OID 17129557)
-- Name: bas_veiculo_tipo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bas_veiculo_tipo (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(80) NOT NULL
);


ALTER TABLE public.bas_veiculo_tipo OWNER TO postgres;

--
-- TOC entry 1288 (class 1259 OID 17129555)
-- Name: bas_veiculo_tipo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bas_veiculo_tipo_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_veiculo_tipo_id_seq OWNER TO postgres;

--
-- TOC entry 11820 (class 0 OID 0)
-- Dependencies: 1288
-- Name: bas_veiculo_tipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bas_veiculo_tipo_id_seq OWNED BY public.bas_veiculo_tipo.id;


--
-- TOC entry 353 (class 1259 OID 14563159)
-- Name: bas_vinculo_empregaticio; Type: TABLE; Schema: public; Owner: infocraftread
--

CREATE TABLE public.bas_vinculo_empregaticio (
 id bigint NOT NULL,
 nome character varying(100) NOT NULL,
 sigla character varying(5)
);


ALTER TABLE public.bas_vinculo_empregaticio OWNER TO infocraftread;

--
-- TOC entry 354 (class 1259 OID 14563162)
-- Name: bas_vinculo_empregaticio_id_seq; Type: SEQUENCE; Schema: public; Owner: infocraftread
--

CREATE SEQUENCE public.bas_vinculo_empregaticio_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.bas_vinculo_empregaticio_id_seq OWNER TO infocraftread;

--
-- TOC entry 11821 (class 0 OID 0)
-- Dependencies: 354
-- Name: bas_vinculo_empregaticio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: infocraftread
--

ALTER SEQUENCE public.bas_vinculo_empregaticio_id_seq OWNED BY public.bas_vinculo_empregaticio.id;


--
-- TOC entry 355 (class 1259 OID 14563164)
-- Name: censo_escolar_cadastro_aluno; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.censo_escolar_cadastro_aluno (
 id bigint NOT NULL,
 codigo_escola bigint,
 codigo_inep character varying(12),
 cpf character varying(16),
 nome character varying(100),
 data_nascimento date,
 filiacao_1 character varying(100),
 filiacao_2 character varying(100),
 nao_declarado_ignorado character(1),
 sexo character(1),
 cor_raca bigint,
 nacionalidade character(1),
 pais_origem bigint,
 municipio_nascimento bigint,
 deficiencia_transtorno_superdotacao character(1),
 baixa_visao character(1),
 deficiencia_fisica character(1),
 surdocegueira character(1),
 cegueira character(1),
 deficiencia_intelectual character(1),
 deficiencia_multipla character(1),
 deficiencia_auditiva character(1),
 surdez character(1),
 autismo_infantil character(1),
 sindrome_rett character(1),
 sindrome_asperger character(1),
 transtorno_desintegrativo_infancia character(1),
 altas_habilidades_superdotacao character(1),
 auxilio_ledor character(1),
 interprete_libras character(1),
 prova_ampliada_20 character(1),
 prova_braille character(1),
 auxilio_transcricao character(1),
 leitura_labial character(1),
 prova_ampliada_24 character(1),
 nenhum character(1),
 guia_interprete character(1),
 prova_ampliada_16 character(1),
 nis character varying(11),
 numero_identidade character varying(10),
 complemento_identidade character varying(4),
 orgao_emissor_identidade bigint,
 uf_identidade bigint,
 data_expedicao_identidade date,
 modelo_certidao_civil character(1),
 tipo_certidao_civil character(1),
 numero_termo character varying(8),
 folha character varying(4),
 livro character varying(8),
 data_emissao_certidao date,
 uf_cartorio bigint,
 municipio_cartorio bigint,
 nome_cartorio bigint,
 numero_matricula_certidao_civil_nova character varying(32),
 documento_estrangeiro_passaporte character varying(20),
 localizacao_zona_residencia character(1),
 cep character varying(10),
 endereco character varying(100),
 numero character varying(10),
 complemento character varying(50),
 bairro character varying(30),
 uf bigint,
 municipio bigint,
 turma bigint,
 filiacao1_grau_parentesco character(1),
 filiacao2_grau_parentesco character(1),
 id_bas_empresa bigint NOT NULL,
 migrado character(1),
 data date DEFAULT now(),
 login character varying(32),
 transporte_publico character(1),
 responsavel_transporte character(1),
 rodoviario_vans_kombi character(1),
 rodoviario_microonibus character(1),
 rodoviario_onibus character(1),
 rodoviario_bicicleta character(1),
 rodoviario_tracao_animal character(1),
 rodoviario_outro character(1),
 aquaviario_5 character(1),
 aquaviario_15 character(1),
 aquaviario_35 character(1),
 aquaviario_mais35 character(1),
 ferroviario_trem_metro character(1)
);


ALTER TABLE public.censo_escolar_cadastro_aluno OWNER TO postgres;

--
-- TOC entry 356 (class 1259 OID 14563171)
-- Name: censo_escolar_cadastro_aluno_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.censo_escolar_cadastro_aluno_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.censo_escolar_cadastro_aluno_id_seq OWNER TO postgres;

--
-- TOC entry 11822 (class 0 OID 0)
-- Dependencies: 356
-- Name: censo_escolar_cadastro_aluno_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.censo_escolar_cadastro_aluno_id_seq OWNED BY public.censo_escolar_cadastro_aluno.id;


--
-- TOC entry 357 (class 1259 OID 14563173)
-- Name: cfg_curso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cfg_curso (
 id bigint NOT NULL,
 nome character varying(100) NOT NULL
);


ALTER TABLE public.cfg_curso OWNER TO postgres;

--
-- TOC entry 358 (class 1259 OID 14563176)
-- Name: cfg_curso_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cfg_curso_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.cfg_curso_id_seq OWNER TO postgres;

--
-- TOC entry 11823 (class 0 OID 0)
-- Dependencies: 358
-- Name: cfg_curso_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cfg_curso_id_seq OWNED BY public.cfg_curso.id;


--
-- TOC entry 359 (class 1259 OID 14563178)
-- Name: cfg_financeiro; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cfg_financeiro (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 verificar_dia_util character(1),
 regime_caixa character(1),
 layout_baixa_bancaria character(1),
 tipo_juros character(1),
 regime_controle_saldo character(1),
 autentica_miniimpressora character(1),
 recibo_miniimpressora character(1)
);


ALTER TABLE public.cfg_financeiro OWNER TO postgres;

--
-- TOC entry 11824 (class 0 OID 0)
-- Dependencies: 359
-- Name: COLUMN cfg_financeiro.verificar_dia_util; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_financeiro.verificar_dia_util IS 'S = Sim, N = Não';


--
-- TOC entry 11825 (class 0 OID 0)
-- Dependencies: 359
-- Name: COLUMN cfg_financeiro.regime_caixa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_financeiro.regime_caixa IS 'A = Ativo, I = Inativo';


--
-- TOC entry 11826 (class 0 OID 0)
-- Dependencies: 359
-- Name: COLUMN cfg_financeiro.layout_baixa_bancaria; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_financeiro.layout_baixa_bancaria IS 'R = Retrato, P = Paisagem';


--
-- TOC entry 11827 (class 0 OID 0)
-- Dependencies: 359
-- Name: COLUMN cfg_financeiro.tipo_juros; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_financeiro.tipo_juros IS 'D = Diario, P = Pro rate Die';


--
-- TOC entry 11828 (class 0 OID 0)
-- Dependencies: 359
-- Name: COLUMN cfg_financeiro.regime_controle_saldo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_financeiro.regime_controle_saldo IS 'P = Data de Pagamento, C = Data de Credito';


--
-- TOC entry 11829 (class 0 OID 0)
-- Dependencies: 359
-- Name: COLUMN cfg_financeiro.autentica_miniimpressora; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_financeiro.autentica_miniimpressora IS 'S = Sim, N = Não';


--
-- TOC entry 11830 (class 0 OID 0)
-- Dependencies: 359
-- Name: COLUMN cfg_financeiro.recibo_miniimpressora; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_financeiro.recibo_miniimpressora IS 'S = SIm, N = Não';


SET default_with_oids = true;

--
-- TOC entry 360 (class 1259 OID 14563181)
-- Name: cfg_financeiro_contabil; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cfg_financeiro_contabil (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sgf_plano_conta_tesouraria bigint,
 id_sgf_plano_conta_juros_receita bigint,
 id_sgf_plano_conta_juros_despesa bigint,
 id_sgf_plano_conta_multa_receita bigint,
 id_sgf_plano_conta_multa_despesa bigint,
 id_sgf_plano_conta_desconto_concedido bigint,
 id_sgf_plano_conta_desconto_recebido bigint,
 id_sgf_plano_conta_cheque_avista bigint,
 id_sgf_plano_conta_cheque_aprazo bigint,
 id_sgf_plano_conta_cheque_devolvido bigint,
 id_sgf_plano_conta_cheque_pagamento bigint,
 id_sgf_plano_conta_boleto_nao_encontrado bigint
);


ALTER TABLE public.cfg_financeiro_contabil OWNER TO postgres;

--
-- TOC entry 361 (class 1259 OID 14563184)
-- Name: cfg_financeiro_contabil_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cfg_financeiro_contabil_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.cfg_financeiro_contabil_id_seq OWNER TO postgres;

--
-- TOC entry 11831 (class 0 OID 0)
-- Dependencies: 361
-- Name: cfg_financeiro_contabil_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cfg_financeiro_contabil_id_seq OWNED BY public.cfg_financeiro_contabil.id;


--
-- TOC entry 362 (class 1259 OID 14563186)
-- Name: cfg_financeiro_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cfg_financeiro_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.cfg_financeiro_id_seq OWNER TO postgres;

--
-- TOC entry 11832 (class 0 OID 0)
-- Dependencies: 362
-- Name: cfg_financeiro_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cfg_financeiro_id_seq OWNED BY public.cfg_financeiro.id;


SET default_with_oids = false;

--
-- TOC entry 363 (class 1259 OID 14563188)
-- Name: cfg_financeiro_lancamento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cfg_financeiro_lancamento (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sgf_lancamento_mensalidade bigint,
 id_sgf_lancamento_acordo bigint,
 id_sgf_lancamento_dependencia bigint,
 id_sgf_lancamento_venda bigint,
 id_sgf_lancamento_adiantamento_matricula bigint,
 id_sgf_lancamento_recuperacao bigint,
 id_sgf_lancamento_cheque_devolvido bigint,
 id_sgf_lancamento_turno_integral bigint,
 id_sgf_lancamento_convenio bigint,
 id_sgf_lancamento_segunda_chamada bigint,
 id_sgf_lancamento_devolucao_matricula bigint,
 id_sgf_lancamento_transporte bigint,
 id_sgf_lancamento_multa_biblioteca bigint,
 id_sgf_lancamento_nota_promissoria bigint,
 id_sgf_lancamento_troca bigint
);


ALTER TABLE public.cfg_financeiro_lancamento OWNER TO postgres;

--
-- TOC entry 364 (class 1259 OID 14563191)
-- Name: cfg_financeiro_lancamento_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cfg_financeiro_lancamento_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.cfg_financeiro_lancamento_id_seq OWNER TO postgres;

--
-- TOC entry 11833 (class 0 OID 0)
-- Dependencies: 364
-- Name: cfg_financeiro_lancamento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cfg_financeiro_lancamento_id_seq OWNED BY public.cfg_financeiro_lancamento.id;


--
-- TOC entry 365 (class 1259 OID 14563193)
-- Name: cfg_financeiro_recebimento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cfg_financeiro_recebimento (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 juros numeric(6,3) NOT NULL,
 multa numeric(6,3) NOT NULL,
 dia_vencimento_padrao smallint NOT NULL,
 tamanho_fonte_autenticacao smallint DEFAULT 8 NOT NULL,
 dias_protesto_banco smallint,
 tolerancia_juros_baixa_boleto numeric(6,3)
);
ALTER TABLE ONLY public.cfg_financeiro_recebimento ALTER COLUMN dia_vencimento_padrao SET STATISTICS 0;


ALTER TABLE public.cfg_financeiro_recebimento OWNER TO postgres;

--
-- TOC entry 11834 (class 0 OID 0)
-- Dependencies: 365
-- Name: COLUMN cfg_financeiro_recebimento.juros; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_financeiro_recebimento.juros IS 'porcentagem mensal de juros';


--
-- TOC entry 11835 (class 0 OID 0)
-- Dependencies: 365
-- Name: COLUMN cfg_financeiro_recebimento.multa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_financeiro_recebimento.multa IS 'valor da multa gerada por atraso';


--
-- TOC entry 11836 (class 0 OID 0)
-- Dependencies: 365
-- Name: COLUMN cfg_financeiro_recebimento.dias_protesto_banco; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_financeiro_recebimento.dias_protesto_banco IS 'dias para o banco protestar';


--
-- TOC entry 11837 (class 0 OID 0)
-- Dependencies: 365
-- Name: COLUMN cfg_financeiro_recebimento.tolerancia_juros_baixa_boleto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_financeiro_recebimento.tolerancia_juros_baixa_boleto IS 'Tolerancia de juros na baixa do boleto';


--
-- TOC entry 366 (class 1259 OID 14563197)
-- Name: cfg_financeiro_recebimento_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cfg_financeiro_recebimento_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.cfg_financeiro_recebimento_id_seq OWNER TO postgres;

--
-- TOC entry 11838 (class 0 OID 0)
-- Dependencies: 366
-- Name: cfg_financeiro_recebimento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cfg_financeiro_recebimento_id_seq OWNED BY public.cfg_financeiro_recebimento.id;


--
-- TOC entry 367 (class 1259 OID 14563199)
-- Name: cfg_pedagogico; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cfg_pedagogico (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 data_inicio_rematricula date,
 data_fim_rematricula date,
 exige_cpf_resp_matricula character(1) DEFAULT 'N'::bpchar NOT NULL,
 prazo_entrega_documento smallint,
 tipo_matricula character(1),
 pode_exceder_vagas character(1),
 matricula_aluno_novo character(1),
 matricula_aluno_rede character(1),
 matricula_aluno_rede_estabelecimento character(1),
 matricula_aluno_fardamento_obrigatorio character(1),
 sus_obrigatorio_matricula character(1),
 componente_curricular_disponivel character(1),
 data_corte_censo date,
 nome_caixa_alta character(1),
 nome_sem_acento character(1),
 local_certidao_nascimento character(1),
 campo_auxiliar_1_label character varying(100),
 campo_auxiliar_2_label character varying(100),
 campo_auxiliar_3_label character varying(100),
 campo_auxiliar_4_label character varying(100),
 campo_auxiliar_5_label character varying(100),
 campo_auxiliar_6_label character varying(100),
 campo_auxiliar_7_label character varying(100),
 campo_auxiliar_8_label character varying(100),
 exibe_campo_auxiliar_1 boolean DEFAULT false NOT NULL,
 exibe_campo_auxiliar_2 boolean DEFAULT false NOT NULL,
 exibe_campo_auxiliar_3 boolean DEFAULT false NOT NULL,
 exibe_campo_auxiliar_4 boolean DEFAULT false NOT NULL,
 exibe_campo_auxiliar_5 boolean DEFAULT false NOT NULL,
 exibe_campo_auxiliar_6 boolean DEFAULT false NOT NULL,
 exibe_campo_auxiliar_7 boolean DEFAULT false NOT NULL,
 exibe_campo_auxiliar_8 boolean DEFAULT false NOT NULL,
 ano_matricula smallint,
 exige_cpf_aluno character(1) DEFAULT 'N'::bpchar NOT NULL,
 exige_endereco_aluno character(1) DEFAULT 'N'::bpchar NOT NULL,
 matricula_exibida character(1),
 critica_idade_matricula character(1),
 exige_mes_falta character(1) DEFAULT 'N'::bpchar NOT NULL
);


ALTER TABLE public.cfg_pedagogico OWNER TO postgres;

--
-- TOC entry 11839 (class 0 OID 0)
-- Dependencies: 367
-- Name: COLUMN cfg_pedagogico.exige_cpf_resp_matricula; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_pedagogico.exige_cpf_resp_matricula IS 'Informa se o cpf do responsável contratual deve ser obrigatório na matrícula. "S" = sim, "N" = Não';


--
-- TOC entry 11840 (class 0 OID 0)
-- Dependencies: 367
-- Name: COLUMN cfg_pedagogico.prazo_entrega_documento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_pedagogico.prazo_entrega_documento IS 'Quantidade limite de dias para o aluno entregar os documentos da matrícula';


--
-- TOC entry 11841 (class 0 OID 0)
-- Dependencies: 367
-- Name: COLUMN cfg_pedagogico.tipo_matricula; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_pedagogico.tipo_matricula IS 'S de serie ou T de turma';


--
-- TOC entry 11842 (class 0 OID 0)
-- Dependencies: 367
-- Name: COLUMN cfg_pedagogico.pode_exceder_vagas; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_pedagogico.pode_exceder_vagas IS '1 se puder';


--
-- TOC entry 11843 (class 0 OID 0)
-- Dependencies: 367
-- Name: COLUMN cfg_pedagogico.matricula_aluno_novo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_pedagogico.matricula_aluno_novo IS '1 = Ativa';


--
-- TOC entry 11844 (class 0 OID 0)
-- Dependencies: 367
-- Name: COLUMN cfg_pedagogico.matricula_aluno_rede; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_pedagogico.matricula_aluno_rede IS '1 = Ativa';


--
-- TOC entry 11845 (class 0 OID 0)
-- Dependencies: 367
-- Name: COLUMN cfg_pedagogico.matricula_aluno_rede_estabelecimento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_pedagogico.matricula_aluno_rede_estabelecimento IS '1 = Ativa';


--
-- TOC entry 11846 (class 0 OID 0)
-- Dependencies: 367
-- Name: COLUMN cfg_pedagogico.componente_curricular_disponivel; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_pedagogico.componente_curricular_disponivel IS 'Parâmetro para a utilização do campo componente curricular na síntese de Desempenho e Questionário Especial, 1=Ativo';


--
-- TOC entry 11847 (class 0 OID 0)
-- Dependencies: 367
-- Name: COLUMN cfg_pedagogico.data_corte_censo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_pedagogico.data_corte_censo IS 'Data de corte do alunos matriculados que serão enviados para o censo.';


--
-- TOC entry 11848 (class 0 OID 0)
-- Dependencies: 367
-- Name: COLUMN cfg_pedagogico.nome_caixa_alta; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_pedagogico.nome_caixa_alta IS '1=Sim, 0=Não';


--
-- TOC entry 11849 (class 0 OID 0)
-- Dependencies: 367
-- Name: COLUMN cfg_pedagogico.nome_sem_acento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_pedagogico.nome_sem_acento IS '1=Sim, 0=Não';


--
-- TOC entry 11850 (class 0 OID 0)
-- Dependencies: 367
-- Name: COLUMN cfg_pedagogico.local_certidao_nascimento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_pedagogico.local_certidao_nascimento IS 'Define se a certidão de nascimento vai ficar localizada no censo ou no cadastro de aluno

A = Aluno
C = Censo';


--
-- TOC entry 11851 (class 0 OID 0)
-- Dependencies: 367
-- Name: COLUMN cfg_pedagogico.campo_auxiliar_1_label; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_pedagogico.campo_auxiliar_1_label IS 'Label do campo auxiliar que irá aparecer na matrícula';


--
-- TOC entry 11852 (class 0 OID 0)
-- Dependencies: 367
-- Name: COLUMN cfg_pedagogico.campo_auxiliar_2_label; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_pedagogico.campo_auxiliar_2_label IS 'Label do campo auxiliar que irá aparecer na matrícula';


--
-- TOC entry 11853 (class 0 OID 0)
-- Dependencies: 367
-- Name: COLUMN cfg_pedagogico.campo_auxiliar_3_label; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_pedagogico.campo_auxiliar_3_label IS 'Label do campo auxiliar que irá aparecer na matrícula';


--
-- TOC entry 11854 (class 0 OID 0)
-- Dependencies: 367
-- Name: COLUMN cfg_pedagogico.campo_auxiliar_4_label; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_pedagogico.campo_auxiliar_4_label IS 'Label do campo auxiliar que irá aparecer na matrícula';


--
-- TOC entry 11855 (class 0 OID 0)
-- Dependencies: 367
-- Name: COLUMN cfg_pedagogico.campo_auxiliar_5_label; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_pedagogico.campo_auxiliar_5_label IS 'Label do campo auxiliar que irá aparecer na matrícula';


--
-- TOC entry 11856 (class 0 OID 0)
-- Dependencies: 367
-- Name: COLUMN cfg_pedagogico.campo_auxiliar_6_label; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_pedagogico.campo_auxiliar_6_label IS 'Label do campo auxiliar que irá aparecer na matrícula';


--
-- TOC entry 11857 (class 0 OID 0)
-- Dependencies: 367
-- Name: COLUMN cfg_pedagogico.campo_auxiliar_7_label; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_pedagogico.campo_auxiliar_7_label IS 'Label do campo auxiliar que irá aparecer na matrícula';


--
-- TOC entry 11858 (class 0 OID 0)
-- Dependencies: 367
-- Name: COLUMN cfg_pedagogico.campo_auxiliar_8_label; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_pedagogico.campo_auxiliar_8_label IS 'Label do campo auxiliar que irá aparecer na matrícula';


--
-- TOC entry 11859 (class 0 OID 0)
-- Dependencies: 367
-- Name: COLUMN cfg_pedagogico.exibe_campo_auxiliar_1; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_pedagogico.exibe_campo_auxiliar_1 IS 'Informa se o campo auxiliar será exibido na matrícula.';


--
-- TOC entry 11860 (class 0 OID 0)
-- Dependencies: 367
-- Name: COLUMN cfg_pedagogico.exibe_campo_auxiliar_2; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_pedagogico.exibe_campo_auxiliar_2 IS 'Informa se o campo auxiliar será exibido na matrícula.';


--
-- TOC entry 11861 (class 0 OID 0)
-- Dependencies: 367
-- Name: COLUMN cfg_pedagogico.exibe_campo_auxiliar_3; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_pedagogico.exibe_campo_auxiliar_3 IS 'Informa se o campo auxiliar será exibido na matrícula.';


--
-- TOC entry 11862 (class 0 OID 0)
-- Dependencies: 367
-- Name: COLUMN cfg_pedagogico.exibe_campo_auxiliar_4; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_pedagogico.exibe_campo_auxiliar_4 IS 'Informa se o campo auxiliar será exibido na matrícula.';


--
-- TOC entry 11863 (class 0 OID 0)
-- Dependencies: 367
-- Name: COLUMN cfg_pedagogico.exibe_campo_auxiliar_5; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_pedagogico.exibe_campo_auxiliar_5 IS 'Informa se o campo auxiliar será exibido na matrícula.';


--
-- TOC entry 11864 (class 0 OID 0)
-- Dependencies: 367
-- Name: COLUMN cfg_pedagogico.exibe_campo_auxiliar_6; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_pedagogico.exibe_campo_auxiliar_6 IS 'Informa se o campo auxiliar será exibido na matrícula.';


--
-- TOC entry 11865 (class 0 OID 0)
-- Dependencies: 367
-- Name: COLUMN cfg_pedagogico.exibe_campo_auxiliar_7; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_pedagogico.exibe_campo_auxiliar_7 IS 'Informa se o campo auxiliar será exibido na matrícula.';


--
-- TOC entry 11866 (class 0 OID 0)
-- Dependencies: 367
-- Name: COLUMN cfg_pedagogico.exibe_campo_auxiliar_8; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_pedagogico.exibe_campo_auxiliar_8 IS 'Informa se o campo auxiliar será exibido na matrícula.';


--
-- TOC entry 11867 (class 0 OID 0)
-- Dependencies: 367
-- Name: COLUMN cfg_pedagogico.exige_cpf_aluno; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_pedagogico.exige_cpf_aluno IS 'Informa se o cpf do aluno deve ser obrigatório na matrícula. "S" = sim, "N" = Não';


--
-- TOC entry 11868 (class 0 OID 0)
-- Dependencies: 367
-- Name: COLUMN cfg_pedagogico.matricula_exibida; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_pedagogico.matricula_exibida IS 'S = Simplificada, P = Padrão';


--
-- TOC entry 11869 (class 0 OID 0)
-- Dependencies: 367
-- Name: COLUMN cfg_pedagogico.exige_mes_falta; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_pedagogico.exige_mes_falta IS 'Informa se o mês é obrigatório na digitação das faltas. "S" = sim, "N" = Não';


--
-- TOC entry 368 (class 1259 OID 14563216)
-- Name: cfg_pedagogico_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cfg_pedagogico_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.cfg_pedagogico_id_seq OWNER TO postgres;

--
-- TOC entry 11870 (class 0 OID 0)
-- Dependencies: 368
-- Name: cfg_pedagogico_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cfg_pedagogico_id_seq OWNED BY public.cfg_pedagogico.id;


--
-- TOC entry 369 (class 1259 OID 14563218)
-- Name: cfg_perfil; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cfg_perfil (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 group_id_administrador integer,
 group_id_coordenador integer,
 group_id_responsavel integer,
 group_id_gestor integer,
 group_id_professor integer,
 group_id_bibliotecario integer,
 group_id_operador integer,
 group_id_saude integer,
 group_id_disciplinar integer,
 group_id_administrador_cliente integer,
 group_id_caixa integer,
 group_id_almoxarife integer,
 group_id_aluno integer,
 group_id_secretario integer,
 group_id_diretor integer
);


ALTER TABLE public.cfg_perfil OWNER TO postgres;

--
-- TOC entry 11871 (class 0 OID 0)
-- Dependencies: 369
-- Name: TABLE cfg_perfil; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.cfg_perfil IS 'Tabela para mapear aos perfis de usuários para o sistema';


--
-- TOC entry 11872 (class 0 OID 0)
-- Dependencies: 369
-- Name: COLUMN cfg_perfil.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_perfil.id IS 'Chave primária da tabela ao lado do campo id_bas_empresa';


--
-- TOC entry 11873 (class 0 OID 0)
-- Dependencies: 369
-- Name: COLUMN cfg_perfil.id_bas_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_perfil.id_bas_empresa IS 'Chave primária da tabela ao lado do campo id e chave estrangeira da tabela bas_empresa';


--
-- TOC entry 11874 (class 0 OID 0)
-- Dependencies: 369
-- Name: COLUMN cfg_perfil.group_id_administrador; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_perfil.group_id_administrador IS 'Chave estrangeira da tabela seg_groups para informar o perfil administrador';


--
-- TOC entry 11875 (class 0 OID 0)
-- Dependencies: 369
-- Name: COLUMN cfg_perfil.group_id_coordenador; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_perfil.group_id_coordenador IS 'Chave estrangeira da tabela seg_groups para informar o perfil coordenador';


--
-- TOC entry 11876 (class 0 OID 0)
-- Dependencies: 369
-- Name: COLUMN cfg_perfil.group_id_responsavel; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_perfil.group_id_responsavel IS 'Chave estrangeira da tabela seg_groups para informar o perfil responsável';


--
-- TOC entry 11877 (class 0 OID 0)
-- Dependencies: 369
-- Name: COLUMN cfg_perfil.group_id_gestor; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_perfil.group_id_gestor IS 'Chave estrangeira da tabela seg_groups para informar o perfil gestor geral';


--
-- TOC entry 11878 (class 0 OID 0)
-- Dependencies: 369
-- Name: COLUMN cfg_perfil.group_id_professor; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_perfil.group_id_professor IS 'Chave estrangeira da tabela seg_groups para informar o perfil professor';


--
-- TOC entry 11879 (class 0 OID 0)
-- Dependencies: 369
-- Name: COLUMN cfg_perfil.group_id_bibliotecario; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_perfil.group_id_bibliotecario IS 'Chave estrangeira da tabela seg_groups para informar o perfil bibliotecário';


--
-- TOC entry 11880 (class 0 OID 0)
-- Dependencies: 369
-- Name: COLUMN cfg_perfil.group_id_operador; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_perfil.group_id_operador IS 'Chave estrangeira da tabela seg_groups para informar o perfil de operador do sistema';


--
-- TOC entry 11881 (class 0 OID 0)
-- Dependencies: 369
-- Name: COLUMN cfg_perfil.group_id_saude; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_perfil.group_id_saude IS 'Chave estrangeira da tabela seg_groups para informar o perfil do profissional de saúde';


--
-- TOC entry 11882 (class 0 OID 0)
-- Dependencies: 369
-- Name: COLUMN cfg_perfil.group_id_disciplinar; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_perfil.group_id_disciplinar IS 'Chave estrangeira da tabela seg_groups para informar o usuário do setor disciplinar';


--
-- TOC entry 11883 (class 0 OID 0)
-- Dependencies: 369
-- Name: COLUMN cfg_perfil.group_id_administrador_cliente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_perfil.group_id_administrador_cliente IS 'Chave estrangeira da tabela seg_groups para informar o perfil administrador cliente';


--
-- TOC entry 11884 (class 0 OID 0)
-- Dependencies: 369
-- Name: COLUMN cfg_perfil.group_id_caixa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_perfil.group_id_caixa IS 'Chave estrangeira da tabela seg_groups para informar o perfil de operador de caixa';


--
-- TOC entry 11885 (class 0 OID 0)
-- Dependencies: 369
-- Name: COLUMN cfg_perfil.group_id_almoxarife; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_perfil.group_id_almoxarife IS 'Chave estrangeira da tabela seg_groups para informar o perfil almoxarife';


--
-- TOC entry 11886 (class 0 OID 0)
-- Dependencies: 369
-- Name: COLUMN cfg_perfil.group_id_aluno; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_perfil.group_id_aluno IS 'Chave estrangeira da tabela seg_groups para informar o perfil aluno';


--
-- TOC entry 11887 (class 0 OID 0)
-- Dependencies: 369
-- Name: COLUMN cfg_perfil.group_id_secretario; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cfg_perfil.group_id_secretario IS 'Chave estrangeira da tabela seg_groups para informar o perfil secretário';


--
-- TOC entry 370 (class 1259 OID 14563221)
-- Name: cfg_perfil_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cfg_perfil_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.cfg_perfil_id_seq OWNER TO postgres;

--
-- TOC entry 11888 (class 0 OID 0)
-- Dependencies: 370
-- Name: cfg_perfil_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cfg_perfil_id_seq OWNED BY public.cfg_perfil.id;


--
-- TOC entry 371 (class 1259 OID 14563223)
-- Name: cfg_serie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cfg_serie (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(100) NOT NULL,
 id_cso_etapa_modalidade bigint,
 id_sge_equivalencia_curricular bigint,
 multisseriada character(1),
 id_cfg_curso bigint,
 critica_serie_matricula character(1)
);


ALTER TABLE public.cfg_serie OWNER TO postgres;

--
-- TOC entry 372 (class 1259 OID 14563226)
-- Name: cfg_serie_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cfg_serie_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.cfg_serie_id_seq OWNER TO postgres;

--
-- TOC entry 11889 (class 0 OID 0)
-- Dependencies: 372
-- Name: cfg_serie_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cfg_serie_id_seq OWNED BY public.cfg_serie.id;


--
-- TOC entry 373 (class 1259 OID 14563228)
-- Name: comissao_avaliadora_id_seq; Type: SEQUENCE; Schema: public; Owner: infocraftread
--

CREATE SEQUENCE public.comissao_avaliadora_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.comissao_avaliadora_id_seq OWNER TO infocraftread;

--
-- TOC entry 374 (class 1259 OID 14563230)
-- Name: cso_aluno; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cso_aluno (
 id_sge_aluno bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 codigo_inep character varying(12),
 filiacao character(1),
 deficiencia_altas_habilidades character(1),
 deficiencia_cegueira character(1),
 deficiencia_baixa_visao character(1),
 deficiencia_surdez character(1),
 deficiencia_auditiva character(1),
 deficiencia_surdocegueira character(1),
 deficiencia_fisica character(1),
 deficiencia_intelectual character(1),
 deficiencia_multipla character(1),
 deficiencia_autismo character(1),
 deficiencia_sindrome_asperger character(1),
 deficiencia_sindrome_rett character(1),
 deficiencia_transtorno character(1),
 deficiencia_superdotacao character(1),
 auxilio_ledor character(1),
 auxilio_transcricao character(1),
 guia_interprete character(1),
 interprete_libras character(1),
 leitura_labial character(1),
 prova_ampliada16 character(1),
 prova_ampliada20 character(1),
 prova_ampliada24 character(1),
 prova_braille character(1),
 nenhum character(1),
 certidao_civil character(1),
 certidao_tipo character(1),
 certidao_folha character varying(100),
 certidao_livro character varying(100),
 certidao_data_emissao date,
 certidao_numero_termo character varying(100),
 certidao_numero_matricula character varying(32),
 id_cso_municipio_cartorio bigint,
 id_cso_cartorio bigint,
 documento_estrangeiro_passaporte character varying(20),
 justificativa_falta_documento character(1),
 localizacao character(1),
 id_cso_municipio bigint,
 id_cso_etapa_modalidade bigint,
 escolarizacao_outro_espaco character(1),
 transporte_publico character(1),
 responsavel_transporte character(1),
 rodoviario_vans_kombi character(1),
 rodoviario_microonibus character(1),
 rodoviario_onibus character(1),
 rodoviario_bicicleta character(1),
 rodoviario_tracao_animal character(1),
 rodoviario_outro character(1),
 aquaviario_5 character(1),
 aquaviario_15 character(1),
 aquaviario_35 character(1),
 aquaviario_mais35 character(1),
 ferroviario_trem_metro character(1),
 forma_ingresso character(1),
 ano_letivo smallint NOT NULL,
 localizacao_diferenciada character(1),
 prova_ampliada18 character(1),
 cd_audio_deficiente_visual character(1),
 prova_portugues_segunda_lingua_surdo character(1),
 prova_video_libras character(1),
 justificativa_falta_documentacao character(1)
);


ALTER TABLE public.cso_aluno OWNER TO postgres;

--
-- TOC entry 11890 (class 0 OID 0)
-- Dependencies: 374
-- Name: TABLE cso_aluno; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.cso_aluno IS 'Censo Escolar - Aluno';


--
-- TOC entry 11891 (class 0 OID 0)
-- Dependencies: 374
-- Name: COLUMN cso_aluno.deficiencia_autismo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_aluno.deficiencia_autismo IS 'Transtorno do espectro autista';


--
-- TOC entry 11892 (class 0 OID 0)
-- Dependencies: 374
-- Name: COLUMN cso_aluno.localizacao_diferenciada; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_aluno.localizacao_diferenciada IS 'Somente aceita os seguintes caracteres entre parêntesis: (1 2 3 7).
Legenda:
 1 – Área de assentamento
 2 – Terra indígena
 3 – Área onde se localiza comunidade
remanescente de quilombos
 7 – Não está em área de localização diferenciada';


--
-- TOC entry 11893 (class 0 OID 0)
-- Dependencies: 374
-- Name: COLUMN cso_aluno.prova_ampliada18; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_aluno.prova_ampliada18 IS 'Somente aceita os seguintes caracteres entre parêntesis: (0 1).
Legenda:
 0 – Não
 1 – Sim';


--
-- TOC entry 11894 (class 0 OID 0)
-- Dependencies: 374
-- Name: COLUMN cso_aluno.cd_audio_deficiente_visual; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_aluno.cd_audio_deficiente_visual IS 'Somente aceita os seguintes caracteres entre parêntesis: (0 1).
Legenda:
 0 – Não
 1 – Sim';


--
-- TOC entry 11895 (class 0 OID 0)
-- Dependencies: 374
-- Name: COLUMN cso_aluno.prova_portugues_segunda_lingua_surdo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_aluno.prova_portugues_segunda_lingua_surdo IS 'Somente aceita os seguintes caracteres entre parêntesis: (0 1).
Legenda:
 0 – Não
 1 – Sim';


--
-- TOC entry 11896 (class 0 OID 0)
-- Dependencies: 374
-- Name: COLUMN cso_aluno.prova_video_libras; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_aluno.prova_video_libras IS 'Somente aceita os seguintes caracteres entre parêntesis: (0 1).
Legenda:
 0 – Não
 1 – Sim';


--
-- TOC entry 11897 (class 0 OID 0)
-- Dependencies: 374
-- Name: COLUMN cso_aluno.justificativa_falta_documentacao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_aluno.justificativa_falta_documentacao IS 'Somente aceita os seguintes caracteres entre parêntesis: (1 2).
Legenda:
 1 – o(a) aluno(a) não possui os documentos pessoais solicitados
 2 – A escola não dispõe ou não recebeu os documentos pessoais do(a) aluno(a)';


--
-- TOC entry 1305 (class 1259 OID 20355870)
-- Name: cso_area_conhecimento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cso_area_conhecimento (
 id bigint NOT NULL,
 nome character varying(200),
 codigo character varying(10) NOT NULL
);


ALTER TABLE public.cso_area_conhecimento OWNER TO postgres;

--
-- TOC entry 1304 (class 1259 OID 20355868)
-- Name: cso_area_conhecimento_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cso_area_conhecimento_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.cso_area_conhecimento_id_seq OWNER TO postgres;

--
-- TOC entry 11898 (class 0 OID 0)
-- Dependencies: 1304
-- Name: cso_area_conhecimento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cso_area_conhecimento_id_seq OWNED BY public.cso_area_conhecimento.id;


--
-- TOC entry 375 (class 1259 OID 14563233)
-- Name: cso_cartorio_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cso_cartorio_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.cso_cartorio_id_seq OWNER TO postgres;

--
-- TOC entry 376 (class 1259 OID 14563235)
-- Name: cso_cartorio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cso_cartorio (
 id bigint DEFAULT nextval('public.cso_cartorio_id_seq'::regclass) NOT NULL,
 nome character varying(250),
 id_cso_municipio bigint,
 serventia character varying(7),
 codigo character varying(6)
);


ALTER TABLE public.cso_cartorio OWNER TO postgres;

--
-- TOC entry 11899 (class 0 OID 0)
-- Dependencies: 376
-- Name: TABLE cso_cartorio; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.cso_cartorio IS 'Censo Escolar - Cartório';


--
-- TOC entry 377 (class 1259 OID 14563239)
-- Name: cso_curso_profissional_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cso_curso_profissional_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.cso_curso_profissional_id_seq OWNER TO postgres;

--
-- TOC entry 378 (class 1259 OID 14563241)
-- Name: cso_curso_profissional; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cso_curso_profissional (
 id bigint DEFAULT nextval('public.cso_curso_profissional_id_seq'::regclass) NOT NULL,
 id_cso_curso_profissional_eixo bigint,
 codigo character varying(5),
 nome character varying(200)
);


ALTER TABLE public.cso_curso_profissional OWNER TO postgres;

--
-- TOC entry 11900 (class 0 OID 0)
-- Dependencies: 378
-- Name: TABLE cso_curso_profissional; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.cso_curso_profissional IS 'Censo Escolar - Curso Prifissional';


--
-- TOC entry 379 (class 1259 OID 14563245)
-- Name: cso_curso_profissional_eixo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cso_curso_profissional_eixo_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.cso_curso_profissional_eixo_id_seq OWNER TO postgres;

--
-- TOC entry 380 (class 1259 OID 14563247)
-- Name: cso_curso_profissional_eixo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cso_curso_profissional_eixo (
 id bigint DEFAULT nextval('public.cso_curso_profissional_eixo_id_seq'::regclass) NOT NULL,
 nome character varying(50)
);


ALTER TABLE public.cso_curso_profissional_eixo OWNER TO postgres;

--
-- TOC entry 11901 (class 0 OID 0)
-- Dependencies: 380
-- Name: TABLE cso_curso_profissional_eixo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.cso_curso_profissional_eixo IS 'Censo Escolar - Curso Prifissional- Eixo';


--
-- TOC entry 381 (class 1259 OID 14563251)
-- Name: cso_curso_superior_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cso_curso_superior_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.cso_curso_superior_id_seq OWNER TO postgres;

--
-- TOC entry 382 (class 1259 OID 14563253)
-- Name: cso_curso_superior; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cso_curso_superior (
 id bigint DEFAULT nextval('public.cso_curso_superior_id_seq'::regclass) NOT NULL,
 area character(1) NOT NULL,
 codigo_ocde character varying(6) NOT NULL,
 nome_grau character varying(200) NOT NULL,
 grau character(1)
);


ALTER TABLE public.cso_curso_superior OWNER TO postgres;

--
-- TOC entry 11902 (class 0 OID 0)
-- Dependencies: 382
-- Name: TABLE cso_curso_superior; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.cso_curso_superior IS 'Censo Escolar - Curso Superior';


--
-- TOC entry 11903 (class 0 OID 0)
-- Dependencies: 382
-- Name: COLUMN cso_curso_superior.area; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_curso_superior.area IS '1- Educação
2- Humanidades e Artes
3- Ciências Sociais, Negócios e Direitos
4- Ciências, Matemática e Computação
5- Engenharia, Produção e Construção
6- Agricultura e Veterinária
7- Saúde e Bem-estar Social
8- Serviços
9- Outros';


--
-- TOC entry 11904 (class 0 OID 0)
-- Dependencies: 382
-- Name: COLUMN cso_curso_superior.grau; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_curso_superior.grau IS 'B- Bacharelado
L- Licenciatura
T- Tecnológico';


--
-- TOC entry 383 (class 1259 OID 14563257)
-- Name: cso_dependencia_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cso_dependencia_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.cso_dependencia_id_seq OWNER TO postgres;

--
-- TOC entry 384 (class 1259 OID 14563259)
-- Name: cso_dependencia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cso_dependencia (
 id bigint DEFAULT nextval('public.cso_dependencia_id_seq'::regclass) NOT NULL,
 codigo character varying(2),
 nome character varying(200)
);


ALTER TABLE public.cso_dependencia OWNER TO postgres;

--
-- TOC entry 11905 (class 0 OID 0)
-- Dependencies: 384
-- Name: TABLE cso_dependencia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.cso_dependencia IS 'Censo Escolar - Dependências da Escola';


--
-- TOC entry 385 (class 1259 OID 14563263)
-- Name: cso_disciplina_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cso_disciplina_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.cso_disciplina_id_seq OWNER TO postgres;

--
-- TOC entry 386 (class 1259 OID 14563265)
-- Name: cso_disciplina; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cso_disciplina (
 id bigint DEFAULT nextval('public.cso_disciplina_id_seq'::regclass) NOT NULL,
 codigo character varying(2),
 nome character varying(200)
);


ALTER TABLE public.cso_disciplina OWNER TO postgres;

--
-- TOC entry 11906 (class 0 OID 0)
-- Dependencies: 386
-- Name: TABLE cso_disciplina; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.cso_disciplina IS 'Censo Escolar - Disciplinas';


--
-- TOC entry 387 (class 1259 OID 14563269)
-- Name: cso_distrito_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cso_distrito_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.cso_distrito_id_seq OWNER TO postgres;

--
-- TOC entry 388 (class 1259 OID 14563271)
-- Name: cso_distrito; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cso_distrito (
 id bigint DEFAULT nextval('public.cso_distrito_id_seq'::regclass) NOT NULL,
 nome character varying(50),
 codigo character varying(7),
 id_cso_municipio bigint
);


ALTER TABLE public.cso_distrito OWNER TO postgres;

--
-- TOC entry 11907 (class 0 OID 0)
-- Dependencies: 388
-- Name: TABLE cso_distrito; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.cso_distrito IS 'Censo Escolar - Distritos';


--
-- TOC entry 389 (class 1259 OID 14563275)
-- Name: cso_estabelecimento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cso_estabelecimento (
 id_bas_empresa bigint NOT NULL,
 id_bas_estabelecimento bigint NOT NULL,
 codigo_inep character varying(8),
 situacao_funcionamento character(1),
 latitude character varying(20),
 longitude character varying(20),
 id_cso_municipio bigint,
 id_cso_distrito bigint,
 complemento character varying(20),
 telefone_publico1 character varying(10),
 outro_telefone character varying(11),
 fax character varying(10),
 id_cso_orgao_regional bigint,
 dependencia_administrativa character(1),
 localizacao character(1),
 categoria_privada character(1),
 conveniada_poder_publico character(1),
 mantenedora_privada character(1),
 mantenedora_sindicato character(1),
 mantenedora_organizacao character(1),
 mantenedora_instituicao character(1),
 sistema_s character(1),
 mantenedora_cnpj character varying(14),
 regulamentacao character(1),
 id_bas_colaborador bigint,
 cargo_gestor character varying(1),
 local_predio_escolar character(1),
 local_templo_igreja character(1),
 local_sala_empresa character(1),
 local_casa_professor character(1),
 local_outra_escola character(1),
 local_racho_paiol_barracao character(1),
 local_unidade_socioeducativo character(1),
 local_unidade_prisional character(1),
 local_outros character(1),
 forma_ocupacao character(1),
 predio_compartilhado character(1),
 compartilha_escola1 character(8),
 compartilha_escola2 character(8),
 compartilha_escola3 character(8),
 compartilha_escola4 character(8),
 compartilha_escola5 character(8),
 compartilha_escola6 character(8),
 agua_filtrada character(1),
 agua_rede_publica character(1),
 agua_poco_artesiano character(1),
 agua_cisterna character(1),
 agua_fonte character(1),
 agua_inexistente character(1),
 energia_publica character(1),
 energia_gerador character(1),
 energia_eolica_solar character(1),
 energia_eletrica character(1),
 energia_inexistente character(1),
 esgoto_publico character(1),
 esgoto_fossa character(1),
 esgoto_inexistente character(1),
 lixo_coleta character(1),
 lixo_queima character(1),
 lixo_outra_area character(1),
 lixo_recicla character(1),
 lixo_enterra character(1),
 lixo_outros character(1),
 dependencia_sala_diretoria character(1),
 dependencia_sala_professores character(1),
 dependencia_sala_secretaria character(1),
 dependencia_laboratorio_informatica character(1),
 dependencia_laboratorio_ciencias character(1),
 dependencia_sala_aee character(1),
 dependencia_quadra_coberta character(1),
 dependencia_quadra_descoberta character(1),
 dependencia_cozinha character(1),
 dependencia_biblioteca character(1),
 dependencia_sala_leitura character(1),
 dependencia_parque_infantil character(1),
 dependencia_bercario character(1),
 dependencia_banheiro_fora character(1),
 dependencia_banheiro_dentro character(1),
 dependencia_banheiro_adequado_infantil character(1),
 dependencia_banheiro_adequado_deficiente character(1),
 dependencia_adequado_deficiente character(1),
 dependencia_banheiro_chuveiro character(1),
 dependencia_refeitorio character(1),
 dependencia_despensa character(1),
 dependencia_almoxarifado character(1),
 dependencia_auditorio character(1),
 dependencia_patio_coberto character(1),
 dependencia_patio_descoberto character(1),
 dependencia_alojamento_aluno character(1),
 dependencia_alojamento_professor character(1),
 dependencia_area_verde character(1),
 dependencia_lavanderia character(1),
 dependencia_nenhuma_relacionada character(1),
 quantidade_salas_escola character varying(4),
 quantidade_total_salas character varying(4),
 equipamentos_televisao character varying(4),
 equipamentos_video_cassete character varying(4),
 equipamentos_dvd character varying(4),
 equipamentos_parabolica character varying(4),
 equipamentos_copiadora character varying(4),
 equipamentos_retroprojetor character varying(4),
 equipamentos_impressora character varying(4),
 equipamentos_som character varying(4),
 equipamentos_projetor character varying(4),
 equipamentos_fax character varying(4),
 equipamentos_camera_filmadora character varying(4),
 equipamentos_computadores character varying(4),
 equipamentos_computadores_administracao character varying(4),
 equipamentos_computadores_alunos character varying(4),
 acesso_internet character(1),
 banda_larga character(1),
 alimentacao_escolar character(1),
 atendimento_educacional_especializado character(1),
 atividade_complementar character(1),
 modalidade_ensino_regular character(1),
 modalidade_educacao_especial character(1),
 modalidade_eja character(1),
 etapas_creche character(1),
 etapas_pre_escola character(1),
 etapas_fundamental8 character(1),
 etapas_fundamental9 character(1),
 etapas_ensino_medio character(1),
 etapas_ensino_medio_integrado character(1),
 etapas_normal_magisterio character(1),
 etapas_educacao_profissional character(1),
 etapas_educacao_especial_creche character(1),
 etapas_educacao_especial_pre_escola character(1),
 etapas_educacao_especial_fundamental8 character(1),
 etapas_educacao_especial_fundamental9 character(1),
 etapas_educacao_especial_medio character(1),
 etapas_educacao_especial_integrado character(1),
 etapas_educacao_especial_normal_magisterio character(1),
 etapas_educacao_especial_educacao_profissional character(1),
 etapas_educacao_especial_eja_fundamental character(1),
 etapas_educacao_especial_eja_medio character(1),
 etapas_eja_fundamental character(1),
 etapas_eja_fundamental_pro_jovem character(1),
 etapas_eja_medio character(1),
 ensino_fundamental_ciclos character(1),
 localizacao_diferenciada character(1),
 material_sociocultural_nao_utiliza character(1),
 material_sociocultural_quilombola character(1),
 material_sociocultural_indigena character(1),
 educacao_indigena character(1),
 ensino_ministrado_lingua_indigena character(1),
 ensino_ministrado_lingua_portuguesa character(1),
 id_cso_lingua_indigena bigint,
 espaco_brasil_alfabetizado character(1),
 abre_finais_semana character(1),
 formacao_por_alternancia character(1),
 vinculo character(1),
 codigo_escola_sede character(8),
 quantidade_impressora_multifuncional character(4),
 modalidade_educacao_profissional character(1),
 quantidade_funcionarios character(4),
 ddd character varying(2),
 telefone character varying(9),
 id_cso_ies bigint,
 criterio_acesso_cargo_funcao_gestor character(1),
 especificacao_criterio_acesso_gestor character varying(100),
 fornece_agua_potavel_consumo character(1),
 esgoto_fossa_septica character(1),
 esgoto_fossa_rudimentar_comum character(1),
 lixo_destinacao_licenciada_poder_publico character(1),
 lixo_separacao_lixo_residuos character(1),
 lixo_reaproveitamento_reutilizacao character(1),
 lixo_nao_faz_tratamento character(1),
 dependencia_banheiro_exclusivo_funcionarios character(1),
 dependencia_banheiro character(1),
 dependencia_piscina character(1),
 dependencia_sala_repouso_alunos character(1),
 dependencia_sala_atelie_artes character(1),
 dependencia_sala_musica_coral character(1),
 dependencia_sala_estudio_danca character(1),
 dependencia_sala_multiuso character(1),
 dependencia_terreirao character(1),
 dependencia_viveiro character(1),
 acessibilidade_corrimao_guarda_corpos character(1),
 acessibilidade_elevador character(1),
 acessibilidade_pisos_tateis character(1),
 acessibilidade_portas_vao_80 character(1),
 acessibilidade_rampa character(1),
 acessibilidade_sinalizacao_sonora character(1),
 acessibilidade_sinalizacao_tatil character(1),
 acessibilidade_sinalizacao_visual character(1),
 acessibilidade_nenhum character(1),
 qtd_salas_aula_utilizadas_dentro character varying(4),
 qtd_salas_aula_utilizadas_fora character varying(4),
 qtd_salas_aula_climatizadas character varying(4),
 qtd_salas_aula_acessibilidade character varying(4),
 equipamentos_parabolica_tem character(1),
 equipamentos_computadores_tem character(1),
 equipamentos_copiadora_tem character(1),
 equipamentos_impressora_tem character(1),
 equipamentos_impressora_multifuncional character(1),
 equipamentos_scanner character(1),
 equipamentos_lousa_digital character varying(4),
 equipamentos_computadores_desktop character varying(4),
 equipamentos_computadores_portateis character varying(4),
 equipamentos_tablet character varying(4),
 internet_administrativo character(1),
 internet_processos_ensino_aprendizagem character(1),
 internet_alunos character(1),
 internet_comunidade character(1),
 equipamento_aluno_internet_da_escola_computadores_tablets character(1),
 equipamento_aluno_internet_da_escola_dispositivos_pessoais character(1),
 rede_local_cabo character(1),
 rede_local_wireless character(1),
 rede_local_nao_tem character(1),
 qtd_profissionais_auxiliares_secretaria_adm_atendente character varying(4),
 qtd_profissionais_auxiliar_gerais character varying(4),
 qtd_profissionais_bibliotecario character varying(4),
 qtd_profissionais_bombeiro_assistencia_saude character varying(4),
 qtd_profissionais_coordenador_turno_disciplina character varying(4),
 qtd_profissionais_fonoaudiologo character varying(4),
 qtd_profissionais_nutricionista character varying(4),
 qtd_profissionais_psicologo_escolar character varying(4),
 qtd_profissionais_alimentar character varying(4),
 qtd_profissionais_apoio_supervisao_pedagogica character varying(4),
 qtd_profissionais_secretario_escolar character varying(4),
 qtd_profissionais_seguranca_guarda character varying(4),
 qtd_profissionais_tecnico_monitor_aux_laboratorio character varying(4),
 organizacao_serie_ano character(1),
 organizacao_periodos_semestrais character(1),
 organizacao_grupos_nao_seriados_base_idade_competencia character(1),
 organizacao_modulos character(1),
 instrumentos_materiais_acervo_multimidia character(1),
 instrumentos_materiais_brinquedos_educacao_infantil character(1),
 instrumentos_materiais_conjunto_materiais_cientificos character(1),
 instrumentos_materiais_equipamento_amplificacao_difusao_som character(1),
 instrumentos_materiais_musicais character(1),
 instrumentos_materiais_jogos_educativos character(1),
 instrumentos_materiais_atividades_culturais_artisticas character(1),
 instrumentos_materiais_pratica_desportiva_recreacao character(1),
 instrumentos_materiais_pedagogicos_educacao_escolar_indigena character(1),
 instrumentos_materiais_pedagogicos_educacao_relacoes_etnicos character(1),
 instrumentos_materiais_pedagogicos_educao_campo character(1),
 id_cso_lingua_indigena_2 bigint,
 id_cso_lingua_indigena_3 bigint,
 escola_faz_exame_selecao character(1),
 reserva_preto_pardo_indigena character(1),
 reserva_condicao_renda character(1),
 reserva_oriundo_escola_publica character(1),
 reserva_pessoa_deficiencia character(1),
 reserva_outros_grupos character(1),
 reserva_nao_tem character(1),
 escola_possui_site_blog_rede_social character(1),
 escola_compartilha_espaco_integracao_comunidade character(1),
 escola_usa_espaco_equip_atividades_alunos character(1),
 orgaos_colegiados_associacao_pais character(1),
 orgaos_colegiados_associacao_pais_mestres character(1),
 orgaos_colegiados_conselho_escolar character(1),
 orgaos_colegiados_gremio_estudantil character(1),
 orgaos_colegiados_outros character(1),
 orgaos_colegiados_nao_tem character(1),
 projeto_politico_pedagogico_proposta character(1),
 secretaria_educacao character(1),
 secretaria_seguranca character(1),
 secretaria_saude character(1),
 outro_orgao_administracao character(1),
 oscip character(1),
 esfera_federal character(1),
 esfera_estadual character(1),
 esfera_municipal character(1)
);


ALTER TABLE public.cso_estabelecimento OWNER TO postgres;

--
-- TOC entry 11908 (class 0 OID 0)
-- Dependencies: 389
-- Name: TABLE cso_estabelecimento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.cso_estabelecimento IS 'Censo Escolar - Estabelecimento';


--
-- TOC entry 11909 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.vinculo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.vinculo IS '1 – Unidade vinculada a escola de
Educação Básica;
2 – Unidade ofertante de Ensino Superior
0 – Não';


--
-- TOC entry 11910 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.quantidade_funcionarios; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.quantidade_funcionarios IS 'tipo char(4) para manter o paadrao utilizado por paulo';


--
-- TOC entry 11911 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.criterio_acesso_cargo_funcao_gestor; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.criterio_acesso_cargo_funcao_gestor IS 'Legenda:
 1 – Ser proprietário(a) ou sócio(a)-proprietário(a) da escola
 2 – Exclusivamente por indicação/escolha da gestão
 3 – Processo seletivo qualificado e escolha/nomeação da gestão
 4 – Concurso público específico para o cargo de gestor escolar
 5 – Exclusivamente por processo eleitoral com a participação da comunidade escolar
 6 – Processo seletivo qualificado e eleição com a participação da comunidade escolar
 7 – Outros';


--
-- TOC entry 11912 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.especificacao_criterio_acesso_gestor; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.especificacao_criterio_acesso_gestor IS 'Deve ser preenchido quando o campo 5 (Critério de acesso ao cargo/função) for preenchido com 7 (Outros).';


--
-- TOC entry 11913 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.fornece_agua_potavel_consumo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.fornece_agua_potavel_consumo IS 'Campo Fornece água potável para o consumo humano - 2019 
Somente aceita os seguintes caracteres entre parêntesis: (0 1).
Legenda:
 0 – Não
 1 – Sim';


--
-- TOC entry 11914 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.esgoto_fossa_septica; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.esgoto_fossa_septica IS 'Campo Fossa séptica 2019
Somente aceita os seguintes caracteres entre parêntesis: (0 1).
Legenda:
 0 – Não
 1 – Sim';


--
-- TOC entry 11915 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.esgoto_fossa_rudimentar_comum; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.esgoto_fossa_rudimentar_comum IS 'Campo Fossa rudimentar/comum 2019
Somente aceita os seguintes caracteres entre parêntesis: (0 1).
Legenda:
 0 – Não
 1 – Sim';


--
-- TOC entry 11916 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.lixo_destinacao_licenciada_poder_publico; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.lixo_destinacao_licenciada_poder_publico IS 'Campo 2019
Somente aceita os seguintes caracteres entre parêntesis: (0 1).
Legenda:
 0 – Não
 1 – Sim';


--
-- TOC entry 11917 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.lixo_separacao_lixo_residuos; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.lixo_separacao_lixo_residuos IS 'Campo 2019
Somente aceita os seguintes caracteres entre parêntesis: (0 1).
Legenda:
 0 – Não
 1 – Sim';


--
-- TOC entry 11918 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.lixo_reaproveitamento_reutilizacao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.lixo_reaproveitamento_reutilizacao IS 'Campo 2019
Somente aceita os seguintes caracteres entre parêntesis: (0 1).
Legenda:
 0 – Não
 1 – Sim';


--
-- TOC entry 11919 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.lixo_nao_faz_tratamento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.lixo_nao_faz_tratamento IS 'Campo 2019
Somente aceita os seguintes caracteres entre parêntesis: (0 1).
Legenda:
 0 – Não
 1 – Sim';


--
-- TOC entry 11920 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.dependencia_banheiro_exclusivo_funcionarios; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.dependencia_banheiro_exclusivo_funcionarios IS 'Campo Banheiro exclusivo para os funcionários 2019
2. Somente aceita os seguintes caracteres entre parêntesis: (0 1).
Legenda:
 0 – Não
 1 – Sim';


--
-- TOC entry 11921 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.dependencia_banheiro; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.dependencia_banheiro IS 'Campo Banheiro 2019
2. Somente aceita os seguintes caracteres entre parêntesis: (0 1).
Legenda:
 0 – Não
 1 – Sim';


--
-- TOC entry 11922 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.dependencia_piscina; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.dependencia_piscina IS 'Campo piscina, 2019
Somente aceita os seguintes caracteres entre parêntesis: (0 1).
Legenda:
 0 – Não
 1 – Sim';


--
-- TOC entry 11923 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.dependencia_sala_repouso_alunos; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.dependencia_sala_repouso_alunos IS 'Campo Sala de repouso para aluno(a) 2019
Somente aceita os seguintes caracteres entre parêntesis: (0 1).
Legenda:
 0 – Não
 1 – Sim';


--
-- TOC entry 11924 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.dependencia_sala_atelie_artes; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.dependencia_sala_atelie_artes IS 'Campo 2019
Somente aceita os seguintes caracteres entre parêntesis: (0 1).
Legenda:
 0 – Não
 1 – Sim';


--
-- TOC entry 11925 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.dependencia_sala_musica_coral; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.dependencia_sala_musica_coral IS 'Campo 2019
Somente aceita os seguintes caracteres entre parêntesis: (0 1).
Legenda:
 0 – Não
 1 – Sim';


--
-- TOC entry 11926 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.dependencia_sala_estudio_danca; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.dependencia_sala_estudio_danca IS 'Campo 2019
Somente aceita os seguintes caracteres entre parêntesis: (0 1).
Legenda:
 0 – Não
 1 – Sim';


--
-- TOC entry 11927 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.dependencia_sala_multiuso; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.dependencia_sala_multiuso IS 'Campo 2019
Somente aceita os seguintes caracteres entre parêntesis: (0 1).
Legenda:
 0 – Não
 1 – Sim';


--
-- TOC entry 11928 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.dependencia_terreirao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.dependencia_terreirao IS 'Campo 2019
Somente aceita os seguintes caracteres entre parêntesis: (0 1).
Legenda:
 0 – Não
 1 – Sim';


--
-- TOC entry 11929 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.dependencia_viveiro; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.dependencia_viveiro IS 'Campo 2019
Somente aceita os seguintes caracteres entre parêntesis: (0 1).
Legenda:
 0 – Não
 1 – Sim';


--
-- TOC entry 11930 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.acessibilidade_corrimao_guarda_corpos; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.acessibilidade_corrimao_guarda_corpos IS 'Campo Corrimão e guarda-corpos 2019 
Somente aceita os seguintes caracteres entre parêntesis: (0 1).
Legenda:
 0 – Não
 1 – Sim';


--
-- TOC entry 11931 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.acessibilidade_elevador; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.acessibilidade_elevador IS '2019 
Somente aceita os seguintes caracteres entre parêntesis: (0 1).
Legenda:
 0 – Não
 1 – Sim';


--
-- TOC entry 11932 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.acessibilidade_pisos_tateis; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.acessibilidade_pisos_tateis IS '2019 
Somente aceita os seguintes caracteres entre parêntesis: (0 1).
Legenda:
 0 – Não
 1 – Sim';


--
-- TOC entry 11933 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.acessibilidade_portas_vao_80; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.acessibilidade_portas_vao_80 IS '2019 
Somente aceita os seguintes caracteres entre parêntesis: (0 1).
Legenda:
 0 – Não
 1 – Sim';


--
-- TOC entry 11934 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.acessibilidade_rampa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.acessibilidade_rampa IS '2019 
Somente aceita os seguintes caracteres entre parêntesis: (0 1).
Legenda:
 0 – Não
 1 – Sim';


--
-- TOC entry 11935 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.acessibilidade_sinalizacao_sonora; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.acessibilidade_sinalizacao_sonora IS '2019 
Somente aceita os seguintes caracteres entre parêntesis: (0 1).
Legenda:
 0 – Não
 1 – Sim';


--
-- TOC entry 11936 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.acessibilidade_sinalizacao_tatil; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.acessibilidade_sinalizacao_tatil IS '2019 
Somente aceita os seguintes caracteres entre parêntesis: (0 1).
Legenda:
 0 – Não
 1 – Sim';


--
-- TOC entry 11937 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.acessibilidade_sinalizacao_visual; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.acessibilidade_sinalizacao_visual IS '2019 
Somente aceita os seguintes caracteres entre parêntesis: (0 1).
Legenda:
 0 – Não
 1 – Sim';


--
-- TOC entry 11938 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.acessibilidade_nenhum; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.acessibilidade_nenhum IS '2019 
Somente aceita os seguintes caracteres entre parêntesis: (0 1).
Legenda:
 0 – Não
 1 – Sim';


--
-- TOC entry 11939 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.qtd_salas_aula_utilizadas_dentro; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.qtd_salas_aula_utilizadas_dentro IS 'Número de salas de aula utilizadas na escola dentro do prédio escolar';


--
-- TOC entry 11940 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.qtd_salas_aula_utilizadas_fora; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.qtd_salas_aula_utilizadas_fora IS 'Número de salas de aula utilizadas na escola fora do prédio escolar';


--
-- TOC entry 11941 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.qtd_salas_aula_climatizadas; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.qtd_salas_aula_climatizadas IS 'Número de salas de aula climatizadas 2019';


--
-- TOC entry 11942 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.qtd_salas_aula_acessibilidade; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.qtd_salas_aula_acessibilidade IS 'Número de salas de aula com acessibilidade para pessoas com deficiência ou mobilidade reduzida';


--
-- TOC entry 11943 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.equipamentos_parabolica_tem; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.equipamentos_parabolica_tem IS 'Para dizer se tem ou não, o outro é de quantidade';


--
-- TOC entry 11944 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.equipamentos_computadores_tem; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.equipamentos_computadores_tem IS 'Para dizer se tem ou não, o outro é de quantidade';


--
-- TOC entry 11945 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.equipamentos_copiadora_tem; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.equipamentos_copiadora_tem IS 'Só para dizer se tem, o outro é quantidade e saiu em 2019, mas não queremos perder a informação';


--
-- TOC entry 11946 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.equipamentos_impressora_tem; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.equipamentos_impressora_tem IS 'Só para dizer se tem, o outro é quantidade e saiu em 2019, mas não queremos perder a informação';


--
-- TOC entry 11947 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.equipamentos_impressora_multifuncional; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.equipamentos_impressora_multifuncional IS '2019';


--
-- TOC entry 11948 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.equipamentos_scanner; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.equipamentos_scanner IS '2019 - Para dizer se tem ou não';


--
-- TOC entry 11949 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.equipamentos_lousa_digital; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.equipamentos_lousa_digital IS 'quantidade - 2019';


--
-- TOC entry 11950 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.equipamentos_computadores_desktop; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.equipamentos_computadores_desktop IS '2019';


--
-- TOC entry 11951 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.equipamentos_tablet; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.equipamentos_tablet IS '2019';


--
-- TOC entry 11952 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.internet_administrativo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.internet_administrativo IS '2019';


--
-- TOC entry 11953 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.internet_processos_ensino_aprendizagem; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.internet_processos_ensino_aprendizagem IS '2019';


--
-- TOC entry 11954 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.internet_alunos; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.internet_alunos IS '2019';


--
-- TOC entry 11955 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.internet_comunidade; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.internet_comunidade IS '2019';


--
-- TOC entry 11956 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.equipamento_aluno_internet_da_escola_computadores_tablets; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.equipamento_aluno_internet_da_escola_computadores_tablets IS 'Campo Computadores de mesa, portáteis e tablets da escola (no laboratório de informática, biblioteca, sala de aula, etc.)
Da seção: Equipamentos que os aluno(a)s usam para acessar a internet da escola
2019
Somente aceita os seguintes caracteres entre parêntesis: (0 1).
Legenda:
 0 – Não
 1 – Sim';


--
-- TOC entry 11957 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.equipamento_aluno_internet_da_escola_dispositivos_pessoais; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.equipamento_aluno_internet_da_escola_dispositivos_pessoais IS 'Campo Dispositivos pessoais (computadores portáteis, celulares, tablets, etc.) 
Seção: Equipamentos que os aluno(a)s usam para acessar a internet da escola
2019';


--
-- TOC entry 11958 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.rede_local_cabo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.rede_local_cabo IS 'Campo A cabo
Seção Rede local de interligação de computadores
2019';


--
-- TOC entry 11959 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.rede_local_nao_tem; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.rede_local_nao_tem IS '2019';


--
-- TOC entry 11960 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.qtd_profissionais_auxiliares_secretaria_adm_atendente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.qtd_profissionais_auxiliares_secretaria_adm_atendente IS 'Auxiliares de secretaria ou auxiliares administrativos, atendentes';


--
-- TOC entry 11961 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.qtd_profissionais_auxiliar_gerais; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.qtd_profissionais_auxiliar_gerais IS 'Auxiliar de serviços gerais, porteiro(a), zelador(a), faxineiro(a), horticultor(a), jardineiro(a)';


--
-- TOC entry 11962 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.qtd_profissionais_bibliotecario; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.qtd_profissionais_bibliotecario IS 'Bibliotecário(a), auxiliar de biblioteca ou monitor(a) da sala de leitura';


--
-- TOC entry 11963 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.qtd_profissionais_bombeiro_assistencia_saude; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.qtd_profissionais_bombeiro_assistencia_saude IS 'Bombeiro(a) brigadista, profissionais de assistência a saúde (urgência e emergência), Enfermeiro(a), Técnico(a) de enfermagem e socorrista';


--
-- TOC entry 11964 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.qtd_profissionais_coordenador_turno_disciplina; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.qtd_profissionais_coordenador_turno_disciplina IS 'Coordenador(a) de turno/disciplina';


--
-- TOC entry 11965 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.qtd_profissionais_fonoaudiologo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.qtd_profissionais_fonoaudiologo IS 'Fonoaudiólogo(a)';


--
-- TOC entry 11966 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.qtd_profissionais_nutricionista; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.qtd_profissionais_nutricionista IS 'Nutricionista';


--
-- TOC entry 11967 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.qtd_profissionais_psicologo_escolar; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.qtd_profissionais_psicologo_escolar IS 'Psicólogo(a) Escolar';


--
-- TOC entry 11968 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.qtd_profissionais_alimentar; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.qtd_profissionais_alimentar IS 'Profissionais de preparação e segurança alimentar, cozinheiro(a), merendeira e auxiliar de cozinha';


--
-- TOC entry 11969 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.qtd_profissionais_apoio_supervisao_pedagogica; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.qtd_profissionais_apoio_supervisao_pedagogica IS 'Profissionais de apoio e supervisão pedagógica: (pedagogo(a), coordenador(a) pedagógico(a), orientador(a) educacional, supervisor(a) escolar e coordenador(a) de área de ensino';


--
-- TOC entry 11970 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.qtd_profissionais_secretario_escolar; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.qtd_profissionais_secretario_escolar IS 'Secretário(a) escolar';


--
-- TOC entry 11971 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.qtd_profissionais_seguranca_guarda; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.qtd_profissionais_seguranca_guarda IS 'Seguranças, guarda ou segurança patrimonial';


--
-- TOC entry 11972 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.qtd_profissionais_tecnico_monitor_aux_laboratorio; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.qtd_profissionais_tecnico_monitor_aux_laboratorio IS 'Técnicos(as), monitores(as) ou auxiliares de laboratório(s)';


--
-- TOC entry 11973 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.organizacao_serie_ano; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.organizacao_serie_ano IS 'Forma(s) de organização do ensino
Campo Série/Ano (séries anuais)
Somente aceita os seguintes caracteres entre parêntesis: (0 1).
Legenda:
 0 – Não
 1 – Sim';


--
-- TOC entry 11974 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.organizacao_periodos_semestrais; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.organizacao_periodos_semestrais IS 'Períodos semestrais';


--
-- TOC entry 11975 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.organizacao_grupos_nao_seriados_base_idade_competencia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.organizacao_grupos_nao_seriados_base_idade_competencia IS 'Grupos não-seriados com base na idade ou competência (art. 23 LDB)';


--
-- TOC entry 11976 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.organizacao_modulos; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.organizacao_modulos IS 'Módulos';


--
-- TOC entry 11977 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.instrumentos_materiais_acervo_multimidia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.instrumentos_materiais_acervo_multimidia IS 'Seção Instrumentos, materiais socioculturais e/ou pedagógicos em uso na escola para o desenvolvimento de atividades de ensino aprendizagem
Campo Acervo multimídia
Somente aceita os seguintes caracteres entre parêntesis: (0 1).
Legenda:
 0 – Não
 1 – Sim';


--
-- TOC entry 11978 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.instrumentos_materiais_brinquedos_educacao_infantil; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.instrumentos_materiais_brinquedos_educacao_infantil IS 'Brinquedos para Educação Infantil';


--
-- TOC entry 11979 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.instrumentos_materiais_conjunto_materiais_cientificos; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.instrumentos_materiais_conjunto_materiais_cientificos IS 'Conjunto de materiais científicos';


--
-- TOC entry 11980 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.instrumentos_materiais_equipamento_amplificacao_difusao_som; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.instrumentos_materiais_equipamento_amplificacao_difusao_som IS 'Equipamento para amplificação e difusão de som/áudio';


--
-- TOC entry 11981 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.instrumentos_materiais_musicais; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.instrumentos_materiais_musicais IS 'Instrumentos musicais para conjunto, banda/fanfarra e/ou aulas de música';


--
-- TOC entry 11982 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.instrumentos_materiais_jogos_educativos; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.instrumentos_materiais_jogos_educativos IS 'Jogos educativos';


--
-- TOC entry 11983 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.instrumentos_materiais_atividades_culturais_artisticas; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.instrumentos_materiais_atividades_culturais_artisticas IS 'Materiais para atividades culturais e artísticas';


--
-- TOC entry 11984 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.instrumentos_materiais_pratica_desportiva_recreacao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.instrumentos_materiais_pratica_desportiva_recreacao IS 'Materiais para prática desportiva e recreação';


--
-- TOC entry 11985 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.instrumentos_materiais_pedagogicos_educacao_escolar_indigena; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.instrumentos_materiais_pedagogicos_educacao_escolar_indigena IS 'Materiais pedagógicos para a educação escolar indígena';


--
-- TOC entry 11986 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.instrumentos_materiais_pedagogicos_educacao_relacoes_etnicos; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.instrumentos_materiais_pedagogicos_educacao_relacoes_etnicos IS 'Materiais pedagógicos para a educação das Relações Étnicos Raciais';


--
-- TOC entry 11987 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.instrumentos_materiais_pedagogicos_educao_campo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.instrumentos_materiais_pedagogicos_educao_campo IS 'Materiais pedagógicos para a educação do campo';


--
-- TOC entry 11988 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.escola_faz_exame_selecao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.escola_faz_exame_selecao IS 'A escola faz exame de seleção para ingresso de seus aluno(a)s (Avaliação por prova e /ou analise curricular)';


--
-- TOC entry 11989 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.reserva_preto_pardo_indigena; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.reserva_preto_pardo_indigena IS 'Autodeclarado preto, pardo ou indígena (PPI)';


--
-- TOC entry 11990 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.reserva_condicao_renda; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.reserva_condicao_renda IS 'Condição de Renda';


--
-- TOC entry 11991 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.reserva_oriundo_escola_publica; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.reserva_oriundo_escola_publica IS 'Oriundo de escola pública';


--
-- TOC entry 11992 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.reserva_pessoa_deficiencia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.reserva_pessoa_deficiencia IS 'Pessoa com deficiência (PCD)';


--
-- TOC entry 11993 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.reserva_outros_grupos; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.reserva_outros_grupos IS 'Outros grupos que não os listados';


--
-- TOC entry 11994 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.reserva_nao_tem; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.reserva_nao_tem IS 'Sem reservas de vagas para sistema de cotas (ampla concorrência)';


--
-- TOC entry 11995 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.escola_possui_site_blog_rede_social; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.escola_possui_site_blog_rede_social IS 'A escola possui site ou blog ou página em redes sociais para comunicação institucional
Somente aceita os seguintes caracteres entre parêntesis: (0 1).
Legenda:
 0 – Não
 1 – Sim';


--
-- TOC entry 11996 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.escola_compartilha_espaco_integracao_comunidade; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.escola_compartilha_espaco_integracao_comunidade IS 'A escola compartilha espaços para atividades de integração escola-comunidade';


--
-- TOC entry 11997 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.escola_usa_espaco_equip_atividades_alunos; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.escola_usa_espaco_equip_atividades_alunos IS 'A escola usa espaços e equipamentos do entorno escolar para atividades regulares com os aluno(a)s';


--
-- TOC entry 11998 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.orgaos_colegiados_associacao_pais; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.orgaos_colegiados_associacao_pais IS 'Associação de Pais
Somente aceita os seguintes caracteres entre parêntesis: (1).
Legenda:
 1 – Sim';


--
-- TOC entry 11999 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.orgaos_colegiados_associacao_pais_mestres; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.orgaos_colegiados_associacao_pais_mestres IS 'Associação de Pais e Mestres';


--
-- TOC entry 12000 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.orgaos_colegiados_conselho_escolar; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.orgaos_colegiados_conselho_escolar IS 'Conselho Escolar';


--
-- TOC entry 12001 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.orgaos_colegiados_gremio_estudantil; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.orgaos_colegiados_gremio_estudantil IS 'Grêmio Estudantil';


--
-- TOC entry 12002 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.orgaos_colegiados_outros; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.orgaos_colegiados_outros IS 'Somente aceita os seguintes caracteres entre parêntesis: (1).
Legenda:
 1 – Sim';


--
-- TOC entry 12003 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.orgaos_colegiados_nao_tem; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.orgaos_colegiados_nao_tem IS 'Não há órgãos colegiados em funcionamento
Somente aceita os seguintes caracteres entre parêntesis: (1).
Legenda:
 1 – Sim';


--
-- TOC entry 12004 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.projeto_politico_pedagogico_proposta; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.projeto_politico_pedagogico_proposta IS 'Projeto político pedagógico ou a proposta pedagógica da escola (conforme art. 12 da LDB) atualizado nos últimos 12 meses até a data de referência
Somente aceita os seguintes caracteres entre parêntesis: (0 1 2).
Legenda:
 0 – Não
 1 – Sim
 2 – A escola não possui projeto político pedagógico/proposta pedagógica';


--
-- TOC entry 12005 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.secretaria_educacao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.secretaria_educacao IS 'Campo Secretaria de Educação/Ministério da Educação';


--
-- TOC entry 12006 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.secretaria_seguranca; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.secretaria_seguranca IS 'Campo Secretaria de Segurança Pública/Forças Armadas/Militar';


--
-- TOC entry 12007 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.secretaria_saude; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.secretaria_saude IS 'Campo Secretaria da Saúde/Ministério da Saúde';


--
-- TOC entry 12008 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.outro_orgao_administracao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.outro_orgao_administracao IS 'Campo Outro órgão da administração pública';


--
-- TOC entry 12009 (class 0 OID 0)
-- Dependencies: 389
-- Name: COLUMN cso_estabelecimento.oscip; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_estabelecimento.oscip IS 'Campo Organização da Sociedade Civil de Interesse Público (Oscip)';


--
-- TOC entry 1297 (class 1259 OID 18535227)
-- Name: cso_etapa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cso_etapa (
 id bigint NOT NULL,
 nome character varying(200),
 codigo character varying(10),
 curso character varying(200)
);


ALTER TABLE public.cso_etapa OWNER TO postgres;

--
-- TOC entry 1296 (class 1259 OID 18535225)
-- Name: cso_etapa_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cso_etapa_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.cso_etapa_id_seq OWNER TO postgres;

--
-- TOC entry 12010 (class 0 OID 0)
-- Dependencies: 1296
-- Name: cso_etapa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cso_etapa_id_seq OWNED BY public.cso_etapa.id;


--
-- TOC entry 390 (class 1259 OID 14563281)
-- Name: cso_etapa_modalidade_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cso_etapa_modalidade_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.cso_etapa_modalidade_id_seq OWNER TO postgres;

--
-- TOC entry 391 (class 1259 OID 14563283)
-- Name: cso_etapa_modalidade; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cso_etapa_modalidade (
 id bigint DEFAULT nextval('public.cso_etapa_modalidade_id_seq'::regclass) NOT NULL,
 codigo character varying(2),
 nome character varying(100),
 regular character(1),
 especial character(1),
 eja character(1),
 curso character varying(100)
);


ALTER TABLE public.cso_etapa_modalidade OWNER TO postgres;

--
-- TOC entry 12011 (class 0 OID 0)
-- Dependencies: 391
-- Name: TABLE cso_etapa_modalidade; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.cso_etapa_modalidade IS 'Censo Escolar - Etapa x Modalidade';


--
-- TOC entry 12012 (class 0 OID 0)
-- Dependencies: 391
-- Name: COLUMN cso_etapa_modalidade.regular; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_etapa_modalidade.regular IS '0- Não
1- Sim';


--
-- TOC entry 12013 (class 0 OID 0)
-- Dependencies: 391
-- Name: COLUMN cso_etapa_modalidade.especial; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_etapa_modalidade.especial IS '0- Não
1- Sim';


--
-- TOC entry 12014 (class 0 OID 0)
-- Dependencies: 391
-- Name: COLUMN cso_etapa_modalidade.eja; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_etapa_modalidade.eja IS '0- Não
1- Sim';


--
-- TOC entry 392 (class 1259 OID 14563287)
-- Name: cso_exportacao_arquivo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cso_exportacao_arquivo_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.cso_exportacao_arquivo_id_seq OWNER TO postgres;

--
-- TOC entry 393 (class 1259 OID 14563289)
-- Name: cso_exportacao_arquivo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cso_exportacao_arquivo (
 id bigint DEFAULT nextval('public.cso_exportacao_arquivo_id_seq'::regclass) NOT NULL,
 ano character(4),
 seq bigint,
 id_bas_empresa bigint NOT NULL,
 id_bas_estabelecimento bigint NOT NULL,
 data_geracao date,
 nome_arquivo character varying(1000),
 tipo character(1),
 descricao character varying(1000),
 tabela character varying(100),
 campo character varying(250),
 hora_geracao character(8),
 chave_tabela bigint,
 registro character(2),
 numero_campo smallint,
 regra smallint,
 link character varying(50)
);


ALTER TABLE public.cso_exportacao_arquivo OWNER TO postgres;

--
-- TOC entry 12015 (class 0 OID 0)
-- Dependencies: 393
-- Name: TABLE cso_exportacao_arquivo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.cso_exportacao_arquivo IS 'Censo Escolar - Exportação de Arquivo';


--
-- TOC entry 12016 (class 0 OID 0)
-- Dependencies: 393
-- Name: COLUMN cso_exportacao_arquivo.descricao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_exportacao_arquivo.descricao IS 'Mensagem de erro do Censo, com ou sem adaptação';


--
-- TOC entry 12017 (class 0 OID 0)
-- Dependencies: 393
-- Name: COLUMN cso_exportacao_arquivo.tabela; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_exportacao_arquivo.tabela IS 'O campo será descontinuado';


--
-- TOC entry 12018 (class 0 OID 0)
-- Dependencies: 393
-- Name: COLUMN cso_exportacao_arquivo.chave_tabela; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_exportacao_arquivo.chave_tabela IS 'armazena o id do registro da tabela relacionada ao erro';


--
-- TOC entry 12019 (class 0 OID 0)
-- Dependencies: 393
-- Name: COLUMN cso_exportacao_arquivo.registro; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_exportacao_arquivo.registro IS 'Registro do layout';


--
-- TOC entry 12020 (class 0 OID 0)
-- Dependencies: 393
-- Name: COLUMN cso_exportacao_arquivo.numero_campo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_exportacao_arquivo.numero_campo IS 'Número do campo do layout';


--
-- TOC entry 12021 (class 0 OID 0)
-- Dependencies: 393
-- Name: COLUMN cso_exportacao_arquivo.regra; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_exportacao_arquivo.regra IS 'Regra do layout';


--
-- TOC entry 12022 (class 0 OID 0)
-- Dependencies: 393
-- Name: COLUMN cso_exportacao_arquivo.link; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_exportacao_arquivo.link IS 'Aplicação que irá compor o link';


--
-- TOC entry 394 (class 1259 OID 14563296)
-- Name: cso_ies_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cso_ies_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.cso_ies_id_seq OWNER TO postgres;

--
-- TOC entry 395 (class 1259 OID 14563298)
-- Name: cso_ies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cso_ies (
 id bigint DEFAULT nextval('public.cso_ies_id_seq'::regclass) NOT NULL,
 codigo character varying(8),
 nome character varying(150),
 id_cso_municipio bigint,
 dependencia_administrativa character(1),
 tipo_instituicao character(3),
 condicao_funcionamento character(1)
);


ALTER TABLE public.cso_ies OWNER TO postgres;

--
-- TOC entry 12023 (class 0 OID 0)
-- Dependencies: 395
-- Name: TABLE cso_ies; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.cso_ies IS 'Censo Escolar - Instituto de Educação Superior';


--
-- TOC entry 12024 (class 0 OID 0)
-- Dependencies: 395
-- Name: COLUMN cso_ies.dependencia_administrativa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_ies.dependencia_administrativa IS '1 - Federal
2- Estadual
3- Municipal
4- Privada
7- Especial';


--
-- TOC entry 12025 (class 0 OID 0)
-- Dependencies: 395
-- Name: COLUMN cso_ies.tipo_instituicao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_ies.tipo_instituicao IS 'PUB- Pública
PRI- Privada';


--
-- TOC entry 12026 (class 0 OID 0)
-- Dependencies: 395
-- Name: COLUMN cso_ies.condicao_funcionamento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_ies.condicao_funcionamento IS 'A - Ativa
I- Inativa';


--
-- TOC entry 396 (class 1259 OID 14563302)
-- Name: cso_lingua_indigena_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cso_lingua_indigena_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.cso_lingua_indigena_id_seq OWNER TO postgres;

--
-- TOC entry 397 (class 1259 OID 14563304)
-- Name: cso_lingua_indigena; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cso_lingua_indigena (
 id bigint DEFAULT nextval('public.cso_lingua_indigena_id_seq'::regclass) NOT NULL,
 id_cso_lingua_indigena_familia bigint,
 id_cso_lingua_indigena_classificacao bigint,
 id_cso_lingua_indigena_tronco bigint,
 codigo character varying(3),
 nome character varying(100)
);


ALTER TABLE public.cso_lingua_indigena OWNER TO postgres;

--
-- TOC entry 12027 (class 0 OID 0)
-- Dependencies: 397
-- Name: TABLE cso_lingua_indigena; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.cso_lingua_indigena IS 'Censo Escolar - Lingua Indígena';


--
-- TOC entry 398 (class 1259 OID 14563308)
-- Name: cso_lingua_indigena_classificacao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cso_lingua_indigena_classificacao_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.cso_lingua_indigena_classificacao_id_seq OWNER TO postgres;

--
-- TOC entry 399 (class 1259 OID 14563310)
-- Name: cso_lingua_indigena_classificacao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cso_lingua_indigena_classificacao (
 id bigint DEFAULT nextval('public.cso_lingua_indigena_classificacao_id_seq'::regclass) NOT NULL,
 id_cso_lingua_indigena_familia bigint,
 nome character varying(50)
);


ALTER TABLE public.cso_lingua_indigena_classificacao OWNER TO postgres;

--
-- TOC entry 12028 (class 0 OID 0)
-- Dependencies: 399
-- Name: TABLE cso_lingua_indigena_classificacao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.cso_lingua_indigena_classificacao IS 'Censo Escolar - Lingua Indígena - Classificação';


--
-- TOC entry 400 (class 1259 OID 14563314)
-- Name: cso_lingua_indigena_familia_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cso_lingua_indigena_familia_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.cso_lingua_indigena_familia_id_seq OWNER TO postgres;

--
-- TOC entry 401 (class 1259 OID 14563316)
-- Name: cso_lingua_indigena_familia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cso_lingua_indigena_familia (
 id bigint DEFAULT nextval('public.cso_lingua_indigena_familia_id_seq'::regclass) NOT NULL,
 id_cso_lingua_indigena_tronco bigint,
 nome character varying(20)
);


ALTER TABLE public.cso_lingua_indigena_familia OWNER TO postgres;

--
-- TOC entry 12029 (class 0 OID 0)
-- Dependencies: 401
-- Name: TABLE cso_lingua_indigena_familia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.cso_lingua_indigena_familia IS 'Censo Escolar - Lingua Indígena - Família';


--
-- TOC entry 402 (class 1259 OID 14563320)
-- Name: cso_lingua_indigena_tronco_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cso_lingua_indigena_tronco_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.cso_lingua_indigena_tronco_id_seq OWNER TO postgres;

--
-- TOC entry 403 (class 1259 OID 14563322)
-- Name: cso_lingua_indigena_tronco; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cso_lingua_indigena_tronco (
 id bigint DEFAULT nextval('public.cso_lingua_indigena_tronco_id_seq'::regclass) NOT NULL,
 codigo character varying(6),
 nome character varying(100)
);


ALTER TABLE public.cso_lingua_indigena_tronco OWNER TO postgres;

--
-- TOC entry 12030 (class 0 OID 0)
-- Dependencies: 403
-- Name: TABLE cso_lingua_indigena_tronco; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.cso_lingua_indigena_tronco IS 'Censo Escolar - Lingua Indígena - Tronco';


--
-- TOC entry 404 (class 1259 OID 14563326)
-- Name: cso_municipio_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cso_municipio_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.cso_municipio_id_seq OWNER TO postgres;

--
-- TOC entry 405 (class 1259 OID 14563328)
-- Name: cso_municipio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cso_municipio (
 id bigint DEFAULT nextval('public.cso_municipio_id_seq'::regclass) NOT NULL,
 id_cso_uf bigint NOT NULL,
 codigo character varying(7) NOT NULL,
 nome character varying(100) NOT NULL,
 cep_inicio character varying(8),
 cep_final character varying(8),
 ddd1 character(2),
 ddd2 character(2)
);


ALTER TABLE public.cso_municipio OWNER TO postgres;

--
-- TOC entry 12031 (class 0 OID 0)
-- Dependencies: 405
-- Name: TABLE cso_municipio; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.cso_municipio IS 'Censo Escolar - Município';


--
-- TOC entry 406 (class 1259 OID 14563332)
-- Name: cso_orgao_emissor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cso_orgao_emissor_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.cso_orgao_emissor_id_seq OWNER TO postgres;

--
-- TOC entry 407 (class 1259 OID 14563334)
-- Name: cso_orgao_emissor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cso_orgao_emissor (
 id bigint DEFAULT nextval('public.cso_orgao_emissor_id_seq'::regclass) NOT NULL,
 codigo character varying(2),
 nome character varying(100),
 sigla character varying(10)
);


ALTER TABLE public.cso_orgao_emissor OWNER TO postgres;

--
-- TOC entry 12032 (class 0 OID 0)
-- Dependencies: 407
-- Name: TABLE cso_orgao_emissor; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.cso_orgao_emissor IS 'Censo Escolar - Orgão Emissor';


--
-- TOC entry 408 (class 1259 OID 14563338)
-- Name: cso_orgao_regional_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cso_orgao_regional_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.cso_orgao_regional_id_seq OWNER TO postgres;

--
-- TOC entry 409 (class 1259 OID 14563340)
-- Name: cso_orgao_regional; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cso_orgao_regional (
 id bigint DEFAULT nextval('public.cso_orgao_regional_id_seq'::regclass) NOT NULL,
 codigo character varying(5),
 nome character varying(100),
 id_cso_municipio bigint
);


ALTER TABLE public.cso_orgao_regional OWNER TO postgres;

--
-- TOC entry 12033 (class 0 OID 0)
-- Dependencies: 409
-- Name: TABLE cso_orgao_regional; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.cso_orgao_regional IS 'Censo Escolar - Órgão Regional';


--
-- TOC entry 410 (class 1259 OID 14563344)
-- Name: cso_pais_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cso_pais_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.cso_pais_id_seq OWNER TO postgres;

--
-- TOC entry 411 (class 1259 OID 14563346)
-- Name: cso_pais; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cso_pais (
 id bigint DEFAULT nextval('public.cso_pais_id_seq'::regclass) NOT NULL,
 codigo character varying(3),
 iso_apha3 character varying(3),
 nome character varying(100)
);


ALTER TABLE public.cso_pais OWNER TO postgres;

--
-- TOC entry 12034 (class 0 OID 0)
-- Dependencies: 411
-- Name: TABLE cso_pais; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.cso_pais IS 'Censo Escolar - País';


--
-- TOC entry 412 (class 1259 OID 14563350)
-- Name: cso_professor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cso_professor (
 id_bas_empresa bigint NOT NULL,
 id_bas_colaborador bigint NOT NULL,
 situacao_funcional character(1),
 codigo_inep character varying(12),
 numero_nis character varying(11),
 localizacao character(1),
 profissional_deficiente character(1),
 deficiencia_cegueira character(1),
 deficiencia_baixa_visao character(1),
 deficiencia_surdez character(1),
 deficiencia_auditiva character(1),
 deficiencia_surdocegueira character(1),
 deficiencia_fisica character(1),
 deficiencia_intelectual character(1),
 deficiencia_multipla character(1),
 escolaridade character(1),
 superior_situacao1 character(1),
 complementacao_pedagogica1 character(1),
 id_cso_curso_superior1 bigint,
 ano_inicio_superior1 character(4),
 ano_conclusao_superior1 character(4),
 id_cso_ies1 bigint,
 superior_situacao2 character(1),
 complementacao_pedagogica2 character(1),
 id_cso_curso_superior2 bigint,
 ano_inicio_superior2 character(4),
 ano_conclusao_superior2 character(4),
 id_cso_ies2 bigint,
 superior_situacao3 character(1),
 complementacao_pedagogica3 character(1),
 id_cso_curso_superior3 bigint,
 ano_inicio_superior3 character(4),
 ano_conclusao_superior3 character(4),
 id_cso_ies3 bigint,
 pos_graduacao_especializacao character(1),
 pos_graduacao_mestrado character(1),
 pos_graduacao_doutorado character(1),
 pos_graduacao_nenhum character(1),
 especifico_creche character(1),
 especifico_pre_escola character(1),
 especifico_anos_iniciais_fundamental character(1),
 especifico_anos_finais_fundamental character(1),
 especifico_ensino_medio character(1),
 especifico_eja character(1),
 especifico_especial character(1),
 especifico_indigena character(1),
 especifico_campo character(1),
 especifico_ambiental character(1),
 especifico_direitos_humanos character(1),
 especifico_genero_diversidade_sexual character(1),
 especifico_direitos_crianca_adolescente character(1),
 especifico_etnicoraciais character(1),
 especifico_outros character(1),
 especifico_nenhum character(1),
 nome_mae character varying(100),
 nome_pai character varying,
 filiacao character(1),
 deficiencia_transtorno_espectro_autista character(1),
 deficiencia_altas_habilidades_superdotacao character(1),
 id_cso_area_conhecimento_1 bigint,
 id_cso_area_conhecimento_2 bigint,
 id_cso_area_conhecimento_3 bigint,
 tipo_ensino_medio_cursado character(1),
 localizacao_diferenciada character(1),
 id_bas_situacao_funcional bigint
);


ALTER TABLE public.cso_professor OWNER TO postgres;

--
-- TOC entry 12035 (class 0 OID 0)
-- Dependencies: 412
-- Name: TABLE cso_professor; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.cso_professor IS 'Censo Escolar - Professor';


--
-- TOC entry 12036 (class 0 OID 0)
-- Dependencies: 412
-- Name: COLUMN cso_professor.nome_mae; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_professor.nome_mae IS 'Nome da mãe';


--
-- TOC entry 12037 (class 0 OID 0)
-- Dependencies: 412
-- Name: COLUMN cso_professor.nome_pai; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_professor.nome_pai IS 'Nome do pai';


--
-- TOC entry 12038 (class 0 OID 0)
-- Dependencies: 412
-- Name: COLUMN cso_professor.deficiencia_transtorno_espectro_autista; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_professor.deficiencia_transtorno_espectro_autista IS 'Transtorno do espectro autista';


--
-- TOC entry 12039 (class 0 OID 0)
-- Dependencies: 412
-- Name: COLUMN cso_professor.deficiencia_altas_habilidades_superdotacao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_professor.deficiencia_altas_habilidades_superdotacao IS 'Altas habilidades/ Superdotação
Somente aceita os seguintes caracteres entre parêntesis: (0 1).
Legenda:
 0 – Não
 1 – Sim';


--
-- TOC entry 12040 (class 0 OID 0)
-- Dependencies: 412
-- Name: COLUMN cso_professor.tipo_ensino_medio_cursado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_professor.tipo_ensino_medio_cursado IS 'Somente aceita os seguintes caracteres entre parêntesis: (1 2 3 4).
Legenda:
 1 – Formação Geral
 2 – Modalidade Normal (Magistério)
 3 – Curso Técnico
 4 – Magistério Indígena Modalidade Normal';


--
-- TOC entry 12041 (class 0 OID 0)
-- Dependencies: 412
-- Name: COLUMN cso_professor.localizacao_diferenciada; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_professor.localizacao_diferenciada IS 'Somente aceita os seguintes caracteres entre parêntesis: (1 2 3 7).
Legenda:
 1 – Área de assentamento
 2 – Terra indígena
 3 – Área onde se localiza comunidade
remanescente de quilombos
 7 – Não está em área de localização diferenciada';


--
-- TOC entry 413 (class 1259 OID 14563356)
-- Name: cso_professor_turma; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cso_professor_turma (
 id_bas_empresa bigint NOT NULL,
 id_bas_colaborador bigint NOT NULL,
 id_sge_turma bigint NOT NULL,
 funcao_turma character(1),
 id_cso_disciplina1 bigint,
 id_cso_disciplina2 bigint,
 id_cso_disciplina3 bigint,
 id_cso_disciplina4 bigint,
 id_cso_disciplina5 bigint,
 id_cso_disciplina6 bigint,
 id_cso_disciplina7 bigint,
 id_cso_disciplina8 bigint,
 id_cso_disciplina9 bigint,
 id_cso_disciplina10 bigint,
 id_cso_disciplina11 bigint,
 id_cso_disciplina12 bigint,
 id_cso_disciplina13 bigint
);


ALTER TABLE public.cso_professor_turma OWNER TO postgres;

--
-- TOC entry 12042 (class 0 OID 0)
-- Dependencies: 413
-- Name: TABLE cso_professor_turma; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.cso_professor_turma IS 'Censo Escolar - Professor-Turma';


--
-- TOC entry 414 (class 1259 OID 14563359)
-- Name: cso_regra_disciplina_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cso_regra_disciplina_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.cso_regra_disciplina_id_seq OWNER TO postgres;

--
-- TOC entry 415 (class 1259 OID 14563361)
-- Name: cso_regra_disciplina; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cso_regra_disciplina (
 id bigint DEFAULT nextval('public.cso_regra_disciplina_id_seq'::regclass) NOT NULL,
 id_cso_etapa_modalidade bigint,
 id_cso_disciplina bigint,
 pode character(1)
);


ALTER TABLE public.cso_regra_disciplina OWNER TO postgres;

--
-- TOC entry 12043 (class 0 OID 0)
-- Dependencies: 415
-- Name: TABLE cso_regra_disciplina; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.cso_regra_disciplina IS 'Censo Escolar - Regra x Disciplina';


--
-- TOC entry 12044 (class 0 OID 0)
-- Dependencies: 415
-- Name: COLUMN cso_regra_disciplina.pode; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_regra_disciplina.pode IS '0- Não
1- Sim';


--
-- TOC entry 416 (class 1259 OID 14563365)
-- Name: cso_tipo_atendimento_aee_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cso_tipo_atendimento_aee_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.cso_tipo_atendimento_aee_id_seq OWNER TO postgres;

--
-- TOC entry 417 (class 1259 OID 14563367)
-- Name: cso_tipo_atendimento_aee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cso_tipo_atendimento_aee (
 id bigint DEFAULT nextval('public.cso_tipo_atendimento_aee_id_seq'::regclass) NOT NULL,
 codigo character varying(2),
 nome character varying(100)
);


ALTER TABLE public.cso_tipo_atendimento_aee OWNER TO postgres;

--
-- TOC entry 12045 (class 0 OID 0)
-- Dependencies: 417
-- Name: TABLE cso_tipo_atendimento_aee; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.cso_tipo_atendimento_aee IS 'Censo Escolar - Tipo de Atendimento Educacional Especializado-AEE';


--
-- TOC entry 418 (class 1259 OID 14563371)
-- Name: cso_tipo_atividade_complementar_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cso_tipo_atividade_complementar_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.cso_tipo_atividade_complementar_id_seq OWNER TO postgres;

--
-- TOC entry 419 (class 1259 OID 14563373)
-- Name: cso_tipo_atividade_complementar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cso_tipo_atividade_complementar (
 id bigint DEFAULT nextval('public.cso_tipo_atividade_complementar_id_seq'::regclass) NOT NULL,
 id_cso_tipo_atividade_complementar_subarea bigint,
 codigo character varying(5),
 nome character(200)
);


ALTER TABLE public.cso_tipo_atividade_complementar OWNER TO postgres;

--
-- TOC entry 12046 (class 0 OID 0)
-- Dependencies: 419
-- Name: TABLE cso_tipo_atividade_complementar; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.cso_tipo_atividade_complementar IS 'Censo Escolar - Tipo de Atividade Complementar';


--
-- TOC entry 420 (class 1259 OID 14563377)
-- Name: cso_tipo_atividade_complementar_area_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cso_tipo_atividade_complementar_area_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.cso_tipo_atividade_complementar_area_id_seq OWNER TO postgres;

--
-- TOC entry 421 (class 1259 OID 14563379)
-- Name: cso_tipo_atividade_complementar_area; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cso_tipo_atividade_complementar_area (
 id bigint DEFAULT nextval('public.cso_tipo_atividade_complementar_area_id_seq'::regclass) NOT NULL,
 codigo character varying(2),
 nome character varying(150)
);


ALTER TABLE public.cso_tipo_atividade_complementar_area OWNER TO postgres;

--
-- TOC entry 12047 (class 0 OID 0)
-- Dependencies: 421
-- Name: TABLE cso_tipo_atividade_complementar_area; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.cso_tipo_atividade_complementar_area IS 'Censo Escolar - Tipo de Atividade Complementar - Área';


--
-- TOC entry 422 (class 1259 OID 14563383)
-- Name: cso_tipo_atividade_complementar_subarea_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cso_tipo_atividade_complementar_subarea_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.cso_tipo_atividade_complementar_subarea_id_seq OWNER TO postgres;

--
-- TOC entry 423 (class 1259 OID 14563385)
-- Name: cso_tipo_atividade_complementar_subarea; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cso_tipo_atividade_complementar_subarea (
 id bigint DEFAULT nextval('public.cso_tipo_atividade_complementar_subarea_id_seq'::regclass) NOT NULL,
 id_cso_tipo_atividade_complementar_area bigint,
 codigo character varying(3),
 nome character varying(150)
);


ALTER TABLE public.cso_tipo_atividade_complementar_subarea OWNER TO postgres;

--
-- TOC entry 12048 (class 0 OID 0)
-- Dependencies: 423
-- Name: TABLE cso_tipo_atividade_complementar_subarea; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.cso_tipo_atividade_complementar_subarea IS 'Censo Escolar - Tipo de Atividade Complementar - Subarea';


--
-- TOC entry 424 (class 1259 OID 14563389)
-- Name: cso_turma; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cso_turma (
 id_bas_empresa bigint NOT NULL,
 id_sge_turma bigint NOT NULL,
 codigo_inep character varying(10),
 dias_semana character varying(13),
 tipo_atendimento character(1),
 mais_educa character(1),
 id_cso_tipo_atividade_complementar1 bigint,
 id_cso_tipo_atividade_complementar2 bigint,
 id_cso_tipo_atividade_complementar3 bigint,
 id_cso_tipo_atividade_complementar4 bigint,
 id_cso_tipo_atividade_complementar5 bigint,
 id_cso_tipo_atividade_complementar6 bigint,
 atividade_aee_braille character(1),
 atividade_aee_recursos_opticos character(1),
 atividade_aee_processos_mentais character(1),
 atividade_aee_orientacao_mobilidade character(1),
 atividade_aee_libras character(1),
 atividade_aee_caa character(1),
 atividade_aee_enriquecimento_curricular character(1),
 atividade_aee_soroban character(1),
 atividade_aee_informatica_acessivel character(1),
 atividade_aee_lingua_portuguesa_escrita character(1),
 atividade_aee_autonomia_escolar character(1),
 modalidade character(1),
 id_cso_etapa_modalidade bigint,
 id_cso_curso_profissional bigint,
 disciplina_quimica character(1),
 disciplina_fisica character(1),
 disciplina_matematica character(1),
 disciplina_biologia character(1),
 disciplina_ciencias character(1),
 disciplina_portugues character(1),
 disciplina_ingles character(1),
 disciplina_espanhol character(1),
 disciplina_frances character(1),
 disciplina_outra character(1),
 disciplina_artes character(1),
 disciplina_educacao_fisica character(1),
 disciplina_historia character(1),
 disciplina_geografia character(1),
 disciplina_filosofia character(1),
 disciplina_estudos_sociais character(1),
 disciplina_sociologia character(1),
 disciplina_informatica character(1),
 disciplina_profissionalizantes character(1),
 disciplina_educacao_especial_inclusiva character(1),
 disciplina_diversidade_cultural character(1),
 disciplina_libras character(1),
 disciplina_pedagogicas character(1),
 disciplina_ensino_religioso character(1),
 disciplina_lingua_indigena character(1),
 disciplina_outras character(1),
 turma_sem_profissional character(1),
 turma_unificada character(1),
 id_cso_etapa_modalidade_concomitante bigint,
 tipo_mediacao_didatico_pedag integer,
 tipo_atendimento_escolarizacao character(1),
 tipo_atendimento_atividade_complementar character(1),
 tipo_atendimento_aee character(1),
 local_funcionamento_diferenciado character(1),
 disciplina_portugues_como_segunda_lingua character(1),
 disciplina_estagio_curricular_supervisionado character(1),
 id_cso_etapa bigint
);


ALTER TABLE public.cso_turma OWNER TO postgres;

--
-- TOC entry 12049 (class 0 OID 0)
-- Dependencies: 424
-- Name: TABLE cso_turma; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.cso_turma IS 'Censo Escolar - Turma';


--
-- TOC entry 12050 (class 0 OID 0)
-- Dependencies: 424
-- Name: COLUMN cso_turma.tipo_atendimento_escolarizacao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_turma.tipo_atendimento_escolarizacao IS 'Somente aceita os seguintes caracteres entre parêntesis: (0 1).
Legenda:
 0 – Não
 1 – Sim';


--
-- TOC entry 12051 (class 0 OID 0)
-- Dependencies: 424
-- Name: COLUMN cso_turma.tipo_atendimento_atividade_complementar; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_turma.tipo_atendimento_atividade_complementar IS 'Somente aceita os seguintes caracteres entre parêntesis: (0 1).
Legenda:
 0 – Não
 1 – Sim';


--
-- TOC entry 12052 (class 0 OID 0)
-- Dependencies: 424
-- Name: COLUMN cso_turma.tipo_atendimento_aee; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_turma.tipo_atendimento_aee IS 'Somente aceita os seguintes caracteres entre parêntesis: (0 1).
Legenda:
 0 – Não
 1 – Sim';


--
-- TOC entry 12053 (class 0 OID 0)
-- Dependencies: 424
-- Name: COLUMN cso_turma.local_funcionamento_diferenciado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_turma.local_funcionamento_diferenciado IS 'Somente aceita os seguintes caracteres entre parêntesis: (0 1 2 3).
Legenda:
 0 – A turma não está em local de funcionamento diferenciado
 1 – Sala anexa
 2 – Unidade de atendimento socioeducativo
 3 – Unidade prisional';


--
-- TOC entry 12054 (class 0 OID 0)
-- Dependencies: 424
-- Name: COLUMN cso_turma.disciplina_portugues_como_segunda_lingua; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_turma.disciplina_portugues_como_segunda_lingua IS 'Somente aceita os seguintes caracteres entre parêntesis: (0 1 2).
Legenda:
 0 – Não oferece disciplina
 1 – Sim, oferece disciplina com docente vinculado.
 2 – Sim, oferece disciplina sem docente vinculado.';


--
-- TOC entry 12055 (class 0 OID 0)
-- Dependencies: 424
-- Name: COLUMN cso_turma.disciplina_estagio_curricular_supervisionado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_turma.disciplina_estagio_curricular_supervisionado IS 'Somente aceita os seguintes caracteres entre parêntesis: (0 1 2).
Legenda:
 0 – Não oferece disciplina
 1 – Sim, oferece disciplina com docente vinculado.
 2 – Sim, oferece disciplina sem docente vinculado.';


--
-- TOC entry 12056 (class 0 OID 0)
-- Dependencies: 424
-- Name: COLUMN cso_turma.id_cso_etapa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cso_turma.id_cso_etapa IS 'Criado em 2019';


--
-- TOC entry 425 (class 1259 OID 14563392)
-- Name: cso_uf_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cso_uf_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.cso_uf_id_seq OWNER TO postgres;

--
-- TOC entry 426 (class 1259 OID 14563394)
-- Name: cso_uf; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cso_uf (
 id bigint DEFAULT nextval('public.cso_uf_id_seq'::regclass) NOT NULL,
 codigo character varying(7),
 sigla character(2) NOT NULL,
 nome character varying(25) NOT NULL
);


ALTER TABLE public.cso_uf OWNER TO postgres;

--
-- TOC entry 12057 (class 0 OID 0)
-- Dependencies: 426
-- Name: TABLE cso_uf; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.cso_uf IS 'Censo Escolar - UF';


--
-- TOC entry 427 (class 1259 OID 14563398)
-- Name: sga_durabilidade; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sga_durabilidade (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(100) NOT NULL
);


ALTER TABLE public.sga_durabilidade OWNER TO postgres;

--
-- TOC entry 428 (class 1259 OID 14563401)
-- Name: durabilidade_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.durabilidade_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.durabilidade_id_seq OWNER TO postgres;

--
-- TOC entry 12058 (class 0 OID 0)
-- Dependencies: 428
-- Name: durabilidade_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.durabilidade_id_seq OWNED BY public.sga_durabilidade.id;


--
-- TOC entry 429 (class 1259 OID 14563403)
-- Name: id_sge_conceito_descritivo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.id_sge_conceito_descritivo_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.id_sge_conceito_descritivo_id_seq OWNER TO postgres;

--
-- TOC entry 430 (class 1259 OID 14563405)
-- Name: pde_receita_id_seq; Type: SEQUENCE; Schema: public; Owner: infocraftread
--

CREATE SEQUENCE public.pde_receita_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.pde_receita_id_seq OWNER TO infocraftread;

--
-- TOC entry 431 (class 1259 OID 14563407)
-- Name: pde_banco_movimento; Type: TABLE; Schema: public; Owner: infocraftread
--

CREATE TABLE public.pde_banco_movimento (
 id bigint DEFAULT nextval('public.pde_receita_id_seq'::regclass) NOT NULL,
 id_sgf_banco integer,
 data_operacao date,
 valor numeric(20,2),
 operacao integer,
 historico character varying(200),
 data_inclusao date,
 id_pde_unidade_executora bigint,
 id_pde_controle_recebimento bigint,
 id_pde_despesa bigint,
 id_sgf_plano_conta integer,
 id_bas_empresa bigint NOT NULL,
 id_sgf_conta_bancaria bigint
);
ALTER TABLE ONLY public.pde_banco_movimento ALTER COLUMN id_sgf_banco SET STATISTICS 0;


ALTER TABLE public.pde_banco_movimento OWNER TO infocraftread;

--
-- TOC entry 432 (class 1259 OID 14563411)
-- Name: pde_categoria_servico_bem; Type: TABLE; Schema: public; Owner: infocraftread
--

CREATE TABLE public.pde_categoria_servico_bem (
 id bigint NOT NULL,
 codigo_conta_contabil_credito character varying(50),
 tipo_despesa integer,
 codigo_conta_contabil_debito character varying(50),
 nome_conta character varying(200),
 id_bas_empresa bigint NOT NULL
);


ALTER TABLE public.pde_categoria_servico_bem OWNER TO infocraftread;

--
-- TOC entry 433 (class 1259 OID 14563414)
-- Name: pde_categoria_servico_bem_id_seq; Type: SEQUENCE; Schema: public; Owner: infocraftread
--

CREATE SEQUENCE public.pde_categoria_servico_bem_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.pde_categoria_servico_bem_id_seq OWNER TO infocraftread;

--
-- TOC entry 434 (class 1259 OID 14563416)
-- Name: pde_categoria_servico_bem_id_seq1; Type: SEQUENCE; Schema: public; Owner: infocraftread
--

CREATE SEQUENCE public.pde_categoria_servico_bem_id_seq1
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.pde_categoria_servico_bem_id_seq1 OWNER TO infocraftread;

--
-- TOC entry 12059 (class 0 OID 0)
-- Dependencies: 434
-- Name: pde_categoria_servico_bem_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: infocraftread
--

ALTER SEQUENCE public.pde_categoria_servico_bem_id_seq1 OWNED BY public.pde_categoria_servico_bem.id;


--
-- TOC entry 435 (class 1259 OID 14563418)
-- Name: pde_comissao_avaliadora; Type: TABLE; Schema: public; Owner: infocraftread
--

CREATE TABLE public.pde_comissao_avaliadora (
 id bigint DEFAULT nextval('public.comissao_avaliadora_id_seq'::regclass) NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_estabelecimento bigint,
 id_pde_unidade_executora bigint,
 nome_comissao character varying(200),
 ano character varying(4),
 data_criacao_comissao date,
 inicio_vigencia date,
 fim_vigencia date,
 id_pde_controle_recebimento bigint
);
ALTER TABLE ONLY public.pde_comissao_avaliadora ALTER COLUMN id_bas_estabelecimento SET STATISTICS 0;
ALTER TABLE ONLY public.pde_comissao_avaliadora ALTER COLUMN inicio_vigencia SET STATISTICS 0;
ALTER TABLE ONLY public.pde_comissao_avaliadora ALTER COLUMN fim_vigencia SET STATISTICS 0;


ALTER TABLE public.pde_comissao_avaliadora OWNER TO infocraftread;

--
-- TOC entry 436 (class 1259 OID 14563422)
-- Name: pde_controle_recebimento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pde_controle_recebimento (
 id bigint NOT NULL,
 valor_recebido_fnde numeric(20,2),
 saldo_do_ano numeric(20,2),
 data_recebimento_valor_fnde date,
 data_inclusao date,
 usuario_inclusao character varying(20),
 historico character varying(500),
 valor_total_rendimento numeric(20,2),
 id_sgf_banco bigint,
 ano character(4),
 encerrado character(1),
 data_encerramento date,
 id_pde_unidade_executora integer,
 inicio_execucao date,
 termino_execucao date,
 programa_destino integer,
 valor_devolvido_fnde numeric(20,2),
 valor_extrato numeric(20,2),
 data_ultimo_lancamento date,
 id_sgf_plano_conta bigint,
 id_sgf_conta_bancaria bigint,
 id_bas_empresa bigint NOT NULL
);


ALTER TABLE public.pde_controle_recebimento OWNER TO postgres;

--
-- TOC entry 437 (class 1259 OID 14563428)
-- Name: pde_controle_recebimento_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pde_controle_recebimento_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.pde_controle_recebimento_id_seq OWNER TO postgres;

--
-- TOC entry 12060 (class 0 OID 0)
-- Dependencies: 437
-- Name: pde_controle_recebimento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pde_controle_recebimento_id_seq OWNED BY public.pde_controle_recebimento.id;


--
-- TOC entry 438 (class 1259 OID 14563430)
-- Name: pde_cotacao; Type: TABLE; Schema: public; Owner: infocraftread
--

CREATE TABLE public.pde_cotacao (
 id bigint NOT NULL,
 num_cotacao character varying(20),
 servico_bem character varying(500),
 observacao character varying(200),
 data_cotacao date,
 ano_cotacao character varying(4),
 id_pde_cotacao bigint,
 id_pde_controle_recebimento bigint,
 id_pde_servico_material_bem bigint,
 descricao character varying(200),
 id_bas_empresa bigint NOT NULL
);


ALTER TABLE public.pde_cotacao OWNER TO infocraftread;

--
-- TOC entry 439 (class 1259 OID 14563436)
-- Name: pde_cotacao_id_seq; Type: SEQUENCE; Schema: public; Owner: infocraftread
--

CREATE SEQUENCE public.pde_cotacao_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.pde_cotacao_id_seq OWNER TO infocraftread;

--
-- TOC entry 440 (class 1259 OID 14563438)
-- Name: pde_cotacao_id_seq1; Type: SEQUENCE; Schema: public; Owner: infocraftread
--

CREATE SEQUENCE public.pde_cotacao_id_seq1
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.pde_cotacao_id_seq1 OWNER TO infocraftread;

--
-- TOC entry 12061 (class 0 OID 0)
-- Dependencies: 440
-- Name: pde_cotacao_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: infocraftread
--

ALTER SEQUENCE public.pde_cotacao_id_seq1 OWNED BY public.pde_cotacao.id;


--
-- TOC entry 441 (class 1259 OID 14563440)
-- Name: pde_cotacao_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pde_cotacao_item (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_pde_cotacao bigint NOT NULL,
 id_pde_servico_material_bem bigint NOT NULL,
 quantidade smallint,
 valor_base numeric(9,2)
);


ALTER TABLE public.pde_cotacao_item OWNER TO postgres;

--
-- TOC entry 442 (class 1259 OID 14563443)
-- Name: pde_cotacao_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pde_cotacao_item_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.pde_cotacao_item_id_seq OWNER TO postgres;

--
-- TOC entry 12062 (class 0 OID 0)
-- Dependencies: 442
-- Name: pde_cotacao_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pde_cotacao_item_id_seq OWNED BY public.pde_cotacao_item.id;


--
-- TOC entry 443 (class 1259 OID 14563445)
-- Name: pde_despesa; Type: TABLE; Schema: public; Owner: infocraftread
--

CREATE TABLE public.pde_despesa (
 id bigint NOT NULL,
 data_despesa date,
 id_forma_pgto character(2),
 id_pde_categoria_servico_bem integer,
 valor_servico_produto numeric(20,2),
 id_bas_fornecedor bigint,
 id_pde_unidade_executora bigint,
 ano_mes character(6),
 descricao_despesa character varying(400),
 ntf_num character varying(20),
 ntf_serie character varying(20),
 icms numeric(20,2),
 iss numeric(20,2),
 valor_liquido numeric(20,2),
 data_inclusao date,
 historico character varying(200),
 anexo character varying(200),
 natureza_despesa character(1),
 id_sgf_plano_conta integer,
 programa_destino integer,
 id_pde_controle_recebimento bigint,
 data_nota date,
 tipo_documento character(2),
 numero_ob_ch character varying(20),
 id_bas_empresa bigint NOT NULL
);


ALTER TABLE public.pde_despesa OWNER TO infocraftread;

--
-- TOC entry 444 (class 1259 OID 14563451)
-- Name: pde_despesa_id_seq; Type: SEQUENCE; Schema: public; Owner: infocraftread
--

CREATE SEQUENCE public.pde_despesa_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.pde_despesa_id_seq OWNER TO infocraftread;

--
-- TOC entry 445 (class 1259 OID 14563453)
-- Name: pde_despesa_id_seq1; Type: SEQUENCE; Schema: public; Owner: infocraftread
--

CREATE SEQUENCE public.pde_despesa_id_seq1
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.pde_despesa_id_seq1 OWNER TO infocraftread;

--
-- TOC entry 12063 (class 0 OID 0)
-- Dependencies: 445
-- Name: pde_despesa_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: infocraftread
--

ALTER SEQUENCE public.pde_despesa_id_seq1 OWNED BY public.pde_despesa.id;


--
-- TOC entry 446 (class 1259 OID 14563455)
-- Name: pde_despesa_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pde_despesa_item (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_pde_despesa bigint,
 id_pde_categoria_servico_bem bigint,
 id_pde_servico_material_bem bigint,
 id_bas_fornecedor bigint
);


ALTER TABLE public.pde_despesa_item OWNER TO postgres;

--
-- TOC entry 447 (class 1259 OID 14563458)
-- Name: pde_despesa_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pde_despesa_item_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.pde_despesa_item_id_seq OWNER TO postgres;

--
-- TOC entry 12064 (class 0 OID 0)
-- Dependencies: 447
-- Name: pde_despesa_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pde_despesa_item_id_seq OWNED BY public.pde_despesa_item.id;


--
-- TOC entry 448 (class 1259 OID 14563460)
-- Name: pde_devolucao_recursos; Type: TABLE; Schema: public; Owner: infocraftread
--

CREATE TABLE public.pde_devolucao_recursos (
 id bigint NOT NULL,
 valor_devolvido numeric(20,2),
 data_devolucao date,
 justificativa character varying(500),
 ano_utilizacao_recurso character(4),
 "GRU" character varying(20),
 id_pde_unidade_executora bigint,
 ted_doc character varying(20),
 historico character varying(500),
 id_pde_controle_recebimento bigint,
 id_bas_empresa bigint NOT NULL
);


ALTER TABLE public.pde_devolucao_recursos OWNER TO infocraftread;

--
-- TOC entry 12065 (class 0 OID 0)
-- Dependencies: 448
-- Name: COLUMN pde_devolucao_recursos."GRU"; Type: COMMENT; Schema: public; Owner: infocraftread
--

COMMENT ON COLUMN public.pde_devolucao_recursos."GRU" IS 'Guia de recolhimento da uniao';


--
-- TOC entry 449 (class 1259 OID 14563466)
-- Name: pde_devolucao_recursos_id_seq; Type: SEQUENCE; Schema: public; Owner: infocraftread
--

CREATE SEQUENCE public.pde_devolucao_recursos_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.pde_devolucao_recursos_id_seq OWNER TO infocraftread;

--
-- TOC entry 450 (class 1259 OID 14563468)
-- Name: pde_devolucao_recursos_id_seq1; Type: SEQUENCE; Schema: public; Owner: infocraftread
--

CREATE SEQUENCE public.pde_devolucao_recursos_id_seq1
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.pde_devolucao_recursos_id_seq1 OWNER TO infocraftread;

--
-- TOC entry 12066 (class 0 OID 0)
-- Dependencies: 450
-- Name: pde_devolucao_recursos_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: infocraftread
--

ALTER SEQUENCE public.pde_devolucao_recursos_id_seq1 OWNED BY public.pde_devolucao_recursos.id;


--
-- TOC entry 451 (class 1259 OID 14563470)
-- Name: pde_escola_uex; Type: TABLE; Schema: public; Owner: infocraftread
--

CREATE TABLE public.pde_escola_uex (
 id_pde_unidade_executora bigint NOT NULL,
 id_bas_estabelecimento bigint NOT NULL,
 id_bas_empresa bigint
);


ALTER TABLE public.pde_escola_uex OWNER TO infocraftread;

--
-- TOC entry 452 (class 1259 OID 14563473)
-- Name: pde_item_cotacao; Type: TABLE; Schema: public; Owner: infocraftread
--

CREATE TABLE public.pde_item_cotacao (
 id bigint NOT NULL,
 id_pde_cotacao bigint,
 id_bas_fornecedor bigint,
 valor numeric(20,2),
 vencedor integer,
 observacao character varying(500),
 id_bas_empresa bigint
);


ALTER TABLE public.pde_item_cotacao OWNER TO infocraftread;

--
-- TOC entry 453 (class 1259 OID 14563479)
-- Name: pde_item_cotacao_id_seq; Type: SEQUENCE; Schema: public; Owner: infocraftread
--

CREATE SEQUENCE public.pde_item_cotacao_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.pde_item_cotacao_id_seq OWNER TO infocraftread;

--
-- TOC entry 454 (class 1259 OID 14563481)
-- Name: pde_item_cotacao_id_seq1; Type: SEQUENCE; Schema: public; Owner: infocraftread
--

CREATE SEQUENCE public.pde_item_cotacao_id_seq1
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.pde_item_cotacao_id_seq1 OWNER TO infocraftread;

--
-- TOC entry 12067 (class 0 OID 0)
-- Dependencies: 454
-- Name: pde_item_cotacao_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: infocraftread
--

ALTER SEQUENCE public.pde_item_cotacao_id_seq1 OWNED BY public.pde_item_cotacao.id;


--
-- TOC entry 455 (class 1259 OID 14563483)
-- Name: pde_membro_comissao; Type: TABLE; Schema: public; Owner: infocraftread
--

CREATE TABLE public.pde_membro_comissao (
 id bigint NOT NULL,
 data_entrada_membro date,
 id_bas_pessoa_membro bigint,
 id_pde_comissao_avaliadora bigint,
 status integer,
 observacao character varying(200),
 data_desligamento date,
 funcao character varying(200),
 id_bas_empresa bigint NOT NULL
);


ALTER TABLE public.pde_membro_comissao OWNER TO infocraftread;

--
-- TOC entry 456 (class 1259 OID 14563486)
-- Name: pde_membro_comissao_id_seq; Type: SEQUENCE; Schema: public; Owner: infocraftread
--

CREATE SEQUENCE public.pde_membro_comissao_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.pde_membro_comissao_id_seq OWNER TO infocraftread;

--
-- TOC entry 457 (class 1259 OID 14563488)
-- Name: pde_membro_comissao_id_seq1; Type: SEQUENCE; Schema: public; Owner: infocraftread
--

CREATE SEQUENCE public.pde_membro_comissao_id_seq1
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.pde_membro_comissao_id_seq1 OWNER TO infocraftread;

--
-- TOC entry 12068 (class 0 OID 0)
-- Dependencies: 457
-- Name: pde_membro_comissao_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: infocraftread
--

ALTER SEQUENCE public.pde_membro_comissao_id_seq1 OWNED BY public.pde_membro_comissao.id;


--
-- TOC entry 458 (class 1259 OID 14563490)
-- Name: pde_servico_material_bem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pde_servico_material_bem (
 id bigint NOT NULL,
 descricao character varying(200),
 tipo character varying(20),
 id_bas_empresa bigint NOT NULL
);


ALTER TABLE public.pde_servico_material_bem OWNER TO postgres;

--
-- TOC entry 459 (class 1259 OID 14563493)
-- Name: pde_servico_material_bem_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pde_servico_material_bem_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.pde_servico_material_bem_id_seq OWNER TO postgres;

--
-- TOC entry 12069 (class 0 OID 0)
-- Dependencies: 459
-- Name: pde_servico_material_bem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pde_servico_material_bem_id_seq OWNED BY public.pde_servico_material_bem.id;


--
-- TOC entry 460 (class 1259 OID 14563495)
-- Name: pde_unidade_executora; Type: TABLE; Schema: public; Owner: infocraftread
--

CREATE TABLE public.pde_unidade_executora (
 id bigint NOT NULL,
 codigo character varying(20),
 id_bas_empresa bigint NOT NULL,
 id_bas_estabelecimento bigint,
 banco character varying(200),
 conta_corrente character varying(20),
 agencia_bancaria character varying(200),
 data_inclusao date NOT NULL,
 data_edital date,
 ano_edital character(4),
 num_edital_convocacao character varying(20),
 anexo_edital character varying(200),
 id_bas_colaborador bigint,
 vigencia date,
 num_registro_civil character varying(20),
 cnpj character(14),
 ata_trabalho character varying(200),
 observacao character varying(500),
 tipo_unidade integer,
 tipo_programa integer,
 endereco character varying(200),
 bairro character varying(200),
 municipio character varying(200),
 uf character(2),
 complemento character varying(200),
 cep character varying(15),
 nome character varying(200),
 numero character varying(20),
 id_sgf_banco bigint,
 id_sgf_conta_bancaria bigint
);


ALTER TABLE public.pde_unidade_executora OWNER TO infocraftread;

--
-- TOC entry 12070 (class 0 OID 0)
-- Dependencies: 460
-- Name: COLUMN pde_unidade_executora.id_bas_colaborador; Type: COMMENT; Schema: public; Owner: infocraftread
--

COMMENT ON COLUMN public.pde_unidade_executora.id_bas_colaborador IS 'diretoria';


--
-- TOC entry 461 (class 1259 OID 14563501)
-- Name: pde_unidade_executora_id_seq; Type: SEQUENCE; Schema: public; Owner: infocraftread
--

CREATE SEQUENCE public.pde_unidade_executora_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.pde_unidade_executora_id_seq OWNER TO infocraftread;

--
-- TOC entry 462 (class 1259 OID 14563503)
-- Name: pde_unidade_executora_id_seq1; Type: SEQUENCE; Schema: public; Owner: infocraftread
--

CREATE SEQUENCE public.pde_unidade_executora_id_seq1
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.pde_unidade_executora_id_seq1 OWNER TO infocraftread;

--
-- TOC entry 12071 (class 0 OID 0)
-- Dependencies: 462
-- Name: pde_unidade_executora_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: infocraftread
--

ALTER SEQUENCE public.pde_unidade_executora_id_seq1 OWNED BY public.pde_unidade_executora.id;


--
-- TOC entry 463 (class 1259 OID 14563505)
-- Name: sge_professor_anotacao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_professor_anotacao (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_professor bigint NOT NULL,
 id_sge_turma_aluno bigint NOT NULL,
 id_sge_aula bigint NOT NULL,
 data date NOT NULL,
 detalhe text NOT NULL,
 data_inclusao date NOT NULL
);


ALTER TABLE public.sge_professor_anotacao OWNER TO postgres;

--
-- TOC entry 464 (class 1259 OID 14563511)
-- Name: professor_anotacao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.professor_anotacao_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.professor_anotacao_id_seq OWNER TO postgres;

--
-- TOC entry 12072 (class 0 OID 0)
-- Dependencies: 464
-- Name: professor_anotacao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.professor_anotacao_id_seq OWNED BY public.sge_professor_anotacao.id;


--
-- TOC entry 1310 (class 1259 OID 22321891)
-- Name: sc_log_sgp; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sc_log_sgp (
 id integer NOT NULL,
 inserted_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
 username character varying(90) NOT NULL,
 application character varying(200) NOT NULL,
 creator character varying(30) NOT NULL,
 ip_user character varying(32) NOT NULL,
 action character varying(30) NOT NULL,
 description text
);


ALTER TABLE public.sc_log_sgp OWNER TO postgres;

--
-- TOC entry 1309 (class 1259 OID 22321889)
-- Name: sc_log_sgp_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sc_log_sgp_id_seq
 AS integer
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sc_log_sgp_id_seq OWNER TO postgres;

--
-- TOC entry 12073 (class 0 OID 0)
-- Dependencies: 1309
-- Name: sc_log_sgp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sc_log_sgp_id_seq OWNED BY public.sc_log_sgp.id;


--
-- TOC entry 465 (class 1259 OID 14563513)
-- Name: seg_acoes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seg_acoes_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.seg_acoes_id_seq OWNER TO postgres;

--
-- TOC entry 466 (class 1259 OID 14563515)
-- Name: seg_acoes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.seg_acoes (
 id bigint DEFAULT nextval('public.seg_acoes_id_seq'::regclass) NOT NULL,
 nome character varying(30) NOT NULL,
 descricao character varying(100),
 ind_ativo boolean NOT NULL
);


ALTER TABLE public.seg_acoes OWNER TO postgres;

--
-- TOC entry 467 (class 1259 OID 14563519)
-- Name: seg_apps; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.seg_apps (
 app_name character varying(128) NOT NULL,
 app_type character varying(255),
 description character varying(255)
);


ALTER TABLE public.seg_apps OWNER TO postgres;

--
-- TOC entry 468 (class 1259 OID 14563525)
-- Name: seg_apps_acoes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seg_apps_acoes_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.seg_apps_acoes_id_seq OWNER TO postgres;

--
-- TOC entry 469 (class 1259 OID 14563527)
-- Name: seg_apps_acoes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.seg_apps_acoes (
 id bigint DEFAULT nextval('public.seg_apps_acoes_id_seq'::regclass) NOT NULL,
 app_name character varying(200) NOT NULL,
 id_acoes integer NOT NULL
);


ALTER TABLE public.seg_apps_acoes OWNER TO postgres;

--
-- TOC entry 470 (class 1259 OID 14563531)
-- Name: seg_funcionalidades_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seg_funcionalidades_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.seg_funcionalidades_id_seq OWNER TO postgres;

--
-- TOC entry 471 (class 1259 OID 14563533)
-- Name: seg_funcionalidades; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.seg_funcionalidades (
 id bigint DEFAULT nextval('public.seg_funcionalidades_id_seq'::regclass) NOT NULL,
 nome character varying(200) NOT NULL,
 descricao character varying(200),
 ind_ativo boolean NOT NULL
);


ALTER TABLE public.seg_funcionalidades OWNER TO postgres;

--
-- TOC entry 472 (class 1259 OID 14563537)
-- Name: seg_funcionalidades_apps_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seg_funcionalidades_apps_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.seg_funcionalidades_apps_id_seq OWNER TO postgres;

--
-- TOC entry 473 (class 1259 OID 14563539)
-- Name: seg_funcionalidades_apps; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.seg_funcionalidades_apps (
 id bigint DEFAULT nextval('public.seg_funcionalidades_apps_id_seq'::regclass) NOT NULL,
 id_seg_funcionalidades integer NOT NULL,
 app_name character varying(200) NOT NULL
);


ALTER TABLE public.seg_funcionalidades_apps OWNER TO postgres;

--
-- TOC entry 474 (class 1259 OID 14563543)
-- Name: seg_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.seg_groups (
 group_id integer NOT NULL,
 description character varying(64),
 tipo character(1) DEFAULT 'N'::bpchar NOT NULL,
 ativo character(1),
 dashboard_inicial character varying(100)
);


ALTER TABLE public.seg_groups OWNER TO postgres;

--
-- TOC entry 12074 (class 0 OID 0)
-- Dependencies: 474
-- Name: COLUMN seg_groups.tipo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.seg_groups.tipo IS '"N" = Não configurado, "G" = Geral (Gestor), "S" = Supervisor, "C" = Coordenador, "D" = Diretor/ Secretaria, "P" = Professor, "A" = Aluno/ Responsavel';


--
-- TOC entry 475 (class 1259 OID 14563547)
-- Name: seg_groups_apps; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.seg_groups_apps (
 group_id integer NOT NULL,
 app_name character varying(128) NOT NULL,
 priv_access character varying(1),
 priv_insert character varying(1),
 priv_delete character varying(1),
 priv_update character varying(1),
 priv_export character varying(1),
 priv_print character varying(1),
 funcionalidade character varying(300)
);


ALTER TABLE public.seg_groups_apps OWNER TO postgres;

--
-- TOC entry 12075 (class 0 OID 0)
-- Dependencies: 475
-- Name: COLUMN seg_groups_apps.funcionalidade; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.seg_groups_apps.funcionalidade IS 'Caminho no menu';


--
-- TOC entry 476 (class 1259 OID 14563550)
-- Name: seg_groups_apps_acoes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seg_groups_apps_acoes_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.seg_groups_apps_acoes_id_seq OWNER TO postgres;

--
-- TOC entry 477 (class 1259 OID 14563552)
-- Name: seg_groups_apps_acoes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.seg_groups_apps_acoes (
 id bigint DEFAULT nextval('public.seg_groups_apps_acoes_id_seq'::regclass) NOT NULL,
 id_seg_groups integer NOT NULL,
 app_name character varying(200) NOT NULL,
 id_seg_acoes integer NOT NULL,
 data_criacao timestamp(0) without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.seg_groups_apps_acoes OWNER TO postgres;

--
-- TOC entry 478 (class 1259 OID 14563557)
-- Name: seg_groups_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seg_groups_group_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.seg_groups_group_id_seq OWNER TO postgres;

--
-- TOC entry 12076 (class 0 OID 0)
-- Dependencies: 478
-- Name: seg_groups_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.seg_groups_group_id_seq OWNED BY public.seg_groups.group_id;


--
-- TOC entry 479 (class 1259 OID 14563559)
-- Name: seg_log_estrutura; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.seg_log_estrutura (
 id bigint NOT NULL,
 tabela character varying(100) NOT NULL,
 campo character varying(50) NOT NULL,
 ind_visivel boolean DEFAULT true NOT NULL,
 label character varying(50) NOT NULL,
 valor text
);


ALTER TABLE public.seg_log_estrutura OWNER TO postgres;

--
-- TOC entry 480 (class 1259 OID 14563566)
-- Name: seg_log_estrutura_app; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.seg_log_estrutura_app (
 id bigint NOT NULL,
 app character varying(100) NOT NULL,
 tabela character varying(100)
);


ALTER TABLE public.seg_log_estrutura_app OWNER TO postgres;

--
-- TOC entry 481 (class 1259 OID 14563569)
-- Name: seg_log_estrutura_app_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seg_log_estrutura_app_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.seg_log_estrutura_app_id_seq OWNER TO postgres;

--
-- TOC entry 12077 (class 0 OID 0)
-- Dependencies: 481
-- Name: seg_log_estrutura_app_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.seg_log_estrutura_app_id_seq OWNED BY public.seg_log_estrutura_app.id;


--
-- TOC entry 482 (class 1259 OID 14563571)
-- Name: seg_log_estrutura_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seg_log_estrutura_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.seg_log_estrutura_id_seq OWNER TO postgres;

--
-- TOC entry 12078 (class 0 OID 0)
-- Dependencies: 482
-- Name: seg_log_estrutura_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.seg_log_estrutura_id_seq OWNED BY public.seg_log_estrutura.id;


--
-- TOC entry 483 (class 1259 OID 14563573)
-- Name: seg_log_sga; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.seg_log_sga (
 id integer NOT NULL,
 inserted_date timestamp without time zone DEFAULT now(),
 username character varying(90) NOT NULL,
 application character varying(200) NOT NULL,
 creator character varying(30) NOT NULL,
 ip_user character varying(32) NOT NULL,
 action character varying(30) NOT NULL,
 description text
);


ALTER TABLE public.seg_log_sga OWNER TO postgres;

--
-- TOC entry 484 (class 1259 OID 14563580)
-- Name: seg_log_sga_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seg_log_sga_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.seg_log_sga_id_seq OWNER TO postgres;

--
-- TOC entry 12079 (class 0 OID 0)
-- Dependencies: 484
-- Name: seg_log_sga_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.seg_log_sga_id_seq OWNED BY public.seg_log_sga.id;


--
-- TOC entry 485 (class 1259 OID 14563582)
-- Name: seg_log_sgb; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.seg_log_sgb (
 id integer NOT NULL,
 inserted_date timestamp without time zone DEFAULT now(),
 username character varying(90) NOT NULL,
 application character varying(200) NOT NULL,
 creator character varying(30) NOT NULL,
 ip_user character varying(32) NOT NULL,
 action character varying(30) NOT NULL,
 description text
);


ALTER TABLE public.seg_log_sgb OWNER TO postgres;

--
-- TOC entry 486 (class 1259 OID 14563589)
-- Name: seg_log_sgb_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seg_log_sgb_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.seg_log_sgb_id_seq OWNER TO postgres;

--
-- TOC entry 12080 (class 0 OID 0)
-- Dependencies: 486
-- Name: seg_log_sgb_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.seg_log_sgb_id_seq OWNED BY public.seg_log_sgb.id;


--
-- TOC entry 487 (class 1259 OID 14563591)
-- Name: seg_log_sge; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.seg_log_sge (
 id integer NOT NULL,
 inserted_date timestamp without time zone DEFAULT now(),
 username character varying(90) NOT NULL,
 application character varying(200) NOT NULL,
 creator character varying(30) NOT NULL,
 ip_user character varying(32) NOT NULL,
 action character varying(30) NOT NULL,
 description text
);


ALTER TABLE public.seg_log_sge OWNER TO postgres;

--
-- TOC entry 488 (class 1259 OID 14563598)
-- Name: seg_log_sge_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seg_log_sge_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.seg_log_sge_id_seq OWNER TO postgres;

--
-- TOC entry 12081 (class 0 OID 0)
-- Dependencies: 488
-- Name: seg_log_sge_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.seg_log_sge_id_seq OWNED BY public.seg_log_sge.id;


--
-- TOC entry 489 (class 1259 OID 14563600)
-- Name: seg_log_sgf; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.seg_log_sgf (
 id integer NOT NULL,
 inserted_date timestamp without time zone DEFAULT now(),
 username character varying(90) NOT NULL,
 application character varying(200) NOT NULL,
 creator character varying(30) NOT NULL,
 ip_user character varying(32) NOT NULL,
 action character varying(30) NOT NULL,
 description text
);


ALTER TABLE public.seg_log_sgf OWNER TO postgres;

--
-- TOC entry 490 (class 1259 OID 14563607)
-- Name: seg_log_sgf_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seg_log_sgf_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.seg_log_sgf_id_seq OWNER TO postgres;

--
-- TOC entry 12082 (class 0 OID 0)
-- Dependencies: 490
-- Name: seg_log_sgf_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.seg_log_sgf_id_seq OWNED BY public.seg_log_sgf.id;


--
-- TOC entry 491 (class 1259 OID 14563609)
-- Name: seg_log_sgm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.seg_log_sgm (
 id integer NOT NULL,
 inserted_date timestamp without time zone DEFAULT now(),
 username character varying(90) NOT NULL,
 application character varying(200) NOT NULL,
 creator character varying(30) NOT NULL,
 ip_user character varying(32) NOT NULL,
 action character varying(30) NOT NULL,
 description text
);


ALTER TABLE public.seg_log_sgm OWNER TO postgres;

--
-- TOC entry 492 (class 1259 OID 14563616)
-- Name: seg_log_sgm_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seg_log_sgm_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.seg_log_sgm_id_seq OWNER TO postgres;

--
-- TOC entry 12083 (class 0 OID 0)
-- Dependencies: 492
-- Name: seg_log_sgm_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.seg_log_sgm_id_seq OWNED BY public.seg_log_sgm.id;


--
-- TOC entry 1316 (class 1259 OID 25363981)
-- Name: seg_log_sgp; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.seg_log_sgp (
 id integer NOT NULL,
 inserted_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
 username character varying(90) NOT NULL,
 application character varying(200) NOT NULL,
 creator character varying(30) NOT NULL,
 ip_user character varying(32) NOT NULL,
 action character varying(30) NOT NULL,
 description text
);


ALTER TABLE public.seg_log_sgp OWNER TO postgres;

--
-- TOC entry 1315 (class 1259 OID 25363979)
-- Name: seg_log_sgp_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seg_log_sgp_id_seq
 AS integer
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.seg_log_sgp_id_seq OWNER TO postgres;

--
-- TOC entry 12084 (class 0 OID 0)
-- Dependencies: 1315
-- Name: seg_log_sgp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.seg_log_sgp_id_seq OWNED BY public.seg_log_sgp.id;


--
-- TOC entry 493 (class 1259 OID 14563618)
-- Name: seg_menu_conf; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.seg_menu_conf (
 id bigint NOT NULL,
 nome character varying(100) NOT NULL
);


ALTER TABLE public.seg_menu_conf OWNER TO postgres;

--
-- TOC entry 494 (class 1259 OID 14563621)
-- Name: seg_menu_conf_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seg_menu_conf_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.seg_menu_conf_id_seq OWNER TO postgres;

--
-- TOC entry 12085 (class 0 OID 0)
-- Dependencies: 494
-- Name: seg_menu_conf_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.seg_menu_conf_id_seq OWNED BY public.seg_menu_conf.id;


--
-- TOC entry 495 (class 1259 OID 14563623)
-- Name: seg_menu_item_conf; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.seg_menu_item_conf (
 id bigint NOT NULL,
 id_seg_menu_conf bigint,
 id_seg_menu_item_conf_pai bigint,
 app_name character varying(128),
 label character varying(128),
 hint character varying(100),
 id_menu character varying(100),
 ordem integer NOT NULL,
 curso_especifico character(1),
 target character varying(20),
 aplicacao_nova character(1) DEFAULT 'N'::bpchar
);


ALTER TABLE public.seg_menu_item_conf OWNER TO postgres;

--
-- TOC entry 12086 (class 0 OID 0)
-- Dependencies: 495
-- Name: COLUMN seg_menu_item_conf.curso_especifico; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.seg_menu_item_conf.curso_especifico IS 'Especial = S

EJA = J

Infantil = I

Fundamental 1 = 1

Fundamental 2 = 2

Médio = M';


--
-- TOC entry 12087 (class 0 OID 0)
-- Dependencies: 495
-- Name: COLUMN seg_menu_item_conf.aplicacao_nova; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.seg_menu_item_conf.aplicacao_nova IS 'S = Sim, N = Não';


--
-- TOC entry 496 (class 1259 OID 14563627)
-- Name: seg_menu_item_conf_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seg_menu_item_conf_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.seg_menu_item_conf_id_seq OWNER TO postgres;

--
-- TOC entry 12088 (class 0 OID 0)
-- Dependencies: 496
-- Name: seg_menu_item_conf_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.seg_menu_item_conf_id_seq OWNED BY public.seg_menu_item_conf.id;


--
-- TOC entry 497 (class 1259 OID 14563629)
-- Name: seg_modulos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seg_modulos_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.seg_modulos_id_seq OWNER TO postgres;

--
-- TOC entry 498 (class 1259 OID 14563631)
-- Name: seg_modulos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.seg_modulos (
 id bigint DEFAULT nextval('public.seg_modulos_id_seq'::regclass) NOT NULL,
 nome character varying(20) NOT NULL,
 sigla character varying(4) NOT NULL,
 descricao character varying(200) NOT NULL,
 ind_ativo boolean NOT NULL
);


ALTER TABLE public.seg_modulos OWNER TO postgres;

--
-- TOC entry 499 (class 1259 OID 14563635)
-- Name: seg_modulos_funcionalidades_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seg_modulos_funcionalidades_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.seg_modulos_funcionalidades_id_seq OWNER TO postgres;

--
-- TOC entry 500 (class 1259 OID 14563637)
-- Name: seg_modulos_funcionalidades; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.seg_modulos_funcionalidades (
 id bigint DEFAULT nextval('public.seg_modulos_funcionalidades_id_seq'::regclass) NOT NULL,
 id_seg_modulos integer NOT NULL,
 id_seg_funcionalidades integer NOT NULL
);


ALTER TABLE public.seg_modulos_funcionalidades OWNER TO postgres;

--
-- TOC entry 501 (class 1259 OID 14563641)
-- Name: seg_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.seg_users (
 login character varying(32) NOT NULL,
 pswd character varying(32) NOT NULL,
 name character varying(64) NOT NULL,
 email character varying(64),
 active character varying(1) NOT NULL,
 activation_code character varying(32),
 priv_admin character varying(1),
 id_bas_company bigint,
 id_bas_establishment bigint,
 id_bas_estabelecimento_origem_biblioteca bigint,
 device character varying(400)
);


ALTER TABLE public.seg_users OWNER TO postgres;

--
-- TOC entry 12089 (class 0 OID 0)
-- Dependencies: 501
-- Name: COLUMN seg_users.active; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.seg_users.active IS 'Y = yes / N = No';


--
-- TOC entry 502 (class 1259 OID 14563647)
-- Name: seg_users_almoxarifado; Type: TABLE; Schema: public; Owner: pgadmin
--

CREATE TABLE public.seg_users_almoxarifado (
 id bigint NOT NULL,
 id_sga_almoxarifado integer NOT NULL,
 login character varying(32) NOT NULL
);


ALTER TABLE public.seg_users_almoxarifado OWNER TO pgadmin;

--
-- TOC entry 503 (class 1259 OID 14563650)
-- Name: seg_users_almoxarifado_id_seq; Type: SEQUENCE; Schema: public; Owner: pgadmin
--

CREATE SEQUENCE public.seg_users_almoxarifado_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.seg_users_almoxarifado_id_seq OWNER TO pgadmin;

--
-- TOC entry 12090 (class 0 OID 0)
-- Dependencies: 503
-- Name: seg_users_almoxarifado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgadmin
--

ALTER SEQUENCE public.seg_users_almoxarifado_id_seq OWNED BY public.seg_users_almoxarifado.id;


--
-- TOC entry 504 (class 1259 OID 14563652)
-- Name: seg_users_establishment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.seg_users_establishment (
 id_bas_empresa bigint NOT NULL,
 id_bas_estabelecimento bigint NOT NULL,
 login character varying(32) NOT NULL
);


ALTER TABLE public.seg_users_establishment OWNER TO postgres;

--
-- TOC entry 505 (class 1259 OID 14563655)
-- Name: seg_users_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.seg_users_groups (
 login character varying(32) NOT NULL,
 group_id integer NOT NULL
);


ALTER TABLE public.seg_users_groups OWNER TO postgres;

SET default_with_oids = true;

--
-- TOC entry 506 (class 1259 OID 14563658)
-- Name: sga_almoxarifado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sga_almoxarifado (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_estabelecimento bigint NOT NULL,
 tipo character(1) NOT NULL,
 nome character varying(100) NOT NULL,
 exibe_quantidade character(1) NOT NULL,
 material_requisicao character(1) NOT NULL,
 descricao text,
 qtd_dias_validade_material integer,
 utiliza_controle_local_material character(1),
 nivel character(1) DEFAULT 'L'::bpchar NOT NULL,
 id_almoxarifado_central bigint
);


ALTER TABLE public.sga_almoxarifado OWNER TO postgres;

--
-- TOC entry 12091 (class 0 OID 0)
-- Dependencies: 506
-- Name: COLUMN sga_almoxarifado.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_almoxarifado.id IS 'Identificador sequencial da tabela, chave primaria composta com o campo id_bas_empresa';


--
-- TOC entry 12092 (class 0 OID 0)
-- Dependencies: 506
-- Name: COLUMN sga_almoxarifado.id_bas_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_almoxarifado.id_bas_empresa IS 'Identificador da tabela bas_empresa, chave primaria composta com o campo id';


--
-- TOC entry 12093 (class 0 OID 0)
-- Dependencies: 506
-- Name: COLUMN sga_almoxarifado.id_bas_estabelecimento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_almoxarifado.id_bas_estabelecimento IS 'Identificador da tabela bas_estabelecimento';


--
-- TOC entry 12094 (class 0 OID 0)
-- Dependencies: 506
-- Name: COLUMN sga_almoxarifado.tipo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_almoxarifado.tipo IS 'Informa o tipo do almoxarifado ( G = “Geral”, C = “Coletivo”)';


--
-- TOC entry 12095 (class 0 OID 0)
-- Dependencies: 506
-- Name: COLUMN sga_almoxarifado.nome; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_almoxarifado.nome IS 'Nome do Almoxarifado';


--
-- TOC entry 12096 (class 0 OID 0)
-- Dependencies: 506
-- Name: COLUMN sga_almoxarifado.exibe_quantidade; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_almoxarifado.exibe_quantidade IS 'S = sim / N = não';


--
-- TOC entry 12097 (class 0 OID 0)
-- Dependencies: 506
-- Name: COLUMN sga_almoxarifado.material_requisicao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_almoxarifado.material_requisicao IS 'Informa se na tela de requisição de material disponibilizará somente materiais com saldo (S = saldo/ T = todos)';


--
-- TOC entry 12098 (class 0 OID 0)
-- Dependencies: 506
-- Name: COLUMN sga_almoxarifado.descricao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_almoxarifado.descricao IS 'Descrição do almoxarifado';


--
-- TOC entry 12099 (class 0 OID 0)
-- Dependencies: 506
-- Name: COLUMN sga_almoxarifado.utiliza_controle_local_material; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_almoxarifado.utiliza_controle_local_material IS 'S = sim / N = não';


--
-- TOC entry 12100 (class 0 OID 0)
-- Dependencies: 506
-- Name: COLUMN sga_almoxarifado.nivel; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_almoxarifado.nivel IS 'Informa o nível do almoxarifado ( C = “Central”, L = “Local”)';


SET default_with_oids = false;

--
-- TOC entry 507 (class 1259 OID 14563665)
-- Name: sga_almoxarifado_grupo_material; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sga_almoxarifado_grupo_material (
 id_sga_almoxarifado integer NOT NULL,
 id_sga_material_grupo integer NOT NULL
);


ALTER TABLE public.sga_almoxarifado_grupo_material OWNER TO postgres;

--
-- TOC entry 508 (class 1259 OID 14563668)
-- Name: sga_almoxarifado_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sga_almoxarifado_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sga_almoxarifado_id_seq OWNER TO postgres;

--
-- TOC entry 12101 (class 0 OID 0)
-- Dependencies: 508
-- Name: sga_almoxarifado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sga_almoxarifado_id_seq OWNED BY public.sga_almoxarifado.id;


--
-- TOC entry 509 (class 1259 OID 14563670)
-- Name: sga_almoxarifado_material; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sga_almoxarifado_material (
 id_bas_empresa bigint NOT NULL,
 id_sga_almoxarifado bigint NOT NULL,
 id_sga_material bigint NOT NULL,
 quantidade numeric(9,2),
 valor_medio numeric(9,2),
 quantidade_minima numeric(9,2),
 quantidade_levantada numeric(9,2),
 valor_venda numeric(9,2) DEFAULT 0,
 data_hora_inclusao timestamp without time zone
);


ALTER TABLE public.sga_almoxarifado_material OWNER TO postgres;

--
-- TOC entry 12102 (class 0 OID 0)
-- Dependencies: 509
-- Name: COLUMN sga_almoxarifado_material.id_bas_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_almoxarifado_material.id_bas_empresa IS 'Identificador da tabela bas_empresa, chave primaria composta com os campos id_sga_almoxarifado e id_sge_material';


--
-- TOC entry 12103 (class 0 OID 0)
-- Dependencies: 509
-- Name: COLUMN sga_almoxarifado_material.id_sga_almoxarifado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_almoxarifado_material.id_sga_almoxarifado IS 'Identificador da tabela sga_almoxarifado, chave primaria composta com os campos id_bas_empresa e id_sge_material';


--
-- TOC entry 12104 (class 0 OID 0)
-- Dependencies: 509
-- Name: COLUMN sga_almoxarifado_material.id_sga_material; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_almoxarifado_material.id_sga_material IS 'Identificador da tabela sge_material, chave primaria composta com os campos id_bas_empresa e id_sga_almoxarifado.';


--
-- TOC entry 12105 (class 0 OID 0)
-- Dependencies: 509
-- Name: COLUMN sga_almoxarifado_material.quantidade; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_almoxarifado_material.quantidade IS 'Quantidade do material no almoxarifado';


--
-- TOC entry 12106 (class 0 OID 0)
-- Dependencies: 509
-- Name: COLUMN sga_almoxarifado_material.valor_medio; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_almoxarifado_material.valor_medio IS 'Valor médio do material no almoxarifado';


--
-- TOC entry 12107 (class 0 OID 0)
-- Dependencies: 509
-- Name: COLUMN sga_almoxarifado_material.quantidade_minima; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_almoxarifado_material.quantidade_minima IS 'Quantidade mínima do material em estoque no almoxarifado.';


--
-- TOC entry 12108 (class 0 OID 0)
-- Dependencies: 509
-- Name: COLUMN sga_almoxarifado_material.quantidade_levantada; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_almoxarifado_material.quantidade_levantada IS 'Quantidade levantada no último inventário.';


--
-- TOC entry 12109 (class 0 OID 0)
-- Dependencies: 509
-- Name: COLUMN sga_almoxarifado_material.valor_venda; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_almoxarifado_material.valor_venda IS 'Valor para venda no almoxarifado';


--
-- TOC entry 510 (class 1259 OID 14563674)
-- Name: sga_autorizacao_fornecimento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sga_autorizacao_fornecimento (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_fornecedor bigint NOT NULL,
 id_sga_compra bigint NOT NULL,
 data date NOT NULL,
 data_entrega date,
 finalizado character(1) DEFAULT 'N'::bpchar NOT NULL,
 numero character varying(15) NOT NULL,
 id_sga_almoxarifado bigint
);


ALTER TABLE public.sga_autorizacao_fornecimento OWNER TO postgres;

--
-- TOC entry 12110 (class 0 OID 0)
-- Dependencies: 510
-- Name: TABLE sga_autorizacao_fornecimento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sga_autorizacao_fornecimento IS 'Cadastra a autorização de fornecimento gerada a partir de uma compra.';


--
-- TOC entry 12111 (class 0 OID 0)
-- Dependencies: 510
-- Name: COLUMN sga_autorizacao_fornecimento.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_autorizacao_fornecimento.id IS 'Identificador sequencial da tabela, chave primaria composta com o campo id_bas_empresa';


--
-- TOC entry 12112 (class 0 OID 0)
-- Dependencies: 510
-- Name: COLUMN sga_autorizacao_fornecimento.id_bas_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_autorizacao_fornecimento.id_bas_empresa IS 'Identificador da tabela bas_empresa, chave primaria composta com o campo id';


--
-- TOC entry 12113 (class 0 OID 0)
-- Dependencies: 510
-- Name: COLUMN sga_autorizacao_fornecimento.id_bas_fornecedor; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_autorizacao_fornecimento.id_bas_fornecedor IS 'Identificador da tabela bas_fornecedor';


--
-- TOC entry 12114 (class 0 OID 0)
-- Dependencies: 510
-- Name: COLUMN sga_autorizacao_fornecimento.id_sga_compra; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_autorizacao_fornecimento.id_sga_compra IS 'identificador da tabela sga_compra';


--
-- TOC entry 12115 (class 0 OID 0)
-- Dependencies: 510
-- Name: COLUMN sga_autorizacao_fornecimento.data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_autorizacao_fornecimento.data IS 'Data da Criação da A.F.';


--
-- TOC entry 12116 (class 0 OID 0)
-- Dependencies: 510
-- Name: COLUMN sga_autorizacao_fornecimento.data_entrega; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_autorizacao_fornecimento.data_entrega IS 'Data para a previsão de entrega';


--
-- TOC entry 12117 (class 0 OID 0)
-- Dependencies: 510
-- Name: COLUMN sga_autorizacao_fornecimento.finalizado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_autorizacao_fornecimento.finalizado IS 'Indica se a criaçao da A.F. foi finalizada (S = Sim, N = Não)';


--
-- TOC entry 12118 (class 0 OID 0)
-- Dependencies: 510
-- Name: COLUMN sga_autorizacao_fornecimento.numero; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_autorizacao_fornecimento.numero IS 'Número da AF para cada empresa';


--
-- TOC entry 12119 (class 0 OID 0)
-- Dependencies: 510
-- Name: COLUMN sga_autorizacao_fornecimento.id_sga_almoxarifado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_autorizacao_fornecimento.id_sga_almoxarifado IS 'Indicador sequencial da tabela sga_almoxarifado';


--
-- TOC entry 511 (class 1259 OID 14563678)
-- Name: sga_autorizacao_fornecimento_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sga_autorizacao_fornecimento_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sga_autorizacao_fornecimento_id_seq OWNER TO postgres;

--
-- TOC entry 12120 (class 0 OID 0)
-- Dependencies: 511
-- Name: sga_autorizacao_fornecimento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sga_autorizacao_fornecimento_id_seq OWNED BY public.sga_autorizacao_fornecimento.id;


--
-- TOC entry 512 (class 1259 OID 14563680)
-- Name: sga_autorizacao_fornecimento_material; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sga_autorizacao_fornecimento_material (
 id_bas_empresa bigint NOT NULL,
 id_sga_autorizacao_fornecimento bigint NOT NULL,
 quantidade numeric(9,2) NOT NULL,
 id_sga_compra_material bigint NOT NULL,
 quantidade_abatida numeric(9,2) DEFAULT 0
);


ALTER TABLE public.sga_autorizacao_fornecimento_material OWNER TO postgres;

--
-- TOC entry 12121 (class 0 OID 0)
-- Dependencies: 512
-- Name: TABLE sga_autorizacao_fornecimento_material; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sga_autorizacao_fornecimento_material IS 'Cadastra os itens de uma autorização de fornecimento';


--
-- TOC entry 12122 (class 0 OID 0)
-- Dependencies: 512
-- Name: COLUMN sga_autorizacao_fornecimento_material.id_bas_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_autorizacao_fornecimento_material.id_bas_empresa IS 'Identificador da tabela bas_empresa, chave primaria composta com o campo id';


--
-- TOC entry 12123 (class 0 OID 0)
-- Dependencies: 512
-- Name: COLUMN sga_autorizacao_fornecimento_material.id_sga_autorizacao_fornecimento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_autorizacao_fornecimento_material.id_sga_autorizacao_fornecimento IS 'Identificador da tabela sga_autorizacao_fornecimento';


--
-- TOC entry 12124 (class 0 OID 0)
-- Dependencies: 512
-- Name: COLUMN sga_autorizacao_fornecimento_material.quantidade; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_autorizacao_fornecimento_material.quantidade IS 'Quantidade de cada material da A.F (podendo ser um valor inteiro ou decimal, ex: 3,5 [kg]);';


--
-- TOC entry 513 (class 1259 OID 14563684)
-- Name: sga_baixa_material_estoque; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sga_baixa_material_estoque (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sga_almoxarifado bigint NOT NULL,
 id_sga_material_estoque bigint NOT NULL,
 login_responsavel character varying(32) NOT NULL,
 data date NOT NULL,
 quantidade numeric(9,2) NOT NULL,
 motivo character varying(100),
 id_sga_inventario integer,
 id_sga_transferencia integer,
 id_sga_requisicao integer,
 id_sga_devolucao integer
);


ALTER TABLE public.sga_baixa_material_estoque OWNER TO postgres;

--
-- TOC entry 12125 (class 0 OID 0)
-- Dependencies: 513
-- Name: TABLE sga_baixa_material_estoque; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sga_baixa_material_estoque IS 'Cadastra as baixas de materiais no estoque';


--
-- TOC entry 12126 (class 0 OID 0)
-- Dependencies: 513
-- Name: COLUMN sga_baixa_material_estoque.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_baixa_material_estoque.id IS 'Identificador sequencial da tabela, chave primaria composta com o campo id_bas_empresa';


--
-- TOC entry 12127 (class 0 OID 0)
-- Dependencies: 513
-- Name: COLUMN sga_baixa_material_estoque.id_bas_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_baixa_material_estoque.id_bas_empresa IS 'Identificador da tabela bas_empresa, chave primaria composta com o campo id';


--
-- TOC entry 12128 (class 0 OID 0)
-- Dependencies: 513
-- Name: COLUMN sga_baixa_material_estoque.id_sga_almoxarifado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_baixa_material_estoque.id_sga_almoxarifado IS 'Identificador da tabela sga_almoxarifado_material junto com os campos id_bas_empresa e id_sga_material';


--
-- TOC entry 12129 (class 0 OID 0)
-- Dependencies: 513
-- Name: COLUMN sga_baixa_material_estoque.id_sga_material_estoque; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_baixa_material_estoque.id_sga_material_estoque IS 'Identificador da tabela sga_material_estoque';


--
-- TOC entry 12130 (class 0 OID 0)
-- Dependencies: 513
-- Name: COLUMN sga_baixa_material_estoque.login_responsavel; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_baixa_material_estoque.login_responsavel IS 'Usuário que registrou a baixa';


--
-- TOC entry 12131 (class 0 OID 0)
-- Dependencies: 513
-- Name: COLUMN sga_baixa_material_estoque.data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_baixa_material_estoque.data IS 'Data da baixa';


--
-- TOC entry 12132 (class 0 OID 0)
-- Dependencies: 513
-- Name: COLUMN sga_baixa_material_estoque.quantidade; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_baixa_material_estoque.quantidade IS 'Quantidade baixada do material';


--
-- TOC entry 12133 (class 0 OID 0)
-- Dependencies: 513
-- Name: COLUMN sga_baixa_material_estoque.motivo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_baixa_material_estoque.motivo IS 'Motivo da baixa.';


--
-- TOC entry 12134 (class 0 OID 0)
-- Dependencies: 513
-- Name: COLUMN sga_baixa_material_estoque.id_sga_inventario; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_baixa_material_estoque.id_sga_inventario IS 'Identificador da tabela sga_inventario. Utilizado quando a baixa é realizada através de um inventário de ajuste.';


--
-- TOC entry 12135 (class 0 OID 0)
-- Dependencies: 513
-- Name: COLUMN sga_baixa_material_estoque.id_sga_transferencia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_baixa_material_estoque.id_sga_transferencia IS 'Chave da tabela sga_transferencia';


--
-- TOC entry 12136 (class 0 OID 0)
-- Dependencies: 513
-- Name: COLUMN sga_baixa_material_estoque.id_sga_requisicao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_baixa_material_estoque.id_sga_requisicao IS 'Chave da tabela sga_requisicao';


--
-- TOC entry 514 (class 1259 OID 14563687)
-- Name: sga_baixa_material_estoque_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sga_baixa_material_estoque_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sga_baixa_material_estoque_id_seq OWNER TO postgres;

--
-- TOC entry 12137 (class 0 OID 0)
-- Dependencies: 514
-- Name: sga_baixa_material_estoque_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sga_baixa_material_estoque_id_seq OWNED BY public.sga_baixa_material_estoque.id;


--
-- TOC entry 515 (class 1259 OID 14563689)
-- Name: sga_centro_custo_colaborador; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sga_centro_custo_colaborador (
 id_bas_empresa bigint NOT NULL,
 id_bas_centro_custo bigint NOT NULL,
 id_bas_colaborador bigint NOT NULL,
 responsavel_centro_custo character(1)
);


ALTER TABLE public.sga_centro_custo_colaborador OWNER TO postgres;

--
-- TOC entry 12138 (class 0 OID 0)
-- Dependencies: 515
-- Name: TABLE sga_centro_custo_colaborador; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sga_centro_custo_colaborador IS 'Informa os colaboradores que podem fazer requisições de materiais por departamento.';


SET default_with_oids = true;

--
-- TOC entry 516 (class 1259 OID 14563692)
-- Name: sga_centro_custo_material; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sga_centro_custo_material (
 id_bas_empresa bigint NOT NULL,
 id_bas_centro_custo bigint NOT NULL,
 id_sga_material bigint NOT NULL
);


ALTER TABLE public.sga_centro_custo_material OWNER TO postgres;

SET default_with_oids = false;

--
-- TOC entry 517 (class 1259 OID 14563695)
-- Name: sga_compra; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sga_compra (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_fornecedor bigint,
 valor numeric(9,2) NOT NULL,
 data date NOT NULL,
 finalizado character(1) DEFAULT 'N'::bpchar NOT NULL,
 numero_compra character varying(5),
 id_sga_contrato_licitacao bigint,
 id_sga_almoxarifado bigint
);


ALTER TABLE public.sga_compra OWNER TO postgres;

--
-- TOC entry 12139 (class 0 OID 0)
-- Dependencies: 517
-- Name: TABLE sga_compra; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sga_compra IS 'Cadastra o cabeçalho de uma compra.';


--
-- TOC entry 12140 (class 0 OID 0)
-- Dependencies: 517
-- Name: COLUMN sga_compra.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_compra.id IS 'Identificador sequencial da tabela, chave primaria composta com o campo id_bas_empresa';


--
-- TOC entry 12141 (class 0 OID 0)
-- Dependencies: 517
-- Name: COLUMN sga_compra.id_bas_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_compra.id_bas_empresa IS 'Identificador da tabela bas_empresa, chave primaria composta com o campo id';


--
-- TOC entry 12142 (class 0 OID 0)
-- Dependencies: 517
-- Name: COLUMN sga_compra.id_bas_fornecedor; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_compra.id_bas_fornecedor IS 'Identificador da tabela bas_fornecedor';


--
-- TOC entry 12143 (class 0 OID 0)
-- Dependencies: 517
-- Name: COLUMN sga_compra.valor; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_compra.valor IS 'Valor total da compra';


--
-- TOC entry 12144 (class 0 OID 0)
-- Dependencies: 517
-- Name: COLUMN sga_compra.data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_compra.data IS 'Data da Compra';


--
-- TOC entry 12145 (class 0 OID 0)
-- Dependencies: 517
-- Name: COLUMN sga_compra.finalizado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_compra.finalizado IS 'Se o cadastro da compra foi finalizado(S = Sim e N = Não)';


--
-- TOC entry 518 (class 1259 OID 14563699)
-- Name: sga_compra_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sga_compra_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sga_compra_id_seq OWNER TO postgres;

--
-- TOC entry 12146 (class 0 OID 0)
-- Dependencies: 518
-- Name: sga_compra_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sga_compra_id_seq OWNED BY public.sga_compra.id;


--
-- TOC entry 519 (class 1259 OID 14563701)
-- Name: sga_compra_material; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sga_compra_material (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sga_compra bigint NOT NULL,
 id_sga_material bigint NOT NULL,
 valor_unitario numeric(9,2) NOT NULL,
 quantidade numeric(9,2) NOT NULL,
 desconto numeric(9,2) NOT NULL,
 valor_total numeric(9,2) NOT NULL
);


ALTER TABLE public.sga_compra_material OWNER TO postgres;

--
-- TOC entry 12147 (class 0 OID 0)
-- Dependencies: 519
-- Name: TABLE sga_compra_material; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sga_compra_material IS 'Cadastra os itens de uma compra';


--
-- TOC entry 12148 (class 0 OID 0)
-- Dependencies: 519
-- Name: COLUMN sga_compra_material.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_compra_material.id IS 'Identificador sequencial da tabela, chave primaria composta com o campo id_bas_empresa';


--
-- TOC entry 12149 (class 0 OID 0)
-- Dependencies: 519
-- Name: COLUMN sga_compra_material.id_bas_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_compra_material.id_bas_empresa IS 'Identificador da tabela bas_empresa, chave primaria composta com o campo id';


--
-- TOC entry 12150 (class 0 OID 0)
-- Dependencies: 519
-- Name: COLUMN sga_compra_material.id_sga_compra; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_compra_material.id_sga_compra IS 'Identificador da tabela sga_compra';


--
-- TOC entry 12151 (class 0 OID 0)
-- Dependencies: 519
-- Name: COLUMN sga_compra_material.id_sga_material; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_compra_material.id_sga_material IS 'Identificador da tabela sga_material';


--
-- TOC entry 12152 (class 0 OID 0)
-- Dependencies: 519
-- Name: COLUMN sga_compra_material.valor_unitario; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_compra_material.valor_unitario IS 'Valor unitário de cada produto da compra';


--
-- TOC entry 12153 (class 0 OID 0)
-- Dependencies: 519
-- Name: COLUMN sga_compra_material.quantidade; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_compra_material.quantidade IS 'Quantidade de cada material da compra (podendo ser um valor inteiro ou decimal, ex: 3,5 [kg]);';


--
-- TOC entry 12154 (class 0 OID 0)
-- Dependencies: 519
-- Name: COLUMN sga_compra_material.desconto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_compra_material.desconto IS 'Desconto aplicado ao valor do material da compra';


--
-- TOC entry 12155 (class 0 OID 0)
-- Dependencies: 519
-- Name: COLUMN sga_compra_material.valor_total; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_compra_material.valor_total IS 'Valor total do item da compra ((valor_unitario * quantidade) - desconto)';


--
-- TOC entry 520 (class 1259 OID 14563704)
-- Name: sga_compra_material_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sga_compra_material_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sga_compra_material_id_seq OWNER TO postgres;

--
-- TOC entry 12156 (class 0 OID 0)
-- Dependencies: 520
-- Name: sga_compra_material_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sga_compra_material_id_seq OWNED BY public.sga_compra_material.id;


--
-- TOC entry 521 (class 1259 OID 14563706)
-- Name: sga_contrato_licitacao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sga_contrato_licitacao (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_fornecedor bigint NOT NULL,
 numero_licitacao character varying(20) NOT NULL,
 ano integer NOT NULL,
 valor_total numeric(9,2) NOT NULL,
 data_recebimento date NOT NULL,
 numero_contrato character varying(20) NOT NULL,
 observacao character varying(1000),
 finalizado character(1),
 data_recebimento_final date,
 fecha_na_compra_parcial character(1)
);


ALTER TABLE public.sga_contrato_licitacao OWNER TO postgres;

--
-- TOC entry 12157 (class 0 OID 0)
-- Dependencies: 521
-- Name: COLUMN sga_contrato_licitacao.finalizado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_contrato_licitacao.finalizado IS 'Se o cadastro do contrato foi finalizado(S = Sim e N = Não)';


--
-- TOC entry 522 (class 1259 OID 14563712)
-- Name: sga_contrato_licitacao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sga_contrato_licitacao_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sga_contrato_licitacao_id_seq OWNER TO postgres;

--
-- TOC entry 12158 (class 0 OID 0)
-- Dependencies: 522
-- Name: sga_contrato_licitacao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sga_contrato_licitacao_id_seq OWNED BY public.sga_contrato_licitacao.id;


--
-- TOC entry 523 (class 1259 OID 14563714)
-- Name: sga_devolucao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sga_devolucao (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 data_devolucao date DEFAULT now(),
 id_sga_requisicao integer,
 id_bas_colaborador bigint,
 finalizado character(1)
);


ALTER TABLE public.sga_devolucao OWNER TO postgres;

--
-- TOC entry 12159 (class 0 OID 0)
-- Dependencies: 523
-- Name: TABLE sga_devolucao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sga_devolucao IS 'Cadastra devoluções.';


--
-- TOC entry 12160 (class 0 OID 0)
-- Dependencies: 523
-- Name: COLUMN sga_devolucao.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_devolucao.id IS 'Identificador sequencial da tabela.';


--
-- TOC entry 12161 (class 0 OID 0)
-- Dependencies: 523
-- Name: COLUMN sga_devolucao.id_bas_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_devolucao.id_bas_empresa IS 'Identificador da tabela bas_empresa.';


--
-- TOC entry 12162 (class 0 OID 0)
-- Dependencies: 523
-- Name: COLUMN sga_devolucao.data_devolucao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_devolucao.data_devolucao IS 'Data de cadastro da Devolução.';


--
-- TOC entry 12163 (class 0 OID 0)
-- Dependencies: 523
-- Name: COLUMN sga_devolucao.id_sga_requisicao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_devolucao.id_sga_requisicao IS 'Identificador da tabela sga_requisicao.';


--
-- TOC entry 12164 (class 0 OID 0)
-- Dependencies: 523
-- Name: COLUMN sga_devolucao.id_bas_colaborador; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_devolucao.id_bas_colaborador IS 'Identificador da tabela bas_colaborador.';


--
-- TOC entry 524 (class 1259 OID 14563718)
-- Name: sga_devolucao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sga_devolucao_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sga_devolucao_id_seq OWNER TO postgres;

--
-- TOC entry 12165 (class 0 OID 0)
-- Dependencies: 524
-- Name: sga_devolucao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sga_devolucao_id_seq OWNED BY public.sga_devolucao.id;


--
-- TOC entry 525 (class 1259 OID 14563720)
-- Name: sga_devolucao_material; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sga_devolucao_material (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sga_devolucao bigint NOT NULL,
 id_sga_transferencia_material bigint NOT NULL,
 data date NOT NULL,
 quantidade_devolvida numeric(9,2) NOT NULL
);


ALTER TABLE public.sga_devolucao_material OWNER TO postgres;

--
-- TOC entry 12166 (class 0 OID 0)
-- Dependencies: 525
-- Name: TABLE sga_devolucao_material; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sga_devolucao_material IS 'Cadastra as devoluções de materiais';


--
-- TOC entry 12167 (class 0 OID 0)
-- Dependencies: 525
-- Name: COLUMN sga_devolucao_material.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_devolucao_material.id IS 'Identificador sequencial da tabela';


--
-- TOC entry 12168 (class 0 OID 0)
-- Dependencies: 525
-- Name: COLUMN sga_devolucao_material.id_bas_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_devolucao_material.id_bas_empresa IS 'Identificador da tabela bas_empresa';


--
-- TOC entry 12169 (class 0 OID 0)
-- Dependencies: 525
-- Name: COLUMN sga_devolucao_material.id_sga_devolucao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_devolucao_material.id_sga_devolucao IS 'Identificador da tabela sga_devolucao';


--
-- TOC entry 12170 (class 0 OID 0)
-- Dependencies: 525
-- Name: COLUMN sga_devolucao_material.id_sga_transferencia_material; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_devolucao_material.id_sga_transferencia_material IS 'Identificador da tabela sga_transferencia_material';


--
-- TOC entry 12171 (class 0 OID 0)
-- Dependencies: 525
-- Name: COLUMN sga_devolucao_material.data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_devolucao_material.data IS 'Data da devolução';


--
-- TOC entry 12172 (class 0 OID 0)
-- Dependencies: 525
-- Name: COLUMN sga_devolucao_material.quantidade_devolvida; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_devolucao_material.quantidade_devolvida IS 'Quantidade devolvida pelo requisitante';


--
-- TOC entry 526 (class 1259 OID 14563723)
-- Name: sga_devolucao_material_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sga_devolucao_material_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sga_devolucao_material_id_seq OWNER TO postgres;

--
-- TOC entry 12173 (class 0 OID 0)
-- Dependencies: 526
-- Name: sga_devolucao_material_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sga_devolucao_material_id_seq OWNED BY public.sga_devolucao_material.id;


--
-- TOC entry 527 (class 1259 OID 14563725)
-- Name: sga_entrada; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sga_entrada (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_fornecedor bigint,
 id_sga_almoxarifado bigint NOT NULL,
 id_sga_autorizacao_fornecimento bigint,
 data date DEFAULT now() NOT NULL,
 origem character(1) NOT NULL,
 numero_documento character varying(20),
 data_emissao date,
 data_recebimento date,
 tributos_nf numeric(9,2),
 desconto_nf numeric(9,2),
 frete_nf numeric(9,2),
 seguro_nf numeric(9,2),
 finalizado character(1) DEFAULT 'N'::bpchar NOT NULL,
 id_sga_contrato_licitacao bigint,
 id_bas_estabelecimento integer,
 id_sga_inventario bigint,
 id_tipo_documento bigint,
 id_sga_transferencia bigint,
 id_sga_devolucao integer
);


ALTER TABLE public.sga_entrada OWNER TO postgres;

--
-- TOC entry 12174 (class 0 OID 0)
-- Dependencies: 527
-- Name: TABLE sga_entrada; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sga_entrada IS 'Cadastra o cabeçalho de uma entrada (nota).';


--
-- TOC entry 12175 (class 0 OID 0)
-- Dependencies: 527
-- Name: COLUMN sga_entrada.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_entrada.id IS 'Identificador sequencial da tabela, chave primaria composta com o campo id_bas_empresa';


--
-- TOC entry 12176 (class 0 OID 0)
-- Dependencies: 527
-- Name: COLUMN sga_entrada.id_bas_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_entrada.id_bas_empresa IS 'Identificador da tabela bas_empresa, chave primaria composta com o campo id';


--
-- TOC entry 12177 (class 0 OID 0)
-- Dependencies: 527
-- Name: COLUMN sga_entrada.id_bas_fornecedor; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_entrada.id_bas_fornecedor IS 'Identificador da tabela bas_fornecedor';


--
-- TOC entry 12178 (class 0 OID 0)
-- Dependencies: 527
-- Name: COLUMN sga_entrada.id_sga_almoxarifado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_entrada.id_sga_almoxarifado IS 'Almoxarifado de destino';


--
-- TOC entry 12179 (class 0 OID 0)
-- Dependencies: 527
-- Name: COLUMN sga_entrada.id_sga_autorizacao_fornecimento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_entrada.id_sga_autorizacao_fornecimento IS 'Autorização de fornecimento que gerou a entrada';


--
-- TOC entry 12180 (class 0 OID 0)
-- Dependencies: 527
-- Name: COLUMN sga_entrada.data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_entrada.data IS 'Data do registro da Entrada';


--
-- TOC entry 12181 (class 0 OID 0)
-- Dependencies: 527
-- Name: COLUMN sga_entrada.origem; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_entrada.origem IS 'Classificação da origem (A = aquisição, D = doação, T = Transferência)';


--
-- TOC entry 12182 (class 0 OID 0)
-- Dependencies: 527
-- Name: COLUMN sga_entrada.numero_documento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_entrada.numero_documento IS 'Número do documento de origem (número da Nota Fiscal ou outro
documento)';


--
-- TOC entry 12183 (class 0 OID 0)
-- Dependencies: 527
-- Name: COLUMN sga_entrada.data_emissao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_entrada.data_emissao IS 'Data da emissão do documento';


--
-- TOC entry 12184 (class 0 OID 0)
-- Dependencies: 527
-- Name: COLUMN sga_entrada.data_recebimento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_entrada.data_recebimento IS 'Data do recebimento dos materiais';


--
-- TOC entry 12185 (class 0 OID 0)
-- Dependencies: 527
-- Name: COLUMN sga_entrada.tributos_nf; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_entrada.tributos_nf IS 'Total de tributos descrito na nota';


--
-- TOC entry 12186 (class 0 OID 0)
-- Dependencies: 527
-- Name: COLUMN sga_entrada.desconto_nf; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_entrada.desconto_nf IS 'Total de descontos descrito na nota.';


--
-- TOC entry 12187 (class 0 OID 0)
-- Dependencies: 527
-- Name: COLUMN sga_entrada.frete_nf; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_entrada.frete_nf IS 'Valor do frete descrito na nota';


--
-- TOC entry 12188 (class 0 OID 0)
-- Dependencies: 527
-- Name: COLUMN sga_entrada.seguro_nf; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_entrada.seguro_nf IS 'Valor do seguro descrito na nota';


--
-- TOC entry 12189 (class 0 OID 0)
-- Dependencies: 527
-- Name: COLUMN sga_entrada.finalizado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_entrada.finalizado IS 'Informa se o cadastro da entrada foi finalizado (S = Sim e N = Não)';


--
-- TOC entry 12190 (class 0 OID 0)
-- Dependencies: 527
-- Name: COLUMN sga_entrada.id_sga_inventario; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_entrada.id_sga_inventario IS 'Utilizado quando a entrada for via inventario';


--
-- TOC entry 12191 (class 0 OID 0)
-- Dependencies: 527
-- Name: COLUMN sga_entrada.id_tipo_documento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_entrada.id_tipo_documento IS 'Tipo de documento - Não está relacionado a banco.codigo direto no FRONT';


--
-- TOC entry 12192 (class 0 OID 0)
-- Dependencies: 527
-- Name: COLUMN sga_entrada.id_sga_transferencia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_entrada.id_sga_transferencia IS 'Utilizado quando a entrada for via transferência';


--
-- TOC entry 528 (class 1259 OID 14563730)
-- Name: sga_entrada_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sga_entrada_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sga_entrada_id_seq OWNER TO postgres;

--
-- TOC entry 12193 (class 0 OID 0)
-- Dependencies: 528
-- Name: sga_entrada_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sga_entrada_id_seq OWNED BY public.sga_entrada.id;


--
-- TOC entry 529 (class 1259 OID 14563732)
-- Name: sga_entrada_material_estoque; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sga_entrada_material_estoque (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sga_almoxarifado bigint NOT NULL,
 id_sga_entrada bigint NOT NULL,
 id_sga_material bigint NOT NULL,
 lote character(10),
 fabricacao date,
 validade date,
 quantidade numeric(9,2) NOT NULL,
 id_sga_material_local_prateleira integer,
 valor_unitario numeric(9,2)
);


ALTER TABLE public.sga_entrada_material_estoque OWNER TO postgres;

--
-- TOC entry 12194 (class 0 OID 0)
-- Dependencies: 529
-- Name: TABLE sga_entrada_material_estoque; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sga_entrada_material_estoque IS 'Mantém dados de estocagem do material na entrada';


--
-- TOC entry 12195 (class 0 OID 0)
-- Dependencies: 529
-- Name: COLUMN sga_entrada_material_estoque.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_entrada_material_estoque.id IS 'Identificador sequencial da tabela, chave primaria composta com o campo id_bas_empresa e id_sga_almoxarifado';


--
-- TOC entry 12196 (class 0 OID 0)
-- Dependencies: 529
-- Name: COLUMN sga_entrada_material_estoque.id_bas_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_entrada_material_estoque.id_bas_empresa IS 'Identificador da tabela bas_empresa';


--
-- TOC entry 12197 (class 0 OID 0)
-- Dependencies: 529
-- Name: COLUMN sga_entrada_material_estoque.id_sga_almoxarifado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_entrada_material_estoque.id_sga_almoxarifado IS 'Identificador da tabela sga_almoxarifado';


--
-- TOC entry 12198 (class 0 OID 0)
-- Dependencies: 529
-- Name: COLUMN sga_entrada_material_estoque.id_sga_entrada; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_entrada_material_estoque.id_sga_entrada IS 'Identificador da tabela sga_entrada';


--
-- TOC entry 12199 (class 0 OID 0)
-- Dependencies: 529
-- Name: COLUMN sga_entrada_material_estoque.id_sga_material; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_entrada_material_estoque.id_sga_material IS 'Identificador da tabela sga_material';


--
-- TOC entry 12200 (class 0 OID 0)
-- Dependencies: 529
-- Name: COLUMN sga_entrada_material_estoque.lote; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_entrada_material_estoque.lote IS 'Lote do material a dar entrada';


--
-- TOC entry 12201 (class 0 OID 0)
-- Dependencies: 529
-- Name: COLUMN sga_entrada_material_estoque.fabricacao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_entrada_material_estoque.fabricacao IS 'Data de fabricação do material';


--
-- TOC entry 12202 (class 0 OID 0)
-- Dependencies: 529
-- Name: COLUMN sga_entrada_material_estoque.validade; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_entrada_material_estoque.validade IS 'Data da validade do material';


--
-- TOC entry 12203 (class 0 OID 0)
-- Dependencies: 529
-- Name: COLUMN sga_entrada_material_estoque.quantidade; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_entrada_material_estoque.quantidade IS 'Quantidade do material por lote(ou não, caso não possua lote)';


--
-- TOC entry 12204 (class 0 OID 0)
-- Dependencies: 529
-- Name: COLUMN sga_entrada_material_estoque.id_sga_material_local_prateleira; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_entrada_material_estoque.id_sga_material_local_prateleira IS 'Localização do material';


--
-- TOC entry 12205 (class 0 OID 0)
-- Dependencies: 529
-- Name: COLUMN sga_entrada_material_estoque.valor_unitario; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_entrada_material_estoque.valor_unitario IS 'Valor unitario do material no lote.';


--
-- TOC entry 530 (class 1259 OID 14563735)
-- Name: sga_entrada_material_estoque_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sga_entrada_material_estoque_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sga_entrada_material_estoque_id_seq OWNER TO postgres;

--
-- TOC entry 12206 (class 0 OID 0)
-- Dependencies: 530
-- Name: sga_entrada_material_estoque_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sga_entrada_material_estoque_id_seq OWNED BY public.sga_entrada_material_estoque.id;


--
-- TOC entry 531 (class 1259 OID 14563737)
-- Name: sga_inventario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sga_inventario (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sga_almoxarifado bigint NOT NULL,
 login character varying(32) NOT NULL,
 situacao character(1) DEFAULT 'E'::bpchar NOT NULL,
 login_cancelamento character varying(32),
 data_hora_cancelamento timestamp(0) without time zone,
 motivo_cancelamento character varying(200),
 data_inicial date,
 data_final date,
 numero_inventario character varying(5),
 justificativa character varying(200),
 tipo_inventario character(1),
 data_hora timestamp(0) without time zone
);


ALTER TABLE public.sga_inventario OWNER TO postgres;

--
-- TOC entry 12207 (class 0 OID 0)
-- Dependencies: 531
-- Name: COLUMN sga_inventario.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_inventario.id IS 'Identificador sequencial da tabela, chave primaria composta com o campo id_bas_empresa';


--
-- TOC entry 12208 (class 0 OID 0)
-- Dependencies: 531
-- Name: COLUMN sga_inventario.id_bas_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_inventario.id_bas_empresa IS 'Identificador da tabela bas_empresa, chave primaria composta com o campo id';


--
-- TOC entry 12209 (class 0 OID 0)
-- Dependencies: 531
-- Name: COLUMN sga_inventario.id_sga_almoxarifado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_inventario.id_sga_almoxarifado IS 'Identificador da tabela sga_almoxarifado';


--
-- TOC entry 12210 (class 0 OID 0)
-- Dependencies: 531
-- Name: COLUMN sga_inventario.login; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_inventario.login IS 'Identificador da tabela seg_users';


--
-- TOC entry 12211 (class 0 OID 0)
-- Dependencies: 531
-- Name: COLUMN sga_inventario.situacao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_inventario.situacao IS 'Situação do inventário (E = Em andamento, F = Finalizado)';


--
-- TOC entry 12212 (class 0 OID 0)
-- Dependencies: 531
-- Name: COLUMN sga_inventario.login_cancelamento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_inventario.login_cancelamento IS 'Identificador da tabela seg_users';


--
-- TOC entry 12213 (class 0 OID 0)
-- Dependencies: 531
-- Name: COLUMN sga_inventario.data_hora_cancelamento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_inventario.data_hora_cancelamento IS 'Data e hora de cancelamento do inventário';


--
-- TOC entry 12214 (class 0 OID 0)
-- Dependencies: 531
-- Name: COLUMN sga_inventario.motivo_cancelamento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_inventario.motivo_cancelamento IS 'Motivo de cancelamento do inventário';


--
-- TOC entry 12215 (class 0 OID 0)
-- Dependencies: 531
-- Name: COLUMN sga_inventario.data_inicial; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_inventario.data_inicial IS 'Data inicial da contagem';


--
-- TOC entry 12216 (class 0 OID 0)
-- Dependencies: 531
-- Name: COLUMN sga_inventario.data_final; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_inventario.data_final IS 'Data final da contagem';


--
-- TOC entry 12217 (class 0 OID 0)
-- Dependencies: 531
-- Name: COLUMN sga_inventario.numero_inventario; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_inventario.numero_inventario IS 'Esse campo é um numerador automatico com o tamanho de 5 posições';


--
-- TOC entry 12218 (class 0 OID 0)
-- Dependencies: 531
-- Name: COLUMN sga_inventario.justificativa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_inventario.justificativa IS 'Justificativa do inventario';


--
-- TOC entry 12219 (class 0 OID 0)
-- Dependencies: 531
-- Name: COLUMN sga_inventario.tipo_inventario; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_inventario.tipo_inventario IS 'Informa se é checagem ou normal
N ou C';


--
-- TOC entry 532 (class 1259 OID 14563741)
-- Name: sga_inventario_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sga_inventario_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sga_inventario_id_seq OWNER TO postgres;

--
-- TOC entry 12220 (class 0 OID 0)
-- Dependencies: 532
-- Name: sga_inventario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sga_inventario_id_seq OWNED BY public.sga_inventario.id;


--
-- TOC entry 533 (class 1259 OID 14563743)
-- Name: sga_inventario_material; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sga_inventario_material (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sga_almoxarifado bigint NOT NULL,
 id_sga_inventario integer,
 id_sga_material integer,
 quantidade numeric(9,2),
 quantidade_no_estoque numeric(9,2),
 valor_medio_unitario numeric(9,2),
 valor_total numeric(9,2)
);


ALTER TABLE public.sga_inventario_material OWNER TO postgres;

--
-- TOC entry 12221 (class 0 OID 0)
-- Dependencies: 533
-- Name: TABLE sga_inventario_material; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sga_inventario_material IS 'Mantém dados gerais do material no inventário';


--
-- TOC entry 12222 (class 0 OID 0)
-- Dependencies: 533
-- Name: COLUMN sga_inventario_material.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_inventario_material.id IS 'Identificador sequencial da tabela, chave primaria composta com o campo id_bas_empresa e id_sga_almoxarifado';


--
-- TOC entry 12223 (class 0 OID 0)
-- Dependencies: 533
-- Name: COLUMN sga_inventario_material.id_bas_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_inventario_material.id_bas_empresa IS 'Identificador da tabela bas_empresa';


--
-- TOC entry 12224 (class 0 OID 0)
-- Dependencies: 533
-- Name: COLUMN sga_inventario_material.id_sga_almoxarifado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_inventario_material.id_sga_almoxarifado IS 'Identificador da tabela sga_almoxarifado';


--
-- TOC entry 12225 (class 0 OID 0)
-- Dependencies: 533
-- Name: COLUMN sga_inventario_material.id_sga_inventario; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_inventario_material.id_sga_inventario IS 'Identificador da tabela sga_inventario';


--
-- TOC entry 12226 (class 0 OID 0)
-- Dependencies: 533
-- Name: COLUMN sga_inventario_material.id_sga_material; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_inventario_material.id_sga_material IS 'Chave da tabela sga_material';


--
-- TOC entry 12227 (class 0 OID 0)
-- Dependencies: 533
-- Name: COLUMN sga_inventario_material.quantidade; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_inventario_material.quantidade IS 'Quantidade do material';


--
-- TOC entry 12228 (class 0 OID 0)
-- Dependencies: 533
-- Name: COLUMN sga_inventario_material.quantidade_no_estoque; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_inventario_material.quantidade_no_estoque IS 'Valor do estoque na criação do inventário';


--
-- TOC entry 12229 (class 0 OID 0)
-- Dependencies: 533
-- Name: COLUMN sga_inventario_material.valor_medio_unitario; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_inventario_material.valor_medio_unitario IS 'Valor médio unitário do material, calculado com base no quantitativo e valor unitário dos materiais por lote.';


--
-- TOC entry 12230 (class 0 OID 0)
-- Dependencies: 533
-- Name: COLUMN sga_inventario_material.valor_total; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_inventario_material.valor_total IS 'Valor total';


--
-- TOC entry 534 (class 1259 OID 14563746)
-- Name: sga_inventario_material_estoque; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sga_inventario_material_estoque (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sga_almoxarifado bigint NOT NULL,
 id_sga_inventario_material bigint NOT NULL,
 id_sga_material bigint NOT NULL,
 lote character(10),
 fabricacao date,
 validade date,
 quantidade numeric(9,2) NOT NULL,
 id_sga_material_local_prateleira integer,
 valor_unitario numeric(9,2),
 valor_total numeric(9,2),
 id_sga_material_estoque bigint,
 quantidade_contada numeric(2,0),
 quantidade_antiga numeric(2,0)
);


ALTER TABLE public.sga_inventario_material_estoque OWNER TO postgres;

--
-- TOC entry 12231 (class 0 OID 0)
-- Dependencies: 534
-- Name: TABLE sga_inventario_material_estoque; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sga_inventario_material_estoque IS 'Mantém dados de estocagem do material d inventário';


--
-- TOC entry 12232 (class 0 OID 0)
-- Dependencies: 534
-- Name: COLUMN sga_inventario_material_estoque.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_inventario_material_estoque.id IS 'Identificador sequencial da tabela, chave primaria composta com o campo id_bas_empresa e id_sga_almoxarifado';


--
-- TOC entry 12233 (class 0 OID 0)
-- Dependencies: 534
-- Name: COLUMN sga_inventario_material_estoque.id_bas_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_inventario_material_estoque.id_bas_empresa IS 'Identificador da tabela bas_empresa';


--
-- TOC entry 12234 (class 0 OID 0)
-- Dependencies: 534
-- Name: COLUMN sga_inventario_material_estoque.id_sga_almoxarifado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_inventario_material_estoque.id_sga_almoxarifado IS 'Identificador da tabela sga_almoxarifado';


--
-- TOC entry 12235 (class 0 OID 0)
-- Dependencies: 534
-- Name: COLUMN sga_inventario_material_estoque.id_sga_inventario_material; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_inventario_material_estoque.id_sga_inventario_material IS 'Identificador da tabela sga_inventario_material';


--
-- TOC entry 12236 (class 0 OID 0)
-- Dependencies: 534
-- Name: COLUMN sga_inventario_material_estoque.id_sga_material; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_inventario_material_estoque.id_sga_material IS 'Identificador da tabela sga_material';


--
-- TOC entry 12237 (class 0 OID 0)
-- Dependencies: 534
-- Name: COLUMN sga_inventario_material_estoque.lote; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_inventario_material_estoque.lote IS 'Lote do material a dar entrada';


--
-- TOC entry 12238 (class 0 OID 0)
-- Dependencies: 534
-- Name: COLUMN sga_inventario_material_estoque.fabricacao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_inventario_material_estoque.fabricacao IS 'Data de fabricação do material';


--
-- TOC entry 12239 (class 0 OID 0)
-- Dependencies: 534
-- Name: COLUMN sga_inventario_material_estoque.validade; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_inventario_material_estoque.validade IS 'Data da validade do material';


--
-- TOC entry 12240 (class 0 OID 0)
-- Dependencies: 534
-- Name: COLUMN sga_inventario_material_estoque.quantidade; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_inventario_material_estoque.quantidade IS 'Quantidade do material por lote(ou não, caso não possua lote)';


--
-- TOC entry 12241 (class 0 OID 0)
-- Dependencies: 534
-- Name: COLUMN sga_inventario_material_estoque.id_sga_material_local_prateleira; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_inventario_material_estoque.id_sga_material_local_prateleira IS 'Localização do material';


--
-- TOC entry 12242 (class 0 OID 0)
-- Dependencies: 534
-- Name: COLUMN sga_inventario_material_estoque.valor_unitario; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_inventario_material_estoque.valor_unitario IS 'Valor unitario do material no lote.';


--
-- TOC entry 12243 (class 0 OID 0)
-- Dependencies: 534
-- Name: COLUMN sga_inventario_material_estoque.valor_total; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_inventario_material_estoque.valor_total IS 'Valor total do material no lote, calculado multiplicando o valor unitário pela quantidade.';


--
-- TOC entry 12244 (class 0 OID 0)
-- Dependencies: 534
-- Name: COLUMN sga_inventario_material_estoque.id_sga_material_estoque; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_inventario_material_estoque.id_sga_material_estoque IS 'Identificador da tabela sga_material_estoque, chave primaria do material estoque';


--
-- TOC entry 535 (class 1259 OID 14563749)
-- Name: sga_inventario_material_estoque_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sga_inventario_material_estoque_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sga_inventario_material_estoque_id_seq OWNER TO postgres;

--
-- TOC entry 12245 (class 0 OID 0)
-- Dependencies: 535
-- Name: sga_inventario_material_estoque_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sga_inventario_material_estoque_id_seq OWNED BY public.sga_inventario_material_estoque.id;


--
-- TOC entry 536 (class 1259 OID 14563751)
-- Name: sga_inventario_material_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sga_inventario_material_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sga_inventario_material_id_seq OWNER TO postgres;

--
-- TOC entry 12246 (class 0 OID 0)
-- Dependencies: 536
-- Name: sga_inventario_material_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sga_inventario_material_id_seq OWNED BY public.sga_inventario_material.id;


--
-- TOC entry 537 (class 1259 OID 14563753)
-- Name: sga_item_contrato_licitacao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sga_item_contrato_licitacao (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sga_contrato_licitacao bigint NOT NULL,
 quantidade numeric(9,2) NOT NULL,
 valor_unitario numeric(9,2) NOT NULL,
 id_sga_material bigint NOT NULL,
 quantidade_atual numeric(9,2),
 id_sga_material_grupo integer,
 id_sga_material_subgrupo integer
);


ALTER TABLE public.sga_item_contrato_licitacao OWNER TO postgres;

--
-- TOC entry 538 (class 1259 OID 14563756)
-- Name: sga_item_contrato_licitacao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sga_item_contrato_licitacao_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sga_item_contrato_licitacao_id_seq OWNER TO postgres;

--
-- TOC entry 12247 (class 0 OID 0)
-- Dependencies: 538
-- Name: sga_item_contrato_licitacao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sga_item_contrato_licitacao_id_seq OWNED BY public.sga_item_contrato_licitacao.id;


--
-- TOC entry 539 (class 1259 OID 14563758)
-- Name: sga_marca; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sga_marca (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(100) NOT NULL
);


ALTER TABLE public.sga_marca OWNER TO postgres;

--
-- TOC entry 540 (class 1259 OID 14563761)
-- Name: sga_marca_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sga_marca_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sga_marca_id_seq OWNER TO postgres;

--
-- TOC entry 12248 (class 0 OID 0)
-- Dependencies: 540
-- Name: sga_marca_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sga_marca_id_seq OWNED BY public.sga_marca.id;


--
-- TOC entry 541 (class 1259 OID 14563763)
-- Name: sga_material; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sga_material (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sga_material_subgrupo bigint NOT NULL,
 id_sga_material_tipo bigint NOT NULL,
 id_sga_marca bigint,
 id_sga_material_durabilidade bigint,
 id_sga_material_procedencia bigint,
 id_sga_unidade_medida bigint,
 nome character varying(200) NOT NULL,
 descricao text NOT NULL,
 perecivel character(1),
 tamanhos character varying(50),
 id_sga_material_grupo integer,
 id_bas_estabelecimento integer
);


ALTER TABLE public.sga_material OWNER TO postgres;

--
-- TOC entry 12249 (class 0 OID 0)
-- Dependencies: 541
-- Name: COLUMN sga_material.perecivel; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_material.perecivel IS 'S = sim / N = não';


--
-- TOC entry 12250 (class 0 OID 0)
-- Dependencies: 541
-- Name: COLUMN sga_material.tamanhos; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_material.tamanhos IS 'Lista de tamanhos, quando o material for um fardamento, que devem ser separados por vírgula ex (p,m,g)';


SET default_with_oids = true;

--
-- TOC entry 542 (class 1259 OID 14563769)
-- Name: sga_material_durabilidade; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sga_material_durabilidade (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(100) NOT NULL
);


ALTER TABLE public.sga_material_durabilidade OWNER TO postgres;

--
-- TOC entry 543 (class 1259 OID 14563772)
-- Name: sga_material_durabilidade_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sga_material_durabilidade_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sga_material_durabilidade_id_seq OWNER TO postgres;

--
-- TOC entry 12251 (class 0 OID 0)
-- Dependencies: 543
-- Name: sga_material_durabilidade_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sga_material_durabilidade_id_seq OWNED BY public.sga_material_durabilidade.id;


SET default_with_oids = false;

--
-- TOC entry 544 (class 1259 OID 14563774)
-- Name: sga_material_estoque; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sga_material_estoque (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sga_almoxarifado bigint NOT NULL,
 id_sga_entrada_material_estoque bigint NOT NULL,
 id_sga_material bigint NOT NULL,
 lote character(10),
 fabricacao date,
 validade date,
 quantidade numeric(9,2) NOT NULL,
 id_sga_material_local_prateleira integer,
 valor_unitario numeric(9,2),
 valor_total numeric(9,2)
);


ALTER TABLE public.sga_material_estoque OWNER TO postgres;

--
-- TOC entry 12252 (class 0 OID 0)
-- Dependencies: 544
-- Name: TABLE sga_material_estoque; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sga_material_estoque IS 'Cadastra dados de estocagem do material';


--
-- TOC entry 12253 (class 0 OID 0)
-- Dependencies: 544
-- Name: COLUMN sga_material_estoque.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_material_estoque.id IS 'Identificador sequencial da tabela, chave primaria composta com o campo id_bas_empresa e id_sga_almoxarifado';


--
-- TOC entry 12254 (class 0 OID 0)
-- Dependencies: 544
-- Name: COLUMN sga_material_estoque.id_bas_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_material_estoque.id_bas_empresa IS 'Identificador da tabela bas_empresa, chave primaria composta com o campo id';


--
-- TOC entry 12255 (class 0 OID 0)
-- Dependencies: 544
-- Name: COLUMN sga_material_estoque.id_sga_almoxarifado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_material_estoque.id_sga_almoxarifado IS 'Identificador da tabela sga_almoxarifado';


--
-- TOC entry 12256 (class 0 OID 0)
-- Dependencies: 544
-- Name: COLUMN sga_material_estoque.id_sga_entrada_material_estoque; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_material_estoque.id_sga_entrada_material_estoque IS 'Identificador da tabela sga_entrada_material_estoque';


--
-- TOC entry 12257 (class 0 OID 0)
-- Dependencies: 544
-- Name: COLUMN sga_material_estoque.id_sga_material; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_material_estoque.id_sga_material IS 'Identificador da tabela sga_material';


--
-- TOC entry 12258 (class 0 OID 0)
-- Dependencies: 544
-- Name: COLUMN sga_material_estoque.lote; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_material_estoque.lote IS 'Lote do material a dar entrada';


--
-- TOC entry 12259 (class 0 OID 0)
-- Dependencies: 544
-- Name: COLUMN sga_material_estoque.fabricacao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_material_estoque.fabricacao IS 'Data de fabricação do material';


--
-- TOC entry 12260 (class 0 OID 0)
-- Dependencies: 544
-- Name: COLUMN sga_material_estoque.validade; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_material_estoque.validade IS 'Data da validade do material';


--
-- TOC entry 12261 (class 0 OID 0)
-- Dependencies: 544
-- Name: COLUMN sga_material_estoque.quantidade; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_material_estoque.quantidade IS 'Quantidade do material por lote(ou não, caso não possua lote)';


--
-- TOC entry 12262 (class 0 OID 0)
-- Dependencies: 544
-- Name: COLUMN sga_material_estoque.id_sga_material_local_prateleira; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_material_estoque.id_sga_material_local_prateleira IS 'Localização do material';


--
-- TOC entry 12263 (class 0 OID 0)
-- Dependencies: 544
-- Name: COLUMN sga_material_estoque.valor_unitario; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_material_estoque.valor_unitario IS 'Valor unitario do material no lote.';


--
-- TOC entry 545 (class 1259 OID 14563777)
-- Name: sga_material_estoque_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sga_material_estoque_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sga_material_estoque_id_seq OWNER TO postgres;

--
-- TOC entry 12264 (class 0 OID 0)
-- Dependencies: 545
-- Name: sga_material_estoque_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sga_material_estoque_id_seq OWNED BY public.sga_material_estoque.id;


--
-- TOC entry 546 (class 1259 OID 14563779)
-- Name: sga_material_estoque_minimo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sga_material_estoque_minimo (
 id bigint NOT NULL,
 id_sga_almoxarifado integer NOT NULL,
 id_sga_material integer NOT NULL,
 id_sga_unidade_medida integer NOT NULL,
 valor_desejavel numeric(10,2) NOT NULL,
 percentual_seguranca numeric(10,2)
);


ALTER TABLE public.sga_material_estoque_minimo OWNER TO postgres;

--
-- TOC entry 547 (class 1259 OID 14563782)
-- Name: sga_material_estoque_minimo_id_seq; Type: SEQUENCE; Schema: public; Owner: pgadmin
--

CREATE SEQUENCE public.sga_material_estoque_minimo_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sga_material_estoque_minimo_id_seq OWNER TO pgadmin;

--
-- TOC entry 548 (class 1259 OID 14563784)
-- Name: sga_material_estoque_minimo_id_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sga_material_estoque_minimo_id_seq1
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sga_material_estoque_minimo_id_seq1 OWNER TO postgres;

--
-- TOC entry 12265 (class 0 OID 0)
-- Dependencies: 548
-- Name: sga_material_estoque_minimo_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sga_material_estoque_minimo_id_seq1 OWNED BY public.sga_material_estoque_minimo.id;


--
-- TOC entry 549 (class 1259 OID 14563786)
-- Name: sga_material_grupo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sga_material_grupo (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(100) NOT NULL,
 ind_utilizado_matricula_aluno boolean
);


ALTER TABLE public.sga_material_grupo OWNER TO postgres;

--
-- TOC entry 550 (class 1259 OID 14563789)
-- Name: sga_material_grupo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sga_material_grupo_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sga_material_grupo_id_seq OWNER TO postgres;

--
-- TOC entry 12266 (class 0 OID 0)
-- Dependencies: 550
-- Name: sga_material_grupo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sga_material_grupo_id_seq OWNED BY public.sga_material_grupo.id;


--
-- TOC entry 551 (class 1259 OID 14563791)
-- Name: sga_material_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sga_material_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sga_material_id_seq OWNER TO postgres;

--
-- TOC entry 12267 (class 0 OID 0)
-- Dependencies: 551
-- Name: sga_material_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sga_material_id_seq OWNED BY public.sga_material.id;


--
-- TOC entry 552 (class 1259 OID 14563793)
-- Name: sga_material_local_estante; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sga_material_local_estante (
 id bigint NOT NULL,
 id_sga_material_local_rua integer NOT NULL,
 nome character varying(10) NOT NULL
);


ALTER TABLE public.sga_material_local_estante OWNER TO postgres;

--
-- TOC entry 553 (class 1259 OID 14563796)
-- Name: sga_material_local_estante_id_seq; Type: SEQUENCE; Schema: public; Owner: pgadmin
--

CREATE SEQUENCE public.sga_material_local_estante_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sga_material_local_estante_id_seq OWNER TO pgadmin;

--
-- TOC entry 554 (class 1259 OID 14563798)
-- Name: sga_material_local_estante_id_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sga_material_local_estante_id_seq1
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sga_material_local_estante_id_seq1 OWNER TO postgres;

--
-- TOC entry 12268 (class 0 OID 0)
-- Dependencies: 554
-- Name: sga_material_local_estante_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sga_material_local_estante_id_seq1 OWNED BY public.sga_material_local_estante.id;


--
-- TOC entry 555 (class 1259 OID 14563800)
-- Name: sga_material_local_prateleira; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sga_material_local_prateleira (
 id bigint NOT NULL,
 id_sga_material_local_estante integer NOT NULL,
 nome character varying(10) NOT NULL
);


ALTER TABLE public.sga_material_local_prateleira OWNER TO postgres;

--
-- TOC entry 556 (class 1259 OID 14563803)
-- Name: sga_material_local_prateleira_id_seq; Type: SEQUENCE; Schema: public; Owner: pgadmin
--

CREATE SEQUENCE public.sga_material_local_prateleira_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sga_material_local_prateleira_id_seq OWNER TO pgadmin;

--
-- TOC entry 557 (class 1259 OID 14563805)
-- Name: sga_material_local_prateleira_id_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sga_material_local_prateleira_id_seq1
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sga_material_local_prateleira_id_seq1 OWNER TO postgres;

--
-- TOC entry 12269 (class 0 OID 0)
-- Dependencies: 557
-- Name: sga_material_local_prateleira_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sga_material_local_prateleira_id_seq1 OWNED BY public.sga_material_local_prateleira.id;


--
-- TOC entry 558 (class 1259 OID 14563807)
-- Name: sga_material_local_rua; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sga_material_local_rua (
 id bigint NOT NULL,
 id_sga_almoxarifado integer NOT NULL,
 nome character varying(10) NOT NULL
);


ALTER TABLE public.sga_material_local_rua OWNER TO postgres;

--
-- TOC entry 559 (class 1259 OID 14563810)
-- Name: sga_material_local_rua_id_seq; Type: SEQUENCE; Schema: public; Owner: pgadmin
--

CREATE SEQUENCE public.sga_material_local_rua_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sga_material_local_rua_id_seq OWNER TO pgadmin;

--
-- TOC entry 560 (class 1259 OID 14563812)
-- Name: sga_material_local_rua_id_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sga_material_local_rua_id_seq1
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sga_material_local_rua_id_seq1 OWNER TO postgres;

--
-- TOC entry 12270 (class 0 OID 0)
-- Dependencies: 560
-- Name: sga_material_local_rua_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sga_material_local_rua_id_seq1 OWNED BY public.sga_material_local_rua.id;


--
-- TOC entry 561 (class 1259 OID 14563814)
-- Name: sga_material_movimento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sga_material_movimento (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sga_almoxarifado bigint NOT NULL,
 id_sga_material_movimento_tipo bigint NOT NULL,
 data date NOT NULL,
 id_sga_entrada_material_estoque integer,
 id_sga_baixa_material_estoque integer
);


ALTER TABLE public.sga_material_movimento OWNER TO postgres;

--
-- TOC entry 12271 (class 0 OID 0)
-- Dependencies: 561
-- Name: TABLE sga_material_movimento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sga_material_movimento IS 'Cadastra a movimentação do material.';


--
-- TOC entry 12272 (class 0 OID 0)
-- Dependencies: 561
-- Name: COLUMN sga_material_movimento.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_material_movimento.id IS 'Identificador sequencial da tabela, chave primaria composta com o campo id_bas_empresa';


--
-- TOC entry 12273 (class 0 OID 0)
-- Dependencies: 561
-- Name: COLUMN sga_material_movimento.id_bas_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_material_movimento.id_bas_empresa IS 'Identificador da tabela bas_empresa, chave primaria composta com o campo id';


--
-- TOC entry 12274 (class 0 OID 0)
-- Dependencies: 561
-- Name: COLUMN sga_material_movimento.id_sga_almoxarifado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_material_movimento.id_sga_almoxarifado IS 'Identificador da tabela sga_almoxarifado_material junto com os campos id_bas_empresa e id_sga_material';


--
-- TOC entry 12275 (class 0 OID 0)
-- Dependencies: 561
-- Name: COLUMN sga_material_movimento.id_sga_material_movimento_tipo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_material_movimento.id_sga_material_movimento_tipo IS 'identificador da tabela sga_material_movimento_tipo';


--
-- TOC entry 12276 (class 0 OID 0)
-- Dependencies: 561
-- Name: COLUMN sga_material_movimento.data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_material_movimento.data IS 'Data da movimentação';


--
-- TOC entry 12277 (class 0 OID 0)
-- Dependencies: 561
-- Name: COLUMN sga_material_movimento.id_sga_entrada_material_estoque; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_material_movimento.id_sga_entrada_material_estoque IS 'Chave da tabela sga_entrada_material_estoque';


--
-- TOC entry 12278 (class 0 OID 0)
-- Dependencies: 561
-- Name: COLUMN sga_material_movimento.id_sga_baixa_material_estoque; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_material_movimento.id_sga_baixa_material_estoque IS 'Chave da tabela sga_baixa_material_estoque';


--
-- TOC entry 562 (class 1259 OID 14563817)
-- Name: sga_material_movimento_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sga_material_movimento_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sga_material_movimento_id_seq OWNER TO postgres;

--
-- TOC entry 12279 (class 0 OID 0)
-- Dependencies: 562
-- Name: sga_material_movimento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sga_material_movimento_id_seq OWNED BY public.sga_material_movimento.id;


--
-- TOC entry 563 (class 1259 OID 14563819)
-- Name: sga_material_movimento_tipo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sga_material_movimento_tipo (
 id bigint NOT NULL,
 motivo character varying(50) NOT NULL,
 tipo character(1) NOT NULL
);


ALTER TABLE public.sga_material_movimento_tipo OWNER TO postgres;

--
-- TOC entry 12280 (class 0 OID 0)
-- Dependencies: 563
-- Name: TABLE sga_material_movimento_tipo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sga_material_movimento_tipo IS 'Cadastra o tipo de movimentação do material.';


--
-- TOC entry 12281 (class 0 OID 0)
-- Dependencies: 563
-- Name: COLUMN sga_material_movimento_tipo.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_material_movimento_tipo.id IS 'Identificador sequencial da tabela, chave primaria';


--
-- TOC entry 12282 (class 0 OID 0)
-- Dependencies: 563
-- Name: COLUMN sga_material_movimento_tipo.motivo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_material_movimento_tipo.motivo IS 'Motivo que gerou a movimentação:
1 - Implantação de Saldo Inicial = E
2 - Entrada de material = E
3 - Atendimento de requisição = S
4 - Devolução de material requsitado = E
5 - Baixa de material = S
6 - Transferência (origem) = S
7 - Transferência (destino) = E
8 - Venda = S
9 - Troca de material vendido(Original) = E
10-Troca de material vendido(Substituto)= S
11-Ajuste de inventário(Entrada) = E
12-Ajuste de inventário(Saída) = S';


--
-- TOC entry 12283 (class 0 OID 0)
-- Dependencies: 563
-- Name: COLUMN sga_material_movimento_tipo.tipo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_material_movimento_tipo.tipo IS 'Tipo da movimentação. (E = Entrada e S = Saída)';


--
-- TOC entry 564 (class 1259 OID 14563822)
-- Name: sga_material_movimento_tipo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sga_material_movimento_tipo_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sga_material_movimento_tipo_id_seq OWNER TO postgres;

--
-- TOC entry 12284 (class 0 OID 0)
-- Dependencies: 564
-- Name: sga_material_movimento_tipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sga_material_movimento_tipo_id_seq OWNED BY public.sga_material_movimento_tipo.id;


SET default_with_oids = true;

--
-- TOC entry 565 (class 1259 OID 14563824)
-- Name: sga_material_procedencia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sga_material_procedencia (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(100) NOT NULL
);


ALTER TABLE public.sga_material_procedencia OWNER TO postgres;

--
-- TOC entry 566 (class 1259 OID 14563827)
-- Name: sga_material_procedencia_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sga_material_procedencia_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sga_material_procedencia_id_seq OWNER TO postgres;

--
-- TOC entry 12285 (class 0 OID 0)
-- Dependencies: 566
-- Name: sga_material_procedencia_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sga_material_procedencia_id_seq OWNED BY public.sga_material_procedencia.id;


SET default_with_oids = false;

--
-- TOC entry 567 (class 1259 OID 14563829)
-- Name: sga_material_subgrupo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sga_material_subgrupo (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(100) NOT NULL,
 id_sga_material_grupo bigint NOT NULL
);


ALTER TABLE public.sga_material_subgrupo OWNER TO postgres;

--
-- TOC entry 568 (class 1259 OID 14563832)
-- Name: sga_material_tipo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sga_material_tipo (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 descricao character varying(100) NOT NULL
);


ALTER TABLE public.sga_material_tipo OWNER TO postgres;

--
-- TOC entry 569 (class 1259 OID 14563835)
-- Name: sga_material_tipo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sga_material_tipo_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sga_material_tipo_id_seq OWNER TO postgres;

--
-- TOC entry 12286 (class 0 OID 0)
-- Dependencies: 569
-- Name: sga_material_tipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sga_material_tipo_id_seq OWNED BY public.sga_material_tipo.id;


--
-- TOC entry 570 (class 1259 OID 14563837)
-- Name: sga_material_troca; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sga_material_troca (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sga_venda bigint NOT NULL,
 id_sga_almoxarifado bigint NOT NULL,
 id_sga_material bigint NOT NULL,
 login character varying(32) NOT NULL,
 quantidade numeric(9,2) NOT NULL,
 data date NOT NULL,
 tipo character(1) NOT NULL,
 valor numeric(9,2) NOT NULL,
 total numeric(9,2) NOT NULL,
 desconto numeric(9,2) DEFAULT 0 NOT NULL
);


ALTER TABLE public.sga_material_troca OWNER TO postgres;

--
-- TOC entry 12287 (class 0 OID 0)
-- Dependencies: 570
-- Name: TABLE sga_material_troca; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sga_material_troca IS 'Cadastra as trocas de materias vendidos';


--
-- TOC entry 12288 (class 0 OID 0)
-- Dependencies: 570
-- Name: COLUMN sga_material_troca.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_material_troca.id IS 'Identificador sequencial da tabela, chave primaria composta com o campo id_bas_empresa';


--
-- TOC entry 12289 (class 0 OID 0)
-- Dependencies: 570
-- Name: COLUMN sga_material_troca.id_bas_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_material_troca.id_bas_empresa IS 'Identificador da tabela bas_empresa, chave primaria composta com o campo id';


--
-- TOC entry 12290 (class 0 OID 0)
-- Dependencies: 570
-- Name: COLUMN sga_material_troca.id_sga_venda; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_material_troca.id_sga_venda IS 'Identificador da tabela sga_venda';


--
-- TOC entry 12291 (class 0 OID 0)
-- Dependencies: 570
-- Name: COLUMN sga_material_troca.id_sga_almoxarifado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_material_troca.id_sga_almoxarifado IS 'Identificador da tabela sga_almoxarifado_material junto com os campos id_bas_empresa e id_sga_material';


--
-- TOC entry 12292 (class 0 OID 0)
-- Dependencies: 570
-- Name: COLUMN sga_material_troca.id_sga_material; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_material_troca.id_sga_material IS 'Identificador da tabela sga_almoxarifado_material junto com os campos id_bas_empresa e id_sga_almoxarifado';


--
-- TOC entry 12293 (class 0 OID 0)
-- Dependencies: 570
-- Name: COLUMN sga_material_troca.login; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_material_troca.login IS 'Identificador da tabela seg_users. Usuário que registrou a troca';


--
-- TOC entry 12294 (class 0 OID 0)
-- Dependencies: 570
-- Name: COLUMN sga_material_troca.quantidade; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_material_troca.quantidade IS 'Quantidade a ser trocada';


--
-- TOC entry 12295 (class 0 OID 0)
-- Dependencies: 570
-- Name: COLUMN sga_material_troca.data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_material_troca.data IS 'Data da troca do material';


--
-- TOC entry 12296 (class 0 OID 0)
-- Dependencies: 570
-- Name: COLUMN sga_material_troca.tipo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_material_troca.tipo IS 'Identificador de entrada ou saída do material. E = Entrada, S = Saída';


--
-- TOC entry 12297 (class 0 OID 0)
-- Dependencies: 570
-- Name: COLUMN sga_material_troca.valor; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_material_troca.valor IS 'Valor unitário do material';


--
-- TOC entry 12298 (class 0 OID 0)
-- Dependencies: 570
-- Name: COLUMN sga_material_troca.total; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_material_troca.total IS 'Valor total do material';


--
-- TOC entry 12299 (class 0 OID 0)
-- Dependencies: 570
-- Name: COLUMN sga_material_troca.desconto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_material_troca.desconto IS 'Desconto do valor do material';


--
-- TOC entry 571 (class 1259 OID 14563841)
-- Name: sga_material_troca_id_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sga_material_troca_id_seq1
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sga_material_troca_id_seq1 OWNER TO postgres;

--
-- TOC entry 12300 (class 0 OID 0)
-- Dependencies: 571
-- Name: sga_material_troca_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sga_material_troca_id_seq1 OWNED BY public.sga_material_troca.id;


--
-- TOC entry 572 (class 1259 OID 14563843)
-- Name: sga_procedencia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sga_procedencia (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(100) NOT NULL
);


ALTER TABLE public.sga_procedencia OWNER TO postgres;

--
-- TOC entry 573 (class 1259 OID 14563846)
-- Name: sga_procedencia_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sga_procedencia_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sga_procedencia_id_seq OWNER TO postgres;

--
-- TOC entry 12301 (class 0 OID 0)
-- Dependencies: 573
-- Name: sga_procedencia_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sga_procedencia_id_seq OWNED BY public.sga_procedencia.id;


SET default_with_oids = true;

--
-- TOC entry 574 (class 1259 OID 14563848)
-- Name: sga_professor_serie_material; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sga_professor_serie_material (
 id_bas_empresa bigint NOT NULL,
 id_bas_colaborador bigint NOT NULL,
 id_sge_serie bigint NOT NULL,
 id_sga_material bigint NOT NULL,
 quantidade numeric(9,2) NOT NULL
);


ALTER TABLE public.sga_professor_serie_material OWNER TO postgres;

SET default_with_oids = false;

--
-- TOC entry 575 (class 1259 OID 14563851)
-- Name: sga_requisicao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sga_requisicao (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_centro_custo bigint NOT NULL,
 id_sga_almoxarifado bigint NOT NULL,
 id_bas_colaborador bigint NOT NULL,
 numero_requisicao character varying(20) NOT NULL,
 finalidade character(1) NOT NULL,
 data date NOT NULL,
 observacao text,
 finalizado character(1) DEFAULT 'N'::bpchar NOT NULL,
 situacao character(1) DEFAULT 'E'::bpchar NOT NULL,
 justificativa character varying(200) NOT NULL,
 login character varying(64),
 finalizar_atendimento character(1),
 id_bas_estabelecimento bigint,
 tipo character(1) DEFAULT 'I'::bpchar NOT NULL,
 id_sga_almoxarifado_destino bigint
);


ALTER TABLE public.sga_requisicao OWNER TO postgres;

--
-- TOC entry 12302 (class 0 OID 0)
-- Dependencies: 575
-- Name: TABLE sga_requisicao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sga_requisicao IS 'Cadastra as informações de uma requisição.';


--
-- TOC entry 12303 (class 0 OID 0)
-- Dependencies: 575
-- Name: COLUMN sga_requisicao.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_requisicao.id IS 'Identificador sequencial da tabela, chave primaria composta com o campo id_bas_empresa';


--
-- TOC entry 12304 (class 0 OID 0)
-- Dependencies: 575
-- Name: COLUMN sga_requisicao.id_bas_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_requisicao.id_bas_empresa IS 'Identificador da tabela bas_empresa, chave primaria composta com o campo id';


--
-- TOC entry 12305 (class 0 OID 0)
-- Dependencies: 575
-- Name: COLUMN sga_requisicao.id_bas_centro_custo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_requisicao.id_bas_centro_custo IS 'Identificador da tabela bas_centro_custo';


--
-- TOC entry 12306 (class 0 OID 0)
-- Dependencies: 575
-- Name: COLUMN sga_requisicao.id_sga_almoxarifado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_requisicao.id_sga_almoxarifado IS 'Identificador da tabela sga_almoxarifado';


--
-- TOC entry 12307 (class 0 OID 0)
-- Dependencies: 575
-- Name: COLUMN sga_requisicao.id_bas_colaborador; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_requisicao.id_bas_colaborador IS 'usuário que realizou a requisição';


--
-- TOC entry 12308 (class 0 OID 0)
-- Dependencies: 575
-- Name: COLUMN sga_requisicao.numero_requisicao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_requisicao.numero_requisicao IS 'Número da requisição para identificação pelos usuários do sistema';


--
-- TOC entry 12309 (class 0 OID 0)
-- Dependencies: 575
-- Name: COLUMN sga_requisicao.finalidade; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_requisicao.finalidade IS 'Finalidade da requisição(C = consumo, D = doação, O = outras)';


--
-- TOC entry 12310 (class 0 OID 0)
-- Dependencies: 575
-- Name: COLUMN sga_requisicao.data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_requisicao.data IS 'Data da requisição';


--
-- TOC entry 12311 (class 0 OID 0)
-- Dependencies: 575
-- Name: COLUMN sga_requisicao.observacao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_requisicao.observacao IS 'Informações adicionais da requisição';


--
-- TOC entry 12312 (class 0 OID 0)
-- Dependencies: 575
-- Name: COLUMN sga_requisicao.finalizado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_requisicao.finalizado IS 'Flag para identificar se a requisição está finalizada (S = Sim, N = Não)';


--
-- TOC entry 12313 (class 0 OID 0)
-- Dependencies: 575
-- Name: COLUMN sga_requisicao.situacao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_requisicao.situacao IS 'Situação geral da requisição (E = Em análise, A = Atendido, N = Negada, P = Atendido Parcial e C = Atendido Parcial/Concluída)';


--
-- TOC entry 12314 (class 0 OID 0)
-- Dependencies: 575
-- Name: COLUMN sga_requisicao.login; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_requisicao.login IS 'Usuário que criou os registros, usado para efeito de visualização';


--
-- TOC entry 12315 (class 0 OID 0)
-- Dependencies: 575
-- Name: COLUMN sga_requisicao.finalizar_atendimento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_requisicao.finalizar_atendimento IS 'S ou N';


--
-- TOC entry 12316 (class 0 OID 0)
-- Dependencies: 575
-- Name: COLUMN sga_requisicao.id_bas_estabelecimento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_requisicao.id_bas_estabelecimento IS 'Chave da requisição';


--
-- TOC entry 12317 (class 0 OID 0)
-- Dependencies: 575
-- Name: COLUMN sga_requisicao.tipo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_requisicao.tipo IS 'Tipo da requisição (I = Interna, E = Externa)';


--
-- TOC entry 12318 (class 0 OID 0)
-- Dependencies: 575
-- Name: COLUMN sga_requisicao.id_sga_almoxarifado_destino; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_requisicao.id_sga_almoxarifado_destino IS 'Almoxarifado destino da requisição';


--
-- TOC entry 576 (class 1259 OID 14563860)
-- Name: sga_requisicao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sga_requisicao_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sga_requisicao_id_seq OWNER TO postgres;

--
-- TOC entry 12319 (class 0 OID 0)
-- Dependencies: 576
-- Name: sga_requisicao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sga_requisicao_id_seq OWNED BY public.sga_requisicao.id;


--
-- TOC entry 577 (class 1259 OID 14563862)
-- Name: sga_requisicao_material; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sga_requisicao_material (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sga_requisicao bigint NOT NULL,
 id_sga_almoxarifado bigint NOT NULL,
 id_sga_material bigint NOT NULL,
 quantidade_solicitada numeric(9,2) NOT NULL,
 quantidade_atendida numeric(9,2),
 situacao character(1) DEFAULT 'E'::bpchar NOT NULL,
 motivo text,
 lote character varying(15),
 valor_unitario numeric(9,2),
 validade date,
 valor_total numeric(9,2),
 id_sga_material_local_prateleira integer,
 finalizar_atendimento character(1),
 tipo_atendimento character varying(2),
 finalizado character(1),
 marcar_material character(1),
 login character varying(64),
 id_sga_entrada_material integer,
 quantidade_estoque numeric(9,2)
);


ALTER TABLE public.sga_requisicao_material OWNER TO postgres;

--
-- TOC entry 12320 (class 0 OID 0)
-- Dependencies: 577
-- Name: TABLE sga_requisicao_material; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sga_requisicao_material IS 'Cadastra os itens de uma requisição.';


--
-- TOC entry 12321 (class 0 OID 0)
-- Dependencies: 577
-- Name: COLUMN sga_requisicao_material.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_requisicao_material.id IS 'Identificador sequencial da tabela, chave primaria composta com o campo id_bas_empresa';


--
-- TOC entry 12322 (class 0 OID 0)
-- Dependencies: 577
-- Name: COLUMN sga_requisicao_material.id_bas_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_requisicao_material.id_bas_empresa IS 'Identificador da tabela bas_empresa, chave primaria composta com o campo id';


--
-- TOC entry 12323 (class 0 OID 0)
-- Dependencies: 577
-- Name: COLUMN sga_requisicao_material.id_sga_requisicao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_requisicao_material.id_sga_requisicao IS 'Identificador da tabela sga_requisicao';


--
-- TOC entry 12324 (class 0 OID 0)
-- Dependencies: 577
-- Name: COLUMN sga_requisicao_material.id_sga_almoxarifado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_requisicao_material.id_sga_almoxarifado IS 'Identificador da tabela sga_almoxarifado_material junto com os campos id_bas_empresa e id_sga_material';


--
-- TOC entry 12325 (class 0 OID 0)
-- Dependencies: 577
-- Name: COLUMN sga_requisicao_material.id_sga_material; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_requisicao_material.id_sga_material IS 'Identificador da tabela sga_almoxarifado_material junto com os campos id_bas_empresa e id_sga_almoxarifado';


--
-- TOC entry 12326 (class 0 OID 0)
-- Dependencies: 577
-- Name: COLUMN sga_requisicao_material.quantidade_solicitada; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_requisicao_material.quantidade_solicitada IS 'Quantidade solicitada pelo requisitante';


--
-- TOC entry 12327 (class 0 OID 0)
-- Dependencies: 577
-- Name: COLUMN sga_requisicao_material.quantidade_atendida; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_requisicao_material.quantidade_atendida IS 'Quantidade atendida pelo almoxarife';


--
-- TOC entry 12328 (class 0 OID 0)
-- Dependencies: 577
-- Name: COLUMN sga_requisicao_material.situacao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_requisicao_material.situacao IS 'Situação da requisição (E = Em análise, A = Atendida, N = Negada, P = Atendimento Parcial e C = Atendimento Parcial/Concluída)';


--
-- TOC entry 12329 (class 0 OID 0)
-- Dependencies: 577
-- Name: COLUMN sga_requisicao_material.motivo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_requisicao_material.motivo IS 'Motivo de negação da requisição';


--
-- TOC entry 12330 (class 0 OID 0)
-- Dependencies: 577
-- Name: COLUMN sga_requisicao_material.finalizar_atendimento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_requisicao_material.finalizar_atendimento IS 'S ou N';


--
-- TOC entry 12331 (class 0 OID 0)
-- Dependencies: 577
-- Name: COLUMN sga_requisicao_material.tipo_atendimento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_requisicao_material.tipo_atendimento IS 'AG = Atendimento por grupo
AN = Atendimento normal';


--
-- TOC entry 12332 (class 0 OID 0)
-- Dependencies: 577
-- Name: COLUMN sga_requisicao_material.finalizado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_requisicao_material.finalizado IS 'S ou N';


--
-- TOC entry 12333 (class 0 OID 0)
-- Dependencies: 577
-- Name: COLUMN sga_requisicao_material.quantidade_estoque; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_requisicao_material.quantidade_estoque IS 'Quantidade de estoque no ato da criação do atendimento.Após finalizar o valor real de estoque passa a ser igual a esse, no mesmo lote';


--
-- TOC entry 578 (class 1259 OID 14563869)
-- Name: sga_requisicao_material_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sga_requisicao_material_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sga_requisicao_material_id_seq OWNER TO postgres;

--
-- TOC entry 12334 (class 0 OID 0)
-- Dependencies: 578
-- Name: sga_requisicao_material_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sga_requisicao_material_id_seq OWNED BY public.sga_requisicao_material.id;


--
-- TOC entry 579 (class 1259 OID 14563871)
-- Name: sga_sugestao_compra; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sga_sugestao_compra (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sga_almoxarifado bigint NOT NULL,
 login character varying(32) NOT NULL,
 meses_calculo integer NOT NULL,
 meses_suprir integer NOT NULL,
 data date NOT NULL,
 finalizado character(1) DEFAULT 'N'::bpchar NOT NULL
);


ALTER TABLE public.sga_sugestao_compra OWNER TO postgres;

--
-- TOC entry 12335 (class 0 OID 0)
-- Dependencies: 579
-- Name: TABLE sga_sugestao_compra; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sga_sugestao_compra IS 'Cadastra as sugestões de compra';


--
-- TOC entry 12336 (class 0 OID 0)
-- Dependencies: 579
-- Name: COLUMN sga_sugestao_compra.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_sugestao_compra.id IS 'Identificador sequencial da tabela, chave primaria composta com o campo id_bas_empresa';


--
-- TOC entry 12337 (class 0 OID 0)
-- Dependencies: 579
-- Name: COLUMN sga_sugestao_compra.id_bas_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_sugestao_compra.id_bas_empresa IS 'Identificador da tabela bas_empresa, chave primaria composta com o campo id';


--
-- TOC entry 12338 (class 0 OID 0)
-- Dependencies: 579
-- Name: COLUMN sga_sugestao_compra.id_sga_almoxarifado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_sugestao_compra.id_sga_almoxarifado IS 'Identificador da tabela sga_almoxarifado';


--
-- TOC entry 12339 (class 0 OID 0)
-- Dependencies: 579
-- Name: COLUMN sga_sugestao_compra.login; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_sugestao_compra.login IS 'Identificador da tabela seg_users';


--
-- TOC entry 12340 (class 0 OID 0)
-- Dependencies: 579
-- Name: COLUMN sga_sugestao_compra.meses_calculo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_sugestao_compra.meses_calculo IS 'Quantidade meses utilizados para cálculo da sugestão de compra';


--
-- TOC entry 12341 (class 0 OID 0)
-- Dependencies: 579
-- Name: COLUMN sga_sugestao_compra.meses_suprir; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_sugestao_compra.meses_suprir IS 'Quantidade de meses a suprir com a sugestão de compra';


--
-- TOC entry 12342 (class 0 OID 0)
-- Dependencies: 579
-- Name: COLUMN sga_sugestao_compra.data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_sugestao_compra.data IS 'Data da criação da sugestão de compra';


--
-- TOC entry 12343 (class 0 OID 0)
-- Dependencies: 579
-- Name: COLUMN sga_sugestao_compra.finalizado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_sugestao_compra.finalizado IS 'Indica se o cadastro da Sugestão de compra foi finalizado (S = Sim, N = Não)';


--
-- TOC entry 580 (class 1259 OID 14563875)
-- Name: sga_sugestao_compra_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sga_sugestao_compra_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sga_sugestao_compra_id_seq OWNER TO postgres;

--
-- TOC entry 12344 (class 0 OID 0)
-- Dependencies: 580
-- Name: sga_sugestao_compra_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sga_sugestao_compra_id_seq OWNED BY public.sga_sugestao_compra.id;


--
-- TOC entry 581 (class 1259 OID 14563877)
-- Name: sga_sugestao_compra_material_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sga_sugestao_compra_material_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sga_sugestao_compra_material_id_seq OWNER TO postgres;

--
-- TOC entry 582 (class 1259 OID 14563879)
-- Name: sga_sugestao_compra_material; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sga_sugestao_compra_material (
 id bigint DEFAULT nextval('public.sga_sugestao_compra_material_id_seq'::regclass) NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sga_sugestao_compra bigint NOT NULL,
 id_sga_almoxarifado bigint NOT NULL,
 id_sga_material bigint NOT NULL,
 quantidade_sugerida numeric(9,2) NOT NULL,
 media_consumo numeric(9,2) NOT NULL
);


ALTER TABLE public.sga_sugestao_compra_material OWNER TO postgres;

--
-- TOC entry 12345 (class 0 OID 0)
-- Dependencies: 582
-- Name: TABLE sga_sugestao_compra_material; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sga_sugestao_compra_material IS 'Cadastra os itens da sugestão de compra';


--
-- TOC entry 12346 (class 0 OID 0)
-- Dependencies: 582
-- Name: COLUMN sga_sugestao_compra_material.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_sugestao_compra_material.id IS 'Identificador sequencial da tabela, chave primaria composta com o campo id_bas_empresa';


--
-- TOC entry 12347 (class 0 OID 0)
-- Dependencies: 582
-- Name: COLUMN sga_sugestao_compra_material.id_bas_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_sugestao_compra_material.id_bas_empresa IS 'Identificador da tabela bas_empresa, chave primaria composta com o campo id';


--
-- TOC entry 12348 (class 0 OID 0)
-- Dependencies: 582
-- Name: COLUMN sga_sugestao_compra_material.id_sga_sugestao_compra; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_sugestao_compra_material.id_sga_sugestao_compra IS 'Identificador da tabela sga_sugestao_compra';


--
-- TOC entry 12349 (class 0 OID 0)
-- Dependencies: 582
-- Name: COLUMN sga_sugestao_compra_material.id_sga_almoxarifado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_sugestao_compra_material.id_sga_almoxarifado IS 'Identificador da tabela sga_almoxarifado_material junto ao campo id_sga_material';


--
-- TOC entry 12350 (class 0 OID 0)
-- Dependencies: 582
-- Name: COLUMN sga_sugestao_compra_material.id_sga_material; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_sugestao_compra_material.id_sga_material IS 'Identificador da tabela sga_almoxarifado_material junto ao campo id_sga_almoxarifado';


--
-- TOC entry 12351 (class 0 OID 0)
-- Dependencies: 582
-- Name: COLUMN sga_sugestao_compra_material.quantidade_sugerida; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_sugestao_compra_material.quantidade_sugerida IS 'Quantidade sugerida para compra do material';


--
-- TOC entry 12352 (class 0 OID 0)
-- Dependencies: 582
-- Name: COLUMN sga_sugestao_compra_material.media_consumo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_sugestao_compra_material.media_consumo IS 'Média de consumo';


--
-- TOC entry 583 (class 1259 OID 14563883)
-- Name: sga_transferencia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sga_transferencia (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sga_almoxarifado_origem bigint NOT NULL,
 id_sga_almoxarifado_destino bigint NOT NULL,
 id_bas_colaborador bigint,
 data date NOT NULL,
 finalizado character(1) DEFAULT 'N'::bpchar NOT NULL,
 numero_transferencia character varying(5),
 status_recebimento character(1),
 usuario character varying(100),
 observacao character varying(300),
 id_sga_requisicao bigint
);


ALTER TABLE public.sga_transferencia OWNER TO postgres;

--
-- TOC entry 12353 (class 0 OID 0)
-- Dependencies: 583
-- Name: TABLE sga_transferencia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sga_transferencia IS 'Cadastra as transferências entre almoxarifados';


--
-- TOC entry 12354 (class 0 OID 0)
-- Dependencies: 583
-- Name: COLUMN sga_transferencia.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_transferencia.id IS 'Identificador sequencial da tabela, chave primaria composta com o campo id_bas_empresa';


--
-- TOC entry 12355 (class 0 OID 0)
-- Dependencies: 583
-- Name: COLUMN sga_transferencia.id_bas_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_transferencia.id_bas_empresa IS 'Identificador da tabela bas_empresa, chave primaria composta com o campo id';


--
-- TOC entry 12356 (class 0 OID 0)
-- Dependencies: 583
-- Name: COLUMN sga_transferencia.id_sga_almoxarifado_origem; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_transferencia.id_sga_almoxarifado_origem IS 'Identificador da tabela sga_almoxarifado do almoxarifado de origem';


--
-- TOC entry 12357 (class 0 OID 0)
-- Dependencies: 583
-- Name: COLUMN sga_transferencia.id_sga_almoxarifado_destino; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_transferencia.id_sga_almoxarifado_destino IS 'Identificador da tabela sga_almoxarifado do almoxarifado de destino';


--
-- TOC entry 12358 (class 0 OID 0)
-- Dependencies: 583
-- Name: COLUMN sga_transferencia.id_bas_colaborador; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_transferencia.id_bas_colaborador IS 'Identificador da tabela bas_colaborador, funcionário requisitante';


--
-- TOC entry 12359 (class 0 OID 0)
-- Dependencies: 583
-- Name: COLUMN sga_transferencia.data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_transferencia.data IS 'Data da requisição';


--
-- TOC entry 12360 (class 0 OID 0)
-- Dependencies: 583
-- Name: COLUMN sga_transferencia.finalizado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_transferencia.finalizado IS 'Indica se o cadastro da transferência foi finalizado (S = Sim, N = Não)';


--
-- TOC entry 12361 (class 0 OID 0)
-- Dependencies: 583
-- Name: COLUMN sga_transferencia.status_recebimento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_transferencia.status_recebimento IS 'Após a finalização somente o almxarifado destino deve manipular';


--
-- TOC entry 12362 (class 0 OID 0)
-- Dependencies: 583
-- Name: COLUMN sga_transferencia.observacao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_transferencia.observacao IS 'Campo usado para que o usuario digite o motivo da transferencia';


--
-- TOC entry 12363 (class 0 OID 0)
-- Dependencies: 583
-- Name: COLUMN sga_transferencia.id_sga_requisicao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_transferencia.id_sga_requisicao IS 'Identificador da tabela sga_requisicao, chave primaria da requisicao';


--
-- TOC entry 584 (class 1259 OID 14563887)
-- Name: sga_transferencia_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sga_transferencia_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sga_transferencia_id_seq OWNER TO postgres;

--
-- TOC entry 12364 (class 0 OID 0)
-- Dependencies: 584
-- Name: sga_transferencia_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sga_transferencia_id_seq OWNED BY public.sga_transferencia.id;


--
-- TOC entry 585 (class 1259 OID 14563889)
-- Name: sga_transferencia_material; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sga_transferencia_material (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sga_transferencia bigint NOT NULL,
 id_sga_material bigint NOT NULL,
 quantidade numeric(9,2) NOT NULL,
 confirmado character(1) DEFAULT 'N'::bpchar NOT NULL,
 finalizado character(1),
 lote character(15),
 validade date,
 valor_unitario numeric(9,2),
 valor_total numeric(9,2),
 id_sga_entrada_material bigint,
 quantidade_atendida numeric(9,2)
);


ALTER TABLE public.sga_transferencia_material OWNER TO postgres;

--
-- TOC entry 12365 (class 0 OID 0)
-- Dependencies: 585
-- Name: COLUMN sga_transferencia_material.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_transferencia_material.id IS 'Identificador sequencial da tabela, chave primaria composta com o campo id_bas_empresa';


--
-- TOC entry 12366 (class 0 OID 0)
-- Dependencies: 585
-- Name: COLUMN sga_transferencia_material.id_bas_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_transferencia_material.id_bas_empresa IS 'Identificador da tabela bas_empresa, chave primaria composta com o campo id';


--
-- TOC entry 12367 (class 0 OID 0)
-- Dependencies: 585
-- Name: COLUMN sga_transferencia_material.id_sga_transferencia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_transferencia_material.id_sga_transferencia IS 'Identificador da tabela sga_transferencia';


--
-- TOC entry 12368 (class 0 OID 0)
-- Dependencies: 585
-- Name: COLUMN sga_transferencia_material.id_sga_material; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_transferencia_material.id_sga_material IS 'Identificador da tabela sga_material';


--
-- TOC entry 12369 (class 0 OID 0)
-- Dependencies: 585
-- Name: COLUMN sga_transferencia_material.quantidade; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_transferencia_material.quantidade IS 'Quantidade transferida';


--
-- TOC entry 12370 (class 0 OID 0)
-- Dependencies: 585
-- Name: COLUMN sga_transferencia_material.confirmado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_transferencia_material.confirmado IS 'Indica se o recebimento do material transferido foi confirmado pelo almoxarifado de destino(S = Sim, N = Não)';


--
-- TOC entry 12371 (class 0 OID 0)
-- Dependencies: 585
-- Name: COLUMN sga_transferencia_material.finalizado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_transferencia_material.finalizado IS 'F - Informa se a transferencia foi finalizada.
E - Informa que esta em andamento de transferencia.
R - Informa que foi recebido.';


--
-- TOC entry 12372 (class 0 OID 0)
-- Dependencies: 585
-- Name: COLUMN sga_transferencia_material.id_sga_entrada_material; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_transferencia_material.id_sga_entrada_material IS 'Relaciona a transferencia a uma entrada';


--
-- TOC entry 12373 (class 0 OID 0)
-- Dependencies: 585
-- Name: COLUMN sga_transferencia_material.quantidade_atendida; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_transferencia_material.quantidade_atendida IS 'Quantidade atendida na entrada';


--
-- TOC entry 586 (class 1259 OID 14563893)
-- Name: sga_transferencia_material_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sga_transferencia_material_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sga_transferencia_material_id_seq OWNER TO postgres;

--
-- TOC entry 12374 (class 0 OID 0)
-- Dependencies: 586
-- Name: sga_transferencia_material_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sga_transferencia_material_id_seq OWNED BY public.sga_transferencia_material.id;


--
-- TOC entry 587 (class 1259 OID 14563895)
-- Name: sga_unidade_medida; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sga_unidade_medida (
 id bigint NOT NULL,
 nome character varying(100) NOT NULL,
 sigla character varying(8) NOT NULL,
 fracao character(1) NOT NULL
);


ALTER TABLE public.sga_unidade_medida OWNER TO postgres;

--
-- TOC entry 12375 (class 0 OID 0)
-- Dependencies: 587
-- Name: COLUMN sga_unidade_medida.fracao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_unidade_medida.fracao IS 'S = Sim, N = Não';


--
-- TOC entry 588 (class 1259 OID 14563898)
-- Name: sga_unidade_medida_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sga_unidade_medida_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sga_unidade_medida_id_seq OWNER TO postgres;

--
-- TOC entry 12376 (class 0 OID 0)
-- Dependencies: 588
-- Name: sga_unidade_medida_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sga_unidade_medida_id_seq OWNED BY public.sga_unidade_medida.id;


SET default_with_oids = true;

--
-- TOC entry 589 (class 1259 OID 14563900)
-- Name: sga_venda; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sga_venda (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_pessoa bigint NOT NULL,
 login character varying(32) NOT NULL,
 data date NOT NULL,
 parcelas smallint,
 vencimento date,
 valor numeric(9,2),
 finalizado character(1) DEFAULT 'N'::bpchar NOT NULL
);


ALTER TABLE public.sga_venda OWNER TO postgres;

--
-- TOC entry 12377 (class 0 OID 0)
-- Dependencies: 589
-- Name: TABLE sga_venda; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sga_venda IS 'Cadastra as informações referentes a uma venda';


--
-- TOC entry 12378 (class 0 OID 0)
-- Dependencies: 589
-- Name: COLUMN sga_venda.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_venda.id IS 'Identificador sequencial da tabela, chave primaria composta com o campo id_bas_empresa';


--
-- TOC entry 12379 (class 0 OID 0)
-- Dependencies: 589
-- Name: COLUMN sga_venda.id_bas_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_venda.id_bas_empresa IS 'Identificador da tabela bas_empresa, chave primaria composta com o campo id';


--
-- TOC entry 12380 (class 0 OID 0)
-- Dependencies: 589
-- Name: COLUMN sga_venda.id_bas_pessoa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_venda.id_bas_pessoa IS 'Identificador da tabela bas_pessoa para definir o cliente da venda';


--
-- TOC entry 12381 (class 0 OID 0)
-- Dependencies: 589
-- Name: COLUMN sga_venda.login; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_venda.login IS 'Identificador da tabela seg_users, usuário que registrou a venda';


--
-- TOC entry 12382 (class 0 OID 0)
-- Dependencies: 589
-- Name: COLUMN sga_venda.data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_venda.data IS 'Data da venda';


--
-- TOC entry 12383 (class 0 OID 0)
-- Dependencies: 589
-- Name: COLUMN sga_venda.parcelas; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_venda.parcelas IS 'Número de parcelas';


--
-- TOC entry 12384 (class 0 OID 0)
-- Dependencies: 589
-- Name: COLUMN sga_venda.vencimento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_venda.vencimento IS 'data de vencimento da primeira parcela';


--
-- TOC entry 12385 (class 0 OID 0)
-- Dependencies: 589
-- Name: COLUMN sga_venda.valor; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_venda.valor IS 'Total da venda';


--
-- TOC entry 12386 (class 0 OID 0)
-- Dependencies: 589
-- Name: COLUMN sga_venda.finalizado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_venda.finalizado IS 'Indica se o cadastro da venda foi finalizado (S = Sim, N = Não)';


--
-- TOC entry 590 (class 1259 OID 14563904)
-- Name: sga_venda_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sga_venda_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sga_venda_id_seq OWNER TO postgres;

--
-- TOC entry 12387 (class 0 OID 0)
-- Dependencies: 590
-- Name: sga_venda_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sga_venda_id_seq OWNED BY public.sga_venda.id;


--
-- TOC entry 591 (class 1259 OID 14563906)
-- Name: sga_venda_material; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sga_venda_material (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sga_almoxarifado bigint NOT NULL,
 id_sga_material bigint NOT NULL,
 id_sga_venda bigint NOT NULL,
 quantidade numeric(9,2) NOT NULL,
 valor numeric(9,2) NOT NULL,
 total numeric(9,2) NOT NULL,
 desconto numeric(9,2) DEFAULT 0 NOT NULL
);


ALTER TABLE public.sga_venda_material OWNER TO postgres;

--
-- TOC entry 12388 (class 0 OID 0)
-- Dependencies: 591
-- Name: TABLE sga_venda_material; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sga_venda_material IS 'Cadastra os itens de uma venda';


--
-- TOC entry 12389 (class 0 OID 0)
-- Dependencies: 591
-- Name: COLUMN sga_venda_material.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_venda_material.id IS 'Identificador sequencial da tabela, chave primaria composta com o campo id_bas_empresa';


--
-- TOC entry 12390 (class 0 OID 0)
-- Dependencies: 591
-- Name: COLUMN sga_venda_material.id_bas_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_venda_material.id_bas_empresa IS 'Identificador da tabela bas_empresa, chave primaria composta com o campo id';


--
-- TOC entry 12391 (class 0 OID 0)
-- Dependencies: 591
-- Name: COLUMN sga_venda_material.id_sga_almoxarifado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_venda_material.id_sga_almoxarifado IS 'Identificador da tabela sga_almoxarifado_material junto aos campos id_bas_empresa e id_sga_material';


--
-- TOC entry 12392 (class 0 OID 0)
-- Dependencies: 591
-- Name: COLUMN sga_venda_material.id_sga_material; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_venda_material.id_sga_material IS 'Identificador da tabela sga_almoxarifado_material junto aos campos id_bas_empresa e id_sga_almoxarifado';


--
-- TOC entry 12393 (class 0 OID 0)
-- Dependencies: 591
-- Name: COLUMN sga_venda_material.id_sga_venda; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_venda_material.id_sga_venda IS 'Identificador da tabela sga_venda';


--
-- TOC entry 12394 (class 0 OID 0)
-- Dependencies: 591
-- Name: COLUMN sga_venda_material.quantidade; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_venda_material.quantidade IS 'Quantidade do material vendido';


--
-- TOC entry 12395 (class 0 OID 0)
-- Dependencies: 591
-- Name: COLUMN sga_venda_material.valor; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_venda_material.valor IS 'Valor unitário do material';


--
-- TOC entry 12396 (class 0 OID 0)
-- Dependencies: 591
-- Name: COLUMN sga_venda_material.total; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_venda_material.total IS 'Valor total do material';


--
-- TOC entry 12397 (class 0 OID 0)
-- Dependencies: 591
-- Name: COLUMN sga_venda_material.desconto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sga_venda_material.desconto IS 'Desconto no valor do material';


--
-- TOC entry 592 (class 1259 OID 14563910)
-- Name: sga_venda_material_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sga_venda_material_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sga_venda_material_id_seq OWNER TO postgres;

--
-- TOC entry 12398 (class 0 OID 0)
-- Dependencies: 592
-- Name: sga_venda_material_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sga_venda_material_id_seq OWNED BY public.sga_venda_material.id;


SET default_with_oids = false;

--
-- TOC entry 593 (class 1259 OID 14563912)
-- Name: sgb_assunto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgb_assunto (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 descricao character varying(100) NOT NULL
);


ALTER TABLE public.sgb_assunto OWNER TO postgres;

--
-- TOC entry 594 (class 1259 OID 14563915)
-- Name: sgb_assunto_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgb_assunto_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgb_assunto_id_seq OWNER TO postgres;

--
-- TOC entry 12399 (class 0 OID 0)
-- Dependencies: 594
-- Name: sgb_assunto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgb_assunto_id_seq OWNED BY public.sgb_assunto.id;


--
-- TOC entry 595 (class 1259 OID 14563917)
-- Name: sgb_autor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgb_autor (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(100) NOT NULL,
 data_nascimento date,
 data_falecimento date,
 nacionalidade character(1)
);


ALTER TABLE public.sgb_autor OWNER TO postgres;

--
-- TOC entry 596 (class 1259 OID 14563920)
-- Name: sgb_autor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgb_autor_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgb_autor_id_seq OWNER TO postgres;

--
-- TOC entry 12400 (class 0 OID 0)
-- Dependencies: 596
-- Name: sgb_autor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgb_autor_id_seq OWNED BY public.sgb_autor.id;


--
-- TOC entry 597 (class 1259 OID 14563922)
-- Name: sgb_autor_livro; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgb_autor_livro (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sgb_autor bigint NOT NULL,
 id_sgb_livro bigint NOT NULL,
 link character varying(250)
);


ALTER TABLE public.sgb_autor_livro OWNER TO postgres;

--
-- TOC entry 598 (class 1259 OID 14563925)
-- Name: sgb_autor_livro_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgb_autor_livro_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgb_autor_livro_id_seq OWNER TO postgres;

--
-- TOC entry 12401 (class 0 OID 0)
-- Dependencies: 598
-- Name: sgb_autor_livro_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgb_autor_livro_id_seq OWNED BY public.sgb_autor_livro.id;


--
-- TOC entry 599 (class 1259 OID 14563927)
-- Name: sgb_biblioteca; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgb_biblioteca (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_estabelecimento bigint,
 nome character varying(100) NOT NULL
);


ALTER TABLE public.sgb_biblioteca OWNER TO postgres;

--
-- TOC entry 600 (class 1259 OID 14563930)
-- Name: sgb_biblioteca_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgb_biblioteca_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgb_biblioteca_id_seq OWNER TO postgres;

--
-- TOC entry 12402 (class 0 OID 0)
-- Dependencies: 600
-- Name: sgb_biblioteca_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgb_biblioteca_id_seq OWNED BY public.sgb_biblioteca.id;


--
-- TOC entry 601 (class 1259 OID 14563932)
-- Name: sgb_bloqueio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgb_bloqueio (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sgb_leitor bigint NOT NULL,
 data_inicio date NOT NULL,
 data_fim timestamp(0) without time zone,
 motivo character varying(200)
);


ALTER TABLE public.sgb_bloqueio OWNER TO postgres;

--
-- TOC entry 602 (class 1259 OID 14563935)
-- Name: sgb_bloqueio_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgb_bloqueio_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgb_bloqueio_id_seq OWNER TO postgres;

--
-- TOC entry 12403 (class 0 OID 0)
-- Dependencies: 602
-- Name: sgb_bloqueio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgb_bloqueio_id_seq OWNED BY public.sgb_bloqueio.id;


--
-- TOC entry 603 (class 1259 OID 14563937)
-- Name: sgb_cdd; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgb_cdd (
 id bigint NOT NULL,
 codigo character varying(30) NOT NULL,
 descricao character varying(50)
);


ALTER TABLE public.sgb_cdd OWNER TO postgres;

--
-- TOC entry 604 (class 1259 OID 14563940)
-- Name: sgb_cdd_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgb_cdd_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgb_cdd_id_seq OWNER TO postgres;

--
-- TOC entry 12404 (class 0 OID 0)
-- Dependencies: 604
-- Name: sgb_cdd_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgb_cdd_id_seq OWNED BY public.sgb_cdd.id;


--
-- TOC entry 605 (class 1259 OID 14563942)
-- Name: sgb_cdu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgb_cdu (
 id bigint NOT NULL,
 numero character varying(30) NOT NULL,
 descricao text,
 id_sgb_cdu_classificacao bigint
);


ALTER TABLE public.sgb_cdu OWNER TO postgres;

--
-- TOC entry 606 (class 1259 OID 14563948)
-- Name: sgb_cdu_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgb_cdu_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgb_cdu_id_seq OWNER TO postgres;

--
-- TOC entry 12405 (class 0 OID 0)
-- Dependencies: 606
-- Name: sgb_cdu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgb_cdu_id_seq OWNED BY public.sgb_cdu.id;


SET default_with_oids = true;

--
-- TOC entry 607 (class 1259 OID 14563950)
-- Name: sgb_classificacao_literaria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgb_classificacao_literaria (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 descricao character varying(100) NOT NULL
);


ALTER TABLE public.sgb_classificacao_literaria OWNER TO postgres;

--
-- TOC entry 608 (class 1259 OID 14563953)
-- Name: sgb_classificacao_literaria_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgb_classificacao_literaria_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgb_classificacao_literaria_id_seq OWNER TO postgres;

--
-- TOC entry 12406 (class 0 OID 0)
-- Dependencies: 608
-- Name: sgb_classificacao_literaria_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgb_classificacao_literaria_id_seq OWNED BY public.sgb_classificacao_literaria.id;


SET default_with_oids = false;

--
-- TOC entry 609 (class 1259 OID 14563955)
-- Name: sgb_colecao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgb_colecao (
 id bigint NOT NULL,
 nome character varying(50) NOT NULL
);


ALTER TABLE public.sgb_colecao OWNER TO postgres;

--
-- TOC entry 610 (class 1259 OID 14563958)
-- Name: sgb_colecao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgb_colecao_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgb_colecao_id_seq OWNER TO postgres;

--
-- TOC entry 12407 (class 0 OID 0)
-- Dependencies: 610
-- Name: sgb_colecao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgb_colecao_id_seq OWNED BY public.sgb_colecao.id;


--
-- TOC entry 611 (class 1259 OID 14563960)
-- Name: sgb_configuracao_etiqueta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgb_configuracao_etiqueta (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_estabelecimento bigint NOT NULL,
 cdd character(1) DEFAULT 'N'::bpchar,
 pha character(1) DEFAULT 'N'::bpchar,
 numero_exemplar character(1) DEFAULT 'N'::bpchar,
 letra_livro character(1) DEFAULT 'N'::bpchar,
 tombo character(1) DEFAULT 'N'::bpchar,
 ano character(1) DEFAULT 'N'::bpchar,
 isbn character(1) DEFAULT 'N'::bpchar
);


ALTER TABLE public.sgb_configuracao_etiqueta OWNER TO postgres;

--
-- TOC entry 12408 (class 0 OID 0)
-- Dependencies: 611
-- Name: COLUMN sgb_configuracao_etiqueta.cdd; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgb_configuracao_etiqueta.cdd IS 'S = Sim 
N = Não';


--
-- TOC entry 12409 (class 0 OID 0)
-- Dependencies: 611
-- Name: COLUMN sgb_configuracao_etiqueta.pha; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgb_configuracao_etiqueta.pha IS 'S = Sim 
N = Não';


--
-- TOC entry 12410 (class 0 OID 0)
-- Dependencies: 611
-- Name: COLUMN sgb_configuracao_etiqueta.numero_exemplar; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgb_configuracao_etiqueta.numero_exemplar IS 'S = Sim 
N = Não';


--
-- TOC entry 12411 (class 0 OID 0)
-- Dependencies: 611
-- Name: COLUMN sgb_configuracao_etiqueta.letra_livro; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgb_configuracao_etiqueta.letra_livro IS 'I = Inicial 
F = Final 
N = Nenhuma';


--
-- TOC entry 12412 (class 0 OID 0)
-- Dependencies: 611
-- Name: COLUMN sgb_configuracao_etiqueta.tombo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgb_configuracao_etiqueta.tombo IS 'S = Sim 
N = Não';


--
-- TOC entry 12413 (class 0 OID 0)
-- Dependencies: 611
-- Name: COLUMN sgb_configuracao_etiqueta.ano; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgb_configuracao_etiqueta.ano IS 'S = Sim 
N = Não';


--
-- TOC entry 12414 (class 0 OID 0)
-- Dependencies: 611
-- Name: COLUMN sgb_configuracao_etiqueta.isbn; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgb_configuracao_etiqueta.isbn IS 'S = Sim 
N = Não';


--
-- TOC entry 612 (class 1259 OID 14563970)
-- Name: sgb_configuracao_etiqueta_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgb_configuracao_etiqueta_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgb_configuracao_etiqueta_id_seq OWNER TO postgres;

--
-- TOC entry 12415 (class 0 OID 0)
-- Dependencies: 612
-- Name: sgb_configuracao_etiqueta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgb_configuracao_etiqueta_id_seq OWNED BY public.sgb_configuracao_etiqueta.id;


--
-- TOC entry 613 (class 1259 OID 14563972)
-- Name: sgb_corredor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgb_corredor (
 id bigint NOT NULL,
 nome character varying NOT NULL
);


ALTER TABLE public.sgb_corredor OWNER TO postgres;

--
-- TOC entry 614 (class 1259 OID 14563978)
-- Name: sgb_corredor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgb_corredor_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgb_corredor_id_seq OWNER TO postgres;

--
-- TOC entry 12416 (class 0 OID 0)
-- Dependencies: 614
-- Name: sgb_corredor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgb_corredor_id_seq OWNED BY public.sgb_corredor.id;


--
-- TOC entry 615 (class 1259 OID 14563980)
-- Name: sgb_cutter; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgb_cutter (
 id bigint NOT NULL,
 nome character varying NOT NULL
);


ALTER TABLE public.sgb_cutter OWNER TO postgres;

--
-- TOC entry 616 (class 1259 OID 14563986)
-- Name: sgb_cutter_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgb_cutter_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgb_cutter_id_seq OWNER TO postgres;

--
-- TOC entry 12417 (class 0 OID 0)
-- Dependencies: 616
-- Name: sgb_cutter_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgb_cutter_id_seq OWNED BY public.sgb_cutter.id;


SET default_with_oids = true;

--
-- TOC entry 617 (class 1259 OID 14563988)
-- Name: sgb_editora; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgb_editora (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(100) NOT NULL
);


ALTER TABLE public.sgb_editora OWNER TO postgres;

--
-- TOC entry 618 (class 1259 OID 14563991)
-- Name: sgb_editora_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgb_editora_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgb_editora_id_seq OWNER TO postgres;

--
-- TOC entry 12418 (class 0 OID 0)
-- Dependencies: 618
-- Name: sgb_editora_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgb_editora_id_seq OWNED BY public.sgb_editora.id;


--
-- TOC entry 619 (class 1259 OID 14563993)
-- Name: sgb_emprestimo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgb_emprestimo (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_estabelecimento bigint,
 id_sgb_exemplar bigint,
 id_sgb_leitor bigint,
 login_emprestimo character varying(32) NOT NULL,
 data_emprestimo date NOT NULL,
 doacao character(1),
 data_previsao_devolucao date,
 login_devolucao character varying(32),
 data_devolucao date,
 finalizado character(1) DEFAULT 'N'::bpchar NOT NULL
);


ALTER TABLE public.sgb_emprestimo OWNER TO postgres;

--
-- TOC entry 12419 (class 0 OID 0)
-- Dependencies: 619
-- Name: COLUMN sgb_emprestimo.doacao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgb_emprestimo.doacao IS 'S="Sim", N= "Não"';


--
-- TOC entry 12420 (class 0 OID 0)
-- Dependencies: 619
-- Name: COLUMN sgb_emprestimo.finalizado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgb_emprestimo.finalizado IS 'S = Sim, N = Não';


--
-- TOC entry 620 (class 1259 OID 14563997)
-- Name: sgb_emprestimo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgb_emprestimo_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgb_emprestimo_id_seq OWNER TO postgres;

--
-- TOC entry 12421 (class 0 OID 0)
-- Dependencies: 620
-- Name: sgb_emprestimo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgb_emprestimo_id_seq OWNED BY public.sgb_emprestimo.id;


SET default_with_oids = false;

--
-- TOC entry 621 (class 1259 OID 14563999)
-- Name: sgb_estante; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgb_estante (
 id bigint NOT NULL,
 nome character varying NOT NULL
);


ALTER TABLE public.sgb_estante OWNER TO postgres;

--
-- TOC entry 622 (class 1259 OID 14564005)
-- Name: sgb_estante_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgb_estante_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgb_estante_id_seq OWNER TO postgres;

--
-- TOC entry 12422 (class 0 OID 0)
-- Dependencies: 622
-- Name: sgb_estante_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgb_estante_id_seq OWNED BY public.sgb_estante.id;


--
-- TOC entry 623 (class 1259 OID 14564007)
-- Name: sgb_etiqueta_formato; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgb_etiqueta_formato (
 id bigint NOT NULL,
 codigo_pimaco character varying NOT NULL,
 altura_pagina double precision NOT NULL,
 largura_pagina double precision NOT NULL,
 margem_superior double precision NOT NULL,
 margem_lateral double precision NOT NULL,
 densidade_vertical double precision,
 densidade_horizontal double precision,
 altura_etiqueta double precision NOT NULL,
 largura_etiqueta double precision NOT NULL,
 etiqueta_linha numeric NOT NULL,
 linha_pagina numeric NOT NULL
);


ALTER TABLE public.sgb_etiqueta_formato OWNER TO postgres;

--
-- TOC entry 624 (class 1259 OID 14564013)
-- Name: sgb_etiqueta_formato_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgb_etiqueta_formato_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgb_etiqueta_formato_id_seq OWNER TO postgres;

--
-- TOC entry 12423 (class 0 OID 0)
-- Dependencies: 624
-- Name: sgb_etiqueta_formato_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgb_etiqueta_formato_id_seq OWNED BY public.sgb_etiqueta_formato.id;


SET default_with_oids = true;

--
-- TOC entry 625 (class 1259 OID 14564015)
-- Name: sgb_exemplar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgb_exemplar (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_estabelecimento bigint,
 id_sgb_livro bigint,
 data_aquisicao date,
 consulta character(1),
 etiqueta character varying(50) NOT NULL,
 data_baixa date,
 login_baixa character varying(32),
 id_sgb_motivo_baixa bigint,
 isbn character varying(20),
 estante character varying(20),
 prateleira character varying(20),
 corredor character varying(20),
 doacao character(1),
 numero_exemplar integer,
 ano integer,
 id_sgb_estante bigint,
 id_sgb_corredor bigint,
 id_sgb_prateleira bigint,
 id_sgb_biblioteca bigint,
 id_sgb_cdu bigint,
 tombo character varying(30),
 id_bas_idioma bigint,
 id_sgb_editora bigint,
 paginas smallint,
 codigo character varying(30),
 edicao character varying(30)
);


ALTER TABLE public.sgb_exemplar OWNER TO postgres;

--
-- TOC entry 12424 (class 0 OID 0)
-- Dependencies: 625
-- Name: COLUMN sgb_exemplar.consulta; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgb_exemplar.consulta IS 'S=Sim, N=Não';


--
-- TOC entry 12425 (class 0 OID 0)
-- Dependencies: 625
-- Name: COLUMN sgb_exemplar.doacao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgb_exemplar.doacao IS 'S="Sim",N="Não"';


--
-- TOC entry 626 (class 1259 OID 14564018)
-- Name: sgb_exemplar_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgb_exemplar_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgb_exemplar_id_seq OWNER TO postgres;

--
-- TOC entry 12426 (class 0 OID 0)
-- Dependencies: 626
-- Name: sgb_exemplar_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgb_exemplar_id_seq OWNED BY public.sgb_exemplar.id;


SET default_with_oids = false;

--
-- TOC entry 627 (class 1259 OID 14564020)
-- Name: sgb_leitor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgb_leitor (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sgb_tipo_leitor bigint NOT NULL,
 id_bas_estabelecimento bigint NOT NULL,
 id_bas_pessoa bigint NOT NULL,
 data_inicio date NOT NULL,
 data_fim date,
 fim_motivo character varying(70),
 matricula character varying(20),
 validade_reserva smallint
);


ALTER TABLE public.sgb_leitor OWNER TO postgres;

--
-- TOC entry 628 (class 1259 OID 14564023)
-- Name: sgb_leitor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgb_leitor_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgb_leitor_id_seq OWNER TO postgres;

--
-- TOC entry 12427 (class 0 OID 0)
-- Dependencies: 628
-- Name: sgb_leitor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgb_leitor_id_seq OWNED BY public.sgb_leitor.id;


SET default_with_oids = true;

--
-- TOC entry 629 (class 1259 OID 14564025)
-- Name: sgb_livro; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgb_livro (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 titulo character varying(100) NOT NULL,
 subtitulo character varying(100),
 id_sgb_editora bigint NOT NULL,
 id_sgb_classificacao_literaria bigint,
 cdu character varying(20),
 volume integer,
 id_sgb_assunto bigint,
 imagem text,
 palavras_chave character varying(200),
 sinopse text,
 id_sgb_colecao bigint,
 id_bas_area_conhecimento bigint,
 id_sgb_cdu bigint,
 id_sgb_cdd bigint,
 id_sgb_pha bigint,
 id_sgb_cutter bigint,
 id_sgb_tipo_obra_especificacao bigint,
 id_bas_idioma bigint,
 tipo_obra character(1),
 id_sgb_biblioteca bigint,
 periodicidade character(2),
 id_bas_area_conhecimento_especifico bigint,
 local_publicacao character varying(50),
 estudio character varying(50),
 outros_titulos character varying(100),
 id_bas_estabelecimento bigint,
 ano smallint
);


ALTER TABLE public.sgb_livro OWNER TO postgres;

--
-- TOC entry 12428 (class 0 OID 0)
-- Dependencies: 629
-- Name: COLUMN sgb_livro.imagem; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgb_livro.imagem IS 'Foto da capa do livro';


--
-- TOC entry 630 (class 1259 OID 14564031)
-- Name: sgb_livro_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgb_livro_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgb_livro_id_seq OWNER TO postgres;

--
-- TOC entry 12429 (class 0 OID 0)
-- Dependencies: 630
-- Name: sgb_livro_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgb_livro_id_seq OWNED BY public.sgb_livro.id;


SET default_with_oids = false;

--
-- TOC entry 631 (class 1259 OID 14564033)
-- Name: sgb_log_migrador_acervo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgb_log_migrador_acervo (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome_campo character varying(150) NOT NULL,
 status character(1) NOT NULL,
 observacao text NOT NULL,
 data_cadastro timestamp(0) without time zone DEFAULT now()
);
ALTER TABLE ONLY public.sgb_log_migrador_acervo ALTER COLUMN id_bas_empresa SET STATISTICS 0;


ALTER TABLE public.sgb_log_migrador_acervo OWNER TO postgres;

--
-- TOC entry 12430 (class 0 OID 0)
-- Dependencies: 631
-- Name: COLUMN sgb_log_migrador_acervo.status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgb_log_migrador_acervo.status IS 'M = Migrado, P = Migrado Parcialmente, N = Não Migrado';


--
-- TOC entry 632 (class 1259 OID 14564040)
-- Name: sgb_log_migrador_acervo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgb_log_migrador_acervo_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgb_log_migrador_acervo_id_seq OWNER TO postgres;

--
-- TOC entry 12431 (class 0 OID 0)
-- Dependencies: 632
-- Name: sgb_log_migrador_acervo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgb_log_migrador_acervo_id_seq OWNED BY public.sgb_log_migrador_acervo.id;


SET default_with_oids = true;

--
-- TOC entry 633 (class 1259 OID 14564042)
-- Name: sgb_motivo_baixa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgb_motivo_baixa (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 descricao character varying(100) NOT NULL
);


ALTER TABLE public.sgb_motivo_baixa OWNER TO postgres;

--
-- TOC entry 634 (class 1259 OID 14564045)
-- Name: sgb_motivo_baixa_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgb_motivo_baixa_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgb_motivo_baixa_id_seq OWNER TO postgres;

--
-- TOC entry 12432 (class 0 OID 0)
-- Dependencies: 634
-- Name: sgb_motivo_baixa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgb_motivo_baixa_id_seq OWNED BY public.sgb_motivo_baixa.id;


SET default_with_oids = false;

--
-- TOC entry 635 (class 1259 OID 14564047)
-- Name: sgb_tipo_obra_especificacao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgb_tipo_obra_especificacao (
 id bigint NOT NULL,
 tipo_obra character(1) NOT NULL,
 nome character varying(50) NOT NULL
);


ALTER TABLE public.sgb_tipo_obra_especificacao OWNER TO postgres;

--
-- TOC entry 12433 (class 0 OID 0)
-- Dependencies: 635
-- Name: COLUMN sgb_tipo_obra_especificacao.tipo_obra; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgb_tipo_obra_especificacao.tipo_obra IS 'L=Livro, M=Mídia, P=Periódico';


--
-- TOC entry 636 (class 1259 OID 14564050)
-- Name: sgb_obra_tipo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgb_obra_tipo_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgb_obra_tipo_id_seq OWNER TO postgres;

--
-- TOC entry 12435 (class 0 OID 0)
-- Dependencies: 636
-- Name: sgb_obra_tipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgb_obra_tipo_id_seq OWNED BY public.sgb_tipo_obra_especificacao.id;


--
-- TOC entry 637 (class 1259 OID 14564052)
-- Name: sgb_pha; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgb_pha (
 id bigint NOT NULL,
 nome character varying(50),
 id_sgb_autor bigint
);


ALTER TABLE public.sgb_pha OWNER TO postgres;

--
-- TOC entry 638 (class 1259 OID 14564055)
-- Name: sgb_pha_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgb_pha_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgb_pha_id_seq OWNER TO postgres;

--
-- TOC entry 12436 (class 0 OID 0)
-- Dependencies: 638
-- Name: sgb_pha_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgb_pha_id_seq OWNED BY public.sgb_pha.id;


--
-- TOC entry 639 (class 1259 OID 14564057)
-- Name: sgb_prateleira; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgb_prateleira (
 id bigint NOT NULL,
 nome character varying NOT NULL
);


ALTER TABLE public.sgb_prateleira OWNER TO postgres;

--
-- TOC entry 640 (class 1259 OID 14564063)
-- Name: sgb_prateleira_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgb_prateleira_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgb_prateleira_id_seq OWNER TO postgres;

--
-- TOC entry 12437 (class 0 OID 0)
-- Dependencies: 640
-- Name: sgb_prateleira_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgb_prateleira_id_seq OWNED BY public.sgb_prateleira.id;


--
-- TOC entry 641 (class 1259 OID 14564065)
-- Name: sgb_renovacao_emprestimo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgb_renovacao_emprestimo (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sgb_emprestimo bigint NOT NULL,
 data_renovacao date,
 data_previsao_devolucao date
);


ALTER TABLE public.sgb_renovacao_emprestimo OWNER TO postgres;

--
-- TOC entry 642 (class 1259 OID 14564068)
-- Name: sgb_renovacao_emprestimo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgb_renovacao_emprestimo_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgb_renovacao_emprestimo_id_seq OWNER TO postgres;

--
-- TOC entry 12438 (class 0 OID 0)
-- Dependencies: 642
-- Name: sgb_renovacao_emprestimo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgb_renovacao_emprestimo_id_seq OWNED BY public.sgb_renovacao_emprestimo.id;


--
-- TOC entry 643 (class 1259 OID 14564070)
-- Name: sgb_reserva_livro; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgb_reserva_livro (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sgb_leitor bigint NOT NULL,
 id_sgb_livro bigint NOT NULL,
 id_sgb_emprestimo bigint,
 data_reserva date NOT NULL,
 hora_reserva time(0) without time zone NOT NULL,
 data_inicio_vigencia date,
 data_fim_vigencia date
);


ALTER TABLE public.sgb_reserva_livro OWNER TO postgres;

--
-- TOC entry 12439 (class 0 OID 0)
-- Dependencies: 643
-- Name: COLUMN sgb_reserva_livro.data_reserva; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgb_reserva_livro.data_reserva IS 'Data da criação da reserva da matrícula. Gravar data e hora internamente.';


--
-- TOC entry 12440 (class 0 OID 0)
-- Dependencies: 643
-- Name: COLUMN sgb_reserva_livro.hora_reserva; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgb_reserva_livro.hora_reserva IS 'Hora em que a reserva foi feita';


--
-- TOC entry 644 (class 1259 OID 14564073)
-- Name: sgb_reserva_livro_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgb_reserva_livro_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgb_reserva_livro_id_seq OWNER TO postgres;

--
-- TOC entry 12441 (class 0 OID 0)
-- Dependencies: 644
-- Name: sgb_reserva_livro_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgb_reserva_livro_id_seq OWNED BY public.sgb_reserva_livro.id;


--
-- TOC entry 645 (class 1259 OID 14564075)
-- Name: sgb_situacao_biblioteca; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgb_situacao_biblioteca (
 id bigint NOT NULL,
 nome character varying(100) NOT NULL,
 sigla character varying(8) NOT NULL
);


ALTER TABLE public.sgb_situacao_biblioteca OWNER TO postgres;

--
-- TOC entry 646 (class 1259 OID 14564078)
-- Name: sgb_situacao_biblioteca_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgb_situacao_biblioteca_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgb_situacao_biblioteca_id_seq OWNER TO postgres;

--
-- TOC entry 12442 (class 0 OID 0)
-- Dependencies: 646
-- Name: sgb_situacao_biblioteca_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgb_situacao_biblioteca_id_seq OWNED BY public.sgb_situacao_biblioteca.id;


--
-- TOC entry 647 (class 1259 OID 14564080)
-- Name: sgb_tipo_aquisicao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgb_tipo_aquisicao (
 id bigint NOT NULL,
 nome character varying NOT NULL
);


ALTER TABLE public.sgb_tipo_aquisicao OWNER TO postgres;

--
-- TOC entry 648 (class 1259 OID 14564086)
-- Name: sgb_tipo_aquisicao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgb_tipo_aquisicao_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgb_tipo_aquisicao_id_seq OWNER TO postgres;

--
-- TOC entry 12443 (class 0 OID 0)
-- Dependencies: 648
-- Name: sgb_tipo_aquisicao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgb_tipo_aquisicao_id_seq OWNED BY public.sgb_tipo_aquisicao.id;


SET default_with_oids = true;

--
-- TOC entry 649 (class 1259 OID 14564088)
-- Name: sgb_tipo_leitor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgb_tipo_leitor (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(100) NOT NULL,
 paga_multa character(1) NOT NULL,
 valor_multa numeric(9,2),
 qtd_dias_emprestimo smallint NOT NULL,
 qtd_dias_reserva smallint NOT NULL,
 qtd_dias_bloqueio smallint NOT NULL,
 limite_emprestimo smallint NOT NULL,
 limite_reserva smallint NOT NULL,
 limite_consulta smallint NOT NULL,
 limite_renovacao smallint NOT NULL
);


ALTER TABLE public.sgb_tipo_leitor OWNER TO postgres;

--
-- TOC entry 12444 (class 0 OID 0)
-- Dependencies: 649
-- Name: COLUMN sgb_tipo_leitor.paga_multa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgb_tipo_leitor.paga_multa IS 'S=sim e N=não';


--
-- TOC entry 12445 (class 0 OID 0)
-- Dependencies: 649
-- Name: COLUMN sgb_tipo_leitor.qtd_dias_emprestimo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgb_tipo_leitor.qtd_dias_emprestimo IS 'dias para emprestimo';


--
-- TOC entry 12446 (class 0 OID 0)
-- Dependencies: 649
-- Name: COLUMN sgb_tipo_leitor.qtd_dias_bloqueio; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgb_tipo_leitor.qtd_dias_bloqueio IS 'quantos dias pode ficar bloqueado';


--
-- TOC entry 12447 (class 0 OID 0)
-- Dependencies: 649
-- Name: COLUMN sgb_tipo_leitor.limite_emprestimo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgb_tipo_leitor.limite_emprestimo IS 'quantos livros pode pegar emprestado';


--
-- TOC entry 12448 (class 0 OID 0)
-- Dependencies: 649
-- Name: COLUMN sgb_tipo_leitor.limite_reserva; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgb_tipo_leitor.limite_reserva IS 'quantos livros pode reservar';


--
-- TOC entry 12449 (class 0 OID 0)
-- Dependencies: 649
-- Name: COLUMN sgb_tipo_leitor.limite_consulta; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgb_tipo_leitor.limite_consulta IS 'quantos livros pode consultar';


--
-- TOC entry 12450 (class 0 OID 0)
-- Dependencies: 649
-- Name: COLUMN sgb_tipo_leitor.limite_renovacao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgb_tipo_leitor.limite_renovacao IS 'qtd de vezes para renovacao emprestimo';


--
-- TOC entry 650 (class 1259 OID 14564091)
-- Name: sgb_tipo_leitor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgb_tipo_leitor_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgb_tipo_leitor_id_seq OWNER TO postgres;

--
-- TOC entry 12451 (class 0 OID 0)
-- Dependencies: 650
-- Name: sgb_tipo_leitor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgb_tipo_leitor_id_seq OWNED BY public.sgb_tipo_leitor.id;


SET default_with_oids = false;

--
-- TOC entry 651 (class 1259 OID 14564093)
-- Name: sgb_tradutor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgb_tradutor (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(100),
 data_nascimento date,
 data_falecimento date,
 nacionalidade character(1)
);


ALTER TABLE public.sgb_tradutor OWNER TO postgres;

--
-- TOC entry 12452 (class 0 OID 0)
-- Dependencies: 651
-- Name: COLUMN sgb_tradutor.nacionalidade; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgb_tradutor.nacionalidade IS '1=Brasileira, 2=Brasileira: nascido no exterior ou naturalizado e 3=Estrangeira';


--
-- TOC entry 652 (class 1259 OID 14564096)
-- Name: sgb_tradutor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgb_tradutor_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgb_tradutor_id_seq OWNER TO postgres;

--
-- TOC entry 12453 (class 0 OID 0)
-- Dependencies: 652
-- Name: sgb_tradutor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgb_tradutor_id_seq OWNED BY public.sgb_tradutor.id;


--
-- TOC entry 653 (class 1259 OID 14564098)
-- Name: sgb_tradutor_livro; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgb_tradutor_livro (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sgb_tradutor bigint,
 id_sgb_livro bigint,
 link character varying(250)
);


ALTER TABLE public.sgb_tradutor_livro OWNER TO postgres;

--
-- TOC entry 654 (class 1259 OID 14564101)
-- Name: sgb_tradutor_livro_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgb_tradutor_livro_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgb_tradutor_livro_id_seq OWNER TO postgres;

--
-- TOC entry 12454 (class 0 OID 0)
-- Dependencies: 654
-- Name: sgb_tradutor_livro_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgb_tradutor_livro_id_seq OWNED BY public.sgb_tradutor_livro.id;


--
-- TOC entry 655 (class 1259 OID 14564103)
-- Name: sge_ajuste_escola_aluno_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_ajuste_escola_aluno_log (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_turma_origem bigint NOT NULL,
 id_sge_turma_destino bigint NOT NULL,
 login character(32) NOT NULL,
 data_gravacao date NOT NULL,
 hora_gravacao time without time zone NOT NULL,
 id_sge_aluno bigint NOT NULL
);


ALTER TABLE public.sge_ajuste_escola_aluno_log OWNER TO postgres;

--
-- TOC entry 656 (class 1259 OID 14564106)
-- Name: sge_ajuste_escola_aluno_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_ajuste_escola_aluno_log_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_ajuste_escola_aluno_log_id_seq OWNER TO postgres;

--
-- TOC entry 12455 (class 0 OID 0)
-- Dependencies: 656
-- Name: sge_ajuste_escola_aluno_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_ajuste_escola_aluno_log_id_seq OWNED BY public.sge_ajuste_escola_aluno_log.id;


SET default_with_oids = true;

--
-- TOC entry 657 (class 1259 OID 14564108)
-- Name: sge_aluno; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_aluno (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_pessoa bigint NOT NULL,
 id_bas_pessoa_mae bigint,
 id_bas_pessoa_pai bigint,
 necessidades text,
 setps character varying(30),
 transferido_ano integer,
 transferido_cidade character varying(30),
 transferido_uf character(2),
 deficiente_fisico character(1) DEFAULT 'N'::bpchar,
 deficiente_visual character(1) DEFAULT 'N'::bpchar,
 deficiente_auditivo character(1) DEFAULT 'N'::bpchar,
 nome_guerra character varying(30),
 observacao_aluno text,
 deficiencia_aprendizagem character(1) DEFAULT 'N'::bpchar,
 observacao_historico character varying(300),
 tipo_historico_fundamental character(1),
 transporte_publico integer,
 responsavel_transporte integer,
 rodoviario_vans_kombi integer,
 rodoviario_microonibus integer,
 rodoviario_onibus integer,
 rodoviario_bicicleta integer,
 rodoviario_tracao_animal integer,
 rodoviario_outro integer,
 aquaviario_5 integer,
 aquaviario_15 integer,
 aquaviario_35 integer,
 aquaviario_mais35 integer,
 ferroviario_trem_metro integer,
 numero_programa character varying(20),
 campo_auxiliar_1 character varying(100),
 campo_auxiliar_2 character varying(100),
 campo_auxiliar_3 character varying(100),
 campo_auxiliar_4 character varying(100),
 campo_auxiliar_5 character varying(100),
 campo_auxiliar_6 character varying(100),
 campo_auxiliar_7 character varying(100),
 campo_auxiliar_8 character varying(100),
 id_sge_grade_historico bigint,
 id_sge_detalhe_deficiencia bigint
);
ALTER TABLE ONLY public.sge_aluno ALTER COLUMN deficiente_fisico SET STATISTICS 0;


ALTER TABLE public.sge_aluno OWNER TO postgres;

--
-- TOC entry 12456 (class 0 OID 0)
-- Dependencies: 657
-- Name: COLUMN sge_aluno.id_bas_pessoa_mae; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_aluno.id_bas_pessoa_mae IS 'mae do aluno';


--
-- TOC entry 12457 (class 0 OID 0)
-- Dependencies: 657
-- Name: COLUMN sge_aluno.id_bas_pessoa_pai; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_aluno.id_bas_pessoa_pai IS 'pai do aluno';


--
-- TOC entry 12458 (class 0 OID 0)
-- Dependencies: 657
-- Name: COLUMN sge_aluno.deficiente_fisico; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_aluno.deficiente_fisico IS 'S = Sim, N = Não';


--
-- TOC entry 12459 (class 0 OID 0)
-- Dependencies: 657
-- Name: COLUMN sge_aluno.deficiente_visual; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_aluno.deficiente_visual IS 'S = Sim, N = Não';


--
-- TOC entry 12460 (class 0 OID 0)
-- Dependencies: 657
-- Name: COLUMN sge_aluno.deficiente_auditivo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_aluno.deficiente_auditivo IS 'S = Sim, N = Não';


--
-- TOC entry 12461 (class 0 OID 0)
-- Dependencies: 657
-- Name: COLUMN sge_aluno.nome_guerra; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_aluno.nome_guerra IS 'Nome de Guerra do Aluno';


--
-- TOC entry 12462 (class 0 OID 0)
-- Dependencies: 657
-- Name: COLUMN sge_aluno.observacao_aluno; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_aluno.observacao_aluno IS 'Observações do aluno.';


--
-- TOC entry 12463 (class 0 OID 0)
-- Dependencies: 657
-- Name: COLUMN sge_aluno.deficiencia_aprendizagem; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_aluno.deficiencia_aprendizagem IS 'Indica se o aluno tem dificuldade de aprendizagem, S = Sim, N = Não';


--
-- TOC entry 12464 (class 0 OID 0)
-- Dependencies: 657
-- Name: COLUMN sge_aluno.observacao_historico; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_aluno.observacao_historico IS 'Observação para o histórico do aluno';


--
-- TOC entry 12465 (class 0 OID 0)
-- Dependencies: 657
-- Name: COLUMN sge_aluno.tipo_historico_fundamental; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_aluno.tipo_historico_fundamental IS '8=Histórico de 08 anos, 9=Histórico de 09 anos';


--
-- TOC entry 12466 (class 0 OID 0)
-- Dependencies: 657
-- Name: COLUMN sge_aluno.transporte_publico; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_aluno.transporte_publico IS 'Não Utiliza = 0
Utiliza = 1';


--
-- TOC entry 12467 (class 0 OID 0)
-- Dependencies: 657
-- Name: COLUMN sge_aluno.responsavel_transporte; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_aluno.responsavel_transporte IS 'Estadual = 1
Municipal = 2';


--
-- TOC entry 12468 (class 0 OID 0)
-- Dependencies: 657
-- Name: COLUMN sge_aluno.rodoviario_vans_kombi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_aluno.rodoviario_vans_kombi IS 'Não = 0
Sim = 1';


--
-- TOC entry 12469 (class 0 OID 0)
-- Dependencies: 657
-- Name: COLUMN sge_aluno.rodoviario_microonibus; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_aluno.rodoviario_microonibus IS 'Não = 0
Sim = 1';


--
-- TOC entry 12470 (class 0 OID 0)
-- Dependencies: 657
-- Name: COLUMN sge_aluno.rodoviario_onibus; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_aluno.rodoviario_onibus IS 'Não = 0
Sim = 1';


--
-- TOC entry 12471 (class 0 OID 0)
-- Dependencies: 657
-- Name: COLUMN sge_aluno.rodoviario_bicicleta; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_aluno.rodoviario_bicicleta IS 'Não = 0
Sim = 1';


--
-- TOC entry 12472 (class 0 OID 0)
-- Dependencies: 657
-- Name: COLUMN sge_aluno.rodoviario_tracao_animal; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_aluno.rodoviario_tracao_animal IS 'Não = 0
Sim = 1';


--
-- TOC entry 12473 (class 0 OID 0)
-- Dependencies: 657
-- Name: COLUMN sge_aluno.rodoviario_outro; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_aluno.rodoviario_outro IS 'Não = 0
Sim = 1';


--
-- TOC entry 12474 (class 0 OID 0)
-- Dependencies: 657
-- Name: COLUMN sge_aluno.aquaviario_5; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_aluno.aquaviario_5 IS 'Não = 0
Sim = 1';


--
-- TOC entry 12475 (class 0 OID 0)
-- Dependencies: 657
-- Name: COLUMN sge_aluno.aquaviario_15; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_aluno.aquaviario_15 IS 'Não = 0
Sim = 1';


--
-- TOC entry 12476 (class 0 OID 0)
-- Dependencies: 657
-- Name: COLUMN sge_aluno.aquaviario_35; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_aluno.aquaviario_35 IS 'Não = 0
Sim = 1';


--
-- TOC entry 12477 (class 0 OID 0)
-- Dependencies: 657
-- Name: COLUMN sge_aluno.aquaviario_mais35; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_aluno.aquaviario_mais35 IS 'Não = 0
Sim = 1';


--
-- TOC entry 12478 (class 0 OID 0)
-- Dependencies: 657
-- Name: COLUMN sge_aluno.ferroviario_trem_metro; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_aluno.ferroviario_trem_metro IS 'Não = 0
Sim = 1';


--
-- TOC entry 12479 (class 0 OID 0)
-- Dependencies: 657
-- Name: COLUMN sge_aluno.numero_programa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_aluno.numero_programa IS 'Número PAS (CONDE)';


--
-- TOC entry 12480 (class 0 OID 0)
-- Dependencies: 657
-- Name: COLUMN sge_aluno.campo_auxiliar_1; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_aluno.campo_auxiliar_1 IS 'Campo auxiliar para ser exibido na matrícula. Deve-se configurar sua exibição na configuração pedagógica.';


--
-- TOC entry 12481 (class 0 OID 0)
-- Dependencies: 657
-- Name: COLUMN sge_aluno.campo_auxiliar_2; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_aluno.campo_auxiliar_2 IS 'Campo auxiliar para ser exibido na matrícula. Deve-se configurar sua exibição na configuração pedagógica.';


--
-- TOC entry 12482 (class 0 OID 0)
-- Dependencies: 657
-- Name: COLUMN sge_aluno.campo_auxiliar_3; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_aluno.campo_auxiliar_3 IS 'Campo auxiliar para ser exibido na matrícula. Deve-se configurar sua exibição na configuração pedagógica.';


--
-- TOC entry 12483 (class 0 OID 0)
-- Dependencies: 657
-- Name: COLUMN sge_aluno.campo_auxiliar_4; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_aluno.campo_auxiliar_4 IS 'Campo auxiliar para ser exibido na matrícula. Deve-se configurar sua exibição na configuração pedagógica.';


--
-- TOC entry 12484 (class 0 OID 0)
-- Dependencies: 657
-- Name: COLUMN sge_aluno.campo_auxiliar_5; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_aluno.campo_auxiliar_5 IS 'Campo auxiliar para ser exibido na matrícula. Deve-se configurar sua exibição na configuração pedagógica.';


--
-- TOC entry 12485 (class 0 OID 0)
-- Dependencies: 657
-- Name: COLUMN sge_aluno.campo_auxiliar_6; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_aluno.campo_auxiliar_6 IS 'Campo auxiliar para ser exibido na matrícula. Deve-se configurar sua exibição na configuração pedagógica.';


--
-- TOC entry 12486 (class 0 OID 0)
-- Dependencies: 657
-- Name: COLUMN sge_aluno.campo_auxiliar_7; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_aluno.campo_auxiliar_7 IS 'Campo auxiliar para ser exibido na matrícula. Deve-se configurar sua exibição na configuração pedagógica.';


--
-- TOC entry 12487 (class 0 OID 0)
-- Dependencies: 657
-- Name: COLUMN sge_aluno.campo_auxiliar_8; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_aluno.campo_auxiliar_8 IS 'Campo auxiliar para ser exibido na matrícula. Deve-se configurar sua exibição na configuração pedagógica.';


--
-- TOC entry 12488 (class 0 OID 0)
-- Dependencies: 657
-- Name: COLUMN sge_aluno.id_sge_grade_historico; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_aluno.id_sge_grade_historico IS 'Grade de disciplina do histórico do EJA';


--
-- TOC entry 658 (class 1259 OID 14564118)
-- Name: sge_aluno_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_aluno_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_aluno_id_seq OWNER TO postgres;

--
-- TOC entry 12489 (class 0 OID 0)
-- Dependencies: 658
-- Name: sge_aluno_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_aluno_id_seq OWNED BY public.sge_aluno.id;


SET default_with_oids = false;

--
-- TOC entry 659 (class 1259 OID 14564120)
-- Name: sge_aluno_vestibular; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_aluno_vestibular (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_aluno bigint NOT NULL,
 id_sge_instituicao_ensino bigint NOT NULL,
 id_sge_curso_superior bigint NOT NULL,
 ano smallint NOT NULL,
 posicao smallint
);


ALTER TABLE public.sge_aluno_vestibular OWNER TO postgres;

--
-- TOC entry 660 (class 1259 OID 14564123)
-- Name: sge_aluno_vestibular_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_aluno_vestibular_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_aluno_vestibular_id_seq OWNER TO postgres;

--
-- TOC entry 12490 (class 0 OID 0)
-- Dependencies: 660
-- Name: sge_aluno_vestibular_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_aluno_vestibular_id_seq OWNED BY public.sge_aluno_vestibular.id;


--
-- TOC entry 661 (class 1259 OID 14564125)
-- Name: sge_anotacao_tipo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_anotacao_tipo (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(100) NOT NULL
);


ALTER TABLE public.sge_anotacao_tipo OWNER TO postgres;

--
-- TOC entry 662 (class 1259 OID 14564128)
-- Name: sge_anotacao_tipo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_anotacao_tipo_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_anotacao_tipo_id_seq OWNER TO postgres;

--
-- TOC entry 12491 (class 0 OID 0)
-- Dependencies: 662
-- Name: sge_anotacao_tipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_anotacao_tipo_id_seq OWNED BY public.sge_anotacao_tipo.id;


--
-- TOC entry 663 (class 1259 OID 14564130)
-- Name: sge_anotacao_tipo_perfil_soe; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_anotacao_tipo_perfil_soe (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_anotacao_tipo bigint NOT NULL,
 id_sge_perfil_soe bigint NOT NULL
);


ALTER TABLE public.sge_anotacao_tipo_perfil_soe OWNER TO postgres;

--
-- TOC entry 664 (class 1259 OID 14564133)
-- Name: sge_anotacao_tipo_perfil_soe_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_anotacao_tipo_perfil_soe_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_anotacao_tipo_perfil_soe_id_seq OWNER TO postgres;

--
-- TOC entry 12492 (class 0 OID 0)
-- Dependencies: 664
-- Name: sge_anotacao_tipo_perfil_soe_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_anotacao_tipo_perfil_soe_id_seq OWNED BY public.sge_anotacao_tipo_perfil_soe.id;


--
-- TOC entry 665 (class 1259 OID 14564135)
-- Name: sge_assunto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_assunto (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_estabelecimento bigint NOT NULL,
 id_sge_disciplina bigint NOT NULL,
 descricao character varying(100) NOT NULL
);


ALTER TABLE public.sge_assunto OWNER TO postgres;

--
-- TOC entry 666 (class 1259 OID 14564138)
-- Name: sge_assunto_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_assunto_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_assunto_id_seq OWNER TO postgres;

--
-- TOC entry 12493 (class 0 OID 0)
-- Dependencies: 666
-- Name: sge_assunto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_assunto_id_seq OWNED BY public.sge_assunto.id;


SET default_with_oids = true;

--
-- TOC entry 667 (class 1259 OID 14564140)
-- Name: sge_atendimento_medico; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_atendimento_medico (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_colaborador bigint,
 id_sge_aluno bigint NOT NULL,
 data date NOT NULL,
 hora_inicio time(6) without time zone,
 hora_fim time(6) without time zone,
 descricao text,
 nome_medico character varying(150),
 medicamento character varying(50),
 via_administrada character varying(30)
);


ALTER TABLE public.sge_atendimento_medico OWNER TO postgres;

--
-- TOC entry 12494 (class 0 OID 0)
-- Dependencies: 667
-- Name: COLUMN sge_atendimento_medico.nome_medico; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atendimento_medico.nome_medico IS 'Nome do médico que realizou o atendimento no hospital';


--
-- TOC entry 668 (class 1259 OID 14564146)
-- Name: sge_atendimento_medico_id_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_atendimento_medico_id_seq1
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_atendimento_medico_id_seq1 OWNER TO postgres;

--
-- TOC entry 12495 (class 0 OID 0)
-- Dependencies: 668
-- Name: sge_atendimento_medico_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_atendimento_medico_id_seq1 OWNED BY public.sge_atendimento_medico.id;


SET default_with_oids = false;

--
-- TOC entry 1308 (class 1259 OID 22012580)
-- Name: sge_atendimento_medico_ocorrencia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_atendimento_medico_ocorrencia (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_atendimento_medico bigint,
 id_sge_ocorrencia_de_enfermagem bigint
);


ALTER TABLE public.sge_atendimento_medico_ocorrencia OWNER TO postgres;

--
-- TOC entry 1307 (class 1259 OID 22012578)
-- Name: sge_atendimento_medico_ocorrencia_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_atendimento_medico_ocorrencia_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_atendimento_medico_ocorrencia_id_seq OWNER TO postgres;

--
-- TOC entry 12496 (class 0 OID 0)
-- Dependencies: 1307
-- Name: sge_atendimento_medico_ocorrencia_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_atendimento_medico_ocorrencia_id_seq OWNED BY public.sge_atendimento_medico_ocorrencia.id;


--
-- TOC entry 669 (class 1259 OID 14564148)
-- Name: sge_atendimento_soe; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_atendimento_soe (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_aluno bigint NOT NULL,
 id_bas_responsavel bigint NOT NULL,
 id_sge_atendimento_tipo bigint NOT NULL,
 data date NOT NULL,
 hora time without time zone NOT NULL,
 observacao text,
 usr_login character varying(32) NOT NULL
);


ALTER TABLE public.sge_atendimento_soe OWNER TO postgres;

--
-- TOC entry 670 (class 1259 OID 14564154)
-- Name: sge_atendimento_soe_anotacao_tipo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_atendimento_soe_anotacao_tipo (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_atendimento_soe bigint NOT NULL,
 id_sge_anotacao_tipo bigint
);


ALTER TABLE public.sge_atendimento_soe_anotacao_tipo OWNER TO postgres;

--
-- TOC entry 671 (class 1259 OID 14564157)
-- Name: sge_atendimento_soe_anotacao_tipo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_atendimento_soe_anotacao_tipo_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_atendimento_soe_anotacao_tipo_id_seq OWNER TO postgres;

--
-- TOC entry 12497 (class 0 OID 0)
-- Dependencies: 671
-- Name: sge_atendimento_soe_anotacao_tipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_atendimento_soe_anotacao_tipo_id_seq OWNED BY public.sge_atendimento_soe_anotacao_tipo.id;


--
-- TOC entry 672 (class 1259 OID 14564159)
-- Name: sge_atendimento_soe_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_atendimento_soe_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_atendimento_soe_id_seq OWNER TO postgres;

--
-- TOC entry 12498 (class 0 OID 0)
-- Dependencies: 672
-- Name: sge_atendimento_soe_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_atendimento_soe_id_seq OWNED BY public.sge_atendimento_soe.id;


--
-- TOC entry 673 (class 1259 OID 14564161)
-- Name: sge_atendimento_tipo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_atendimento_tipo (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 tipo character varying(100) NOT NULL
);


ALTER TABLE public.sge_atendimento_tipo OWNER TO postgres;

--
-- TOC entry 12499 (class 0 OID 0)
-- Dependencies: 673
-- Name: COLUMN sge_atendimento_tipo.tipo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atendimento_tipo.tipo IS 'Tipos de atendimento do SOE';


--
-- TOC entry 674 (class 1259 OID 14564164)
-- Name: sge_atendimento_tipo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_atendimento_tipo_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_atendimento_tipo_id_seq OWNER TO postgres;

--
-- TOC entry 12500 (class 0 OID 0)
-- Dependencies: 674
-- Name: sge_atendimento_tipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_atendimento_tipo_id_seq OWNED BY public.sge_atendimento_tipo.id;


--
-- TOC entry 675 (class 1259 OID 14564166)
-- Name: sge_atendimento_tipo_perfil_soe; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_atendimento_tipo_perfil_soe (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_atendimento_tipo bigint NOT NULL,
 id_sge_perfil_soe bigint NOT NULL
);


ALTER TABLE public.sge_atendimento_tipo_perfil_soe OWNER TO postgres;

--
-- TOC entry 676 (class 1259 OID 14564169)
-- Name: sge_atendimento_tipo_perfil_soe_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_atendimento_tipo_perfil_soe_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_atendimento_tipo_perfil_soe_id_seq OWNER TO postgres;

--
-- TOC entry 12501 (class 0 OID 0)
-- Dependencies: 676
-- Name: sge_atendimento_tipo_perfil_soe_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_atendimento_tipo_perfil_soe_id_seq OWNED BY public.sge_atendimento_tipo_perfil_soe.id;


--
-- TOC entry 677 (class 1259 OID 14564171)
-- Name: sge_atestado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_atestado (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_atestado_tipo bigint NOT NULL,
 data_entrega date NOT NULL,
 observacao character varying(100),
 data_inicial date NOT NULL,
 data_final date NOT NULL,
 id_sge_turma_aluno bigint NOT NULL,
 id_bas_cid bigint
);
ALTER TABLE ONLY public.sge_atestado ALTER COLUMN id SET STATISTICS 0;
ALTER TABLE ONLY public.sge_atestado ALTER COLUMN id_bas_empresa SET STATISTICS 0;
ALTER TABLE ONLY public.sge_atestado ALTER COLUMN data_entrega SET STATISTICS 0;
ALTER TABLE ONLY public.sge_atestado ALTER COLUMN observacao SET STATISTICS 0;


ALTER TABLE public.sge_atestado OWNER TO postgres;

--
-- TOC entry 678 (class 1259 OID 14564174)
-- Name: sge_atestado_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_atestado_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_atestado_id_seq OWNER TO postgres;

--
-- TOC entry 12502 (class 0 OID 0)
-- Dependencies: 678
-- Name: sge_atestado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_atestado_id_seq OWNED BY public.sge_atestado.id;


--
-- TOC entry 679 (class 1259 OID 14564176)
-- Name: sge_atestado_tipo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_atestado_tipo (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(20) NOT NULL
);
ALTER TABLE ONLY public.sge_atestado_tipo ALTER COLUMN id SET STATISTICS 0;
ALTER TABLE ONLY public.sge_atestado_tipo ALTER COLUMN id_bas_empresa SET STATISTICS 0;
ALTER TABLE ONLY public.sge_atestado_tipo ALTER COLUMN nome SET STATISTICS 0;


ALTER TABLE public.sge_atestado_tipo OWNER TO postgres;

--
-- TOC entry 680 (class 1259 OID 14564179)
-- Name: sge_atestado_tipo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_atestado_tipo_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_atestado_tipo_id_seq OWNER TO postgres;

--
-- TOC entry 12503 (class 0 OID 0)
-- Dependencies: 680
-- Name: sge_atestado_tipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_atestado_tipo_id_seq OWNED BY public.sge_atestado_tipo.id;


--
-- TOC entry 681 (class 1259 OID 14564181)
-- Name: sge_atividade; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_atividade (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_estabelecimento bigint,
 id_sgf_tipo_titulo_receber bigint,
 id_sge_disciplina bigint,
 nome character varying(50) NOT NULL,
 valor numeric(9,2),
 data_cancelamento date,
 id_sge_oficina bigint
);


ALTER TABLE public.sge_atividade OWNER TO postgres;

--
-- TOC entry 12504 (class 0 OID 0)
-- Dependencies: 681
-- Name: TABLE sge_atividade; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sge_atividade IS 'Cadastra as atividades do estabelecimento';


--
-- TOC entry 12505 (class 0 OID 0)
-- Dependencies: 681
-- Name: COLUMN sge_atividade.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade.id IS 'Identificador sequencial da tabela, chave primaria composta com o campo id_bas_empresa';


--
-- TOC entry 12506 (class 0 OID 0)
-- Dependencies: 681
-- Name: COLUMN sge_atividade.id_bas_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade.id_bas_empresa IS 'Identificador da tabela bas_empresa, chave primaria composta com o campo id';


--
-- TOC entry 12507 (class 0 OID 0)
-- Dependencies: 681
-- Name: COLUMN sge_atividade.id_bas_estabelecimento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade.id_bas_estabelecimento IS 'Identificador da tabela bas_estabelecimento junto com o campo id_bas_empresa';


--
-- TOC entry 12508 (class 0 OID 0)
-- Dependencies: 681
-- Name: COLUMN sge_atividade.id_sgf_tipo_titulo_receber; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade.id_sgf_tipo_titulo_receber IS 'Identificador da tabela sgf_tipo_titulo_receber junto com o campo id_bas_empresa';


--
-- TOC entry 12509 (class 0 OID 0)
-- Dependencies: 681
-- Name: COLUMN sge_atividade.id_sge_disciplina; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade.id_sge_disciplina IS 'Identificador da tabela sge_disciplina junto com o campo id_bas_empresa';


--
-- TOC entry 12510 (class 0 OID 0)
-- Dependencies: 681
-- Name: COLUMN sge_atividade.nome; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade.nome IS 'Nome da atividade';


--
-- TOC entry 12511 (class 0 OID 0)
-- Dependencies: 681
-- Name: COLUMN sge_atividade.valor; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade.valor IS 'Valor da atividade';


--
-- TOC entry 12512 (class 0 OID 0)
-- Dependencies: 681
-- Name: COLUMN sge_atividade.data_cancelamento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade.data_cancelamento IS 'Data de cancelamento da atividade';


--
-- TOC entry 12513 (class 0 OID 0)
-- Dependencies: 681
-- Name: COLUMN sge_atividade.id_sge_oficina; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade.id_sge_oficina IS 'Chave estrangeira da tabela sge_oficina ao lado do campo id_bas_empresa';


--
-- TOC entry 682 (class 1259 OID 14564184)
-- Name: sge_atividade_categoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_atividade_categoria (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_atividade bigint NOT NULL,
 nome character varying(100) NOT NULL,
 valor numeric(9,2),
 data_cancelamento date
);


ALTER TABLE public.sge_atividade_categoria OWNER TO postgres;

--
-- TOC entry 12514 (class 0 OID 0)
-- Dependencies: 682
-- Name: TABLE sge_atividade_categoria; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sge_atividade_categoria IS 'Cadastra as categorias das atividades';


--
-- TOC entry 12515 (class 0 OID 0)
-- Dependencies: 682
-- Name: COLUMN sge_atividade_categoria.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade_categoria.id IS 'Identificador sequencial da tabela, chave primaria composta com o campo id_bas_empresa';


--
-- TOC entry 12516 (class 0 OID 0)
-- Dependencies: 682
-- Name: COLUMN sge_atividade_categoria.id_bas_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade_categoria.id_bas_empresa IS 'Identificador da tabela bas_empresa, chave primaria composta com o campo id';


--
-- TOC entry 12517 (class 0 OID 0)
-- Dependencies: 682
-- Name: COLUMN sge_atividade_categoria.id_sge_atividade; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade_categoria.id_sge_atividade IS 'Identificador da tabela sga_atividade junto com o campo id_bas_empresa';


--
-- TOC entry 12518 (class 0 OID 0)
-- Dependencies: 682
-- Name: COLUMN sge_atividade_categoria.nome; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade_categoria.nome IS 'Nome da categoria da atividade';


--
-- TOC entry 12519 (class 0 OID 0)
-- Dependencies: 682
-- Name: COLUMN sge_atividade_categoria.valor; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade_categoria.valor IS 'Valor da categoria da atividade';


--
-- TOC entry 12520 (class 0 OID 0)
-- Dependencies: 682
-- Name: COLUMN sge_atividade_categoria.data_cancelamento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade_categoria.data_cancelamento IS 'Data de cancelamento da categoria da atividade';


--
-- TOC entry 683 (class 1259 OID 14564187)
-- Name: sge_atividade_categoria_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_atividade_categoria_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_atividade_categoria_id_seq OWNER TO postgres;

--
-- TOC entry 12521 (class 0 OID 0)
-- Dependencies: 683
-- Name: sge_atividade_categoria_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_atividade_categoria_id_seq OWNED BY public.sge_atividade_categoria.id;


--
-- TOC entry 684 (class 1259 OID 14564189)
-- Name: sge_atividade_coordenacao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_atividade_coordenacao (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_atividade_coordenacao bigint,
 id_bas_estabelecimento bigint NOT NULL,
 id_sge_professor bigint NOT NULL,
 titulo character varying(80) NOT NULL,
 data_inicio date NOT NULL,
 data_fim date NOT NULL,
 hora_inicio time without time zone NOT NULL,
 hora_fim time without time zone NOT NULL,
 descricao text NOT NULL,
 status character(1) NOT NULL,
 motivo text,
 data_inclusao date NOT NULL,
 data_atualizacao timestamp without time zone,
 responsavel character(1) DEFAULT 'S'::bpchar NOT NULL
);


ALTER TABLE public.sge_atividade_coordenacao OWNER TO postgres;

--
-- TOC entry 12522 (class 0 OID 0)
-- Dependencies: 684
-- Name: COLUMN sge_atividade_coordenacao.id_sge_atividade_coordenacao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade_coordenacao.id_sge_atividade_coordenacao IS 'id da atividade pai';


--
-- TOC entry 12523 (class 0 OID 0)
-- Dependencies: 684
-- Name: COLUMN sge_atividade_coordenacao.status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade_coordenacao.status IS 'A = Ativa , C = Cancelada';


--
-- TOC entry 12524 (class 0 OID 0)
-- Dependencies: 684
-- Name: COLUMN sge_atividade_coordenacao.motivo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade_coordenacao.motivo IS 'Caso a atividade seja cancelada';


--
-- TOC entry 12525 (class 0 OID 0)
-- Dependencies: 684
-- Name: COLUMN sge_atividade_coordenacao.responsavel; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade_coordenacao.responsavel IS 'Responsavel por criar a atividade

S = Sim N = Não';


--
-- TOC entry 685 (class 1259 OID 14564196)
-- Name: sge_atividade_coordenacao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_atividade_coordenacao_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_atividade_coordenacao_id_seq OWNER TO postgres;

--
-- TOC entry 12526 (class 0 OID 0)
-- Dependencies: 685
-- Name: sge_atividade_coordenacao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_atividade_coordenacao_id_seq OWNED BY public.sge_atividade_coordenacao.id;


--
-- TOC entry 686 (class 1259 OID 14564198)
-- Name: sge_atividade_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_atividade_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_atividade_id_seq OWNER TO postgres;

--
-- TOC entry 12527 (class 0 OID 0)
-- Dependencies: 686
-- Name: sge_atividade_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_atividade_id_seq OWNED BY public.sge_atividade.id;


--
-- TOC entry 687 (class 1259 OID 14564200)
-- Name: sge_atividade_pessoa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_atividade_pessoa (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_estabelecimento bigint NOT NULL,
 id_bas_pessoa bigint NOT NULL,
 id_bas_pessoa_responsavel bigint NOT NULL,
 id_sge_atividade bigint NOT NULL,
 id_sge_atividade_turma bigint,
 id_sge_atividade_categoria bigint,
 id_sge_local_aula bigint,
 data date NOT NULL,
 data_inicio date NOT NULL,
 data_termino date,
 ano integer NOT NULL,
 valor numeric(9,2),
 data_cancelamento date,
 login_cancelamento character varying(32),
 motivo_cancelamento character varying(50),
 aluno character(1) DEFAULT 'N'::bpchar NOT NULL,
 observacao character varying(50)
);


ALTER TABLE public.sge_atividade_pessoa OWNER TO postgres;

--
-- TOC entry 12528 (class 0 OID 0)
-- Dependencies: 687
-- Name: TABLE sge_atividade_pessoa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sge_atividade_pessoa IS 'Cadastra a atividade para o aluno';


--
-- TOC entry 12529 (class 0 OID 0)
-- Dependencies: 687
-- Name: COLUMN sge_atividade_pessoa.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade_pessoa.id IS 'Identificador sequencial da tabela, chave primaria composta com o campo id_bas_empresa';


--
-- TOC entry 12530 (class 0 OID 0)
-- Dependencies: 687
-- Name: COLUMN sge_atividade_pessoa.id_bas_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade_pessoa.id_bas_empresa IS 'Identificador da tabela bas_empresa, chave primaria composta com o campo id';


--
-- TOC entry 12531 (class 0 OID 0)
-- Dependencies: 687
-- Name: COLUMN sge_atividade_pessoa.id_bas_estabelecimento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade_pessoa.id_bas_estabelecimento IS 'Identificador da tabela bas_estabelecimento junto com o campo id_bas_empresa';


--
-- TOC entry 12532 (class 0 OID 0)
-- Dependencies: 687
-- Name: COLUMN sge_atividade_pessoa.id_bas_pessoa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade_pessoa.id_bas_pessoa IS 'Identificador da tabela bas_pessoa junto com o campo id_bas_empresa para indicar a pessoa que participa da atividade';


--
-- TOC entry 12533 (class 0 OID 0)
-- Dependencies: 687
-- Name: COLUMN sge_atividade_pessoa.id_bas_pessoa_responsavel; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade_pessoa.id_bas_pessoa_responsavel IS 'Identificador da tabela bas_pessoa junto com o campo id_bas_empresa para indicar a pessoa responsável por quem participa da atividade';


--
-- TOC entry 12534 (class 0 OID 0)
-- Dependencies: 687
-- Name: COLUMN sge_atividade_pessoa.id_sge_atividade; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade_pessoa.id_sge_atividade IS 'Identificador da tabela sge_atividade junto com o campo id_bas_empresa';


--
-- TOC entry 12535 (class 0 OID 0)
-- Dependencies: 687
-- Name: COLUMN sge_atividade_pessoa.id_sge_atividade_turma; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade_pessoa.id_sge_atividade_turma IS 'Identificador da tabela sge_atividade_turma junto com o campo id_bas_empresa';


--
-- TOC entry 12536 (class 0 OID 0)
-- Dependencies: 687
-- Name: COLUMN sge_atividade_pessoa.id_sge_atividade_categoria; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade_pessoa.id_sge_atividade_categoria IS 'Identificador da tabela sge_atividade_categoria junto com o campo id_bas_empresa';


--
-- TOC entry 12537 (class 0 OID 0)
-- Dependencies: 687
-- Name: COLUMN sge_atividade_pessoa.id_sge_local_aula; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade_pessoa.id_sge_local_aula IS 'Identificador da tabela sge_local_aula junto com o campo id_bas_empresa';


--
-- TOC entry 12538 (class 0 OID 0)
-- Dependencies: 687
-- Name: COLUMN sge_atividade_pessoa.data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade_pessoa.data IS 'Data de cadastro do registro';


--
-- TOC entry 12539 (class 0 OID 0)
-- Dependencies: 687
-- Name: COLUMN sge_atividade_pessoa.data_inicio; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade_pessoa.data_inicio IS 'Data de inicio da atividade';


--
-- TOC entry 12540 (class 0 OID 0)
-- Dependencies: 687
-- Name: COLUMN sge_atividade_pessoa.data_termino; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade_pessoa.data_termino IS 'Data do fim da atividade';


--
-- TOC entry 12541 (class 0 OID 0)
-- Dependencies: 687
-- Name: COLUMN sge_atividade_pessoa.ano; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade_pessoa.ano IS 'Ano da atividade';


--
-- TOC entry 12542 (class 0 OID 0)
-- Dependencies: 687
-- Name: COLUMN sge_atividade_pessoa.valor; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade_pessoa.valor IS 'Valor que o aluno paga pela atividade';


--
-- TOC entry 12543 (class 0 OID 0)
-- Dependencies: 687
-- Name: COLUMN sge_atividade_pessoa.data_cancelamento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade_pessoa.data_cancelamento IS 'Data do cancelamento da atividade';


--
-- TOC entry 12544 (class 0 OID 0)
-- Dependencies: 687
-- Name: COLUMN sge_atividade_pessoa.login_cancelamento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade_pessoa.login_cancelamento IS 'Login de quem cancelou a atividade';


--
-- TOC entry 12545 (class 0 OID 0)
-- Dependencies: 687
-- Name: COLUMN sge_atividade_pessoa.motivo_cancelamento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade_pessoa.motivo_cancelamento IS 'Motivo pelo qual a atividade foi cancelada';


--
-- TOC entry 12546 (class 0 OID 0)
-- Dependencies: 687
-- Name: COLUMN sge_atividade_pessoa.aluno; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade_pessoa.aluno IS 'Se o participante é aluno da instituição (S = sim, N = Não)';


--
-- TOC entry 12547 (class 0 OID 0)
-- Dependencies: 687
-- Name: COLUMN sge_atividade_pessoa.observacao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade_pessoa.observacao IS 'Observação referente a atividade';


--
-- TOC entry 688 (class 1259 OID 14564204)
-- Name: sge_atividade_pessoa_atendimento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_atividade_pessoa_atendimento (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_atividade_pessoa integer NOT NULL,
 relatorio text,
 id_sge_educacao_especial_questionario_atividade_turma bigint
);


ALTER TABLE public.sge_atividade_pessoa_atendimento OWNER TO postgres;

--
-- TOC entry 689 (class 1259 OID 14564210)
-- Name: sge_atividade_pessoa_atendimento_acompanhamento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_atividade_pessoa_atendimento_acompanhamento (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_atividade_pessoa_atendimento bigint NOT NULL,
 data date,
 relatorio text
);


ALTER TABLE public.sge_atividade_pessoa_atendimento_acompanhamento OWNER TO postgres;

--
-- TOC entry 690 (class 1259 OID 14564216)
-- Name: sge_atividade_pessoa_atendimento_acompanhamento_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_atividade_pessoa_atendimento_acompanhamento_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_atividade_pessoa_atendimento_acompanhamento_id_seq OWNER TO postgres;

--
-- TOC entry 12548 (class 0 OID 0)
-- Dependencies: 690
-- Name: sge_atividade_pessoa_atendimento_acompanhamento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_atividade_pessoa_atendimento_acompanhamento_id_seq OWNED BY public.sge_atividade_pessoa_atendimento_acompanhamento.id;


--
-- TOC entry 691 (class 1259 OID 14564218)
-- Name: sge_atividade_pessoa_atendimento_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_atividade_pessoa_atendimento_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_atividade_pessoa_atendimento_id_seq OWNER TO postgres;

--
-- TOC entry 12549 (class 0 OID 0)
-- Dependencies: 691
-- Name: sge_atividade_pessoa_atendimento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_atividade_pessoa_atendimento_id_seq OWNED BY public.sge_atividade_pessoa_atendimento.id;


--
-- TOC entry 692 (class 1259 OID 14564220)
-- Name: sge_atividade_pessoa_horario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_atividade_pessoa_horario (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_atividade_pessoa bigint NOT NULL,
 dia integer NOT NULL,
 hora_inicio time without time zone NOT NULL,
 hora_fim time without time zone NOT NULL
);
ALTER TABLE ONLY public.sge_atividade_pessoa_horario ALTER COLUMN id_sge_atividade_pessoa SET STATISTICS 0;


ALTER TABLE public.sge_atividade_pessoa_horario OWNER TO postgres;

--
-- TOC entry 12550 (class 0 OID 0)
-- Dependencies: 692
-- Name: TABLE sge_atividade_pessoa_horario; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sge_atividade_pessoa_horario IS 'Cadastra os horários da turma da atividade';


--
-- TOC entry 12551 (class 0 OID 0)
-- Dependencies: 692
-- Name: COLUMN sge_atividade_pessoa_horario.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade_pessoa_horario.id IS 'Identificador sequencial da tabela, chave primaria composta com o campo id_bas_empresa';


--
-- TOC entry 12552 (class 0 OID 0)
-- Dependencies: 692
-- Name: COLUMN sge_atividade_pessoa_horario.id_bas_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade_pessoa_horario.id_bas_empresa IS 'Identificador da tabela bas_empresa, chave primaria composta com o campo id';


--
-- TOC entry 12553 (class 0 OID 0)
-- Dependencies: 692
-- Name: COLUMN sge_atividade_pessoa_horario.id_sge_atividade_pessoa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade_pessoa_horario.id_sge_atividade_pessoa IS 'Identificador da tabela sge_atividade_pessoa junto com o campo id_bas_empresa';


--
-- TOC entry 12554 (class 0 OID 0)
-- Dependencies: 692
-- Name: COLUMN sge_atividade_pessoa_horario.dia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade_pessoa_horario.dia IS 'Dia da semana que acontece a atividade';


--
-- TOC entry 12555 (class 0 OID 0)
-- Dependencies: 692
-- Name: COLUMN sge_atividade_pessoa_horario.hora_inicio; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade_pessoa_horario.hora_inicio IS 'Hora de inicio da atividade';


--
-- TOC entry 12556 (class 0 OID 0)
-- Dependencies: 692
-- Name: COLUMN sge_atividade_pessoa_horario.hora_fim; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade_pessoa_horario.hora_fim IS 'Hora do fim da atividade';


--
-- TOC entry 693 (class 1259 OID 14564223)
-- Name: sge_atividade_pessoa_horario_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_atividade_pessoa_horario_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_atividade_pessoa_horario_id_seq OWNER TO postgres;

--
-- TOC entry 12557 (class 0 OID 0)
-- Dependencies: 693
-- Name: sge_atividade_pessoa_horario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_atividade_pessoa_horario_id_seq OWNED BY public.sge_atividade_pessoa_horario.id;


--
-- TOC entry 694 (class 1259 OID 14564225)
-- Name: sge_atividade_pessoa_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_atividade_pessoa_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_atividade_pessoa_id_seq OWNER TO postgres;

--
-- TOC entry 12558 (class 0 OID 0)
-- Dependencies: 694
-- Name: sge_atividade_pessoa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_atividade_pessoa_id_seq OWNED BY public.sge_atividade_pessoa.id;


--
-- TOC entry 695 (class 1259 OID 14564227)
-- Name: sge_atividade_pessoa_topico_resposta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_atividade_pessoa_topico_resposta (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_atividade_pessoa bigint NOT NULL,
 id_sge_educacao_especial_topico bigint NOT NULL,
 resposta text,
 data date DEFAULT now(),
 usr_login character varying(32)
);


ALTER TABLE public.sge_atividade_pessoa_topico_resposta OWNER TO postgres;

--
-- TOC entry 696 (class 1259 OID 14564234)
-- Name: sge_atividade_pessoa_topico_resposta_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_atividade_pessoa_topico_resposta_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_atividade_pessoa_topico_resposta_id_seq OWNER TO postgres;

--
-- TOC entry 12559 (class 0 OID 0)
-- Dependencies: 696
-- Name: sge_atividade_pessoa_topico_resposta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_atividade_pessoa_topico_resposta_id_seq OWNED BY public.sge_atividade_pessoa_topico_resposta.id;


--
-- TOC entry 697 (class 1259 OID 14564236)
-- Name: sge_atividade_turma; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_atividade_turma (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_atividade bigint NOT NULL,
 id_sge_turno bigint NOT NULL,
 id_sge_professor bigint,
 id_bas_sala bigint,
 nome character varying NOT NULL,
 valor numeric(9,2),
 data_cancelamento date,
 capacidade smallint
);


ALTER TABLE public.sge_atividade_turma OWNER TO postgres;

--
-- TOC entry 12560 (class 0 OID 0)
-- Dependencies: 697
-- Name: TABLE sge_atividade_turma; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sge_atividade_turma IS 'Cadastra as turmas da atividade';


--
-- TOC entry 12561 (class 0 OID 0)
-- Dependencies: 697
-- Name: COLUMN sge_atividade_turma.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade_turma.id IS 'Identificador sequencial da tabela, chave primaria composta com o campo id_bas_empresa';


--
-- TOC entry 12562 (class 0 OID 0)
-- Dependencies: 697
-- Name: COLUMN sge_atividade_turma.id_bas_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade_turma.id_bas_empresa IS 'Identificador da tabela bas_empresa, chave primaria composta com o campo id';


--
-- TOC entry 12563 (class 0 OID 0)
-- Dependencies: 697
-- Name: COLUMN sge_atividade_turma.id_sge_atividade; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade_turma.id_sge_atividade IS 'Identificador da tabela sge_atividade junto com o campo id_bas_empresa';


--
-- TOC entry 12564 (class 0 OID 0)
-- Dependencies: 697
-- Name: COLUMN sge_atividade_turma.id_sge_turno; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade_turma.id_sge_turno IS 'Identificador da tabela sge_turno';


--
-- TOC entry 12565 (class 0 OID 0)
-- Dependencies: 697
-- Name: COLUMN sge_atividade_turma.id_sge_professor; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade_turma.id_sge_professor IS 'Identificador da tabela sge_professor junto com o campo id_bas_empresa';


--
-- TOC entry 12566 (class 0 OID 0)
-- Dependencies: 697
-- Name: COLUMN sge_atividade_turma.id_bas_sala; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade_turma.id_bas_sala IS 'Identificador da tabela bas_sala junto com o campo id_bas_empresa';


--
-- TOC entry 12567 (class 0 OID 0)
-- Dependencies: 697
-- Name: COLUMN sge_atividade_turma.nome; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade_turma.nome IS 'Nome da turma da atividade';


--
-- TOC entry 12568 (class 0 OID 0)
-- Dependencies: 697
-- Name: COLUMN sge_atividade_turma.valor; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade_turma.valor IS 'Valor da turma da atividade';


--
-- TOC entry 12569 (class 0 OID 0)
-- Dependencies: 697
-- Name: COLUMN sge_atividade_turma.data_cancelamento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade_turma.data_cancelamento IS 'Data de cancelamento da turma da atividade';


--
-- TOC entry 698 (class 1259 OID 14564242)
-- Name: sge_atividade_turma_horario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_atividade_turma_horario (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_atividade_turma bigint NOT NULL,
 dia integer NOT NULL,
 hora_inicio time without time zone NOT NULL,
 hora_fim time without time zone NOT NULL
);
ALTER TABLE ONLY public.sge_atividade_turma_horario ALTER COLUMN id_sge_atividade_turma SET STATISTICS 0;


ALTER TABLE public.sge_atividade_turma_horario OWNER TO postgres;

--
-- TOC entry 12570 (class 0 OID 0)
-- Dependencies: 698
-- Name: TABLE sge_atividade_turma_horario; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sge_atividade_turma_horario IS 'Cadastra os horários da turma da atividade';


--
-- TOC entry 12571 (class 0 OID 0)
-- Dependencies: 698
-- Name: COLUMN sge_atividade_turma_horario.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade_turma_horario.id IS 'Identificador sequencial da tabela, chave primaria composta com o campo id_bas_empresa';


--
-- TOC entry 12572 (class 0 OID 0)
-- Dependencies: 698
-- Name: COLUMN sge_atividade_turma_horario.id_bas_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade_turma_horario.id_bas_empresa IS 'Identificador da tabela bas_empresa, chave primaria composta com o campo id';


--
-- TOC entry 12573 (class 0 OID 0)
-- Dependencies: 698
-- Name: COLUMN sge_atividade_turma_horario.id_sge_atividade_turma; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade_turma_horario.id_sge_atividade_turma IS 'Identificador da tabela sge_atividade_turma junto com o campo id_bas_empresa';


--
-- TOC entry 12574 (class 0 OID 0)
-- Dependencies: 698
-- Name: COLUMN sge_atividade_turma_horario.dia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade_turma_horario.dia IS 'Dia da semana que acontece a atividade';


--
-- TOC entry 12575 (class 0 OID 0)
-- Dependencies: 698
-- Name: COLUMN sge_atividade_turma_horario.hora_inicio; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade_turma_horario.hora_inicio IS 'Hora de inicio da atividade';


--
-- TOC entry 12576 (class 0 OID 0)
-- Dependencies: 698
-- Name: COLUMN sge_atividade_turma_horario.hora_fim; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_atividade_turma_horario.hora_fim IS 'Hora do fim da atividade';


--
-- TOC entry 699 (class 1259 OID 14564245)
-- Name: sge_atividade_turma_horario_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_atividade_turma_horario_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_atividade_turma_horario_id_seq OWNER TO postgres;

--
-- TOC entry 12577 (class 0 OID 0)
-- Dependencies: 699
-- Name: sge_atividade_turma_horario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_atividade_turma_horario_id_seq OWNED BY public.sge_atividade_turma_horario.id;


--
-- TOC entry 700 (class 1259 OID 14564247)
-- Name: sge_atividade_turma_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_atividade_turma_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_atividade_turma_id_seq OWNER TO postgres;

--
-- TOC entry 12578 (class 0 OID 0)
-- Dependencies: 700
-- Name: sge_atividade_turma_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_atividade_turma_id_seq OWNED BY public.sge_atividade_turma.id;


--
-- TOC entry 701 (class 1259 OID 14564249)
-- Name: sge_aula; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_aula (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_turma bigint,
 id_sge_professor bigint NOT NULL,
 id_sge_modulo bigint,
 id_sge_plano_aula bigint,
 data date NOT NULL,
 quantidade integer,
 tarefa_casa integer,
 anotacao text NOT NULL,
 consideracao_final text,
 data_inclusao date,
 id_sge_turma_ano bigint NOT NULL,
 id_sge_disciplina bigint,
 id_sge_grade_horario bigint,
 aula_executada character(1),
 id_sge_etapa bigint
);


ALTER TABLE public.sge_aula OWNER TO postgres;

--
-- TOC entry 702 (class 1259 OID 14564255)
-- Name: sge_aula_executadas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_aula_executadas (
 id integer NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_professor bigint,
 id_sge_turma bigint,
 data date,
 id_sge_grade_horario bigint NOT NULL
);


ALTER TABLE public.sge_aula_executadas OWNER TO postgres;

--
-- TOC entry 703 (class 1259 OID 14564258)
-- Name: sge_aula_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_aula_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_aula_id_seq OWNER TO postgres;

--
-- TOC entry 12579 (class 0 OID 0)
-- Dependencies: 703
-- Name: sge_aula_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_aula_id_seq OWNED BY public.sge_aula.id;


--
-- TOC entry 704 (class 1259 OID 14564260)
-- Name: sge_aula_planejada; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_aula_planejada (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_professor bigint NOT NULL,
 id_sge_turma bigint NOT NULL,
 data date,
 numero smallint NOT NULL,
 id_sge_etapa bigint,
 descricao character varying(50),
 sge_grade_horario bigint
);


ALTER TABLE public.sge_aula_planejada OWNER TO postgres;

--
-- TOC entry 705 (class 1259 OID 14564263)
-- Name: sge_aula_planejada_executada; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_aula_planejada_executada (
 id integer NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_aula_planejada bigint NOT NULL,
 id_sge_aula_executada bigint NOT NULL
);


ALTER TABLE public.sge_aula_planejada_executada OWNER TO postgres;

--
-- TOC entry 706 (class 1259 OID 14564266)
-- Name: sge_aula_planejada_executada_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_aula_planejada_executada_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_aula_planejada_executada_id_seq OWNER TO postgres;

--
-- TOC entry 12580 (class 0 OID 0)
-- Dependencies: 706
-- Name: sge_aula_planejada_executada_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_aula_planejada_executada_id_seq OWNED BY public.sge_aula_planejada_executada.id;


--
-- TOC entry 707 (class 1259 OID 14564268)
-- Name: sge_aula_planejada_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_aula_planejada_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_aula_planejada_id_seq OWNER TO postgres;

--
-- TOC entry 12581 (class 0 OID 0)
-- Dependencies: 707
-- Name: sge_aula_planejada_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_aula_planejada_id_seq OWNED BY public.sge_aula_planejada.id;


--
-- TOC entry 708 (class 1259 OID 14564270)
-- Name: sge_aula_turma_aluno_frequencia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_aula_turma_aluno_frequencia (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_aula bigint,
 id_sge_turma_aluno bigint,
 presente character(1),
 id_sge_disciplina bigint,
 data_frequencia date,
 ordem smallint,
 justificativa character varying(150)
);


ALTER TABLE public.sge_aula_turma_aluno_frequencia OWNER TO postgres;

--
-- TOC entry 709 (class 1259 OID 14564273)
-- Name: sge_aula_turma_aluno_frequencia_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_aula_turma_aluno_frequencia_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_aula_turma_aluno_frequencia_id_seq OWNER TO postgres;

--
-- TOC entry 12582 (class 0 OID 0)
-- Dependencies: 709
-- Name: sge_aula_turma_aluno_frequencia_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_aula_turma_aluno_frequencia_id_seq OWNED BY public.sge_aula_turma_aluno_frequencia.id;


--
-- TOC entry 710 (class 1259 OID 14564275)
-- Name: sge_aula_turma_aluno_observacao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_aula_turma_aluno_observacao (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_aula bigint,
 id_sge_turma_aluno bigint,
 observacao text
);


ALTER TABLE public.sge_aula_turma_aluno_observacao OWNER TO postgres;

--
-- TOC entry 711 (class 1259 OID 14564281)
-- Name: sge_aula_turma_aluno_observacao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_aula_turma_aluno_observacao_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_aula_turma_aluno_observacao_id_seq OWNER TO postgres;

--
-- TOC entry 12583 (class 0 OID 0)
-- Dependencies: 711
-- Name: sge_aula_turma_aluno_observacao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_aula_turma_aluno_observacao_id_seq OWNED BY public.sge_aula_turma_aluno_observacao.id;


--
-- TOC entry 712 (class 1259 OID 14564283)
-- Name: sge_aulas_executadas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_aulas_executadas_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_aulas_executadas_id_seq OWNER TO postgres;

--
-- TOC entry 12584 (class 0 OID 0)
-- Dependencies: 712
-- Name: sge_aulas_executadas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_aulas_executadas_id_seq OWNED BY public.sge_aula_executadas.id;


--
-- TOC entry 713 (class 1259 OID 14564285)
-- Name: sge_avaliacao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_avaliacao (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(100) NOT NULL,
 sigla character varying(10) NOT NULL,
 sequencia integer,
 tipo integer
);


ALTER TABLE public.sge_avaliacao OWNER TO postgres;

--
-- TOC entry 714 (class 1259 OID 14564288)
-- Name: sge_criterio_etapa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_criterio_etapa (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_etapa bigint NOT NULL,
 id_sge_criterio_final bigint NOT NULL,
 liberada character(1) DEFAULT 'N'::bpchar,
 formula text,
 mes integer,
 define_situacao character(1) DEFAULT 'N'::bpchar,
 recuperacao character(1) DEFAULT 'N'::bpchar,
 professor character(1) DEFAULT 'N'::bpchar,
 prova_final character(1) DEFAULT 'N'::bpchar,
 ordem smallint,
 divide_notas character(1),
 forcar_recuperacao character(1) DEFAULT 'N'::bpchar,
 nota_maxima numeric(5,2),
 peso smallint,
 agrega_media character(1),
 substituida character(1) DEFAULT 'N'::bpchar,
 substitui_etapa character(1) DEFAULT 'N'::bpchar,
 substitui_menor_nota character(1) DEFAULT 'N'::bpchar,
 substitui_nota_final character(1) DEFAULT 'N'::bpchar,
 complementa_nota_final character(1) DEFAULT 'N'::bpchar,
 possui_conselho character(1) DEFAULT 'S'::bpchar NOT NULL,
 conselho_define_situacao character(1) DEFAULT 'N'::bpchar NOT NULL,
 nota_minima numeric(6,3) DEFAULT 0 NOT NULL,
 usa_conversao character(1) DEFAULT 'N'::bpchar NOT NULL,
 periodo_digitacao_inicio character varying(4),
 periodo_digitacao_fim character varying(4),
 nota_objetivo numeric(6,3),
 id_sge_etapa_substituicao bigint,
 recuperacao_paralela character(1)
);


ALTER TABLE public.sge_criterio_etapa OWNER TO postgres;

--
-- TOC entry 12585 (class 0 OID 0)
-- Dependencies: 714
-- Name: COLUMN sge_criterio_etapa.liberada; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_criterio_etapa.liberada IS 'S=sim, N=nao';


--
-- TOC entry 12586 (class 0 OID 0)
-- Dependencies: 714
-- Name: COLUMN sge_criterio_etapa.define_situacao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_criterio_etapa.define_situacao IS 'S=sim, N=nao';


--
-- TOC entry 12587 (class 0 OID 0)
-- Dependencies: 714
-- Name: COLUMN sge_criterio_etapa.recuperacao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_criterio_etapa.recuperacao IS 'S=sim, N=nao';


--
-- TOC entry 12588 (class 0 OID 0)
-- Dependencies: 714
-- Name: COLUMN sge_criterio_etapa.professor; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_criterio_etapa.professor IS 'S=sim, N=nao';


--
-- TOC entry 12589 (class 0 OID 0)
-- Dependencies: 714
-- Name: COLUMN sge_criterio_etapa.prova_final; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_criterio_etapa.prova_final IS 'S=sim, N=nao';


--
-- TOC entry 12590 (class 0 OID 0)
-- Dependencies: 714
-- Name: COLUMN sge_criterio_etapa.divide_notas; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_criterio_etapa.divide_notas IS '''S'' = Sim, ''N'' = Não';


--
-- TOC entry 12591 (class 0 OID 0)
-- Dependencies: 714
-- Name: COLUMN sge_criterio_etapa.forcar_recuperacao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_criterio_etapa.forcar_recuperacao IS '''S'' = Sim, ''N'' = Não';


--
-- TOC entry 12592 (class 0 OID 0)
-- Dependencies: 714
-- Name: COLUMN sge_criterio_etapa.agrega_media; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_criterio_etapa.agrega_media IS '"S" = Sim, "N" = Não';


--
-- TOC entry 12593 (class 0 OID 0)
-- Dependencies: 714
-- Name: COLUMN sge_criterio_etapa.substituida; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_criterio_etapa.substituida IS '''S'' = Sim, ''N'' = Não.
Campo que diz se a etapa será substituída por alguma recuperação.';


--
-- TOC entry 12594 (class 0 OID 0)
-- Dependencies: 714
-- Name: COLUMN sge_criterio_etapa.substitui_etapa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_criterio_etapa.substitui_etapa IS '''S'' = Sim, ''N'' = Não. Campo que define se a prova de recuperação irá substituir alguma etapa.';


--
-- TOC entry 12595 (class 0 OID 0)
-- Dependencies: 714
-- Name: COLUMN sge_criterio_etapa.substitui_menor_nota; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_criterio_etapa.substitui_menor_nota IS '''S'' = Sim, ''N'' = Não. Campo que define se a prova de recuperação irá substituir a etapa de menor nota.';


--
-- TOC entry 12596 (class 0 OID 0)
-- Dependencies: 714
-- Name: COLUMN sge_criterio_etapa.substitui_nota_final; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_criterio_etapa.substitui_nota_final IS '''S'' = Sim, ''N'' = Não. Campo que define se a prova de recuperação irá substituir a nota final.';


--
-- TOC entry 12597 (class 0 OID 0)
-- Dependencies: 714
-- Name: COLUMN sge_criterio_etapa.complementa_nota_final; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_criterio_etapa.complementa_nota_final IS '''S'' = Sim, ''N'' = Não. Campo que define se a prova de recuperação irá complementar a nota final.';


--
-- TOC entry 12598 (class 0 OID 0)
-- Dependencies: 714
-- Name: COLUMN sge_criterio_etapa.possui_conselho; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_criterio_etapa.possui_conselho IS '''S'' = ''Sim'', ''N'' = ''Não'' Define se a etapa possui conselho de classe';


--
-- TOC entry 12599 (class 0 OID 0)
-- Dependencies: 714
-- Name: COLUMN sge_criterio_etapa.conselho_define_situacao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_criterio_etapa.conselho_define_situacao IS '''S'' = ''Sim'', ''N'' = ''Não'' Define se o conselho define situação do aluno';


--
-- TOC entry 12600 (class 0 OID 0)
-- Dependencies: 714
-- Name: COLUMN sge_criterio_etapa.nota_minima; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_criterio_etapa.nota_minima IS 'Nota parcial mínima que o tad precisa ter para estar apto a cursar essa etapa.';


--
-- TOC entry 12601 (class 0 OID 0)
-- Dependencies: 714
-- Name: COLUMN sge_criterio_etapa.usa_conversao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_criterio_etapa.usa_conversao IS 'Informa se a etapa usa conversão de notas para saber se o aluno pode ou não cursar essa etapa, caso ''S'', ele não informa a nota_minima';


--
-- TOC entry 12602 (class 0 OID 0)
-- Dependencies: 714
-- Name: COLUMN sge_criterio_etapa.periodo_digitacao_inicio; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_criterio_etapa.periodo_digitacao_inicio IS 'periodo inicial de digitação de notas';


--
-- TOC entry 12603 (class 0 OID 0)
-- Dependencies: 714
-- Name: COLUMN sge_criterio_etapa.periodo_digitacao_fim; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_criterio_etapa.periodo_digitacao_fim IS 'periodo final de digitação de notas';


--
-- TOC entry 12604 (class 0 OID 0)
-- Dependencies: 714
-- Name: COLUMN sge_criterio_etapa.nota_objetivo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_criterio_etapa.nota_objetivo IS 'Campo utilizado caso a etapa seja uma etapa de recuperação ou prova final que não utilize conversao de notas.É a nota necescessária para aprovação.';


--
-- TOC entry 12605 (class 0 OID 0)
-- Dependencies: 714
-- Name: COLUMN sge_criterio_etapa.id_sge_etapa_substituicao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_criterio_etapa.id_sge_etapa_substituicao IS 'Etapa que a recuperação substitui';


--
-- TOC entry 715 (class 1259 OID 14564309)
-- Name: sge_avaliacao_etapa_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_avaliacao_etapa_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_avaliacao_etapa_id_seq OWNER TO postgres;

--
-- TOC entry 12606 (class 0 OID 0)
-- Dependencies: 715
-- Name: sge_avaliacao_etapa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_avaliacao_etapa_id_seq OWNED BY public.sge_criterio_etapa.id;


--
-- TOC entry 716 (class 1259 OID 14564311)
-- Name: sge_etapa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_etapa (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(100) NOT NULL,
 sigla character varying(10) NOT NULL,
 recebe_falta character(1) NOT NULL,
 sigla_falta character varying(10),
 usa_conceito character(1) NOT NULL,
 sigla_conceito character varying(10),
 tem_recuperacao character(1) NOT NULL,
 sigla_recuperacao character varying(10),
 exibe_parcial character(1) NOT NULL,
 sigla_parcial character varying(10),
 ordem smallint,
 ativo character(1)
);


ALTER TABLE public.sge_etapa OWNER TO postgres;

--
-- TOC entry 12607 (class 0 OID 0)
-- Dependencies: 716
-- Name: COLUMN sge_etapa.recebe_falta; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_etapa.recebe_falta IS 'S=sim, N=nao';


--
-- TOC entry 12608 (class 0 OID 0)
-- Dependencies: 716
-- Name: COLUMN sge_etapa.usa_conceito; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_etapa.usa_conceito IS 'S=sim, N=nao';


--
-- TOC entry 12609 (class 0 OID 0)
-- Dependencies: 716
-- Name: COLUMN sge_etapa.tem_recuperacao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_etapa.tem_recuperacao IS 'S=sim, N=nao';


--
-- TOC entry 12610 (class 0 OID 0)
-- Dependencies: 716
-- Name: COLUMN sge_etapa.exibe_parcial; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_etapa.exibe_parcial IS 'S=sim, N=nao';


--
-- TOC entry 12611 (class 0 OID 0)
-- Dependencies: 716
-- Name: COLUMN sge_etapa.ativo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_etapa.ativo IS 'S=Sim, N=Não';


--
-- TOC entry 717 (class 1259 OID 14564314)
-- Name: sge_avaliacao_etapa_tipo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_avaliacao_etapa_tipo_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_avaliacao_etapa_tipo_id_seq OWNER TO postgres;

--
-- TOC entry 12612 (class 0 OID 0)
-- Dependencies: 717
-- Name: sge_avaliacao_etapa_tipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_avaliacao_etapa_tipo_id_seq OWNED BY public.sge_etapa.id;


--
-- TOC entry 718 (class 1259 OID 14564316)
-- Name: sge_avaliacao_inicial; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_avaliacao_inicial (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_turma_aluno bigint NOT NULL,
 id_sge_professor bigint,
 avaliacao text,
 data_avaliacao date,
 data_inicial date,
 data_final date
);


ALTER TABLE public.sge_avaliacao_inicial OWNER TO postgres;

--
-- TOC entry 12613 (class 0 OID 0)
-- Dependencies: 718
-- Name: COLUMN sge_avaliacao_inicial.data_inicial; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_avaliacao_inicial.data_inicial IS 'Data inicial do período de digitação da avaliação inicial';


--
-- TOC entry 12614 (class 0 OID 0)
-- Dependencies: 718
-- Name: COLUMN sge_avaliacao_inicial.data_final; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_avaliacao_inicial.data_final IS 'Data final do período de digitação da avaliação inicial';


--
-- TOC entry 719 (class 1259 OID 14564322)
-- Name: sge_avaliacao_inicial_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_avaliacao_inicial_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_avaliacao_inicial_id_seq OWNER TO postgres;

--
-- TOC entry 12615 (class 0 OID 0)
-- Dependencies: 719
-- Name: sge_avaliacao_inicial_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_avaliacao_inicial_id_seq OWNED BY public.sge_avaliacao_inicial.id;


--
-- TOC entry 720 (class 1259 OID 14564324)
-- Name: sge_avaliacao_inicial_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_avaliacao_inicial_log (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_aluno bigint NOT NULL,
 login character(32) NOT NULL,
 data_hora timestamp without time zone NOT NULL,
 tipo character(1) NOT NULL,
 estado_anterior text,
 estado_atual text,
 professor character varying(200) NOT NULL
);


ALTER TABLE public.sge_avaliacao_inicial_log OWNER TO postgres;

--
-- TOC entry 721 (class 1259 OID 14564330)
-- Name: sge_avaliacao_inicial_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_avaliacao_inicial_log_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_avaliacao_inicial_log_id_seq OWNER TO postgres;

--
-- TOC entry 12616 (class 0 OID 0)
-- Dependencies: 721
-- Name: sge_avaliacao_inicial_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_avaliacao_inicial_log_id_seq OWNED BY public.sge_avaliacao_inicial_log.id;


--
-- TOC entry 722 (class 1259 OID 14564332)
-- Name: sge_avaliacao_tipo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_avaliacao_tipo_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_avaliacao_tipo_id_seq OWNER TO postgres;

--
-- TOC entry 12617 (class 0 OID 0)
-- Dependencies: 722
-- Name: sge_avaliacao_tipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_avaliacao_tipo_id_seq OWNED BY public.sge_avaliacao.id;


--
-- TOC entry 723 (class 1259 OID 14564334)
-- Name: sge_criterio_final; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_criterio_final (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(100) NOT NULL,
 ano integer NOT NULL,
 texto text,
 media_boletim numeric(6,3),
 media_recuperacao numeric(6,3),
 media_conselho numeric(6,3),
 divide_notas character(1),
 forcar_recuperacao character(1),
 nota_maxima numeric(6,3),
 nota_minima_conselho numeric(6,3) DEFAULT 3.5 NOT NULL,
 quant_rec_maxima_conselho smallint DEFAULT 3 NOT NULL,
 limite_falta_situacao character(1),
 nomenclatura_etapa character varying DEFAULT 'ETAPA'::character varying NOT NULL
);


ALTER TABLE public.sge_criterio_final OWNER TO postgres;

--
-- TOC entry 12618 (class 0 OID 0)
-- Dependencies: 723
-- Name: COLUMN sge_criterio_final.ano; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_criterio_final.ano IS 'Ano de criacao';


--
-- TOC entry 12619 (class 0 OID 0)
-- Dependencies: 723
-- Name: COLUMN sge_criterio_final.media_recuperacao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_criterio_final.media_recuperacao IS 'Não é mais utilizada, o campo pode ser deletado. Não deletei por segurança.';


--
-- TOC entry 12620 (class 0 OID 0)
-- Dependencies: 723
-- Name: COLUMN sge_criterio_final.divide_notas; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_criterio_final.divide_notas IS '"S" = Sim, "N" = Não';


--
-- TOC entry 12621 (class 0 OID 0)
-- Dependencies: 723
-- Name: COLUMN sge_criterio_final.forcar_recuperacao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_criterio_final.forcar_recuperacao IS '"S" = Sim, "N" = Não';


--
-- TOC entry 12622 (class 0 OID 0)
-- Dependencies: 723
-- Name: COLUMN sge_criterio_final.nota_minima_conselho; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_criterio_final.nota_minima_conselho IS 'Nota mínima necessária para o aluno ir ao conselho';


--
-- TOC entry 12623 (class 0 OID 0)
-- Dependencies: 723
-- Name: COLUMN sge_criterio_final.quant_rec_maxima_conselho; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_criterio_final.quant_rec_maxima_conselho IS 'Número máximo de disciplinas que o aluno pode reprovar para ir para o conselho';


--
-- TOC entry 724 (class 1259 OID 14564343)
-- Name: sge_boletim_formula_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_boletim_formula_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_boletim_formula_id_seq OWNER TO postgres;

--
-- TOC entry 12624 (class 0 OID 0)
-- Dependencies: 724
-- Name: sge_boletim_formula_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_boletim_formula_id_seq OWNED BY public.sge_criterio_final.id;


--
-- TOC entry 725 (class 1259 OID 14564345)
-- Name: sge_conceito; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_conceito (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(100) NOT NULL
);


ALTER TABLE public.sge_conceito OWNER TO postgres;

--
-- TOC entry 726 (class 1259 OID 14564348)
-- Name: sge_conceito_descritivo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_conceito_descritivo (
 id bigint DEFAULT nextval('public.id_sge_conceito_descritivo_id_seq'::regclass) NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(50),
 id_sge_conceito_descritivo_tipo integer
);


ALTER TABLE public.sge_conceito_descritivo OWNER TO postgres;

--
-- TOC entry 727 (class 1259 OID 14564352)
-- Name: sge_conceito_descritivo_etapa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_conceito_descritivo_etapa (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_conceito_descritivo bigint,
 id_sge_etapa bigint
);


ALTER TABLE public.sge_conceito_descritivo_etapa OWNER TO postgres;

--
-- TOC entry 728 (class 1259 OID 14564355)
-- Name: sge_conceito_descritivo_etapa_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_conceito_descritivo_etapa_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_conceito_descritivo_etapa_id_seq OWNER TO postgres;

--
-- TOC entry 12625 (class 0 OID 0)
-- Dependencies: 728
-- Name: sge_conceito_descritivo_etapa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_conceito_descritivo_etapa_id_seq OWNED BY public.sge_conceito_descritivo_etapa.id;


--
-- TOC entry 729 (class 1259 OID 14564357)
-- Name: sge_conceito_descritivo_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_conceito_descritivo_group (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_conceito_descritivo bigint,
 group_id bigint
);


ALTER TABLE public.sge_conceito_descritivo_group OWNER TO postgres;

--
-- TOC entry 730 (class 1259 OID 14564360)
-- Name: sge_conceito_descritivo_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_conceito_descritivo_group_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_conceito_descritivo_group_id_seq OWNER TO postgres;

--
-- TOC entry 12626 (class 0 OID 0)
-- Dependencies: 730
-- Name: sge_conceito_descritivo_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_conceito_descritivo_group_id_seq OWNED BY public.sge_conceito_descritivo_group.id;


--
-- TOC entry 731 (class 1259 OID 14564362)
-- Name: sge_conceito_descritivo_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_conceito_descritivo_item (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_conceito_descritivo bigint NOT NULL,
 descricao text NOT NULL,
 id_sge_disciplina bigint,
 ordem smallint,
 precisa_avaliacao character(1) DEFAULT 'S'::bpchar
);


ALTER TABLE public.sge_conceito_descritivo_item OWNER TO postgres;

--
-- TOC entry 12627 (class 0 OID 0)
-- Dependencies: 731
-- Name: COLUMN sge_conceito_descritivo_item.ordem; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_conceito_descritivo_item.ordem IS 'Ordem, por disciplina';


--
-- TOC entry 732 (class 1259 OID 14564369)
-- Name: sge_conceito_descritivo_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_conceito_descritivo_item_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_conceito_descritivo_item_id_seq OWNER TO postgres;

--
-- TOC entry 12628 (class 0 OID 0)
-- Dependencies: 732
-- Name: sge_conceito_descritivo_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_conceito_descritivo_item_id_seq OWNED BY public.sge_conceito_descritivo_item.id;


--
-- TOC entry 733 (class 1259 OID 14564371)
-- Name: sge_conceito_descritivo_item_turma_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_conceito_descritivo_item_turma_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_conceito_descritivo_item_turma_id_seq OWNER TO postgres;

--
-- TOC entry 734 (class 1259 OID 14564373)
-- Name: sge_conceito_descritivo_opcao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_conceito_descritivo_opcao (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_conceito_descritivo bigint,
 descricao character varying(100),
 sigla character(5),
 ordem smallint
);


ALTER TABLE public.sge_conceito_descritivo_opcao OWNER TO postgres;

--
-- TOC entry 12629 (class 0 OID 0)
-- Dependencies: 734
-- Name: COLUMN sge_conceito_descritivo_opcao.ordem; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_conceito_descritivo_opcao.ordem IS 'Ordem de exibição das respostas nos combos';


--
-- TOC entry 735 (class 1259 OID 14564376)
-- Name: sge_conceito_descritivo_opcao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_conceito_descritivo_opcao_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_conceito_descritivo_opcao_id_seq OWNER TO postgres;

--
-- TOC entry 12630 (class 0 OID 0)
-- Dependencies: 735
-- Name: sge_conceito_descritivo_opcao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_conceito_descritivo_opcao_id_seq OWNED BY public.sge_conceito_descritivo_opcao.id;


--
-- TOC entry 736 (class 1259 OID 14564378)
-- Name: sge_conceito_descritivo_tipo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_conceito_descritivo_tipo (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(50)
);


ALTER TABLE public.sge_conceito_descritivo_tipo OWNER TO postgres;

--
-- TOC entry 737 (class 1259 OID 14564381)
-- Name: sge_conceito_descritivo_tipo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_conceito_descritivo_tipo_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_conceito_descritivo_tipo_id_seq OWNER TO postgres;

--
-- TOC entry 12631 (class 0 OID 0)
-- Dependencies: 737
-- Name: sge_conceito_descritivo_tipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_conceito_descritivo_tipo_id_seq OWNED BY public.sge_conceito_descritivo_tipo.id;


--
-- TOC entry 738 (class 1259 OID 14564383)
-- Name: sge_conceito_descritivo_turma; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_conceito_descritivo_turma (
 id bigint DEFAULT nextval('public.sge_conceito_descritivo_item_turma_id_seq'::regclass) NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_conceito_descritivo bigint,
 id_sge_turma bigint,
 ano integer NOT NULL,
 serie_real character varying(50)
);


ALTER TABLE public.sge_conceito_descritivo_turma OWNER TO postgres;

--
-- TOC entry 12632 (class 0 OID 0)
-- Dependencies: 738
-- Name: COLUMN sge_conceito_descritivo_turma.serie_real; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_conceito_descritivo_turma.serie_real IS 'Série real do aluno, solução paleativa para turmas multisseriadas em anguera';


--
-- TOC entry 739 (class 1259 OID 14564387)
-- Name: sge_conceito_faixa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_conceito_faixa (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_conceito bigint NOT NULL,
 id_sge_situacao_disciplina bigint NOT NULL,
 nome character varying(100) NOT NULL,
 sigla character varying(8) NOT NULL,
 faixa_inicial numeric(6,3) NOT NULL,
 faixa_final numeric(6,3) NOT NULL
);


ALTER TABLE public.sge_conceito_faixa OWNER TO postgres;

--
-- TOC entry 740 (class 1259 OID 14564390)
-- Name: sge_conceito_faixa_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_conceito_faixa_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_conceito_faixa_id_seq OWNER TO postgres;

--
-- TOC entry 12633 (class 0 OID 0)
-- Dependencies: 740
-- Name: sge_conceito_faixa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_conceito_faixa_id_seq OWNED BY public.sge_conceito_faixa.id;


--
-- TOC entry 741 (class 1259 OID 14564392)
-- Name: sge_conceito_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_conceito_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_conceito_id_seq OWNER TO postgres;

--
-- TOC entry 12634 (class 0 OID 0)
-- Dependencies: 741
-- Name: sge_conceito_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_conceito_id_seq OWNED BY public.sge_conceito.id;


--
-- TOC entry 742 (class 1259 OID 14564394)
-- Name: sge_conceito_turma; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_conceito_turma (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_conceito bigint,
 id_sge_turma_ano bigint
);


ALTER TABLE public.sge_conceito_turma OWNER TO postgres;

--
-- TOC entry 743 (class 1259 OID 14564397)
-- Name: sge_conceito_turma_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_conceito_turma_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_conceito_turma_id_seq OWNER TO postgres;

--
-- TOC entry 12635 (class 0 OID 0)
-- Dependencies: 743
-- Name: sge_conceito_turma_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_conceito_turma_id_seq OWNED BY public.sge_conceito_turma.id;


--
-- TOC entry 744 (class 1259 OID 14564399)
-- Name: sge_conselho_classe; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_conselho_classe (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_turma bigint NOT NULL,
 id_sge_etapa bigint,
 data_realizacao_conselho date NOT NULL,
 tipo_conselho character(1) NOT NULL,
 ata_reuniao text NOT NULL,
 ano_letivo smallint
);


ALTER TABLE public.sge_conselho_classe OWNER TO postgres;

--
-- TOC entry 12636 (class 0 OID 0)
-- Dependencies: 744
-- Name: COLUMN sge_conselho_classe.tipo_conselho; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_conselho_classe.tipo_conselho IS 'P = Parcial, F = Final';


--
-- TOC entry 745 (class 1259 OID 14564405)
-- Name: sge_conselho_classe_aluno; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_conselho_classe_aluno (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_aluno bigint NOT NULL,
 id_sge_conselho_classe bigint NOT NULL,
 id_sge_situacao_pedagogica bigint,
 id_sge_situacao_pedagogica_anterior bigint,
 id_sge_situacao_disciplina_anterior bigint,
 media_anterior numeric(6,3),
 observacao text,
 complemento text
);


ALTER TABLE public.sge_conselho_classe_aluno OWNER TO postgres;

--
-- TOC entry 12637 (class 0 OID 0)
-- Dependencies: 745
-- Name: COLUMN sge_conselho_classe_aluno.complemento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_conselho_classe_aluno.complemento IS 'Utilizado para complementar o relatório semestral do conselho de classe (EJA)';


--
-- TOC entry 746 (class 1259 OID 14564411)
-- Name: sge_conselho_classe_aluno_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_conselho_classe_aluno_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_conselho_classe_aluno_id_seq OWNER TO postgres;

--
-- TOC entry 12638 (class 0 OID 0)
-- Dependencies: 746
-- Name: sge_conselho_classe_aluno_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_conselho_classe_aluno_id_seq OWNED BY public.sge_conselho_classe_aluno.id;


--
-- TOC entry 747 (class 1259 OID 14564413)
-- Name: sge_conselho_classe_colaborador; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_conselho_classe_colaborador (
 id_bas_empresa bigint NOT NULL,
 id_bas_colaborador bigint NOT NULL,
 id_sge_conselho_classe bigint NOT NULL
);


ALTER TABLE public.sge_conselho_classe_colaborador OWNER TO postgres;

--
-- TOC entry 748 (class 1259 OID 14564416)
-- Name: sge_conselho_classe_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_conselho_classe_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_conselho_classe_id_seq OWNER TO postgres;

--
-- TOC entry 12639 (class 0 OID 0)
-- Dependencies: 748
-- Name: sge_conselho_classe_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_conselho_classe_id_seq OWNED BY public.sge_conselho_classe.id;


--
-- TOC entry 749 (class 1259 OID 14564418)
-- Name: sge_conteudo_planejado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_conteudo_planejado (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_conteudo_programatico_assunto bigint NOT NULL,
 id_sge_aula_planejada bigint NOT NULL
);


ALTER TABLE public.sge_conteudo_planejado OWNER TO postgres;

--
-- TOC entry 750 (class 1259 OID 14564421)
-- Name: sge_conteudo_planejado_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_conteudo_planejado_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_conteudo_planejado_id_seq OWNER TO postgres;

--
-- TOC entry 12640 (class 0 OID 0)
-- Dependencies: 750
-- Name: sge_conteudo_planejado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_conteudo_planejado_id_seq OWNED BY public.sge_conteudo_planejado.id;


--
-- TOC entry 751 (class 1259 OID 14564423)
-- Name: sge_conteudo_programatico; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_conteudo_programatico (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_disciplina bigint NOT NULL,
 id_sge_grade bigint,
 id_sge_etapa bigint,
 id_bas_colaborador_coordenador bigint,
 ano_letivo smallint NOT NULL,
 descricao character varying(100),
 id_cfg_curso bigint,
 id_cfg_serie bigint,
 observacao text,
 nome character varying(50)
);


ALTER TABLE public.sge_conteudo_programatico OWNER TO postgres;

--
-- TOC entry 752 (class 1259 OID 14564429)
-- Name: sge_conteudo_programatico_assunto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_conteudo_programatico_assunto (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_conteudo_programatico bigint NOT NULL,
 id_sge_assunto bigint,
 ordem smallint NOT NULL,
 assunto text,
 id_bas_area_conhecimento bigint
);


ALTER TABLE public.sge_conteudo_programatico_assunto OWNER TO postgres;

--
-- TOC entry 753 (class 1259 OID 14564435)
-- Name: sge_conteudo_programatico_assunto_aula; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_conteudo_programatico_assunto_aula (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_conteudo_programatico_assunto bigint,
 id_sge_aula bigint,
 objeto_conteudo character varying(150)
);


ALTER TABLE public.sge_conteudo_programatico_assunto_aula OWNER TO postgres;

--
-- TOC entry 754 (class 1259 OID 14564438)
-- Name: sge_conteudo_programatico_assunto_aula_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_conteudo_programatico_assunto_aula_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_conteudo_programatico_assunto_aula_id_seq OWNER TO postgres;

--
-- TOC entry 12641 (class 0 OID 0)
-- Dependencies: 754
-- Name: sge_conteudo_programatico_assunto_aula_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_conteudo_programatico_assunto_aula_id_seq OWNED BY public.sge_conteudo_programatico_assunto_aula.id;


--
-- TOC entry 755 (class 1259 OID 14564440)
-- Name: sge_conteudo_programatico_assunto_etapa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_conteudo_programatico_assunto_etapa (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_conteudo_programatico_assunto bigint,
 id_sge_etapa bigint
);


ALTER TABLE public.sge_conteudo_programatico_assunto_etapa OWNER TO postgres;

--
-- TOC entry 756 (class 1259 OID 14564443)
-- Name: sge_conteudo_programatico_assunto_etapa_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_conteudo_programatico_assunto_etapa_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_conteudo_programatico_assunto_etapa_id_seq OWNER TO postgres;

--
-- TOC entry 12642 (class 0 OID 0)
-- Dependencies: 756
-- Name: sge_conteudo_programatico_assunto_etapa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_conteudo_programatico_assunto_etapa_id_seq OWNED BY public.sge_conteudo_programatico_assunto_etapa.id;


--
-- TOC entry 757 (class 1259 OID 14564445)
-- Name: sge_conteudo_programatico_assunto_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_conteudo_programatico_assunto_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_conteudo_programatico_assunto_id_seq OWNER TO postgres;

--
-- TOC entry 12643 (class 0 OID 0)
-- Dependencies: 757
-- Name: sge_conteudo_programatico_assunto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_conteudo_programatico_assunto_id_seq OWNED BY public.sge_conteudo_programatico_assunto.id;


--
-- TOC entry 758 (class 1259 OID 14564447)
-- Name: sge_conteudo_programatico_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_conteudo_programatico_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_conteudo_programatico_id_seq OWNER TO postgres;

--
-- TOC entry 12644 (class 0 OID 0)
-- Dependencies: 758
-- Name: sge_conteudo_programatico_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_conteudo_programatico_id_seq OWNED BY public.sge_conteudo_programatico.id;


--
-- TOC entry 759 (class 1259 OID 14564449)
-- Name: sge_conteudo_programatico_serie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_conteudo_programatico_serie (
 id bigint NOT NULL,
 id_sge_conteudo_programatico bigint,
 id_sge_serie bigint,
 id_bas_empresa bigint
);


ALTER TABLE public.sge_conteudo_programatico_serie OWNER TO postgres;

--
-- TOC entry 760 (class 1259 OID 14564452)
-- Name: sge_conteudo_programatico_serie_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_conteudo_programatico_serie_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_conteudo_programatico_serie_id_seq OWNER TO postgres;

--
-- TOC entry 12645 (class 0 OID 0)
-- Dependencies: 760
-- Name: sge_conteudo_programatico_serie_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_conteudo_programatico_serie_id_seq OWNED BY public.sge_conteudo_programatico_serie.id;


--
-- TOC entry 761 (class 1259 OID 14564454)
-- Name: sge_contrato; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_contrato (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_turma_aluno bigint NOT NULL,
 id_bas_responsavel bigint NOT NULL,
 valor_contrato numeric(9,2) NOT NULL,
 quantidade_parcela smallint NOT NULL,
 valor_parcela numeric(9,2) NOT NULL,
 dia_vencimento smallint NOT NULL,
 data_inicial date NOT NULL,
 data_final date NOT NULL,
 juros numeric(5,2) NOT NULL,
 multa numeric(5,2) NOT NULL,
 categoria smallint NOT NULL,
 percentual_bolsa numeric(4,1),
 id_bas_fiador bigint,
 id_sge_convenio bigint,
 numero integer NOT NULL
);


ALTER TABLE public.sge_contrato OWNER TO postgres;

--
-- TOC entry 12646 (class 0 OID 0)
-- Dependencies: 761
-- Name: COLUMN sge_contrato.categoria; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_contrato.categoria IS '1=Particular, 2=Bolsista, 3=Convenio e 4=Filantropia';


--
-- TOC entry 12647 (class 0 OID 0)
-- Dependencies: 761
-- Name: COLUMN sge_contrato.id_bas_fiador; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_contrato.id_bas_fiador IS 'Responsavel fiador';


--
-- TOC entry 762 (class 1259 OID 14564457)
-- Name: sge_contrato_desconto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_contrato_desconto (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_contrato bigint NOT NULL,
 id_sge_serie_desconto bigint,
 forma character(1) NOT NULL,
 valor numeric(9,2) NOT NULL,
 motivo_desconto character varying(200),
 fixo character(1) NOT NULL,
 base character(1) NOT NULL,
 parcela_inicial smallint NOT NULL,
 parcela_final smallint NOT NULL,
 mesatual character(1) NOT NULL,
 cumulativo character(1) NOT NULL,
 data_inclusao date,
 data_cancelamento date,
 motivo_cancelamento character varying(200),
 login character varying(32) NOT NULL,
 login_cancelamento character varying(32)
);


ALTER TABLE public.sge_contrato_desconto OWNER TO postgres;

--
-- TOC entry 12648 (class 0 OID 0)
-- Dependencies: 762
-- Name: COLUMN sge_contrato_desconto.forma; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_contrato_desconto.forma IS 'M=monetario, P=Percentual';


--
-- TOC entry 12649 (class 0 OID 0)
-- Dependencies: 762
-- Name: COLUMN sge_contrato_desconto.fixo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_contrato_desconto.fixo IS 'S=sim, N=nao';


--
-- TOC entry 12650 (class 0 OID 0)
-- Dependencies: 762
-- Name: COLUMN sge_contrato_desconto.base; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_contrato_desconto.base IS 'A=antecipacao, D-=dia fixo';


--
-- TOC entry 12651 (class 0 OID 0)
-- Dependencies: 762
-- Name: COLUMN sge_contrato_desconto.mesatual; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_contrato_desconto.mesatual IS 'S=sim, N=nao';


--
-- TOC entry 12652 (class 0 OID 0)
-- Dependencies: 762
-- Name: COLUMN sge_contrato_desconto.cumulativo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_contrato_desconto.cumulativo IS 'S=sim, N=nao';


--
-- TOC entry 763 (class 1259 OID 14564460)
-- Name: sge_contrato_desconto_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_contrato_desconto_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_contrato_desconto_id_seq OWNER TO postgres;

--
-- TOC entry 12653 (class 0 OID 0)
-- Dependencies: 763
-- Name: sge_contrato_desconto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_contrato_desconto_id_seq OWNED BY public.sge_contrato_desconto.id;


--
-- TOC entry 764 (class 1259 OID 14564462)
-- Name: sge_contrato_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_contrato_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_contrato_id_seq OWNER TO postgres;

--
-- TOC entry 12654 (class 0 OID 0)
-- Dependencies: 764
-- Name: sge_contrato_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_contrato_id_seq OWNED BY public.sge_contrato.id;


--
-- TOC entry 1301 (class 1259 OID 20272323)
-- Name: sge_controle_aulas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_controle_aulas (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_professor_disciplina_turma bigint NOT NULL,
 jan smallint,
 fev smallint,
 mar smallint,
 abr smallint,
 mai smallint,
 jun smallint,
 jul smallint,
 ago smallint,
 set smallint,
 "out" smallint,
 nov smallint,
 dez smallint,
 aulas_lecionadas smallint,
 aulas_computadas smallint
);


ALTER TABLE public.sge_controle_aulas OWNER TO postgres;

--
-- TOC entry 1300 (class 1259 OID 20272321)
-- Name: sge_controle_aulas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_controle_aulas_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_controle_aulas_id_seq OWNER TO postgres;

--
-- TOC entry 12655 (class 0 OID 0)
-- Dependencies: 1300
-- Name: sge_controle_aulas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_controle_aulas_id_seq OWNED BY public.sge_controle_aulas.id;


--
-- TOC entry 765 (class 1259 OID 14564464)
-- Name: sge_convenio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_convenio (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_pessoa bigint NOT NULL,
 descricao character varying(100) NOT NULL,
 nome_responsavel character varying(100),
 data_inicial date NOT NULL,
 data_final date NOT NULL,
 participacao numeric(5,2) NOT NULL,
 parcela_inicial smallint,
 numero_contrato character varying(20),
 gera_financeiro character(1) NOT NULL,
 prefeitura character(1) NOT NULL
);


ALTER TABLE public.sge_convenio OWNER TO postgres;

--
-- TOC entry 12656 (class 0 OID 0)
-- Dependencies: 765
-- Name: COLUMN sge_convenio.participacao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_convenio.participacao IS 'Percentual de participacao na parcela';


--
-- TOC entry 12657 (class 0 OID 0)
-- Dependencies: 765
-- Name: COLUMN sge_convenio.gera_financeiro; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_convenio.gera_financeiro IS 'S = Sim, N = Não';


--
-- TOC entry 12658 (class 0 OID 0)
-- Dependencies: 765
-- Name: COLUMN sge_convenio.prefeitura; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_convenio.prefeitura IS 'S= Sim, N = Não';


--
-- TOC entry 766 (class 1259 OID 14564467)
-- Name: sge_convenio_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_convenio_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_convenio_id_seq OWNER TO postgres;

--
-- TOC entry 12659 (class 0 OID 0)
-- Dependencies: 766
-- Name: sge_convenio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_convenio_id_seq OWNED BY public.sge_convenio.id;


--
-- TOC entry 767 (class 1259 OID 14564469)
-- Name: sge_conversao_nota; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_conversao_nota (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 valor_minimo numeric(3,1) NOT NULL,
 valor_maximo numeric(3,1) NOT NULL,
 media numeric(3,1) NOT NULL,
 nota_pf numeric(3,1) NOT NULL
);
ALTER TABLE ONLY public.sge_conversao_nota ALTER COLUMN id SET STATISTICS 0;
ALTER TABLE ONLY public.sge_conversao_nota ALTER COLUMN id_bas_empresa SET STATISTICS 0;
ALTER TABLE ONLY public.sge_conversao_nota ALTER COLUMN media SET STATISTICS 0;


ALTER TABLE public.sge_conversao_nota OWNER TO postgres;

--
-- TOC entry 12660 (class 0 OID 0)
-- Dependencies: 767
-- Name: COLUMN sge_conversao_nota.nota_pf; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_conversao_nota.nota_pf IS 'Nota que o aluno precisará tirar na prova final.';


--
-- TOC entry 768 (class 1259 OID 14564472)
-- Name: sge_conversao_nota_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_conversao_nota_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_conversao_nota_id_seq OWNER TO postgres;

--
-- TOC entry 12661 (class 0 OID 0)
-- Dependencies: 768
-- Name: sge_conversao_nota_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_conversao_nota_id_seq OWNED BY public.sge_conversao_nota.id;


--
-- TOC entry 769 (class 1259 OID 14564474)
-- Name: sge_cotas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_cotas (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(100) NOT NULL,
 reserva integer NOT NULL
);
ALTER TABLE ONLY public.sge_cotas ALTER COLUMN id SET STATISTICS 0;
ALTER TABLE ONLY public.sge_cotas ALTER COLUMN nome SET STATISTICS 0;


ALTER TABLE public.sge_cotas OWNER TO postgres;

--
-- TOC entry 12662 (class 0 OID 0)
-- Dependencies: 769
-- Name: COLUMN sge_cotas.reserva; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_cotas.reserva IS 'Porcentagem de vagas reservadas para esta cota';


--
-- TOC entry 770 (class 1259 OID 14564477)
-- Name: sge_cotas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_cotas_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_cotas_id_seq OWNER TO postgres;

--
-- TOC entry 12663 (class 0 OID 0)
-- Dependencies: 770
-- Name: sge_cotas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_cotas_id_seq OWNED BY public.sge_cotas.id;


--
-- TOC entry 771 (class 1259 OID 14564479)
-- Name: sge_criterio_etapa_avaliacao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_criterio_etapa_avaliacao_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_criterio_etapa_avaliacao_id_seq OWNER TO postgres;

--
-- TOC entry 772 (class 1259 OID 14564481)
-- Name: sge_criterio_etapa_avaliacao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_criterio_etapa_avaliacao (
 id bigint DEFAULT nextval('public.sge_criterio_etapa_avaliacao_id_seq'::regclass) NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_criterio_etapa bigint NOT NULL,
 id_sge_avaliacao bigint NOT NULL,
 nota_maxima numeric(5,2),
 substituida_recuperacao character(1) DEFAULT 'N'::bpchar,
 substitui_avaliacao character(1),
 substitui_menor_nota character(1),
 substitui_nota_etapa character(1),
 complementa_nota_etapa character(1),
 recuperacao character(1),
 peso smallint,
 id_sge_professor_disciplina_turma bigint,
 login_autorizacao character varying(32)
);


ALTER TABLE public.sge_criterio_etapa_avaliacao OWNER TO postgres;

--
-- TOC entry 12664 (class 0 OID 0)
-- Dependencies: 772
-- Name: COLUMN sge_criterio_etapa_avaliacao.nota_maxima; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_criterio_etapa_avaliacao.nota_maxima IS 'Nota máxima da avaliação';


--
-- TOC entry 12665 (class 0 OID 0)
-- Dependencies: 772
-- Name: COLUMN sge_criterio_etapa_avaliacao.substituida_recuperacao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_criterio_etapa_avaliacao.substituida_recuperacao IS 'S = sim, N = Não';


--
-- TOC entry 12666 (class 0 OID 0)
-- Dependencies: 772
-- Name: COLUMN sge_criterio_etapa_avaliacao.substitui_avaliacao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_criterio_etapa_avaliacao.substitui_avaliacao IS 'S = Sim, N = Não';


--
-- TOC entry 12667 (class 0 OID 0)
-- Dependencies: 772
-- Name: COLUMN sge_criterio_etapa_avaliacao.substitui_menor_nota; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_criterio_etapa_avaliacao.substitui_menor_nota IS 'S = Sim, N = Não';


--
-- TOC entry 12668 (class 0 OID 0)
-- Dependencies: 772
-- Name: COLUMN sge_criterio_etapa_avaliacao.substitui_nota_etapa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_criterio_etapa_avaliacao.substitui_nota_etapa IS 'S = Sim, N = Não';


--
-- TOC entry 12669 (class 0 OID 0)
-- Dependencies: 772
-- Name: COLUMN sge_criterio_etapa_avaliacao.complementa_nota_etapa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_criterio_etapa_avaliacao.complementa_nota_etapa IS 'S = Sim, N = Não';


--
-- TOC entry 12670 (class 0 OID 0)
-- Dependencies: 772
-- Name: COLUMN sge_criterio_etapa_avaliacao.recuperacao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_criterio_etapa_avaliacao.recuperacao IS 'S = Sim, N = não';


--
-- TOC entry 773 (class 1259 OID 14564486)
-- Name: sge_criterio_final_turma; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_criterio_final_turma (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_turma bigint NOT NULL,
 id_sge_criterio_final bigint NOT NULL,
 data timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.sge_criterio_final_turma OWNER TO postgres;

--
-- TOC entry 774 (class 1259 OID 14564489)
-- Name: sge_criterio_final_turma_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_criterio_final_turma_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_criterio_final_turma_id_seq OWNER TO postgres;

--
-- TOC entry 12671 (class 0 OID 0)
-- Dependencies: 774
-- Name: sge_criterio_final_turma_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_criterio_final_turma_id_seq OWNED BY public.sge_criterio_final_turma.id;


--
-- TOC entry 775 (class 1259 OID 14564491)
-- Name: sge_criterio_grade_disciplina; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_criterio_grade_disciplina (
 id_sge_grade bigint NOT NULL,
 id_sge_disciplina bigint NOT NULL,
 id_sge_criterio_final bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 data_inicio date NOT NULL
);
ALTER TABLE ONLY public.sge_criterio_grade_disciplina ALTER COLUMN id_sge_grade SET STATISTICS 0;
ALTER TABLE ONLY public.sge_criterio_grade_disciplina ALTER COLUMN id_bas_empresa SET STATISTICS 0;
ALTER TABLE ONLY public.sge_criterio_grade_disciplina ALTER COLUMN data_inicio SET STATISTICS 0;


ALTER TABLE public.sge_criterio_grade_disciplina OWNER TO postgres;

--
-- TOC entry 776 (class 1259 OID 14564494)
-- Name: sge_cronograma; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_cronograma (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 ano_letivo smallint NOT NULL,
 nome character varying(30) NOT NULL
);


ALTER TABLE public.sge_cronograma OWNER TO postgres;

--
-- TOC entry 12672 (class 0 OID 0)
-- Dependencies: 776
-- Name: COLUMN sge_cronograma.ano_letivo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_cronograma.ano_letivo IS 'Ano letivo do cronograma';


--
-- TOC entry 12673 (class 0 OID 0)
-- Dependencies: 776
-- Name: COLUMN sge_cronograma.nome; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_cronograma.nome IS 'Nome do cronograma';


--
-- TOC entry 777 (class 1259 OID 14564497)
-- Name: sge_cronograma_turma_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_cronograma_turma_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_cronograma_turma_id_seq OWNER TO postgres;

--
-- TOC entry 778 (class 1259 OID 14564499)
-- Name: sge_cronograma_curso_serie_turma; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_cronograma_curso_serie_turma (
 id bigint DEFAULT nextval('public.sge_cronograma_turma_id_seq'::regclass) NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_etapa bigint NOT NULL,
 id_sge_turma bigint,
 id_sge_curso bigint,
 id_sge_serie bigint,
 id_sge_criterio_final bigint,
 data_inicio date NOT NULL,
 data_fim date NOT NULL,
 inicio_digitacao_notas date,
 fim_digitacao_notas date,
 ano_letivo smallint
);


ALTER TABLE public.sge_cronograma_curso_serie_turma OWNER TO postgres;

--
-- TOC entry 779 (class 1259 OID 14564503)
-- Name: sge_cronograma_etapa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_cronograma_etapa (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_cronograma bigint NOT NULL,
 id_sge_etapa bigint NOT NULL,
 data_inicio date NOT NULL,
 data_fim date NOT NULL,
 inicio_digitacao_notas date,
 fim_digitacao_notas date
);


ALTER TABLE public.sge_cronograma_etapa OWNER TO postgres;

--
-- TOC entry 12674 (class 0 OID 0)
-- Dependencies: 779
-- Name: COLUMN sge_cronograma_etapa.data_inicio; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_cronograma_etapa.data_inicio IS 'Data de início do cronograma da etapa';


--
-- TOC entry 12675 (class 0 OID 0)
-- Dependencies: 779
-- Name: COLUMN sge_cronograma_etapa.data_fim; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_cronograma_etapa.data_fim IS 'Data de fim do cronograma da etapa';


--
-- TOC entry 12676 (class 0 OID 0)
-- Dependencies: 779
-- Name: COLUMN sge_cronograma_etapa.inicio_digitacao_notas; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_cronograma_etapa.inicio_digitacao_notas IS 'Data de início do período de digitação de notas dessa etapa';


--
-- TOC entry 12677 (class 0 OID 0)
-- Dependencies: 779
-- Name: COLUMN sge_cronograma_etapa.fim_digitacao_notas; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_cronograma_etapa.fim_digitacao_notas IS 'Data final para digitação de notas dessa etapa';


--
-- TOC entry 780 (class 1259 OID 14564506)
-- Name: sge_cronograma_etapa_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_cronograma_etapa_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_cronograma_etapa_id_seq OWNER TO postgres;

--
-- TOC entry 12678 (class 0 OID 0)
-- Dependencies: 780
-- Name: sge_cronograma_etapa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_cronograma_etapa_id_seq OWNED BY public.sge_cronograma_etapa.id;


--
-- TOC entry 781 (class 1259 OID 14564508)
-- Name: sge_cronograma_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_cronograma_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_cronograma_id_seq OWNER TO postgres;

--
-- TOC entry 12679 (class 0 OID 0)
-- Dependencies: 781
-- Name: sge_cronograma_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_cronograma_id_seq OWNED BY public.sge_cronograma.id;


SET default_with_oids = true;

--
-- TOC entry 782 (class 1259 OID 14564510)
-- Name: sge_curso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_curso (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_estabelecimento bigint NOT NULL,
 id_sge_tipo_ensino bigint NOT NULL,
 id_bas_pessoa_fisica bigint,
 id_sgb_tipo_leitor bigint,
 nome character varying(100) NOT NULL,
 sigla character varying(20),
 ementa text,
 ano_criacao integer NOT NULL,
 autorizacao character varying(20),
 quantidade_periodo smallint,
 id_sgf_nfse_curso bigint,
 qt_dias_letivos smallint,
 multisseriada character(1) DEFAULT 'N'::bpchar NOT NULL
);


ALTER TABLE public.sge_curso OWNER TO postgres;

--
-- TOC entry 12680 (class 0 OID 0)
-- Dependencies: 782
-- Name: COLUMN sge_curso.id_bas_pessoa_fisica; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_curso.id_bas_pessoa_fisica IS 'secretário do curso';


--
-- TOC entry 12681 (class 0 OID 0)
-- Dependencies: 782
-- Name: COLUMN sge_curso.id_sgb_tipo_leitor; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_curso.id_sgb_tipo_leitor IS 'Configuracoes para cada tipo';


--
-- TOC entry 12682 (class 0 OID 0)
-- Dependencies: 782
-- Name: COLUMN sge_curso.autorizacao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_curso.autorizacao IS 'autorizacao do secretario';


--
-- TOC entry 12683 (class 0 OID 0)
-- Dependencies: 782
-- Name: COLUMN sge_curso.id_sgf_nfse_curso; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_curso.id_sgf_nfse_curso IS 'Configuração para NFS-e Municipal';


--
-- TOC entry 12684 (class 0 OID 0)
-- Dependencies: 782
-- Name: COLUMN sge_curso.multisseriada; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_curso.multisseriada IS 'S = sim, N = não';


--
-- TOC entry 783 (class 1259 OID 14564517)
-- Name: sge_curso_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_curso_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_curso_id_seq OWNER TO postgres;

--
-- TOC entry 12685 (class 0 OID 0)
-- Dependencies: 783
-- Name: sge_curso_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_curso_id_seq OWNED BY public.sge_curso.id;


SET default_with_oids = false;

--
-- TOC entry 784 (class 1259 OID 14564519)
-- Name: sge_curso_superior; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_curso_superior (
 id bigint NOT NULL,
 nome character varying(50),
 codigo character varying,
 grau character varying(20)
);


ALTER TABLE public.sge_curso_superior OWNER TO postgres;

--
-- TOC entry 785 (class 1259 OID 14564525)
-- Name: sge_curso_superio_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_curso_superio_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_curso_superio_id_seq OWNER TO postgres;

--
-- TOC entry 12686 (class 0 OID 0)
-- Dependencies: 785
-- Name: sge_curso_superio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_curso_superio_id_seq OWNED BY public.sge_curso_superior.id;


--
-- TOC entry 786 (class 1259 OID 14564527)
-- Name: sge_curso_superior_disciplina; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_curso_superior_disciplina (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_cso_curso_superior bigint NOT NULL,
 id_sge_disciplina bigint NOT NULL,
 data_inclusao date NOT NULL
);


ALTER TABLE public.sge_curso_superior_disciplina OWNER TO postgres;

--
-- TOC entry 787 (class 1259 OID 14564530)
-- Name: sge_curso_superior_disciplina_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_curso_superior_disciplina_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_curso_superior_disciplina_id_seq OWNER TO postgres;

--
-- TOC entry 12687 (class 0 OID 0)
-- Dependencies: 787
-- Name: sge_curso_superior_disciplina_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_curso_superior_disciplina_id_seq OWNED BY public.sge_curso_superior_disciplina.id;


--
-- TOC entry 788 (class 1259 OID 14564532)
-- Name: sge_data_matricula_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_data_matricula_log (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_turma_aluno bigint NOT NULL,
 login character varying(32) NOT NULL,
 data_hora timestamp(0) without time zone DEFAULT now() NOT NULL,
 data_antiga date,
 data_atualizada date
);


ALTER TABLE public.sge_data_matricula_log OWNER TO postgres;

--
-- TOC entry 789 (class 1259 OID 14564536)
-- Name: sge_data_matricula_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_data_matricula_log_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_data_matricula_log_id_seq OWNER TO postgres;

--
-- TOC entry 12688 (class 0 OID 0)
-- Dependencies: 789
-- Name: sge_data_matricula_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_data_matricula_log_id_seq OWNED BY public.sge_data_matricula_log.id;


--
-- TOC entry 790 (class 1259 OID 14564538)
-- Name: sge_detalhe_deficiencia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_detalhe_deficiencia (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 tipo character varying(100)
);


ALTER TABLE public.sge_detalhe_deficiencia OWNER TO postgres;

--
-- TOC entry 791 (class 1259 OID 14564541)
-- Name: sge_detalhe_deficiencia_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_detalhe_deficiencia_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_detalhe_deficiencia_id_seq OWNER TO postgres;

--
-- TOC entry 12689 (class 0 OID 0)
-- Dependencies: 791
-- Name: sge_detalhe_deficiencia_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_detalhe_deficiencia_id_seq OWNED BY public.sge_detalhe_deficiencia.id;


--
-- TOC entry 792 (class 1259 OID 14564543)
-- Name: sge_diagnose_inicial; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_diagnose_inicial (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_turma_aluno bigint NOT NULL,
 id_sge_professor bigint NOT NULL,
 patologia character varying(100),
 relatorio text NOT NULL,
 data date NOT NULL
);


ALTER TABLE public.sge_diagnose_inicial OWNER TO postgres;

--
-- TOC entry 793 (class 1259 OID 14564549)
-- Name: sge_diagnose_inicial_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_diagnose_inicial_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_diagnose_inicial_id_seq OWNER TO postgres;

--
-- TOC entry 12690 (class 0 OID 0)
-- Dependencies: 793
-- Name: sge_diagnose_inicial_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_diagnose_inicial_id_seq OWNED BY public.sge_diagnose_inicial.id;


--
-- TOC entry 1299 (class 1259 OID 18536097)
-- Name: sge_diario_classe_orientacao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_diario_classe_orientacao (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_cfg_curso bigint NOT NULL,
 texto text NOT NULL
);


ALTER TABLE public.sge_diario_classe_orientacao OWNER TO postgres;

--
-- TOC entry 1298 (class 1259 OID 18536095)
-- Name: sge_diario_classe_orientacao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_diario_classe_orientacao_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_diario_classe_orientacao_id_seq OWNER TO postgres;

--
-- TOC entry 12691 (class 0 OID 0)
-- Dependencies: 1298
-- Name: sge_diario_classe_orientacao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_diario_classe_orientacao_id_seq OWNED BY public.sge_diario_classe_orientacao.id;


--
-- TOC entry 794 (class 1259 OID 14564551)
-- Name: sge_disciplina; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_disciplina (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(100) NOT NULL,
 sigla character varying(10) NOT NULL,
 codigo_censo character varying(2)
);


ALTER TABLE public.sge_disciplina OWNER TO postgres;

--
-- TOC entry 795 (class 1259 OID 14564554)
-- Name: sge_disciplina_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_disciplina_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_disciplina_id_seq OWNER TO postgres;

--
-- TOC entry 12692 (class 0 OID 0)
-- Dependencies: 795
-- Name: sge_disciplina_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_disciplina_id_seq OWNED BY public.sge_disciplina.id;


--
-- TOC entry 796 (class 1259 OID 14564556)
-- Name: sge_doc_emitido_escola; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_doc_emitido_escola (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_aluno bigint NOT NULL,
 id_sge_tipo_documento bigint NOT NULL,
 data_emissao date,
 data_entrega date,
 protocolo bigint,
 observacao text
);


ALTER TABLE public.sge_doc_emitido_escola OWNER TO postgres;

--
-- TOC entry 797 (class 1259 OID 14564562)
-- Name: sge_documento_emitido_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_documento_emitido_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_documento_emitido_id_seq OWNER TO postgres;

--
-- TOC entry 12693 (class 0 OID 0)
-- Dependencies: 797
-- Name: sge_documento_emitido_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_documento_emitido_id_seq OWNED BY public.sge_doc_emitido_escola.id;


--
-- TOC entry 798 (class 1259 OID 14564564)
-- Name: sge_educacao_especial_questionario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_educacao_especial_questionario (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(20) NOT NULL,
 ativo character(1),
 data_cancelamento date
);


ALTER TABLE public.sge_educacao_especial_questionario OWNER TO postgres;

--
-- TOC entry 12694 (class 0 OID 0)
-- Dependencies: 798
-- Name: COLUMN sge_educacao_especial_questionario.data_cancelamento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_educacao_especial_questionario.data_cancelamento IS 'Caso o questionário tenha este campo preenchido, o mesmo estará cancelado';


--
-- TOC entry 799 (class 1259 OID 14564567)
-- Name: sge_educacao_especial_questionario_atividade_turma; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_educacao_especial_questionario_atividade_turma (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_atividade_turma bigint NOT NULL,
 id_sge_educacao_especial_questionario bigint NOT NULL
);


ALTER TABLE public.sge_educacao_especial_questionario_atividade_turma OWNER TO postgres;

--
-- TOC entry 800 (class 1259 OID 14564570)
-- Name: sge_educacao_especial_questionario_atividade_turma_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_educacao_especial_questionario_atividade_turma_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_educacao_especial_questionario_atividade_turma_id_seq OWNER TO postgres;

--
-- TOC entry 12695 (class 0 OID 0)
-- Dependencies: 800
-- Name: sge_educacao_especial_questionario_atividade_turma_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_educacao_especial_questionario_atividade_turma_id_seq OWNED BY public.sge_educacao_especial_questionario_atividade_turma.id;


--
-- TOC entry 801 (class 1259 OID 14564572)
-- Name: sge_educacao_especial_questionario_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_educacao_especial_questionario_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_educacao_especial_questionario_id_seq OWNER TO postgres;

--
-- TOC entry 12696 (class 0 OID 0)
-- Dependencies: 801
-- Name: sge_educacao_especial_questionario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_educacao_especial_questionario_id_seq OWNED BY public.sge_educacao_especial_questionario.id;


--
-- TOC entry 802 (class 1259 OID 14564574)
-- Name: sge_educacao_especial_questionario_turma; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_educacao_especial_questionario_turma (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_educacao_especial_questionario bigint NOT NULL,
 id_sge_turma bigint NOT NULL
);


ALTER TABLE public.sge_educacao_especial_questionario_turma OWNER TO postgres;

--
-- TOC entry 803 (class 1259 OID 14564577)
-- Name: sge_educacao_especial_questionario_turma_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_educacao_especial_questionario_turma_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_educacao_especial_questionario_turma_id_seq OWNER TO postgres;

--
-- TOC entry 12697 (class 0 OID 0)
-- Dependencies: 803
-- Name: sge_educacao_especial_questionario_turma_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_educacao_especial_questionario_turma_id_seq OWNED BY public.sge_educacao_especial_questionario_turma.id;


--
-- TOC entry 804 (class 1259 OID 14564579)
-- Name: sge_educacao_especial_topico; Type: TABLE; Schema: public; Owner: pgadmin
--

CREATE TABLE public.sge_educacao_especial_topico (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 titulo character varying(100) NOT NULL,
 ativo character(1) NOT NULL,
 id_sge_educacao_especial_questionario bigint NOT NULL
);


ALTER TABLE public.sge_educacao_especial_topico OWNER TO pgadmin;

--
-- TOC entry 805 (class 1259 OID 14564582)
-- Name: sge_educacao_especial_topico_id_seq; Type: SEQUENCE; Schema: public; Owner: pgadmin
--

CREATE SEQUENCE public.sge_educacao_especial_topico_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_educacao_especial_topico_id_seq OWNER TO pgadmin;

--
-- TOC entry 12698 (class 0 OID 0)
-- Dependencies: 805
-- Name: sge_educacao_especial_topico_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgadmin
--

ALTER SEQUENCE public.sge_educacao_especial_topico_id_seq OWNED BY public.sge_educacao_especial_topico.id;


--
-- TOC entry 806 (class 1259 OID 14564584)
-- Name: sge_eixo_tecnologico; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_eixo_tecnologico (
 id bigint NOT NULL,
 nome character varying(100) NOT NULL
);


ALTER TABLE public.sge_eixo_tecnologico OWNER TO postgres;

--
-- TOC entry 807 (class 1259 OID 14564587)
-- Name: sge_eixo_tecnologico_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_eixo_tecnologico_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_eixo_tecnologico_id_seq OWNER TO postgres;

--
-- TOC entry 12699 (class 0 OID 0)
-- Dependencies: 807
-- Name: sge_eixo_tecnologico_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_eixo_tecnologico_id_seq OWNED BY public.sge_eixo_tecnologico.id;


--
-- TOC entry 808 (class 1259 OID 14564589)
-- Name: sge_eja_nomenclatura; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_eja_nomenclatura (
 id bigint NOT NULL,
 nome character varying(50) NOT NULL
);


ALTER TABLE public.sge_eja_nomenclatura OWNER TO postgres;

--
-- TOC entry 809 (class 1259 OID 14564592)
-- Name: sge_eja_nomenclatura_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_eja_nomenclatura_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_eja_nomenclatura_id_seq OWNER TO postgres;

--
-- TOC entry 12700 (class 0 OID 0)
-- Dependencies: 809
-- Name: sge_eja_nomenclatura_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_eja_nomenclatura_id_seq OWNED BY public.sge_eja_nomenclatura.id;


SET default_with_oids = true;

--
-- TOC entry 810 (class 1259 OID 14564594)
-- Name: sge_email_enviado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_email_enviado (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_estabelecimento bigint NOT NULL,
 login character varying(20) NOT NULL,
 id_bas_pessoa bigint NOT NULL,
 conteudo text NOT NULL,
 data_hora timestamp(6) without time zone NOT NULL,
 erro character(1) NOT NULL,
 celular character varying(20) NOT NULL
);
ALTER TABLE ONLY public.sge_email_enviado ALTER COLUMN id SET STATISTICS 0;
ALTER TABLE ONLY public.sge_email_enviado ALTER COLUMN id_bas_empresa SET STATISTICS 0;
ALTER TABLE ONLY public.sge_email_enviado ALTER COLUMN id_bas_estabelecimento SET STATISTICS 0;
ALTER TABLE ONLY public.sge_email_enviado ALTER COLUMN login SET STATISTICS 0;
ALTER TABLE ONLY public.sge_email_enviado ALTER COLUMN id_bas_pessoa SET STATISTICS 0;
ALTER TABLE ONLY public.sge_email_enviado ALTER COLUMN conteudo SET STATISTICS 0;
ALTER TABLE ONLY public.sge_email_enviado ALTER COLUMN data_hora SET STATISTICS 0;
ALTER TABLE ONLY public.sge_email_enviado ALTER COLUMN erro SET STATISTICS 0;
ALTER TABLE ONLY public.sge_email_enviado ALTER COLUMN celular SET STATISTICS 0;


ALTER TABLE public.sge_email_enviado OWNER TO postgres;

--
-- TOC entry 12701 (class 0 OID 0)
-- Dependencies: 810
-- Name: COLUMN sge_email_enviado.erro; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_email_enviado.erro IS 'S = "Sim", N = "Não"';


--
-- TOC entry 811 (class 1259 OID 14564600)
-- Name: sge_email_enviado_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_email_enviado_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_email_enviado_id_seq OWNER TO postgres;

--
-- TOC entry 12702 (class 0 OID 0)
-- Dependencies: 811
-- Name: sge_email_enviado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_email_enviado_id_seq OWNED BY public.sge_email_enviado.id;


SET default_with_oids = false;

--
-- TOC entry 812 (class 1259 OID 14564602)
-- Name: sge_equivalencia_curricular; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_equivalencia_curricular (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(100) NOT NULL,
 grau smallint NOT NULL,
 serie smallint NOT NULL,
 serie_anterior smallint,
 ordem smallint,
 idade smallint
);


ALTER TABLE public.sge_equivalencia_curricular OWNER TO postgres;

--
-- TOC entry 813 (class 1259 OID 14564605)
-- Name: sge_equivalencia_curricular_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_equivalencia_curricular_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_equivalencia_curricular_id_seq OWNER TO postgres;

--
-- TOC entry 12703 (class 0 OID 0)
-- Dependencies: 813
-- Name: sge_equivalencia_curricular_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_equivalencia_curricular_id_seq OWNED BY public.sge_equivalencia_curricular.id;


--
-- TOC entry 814 (class 1259 OID 14564607)
-- Name: sge_etapa_modalidade; Type: TABLE; Schema: public; Owner: pgadmin
--

CREATE TABLE public.sge_etapa_modalidade (
 id bigint NOT NULL,
 codigo character varying(2),
 nome character varying(100),
 regular character(1),
 especial character(1),
 eja character(1)
);


ALTER TABLE public.sge_etapa_modalidade OWNER TO pgadmin;

--
-- TOC entry 12704 (class 0 OID 0)
-- Dependencies: 814
-- Name: TABLE sge_etapa_modalidade; Type: COMMENT; Schema: public; Owner: pgadmin
--

COMMENT ON TABLE public.sge_etapa_modalidade IS 'Censo Escolar - Etapa x Modalidade';


--
-- TOC entry 12705 (class 0 OID 0)
-- Dependencies: 814
-- Name: COLUMN sge_etapa_modalidade.regular; Type: COMMENT; Schema: public; Owner: pgadmin
--

COMMENT ON COLUMN public.sge_etapa_modalidade.regular IS '0- Não
1- Sim';


--
-- TOC entry 12706 (class 0 OID 0)
-- Dependencies: 814
-- Name: COLUMN sge_etapa_modalidade.especial; Type: COMMENT; Schema: public; Owner: pgadmin
--

COMMENT ON COLUMN public.sge_etapa_modalidade.especial IS '0- Não
1- Sim';


--
-- TOC entry 12707 (class 0 OID 0)
-- Dependencies: 814
-- Name: COLUMN sge_etapa_modalidade.eja; Type: COMMENT; Schema: public; Owner: pgadmin
--

COMMENT ON COLUMN public.sge_etapa_modalidade.eja IS '0- Não
1- Sim';


--
-- TOC entry 815 (class 1259 OID 14564610)
-- Name: sge_etapa_modalidade_id_seq; Type: SEQUENCE; Schema: public; Owner: pgadmin
--

CREATE SEQUENCE public.sge_etapa_modalidade_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_etapa_modalidade_id_seq OWNER TO pgadmin;

--
-- TOC entry 12708 (class 0 OID 0)
-- Dependencies: 815
-- Name: sge_etapa_modalidade_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgadmin
--

ALTER SEQUENCE public.sge_etapa_modalidade_id_seq OWNED BY public.sge_etapa_modalidade.id;


SET default_with_oids = true;

--
-- TOC entry 816 (class 1259 OID 14564612)
-- Name: sge_faixa_etaria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_faixa_etaria (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(100) NOT NULL,
 faixa_inicial integer NOT NULL,
 faixa_final integer NOT NULL
);


ALTER TABLE public.sge_faixa_etaria OWNER TO postgres;

--
-- TOC entry 817 (class 1259 OID 14564615)
-- Name: sge_faixa_etaria_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_faixa_etaria_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_faixa_etaria_id_seq OWNER TO postgres;

--
-- TOC entry 12709 (class 0 OID 0)
-- Dependencies: 817
-- Name: sge_faixa_etaria_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_faixa_etaria_id_seq OWNED BY public.sge_faixa_etaria.id;


SET default_with_oids = false;

--
-- TOC entry 818 (class 1259 OID 14564617)
-- Name: sge_faixa_horario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_faixa_horario (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(100) NOT NULL
);


ALTER TABLE public.sge_faixa_horario OWNER TO postgres;

--
-- TOC entry 819 (class 1259 OID 14564620)
-- Name: sge_faixa_horario_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_faixa_horario_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_faixa_horario_id_seq OWNER TO postgres;

--
-- TOC entry 12710 (class 0 OID 0)
-- Dependencies: 819
-- Name: sge_faixa_horario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_faixa_horario_id_seq OWNED BY public.sge_faixa_horario.id;


--
-- TOC entry 820 (class 1259 OID 14564622)
-- Name: sge_faixa_horario_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_faixa_horario_item (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_faixa_horario bigint NOT NULL,
 hora_inicial time without time zone NOT NULL,
 hora_final time without time zone NOT NULL
);


ALTER TABLE public.sge_faixa_horario_item OWNER TO postgres;

--
-- TOC entry 821 (class 1259 OID 14564625)
-- Name: sge_faixa_horario_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_faixa_horario_item_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_faixa_horario_item_id_seq OWNER TO postgres;

--
-- TOC entry 12711 (class 0 OID 0)
-- Dependencies: 821
-- Name: sge_faixa_horario_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_faixa_horario_item_id_seq OWNED BY public.sge_faixa_horario_item.id;


--
-- TOC entry 822 (class 1259 OID 14564627)
-- Name: sge_falta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_falta (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 justificativa character varying(150),
 atestado character(1) DEFAULT 'N'::bpchar,
 data date,
 id_sge_atestado bigint,
 id_sge_turma_aluno bigint NOT NULL,
 id_sge_etapa bigint,
 id_sge_grade_horario bigint,
 id_sge_disciplina bigint,
 quantidade smallint,
 mes_referencia integer,
 quantidade_presenca smallint
);
ALTER TABLE ONLY public.sge_falta ALTER COLUMN id SET STATISTICS 0;
ALTER TABLE ONLY public.sge_falta ALTER COLUMN id_bas_empresa SET STATISTICS 0;
ALTER TABLE ONLY public.sge_falta ALTER COLUMN justificativa SET STATISTICS 0;


ALTER TABLE public.sge_falta OWNER TO postgres;

--
-- TOC entry 12712 (class 0 OID 0)
-- Dependencies: 822
-- Name: COLUMN sge_falta.atestado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_falta.atestado IS '''S'' = Sim, ''N'' = Não';


SET default_with_oids = true;

--
-- TOC entry 823 (class 1259 OID 14564631)
-- Name: sge_falta_escola; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_falta_escola (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_lider_turma bigint,
 id_sge_turma_aluno bigint NOT NULL,
 data date NOT NULL,
 login character varying(32)
);


ALTER TABLE public.sge_falta_escola OWNER TO postgres;

--
-- TOC entry 12713 (class 0 OID 0)
-- Dependencies: 823
-- Name: COLUMN sge_falta_escola.id_sge_lider_turma; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_falta_escola.id_sge_lider_turma IS 'Lider da turma que registrou a falta';


--
-- TOC entry 12714 (class 0 OID 0)
-- Dependencies: 823
-- Name: COLUMN sge_falta_escola.id_sge_turma_aluno; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_falta_escola.id_sge_turma_aluno IS 'aluno que faltou';


--
-- TOC entry 12715 (class 0 OID 0)
-- Dependencies: 823
-- Name: COLUMN sge_falta_escola.data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_falta_escola.data IS 'Data da falta';


--
-- TOC entry 824 (class 1259 OID 14564634)
-- Name: sge_falta_escola_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_falta_escola_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_falta_escola_id_seq OWNER TO postgres;

--
-- TOC entry 12716 (class 0 OID 0)
-- Dependencies: 824
-- Name: sge_falta_escola_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_falta_escola_id_seq OWNED BY public.sge_falta_escola.id;


--
-- TOC entry 825 (class 1259 OID 14564636)
-- Name: sge_falta_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_falta_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_falta_id_seq OWNER TO postgres;

--
-- TOC entry 12717 (class 0 OID 0)
-- Dependencies: 825
-- Name: sge_falta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_falta_id_seq OWNED BY public.sge_falta.id;


SET default_with_oids = false;

--
-- TOC entry 826 (class 1259 OID 14564638)
-- Name: sge_fardamento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_fardamento (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(50) NOT NULL,
 tamanhos character varying(50) NOT NULL
);


ALTER TABLE public.sge_fardamento OWNER TO postgres;

--
-- TOC entry 12718 (class 0 OID 0)
-- Dependencies: 826
-- Name: TABLE sge_fardamento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sge_fardamento IS 'Registra os tipos de fardamento e seus tamanhos';


--
-- TOC entry 12719 (class 0 OID 0)
-- Dependencies: 826
-- Name: COLUMN sge_fardamento.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_fardamento.id IS 'Chave primária composta ao lado de id_bas_empresa, sequencial';


--
-- TOC entry 12720 (class 0 OID 0)
-- Dependencies: 826
-- Name: COLUMN sge_fardamento.id_bas_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_fardamento.id_bas_empresa IS 'Chave estrangeira da tabela bas_empresa e chave primária ao lado do campo id';


--
-- TOC entry 12721 (class 0 OID 0)
-- Dependencies: 826
-- Name: COLUMN sge_fardamento.nome; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_fardamento.nome IS 'Nome, descrição do fardamento';


--
-- TOC entry 12722 (class 0 OID 0)
-- Dependencies: 826
-- Name: COLUMN sge_fardamento.tamanhos; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_fardamento.tamanhos IS 'Lista de tamanhos que devem ser separados por vírgula ex (p,m,g)';


--
-- TOC entry 827 (class 1259 OID 14564641)
-- Name: sge_fardamento_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_fardamento_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_fardamento_id_seq OWNER TO postgres;

--
-- TOC entry 12723 (class 0 OID 0)
-- Dependencies: 827
-- Name: sge_fardamento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_fardamento_id_seq OWNED BY public.sge_fardamento.id;


--
-- TOC entry 828 (class 1259 OID 14564643)
-- Name: sgf_forma_recebimento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_forma_recebimento (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_estabelecimento bigint NOT NULL,
 id_sgf_plano_conta bigint NOT NULL,
 id_sgf_conta_bancaria bigint,
 descricao character varying(100),
 tipo smallint,
 taxa numeric(9,2),
 dias smallint,
 conta_taxa bigint,
 conta_cheque_prazo bigint,
 conta_cheque_dev bigint,
 conta_cheque_pagamento bigint,
 promissoria character(1)
);


ALTER TABLE public.sgf_forma_recebimento OWNER TO postgres;

--
-- TOC entry 12724 (class 0 OID 0)
-- Dependencies: 828
-- Name: COLUMN sgf_forma_recebimento.id_sgf_plano_conta; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_forma_recebimento.id_sgf_plano_conta IS 'conta pra debito da forma de recebimento';


--
-- TOC entry 12725 (class 0 OID 0)
-- Dependencies: 828
-- Name: COLUMN sgf_forma_recebimento.id_sgf_conta_bancaria; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_forma_recebimento.id_sgf_conta_bancaria IS 'conta bancária para crédito do reembolso da movimentação do cartao';


--
-- TOC entry 12726 (class 0 OID 0)
-- Dependencies: 828
-- Name: COLUMN sgf_forma_recebimento.tipo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_forma_recebimento.tipo IS '1- Dinheiro
2- Cheque
3- Cartão
4- Nota Promissória
5- Depósito Bancário
6- Boleto Bancário';


--
-- TOC entry 12727 (class 0 OID 0)
-- Dependencies: 828
-- Name: COLUMN sgf_forma_recebimento.taxa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_forma_recebimento.taxa IS 'taxa que a operador de cartão retem';


--
-- TOC entry 12728 (class 0 OID 0)
-- Dependencies: 828
-- Name: COLUMN sgf_forma_recebimento.dias; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_forma_recebimento.dias IS 'dias para credito(ja deduzida a taxa) na conta do estabelecimento';


--
-- TOC entry 12729 (class 0 OID 0)
-- Dependencies: 828
-- Name: COLUMN sgf_forma_recebimento.conta_taxa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_forma_recebimento.conta_taxa IS 'conta contabil pra taxa da administradora do cartao';


--
-- TOC entry 12730 (class 0 OID 0)
-- Dependencies: 828
-- Name: COLUMN sgf_forma_recebimento.conta_cheque_prazo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_forma_recebimento.conta_cheque_prazo IS 'conta para cheque a prazo';


--
-- TOC entry 12731 (class 0 OID 0)
-- Dependencies: 828
-- Name: COLUMN sgf_forma_recebimento.conta_cheque_dev; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_forma_recebimento.conta_cheque_dev IS 'conta para cheque devolvido';


--
-- TOC entry 12732 (class 0 OID 0)
-- Dependencies: 828
-- Name: COLUMN sgf_forma_recebimento.conta_cheque_pagamento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_forma_recebimento.conta_cheque_pagamento IS 'conta para cheque usado para pagamento';


--
-- TOC entry 12733 (class 0 OID 0)
-- Dependencies: 828
-- Name: COLUMN sgf_forma_recebimento.promissoria; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_forma_recebimento.promissoria IS 'S = sim, N = não';


--
-- TOC entry 829 (class 1259 OID 14564646)
-- Name: sge_forma_recebimento_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_forma_recebimento_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_forma_recebimento_id_seq OWNER TO postgres;

--
-- TOC entry 12734 (class 0 OID 0)
-- Dependencies: 829
-- Name: sge_forma_recebimento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_forma_recebimento_id_seq OWNED BY public.sgf_forma_recebimento.id;


--
-- TOC entry 830 (class 1259 OID 14564648)
-- Name: sge_formulario_diversos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_formulario_diversos (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 titulo character varying(150) NOT NULL,
 arquivo character varying(80) NOT NULL,
 id_seg_login character varying(32),
 data_hora timestamp(0) without time zone DEFAULT now(),
 observacao text,
 id_bas_estabelecimento bigint
);


ALTER TABLE public.sge_formulario_diversos OWNER TO postgres;

--
-- TOC entry 831 (class 1259 OID 14564655)
-- Name: sge_formulario_diversos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_formulario_diversos_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_formulario_diversos_id_seq OWNER TO postgres;

--
-- TOC entry 12735 (class 0 OID 0)
-- Dependencies: 831
-- Name: sge_formulario_diversos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_formulario_diversos_id_seq OWNED BY public.sge_formulario_diversos.id;


--
-- TOC entry 832 (class 1259 OID 14564657)
-- Name: sge_formulario_diversos_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_formulario_diversos_log (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_seg_users character varying(32),
 id_seg_login_arquivo character varying(32),
 titulo_arquivo character varying(80),
 observacao_arquivo text,
 arquivo character varying(200),
 data_hora timestamp without time zone,
 data_hora_insercao_arquivo timestamp without time zone,
 id_bas_estabelecimento_arquivo bigint
);


ALTER TABLE public.sge_formulario_diversos_log OWNER TO postgres;

--
-- TOC entry 833 (class 1259 OID 14564663)
-- Name: sge_formulario_diversos_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_formulario_diversos_log_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_formulario_diversos_log_id_seq OWNER TO postgres;

--
-- TOC entry 12736 (class 0 OID 0)
-- Dependencies: 833
-- Name: sge_formulario_diversos_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_formulario_diversos_log_id_seq OWNED BY public.sge_formulario_diversos_log.id;


--
-- TOC entry 834 (class 1259 OID 14564665)
-- Name: sge_funcao_turma; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_funcao_turma (
 id bigint NOT NULL,
 nome character varying(100)
);


ALTER TABLE public.sge_funcao_turma OWNER TO postgres;

--
-- TOC entry 12737 (class 0 OID 0)
-- Dependencies: 834
-- Name: TABLE sge_funcao_turma; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sge_funcao_turma IS 'Funções do professor na turma.';


--
-- TOC entry 835 (class 1259 OID 14564668)
-- Name: sge_funcao_turma_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_funcao_turma_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_funcao_turma_id_seq OWNER TO postgres;

--
-- TOC entry 12738 (class 0 OID 0)
-- Dependencies: 835
-- Name: sge_funcao_turma_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_funcao_turma_id_seq OWNED BY public.sge_funcao_turma.id;


--
-- TOC entry 836 (class 1259 OID 14564670)
-- Name: sge_grade; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_grade (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_serie bigint,
 id_sge_turma bigint,
 nome character varying(100) NOT NULL,
 objetivo text,
 data_inicio date,
 data_fim date,
 ano integer NOT NULL,
 autorizacao character varying(100),
 data_autorizacao date
);


ALTER TABLE public.sge_grade OWNER TO postgres;

--
-- TOC entry 12739 (class 0 OID 0)
-- Dependencies: 836
-- Name: COLUMN sge_grade.ano; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_grade.ano IS 'Ano de criacao';


--
-- TOC entry 837 (class 1259 OID 14564676)
-- Name: sge_grade_disciplina; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_grade_disciplina (
 id_sge_grade bigint NOT NULL,
 id_sge_disciplina bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_disciplina_pai bigint,
 id_sge_grupo_disciplina bigint,
 id_sge_conceito bigint,
 id_sge_modulo bigint,
 carga_horaria integer,
 ementa text,
 valor numeric(9,2),
 conceito character(1),
 quadro character(1),
 reprova character(1),
 recebe_nota character(1),
 optativa character(1),
 limite_faltas integer,
 sequencial integer,
 data_cadastro date NOT NULL,
 ficha character(1),
 aulas_previstas smallint
);


ALTER TABLE public.sge_grade_disciplina OWNER TO postgres;

--
-- TOC entry 12740 (class 0 OID 0)
-- Dependencies: 837
-- Name: COLUMN sge_grade_disciplina.conceito; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_grade_disciplina.conceito IS 'S/N';


--
-- TOC entry 12741 (class 0 OID 0)
-- Dependencies: 837
-- Name: COLUMN sge_grade_disciplina.quadro; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_grade_disciplina.quadro IS 'S/N';


--
-- TOC entry 12742 (class 0 OID 0)
-- Dependencies: 837
-- Name: COLUMN sge_grade_disciplina.reprova; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_grade_disciplina.reprova IS 'S/N';


--
-- TOC entry 12743 (class 0 OID 0)
-- Dependencies: 837
-- Name: COLUMN sge_grade_disciplina.recebe_nota; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_grade_disciplina.recebe_nota IS 'S/N';


--
-- TOC entry 12744 (class 0 OID 0)
-- Dependencies: 837
-- Name: COLUMN sge_grade_disciplina.optativa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_grade_disciplina.optativa IS 'S/N';


--
-- TOC entry 12745 (class 0 OID 0)
-- Dependencies: 837
-- Name: COLUMN sge_grade_disciplina.limite_faltas; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_grade_disciplina.limite_faltas IS 'Quantidade de faltas que reprova';


--
-- TOC entry 12746 (class 0 OID 0)
-- Dependencies: 837
-- Name: COLUMN sge_grade_disciplina.ficha; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_grade_disciplina.ficha IS 'S/N';


--
-- TOC entry 838 (class 1259 OID 14564682)
-- Name: sge_grade_historico; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_grade_historico (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(50),
 id_sge_eja_nomenclatura bigint
);


ALTER TABLE public.sge_grade_historico OWNER TO postgres;

--
-- TOC entry 839 (class 1259 OID 14564685)
-- Name: sge_grade_historico_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_grade_historico_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_grade_historico_id_seq OWNER TO postgres;

--
-- TOC entry 12747 (class 0 OID 0)
-- Dependencies: 839
-- Name: sge_grade_historico_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_grade_historico_id_seq OWNED BY public.sge_grade_historico.id;


--
-- TOC entry 840 (class 1259 OID 14564687)
-- Name: sge_grade_historico_serie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_grade_historico_serie (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_grade_historico bigint,
 ordem smallint,
 nome character varying(50),
 tipo character(1)
);


ALTER TABLE public.sge_grade_historico_serie OWNER TO postgres;

--
-- TOC entry 12748 (class 0 OID 0)
-- Dependencies: 840
-- Name: COLUMN sge_grade_historico_serie.tipo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_grade_historico_serie.tipo IS 'I=Iniciais, F=Finais';


--
-- TOC entry 841 (class 1259 OID 14564690)
-- Name: sge_grade_historico_serie_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_grade_historico_serie_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_grade_historico_serie_id_seq OWNER TO postgres;

--
-- TOC entry 12749 (class 0 OID 0)
-- Dependencies: 841
-- Name: sge_grade_historico_serie_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_grade_historico_serie_id_seq OWNED BY public.sge_grade_historico_serie.id;


--
-- TOC entry 842 (class 1259 OID 14564692)
-- Name: sge_grade_horario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_grade_horario (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_turma bigint,
 id_sge_disciplina bigint,
 id_sge_faixa_horario_item bigint,
 dia_semana smallint,
 id_sge_professor_disciplina_turma bigint,
 ano_letivo smallint NOT NULL,
 id_sge_professor_disciplina_turma_monitor bigint,
 data_registro date,
 data_inicio date,
 data_fim date
);


ALTER TABLE public.sge_grade_horario OWNER TO postgres;

--
-- TOC entry 12750 (class 0 OID 0)
-- Dependencies: 842
-- Name: COLUMN sge_grade_horario.dia_semana; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_grade_horario.dia_semana IS '2=segunda, 3=terca, 4=quarta,...';


--
-- TOC entry 843 (class 1259 OID 14564695)
-- Name: sge_grade_horario_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_grade_horario_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_grade_horario_id_seq OWNER TO postgres;

--
-- TOC entry 12751 (class 0 OID 0)
-- Dependencies: 843
-- Name: sge_grade_horario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_grade_horario_id_seq OWNED BY public.sge_grade_horario.id;


--
-- TOC entry 844 (class 1259 OID 14564697)
-- Name: sge_grade_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_grade_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_grade_id_seq OWNER TO postgres;

--
-- TOC entry 12752 (class 0 OID 0)
-- Dependencies: 844
-- Name: sge_grade_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_grade_id_seq OWNED BY public.sge_grade.id;


--
-- TOC entry 845 (class 1259 OID 14564699)
-- Name: sge_graduacao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_graduacao (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 descricao character varying(150) NOT NULL
);
ALTER TABLE ONLY public.sge_graduacao ALTER COLUMN id SET STATISTICS 0;
ALTER TABLE ONLY public.sge_graduacao ALTER COLUMN id_bas_empresa SET STATISTICS 0;
ALTER TABLE ONLY public.sge_graduacao ALTER COLUMN descricao SET STATISTICS 0;


ALTER TABLE public.sge_graduacao OWNER TO postgres;

--
-- TOC entry 846 (class 1259 OID 14564702)
-- Name: sge_graduacao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_graduacao_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_graduacao_id_seq OWNER TO postgres;

--
-- TOC entry 12753 (class 0 OID 0)
-- Dependencies: 846
-- Name: sge_graduacao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_graduacao_id_seq OWNED BY public.sge_graduacao.id;


--
-- TOC entry 847 (class 1259 OID 14564704)
-- Name: sge_grupo_disciplina; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_grupo_disciplina (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(100) NOT NULL,
 sigla character varying(3)
);


ALTER TABLE public.sge_grupo_disciplina OWNER TO postgres;

--
-- TOC entry 848 (class 1259 OID 14564707)
-- Name: sge_grupo_disciplina_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_grupo_disciplina_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_grupo_disciplina_id_seq OWNER TO postgres;

--
-- TOC entry 12754 (class 0 OID 0)
-- Dependencies: 848
-- Name: sge_grupo_disciplina_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_grupo_disciplina_id_seq OWNED BY public.sge_grupo_disciplina.id;


--
-- TOC entry 849 (class 1259 OID 14564709)
-- Name: sge_grupo_material; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_grupo_material (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(100) NOT NULL
);


ALTER TABLE public.sge_grupo_material OWNER TO postgres;

--
-- TOC entry 850 (class 1259 OID 14564712)
-- Name: sge_grupo_material_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_grupo_material_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_grupo_material_id_seq OWNER TO postgres;

--
-- TOC entry 12755 (class 0 OID 0)
-- Dependencies: 850
-- Name: sge_grupo_material_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_grupo_material_id_seq OWNED BY public.sge_grupo_material.id;


--
-- TOC entry 851 (class 1259 OID 14564714)
-- Name: sge_historico_disciplina; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_historico_disciplina (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_disciplina bigint NOT NULL,
 id_sge_grupo_disciplina bigint NOT NULL,
 nota_1ano_f character varying(10),
 carga_horaria_1ano_f numeric(6,2),
 nota_2ano_f character varying(10),
 carga_horaria_2ano_f numeric(6,2),
 nota_3ano_f character varying(10),
 carga_horaria_3ano_f numeric(6,2),
 nota_4ano_f numeric(6,3),
 carga_horaria_4ano_f numeric(6,2),
 nota_5ano_f numeric(6,3),
 carga_horaria_5ano_f numeric(6,2),
 nota_6ano_f numeric(6,3),
 carga_horaria_6ano_f numeric(6,2),
 nota_7ano_f numeric(6,3),
 carga_horaria_7ano_f numeric(6,2),
 nota_8ano_f numeric(6,3),
 carga_horaria_8ano_f numeric(6,2),
 nota_9ano_f numeric(6,3),
 carga_horaria_9ano_f numeric(6,2),
 nota_1ano_m numeric(6,3),
 carga_horaria_1ano_m numeric(6,2),
 nota_2ano_m numeric(6,3),
 carga_horaria_2ano_m numeric(6,2),
 nota_3ano_m numeric(6,3),
 carga_horaria_3ano_m numeric(6,2),
 id_sge_aluno bigint NOT NULL,
 ordem smallint,
 nota_1ano_eja character varying(6),
 carga_horaria_1ano_eja character varying(6),
 nota_2ano_eja character varying(6),
 carga_horaria_2ano_eja character varying(6),
 nota_3ano_eja character varying(6),
 carga_horaria_3ano_eja character varying(6),
 nota_4ano_eja character varying(6),
 carga_horaria_4ano_eja character varying(6),
 nota_5ano_eja character varying(6),
 carga_horaria_5ano_eja character varying(6),
 nota_6ano_eja character varying(6),
 carga_horaria_6ano_eja character varying(6)
);


ALTER TABLE public.sge_historico_disciplina OWNER TO postgres;

--
-- TOC entry 12756 (class 0 OID 0)
-- Dependencies: 851
-- Name: COLUMN sge_historico_disciplina.nota_1ano_f; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_historico_disciplina.nota_1ano_f IS 'Nota do 1º ano do ensino fundamental';


--
-- TOC entry 12757 (class 0 OID 0)
-- Dependencies: 851
-- Name: COLUMN sge_historico_disciplina.carga_horaria_1ano_f; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_historico_disciplina.carga_horaria_1ano_f IS 'Carga horária do 1º ano do ensino fundamental';


--
-- TOC entry 12758 (class 0 OID 0)
-- Dependencies: 851
-- Name: COLUMN sge_historico_disciplina.nota_2ano_f; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_historico_disciplina.nota_2ano_f IS 'Nota do 2º ano do ensino fundamental';


--
-- TOC entry 12759 (class 0 OID 0)
-- Dependencies: 851
-- Name: COLUMN sge_historico_disciplina.carga_horaria_2ano_f; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_historico_disciplina.carga_horaria_2ano_f IS 'Carga horária do 2º ano do ensino fundamental';


--
-- TOC entry 12760 (class 0 OID 0)
-- Dependencies: 851
-- Name: COLUMN sge_historico_disciplina.nota_3ano_f; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_historico_disciplina.nota_3ano_f IS 'Nota do 3º ano do ensino fundamental';


--
-- TOC entry 12761 (class 0 OID 0)
-- Dependencies: 851
-- Name: COLUMN sge_historico_disciplina.carga_horaria_3ano_f; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_historico_disciplina.carga_horaria_3ano_f IS 'Carga horária do 3º ano do ensino fundamental';


--
-- TOC entry 12762 (class 0 OID 0)
-- Dependencies: 851
-- Name: COLUMN sge_historico_disciplina.nota_4ano_f; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_historico_disciplina.nota_4ano_f IS 'Nota do 4º ano do ensino fundamental';


--
-- TOC entry 12763 (class 0 OID 0)
-- Dependencies: 851
-- Name: COLUMN sge_historico_disciplina.carga_horaria_4ano_f; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_historico_disciplina.carga_horaria_4ano_f IS 'Carga horária do 4º ano do ensino fundamental';


--
-- TOC entry 12764 (class 0 OID 0)
-- Dependencies: 851
-- Name: COLUMN sge_historico_disciplina.nota_5ano_f; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_historico_disciplina.nota_5ano_f IS 'Nota do 5º ano do ensino fundamental';


--
-- TOC entry 12765 (class 0 OID 0)
-- Dependencies: 851
-- Name: COLUMN sge_historico_disciplina.carga_horaria_5ano_f; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_historico_disciplina.carga_horaria_5ano_f IS 'Carga horária do 5º ano do ensino fundamental';


--
-- TOC entry 12766 (class 0 OID 0)
-- Dependencies: 851
-- Name: COLUMN sge_historico_disciplina.nota_6ano_f; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_historico_disciplina.nota_6ano_f IS 'Nota do 6º ano do ensino fundamental';


--
-- TOC entry 12767 (class 0 OID 0)
-- Dependencies: 851
-- Name: COLUMN sge_historico_disciplina.carga_horaria_6ano_f; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_historico_disciplina.carga_horaria_6ano_f IS 'Carga horária do 6º ano do ensino fundamental';


--
-- TOC entry 12768 (class 0 OID 0)
-- Dependencies: 851
-- Name: COLUMN sge_historico_disciplina.nota_7ano_f; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_historico_disciplina.nota_7ano_f IS 'Nota do 7º ano do ensino fundamental';


--
-- TOC entry 12769 (class 0 OID 0)
-- Dependencies: 851
-- Name: COLUMN sge_historico_disciplina.carga_horaria_7ano_f; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_historico_disciplina.carga_horaria_7ano_f IS 'Carga horária do 7º ano do ensino fundamental';


--
-- TOC entry 12770 (class 0 OID 0)
-- Dependencies: 851
-- Name: COLUMN sge_historico_disciplina.nota_8ano_f; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_historico_disciplina.nota_8ano_f IS 'Nota do 8º ano do ensino fundamental';


--
-- TOC entry 12771 (class 0 OID 0)
-- Dependencies: 851
-- Name: COLUMN sge_historico_disciplina.carga_horaria_8ano_f; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_historico_disciplina.carga_horaria_8ano_f IS 'Carga horária do 8º ano do ensino fundamental';


--
-- TOC entry 12772 (class 0 OID 0)
-- Dependencies: 851
-- Name: COLUMN sge_historico_disciplina.nota_9ano_f; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_historico_disciplina.nota_9ano_f IS 'Nota do 9º ano do ensino fundamental';


--
-- TOC entry 12773 (class 0 OID 0)
-- Dependencies: 851
-- Name: COLUMN sge_historico_disciplina.carga_horaria_9ano_f; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_historico_disciplina.carga_horaria_9ano_f IS 'Carga horária do 9º ano do ensino fundamental';


--
-- TOC entry 12774 (class 0 OID 0)
-- Dependencies: 851
-- Name: COLUMN sge_historico_disciplina.nota_1ano_m; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_historico_disciplina.nota_1ano_m IS 'Nota do 1ª série do ensino médio';


--
-- TOC entry 12775 (class 0 OID 0)
-- Dependencies: 851
-- Name: COLUMN sge_historico_disciplina.carga_horaria_1ano_m; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_historico_disciplina.carga_horaria_1ano_m IS 'Carga horária do 1ª série do ensino médio';


--
-- TOC entry 12776 (class 0 OID 0)
-- Dependencies: 851
-- Name: COLUMN sge_historico_disciplina.nota_2ano_m; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_historico_disciplina.nota_2ano_m IS 'Nota do 2ª série do ensino médio';


--
-- TOC entry 12777 (class 0 OID 0)
-- Dependencies: 851
-- Name: COLUMN sge_historico_disciplina.carga_horaria_2ano_m; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_historico_disciplina.carga_horaria_2ano_m IS 'Carga horária do 2ª série do ensino médio';


--
-- TOC entry 12778 (class 0 OID 0)
-- Dependencies: 851
-- Name: COLUMN sge_historico_disciplina.nota_3ano_m; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_historico_disciplina.nota_3ano_m IS 'Nota do 3ª série do ensino médio';


--
-- TOC entry 12779 (class 0 OID 0)
-- Dependencies: 851
-- Name: COLUMN sge_historico_disciplina.carga_horaria_3ano_m; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_historico_disciplina.carga_horaria_3ano_m IS 'Carga horária do 3ª série do ensino médio';


--
-- TOC entry 12780 (class 0 OID 0)
-- Dependencies: 851
-- Name: COLUMN sge_historico_disciplina.ordem; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_historico_disciplina.ordem IS 'Ordem que aparecerá na emissão do histórico';


--
-- TOC entry 12781 (class 0 OID 0)
-- Dependencies: 851
-- Name: COLUMN sge_historico_disciplina.nota_1ano_eja; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_historico_disciplina.nota_1ano_eja IS 'Nota da serie de ordem 1 do EJA';


--
-- TOC entry 12782 (class 0 OID 0)
-- Dependencies: 851
-- Name: COLUMN sge_historico_disciplina.carga_horaria_1ano_eja; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_historico_disciplina.carga_horaria_1ano_eja IS 'Carga horária da série de ordem 1 do EJA';


--
-- TOC entry 12783 (class 0 OID 0)
-- Dependencies: 851
-- Name: COLUMN sge_historico_disciplina.nota_2ano_eja; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_historico_disciplina.nota_2ano_eja IS 'Nota da serie de ordem 2 do EJA';


--
-- TOC entry 12784 (class 0 OID 0)
-- Dependencies: 851
-- Name: COLUMN sge_historico_disciplina.carga_horaria_2ano_eja; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_historico_disciplina.carga_horaria_2ano_eja IS 'Carga horária da série de ordem 2 do EJA';


--
-- TOC entry 12785 (class 0 OID 0)
-- Dependencies: 851
-- Name: COLUMN sge_historico_disciplina.nota_3ano_eja; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_historico_disciplina.nota_3ano_eja IS 'Nota da serie de ordem 3 do EJA';


--
-- TOC entry 12786 (class 0 OID 0)
-- Dependencies: 851
-- Name: COLUMN sge_historico_disciplina.carga_horaria_3ano_eja; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_historico_disciplina.carga_horaria_3ano_eja IS 'Carga horária da série de ordem 3 do EJA';


--
-- TOC entry 12787 (class 0 OID 0)
-- Dependencies: 851
-- Name: COLUMN sge_historico_disciplina.nota_4ano_eja; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_historico_disciplina.nota_4ano_eja IS 'Nota da serie de ordem 4 do EJA';


--
-- TOC entry 12788 (class 0 OID 0)
-- Dependencies: 851
-- Name: COLUMN sge_historico_disciplina.carga_horaria_4ano_eja; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_historico_disciplina.carga_horaria_4ano_eja IS 'Carga horária da série de ordem 4 do EJA';


--
-- TOC entry 12789 (class 0 OID 0)
-- Dependencies: 851
-- Name: COLUMN sge_historico_disciplina.nota_5ano_eja; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_historico_disciplina.nota_5ano_eja IS 'Nota da serie de ordem 5 do EJA';


--
-- TOC entry 12790 (class 0 OID 0)
-- Dependencies: 851
-- Name: COLUMN sge_historico_disciplina.carga_horaria_5ano_eja; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_historico_disciplina.carga_horaria_5ano_eja IS 'Carga horária da série de ordem 5 do EJA';


--
-- TOC entry 12791 (class 0 OID 0)
-- Dependencies: 851
-- Name: COLUMN sge_historico_disciplina.nota_6ano_eja; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_historico_disciplina.nota_6ano_eja IS 'Nota da serie de ordem 6 do EJA';


--
-- TOC entry 12792 (class 0 OID 0)
-- Dependencies: 851
-- Name: COLUMN sge_historico_disciplina.carga_horaria_6ano_eja; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_historico_disciplina.carga_horaria_6ano_eja IS 'Carga horária da série de ordem 6 do EJA';


--
-- TOC entry 852 (class 1259 OID 14564717)
-- Name: sge_historico_disciplina_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_historico_disciplina_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_historico_disciplina_id_seq OWNER TO postgres;

--
-- TOC entry 12793 (class 0 OID 0)
-- Dependencies: 852
-- Name: sge_historico_disciplina_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_historico_disciplina_id_seq OWNED BY public.sge_historico_disciplina.id;


--
-- TOC entry 853 (class 1259 OID 14564719)
-- Name: sge_historico_escola; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_historico_escola (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_escola_origem bigint NOT NULL,
 id_sge_equivalencia_curricular bigint NOT NULL,
 ano integer,
 id_sge_aluno bigint NOT NULL,
 origem_dos_dados character(1),
 ed_fisica_aulas integer,
 ed_fisica_faltas integer,
 portaria character varying(100)
);


ALTER TABLE public.sge_historico_escola OWNER TO postgres;

--
-- TOC entry 12794 (class 0 OID 0)
-- Dependencies: 853
-- Name: COLUMN sge_historico_escola.origem_dos_dados; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_historico_escola.origem_dos_dados IS 'Indica se os dados vem do boletim ou do histórico. B = Boletim, H = Histórico';


--
-- TOC entry 854 (class 1259 OID 14564722)
-- Name: sge_historico_escola_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_historico_escola_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_historico_escola_id_seq OWNER TO postgres;

--
-- TOC entry 12795 (class 0 OID 0)
-- Dependencies: 854
-- Name: sge_historico_escola_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_historico_escola_id_seq OWNED BY public.sge_historico_escola.id;


--
-- TOC entry 855 (class 1259 OID 14564724)
-- Name: sge_instituicao_ensino; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_instituicao_ensino (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(100) NOT NULL,
 logradouro character varying(100),
 numero character varying(10),
 municipio character varying(40),
 telefone character varying(11),
 tipo character(1) NOT NULL,
 uf character(2),
 cep character varying(10),
 ensino character(1)
);


ALTER TABLE public.sge_instituicao_ensino OWNER TO postgres;

--
-- TOC entry 12796 (class 0 OID 0)
-- Dependencies: 855
-- Name: COLUMN sge_instituicao_ensino.tipo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_instituicao_ensino.tipo IS '1 - Federal, 2 - Estadual, 3 - Municipal, 4 - Particular';


--
-- TOC entry 12797 (class 0 OID 0)
-- Dependencies: 855
-- Name: COLUMN sge_instituicao_ensino.ensino; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_instituicao_ensino.ensino IS '"S" = Superior, "M" = Médio/Fundamental, "J" = Jardim de Infância, "T" = Técnico';


--
-- TOC entry 856 (class 1259 OID 14564727)
-- Name: sge_instituicao_ensino_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_instituicao_ensino_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_instituicao_ensino_id_seq OWNER TO postgres;

--
-- TOC entry 12798 (class 0 OID 0)
-- Dependencies: 856
-- Name: sge_instituicao_ensino_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_instituicao_ensino_id_seq OWNED BY public.sge_instituicao_ensino.id;


--
-- TOC entry 857 (class 1259 OID 14564729)
-- Name: sge_liberacao_digitacao_notas_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_liberacao_digitacao_notas_log (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_etapa bigint NOT NULL,
 login_autorizado character varying(32) NOT NULL,
 login_autorizacao character varying(32) NOT NULL,
 data_inicio date NOT NULL,
 data_fim date NOT NULL,
 observacao text,
 data date NOT NULL
);


ALTER TABLE public.sge_liberacao_digitacao_notas_log OWNER TO postgres;

--
-- TOC entry 12799 (class 0 OID 0)
-- Dependencies: 857
-- Name: COLUMN sge_liberacao_digitacao_notas_log.id_sge_etapa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_liberacao_digitacao_notas_log.id_sge_etapa IS 'Etapa que será liberada para digitação';


--
-- TOC entry 12800 (class 0 OID 0)
-- Dependencies: 857
-- Name: COLUMN sge_liberacao_digitacao_notas_log.login_autorizado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_liberacao_digitacao_notas_log.login_autorizado IS 'Login autorizado a digitar';


--
-- TOC entry 12801 (class 0 OID 0)
-- Dependencies: 857
-- Name: COLUMN sge_liberacao_digitacao_notas_log.login_autorizacao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_liberacao_digitacao_notas_log.login_autorizacao IS 'Login que auorizou a digitação';


--
-- TOC entry 12802 (class 0 OID 0)
-- Dependencies: 857
-- Name: COLUMN sge_liberacao_digitacao_notas_log.data_inicio; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_liberacao_digitacao_notas_log.data_inicio IS 'Data inicial do período para digitação autorizada';


--
-- TOC entry 12803 (class 0 OID 0)
-- Dependencies: 857
-- Name: COLUMN sge_liberacao_digitacao_notas_log.data_fim; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_liberacao_digitacao_notas_log.data_fim IS 'Data final do período para digitação autorizada';


--
-- TOC entry 858 (class 1259 OID 14564735)
-- Name: sge_liberacao_digitacao_notas_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_liberacao_digitacao_notas_log_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_liberacao_digitacao_notas_log_id_seq OWNER TO postgres;

--
-- TOC entry 12804 (class 0 OID 0)
-- Dependencies: 858
-- Name: sge_liberacao_digitacao_notas_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_liberacao_digitacao_notas_log_id_seq OWNED BY public.sge_liberacao_digitacao_notas_log.id;


SET default_with_oids = true;

--
-- TOC entry 859 (class 1259 OID 14564737)
-- Name: sge_lider_turma; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_lider_turma (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_turma_aluno bigint NOT NULL,
 data_inicio date NOT NULL,
 data_final date NOT NULL
);


ALTER TABLE public.sge_lider_turma OWNER TO postgres;

--
-- TOC entry 860 (class 1259 OID 14564740)
-- Name: sge_lider_turma_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_lider_turma_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_lider_turma_id_seq OWNER TO postgres;

--
-- TOC entry 12805 (class 0 OID 0)
-- Dependencies: 860
-- Name: sge_lider_turma_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_lider_turma_id_seq OWNED BY public.sge_lider_turma.id;


SET default_with_oids = false;

--
-- TOC entry 861 (class 1259 OID 14564742)
-- Name: sge_local_aula; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_local_aula (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 descricacao character varying(50) NOT NULL
);


ALTER TABLE public.sge_local_aula OWNER TO postgres;

--
-- TOC entry 12806 (class 0 OID 0)
-- Dependencies: 861
-- Name: TABLE sge_local_aula; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sge_local_aula IS 'Cadastra os locais de aula';


--
-- TOC entry 12807 (class 0 OID 0)
-- Dependencies: 861
-- Name: COLUMN sge_local_aula.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_local_aula.id IS 'Identificador sequencial da tabela, chave primaria composta com o campo id_bas_empresa';


--
-- TOC entry 12808 (class 0 OID 0)
-- Dependencies: 861
-- Name: COLUMN sge_local_aula.id_bas_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_local_aula.id_bas_empresa IS 'Identificador da tabela bas_empresa, chave primaria composta com o campo id';


--
-- TOC entry 12809 (class 0 OID 0)
-- Dependencies: 861
-- Name: COLUMN sge_local_aula.descricacao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_local_aula.descricacao IS 'Descrição do local de aula';


--
-- TOC entry 862 (class 1259 OID 14564745)
-- Name: sge_local_aula_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_local_aula_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_local_aula_id_seq OWNER TO postgres;

--
-- TOC entry 12810 (class 0 OID 0)
-- Dependencies: 862
-- Name: sge_local_aula_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_local_aula_id_seq OWNED BY public.sge_local_aula.id;


--
-- TOC entry 863 (class 1259 OID 14564747)
-- Name: sge_log_matricula_offline; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_log_matricula_offline (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_estabelecimento bigint,
 situacao character(1),
 situacao_academica text NOT NULL,
 prefixo text NOT NULL,
 observacao text NOT NULL,
 nome_aluno text NOT NULL,
 data_nascimento text NOT NULL,
 turma_id text NOT NULL,
 numero_matricula_aluno text NOT NULL,
 nome_filiacao_1 text NOT NULL,
 tipo_filiacao_1 text NOT NULL,
 nome_filiacao_2 text NOT NULL,
 tipo_filiacao_2 text NOT NULL,
 sexo text NOT NULL,
 estado_civil text NOT NULL,
 naturalidade text NOT NULL,
 uf_nascimento text NOT NULL,
 necessidades_especiais text NOT NULL,
 necessidade_fisica text NOT NULL,
 necessidade_visual text NOT NULL,
 necessidade_mental text NOT NULL,
 necessidade_auditiva text NOT NULL,
 raca_cor text NOT NULL,
 tipo_sanguineo text NOT NULL,
 alergia_medicamento text NOT NULL,
 nome_medicamento text NOT NULL,
 modelo_certidao text NOT NULL,
 tipo_certidao text NOT NULL,
 numero_termo text NOT NULL,
 folha text NOT NULL,
 livro text NOT NULL,
 data_emissao_certidao text NOT NULL,
 municipio_cartorio text NOT NULL,
 uf_cartorio text NOT NULL,
 nome_cartorio text NOT NULL,
 numero_matricula_certidao text NOT NULL,
 rg text NOT NULL,
 data_emissao_rg text NOT NULL,
 uf_rg text NOT NULL,
 orgao_emissor_rg text NOT NULL,
 cpf text NOT NULL,
 titulo_eleitor text NOT NULL,
 zona text NOT NULL,
 secao text NOT NULL,
 numero_bolsa_familia text NOT NULL,
 cep text NOT NULL,
 uf_cep text NOT NULL,
 municipio_cep text NOT NULL,
 bairro_cep text NOT NULL,
 endereco text NOT NULL,
 complemento text NOT NULL,
 telefone_fixo text NOT NULL,
 telefone_celular text NOT NULL,
 utiliza_transporte text NOT NULL,
 _id character varying(300),
 observacao_migracao text,
 data_inclusao date DEFAULT now(),
 nome_responsavel_legal text,
 tipo_responsavel_legal text,
 data_matricula text,
 rg_filiacao_1 text,
 uf_nascimento_ne text,
 uf_cartorio_ne text,
 municipio_cartorio_ne text,
 uf_rg_ne text,
 naturalidade_ne text,
 uf_cep_ne text,
 municipio_cep_ne text,
 documento_serie text,
 material_serie text,
 tamanho_material text,
 tipo_aluno text,
 alergia_alimento text,
 nome_alimento text,
 numero_cartao_sus text,
 numero_pas text,
 educa_chico text,
 data_cadastro text
);


ALTER TABLE public.sge_log_matricula_offline OWNER TO postgres;

--
-- TOC entry 12811 (class 0 OID 0)
-- Dependencies: 863
-- Name: COLUMN sge_log_matricula_offline.situacao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_log_matricula_offline.situacao IS 'M = Migrado, N = Não Migrado';


--
-- TOC entry 864 (class 1259 OID 14564754)
-- Name: sge_log_matricula_offline_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_log_matricula_offline_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_log_matricula_offline_id_seq OWNER TO postgres;

--
-- TOC entry 12812 (class 0 OID 0)
-- Dependencies: 864
-- Name: sge_log_matricula_offline_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_log_matricula_offline_id_seq OWNED BY public.sge_log_matricula_offline.id;


--
-- TOC entry 865 (class 1259 OID 14564756)
-- Name: sge_material; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_material (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_grupo_material bigint,
 nome character varying(100),
 unidade character varying(10),
 unidade_conversao numeric(7,2)
);


ALTER TABLE public.sge_material OWNER TO postgres;

--
-- TOC entry 866 (class 1259 OID 14564759)
-- Name: sge_material_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_material_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_material_id_seq OWNER TO postgres;

--
-- TOC entry 12813 (class 0 OID 0)
-- Dependencies: 866
-- Name: sge_material_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_material_id_seq OWNED BY public.sge_material.id;


--
-- TOC entry 867 (class 1259 OID 14564761)
-- Name: sge_matricula_situacao_academica_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_matricula_situacao_academica_log (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_turma_aluno bigint NOT NULL,
 id_sge_situacao_academica bigint NOT NULL,
 login character varying(32) NOT NULL,
 data date NOT NULL,
 hora time without time zone NOT NULL,
 data_cancelamento date,
 motivo character varying(300),
 id_sge_turma bigint,
 id_sge_aluno bigint
);


ALTER TABLE public.sge_matricula_situacao_academica_log OWNER TO postgres;

--
-- TOC entry 12814 (class 0 OID 0)
-- Dependencies: 867
-- Name: COLUMN sge_matricula_situacao_academica_log.data_cancelamento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_matricula_situacao_academica_log.data_cancelamento IS 'Data da ocorrência, registrado em tela pelo usuário, via sistema.';


--
-- TOC entry 868 (class 1259 OID 14564764)
-- Name: sge_matricula_situacao_academica_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_matricula_situacao_academica_log_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_matricula_situacao_academica_log_id_seq OWNER TO postgres;

--
-- TOC entry 12815 (class 0 OID 0)
-- Dependencies: 868
-- Name: sge_matricula_situacao_academica_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_matricula_situacao_academica_log_id_seq OWNED BY public.sge_matricula_situacao_academica_log.id;


--
-- TOC entry 869 (class 1259 OID 14564766)
-- Name: sge_modo_ingresso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_modo_ingresso (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(100) NOT NULL,
 tipo character(1) NOT NULL,
 especial character(1) DEFAULT 'N'::bpchar NOT NULL
);
ALTER TABLE ONLY public.sge_modo_ingresso ALTER COLUMN id SET STATISTICS 0;
ALTER TABLE ONLY public.sge_modo_ingresso ALTER COLUMN tipo SET STATISTICS 0;


ALTER TABLE public.sge_modo_ingresso OWNER TO postgres;

--
-- TOC entry 12816 (class 0 OID 0)
-- Dependencies: 869
-- Name: COLUMN sge_modo_ingresso.tipo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_modo_ingresso.tipo IS '"V" = "Veterano", N = "Aluno Novo".';


--
-- TOC entry 12817 (class 0 OID 0)
-- Dependencies: 869
-- Name: COLUMN sge_modo_ingresso.especial; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_modo_ingresso.especial IS 'Determina se um modo de ingresso é tratado de forma especial na hora da matrícula.';


--
-- TOC entry 870 (class 1259 OID 14564770)
-- Name: sge_modo_ingresso_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_modo_ingresso_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_modo_ingresso_id_seq OWNER TO postgres;

--
-- TOC entry 12818 (class 0 OID 0)
-- Dependencies: 870
-- Name: sge_modo_ingresso_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_modo_ingresso_id_seq OWNED BY public.sge_modo_ingresso.id;


SET default_with_oids = true;

--
-- TOC entry 871 (class 1259 OID 14564772)
-- Name: sge_modulo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_modulo (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(50) NOT NULL,
 ordem smallint
);


ALTER TABLE public.sge_modulo OWNER TO postgres;

--
-- TOC entry 872 (class 1259 OID 14564775)
-- Name: sge_modulo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_modulo_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_modulo_id_seq OWNER TO postgres;

--
-- TOC entry 12819 (class 0 OID 0)
-- Dependencies: 872
-- Name: sge_modulo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_modulo_id_seq OWNED BY public.sge_modulo.id;


SET default_with_oids = false;

--
-- TOC entry 873 (class 1259 OID 14564777)
-- Name: sge_naef_visita; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_naef_visita (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_estabelecimento bigint NOT NULL,
 id_bas_colaborador bigint NOT NULL,
 id_sge_turma_aluno bigint NOT NULL,
 motivo character varying,
 data date,
 hora time without time zone,
 nome_familiar_entrevistado character varying(100),
 encaminhamento_durante_visita character varying,
 encaminhamento_posterior_visita character varying,
 login character varying(32) NOT NULL,
 id_bas_grau_parentesco bigint
);


ALTER TABLE public.sge_naef_visita OWNER TO postgres;

--
-- TOC entry 12820 (class 0 OID 0)
-- Dependencies: 873
-- Name: COLUMN sge_naef_visita.nome_familiar_entrevistado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_naef_visita.nome_familiar_entrevistado IS 'Nome do familiar que foi entrevistado em casa';


--
-- TOC entry 12821 (class 0 OID 0)
-- Dependencies: 873
-- Name: COLUMN sge_naef_visita.id_bas_grau_parentesco; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_naef_visita.id_bas_grau_parentesco IS 'Grau de parentesco do familiar entrevistado';


--
-- TOC entry 874 (class 1259 OID 14564783)
-- Name: sge_naef_visita_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_naef_visita_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_naef_visita_id_seq OWNER TO postgres;

--
-- TOC entry 12822 (class 0 OID 0)
-- Dependencies: 874
-- Name: sge_naef_visita_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_naef_visita_id_seq OWNED BY public.sge_naef_visita.id;


--
-- TOC entry 875 (class 1259 OID 14564785)
-- Name: sge_nota_avaliacao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_nota_avaliacao (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_criterio_etapa_avaliacao bigint NOT NULL,
 id_sge_turma_aluno_disciplina_etapa bigint NOT NULL,
 nota numeric(6,3),
 data_inclusao date
);


ALTER TABLE public.sge_nota_avaliacao OWNER TO postgres;

--
-- TOC entry 876 (class 1259 OID 14564788)
-- Name: sge_nota_avaliacao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_nota_avaliacao_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_nota_avaliacao_id_seq OWNER TO postgres;

--
-- TOC entry 12823 (class 0 OID 0)
-- Dependencies: 876
-- Name: sge_nota_avaliacao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_nota_avaliacao_id_seq OWNED BY public.sge_nota_avaliacao.id;


--
-- TOC entry 877 (class 1259 OID 14564790)
-- Name: sge_nota_avaliacao_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_nota_avaliacao_log (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_nota_avaliacao bigint NOT NULL,
 login character varying(32) NOT NULL,
 nota numeric(6,3),
 data date NOT NULL,
 hora time without time zone NOT NULL
);


ALTER TABLE public.sge_nota_avaliacao_log OWNER TO postgres;

--
-- TOC entry 878 (class 1259 OID 14564793)
-- Name: sge_nota_avaliacao_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_nota_avaliacao_log_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_nota_avaliacao_log_id_seq OWNER TO postgres;

--
-- TOC entry 12824 (class 0 OID 0)
-- Dependencies: 878
-- Name: sge_nota_avaliacao_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_nota_avaliacao_log_id_seq OWNED BY public.sge_nota_avaliacao_log.id;


--
-- TOC entry 879 (class 1259 OID 14564795)
-- Name: sge_ocorrencia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_ocorrencia (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 login character varying(32),
 id_sge_ocorrencia_tipo bigint NOT NULL,
 descricao text,
 data date,
 hora time(6) without time zone,
 id_bas_tipo_punicao bigint,
 id_sge_aluno bigint,
 pontuacao numeric(4,2),
 abrangencia character(1) NOT NULL,
 id_bas_colaborador bigint,
 id_bas_estabelecimento bigint
);


ALTER TABLE public.sge_ocorrencia OWNER TO postgres;

--
-- TOC entry 12825 (class 0 OID 0)
-- Dependencies: 879
-- Name: COLUMN sge_ocorrencia.abrangencia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_ocorrencia.abrangencia IS 'I=individual C=coletivo';


--
-- TOC entry 1312 (class 1259 OID 22554125)
-- Name: sge_ocorrencia_de_enfermagem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_ocorrencia_de_enfermagem (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(50)
);


ALTER TABLE public.sge_ocorrencia_de_enfermagem OWNER TO postgres;

--
-- TOC entry 1311 (class 1259 OID 22554123)
-- Name: sge_ocorrencia_de_enfermagem_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_ocorrencia_de_enfermagem_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_ocorrencia_de_enfermagem_id_seq OWNER TO postgres;

--
-- TOC entry 12826 (class 0 OID 0)
-- Dependencies: 1311
-- Name: sge_ocorrencia_de_enfermagem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_ocorrencia_de_enfermagem_id_seq OWNED BY public.sge_ocorrencia_de_enfermagem.id;


--
-- TOC entry 880 (class 1259 OID 14564801)
-- Name: sge_ocorrencia_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_ocorrencia_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_ocorrencia_id_seq OWNER TO postgres;

--
-- TOC entry 12827 (class 0 OID 0)
-- Dependencies: 880
-- Name: sge_ocorrencia_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_ocorrencia_id_seq OWNED BY public.sge_ocorrencia.id;


--
-- TOC entry 881 (class 1259 OID 14564803)
-- Name: sge_ocorrencia_tipo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_ocorrencia_tipo (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(100) NOT NULL,
 classificacao smallint NOT NULL,
 data_cancelamento date,
 tipo_uso smallint
);


ALTER TABLE public.sge_ocorrencia_tipo OWNER TO postgres;

--
-- TOC entry 12828 (class 0 OID 0)
-- Dependencies: 881
-- Name: COLUMN sge_ocorrencia_tipo.classificacao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_ocorrencia_tipo.classificacao IS '1 = positiva, 2 = negativa, 3 = neutra';


--
-- TOC entry 12829 (class 0 OID 0)
-- Dependencies: 881
-- Name: COLUMN sge_ocorrencia_tipo.tipo_uso; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_ocorrencia_tipo.tipo_uso IS '1=Secretaria,2=Professor,3=Ambos (quem aplica)';


--
-- TOC entry 882 (class 1259 OID 14564806)
-- Name: sge_ocorrencia_tipo_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_ocorrencia_tipo_group_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_ocorrencia_tipo_group_id_seq OWNER TO postgres;

--
-- TOC entry 883 (class 1259 OID 14564808)
-- Name: sge_ocorrencia_tipo_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_ocorrencia_tipo_group (
 id bigint DEFAULT nextval('public.sge_ocorrencia_tipo_group_id_seq'::regclass) NOT NULL,
 id_sge_ocorrencia_tipo integer NOT NULL,
 id_seg_group integer NOT NULL
);


ALTER TABLE public.sge_ocorrencia_tipo_group OWNER TO postgres;

--
-- TOC entry 884 (class 1259 OID 14564812)
-- Name: sge_ocorrencia_tipo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_ocorrencia_tipo_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_ocorrencia_tipo_id_seq OWNER TO postgres;

--
-- TOC entry 12830 (class 0 OID 0)
-- Dependencies: 884
-- Name: sge_ocorrencia_tipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_ocorrencia_tipo_id_seq OWNED BY public.sge_ocorrencia_tipo.id;


--
-- TOC entry 885 (class 1259 OID 14564814)
-- Name: sge_oficina; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_oficina (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(100) NOT NULL
);


ALTER TABLE public.sge_oficina OWNER TO postgres;

--
-- TOC entry 12831 (class 0 OID 0)
-- Dependencies: 885
-- Name: TABLE sge_oficina; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sge_oficina IS 'Guarda informações das oficinas da empresa';


--
-- TOC entry 12832 (class 0 OID 0)
-- Dependencies: 885
-- Name: COLUMN sge_oficina.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_oficina.id IS 'Chave composta da atebela ao lado de id_bas_empresa';


--
-- TOC entry 12833 (class 0 OID 0)
-- Dependencies: 885
-- Name: COLUMN sge_oficina.id_bas_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_oficina.id_bas_empresa IS 'chave primária composta da tabela ao lado de id e chave estrangeira da tabela bas_empresa';


--
-- TOC entry 12834 (class 0 OID 0)
-- Dependencies: 885
-- Name: COLUMN sge_oficina.nome; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_oficina.nome IS 'Nome da oficina';


--
-- TOC entry 886 (class 1259 OID 14564817)
-- Name: sge_oficina_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_oficina_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_oficina_id_seq OWNER TO postgres;

--
-- TOC entry 12835 (class 0 OID 0)
-- Dependencies: 886
-- Name: sge_oficina_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_oficina_id_seq OWNED BY public.sge_oficina.id;


--
-- TOC entry 887 (class 1259 OID 14564819)
-- Name: sge_parecer_eja; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_parecer_eja (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_turma_aluno bigint NOT NULL,
 texto text,
 parecer character(1),
 eixo_atual character varying(50) NOT NULL,
 eixo_posterior character varying(50) NOT NULL,
 data date DEFAULT ('now'::text)::date NOT NULL
);


ALTER TABLE public.sge_parecer_eja OWNER TO postgres;

--
-- TOC entry 12836 (class 0 OID 0)
-- Dependencies: 887
-- Name: COLUMN sge_parecer_eja.parecer; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_parecer_eja.parecer IS '"C" Construido e P em processo';


--
-- TOC entry 888 (class 1259 OID 14564826)
-- Name: sge_parecer_eja_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_parecer_eja_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_parecer_eja_id_seq OWNER TO postgres;

--
-- TOC entry 12837 (class 0 OID 0)
-- Dependencies: 888
-- Name: sge_parecer_eja_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_parecer_eja_id_seq OWNED BY public.sge_parecer_eja.id;


--
-- TOC entry 889 (class 1259 OID 14564828)
-- Name: sge_pasta_aluno; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_pasta_aluno (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_estabelecimento bigint NOT NULL,
 id_sge_aluno bigint NOT NULL,
 id_bas_sala bigint,
 estante character varying(20),
 prateleira character varying(20),
 corredor character varying(20)
);


ALTER TABLE public.sge_pasta_aluno OWNER TO postgres;

--
-- TOC entry 12838 (class 0 OID 0)
-- Dependencies: 889
-- Name: COLUMN sge_pasta_aluno.corredor; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_pasta_aluno.corredor IS 'Rua';


--
-- TOC entry 890 (class 1259 OID 14564831)
-- Name: sge_pasta_aluno_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_pasta_aluno_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_pasta_aluno_id_seq OWNER TO postgres;

--
-- TOC entry 12839 (class 0 OID 0)
-- Dependencies: 890
-- Name: sge_pasta_aluno_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_pasta_aluno_id_seq OWNED BY public.sge_pasta_aluno.id;


--
-- TOC entry 891 (class 1259 OID 14564833)
-- Name: sge_perfil_soe; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_perfil_soe (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(20) NOT NULL
);


ALTER TABLE public.sge_perfil_soe OWNER TO postgres;

--
-- TOC entry 892 (class 1259 OID 14564836)
-- Name: sge_perfil_soe_autorizacao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_perfil_soe_autorizacao (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_perfil_soe bigint NOT NULL,
 id_sge_curso bigint,
 id_sge_serie bigint,
 id_sge_turma bigint,
 id_sge_aluno bigint,
 autorizado character(1) NOT NULL
);


ALTER TABLE public.sge_perfil_soe_autorizacao OWNER TO postgres;

--
-- TOC entry 893 (class 1259 OID 14564839)
-- Name: sge_perfil_soe_autorizacao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_perfil_soe_autorizacao_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_perfil_soe_autorizacao_id_seq OWNER TO postgres;

--
-- TOC entry 12840 (class 0 OID 0)
-- Dependencies: 893
-- Name: sge_perfil_soe_autorizacao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_perfil_soe_autorizacao_id_seq OWNED BY public.sge_perfil_soe_autorizacao.id;


--
-- TOC entry 894 (class 1259 OID 14564841)
-- Name: sge_perfil_soe_colaborador; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_perfil_soe_colaborador (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_perfil_soe bigint NOT NULL,
 id_bas_colaborador bigint NOT NULL
);


ALTER TABLE public.sge_perfil_soe_colaborador OWNER TO postgres;

--
-- TOC entry 895 (class 1259 OID 14564844)
-- Name: sge_perfil_soe_colaborador_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_perfil_soe_colaborador_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_perfil_soe_colaborador_id_seq OWNER TO postgres;

--
-- TOC entry 12841 (class 0 OID 0)
-- Dependencies: 895
-- Name: sge_perfil_soe_colaborador_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_perfil_soe_colaborador_id_seq OWNED BY public.sge_perfil_soe_colaborador.id;


--
-- TOC entry 896 (class 1259 OID 14564846)
-- Name: sge_perfil_soe_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_perfil_soe_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_perfil_soe_id_seq OWNER TO postgres;

--
-- TOC entry 12842 (class 0 OID 0)
-- Dependencies: 896
-- Name: sge_perfil_soe_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_perfil_soe_id_seq OWNED BY public.sge_perfil_soe.id;


--
-- TOC entry 897 (class 1259 OID 14564848)
-- Name: sge_periodo_matricula_segmento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_periodo_matricula_segmento (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome_sge_serie character varying(100) NOT NULL,
 data_inicio_rede date NOT NULL,
 data_inicio_novo date NOT NULL,
 data_fim_rede date NOT NULL,
 data_fim_novo date NOT NULL,
 recuperacao character(1)
);


ALTER TABLE public.sge_periodo_matricula_segmento OWNER TO postgres;

--
-- TOC entry 12843 (class 0 OID 0)
-- Dependencies: 897
-- Name: COLUMN sge_periodo_matricula_segmento.recuperacao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_periodo_matricula_segmento.recuperacao IS '"S" ou "N"';


--
-- TOC entry 898 (class 1259 OID 14564851)
-- Name: sge_periodo_matricula_segmento_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_periodo_matricula_segmento_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_periodo_matricula_segmento_id_seq OWNER TO postgres;

--
-- TOC entry 12844 (class 0 OID 0)
-- Dependencies: 898
-- Name: sge_periodo_matricula_segmento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_periodo_matricula_segmento_id_seq OWNED BY public.sge_periodo_matricula_segmento.id;


--
-- TOC entry 899 (class 1259 OID 14564853)
-- Name: sge_professor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_professor (
 id_bas_colaborador bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 ativo character(1) NOT NULL,
 origem character(1) DEFAULT 'S'::bpchar NOT NULL
);


ALTER TABLE public.sge_professor OWNER TO postgres;

--
-- TOC entry 12845 (class 0 OID 0)
-- Dependencies: 899
-- Name: COLUMN sge_professor.ativo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_professor.ativo IS 'S=sim e N=nao';


--
-- TOC entry 12846 (class 0 OID 0)
-- Dependencies: 899
-- Name: COLUMN sge_professor.origem; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_professor.origem IS '"S" = "SEC", "M" = "MILITAR"';


--
-- TOC entry 900 (class 1259 OID 14564857)
-- Name: sge_professor_disciplina; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_professor_disciplina (
 id_bas_empresa bigint NOT NULL,
 id_sge_professor bigint NOT NULL,
 id_sge_disciplina bigint NOT NULL,
 ativo character(1) DEFAULT 'S'::bpchar
);


ALTER TABLE public.sge_professor_disciplina OWNER TO postgres;

--
-- TOC entry 12847 (class 0 OID 0)
-- Dependencies: 900
-- Name: COLUMN sge_professor_disciplina.ativo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_professor_disciplina.ativo IS 'S=Sim ou N=Nao';


--
-- TOC entry 901 (class 1259 OID 14564861)
-- Name: sge_professor_disciplina_turma; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_professor_disciplina_turma (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_turma_modulo bigint,
 id_sge_professor bigint,
 id_sge_disciplina bigint,
 monitor character(1),
 id_sge_professor_auxiliar_1 bigint,
 id_sge_professor_auxiliar_2 bigint,
 id_sge_professor_auxiliar_3 bigint,
 id_sge_funcao_turma bigint,
 ano_letivo bigint
);


ALTER TABLE public.sge_professor_disciplina_turma OWNER TO postgres;

--
-- TOC entry 12848 (class 0 OID 0)
-- Dependencies: 901
-- Name: COLUMN sge_professor_disciplina_turma.monitor; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_professor_disciplina_turma.monitor IS 'S = Sim, N = Não. Indica se aquele professor é apenas monitor para a turma.';


--
-- TOC entry 12849 (class 0 OID 0)
-- Dependencies: 901
-- Name: COLUMN sge_professor_disciplina_turma.id_sge_funcao_turma; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_professor_disciplina_turma.id_sge_funcao_turma IS 'Identificador da tabela sge_funcao_turma.';


--
-- TOC entry 12850 (class 0 OID 0)
-- Dependencies: 901
-- Name: COLUMN sge_professor_disciplina_turma.ano_letivo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_professor_disciplina_turma.ano_letivo IS 'Ano do professor na disciplina da turma.';


--
-- TOC entry 1303 (class 1259 OID 20275558)
-- Name: sge_professor_disciplina_turma_etapa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_professor_disciplina_turma_etapa (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_professor_disciplina_turma bigint NOT NULL,
 id_sge_etapa bigint NOT NULL,
 texto text NOT NULL
);


ALTER TABLE public.sge_professor_disciplina_turma_etapa OWNER TO postgres;

--
-- TOC entry 1302 (class 1259 OID 20275556)
-- Name: sge_professor_disciplina_turma_etapa_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_professor_disciplina_turma_etapa_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_professor_disciplina_turma_etapa_id_seq OWNER TO postgres;

--
-- TOC entry 12851 (class 0 OID 0)
-- Dependencies: 1302
-- Name: sge_professor_disciplina_turma_etapa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_professor_disciplina_turma_etapa_id_seq OWNED BY public.sge_professor_disciplina_turma_etapa.id;


--
-- TOC entry 902 (class 1259 OID 14564864)
-- Name: sge_professor_disciplina_turma_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_professor_disciplina_turma_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_professor_disciplina_turma_id_seq OWNER TO postgres;

--
-- TOC entry 12852 (class 0 OID 0)
-- Dependencies: 902
-- Name: sge_professor_disciplina_turma_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_professor_disciplina_turma_id_seq OWNED BY public.sge_professor_disciplina_turma.id;


--
-- TOC entry 903 (class 1259 OID 14564866)
-- Name: sge_professor_falta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_professor_falta (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_professor bigint NOT NULL,
 data date NOT NULL,
 justificativa character varying,
 abonada character(1),
 login character varying(32),
 hora_inclusao time(6) without time zone,
 observacao text
);


ALTER TABLE public.sge_professor_falta OWNER TO postgres;

--
-- TOC entry 12853 (class 0 OID 0)
-- Dependencies: 903
-- Name: COLUMN sge_professor_falta.id_sge_professor; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_professor_falta.id_sge_professor IS 'id do colaborador, chave com sge_professor';


--
-- TOC entry 12854 (class 0 OID 0)
-- Dependencies: 903
-- Name: COLUMN sge_professor_falta.abonada; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_professor_falta.abonada IS '"S" = Sim, "N" = Não';


--
-- TOC entry 12855 (class 0 OID 0)
-- Dependencies: 903
-- Name: COLUMN sge_professor_falta.login; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_professor_falta.login IS 'Login da pessoa que gravou o registro';


--
-- TOC entry 12856 (class 0 OID 0)
-- Dependencies: 903
-- Name: COLUMN sge_professor_falta.observacao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_professor_falta.observacao IS 'Observação da falta';


--
-- TOC entry 904 (class 1259 OID 14564872)
-- Name: sge_professor_falta_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_professor_falta_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_professor_falta_id_seq OWNER TO postgres;

--
-- TOC entry 12857 (class 0 OID 0)
-- Dependencies: 904
-- Name: sge_professor_falta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_professor_falta_id_seq OWNED BY public.sge_professor_falta.id;


SET default_with_oids = true;

--
-- TOC entry 905 (class 1259 OID 14564874)
-- Name: sge_profissional_saude; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_profissional_saude (
 id_bas_colaborador bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 ativo character(1)
);


ALTER TABLE public.sge_profissional_saude OWNER TO postgres;

--
-- TOC entry 12858 (class 0 OID 0)
-- Dependencies: 905
-- Name: COLUMN sge_profissional_saude.ativo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_profissional_saude.ativo IS 'S=Sim, N=Não';


SET default_with_oids = false;

--
-- TOC entry 906 (class 1259 OID 14564877)
-- Name: sge_programa_social; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_programa_social (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(50)
);


ALTER TABLE public.sge_programa_social OWNER TO postgres;

--
-- TOC entry 907 (class 1259 OID 14564880)
-- Name: sge_programa_social_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_programa_social_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_programa_social_id_seq OWNER TO postgres;

--
-- TOC entry 12859 (class 0 OID 0)
-- Dependencies: 907
-- Name: sge_programa_social_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_programa_social_id_seq OWNED BY public.sge_programa_social.id;


--
-- TOC entry 908 (class 1259 OID 14564882)
-- Name: sge_reclassificacao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_reclassificacao (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_turma_aluno bigint NOT NULL,
 id_sge_turma_aluno_reclassificado bigint,
 arquivo text,
 resultado character(1),
 data date
);


ALTER TABLE public.sge_reclassificacao OWNER TO postgres;

--
-- TOC entry 12860 (class 0 OID 0)
-- Dependencies: 908
-- Name: TABLE sge_reclassificacao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sge_reclassificacao IS 'Cadastra as reclassifiações dos alunos.';


--
-- TOC entry 12861 (class 0 OID 0)
-- Dependencies: 908
-- Name: COLUMN sge_reclassificacao.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_reclassificacao.id IS 'Identificador sequencial da tabela, chave primaria composta com o campo id_bas_empresa.';


--
-- TOC entry 12862 (class 0 OID 0)
-- Dependencies: 908
-- Name: COLUMN sge_reclassificacao.id_bas_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_reclassificacao.id_bas_empresa IS 'Identificador da tabela bas_empresa, chave primaria composta com o campo id.';


--
-- TOC entry 12863 (class 0 OID 0)
-- Dependencies: 908
-- Name: COLUMN sge_reclassificacao.id_sge_turma_aluno; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_reclassificacao.id_sge_turma_aluno IS 'Turma aluno inicial.';


--
-- TOC entry 12864 (class 0 OID 0)
-- Dependencies: 908
-- Name: COLUMN sge_reclassificacao.id_sge_turma_aluno_reclassificado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_reclassificacao.id_sge_turma_aluno_reclassificado IS 'Turma aluno destino.';


--
-- TOC entry 12865 (class 0 OID 0)
-- Dependencies: 908
-- Name: COLUMN sge_reclassificacao.arquivo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_reclassificacao.arquivo IS 'Caminho no servidor do arquivo digitalizado da prova.';


--
-- TOC entry 12866 (class 0 OID 0)
-- Dependencies: 908
-- Name: COLUMN sge_reclassificacao.resultado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_reclassificacao.resultado IS 'Resultado da avaliação. R = retroceder, P= Permanecer e A=Avançar.';


--
-- TOC entry 12867 (class 0 OID 0)
-- Dependencies: 908
-- Name: COLUMN sge_reclassificacao.data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_reclassificacao.data IS 'Data da reclassificação.';


--
-- TOC entry 909 (class 1259 OID 14564888)
-- Name: sge_reclassificacao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_reclassificacao_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_reclassificacao_id_seq OWNER TO postgres;

--
-- TOC entry 12868 (class 0 OID 0)
-- Dependencies: 909
-- Name: sge_reclassificacao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_reclassificacao_id_seq OWNED BY public.sge_reclassificacao.id;


SET default_with_oids = true;

--
-- TOC entry 910 (class 1259 OID 14564890)
-- Name: sge_requerimento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_requerimento (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_estabelecimento bigint NOT NULL,
 id_bas_responsavel bigint NOT NULL,
 id_sge_aluno bigint,
 id_sge_tipo_requerimento bigint NOT NULL,
 data date NOT NULL,
 observacoes text,
 data_parecer date,
 id_bas_estabelecimento_destino bigint,
 parecer character(1),
 motivo text
);


ALTER TABLE public.sge_requerimento OWNER TO postgres;

--
-- TOC entry 12869 (class 0 OID 0)
-- Dependencies: 910
-- Name: COLUMN sge_requerimento.data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_requerimento.data IS 'Data do requerimento';


--
-- TOC entry 12870 (class 0 OID 0)
-- Dependencies: 910
-- Name: COLUMN sge_requerimento.data_parecer; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_requerimento.data_parecer IS 'Data da Última tramitação';


--
-- TOC entry 12871 (class 0 OID 0)
-- Dependencies: 910
-- Name: COLUMN sge_requerimento.id_bas_estabelecimento_destino; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_requerimento.id_bas_estabelecimento_destino IS 'Estabelecimento para onde o aluno deseja ser transferido.';


--
-- TOC entry 12872 (class 0 OID 0)
-- Dependencies: 910
-- Name: COLUMN sge_requerimento.parecer; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_requerimento.parecer IS 'D="Deferido"
I="Indeferido"
A="Em Análise"';


--
-- TOC entry 12873 (class 0 OID 0)
-- Dependencies: 910
-- Name: COLUMN sge_requerimento.motivo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_requerimento.motivo IS 'Motivo do Parecer';


--
-- TOC entry 911 (class 1259 OID 14564896)
-- Name: sge_requerimento_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_requerimento_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_requerimento_id_seq OWNER TO postgres;

--
-- TOC entry 12874 (class 0 OID 0)
-- Dependencies: 911
-- Name: sge_requerimento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_requerimento_id_seq OWNED BY public.sge_requerimento.id;


--
-- TOC entry 912 (class 1259 OID 14564898)
-- Name: sge_serie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_serie (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_curso bigint NOT NULL,
 id_sge_equivalencia_curricular bigint NOT NULL,
 id_sge_faixa_etaria bigint NOT NULL,
 id_sge_area_conhecimento bigint,
 nome character varying(100) NOT NULL,
 sequencia integer,
 recebe_nota character(1) DEFAULT 'S'::bpchar,
 avaliacao_descritiva character(1) DEFAULT 'N'::bpchar,
 ementa text,
 parecer character varying(100),
 processo character varying(100),
 autorizacao character varying(100),
 autorizacao_data date,
 portaria character varying(100),
 portaria_data date,
 resolucao character varying(100),
 resolucao_data date,
 duracao_serie smallint,
 id_bas_centro_custo bigint,
 data_diario_oficial_res date,
 data_diario_oficial_port date,
 data_inicio_rede date,
 data_inicio_novo date,
 data_fim_rede date,
 data_fim_novo date,
 id_sge_etapa_modalidade bigint,
 multisseriada character(1) DEFAULT 'N'::bpchar NOT NULL,
 ordem integer DEFAULT 0 NOT NULL,
 entidade_mantenedora character varying(30),
 diario_oficial character varying(30),
 ato_de_criacao smallint
);


ALTER TABLE public.sge_serie OWNER TO postgres;

--
-- TOC entry 12875 (class 0 OID 0)
-- Dependencies: 912
-- Name: COLUMN sge_serie.id_sge_area_conhecimento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_serie.id_sge_area_conhecimento IS 'antigo SGE_CURSO_AREA_ID';


--
-- TOC entry 12876 (class 0 OID 0)
-- Dependencies: 912
-- Name: COLUMN sge_serie.recebe_nota; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_serie.recebe_nota IS 'S=sim, N=nao';


--
-- TOC entry 12877 (class 0 OID 0)
-- Dependencies: 912
-- Name: COLUMN sge_serie.avaliacao_descritiva; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_serie.avaliacao_descritiva IS 'S=sim, N=nao';


--
-- TOC entry 12878 (class 0 OID 0)
-- Dependencies: 912
-- Name: COLUMN sge_serie.id_sge_etapa_modalidade; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_serie.id_sge_etapa_modalidade IS 'Identificador da tabela sge_etapa_modalidade.';


--
-- TOC entry 12879 (class 0 OID 0)
-- Dependencies: 912
-- Name: COLUMN sge_serie.multisseriada; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_serie.multisseriada IS 'S sim, N = não';


--
-- TOC entry 913 (class 1259 OID 14564908)
-- Name: sge_turma_aluno_questionario_id_seq; Type: SEQUENCE; Schema: public; Owner: pgadmin
--

CREATE SEQUENCE public.sge_turma_aluno_questionario_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_turma_aluno_questionario_id_seq OWNER TO pgadmin;

SET default_with_oids = false;

--
-- TOC entry 914 (class 1259 OID 14564910)
-- Name: sge_serie_anamnese; Type: TABLE; Schema: public; Owner: pgadmin
--

CREATE TABLE public.sge_serie_anamnese (
 id bigint DEFAULT nextval('public.sge_turma_aluno_questionario_id_seq'::regclass) NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_anamnese bigint NOT NULL,
 data_criacao date DEFAULT now() NOT NULL,
 login character varying(150) NOT NULL,
 ano integer,
 id_sge_serie bigint
);


ALTER TABLE public.sge_serie_anamnese OWNER TO pgadmin;

--
-- TOC entry 915 (class 1259 OID 14564915)
-- Name: sge_serie_desconto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_serie_desconto (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_serie bigint,
 id_sge_turma bigint,
 id_sgf_desconto_tipo bigint NOT NULL,
 forma character(1) NOT NULL,
 valor numeric(9,2) NOT NULL,
 fixo character(1) NOT NULL,
 base character(1),
 parcela_inicial smallint NOT NULL,
 parcela_final smallint NOT NULL,
 referente_matricula character(1),
 mesatual character(1) NOT NULL,
 dia smallint,
 cumulativo character(1) NOT NULL,
 id_sgf_tipo_titulo_receber bigint NOT NULL,
 ano smallint NOT NULL
);


ALTER TABLE public.sge_serie_desconto OWNER TO postgres;

--
-- TOC entry 12880 (class 0 OID 0)
-- Dependencies: 915
-- Name: COLUMN sge_serie_desconto.forma; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_serie_desconto.forma IS 'M=Monetario, P=Percentual';


--
-- TOC entry 12881 (class 0 OID 0)
-- Dependencies: 915
-- Name: COLUMN sge_serie_desconto.fixo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_serie_desconto.fixo IS 'S=sim N=nao';


--
-- TOC entry 12882 (class 0 OID 0)
-- Dependencies: 915
-- Name: COLUMN sge_serie_desconto.base; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_serie_desconto.base IS 'A=antecipacao, D=dia fixo';


--
-- TOC entry 12883 (class 0 OID 0)
-- Dependencies: 915
-- Name: COLUMN sge_serie_desconto.referente_matricula; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_serie_desconto.referente_matricula IS 'S=sim N=nao';


--
-- TOC entry 12884 (class 0 OID 0)
-- Dependencies: 915
-- Name: COLUMN sge_serie_desconto.mesatual; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_serie_desconto.mesatual IS 'S=sim N=nao';


--
-- TOC entry 12885 (class 0 OID 0)
-- Dependencies: 915
-- Name: COLUMN sge_serie_desconto.dia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_serie_desconto.dia IS 'Qtde dias ou dia tal(ex:dia 5)';


--
-- TOC entry 12886 (class 0 OID 0)
-- Dependencies: 915
-- Name: COLUMN sge_serie_desconto.cumulativo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_serie_desconto.cumulativo IS 'S=sim N=nao';


--
-- TOC entry 916 (class 1259 OID 14564918)
-- Name: sge_serie_desconto_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_serie_desconto_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_serie_desconto_id_seq OWNER TO postgres;

--
-- TOC entry 12887 (class 0 OID 0)
-- Dependencies: 916
-- Name: sge_serie_desconto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_serie_desconto_id_seq OWNED BY public.sge_serie_desconto.id;


--
-- TOC entry 917 (class 1259 OID 14564920)
-- Name: sge_serie_documento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_serie_documento (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_serie bigint,
 id_sge_turma bigint,
 id_sge_tipo_documento bigint NOT NULL,
 quantidade integer NOT NULL,
 obrigatorio character(1),
 ano_letivo smallint
);


ALTER TABLE public.sge_serie_documento OWNER TO postgres;

--
-- TOC entry 12888 (class 0 OID 0)
-- Dependencies: 917
-- Name: COLUMN sge_serie_documento.obrigatorio; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_serie_documento.obrigatorio IS 'S=sim , N=nao';


--
-- TOC entry 918 (class 1259 OID 14564923)
-- Name: sge_serie_documento_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_serie_documento_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_serie_documento_id_seq OWNER TO postgres;

--
-- TOC entry 12889 (class 0 OID 0)
-- Dependencies: 918
-- Name: sge_serie_documento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_serie_documento_id_seq OWNED BY public.sge_serie_documento.id;


--
-- TOC entry 919 (class 1259 OID 14564925)
-- Name: sge_serie_fardamento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_serie_fardamento (
 id_bas_empresa bigint NOT NULL,
 id_sge_serie bigint NOT NULL,
 id_sga_material bigint NOT NULL
);


ALTER TABLE public.sge_serie_fardamento OWNER TO postgres;

--
-- TOC entry 12890 (class 0 OID 0)
-- Dependencies: 919
-- Name: TABLE sge_serie_fardamento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sge_serie_fardamento IS 'Registra a relação nxn entre sge_serie e sge_fardamento';


--
-- TOC entry 12891 (class 0 OID 0)
-- Dependencies: 919
-- Name: COLUMN sge_serie_fardamento.id_bas_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_serie_fardamento.id_bas_empresa IS 'Chave estrangeira da tabela bas_empresa e chave primária ao lado dos campos id_sge_serie e id_sge_fardamento';


--
-- TOC entry 12892 (class 0 OID 0)
-- Dependencies: 919
-- Name: COLUMN sge_serie_fardamento.id_sge_serie; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_serie_fardamento.id_sge_serie IS 'Chave estrangeira da tabela sge_serie ao lado do campo id_bas_empresa e chave primária ao lado dos campos id_bas_empresa e id_sge_fardamento';


--
-- TOC entry 12893 (class 0 OID 0)
-- Dependencies: 919
-- Name: COLUMN sge_serie_fardamento.id_sga_material; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_serie_fardamento.id_sga_material IS 'Chave estrangeira da tabela sga_material (fardamento) ao lado do campo id_bas_empresa e chave primária ao lado dos campos id_bas_empresa e id_sge_serie';


--
-- TOC entry 920 (class 1259 OID 14564928)
-- Name: sge_serie_graduacao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_serie_graduacao (
 id_bas_empresa bigint NOT NULL,
 id_sge_serie bigint NOT NULL,
 id_sge_graduacao bigint NOT NULL
);


ALTER TABLE public.sge_serie_graduacao OWNER TO postgres;

--
-- TOC entry 921 (class 1259 OID 14564931)
-- Name: sge_serie_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_serie_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_serie_id_seq OWNER TO postgres;

--
-- TOC entry 12894 (class 0 OID 0)
-- Dependencies: 921
-- Name: sge_serie_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_serie_id_seq OWNED BY public.sge_serie.id;


SET default_with_oids = true;

--
-- TOC entry 922 (class 1259 OID 14564933)
-- Name: sge_serie_livro; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_serie_livro (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_serie bigint NOT NULL,
 id_sgb_livro bigint NOT NULL,
 doacao character(1)
);


ALTER TABLE public.sge_serie_livro OWNER TO postgres;

--
-- TOC entry 12895 (class 0 OID 0)
-- Dependencies: 922
-- Name: COLUMN sge_serie_livro.doacao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_serie_livro.doacao IS 'S=''Sim'', N=''Não''. Configuração de livro para doação.';


--
-- TOC entry 923 (class 1259 OID 14564936)
-- Name: sge_serie_livro_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_serie_livro_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_serie_livro_id_seq OWNER TO postgres;

--
-- TOC entry 12896 (class 0 OID 0)
-- Dependencies: 923
-- Name: sge_serie_livro_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_serie_livro_id_seq OWNED BY public.sge_serie_livro.id;


SET default_with_oids = false;

--
-- TOC entry 924 (class 1259 OID 14564938)
-- Name: sge_serie_multisseriada_serie_real; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_serie_multisseriada_serie_real (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_serie_real bigint NOT NULL,
 id_cfg_serie bigint
);


ALTER TABLE public.sge_serie_multisseriada_serie_real OWNER TO postgres;

--
-- TOC entry 925 (class 1259 OID 14564941)
-- Name: sge_serie_multisseriada_serie_real_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_serie_multisseriada_serie_real_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_serie_multisseriada_serie_real_id_seq OWNER TO postgres;

--
-- TOC entry 12897 (class 0 OID 0)
-- Dependencies: 925
-- Name: sge_serie_multisseriada_serie_real_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_serie_multisseriada_serie_real_id_seq OWNED BY public.sge_serie_multisseriada_serie_real.id;


--
-- TOC entry 926 (class 1259 OID 14564943)
-- Name: sge_serie_plano_pagamento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_serie_plano_pagamento (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_serie bigint,
 id_sge_turma bigint,
 id_sgf_plano_pagamento bigint NOT NULL
);


ALTER TABLE public.sge_serie_plano_pagamento OWNER TO postgres;

--
-- TOC entry 927 (class 1259 OID 14564946)
-- Name: sge_serie_plano_pagamento_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_serie_plano_pagamento_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_serie_plano_pagamento_id_seq OWNER TO postgres;

--
-- TOC entry 12898 (class 0 OID 0)
-- Dependencies: 927
-- Name: sge_serie_plano_pagamento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_serie_plano_pagamento_id_seq OWNED BY public.sge_serie_plano_pagamento.id;


--
-- TOC entry 928 (class 1259 OID 14564948)
-- Name: sge_serie_real; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_serie_real (
 id bigint NOT NULL,
 nome character varying(100) NOT NULL
);


ALTER TABLE public.sge_serie_real OWNER TO postgres;

--
-- TOC entry 929 (class 1259 OID 14564951)
-- Name: sge_serie_real_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_serie_real_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_serie_real_id_seq OWNER TO postgres;

--
-- TOC entry 12899 (class 0 OID 0)
-- Dependencies: 929
-- Name: sge_serie_real_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_serie_real_id_seq OWNED BY public.sge_serie_real.id;


--
-- TOC entry 930 (class 1259 OID 14564953)
-- Name: sge_sintese_desempenho; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_sintese_desempenho (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_etapa bigint NOT NULL,
 data_inicial date NOT NULL,
 data_final date NOT NULL,
 ano_letivo smallint NOT NULL
);


ALTER TABLE public.sge_sintese_desempenho OWNER TO postgres;

--
-- TOC entry 12900 (class 0 OID 0)
-- Dependencies: 930
-- Name: TABLE sge_sintese_desempenho; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sge_sintese_desempenho IS 'Tabela para guardar as informações de definição da avaliação descritiva (Síntese de desempenho)';


--
-- TOC entry 931 (class 1259 OID 14564956)
-- Name: sge_sintese_desempenho_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_sintese_desempenho_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_sintese_desempenho_id_seq OWNER TO postgres;

--
-- TOC entry 12901 (class 0 OID 0)
-- Dependencies: 931
-- Name: sge_sintese_desempenho_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_sintese_desempenho_id_seq OWNED BY public.sge_sintese_desempenho.id;


--
-- TOC entry 932 (class 1259 OID 14564958)
-- Name: sge_situacao_academica; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_situacao_academica (
 id bigint NOT NULL,
 nome character varying(100) NOT NULL,
 sigla character varying(8) NOT NULL,
 status character(1)
);


ALTER TABLE public.sge_situacao_academica OWNER TO postgres;

--
-- TOC entry 12902 (class 0 OID 0)
-- Dependencies: 932
-- Name: COLUMN sge_situacao_academica.status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_situacao_academica.status IS 'A = Ativo, I = Inativo';


--
-- TOC entry 933 (class 1259 OID 14564961)
-- Name: sge_situacao_academica_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_situacao_academica_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_situacao_academica_id_seq OWNER TO postgres;

--
-- TOC entry 12903 (class 0 OID 0)
-- Dependencies: 933
-- Name: sge_situacao_academica_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_situacao_academica_id_seq OWNED BY public.sge_situacao_academica.id;


--
-- TOC entry 934 (class 1259 OID 14564963)
-- Name: sge_situacao_disciplina; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_situacao_disciplina (
 id bigint NOT NULL,
 nome character varying(100) NOT NULL,
 sigla character varying(8) NOT NULL
);


ALTER TABLE public.sge_situacao_disciplina OWNER TO postgres;

--
-- TOC entry 935 (class 1259 OID 14564966)
-- Name: sge_situacao_disciplina_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_situacao_disciplina_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_situacao_disciplina_id_seq OWNER TO postgres;

--
-- TOC entry 12904 (class 0 OID 0)
-- Dependencies: 935
-- Name: sge_situacao_disciplina_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_situacao_disciplina_id_seq OWNED BY public.sge_situacao_disciplina.id;


--
-- TOC entry 936 (class 1259 OID 14564968)
-- Name: sge_situacao_pedagogica; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_situacao_pedagogica (
 id bigint NOT NULL,
 nome character varying(100) NOT NULL,
 sigla character varying(8) NOT NULL
);


ALTER TABLE public.sge_situacao_pedagogica OWNER TO postgres;

--
-- TOC entry 937 (class 1259 OID 14564971)
-- Name: sge_situacao_pedagogica_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_situacao_pedagogica_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_situacao_pedagogica_id_seq OWNER TO postgres;

--
-- TOC entry 12905 (class 0 OID 0)
-- Dependencies: 937
-- Name: sge_situacao_pedagogica_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_situacao_pedagogica_id_seq OWNED BY public.sge_situacao_pedagogica.id;


SET default_with_oids = true;

--
-- TOC entry 938 (class 1259 OID 14564973)
-- Name: sge_sms_enviado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_sms_enviado (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_estabelecimento bigint NOT NULL,
 login character varying(20) NOT NULL,
 id_bas_pessoa bigint NOT NULL,
 conteudo character varying(160) NOT NULL,
 data_hora timestamp(6) without time zone NOT NULL,
 erro character(1) NOT NULL,
 celular character varying(20) NOT NULL
);
ALTER TABLE ONLY public.sge_sms_enviado ALTER COLUMN id SET STATISTICS 0;
ALTER TABLE ONLY public.sge_sms_enviado ALTER COLUMN id_bas_empresa SET STATISTICS 0;
ALTER TABLE ONLY public.sge_sms_enviado ALTER COLUMN id_bas_estabelecimento SET STATISTICS 0;
ALTER TABLE ONLY public.sge_sms_enviado ALTER COLUMN login SET STATISTICS 0;
ALTER TABLE ONLY public.sge_sms_enviado ALTER COLUMN id_bas_pessoa SET STATISTICS 0;
ALTER TABLE ONLY public.sge_sms_enviado ALTER COLUMN conteudo SET STATISTICS 0;
ALTER TABLE ONLY public.sge_sms_enviado ALTER COLUMN data_hora SET STATISTICS 0;
ALTER TABLE ONLY public.sge_sms_enviado ALTER COLUMN erro SET STATISTICS 0;
ALTER TABLE ONLY public.sge_sms_enviado ALTER COLUMN celular SET STATISTICS 0;


ALTER TABLE public.sge_sms_enviado OWNER TO postgres;

--
-- TOC entry 12906 (class 0 OID 0)
-- Dependencies: 938
-- Name: COLUMN sge_sms_enviado.erro; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_sms_enviado.erro IS 'S = "Sim", N = "Não"';


--
-- TOC entry 939 (class 1259 OID 14564976)
-- Name: sge_sms_enviado_id_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_sms_enviado_id_seq1
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_sms_enviado_id_seq1 OWNER TO postgres;

--
-- TOC entry 12907 (class 0 OID 0)
-- Dependencies: 939
-- Name: sge_sms_enviado_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_sms_enviado_id_seq1 OWNED BY public.sge_sms_enviado.id;


SET default_with_oids = false;

--
-- TOC entry 940 (class 1259 OID 14564978)
-- Name: sge_substituicao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_substituicao (
 id_bas_empresa bigint NOT NULL,
 id bigint NOT NULL,
 nome character varying(50),
 valor bigint,
 n_substituicoes smallint NOT NULL,
 max smallint,
 ordem smallint,
 sigla character varying(6)
);


ALTER TABLE public.sge_substituicao OWNER TO postgres;

--
-- TOC entry 941 (class 1259 OID 14564981)
-- Name: sge_substituicao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_substituicao_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_substituicao_id_seq OWNER TO postgres;

--
-- TOC entry 12908 (class 0 OID 0)
-- Dependencies: 941
-- Name: sge_substituicao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_substituicao_id_seq OWNED BY public.sge_substituicao.id;


--
-- TOC entry 942 (class 1259 OID 14564983)
-- Name: sge_substituicao_nota; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_substituicao_nota (
 id_bas_empresa bigint NOT NULL,
 id bigint NOT NULL,
 id_nota bigint NOT NULL,
 id_substituicao bigint NOT NULL,
 valor smallint
);


ALTER TABLE public.sge_substituicao_nota OWNER TO postgres;

--
-- TOC entry 943 (class 1259 OID 14564986)
-- Name: sge_substituicao_nota_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_substituicao_nota_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_substituicao_nota_id_seq OWNER TO postgres;

--
-- TOC entry 12909 (class 0 OID 0)
-- Dependencies: 943
-- Name: sge_substituicao_nota_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_substituicao_nota_id_seq OWNED BY public.sge_substituicao_nota.id;


--
-- TOC entry 944 (class 1259 OID 14564988)
-- Name: sge_suspensao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_suspensao (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 data_registro date NOT NULL,
 data_inicial date NOT NULL,
 data_final date NOT NULL,
 motivo character varying(300) NOT NULL,
 observacao character varying(300),
 login character varying(32) NOT NULL,
 id_sge_turma_aluno bigint NOT NULL,
 atividade_extra_classe character varying(200)
);


ALTER TABLE public.sge_suspensao OWNER TO postgres;

--
-- TOC entry 945 (class 1259 OID 14564994)
-- Name: sge_suspensao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_suspensao_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_suspensao_id_seq OWNER TO postgres;

--
-- TOC entry 12910 (class 0 OID 0)
-- Dependencies: 945
-- Name: sge_suspensao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_suspensao_id_seq OWNED BY public.sge_suspensao.id;


--
-- TOC entry 946 (class 1259 OID 14564996)
-- Name: sge_suspensao_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_suspensao_log (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 data_registro_original date NOT NULL,
 data_inicial_original date NOT NULL,
 data_final_original date NOT NULL,
 login_original character varying(32) NOT NULL,
 motivo_original character varying(300) NOT NULL,
 observacao_original character varying(300),
 data_exclusao date NOT NULL,
 login_exclusao character varying(32) NOT NULL,
 motivo_exclusao character varying(300) NOT NULL,
 id_sge_turma_aluno_original bigint NOT NULL
);


ALTER TABLE public.sge_suspensao_log OWNER TO postgres;

--
-- TOC entry 947 (class 1259 OID 14565002)
-- Name: sge_suspensao_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_suspensao_log_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_suspensao_log_id_seq OWNER TO postgres;

--
-- TOC entry 12911 (class 0 OID 0)
-- Dependencies: 947
-- Name: sge_suspensao_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_suspensao_log_id_seq OWNED BY public.sge_suspensao_log.id;


--
-- TOC entry 948 (class 1259 OID 14565004)
-- Name: sge_tipo_documento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_tipo_documento (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(100) NOT NULL,
 reaproveitavel character(1) DEFAULT 'N'::bpchar,
 emissao character(1) DEFAULT 'N'::bpchar,
 recepcao character(1) DEFAULT 'N'::bpchar,
 campo_matricula integer
);


ALTER TABLE public.sge_tipo_documento OWNER TO postgres;

--
-- TOC entry 12912 (class 0 OID 0)
-- Dependencies: 948
-- Name: COLUMN sge_tipo_documento.reaproveitavel; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_tipo_documento.reaproveitavel IS 'S/N';


--
-- TOC entry 12913 (class 0 OID 0)
-- Dependencies: 948
-- Name: COLUMN sge_tipo_documento.emissao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_tipo_documento.emissao IS 'S/N';


--
-- TOC entry 12914 (class 0 OID 0)
-- Dependencies: 948
-- Name: COLUMN sge_tipo_documento.recepcao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_tipo_documento.recepcao IS 'S/N';


--
-- TOC entry 12915 (class 0 OID 0)
-- Dependencies: 948
-- Name: COLUMN sge_tipo_documento.campo_matricula; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_tipo_documento.campo_matricula IS '1 - CERTIDÃO DE NASCIMENTO DO ALUNO
2 - RG DO ALUNO
3 - CPF DO ALUNO
4 - NÚMERO DO NIS DO ALUNO
5 - NÚMERO DO CARTÃO DO SUS
6 - NENHUM';


--
-- TOC entry 949 (class 1259 OID 14565010)
-- Name: sge_tipo_documento_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_tipo_documento_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_tipo_documento_id_seq OWNER TO postgres;

--
-- TOC entry 12916 (class 0 OID 0)
-- Dependencies: 949
-- Name: sge_tipo_documento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_tipo_documento_id_seq OWNED BY public.sge_tipo_documento.id;


SET default_with_oids = true;

--
-- TOC entry 950 (class 1259 OID 14565012)
-- Name: sge_tipo_ensino; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_tipo_ensino (
 id bigint NOT NULL,
 nome character varying(50) NOT NULL
);


ALTER TABLE public.sge_tipo_ensino OWNER TO postgres;

--
-- TOC entry 951 (class 1259 OID 14565015)
-- Name: sge_tipo_ensino_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_tipo_ensino_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_tipo_ensino_id_seq OWNER TO postgres;

--
-- TOC entry 12917 (class 0 OID 0)
-- Dependencies: 951
-- Name: sge_tipo_ensino_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_tipo_ensino_id_seq OWNED BY public.sge_tipo_ensino.id;


--
-- TOC entry 952 (class 1259 OID 14565017)
-- Name: sge_tipo_requerimento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_tipo_requerimento (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(100),
 prazo integer,
 identificador_tipo character(1)
);


ALTER TABLE public.sge_tipo_requerimento OWNER TO postgres;

--
-- TOC entry 12918 (class 0 OID 0)
-- Dependencies: 952
-- Name: COLUMN sge_tipo_requerimento.identificador_tipo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_tipo_requerimento.identificador_tipo IS '"T" = Transferência
"R" = Emissão de documento para o responsável.
"A" = Emissão de documento para o aluno.
"O" = Outros';


--
-- TOC entry 953 (class 1259 OID 14565020)
-- Name: sge_tipo_requerimento_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_tipo_requerimento_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_tipo_requerimento_id_seq OWNER TO postgres;

--
-- TOC entry 12919 (class 0 OID 0)
-- Dependencies: 953
-- Name: sge_tipo_requerimento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_tipo_requerimento_id_seq OWNED BY public.sge_tipo_requerimento.id;


--
-- TOC entry 954 (class 1259 OID 14565022)
-- Name: sge_transferencia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_transferencia (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_estabelecimento_origem bigint,
 id_bas_estabelecimento_destino bigint,
 data_solicitacao_origem date NOT NULL,
 deferido character(1),
 data_resposta date,
 id_sge_requerimento bigint,
 motivo text,
 id_sge_turma_aluno bigint NOT NULL,
 login_origem character varying(32),
 login_destino character varying(32),
 id_sge_serie_destino bigint,
 tipo character(1) NOT NULL,
 id_sge_instituicao_ensino bigint,
 id_sge_turma_destino bigint
);


ALTER TABLE public.sge_transferencia OWNER TO postgres;

--
-- TOC entry 12920 (class 0 OID 0)
-- Dependencies: 954
-- Name: COLUMN sge_transferencia.deferido; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_transferencia.deferido IS 'S="Sim", N="Não"';


--
-- TOC entry 12921 (class 0 OID 0)
-- Dependencies: 954
-- Name: COLUMN sge_transferencia.login_origem; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_transferencia.login_origem IS 'Login do usuário que originou a transferência';


--
-- TOC entry 12922 (class 0 OID 0)
-- Dependencies: 954
-- Name: COLUMN sge_transferencia.login_destino; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_transferencia.login_destino IS 'Login do usuário que finalizou a transferência';


--
-- TOC entry 12923 (class 0 OID 0)
-- Dependencies: 954
-- Name: COLUMN sge_transferencia.tipo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_transferencia.tipo IS 'I=Interna, E=Externa';


--
-- TOC entry 12924 (class 0 OID 0)
-- Dependencies: 954
-- Name: COLUMN sge_transferencia.id_sge_instituicao_ensino; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_transferencia.id_sge_instituicao_ensino IS 'Escola que o aluno vai estudar. Campo somente aplicável à transferência externa.';


--
-- TOC entry 955 (class 1259 OID 14565028)
-- Name: sge_transferencia_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_transferencia_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_transferencia_id_seq OWNER TO postgres;

--
-- TOC entry 12925 (class 0 OID 0)
-- Dependencies: 955
-- Name: sge_transferencia_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_transferencia_id_seq OWNED BY public.sge_transferencia.id;


SET default_with_oids = false;

--
-- TOC entry 956 (class 1259 OID 14565030)
-- Name: sge_transporte; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_transporte (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_turma_aluno bigint,
 id_sge_transporte_ponto_partida bigint,
 id_sge_transporte_ponto_retorno bigint,
 id_sge_transporte_roteiro_partida bigint,
 id_sge_transporte_roteiro_retorno bigint,
 login character varying(32) NOT NULL,
 login_cancelamento character varying(32),
 data date NOT NULL,
 data_inicio date,
 data_fim date,
 data_cancelamento date,
 data_vencimento date,
 valor numeric(9,2),
 observacao_partida text,
 observacao_retorno text,
 parcelas smallint,
 ida character(1) DEFAULT 'N'::bpchar NOT NULL,
 volta character(1) DEFAULT 'N'::bpchar NOT NULL,
 status character(1),
 id_bas_pessoa_responsavel bigint,
 id_bas_grau_parentesco bigint,
 id_sge_detalhe_deficiencia bigint,
 rede character(1),
 id_bas_pessoa bigint,
 ano_letivo integer
);


ALTER TABLE public.sge_transporte OWNER TO postgres;

--
-- TOC entry 12926 (class 0 OID 0)
-- Dependencies: 956
-- Name: TABLE sge_transporte; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sge_transporte IS 'Cadastra os transportes de cada aluno';


--
-- TOC entry 12927 (class 0 OID 0)
-- Dependencies: 956
-- Name: COLUMN sge_transporte.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_transporte.id IS 'Identificador sequencial da tabela, chave primaria composta com o campo id_bas_empresa';


--
-- TOC entry 12928 (class 0 OID 0)
-- Dependencies: 956
-- Name: COLUMN sge_transporte.id_bas_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_transporte.id_bas_empresa IS 'Identificador da tabela bas_empresa, chave primaria composta com o campo id';


--
-- TOC entry 12929 (class 0 OID 0)
-- Dependencies: 956
-- Name: COLUMN sge_transporte.id_sge_turma_aluno; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_transporte.id_sge_turma_aluno IS 'Identificador da tabela sge_turma_aluno junto com o campo id_bas_empresa';


--
-- TOC entry 12930 (class 0 OID 0)
-- Dependencies: 956
-- Name: COLUMN sge_transporte.id_sge_transporte_ponto_partida; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_transporte.id_sge_transporte_ponto_partida IS 'Identificador da tabela sgf_transporte_ponto junto com o campo id_bas_empresa';


--
-- TOC entry 12931 (class 0 OID 0)
-- Dependencies: 956
-- Name: COLUMN sge_transporte.id_sge_transporte_ponto_retorno; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_transporte.id_sge_transporte_ponto_retorno IS 'Identificador da tabela sgf_transporte junto com o campo id_bas_empresa';


--
-- TOC entry 12932 (class 0 OID 0)
-- Dependencies: 956
-- Name: COLUMN sge_transporte.id_sge_transporte_roteiro_partida; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_transporte.id_sge_transporte_roteiro_partida IS 'Identificador da tabela sge_transporte_roteiro junto com o campo id_bas_empresa';


--
-- TOC entry 12933 (class 0 OID 0)
-- Dependencies: 956
-- Name: COLUMN sge_transporte.id_sge_transporte_roteiro_retorno; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_transporte.id_sge_transporte_roteiro_retorno IS 'Identificador da tabela sge_transporte_roteiro junto com o campo id_bas_empresa';


--
-- TOC entry 12934 (class 0 OID 0)
-- Dependencies: 956
-- Name: COLUMN sge_transporte.login; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_transporte.login IS 'Identificador da tabela seg_users';


--
-- TOC entry 12935 (class 0 OID 0)
-- Dependencies: 956
-- Name: COLUMN sge_transporte.login_cancelamento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_transporte.login_cancelamento IS 'identificador da tabela seg_users';


--
-- TOC entry 12936 (class 0 OID 0)
-- Dependencies: 956
-- Name: COLUMN sge_transporte.data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_transporte.data IS 'Data de gravação do registro';


--
-- TOC entry 12937 (class 0 OID 0)
-- Dependencies: 956
-- Name: COLUMN sge_transporte.data_inicio; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_transporte.data_inicio IS 'Data de inicio do transporte';


--
-- TOC entry 12938 (class 0 OID 0)
-- Dependencies: 956
-- Name: COLUMN sge_transporte.data_fim; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_transporte.data_fim IS 'Data do fim do transporte';


--
-- TOC entry 12939 (class 0 OID 0)
-- Dependencies: 956
-- Name: COLUMN sge_transporte.data_cancelamento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_transporte.data_cancelamento IS 'Data do cancelamento do transporte';


--
-- TOC entry 12940 (class 0 OID 0)
-- Dependencies: 956
-- Name: COLUMN sge_transporte.data_vencimento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_transporte.data_vencimento IS 'Data do vencimento do transporte';


--
-- TOC entry 12941 (class 0 OID 0)
-- Dependencies: 956
-- Name: COLUMN sge_transporte.valor; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_transporte.valor IS 'Valor do transporte';


--
-- TOC entry 12942 (class 0 OID 0)
-- Dependencies: 956
-- Name: COLUMN sge_transporte.observacao_partida; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_transporte.observacao_partida IS 'Observações relacionadas a partida';


--
-- TOC entry 12943 (class 0 OID 0)
-- Dependencies: 956
-- Name: COLUMN sge_transporte.observacao_retorno; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_transporte.observacao_retorno IS 'Observação relacionada ao retorno';


--
-- TOC entry 12944 (class 0 OID 0)
-- Dependencies: 956
-- Name: COLUMN sge_transporte.parcelas; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_transporte.parcelas IS 'Quantidade de parcelas';


--
-- TOC entry 12945 (class 0 OID 0)
-- Dependencies: 956
-- Name: COLUMN sge_transporte.ida; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_transporte.ida IS 'Se o aluno participa da ida (''S'' = sim, ''N'' = Não)';


--
-- TOC entry 12946 (class 0 OID 0)
-- Dependencies: 956
-- Name: COLUMN sge_transporte.volta; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_transporte.volta IS 'Se o aluno participa da volta (''S'' = sim, ''N'' = Não)';


--
-- TOC entry 1295 (class 1259 OID 17129615)
-- Name: sge_transporte_documento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_transporte_documento (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_tipo_documento bigint NOT NULL,
 obrigatorio character(1) NOT NULL
);


ALTER TABLE public.sge_transporte_documento OWNER TO postgres;

--
-- TOC entry 1294 (class 1259 OID 17129613)
-- Name: sge_transporte_documento_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_transporte_documento_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_transporte_documento_id_seq OWNER TO postgres;

--
-- TOC entry 12947 (class 0 OID 0)
-- Dependencies: 1294
-- Name: sge_transporte_documento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_transporte_documento_id_seq OWNED BY public.sge_transporte_documento.id;


--
-- TOC entry 957 (class 1259 OID 14565038)
-- Name: sge_transporte_ponto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_transporte_ponto (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 descricao character varying(100) NOT NULL,
 bairro character varying(50) NOT NULL,
 id_bas_bairro bigint
);


ALTER TABLE public.sge_transporte_ponto OWNER TO postgres;

--
-- TOC entry 12948 (class 0 OID 0)
-- Dependencies: 957
-- Name: TABLE sge_transporte_ponto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sge_transporte_ponto IS 'Cadastra os pontos para o transporte';


--
-- TOC entry 12949 (class 0 OID 0)
-- Dependencies: 957
-- Name: COLUMN sge_transporte_ponto.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_transporte_ponto.id IS 'Identificador sequencial da tabela, chave primaria composta com o campo id_bas_empresa';


--
-- TOC entry 12950 (class 0 OID 0)
-- Dependencies: 957
-- Name: COLUMN sge_transporte_ponto.id_bas_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_transporte_ponto.id_bas_empresa IS 'Identificador da tabela bas_empresa, chave primaria composta com o campo id';


--
-- TOC entry 12951 (class 0 OID 0)
-- Dependencies: 957
-- Name: COLUMN sge_transporte_ponto.descricao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_transporte_ponto.descricao IS 'Descrição do ponto';


--
-- TOC entry 12952 (class 0 OID 0)
-- Dependencies: 957
-- Name: COLUMN sge_transporte_ponto.bairro; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_transporte_ponto.bairro IS 'bairro onde o ponto está localizado';


--
-- TOC entry 958 (class 1259 OID 14565041)
-- Name: sge_transporte_roteiro; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_transporte_roteiro (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_veiculo bigint,
 descricao character varying(100),
 data date,
 horario_partida time(0) without time zone,
 horario_chegada time(0) without time zone,
 terceirizado character(1)
);


ALTER TABLE public.sge_transporte_roteiro OWNER TO postgres;

--
-- TOC entry 12953 (class 0 OID 0)
-- Dependencies: 958
-- Name: TABLE sge_transporte_roteiro; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sge_transporte_roteiro IS 'Cadastra os roteiros possíveis da escola';


--
-- TOC entry 12954 (class 0 OID 0)
-- Dependencies: 958
-- Name: COLUMN sge_transporte_roteiro.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_transporte_roteiro.id IS 'Identificador sequencial da tabela, chave primaria composta com o campo id_bas_empresa';


--
-- TOC entry 12955 (class 0 OID 0)
-- Dependencies: 958
-- Name: COLUMN sge_transporte_roteiro.id_bas_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_transporte_roteiro.id_bas_empresa IS 'Identificador da tabela bas_empresa, chave primaria composta com o campo id';


--
-- TOC entry 12956 (class 0 OID 0)
-- Dependencies: 958
-- Name: COLUMN sge_transporte_roteiro.id_bas_veiculo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_transporte_roteiro.id_bas_veiculo IS 'Identificador da tabela bas_veiculo junto com o campo id_bas_empresa';


--
-- TOC entry 12957 (class 0 OID 0)
-- Dependencies: 958
-- Name: COLUMN sge_transporte_roteiro.descricao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_transporte_roteiro.descricao IS 'Descrição do roteiro';


--
-- TOC entry 12958 (class 0 OID 0)
-- Dependencies: 958
-- Name: COLUMN sge_transporte_roteiro.data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_transporte_roteiro.data IS 'Data de cadastro do roteiro';


--
-- TOC entry 12959 (class 0 OID 0)
-- Dependencies: 958
-- Name: COLUMN sge_transporte_roteiro.horario_partida; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_transporte_roteiro.horario_partida IS 'Horário de partida do roteiro';


--
-- TOC entry 959 (class 1259 OID 14565044)
-- Name: sge_transporte_roteiro_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_transporte_roteiro_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_transporte_roteiro_id_seq OWNER TO postgres;

--
-- TOC entry 12960 (class 0 OID 0)
-- Dependencies: 959
-- Name: sge_transporte_roteiro_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_transporte_roteiro_id_seq OWNED BY public.sge_transporte_roteiro.id;


--
-- TOC entry 960 (class 1259 OID 14565046)
-- Name: sge_transporte_roteiro_ponto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_transporte_roteiro_ponto (
 id_bas_empresa bigint NOT NULL,
 id_sge_transporte_roteiro bigint NOT NULL,
 id_sge_transporte_ponto bigint NOT NULL,
 ordem smallint
);


ALTER TABLE public.sge_transporte_roteiro_ponto OWNER TO postgres;

--
-- TOC entry 12961 (class 0 OID 0)
-- Dependencies: 960
-- Name: TABLE sge_transporte_roteiro_ponto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sge_transporte_roteiro_ponto IS 'Cadastra os pontos dos roteiros';


--
-- TOC entry 12962 (class 0 OID 0)
-- Dependencies: 960
-- Name: COLUMN sge_transporte_roteiro_ponto.id_bas_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_transporte_roteiro_ponto.id_bas_empresa IS 'Identificador da tabela bas_empresa, chave primaria';


--
-- TOC entry 12963 (class 0 OID 0)
-- Dependencies: 960
-- Name: COLUMN sge_transporte_roteiro_ponto.id_sge_transporte_roteiro; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_transporte_roteiro_ponto.id_sge_transporte_roteiro IS 'Identificador da tabela sge_transporte_roteiro junto com o campo id_bas_empresa';


--
-- TOC entry 12964 (class 0 OID 0)
-- Dependencies: 960
-- Name: COLUMN sge_transporte_roteiro_ponto.id_sge_transporte_ponto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_transporte_roteiro_ponto.id_sge_transporte_ponto IS 'Identificador da tabela sge_transporte_ponto junto com o campo id_bas_empresa';


--
-- TOC entry 12965 (class 0 OID 0)
-- Dependencies: 960
-- Name: COLUMN sge_transporte_roteiro_ponto.ordem; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_transporte_roteiro_ponto.ordem IS 'Ordem do ponto';


--
-- TOC entry 961 (class 1259 OID 14565049)
-- Name: sge_transporte_roteiro_viagem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_transporte_roteiro_viagem (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 data date NOT NULL,
 tipo_viagem character(1) NOT NULL,
 id_sge_transporte_roteiro bigint NOT NULL,
 id_bas_colaborador bigint NOT NULL
);


ALTER TABLE public.sge_transporte_roteiro_viagem OWNER TO postgres;

--
-- TOC entry 12966 (class 0 OID 0)
-- Dependencies: 961
-- Name: COLUMN sge_transporte_roteiro_viagem.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_transporte_roteiro_viagem.id IS 'Identificador sequencial da tabela, chave primaria composta com o campo id_bas_empresa';


--
-- TOC entry 12967 (class 0 OID 0)
-- Dependencies: 961
-- Name: COLUMN sge_transporte_roteiro_viagem.id_bas_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_transporte_roteiro_viagem.id_bas_empresa IS 'Identificador da tabela bas_empresa, chave primaria composta com o campo id';


--
-- TOC entry 12968 (class 0 OID 0)
-- Dependencies: 961
-- Name: COLUMN sge_transporte_roteiro_viagem.data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_transporte_roteiro_viagem.data IS 'Data da viagem';


--
-- TOC entry 12969 (class 0 OID 0)
-- Dependencies: 961
-- Name: COLUMN sge_transporte_roteiro_viagem.tipo_viagem; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_transporte_roteiro_viagem.tipo_viagem IS 'I = Ida, V = Volta';


--
-- TOC entry 12970 (class 0 OID 0)
-- Dependencies: 961
-- Name: COLUMN sge_transporte_roteiro_viagem.id_sge_transporte_roteiro; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_transporte_roteiro_viagem.id_sge_transporte_roteiro IS 'Identificador da tabela sge_transporte_roteiro junto com o campo id_bas_empresa';


--
-- TOC entry 12971 (class 0 OID 0)
-- Dependencies: 961
-- Name: COLUMN sge_transporte_roteiro_viagem.id_bas_colaborador; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_transporte_roteiro_viagem.id_bas_colaborador IS 'Motorista da viagem, Identificador da tabela bas_colaborador junto com o campo id_bas_empresa';


--
-- TOC entry 962 (class 1259 OID 14565052)
-- Name: sge_transporte_roteiro_viagem_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_transporte_roteiro_viagem_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_transporte_roteiro_viagem_id_seq OWNER TO postgres;

--
-- TOC entry 12972 (class 0 OID 0)
-- Dependencies: 962
-- Name: sge_transporte_roteiro_viagem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_transporte_roteiro_viagem_id_seq OWNED BY public.sge_transporte_roteiro_viagem.id;


--
-- TOC entry 963 (class 1259 OID 14565054)
-- Name: sge_transporte_roteiro_viagem_pessoa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_transporte_roteiro_viagem_pessoa (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_transporte_roteiro_viagem integer NOT NULL,
 id_sge_transporte bigint NOT NULL,
 presente character(1) NOT NULL
);


ALTER TABLE public.sge_transporte_roteiro_viagem_pessoa OWNER TO postgres;

--
-- TOC entry 12973 (class 0 OID 0)
-- Dependencies: 963
-- Name: COLUMN sge_transporte_roteiro_viagem_pessoa.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_transporte_roteiro_viagem_pessoa.id IS 'Identificador sequencial da tabela, chave primaria composta com o campo id_bas_empresa';


--
-- TOC entry 12974 (class 0 OID 0)
-- Dependencies: 963
-- Name: COLUMN sge_transporte_roteiro_viagem_pessoa.id_bas_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_transporte_roteiro_viagem_pessoa.id_bas_empresa IS 'Identificador da tabela bas_empresa, chave primaria composta com o campo id';


--
-- TOC entry 12975 (class 0 OID 0)
-- Dependencies: 963
-- Name: COLUMN sge_transporte_roteiro_viagem_pessoa.id_sge_transporte_roteiro_viagem; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_transporte_roteiro_viagem_pessoa.id_sge_transporte_roteiro_viagem IS 'Identificador da tabela sge_transporte_roteiro_viagem junto com o campo id_bas_empresa';


--
-- TOC entry 964 (class 1259 OID 14565057)
-- Name: sge_transporte_roteiro_viagem_pessoa_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_transporte_roteiro_viagem_pessoa_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_transporte_roteiro_viagem_pessoa_id_seq OWNER TO postgres;

--
-- TOC entry 12976 (class 0 OID 0)
-- Dependencies: 964
-- Name: sge_transporte_roteiro_viagem_pessoa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_transporte_roteiro_viagem_pessoa_id_seq OWNED BY public.sge_transporte_roteiro_viagem_pessoa.id;


SET default_with_oids = true;

--
-- TOC entry 965 (class 1259 OID 14565059)
-- Name: sge_turma; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_turma (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_serie bigint NOT NULL,
 id_sge_turno bigint NOT NULL,
 id_bas_sala bigint,
 id_sge_conceito bigint,
 nome character varying(100) NOT NULL,
 sigla character varying(10) NOT NULL,
 ativo character(1) DEFAULT 'S'::bpchar NOT NULL,
 ano integer NOT NULL,
 sequencia integer,
 matricula_ativa character(1) DEFAULT 'S'::bpchar NOT NULL,
 m2_aluno numeric(3,1),
 horario_inicio time(6) without time zone,
 horario_fim time(6) without time zone,
 prefixo_matricula character varying(20),
 id_sge_turma_multisseriada bigint,
 objetivo text,
 multisseriada character(1) DEFAULT 'N'::bpchar NOT NULL,
 id_bas_estabelecimento bigint
);


ALTER TABLE public.sge_turma OWNER TO postgres;

--
-- TOC entry 12977 (class 0 OID 0)
-- Dependencies: 965
-- Name: COLUMN sge_turma.ativo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma.ativo IS 'S=sim, N=nao';


--
-- TOC entry 12978 (class 0 OID 0)
-- Dependencies: 965
-- Name: COLUMN sge_turma.ano; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma.ano IS 'Ano de criacao';


--
-- TOC entry 12979 (class 0 OID 0)
-- Dependencies: 965
-- Name: COLUMN sge_turma.objetivo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma.objetivo IS 'Utilizado para o objetivo da turma da educação especial';


--
-- TOC entry 12980 (class 0 OID 0)
-- Dependencies: 965
-- Name: COLUMN sge_turma.multisseriada; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma.multisseriada IS 'S = sim, N = Não';


SET default_with_oids = false;

--
-- TOC entry 966 (class 1259 OID 14565068)
-- Name: sge_turma_aluno; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_turma_aluno (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_turma bigint,
 id_sge_aluno bigint NOT NULL,
 id_bas_estabelecimento bigint NOT NULL,
 id_bas_instituicao_ensino_origem bigint,
 ano_letivo integer NOT NULL,
 matricula character varying(20) NOT NULL,
 matricula_etapa integer DEFAULT 0 NOT NULL,
 matricula_data date NOT NULL,
 id_sge_situacao_academica bigint,
 id_sge_situacao_pedagogica bigint,
 id_sge_situacao_pedagogica_anterior bigint,
 livro character varying(20),
 folha character varying(20),
 registro character varying(20),
 data_certificado date,
 data_colacao_grau date,
 recuperacao character(1),
 recuperacao_valor numeric(9,2),
 dependencia character(1) DEFAULT 'N'::bpchar NOT NULL,
 adiantamento_valor numeric(10,2),
 adiantamento_data date,
 parcela integer,
 data_inclusao date NOT NULL,
 bloqueio_data date,
 cancelamento_matricula_data timestamp without time zone,
 sequencia_diario_classe integer,
 sequencia_matricula integer,
 autoriza_foto character(1),
 bloqueio_observacao text,
 id_sge_serie bigint,
 id_sge_cotas bigint,
 login character varying(32),
 exclui_prematricula_data date,
 login_exclui_prematricula character varying(32),
 id_sge_graduacao bigint,
 base_sorteio_turma numeric(5,2),
 id_sge_modo_ingresso bigint,
 boletim_graduacao character varying(15),
 data_graduacao date,
 data_trancamento date,
 login_trancamento character varying(32),
 motivo_trancamento character varying(100),
 parecer_disciplinar character(1),
 serie_real character varying(50),
 observacao_parecer_pedagogico text,
 login_finalizado character varying(32),
 id_sge_conceito_faixa bigint,
 matricula_offline character(1)
);


ALTER TABLE public.sge_turma_aluno OWNER TO postgres;

--
-- TOC entry 12981 (class 0 OID 0)
-- Dependencies: 966
-- Name: COLUMN sge_turma_aluno.id_bas_instituicao_ensino_origem; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma_aluno.id_bas_instituicao_ensino_origem IS 'Escola anterior do aluno';


--
-- TOC entry 12982 (class 0 OID 0)
-- Dependencies: 966
-- Name: COLUMN sge_turma_aluno.matricula_etapa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma_aluno.matricula_etapa IS '1, 2,...(etapa atual da matrícula)';


--
-- TOC entry 12983 (class 0 OID 0)
-- Dependencies: 966
-- Name: COLUMN sge_turma_aluno.id_sge_situacao_academica; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma_aluno.id_sge_situacao_academica IS 'Candidato, Reservado, Cursando, Transf...';


--
-- TOC entry 12984 (class 0 OID 0)
-- Dependencies: 966
-- Name: COLUMN sge_turma_aluno.id_sge_situacao_pedagogica; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma_aluno.id_sge_situacao_pedagogica IS 'Aprovado, Conservado, ...';


--
-- TOC entry 12985 (class 0 OID 0)
-- Dependencies: 966
-- Name: COLUMN sge_turma_aluno.recuperacao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma_aluno.recuperacao IS 'S=sim N=nao';


--
-- TOC entry 12986 (class 0 OID 0)
-- Dependencies: 966
-- Name: COLUMN sge_turma_aluno.dependencia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma_aluno.dependencia IS 'S=sim N=nao';


--
-- TOC entry 12987 (class 0 OID 0)
-- Dependencies: 966
-- Name: COLUMN sge_turma_aluno.bloqueio_data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma_aluno.bloqueio_data IS 'Data que o o aluno foi bloqueado';


--
-- TOC entry 12988 (class 0 OID 0)
-- Dependencies: 966
-- Name: COLUMN sge_turma_aluno.autoriza_foto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma_aluno.autoriza_foto IS 'S = Sim, N = Nao';


--
-- TOC entry 12989 (class 0 OID 0)
-- Dependencies: 966
-- Name: COLUMN sge_turma_aluno.bloqueio_observacao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma_aluno.bloqueio_observacao IS 'Texto com o motivo do bloqueio do aluno.';


--
-- TOC entry 12990 (class 0 OID 0)
-- Dependencies: 966
-- Name: COLUMN sge_turma_aluno.base_sorteio_turma; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma_aluno.base_sorteio_turma IS 'Pontuação base para realocação do aluno em uma turma.';


--
-- TOC entry 12991 (class 0 OID 0)
-- Dependencies: 966
-- Name: COLUMN sge_turma_aluno.parecer_disciplinar; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma_aluno.parecer_disciplinar IS 'C="continuado"; D="descontinuado" conforme comportamento definido em conselho disciplinar.';


--
-- TOC entry 12992 (class 0 OID 0)
-- Dependencies: 966
-- Name: COLUMN sge_turma_aluno.serie_real; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma_aluno.serie_real IS 'Série real do aluno, solução paleativa para turmas multisseriadas em anguera';


--
-- TOC entry 12993 (class 0 OID 0)
-- Dependencies: 966
-- Name: COLUMN sge_turma_aluno.login_finalizado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma_aluno.login_finalizado IS 'Login que finalizou a matrícula do aluno';


--
-- TOC entry 12994 (class 0 OID 0)
-- Dependencies: 966
-- Name: COLUMN sge_turma_aluno.id_sge_conceito_faixa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma_aluno.id_sge_conceito_faixa IS 'Situação final da nota conceitual';


--
-- TOC entry 967 (class 1259 OID 14565076)
-- Name: sge_turma_aluno_cid; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_turma_aluno_cid (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_cid bigint NOT NULL,
 id_sge_turma_aluno bigint NOT NULL
);


ALTER TABLE public.sge_turma_aluno_cid OWNER TO postgres;

--
-- TOC entry 968 (class 1259 OID 14565079)
-- Name: sge_turma_aluno_cid_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_turma_aluno_cid_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_turma_aluno_cid_id_seq OWNER TO postgres;

--
-- TOC entry 12995 (class 0 OID 0)
-- Dependencies: 968
-- Name: sge_turma_aluno_cid_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_turma_aluno_cid_id_seq OWNED BY public.sge_turma_aluno_cid.id;


--
-- TOC entry 969 (class 1259 OID 14565081)
-- Name: sge_turma_aluno_dados_medicos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_turma_aluno_dados_medicos (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_turma_aluno bigint,
 medico_nome character varying(100),
 medico_endereco character varying(60),
 medico_telefone character varying(11),
 medico_celular character varying(11),
 alergico character(1),
 medicamentos_alergico character varying(100),
 medicamento_febre character varying(40),
 doenca_congenita character(1),
 congenita_qual character varying(40),
 epiletico character(1),
 tratamento_epiletico character(1),
 hemofolico character(1),
 hipertensao character(1),
 asmatico character(1),
 deficiente_visual character(1),
 deficiente_fisico character(1),
 diabetico character(1),
 dependente_insulina character(1),
 em_tratamento character(1),
 qual_tratamento character varying(40),
 medicacao_especifica character(1),
 qual_med_espec character varying(40),
 plano_saude character(1),
 qual_plano character varying(40),
 hospital character varying(40),
 hospital_endereco character varying(60),
 hospital_telefone character varying(11),
 contato_emerg_nome character varying(40),
 contato_emerg_endereco character varying(60),
 contato_emerg_telefone character varying(11),
 contato_emerg_celular character varying(11),
 medico_especialidade character varying(30),
 vacinacao_atualizada character(1) DEFAULT 'N'::bpchar,
 contato_emerg_outro character varying(20),
 id_bas_grau_parentesco_contato_emergencia bigint,
 atraso_des_neuropscicomotor character(1) DEFAULT 'N'::bpchar,
 transtorno_invasivo_des character(1) DEFAULT 'N'::bpchar,
 defcit_proc_audi_central character(1) DEFAULT 'N'::bpchar,
 defcit_cogn_indep_e_intelectual character(1) DEFAULT 'N'::bpchar,
 hidrocefalia character(1) DEFAULT 'N'::bpchar,
 mudez character(1) DEFAULT 'N'::bpchar,
 atraso_neuro_secund_anoxia_perinatal character(1) DEFAULT 'N'::bpchar,
 sindrome_willians_eou_silver character(1) DEFAULT 'N'::bpchar,
 sindrome_down character(1) DEFAULT 'N'::bpchar
);


ALTER TABLE public.sge_turma_aluno_dados_medicos OWNER TO postgres;

--
-- TOC entry 12996 (class 0 OID 0)
-- Dependencies: 969
-- Name: TABLE sge_turma_aluno_dados_medicos; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sge_turma_aluno_dados_medicos IS 'Tabela temporária feita apenas para a apresentação de 19/02/2013.
Excluir essa tabela no dia 20/02/2013, sem atraso!';


--
-- TOC entry 12997 (class 0 OID 0)
-- Dependencies: 969
-- Name: COLUMN sge_turma_aluno_dados_medicos.alergico; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma_aluno_dados_medicos.alergico IS 'S = sim N = não';


--
-- TOC entry 12998 (class 0 OID 0)
-- Dependencies: 969
-- Name: COLUMN sge_turma_aluno_dados_medicos.doenca_congenita; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma_aluno_dados_medicos.doenca_congenita IS 'S = sim, N = não';


--
-- TOC entry 12999 (class 0 OID 0)
-- Dependencies: 969
-- Name: COLUMN sge_turma_aluno_dados_medicos.epiletico; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma_aluno_dados_medicos.epiletico IS 'S = sim, N = não';


--
-- TOC entry 13000 (class 0 OID 0)
-- Dependencies: 969
-- Name: COLUMN sge_turma_aluno_dados_medicos.tratamento_epiletico; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma_aluno_dados_medicos.tratamento_epiletico IS 'S = sim, N = não';


--
-- TOC entry 13001 (class 0 OID 0)
-- Dependencies: 969
-- Name: COLUMN sge_turma_aluno_dados_medicos.hemofolico; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma_aluno_dados_medicos.hemofolico IS 'S = sim, N = não';


--
-- TOC entry 13002 (class 0 OID 0)
-- Dependencies: 969
-- Name: COLUMN sge_turma_aluno_dados_medicos.hipertensao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma_aluno_dados_medicos.hipertensao IS 'S = sim, N = não';


--
-- TOC entry 13003 (class 0 OID 0)
-- Dependencies: 969
-- Name: COLUMN sge_turma_aluno_dados_medicos.asmatico; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma_aluno_dados_medicos.asmatico IS 'S = sim, N = não';


--
-- TOC entry 13004 (class 0 OID 0)
-- Dependencies: 969
-- Name: COLUMN sge_turma_aluno_dados_medicos.deficiente_visual; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma_aluno_dados_medicos.deficiente_visual IS 'S = sim, N = não';


--
-- TOC entry 13005 (class 0 OID 0)
-- Dependencies: 969
-- Name: COLUMN sge_turma_aluno_dados_medicos.deficiente_fisico; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma_aluno_dados_medicos.deficiente_fisico IS 'S = sim, N = não';


--
-- TOC entry 13006 (class 0 OID 0)
-- Dependencies: 969
-- Name: COLUMN sge_turma_aluno_dados_medicos.diabetico; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma_aluno_dados_medicos.diabetico IS 'S = sim, N = não';


--
-- TOC entry 13007 (class 0 OID 0)
-- Dependencies: 969
-- Name: COLUMN sge_turma_aluno_dados_medicos.dependente_insulina; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma_aluno_dados_medicos.dependente_insulina IS 'S = sim, N = não';


--
-- TOC entry 13008 (class 0 OID 0)
-- Dependencies: 969
-- Name: COLUMN sge_turma_aluno_dados_medicos.em_tratamento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma_aluno_dados_medicos.em_tratamento IS 'S = sim, N = não';


--
-- TOC entry 13009 (class 0 OID 0)
-- Dependencies: 969
-- Name: COLUMN sge_turma_aluno_dados_medicos.medicacao_especifica; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma_aluno_dados_medicos.medicacao_especifica IS 'S = sim, N = não';


--
-- TOC entry 13010 (class 0 OID 0)
-- Dependencies: 969
-- Name: COLUMN sge_turma_aluno_dados_medicos.qual_med_espec; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma_aluno_dados_medicos.qual_med_espec IS 'Quais medicações específicas?';


--
-- TOC entry 13011 (class 0 OID 0)
-- Dependencies: 969
-- Name: COLUMN sge_turma_aluno_dados_medicos.plano_saude; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma_aluno_dados_medicos.plano_saude IS 'S = sim, N = não';


--
-- TOC entry 13012 (class 0 OID 0)
-- Dependencies: 969
-- Name: COLUMN sge_turma_aluno_dados_medicos.qual_plano; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma_aluno_dados_medicos.qual_plano IS 'Qual plano de saúde';


--
-- TOC entry 13013 (class 0 OID 0)
-- Dependencies: 969
-- Name: COLUMN sge_turma_aluno_dados_medicos.hospital; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma_aluno_dados_medicos.hospital IS 'Hospital para emergências';


--
-- TOC entry 13014 (class 0 OID 0)
-- Dependencies: 969
-- Name: COLUMN sge_turma_aluno_dados_medicos.medico_especialidade; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma_aluno_dados_medicos.medico_especialidade IS 'A especialidade do médico';


--
-- TOC entry 13015 (class 0 OID 0)
-- Dependencies: 969
-- Name: COLUMN sge_turma_aluno_dados_medicos.vacinacao_atualizada; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma_aluno_dados_medicos.vacinacao_atualizada IS 'Informa se a vacina está atualizada.';


--
-- TOC entry 13016 (class 0 OID 0)
-- Dependencies: 969
-- Name: COLUMN sge_turma_aluno_dados_medicos.contato_emerg_outro; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma_aluno_dados_medicos.contato_emerg_outro IS 'Outro tipo contato emergencia (parenteso)';


--
-- TOC entry 970 (class 1259 OID 14565097)
-- Name: sge_turma_aluno_dados_medicos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_turma_aluno_dados_medicos_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_turma_aluno_dados_medicos_id_seq OWNER TO postgres;

--
-- TOC entry 13017 (class 0 OID 0)
-- Dependencies: 970
-- Name: sge_turma_aluno_dados_medicos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_turma_aluno_dados_medicos_id_seq OWNED BY public.sge_turma_aluno_dados_medicos.id;


--
-- TOC entry 971 (class 1259 OID 14565099)
-- Name: sge_turma_aluno_disciplina; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_turma_aluno_disciplina (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_turma_aluno bigint NOT NULL,
 id_sge_disciplina bigint NOT NULL,
 id_sge_situacao_disciplina bigint NOT NULL,
 id_sge_modulo bigint,
 id_sge_turma_aula bigint,
 dependencia integer DEFAULT 0 NOT NULL,
 id_sgf_tipo_titulo_receber bigint,
 valor numeric(9,2),
 nota numeric(6,3),
 nota_parcial numeric(6,3),
 pontos numeric(6,3),
 id_sge_conceito_faixa bigint,
 faltas integer,
 data date,
 datahora timestamp without time zone DEFAULT now() NOT NULL,
 nota_anterior numeric(6,3),
 id_sge_situacao_disciplina_anterior bigint,
 inscrito_recuperacao character(1),
 nota_recuperacao numeric(6,3),
 aprovado_conselho character(1),
 datahora_conselho timestamp without time zone,
 optativa character(1),
 dispensa character(1) DEFAULT 'N'::bpchar,
 dispensa_data date,
 dispensa_observacao character varying(100),
 dispensa_protocolo character varying(100),
 observacao_aluno text
);


ALTER TABLE public.sge_turma_aluno_disciplina OWNER TO postgres;

--
-- TOC entry 13018 (class 0 OID 0)
-- Dependencies: 971
-- Name: COLUMN sge_turma_aluno_disciplina.optativa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma_aluno_disciplina.optativa IS 'S=sim N=nao';


--
-- TOC entry 13019 (class 0 OID 0)
-- Dependencies: 971
-- Name: COLUMN sge_turma_aluno_disciplina.dispensa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma_aluno_disciplina.dispensa IS 'S=sim N=nao';


SET default_with_oids = true;

--
-- TOC entry 972 (class 1259 OID 14565105)
-- Name: sge_turma_aluno_disciplina_etapa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_turma_aluno_disciplina_etapa (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_turma_aluno_disciplina bigint NOT NULL,
 id_sge_conceito_faixa bigint,
 id_sge_criterio_etapa bigint,
 nota numeric(6,3),
 relatorio text,
 nota_recuperacao numeric(6,3),
 nota_parcial numeric(6,3),
 origem character(1),
 situacao integer,
 id_sge_conceito_descritivo_item bigint,
 id_sge_conceito_descritivo_opcao bigint,
 presencas smallint
);


ALTER TABLE public.sge_turma_aluno_disciplina_etapa OWNER TO postgres;

--
-- TOC entry 13020 (class 0 OID 0)
-- Dependencies: 972
-- Name: COLUMN sge_turma_aluno_disciplina_etapa.relatorio; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma_aluno_disciplina_etapa.relatorio IS 'Informações voltadas ao conselho.';


--
-- TOC entry 13021 (class 0 OID 0)
-- Dependencies: 972
-- Name: COLUMN sge_turma_aluno_disciplina_etapa.presencas; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma_aluno_disciplina_etapa.presencas IS 'Quantidade de presenças - Voltado inicialmente para o ensino dos alunos especiais';


SET default_with_oids = false;

--
-- TOC entry 973 (class 1259 OID 14565111)
-- Name: sge_turma_aluno_disciplina_etapa_anotacao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_turma_aluno_disciplina_etapa_anotacao (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_turma_aluno_disciplina bigint NOT NULL,
 id_sge_etapa bigint NOT NULL,
 id_sge_ocorrencia_tipo bigint,
 anotacao text,
 data date NOT NULL,
 hora time(0) without time zone
);


ALTER TABLE public.sge_turma_aluno_disciplina_etapa_anotacao OWNER TO postgres;

--
-- TOC entry 974 (class 1259 OID 14565117)
-- Name: sge_turma_aluno_disciplina_etapa_anotacao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_turma_aluno_disciplina_etapa_anotacao_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_turma_aluno_disciplina_etapa_anotacao_id_seq OWNER TO postgres;

--
-- TOC entry 13022 (class 0 OID 0)
-- Dependencies: 974
-- Name: sge_turma_aluno_disciplina_etapa_anotacao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_turma_aluno_disciplina_etapa_anotacao_id_seq OWNED BY public.sge_turma_aluno_disciplina_etapa_anotacao.id;


--
-- TOC entry 975 (class 1259 OID 14565119)
-- Name: sge_turma_aluno_disciplina_etapa_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_turma_aluno_disciplina_etapa_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_turma_aluno_disciplina_etapa_id_seq OWNER TO postgres;

--
-- TOC entry 13023 (class 0 OID 0)
-- Dependencies: 975
-- Name: sge_turma_aluno_disciplina_etapa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_turma_aluno_disciplina_etapa_id_seq OWNED BY public.sge_turma_aluno_disciplina_etapa.id;


--
-- TOC entry 976 (class 1259 OID 14565121)
-- Name: sge_turma_aluno_disciplina_etapa_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_turma_aluno_disciplina_etapa_log (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_turma_aluno_disciplina_etapa bigint NOT NULL,
 login character varying(32) NOT NULL,
 nota numeric(6,3),
 data date NOT NULL,
 hora time without time zone NOT NULL,
 id_sge_conceito_descritivo_item bigint,
 id_sge_conceito_descritivo_opcao bigint
);


ALTER TABLE public.sge_turma_aluno_disciplina_etapa_log OWNER TO postgres;

--
-- TOC entry 977 (class 1259 OID 14565124)
-- Name: sge_turma_aluno_disciplina_etapa_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_turma_aluno_disciplina_etapa_log_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_turma_aluno_disciplina_etapa_log_id_seq OWNER TO postgres;

--
-- TOC entry 13024 (class 0 OID 0)
-- Dependencies: 977
-- Name: sge_turma_aluno_disciplina_etapa_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_turma_aluno_disciplina_etapa_log_id_seq OWNED BY public.sge_turma_aluno_disciplina_etapa_log.id;


--
-- TOC entry 978 (class 1259 OID 14565126)
-- Name: sge_turma_aluno_disciplina_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_turma_aluno_disciplina_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_turma_aluno_disciplina_id_seq OWNER TO postgres;

--
-- TOC entry 13025 (class 0 OID 0)
-- Dependencies: 978
-- Name: sge_turma_aluno_disciplina_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_turma_aluno_disciplina_id_seq OWNED BY public.sge_turma_aluno_disciplina.id;


--
-- TOC entry 979 (class 1259 OID 14565128)
-- Name: sge_turma_aluno_doacao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_turma_aluno_doacao (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_turma_aluno bigint NOT NULL,
 id_sgb_livro bigint NOT NULL,
 id_sgb_exemplar bigint,
 login_emprestimo character varying(32),
 login_devolucao character varying(32),
 quantidade integer NOT NULL,
 data_doacao date,
 data_devolucao date
);


ALTER TABLE public.sge_turma_aluno_doacao OWNER TO postgres;

--
-- TOC entry 980 (class 1259 OID 14565131)
-- Name: sge_turma_aluno_doacao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_turma_aluno_doacao_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_turma_aluno_doacao_id_seq OWNER TO postgres;

--
-- TOC entry 13026 (class 0 OID 0)
-- Dependencies: 980
-- Name: sge_turma_aluno_doacao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_turma_aluno_doacao_id_seq OWNED BY public.sge_turma_aluno_doacao.id;


--
-- TOC entry 981 (class 1259 OID 14565133)
-- Name: sge_turma_aluno_documento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_turma_aluno_documento (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_turma_aluno bigint NOT NULL,
 id_sge_tipo_documento bigint NOT NULL,
 login character varying(32),
 quant_entregue integer NOT NULL,
 observacao character varying(200),
 data_inclusao date NOT NULL,
 quantidade integer,
 obrigatorio character(1)
);


ALTER TABLE public.sge_turma_aluno_documento OWNER TO postgres;

--
-- TOC entry 13027 (class 0 OID 0)
-- Dependencies: 981
-- Name: COLUMN sge_turma_aluno_documento.quant_entregue; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma_aluno_documento.quant_entregue IS 'Quantidade de documentos entregues';


--
-- TOC entry 13028 (class 0 OID 0)
-- Dependencies: 981
-- Name: COLUMN sge_turma_aluno_documento.quantidade; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma_aluno_documento.quantidade IS 'Quantidade requerida';


--
-- TOC entry 982 (class 1259 OID 14565136)
-- Name: sge_turma_aluno_documento_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_turma_aluno_documento_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_turma_aluno_documento_id_seq OWNER TO postgres;

--
-- TOC entry 13029 (class 0 OID 0)
-- Dependencies: 982
-- Name: sge_turma_aluno_documento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_turma_aluno_documento_id_seq OWNED BY public.sge_turma_aluno_documento.id;


--
-- TOC entry 983 (class 1259 OID 14565138)
-- Name: sge_turma_aluno_etapa_mensagem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_turma_aluno_etapa_mensagem (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_turma_aluno bigint NOT NULL,
 id_sge_etapa bigint NOT NULL,
 mensagem text NOT NULL
);


ALTER TABLE public.sge_turma_aluno_etapa_mensagem OWNER TO postgres;

--
-- TOC entry 984 (class 1259 OID 14565144)
-- Name: sge_turma_aluno_etapa_mensagem_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_turma_aluno_etapa_mensagem_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_turma_aluno_etapa_mensagem_id_seq OWNER TO postgres;

--
-- TOC entry 13030 (class 0 OID 0)
-- Dependencies: 984
-- Name: sge_turma_aluno_etapa_mensagem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_turma_aluno_etapa_mensagem_id_seq OWNED BY public.sge_turma_aluno_etapa_mensagem.id;


--
-- TOC entry 985 (class 1259 OID 14565146)
-- Name: sge_turma_aluno_fardamento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_turma_aluno_fardamento (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_turma_aluno bigint NOT NULL,
 id_sga_material bigint NOT NULL,
 tamanho character varying(10)
);


ALTER TABLE public.sge_turma_aluno_fardamento OWNER TO postgres;

--
-- TOC entry 13031 (class 0 OID 0)
-- Dependencies: 985
-- Name: TABLE sge_turma_aluno_fardamento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sge_turma_aluno_fardamento IS 'Registra os tamanhos para o fardamento que o aluno utilizará';


--
-- TOC entry 13032 (class 0 OID 0)
-- Dependencies: 985
-- Name: COLUMN sge_turma_aluno_fardamento.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma_aluno_fardamento.id IS 'Chave primária composta ao lado de id_bas_empresa, sequencial';


--
-- TOC entry 13033 (class 0 OID 0)
-- Dependencies: 985
-- Name: COLUMN sge_turma_aluno_fardamento.id_bas_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma_aluno_fardamento.id_bas_empresa IS 'Chave estrangeira da tabela bas_empresa e chave primária ao lado do campo id';


--
-- TOC entry 13034 (class 0 OID 0)
-- Dependencies: 985
-- Name: COLUMN sge_turma_aluno_fardamento.id_sge_turma_aluno; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma_aluno_fardamento.id_sge_turma_aluno IS 'Chave estrangeira da tabela sge_turma_aluno ao lado do campo id_bas_empresa';


--
-- TOC entry 13035 (class 0 OID 0)
-- Dependencies: 985
-- Name: COLUMN sge_turma_aluno_fardamento.id_sga_material; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma_aluno_fardamento.id_sga_material IS 'Chave estrangeira da tabela sge_material ao lado do campo id_bas_empresa';


--
-- TOC entry 13036 (class 0 OID 0)
-- Dependencies: 985
-- Name: COLUMN sge_turma_aluno_fardamento.tamanho; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma_aluno_fardamento.tamanho IS 'Tamanho que aquele aluno utiliza';


--
-- TOC entry 986 (class 1259 OID 14565149)
-- Name: sge_turma_aluno_fardamento_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_turma_aluno_fardamento_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_turma_aluno_fardamento_id_seq OWNER TO postgres;

--
-- TOC entry 13037 (class 0 OID 0)
-- Dependencies: 986
-- Name: sge_turma_aluno_fardamento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_turma_aluno_fardamento_id_seq OWNED BY public.sge_turma_aluno_fardamento.id;


--
-- TOC entry 987 (class 1259 OID 14565151)
-- Name: sge_turma_aluno_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_turma_aluno_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_turma_aluno_id_seq OWNER TO postgres;

--
-- TOC entry 13038 (class 0 OID 0)
-- Dependencies: 987
-- Name: sge_turma_aluno_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_turma_aluno_id_seq OWNED BY public.sge_turma_aluno.id;


--
-- TOC entry 988 (class 1259 OID 14565153)
-- Name: sge_turma_aluno_modulo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_turma_aluno_modulo (
 id_bas_empresa bigint NOT NULL,
 id_sge_turma_aluno bigint NOT NULL,
 id_sge_modulo bigint NOT NULL
);


ALTER TABLE public.sge_turma_aluno_modulo OWNER TO postgres;

--
-- TOC entry 989 (class 1259 OID 14565156)
-- Name: sge_turma_aluno_programa_social; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_turma_aluno_programa_social (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_turma_aluno bigint NOT NULL,
 observacao character varying(50),
 id_sge_turno bigint,
 matricula character varying(50),
 horario_inicial time without time zone,
 horario_final time without time zone,
 id_sge_programa_social bigint
);


ALTER TABLE public.sge_turma_aluno_programa_social OWNER TO postgres;

--
-- TOC entry 990 (class 1259 OID 14565159)
-- Name: sge_turma_aluno_programa_social_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_turma_aluno_programa_social_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_turma_aluno_programa_social_id_seq OWNER TO postgres;

--
-- TOC entry 13039 (class 0 OID 0)
-- Dependencies: 990
-- Name: sge_turma_aluno_programa_social_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_turma_aluno_programa_social_id_seq OWNED BY public.sge_turma_aluno_programa_social.id;


--
-- TOC entry 991 (class 1259 OID 14565161)
-- Name: sge_turma_aluno_questionario_respondido; Type: TABLE; Schema: public; Owner: pgadmin
--

CREATE TABLE public.sge_turma_aluno_questionario_respondido (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_turma_aluno bigint NOT NULL,
 id_bas_pergunta bigint NOT NULL,
 id_bas_resposta bigint,
 data_resposta date DEFAULT now(),
 resposta_texto character varying(300)
);


ALTER TABLE public.sge_turma_aluno_questionario_respondido OWNER TO pgadmin;

--
-- TOC entry 992 (class 1259 OID 14565165)
-- Name: sge_turma_aluno_questionario_respondido_id_seq; Type: SEQUENCE; Schema: public; Owner: pgadmin
--

CREATE SEQUENCE public.sge_turma_aluno_questionario_respondido_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_turma_aluno_questionario_respondido_id_seq OWNER TO pgadmin;

--
-- TOC entry 13040 (class 0 OID 0)
-- Dependencies: 992
-- Name: sge_turma_aluno_questionario_respondido_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgadmin
--

ALTER SEQUENCE public.sge_turma_aluno_questionario_respondido_id_seq OWNED BY public.sge_turma_aluno_questionario_respondido.id;


--
-- TOC entry 993 (class 1259 OID 14565167)
-- Name: sge_turma_aluno_sintese_desempenho; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_turma_aluno_sintese_desempenho (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_turma_aluno bigint NOT NULL,
 texto text NOT NULL,
 id_sge_disciplina bigint,
 id_sge_etapa bigint,
 situacao character(1) DEFAULT 'N'::bpchar NOT NULL,
 observacao text,
 login_coordenador character varying
);


ALTER TABLE public.sge_turma_aluno_sintese_desempenho OWNER TO postgres;

--
-- TOC entry 13041 (class 0 OID 0)
-- Dependencies: 993
-- Name: TABLE sge_turma_aluno_sintese_desempenho; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sge_turma_aluno_sintese_desempenho IS 'Estrutura para o aluno receber a sintese de desempenho';


--
-- TOC entry 13042 (class 0 OID 0)
-- Dependencies: 993
-- Name: COLUMN sge_turma_aluno_sintese_desempenho.id_sge_disciplina; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma_aluno_sintese_desempenho.id_sge_disciplina IS 'Disciplina opcional';


--
-- TOC entry 13043 (class 0 OID 0)
-- Dependencies: 993
-- Name: COLUMN sge_turma_aluno_sintese_desempenho.situacao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turma_aluno_sintese_desempenho.situacao IS '''N'' = Não lido, ''L'' = Lido e ''R'' = Recusado';


--
-- TOC entry 994 (class 1259 OID 14565174)
-- Name: sge_turma_aluno_sintese_desempenho_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_turma_aluno_sintese_desempenho_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_turma_aluno_sintese_desempenho_id_seq OWNER TO postgres;

--
-- TOC entry 13044 (class 0 OID 0)
-- Dependencies: 994
-- Name: sge_turma_aluno_sintese_desempenho_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_turma_aluno_sintese_desempenho_id_seq OWNED BY public.sge_turma_aluno_sintese_desempenho.id;


--
-- TOC entry 995 (class 1259 OID 14565176)
-- Name: sge_turma_aluno_situacao_academica_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_turma_aluno_situacao_academica_log (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_turma_aluno bigint,
 id_sge_situacao_academica bigint,
 login character varying(32),
 motivo character varying(100),
 data_hora timestamp(0) without time zone DEFAULT now()
);


ALTER TABLE public.sge_turma_aluno_situacao_academica_log OWNER TO postgres;

--
-- TOC entry 996 (class 1259 OID 14565180)
-- Name: sge_turma_aluno_situacao_academica_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_turma_aluno_situacao_academica_log_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_turma_aluno_situacao_academica_log_id_seq OWNER TO postgres;

--
-- TOC entry 13045 (class 0 OID 0)
-- Dependencies: 996
-- Name: sge_turma_aluno_situacao_academica_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_turma_aluno_situacao_academica_log_id_seq OWNED BY public.sge_turma_aluno_situacao_academica_log.id;


--
-- TOC entry 997 (class 1259 OID 14565182)
-- Name: sge_turma_aluno_topico_resposta; Type: TABLE; Schema: public; Owner: pgadmin
--

CREATE TABLE public.sge_turma_aluno_topico_resposta (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_educacao_especial_topico bigint NOT NULL,
 id_sge_turma_aluno_disciplina_etapa bigint NOT NULL,
 resposta text NOT NULL,
 data date NOT NULL,
 login character varying(32) NOT NULL
);


ALTER TABLE public.sge_turma_aluno_topico_resposta OWNER TO pgadmin;

--
-- TOC entry 998 (class 1259 OID 14565188)
-- Name: sge_turma_aluno_topico_resposta_id_seq; Type: SEQUENCE; Schema: public; Owner: pgadmin
--

CREATE SEQUENCE public.sge_turma_aluno_topico_resposta_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_turma_aluno_topico_resposta_id_seq OWNER TO pgadmin;

--
-- TOC entry 13046 (class 0 OID 0)
-- Dependencies: 998
-- Name: sge_turma_aluno_topico_resposta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgadmin
--

ALTER SEQUENCE public.sge_turma_aluno_topico_resposta_id_seq OWNED BY public.sge_turma_aluno_topico_resposta.id;


--
-- TOC entry 999 (class 1259 OID 14565190)
-- Name: sge_turma_aluno_topico_resposta_log; Type: TABLE; Schema: public; Owner: pgadmin
--

CREATE TABLE public.sge_turma_aluno_topico_resposta_log (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_turma_aluno_topico_resposta bigint,
 data timestamp without time zone,
 login character varying(32)
);


ALTER TABLE public.sge_turma_aluno_topico_resposta_log OWNER TO pgadmin;

--
-- TOC entry 1000 (class 1259 OID 14565193)
-- Name: sge_turma_aluno_topico_resposta_log_id_seq; Type: SEQUENCE; Schema: public; Owner: pgadmin
--

CREATE SEQUENCE public.sge_turma_aluno_topico_resposta_log_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_turma_aluno_topico_resposta_log_id_seq OWNER TO pgadmin;

--
-- TOC entry 13047 (class 0 OID 0)
-- Dependencies: 1000
-- Name: sge_turma_aluno_topico_resposta_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgadmin
--

ALTER SEQUENCE public.sge_turma_aluno_topico_resposta_log_id_seq OWNED BY public.sge_turma_aluno_topico_resposta_log.id;


--
-- TOC entry 1001 (class 1259 OID 14565195)
-- Name: sge_turma_ano; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_turma_ano (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_turma bigint NOT NULL,
 id_sge_turno bigint,
 id_bas_sala bigint,
 ano_letivo smallint NOT NULL,
 horario_inicio time without time zone,
 horario_fim time without time zone,
 m2_aluno numeric(3,1) NOT NULL,
 capacidade integer
);


ALTER TABLE public.sge_turma_ano OWNER TO postgres;

--
-- TOC entry 1002 (class 1259 OID 14565198)
-- Name: sge_turma_ano_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_turma_ano_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_turma_ano_id_seq OWNER TO postgres;

--
-- TOC entry 13048 (class 0 OID 0)
-- Dependencies: 1002
-- Name: sge_turma_ano_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_turma_ano_id_seq OWNED BY public.sge_turma_ano.id;


--
-- TOC entry 1003 (class 1259 OID 14565200)
-- Name: sge_turma_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_turma_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_turma_id_seq OWNER TO postgres;

--
-- TOC entry 13049 (class 0 OID 0)
-- Dependencies: 1003
-- Name: sge_turma_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_turma_id_seq OWNED BY public.sge_turma.id;


--
-- TOC entry 1004 (class 1259 OID 14565202)
-- Name: sge_turma_modulo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_turma_modulo (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_turma bigint NOT NULL,
 id_sge_modulo bigint NOT NULL,
 exige_matricula character(1),
 parcela_mes smallint,
 data_inicio date,
 data_fim date,
 parcelas smallint,
 parcelas_inicio smallint,
 parcelas_fim smallint
);


ALTER TABLE public.sge_turma_modulo OWNER TO postgres;

--
-- TOC entry 1005 (class 1259 OID 14565205)
-- Name: sge_turma_modulo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_turma_modulo_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_turma_modulo_id_seq OWNER TO postgres;

--
-- TOC entry 13050 (class 0 OID 0)
-- Dependencies: 1005
-- Name: sge_turma_modulo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_turma_modulo_id_seq OWNED BY public.sge_turma_modulo.id;


--
-- TOC entry 1006 (class 1259 OID 14565207)
-- Name: sge_turma_multisseriada; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_turma_multisseriada (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_curso bigint,
 nome character varying(100)
);


ALTER TABLE public.sge_turma_multisseriada OWNER TO postgres;

--
-- TOC entry 1007 (class 1259 OID 14565210)
-- Name: sge_turma_multisseriada_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_turma_multisseriada_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_turma_multisseriada_id_seq OWNER TO postgres;

--
-- TOC entry 13051 (class 0 OID 0)
-- Dependencies: 1007
-- Name: sge_turma_multisseriada_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_turma_multisseriada_id_seq OWNED BY public.sge_turma_multisseriada.id;


SET default_with_oids = true;

--
-- TOC entry 1008 (class 1259 OID 14565212)
-- Name: sge_turno; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_turno (
 id bigint NOT NULL,
 nome character varying(50)
);


ALTER TABLE public.sge_turno OWNER TO postgres;

--
-- TOC entry 1009 (class 1259 OID 14565215)
-- Name: sge_turno_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_turno_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_turno_id_seq OWNER TO postgres;

--
-- TOC entry 13052 (class 0 OID 0)
-- Dependencies: 1009
-- Name: sge_turno_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_turno_id_seq OWNED BY public.sge_turno.id;


SET default_with_oids = false;

--
-- TOC entry 1010 (class 1259 OID 14565217)
-- Name: sge_turno_integral; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_turno_integral (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_turma_aluno bigint NOT NULL,
 id_sge_turno_integral_opcao bigint NOT NULL,
 login character varying(32) NOT NULL,
 login_cancelamento character varying(32),
 data date NOT NULL,
 data_inicio date,
 data_fim date,
 data_cancelamento date,
 valor numeric(9,2) NOT NULL,
 parcela integer NOT NULL,
 segunda character(1) DEFAULT 'N'::bpchar NOT NULL,
 terca character(1) DEFAULT 'N'::bpchar NOT NULL,
 quarta character(1) DEFAULT 'N'::bpchar NOT NULL,
 quinta character(1) DEFAULT 'N'::bpchar NOT NULL,
 sexta character(1) DEFAULT 'N'::bpchar NOT NULL,
 primeiro_vencimento date
);


ALTER TABLE public.sge_turno_integral OWNER TO postgres;

--
-- TOC entry 13053 (class 0 OID 0)
-- Dependencies: 1010
-- Name: TABLE sge_turno_integral; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sge_turno_integral IS 'Cadastra os turnos integrais dos alunos';


--
-- TOC entry 13054 (class 0 OID 0)
-- Dependencies: 1010
-- Name: COLUMN sge_turno_integral.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turno_integral.id IS 'Identificador sequencial da tabela, chave primaria composta com o campo id_bas_empresa';


--
-- TOC entry 13055 (class 0 OID 0)
-- Dependencies: 1010
-- Name: COLUMN sge_turno_integral.id_bas_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turno_integral.id_bas_empresa IS 'Identificador da tabela bas_empresa, chave primaria composta com o campo id';


--
-- TOC entry 13056 (class 0 OID 0)
-- Dependencies: 1010
-- Name: COLUMN sge_turno_integral.id_sge_turma_aluno; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turno_integral.id_sge_turma_aluno IS 'Identificador da tabela sge_turma_aluno junto com o campo id_bas_empresa';


--
-- TOC entry 13057 (class 0 OID 0)
-- Dependencies: 1010
-- Name: COLUMN sge_turno_integral.id_sge_turno_integral_opcao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turno_integral.id_sge_turno_integral_opcao IS 'Identificador da tabela sge_opcao_turno_integral junto com o campo id_bas_empresa';


--
-- TOC entry 13058 (class 0 OID 0)
-- Dependencies: 1010
-- Name: COLUMN sge_turno_integral.login; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turno_integral.login IS 'Identificador da tabela seg_users';


--
-- TOC entry 13059 (class 0 OID 0)
-- Dependencies: 1010
-- Name: COLUMN sge_turno_integral.login_cancelamento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turno_integral.login_cancelamento IS 'Identificador da tabela seg_users';


--
-- TOC entry 13060 (class 0 OID 0)
-- Dependencies: 1010
-- Name: COLUMN sge_turno_integral.data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turno_integral.data IS 'Data de gravação do registro';


--
-- TOC entry 13061 (class 0 OID 0)
-- Dependencies: 1010
-- Name: COLUMN sge_turno_integral.data_inicio; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turno_integral.data_inicio IS 'Data do início do turno integral';


--
-- TOC entry 13062 (class 0 OID 0)
-- Dependencies: 1010
-- Name: COLUMN sge_turno_integral.data_fim; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turno_integral.data_fim IS 'Data do fim do turno integra';


--
-- TOC entry 13063 (class 0 OID 0)
-- Dependencies: 1010
-- Name: COLUMN sge_turno_integral.data_cancelamento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turno_integral.data_cancelamento IS 'Data do cancelamento do turno integral';


--
-- TOC entry 13064 (class 0 OID 0)
-- Dependencies: 1010
-- Name: COLUMN sge_turno_integral.valor; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turno_integral.valor IS 'Valor do turno integral';


--
-- TOC entry 13065 (class 0 OID 0)
-- Dependencies: 1010
-- Name: COLUMN sge_turno_integral.parcela; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turno_integral.parcela IS 'Número de parcelas do turno integral';


--
-- TOC entry 13066 (class 0 OID 0)
-- Dependencies: 1010
-- Name: COLUMN sge_turno_integral.segunda; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turno_integral.segunda IS 'Se o aluno possui turno integral na segunda (S="Sim, N = Não)';


--
-- TOC entry 13067 (class 0 OID 0)
-- Dependencies: 1010
-- Name: COLUMN sge_turno_integral.terca; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turno_integral.terca IS 'Se o aluno possui turno integral na terça (S="Sim, N = Não)';


--
-- TOC entry 13068 (class 0 OID 0)
-- Dependencies: 1010
-- Name: COLUMN sge_turno_integral.quarta; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turno_integral.quarta IS 'Se o aluno possui turno integral na quarta (S="Sim, N = Não)';


--
-- TOC entry 13069 (class 0 OID 0)
-- Dependencies: 1010
-- Name: COLUMN sge_turno_integral.quinta; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turno_integral.quinta IS 'Se o aluno possui turno integral na quinta (S="Sim, N = Não)';


--
-- TOC entry 13070 (class 0 OID 0)
-- Dependencies: 1010
-- Name: COLUMN sge_turno_integral.sexta; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turno_integral.sexta IS 'Se o aluno possui turno integral na sexta (S="Sim, N = Não)';


--
-- TOC entry 13071 (class 0 OID 0)
-- Dependencies: 1010
-- Name: COLUMN sge_turno_integral.primeiro_vencimento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turno_integral.primeiro_vencimento IS 'Data do primeiro vencimento das parcelas geradas pelo turno integral';


--
-- TOC entry 1011 (class 1259 OID 14565225)
-- Name: sge_turno_integral_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_turno_integral_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_turno_integral_id_seq OWNER TO postgres;

--
-- TOC entry 13072 (class 0 OID 0)
-- Dependencies: 1011
-- Name: sge_turno_integral_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_turno_integral_id_seq OWNED BY public.sge_turno_integral.id;


--
-- TOC entry 1012 (class 1259 OID 14565227)
-- Name: sge_turno_integral_opcao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_turno_integral_opcao (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 descricao character varying(50) NOT NULL,
 valor numeric(9,2) NOT NULL
);


ALTER TABLE public.sge_turno_integral_opcao OWNER TO postgres;

--
-- TOC entry 13073 (class 0 OID 0)
-- Dependencies: 1012
-- Name: TABLE sge_turno_integral_opcao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sge_turno_integral_opcao IS 'Cadastra as opções para turnos integrais';


--
-- TOC entry 13074 (class 0 OID 0)
-- Dependencies: 1012
-- Name: COLUMN sge_turno_integral_opcao.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turno_integral_opcao.id IS 'Identificador sequencial da tabela, chave primaria composta com o campo id_bas_empresa';


--
-- TOC entry 13075 (class 0 OID 0)
-- Dependencies: 1012
-- Name: COLUMN sge_turno_integral_opcao.id_bas_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turno_integral_opcao.id_bas_empresa IS 'Identificador da tabela bas_empresa, chave primaria composta com o campo id';


--
-- TOC entry 13076 (class 0 OID 0)
-- Dependencies: 1012
-- Name: COLUMN sge_turno_integral_opcao.descricao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turno_integral_opcao.descricao IS 'Descrição da opção do turno integral';


--
-- TOC entry 13077 (class 0 OID 0)
-- Dependencies: 1012
-- Name: COLUMN sge_turno_integral_opcao.valor; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sge_turno_integral_opcao.valor IS 'Valor pré-definido para os turnos integrais daquela opção';


--
-- TOC entry 1013 (class 1259 OID 14565230)
-- Name: sge_turno_integral_opcao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_turno_integral_opcao_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_turno_integral_opcao_id_seq OWNER TO postgres;

--
-- TOC entry 13078 (class 0 OID 0)
-- Dependencies: 1013
-- Name: sge_turno_integral_opcao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_turno_integral_opcao_id_seq OWNED BY public.sge_turno_integral_opcao.id;


SET default_with_oids = true;

--
-- TOC entry 1014 (class 1259 OID 14565232)
-- Name: sge_visita_responsavel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sge_visita_responsavel (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sge_aluno bigint NOT NULL,
 id_bas_responsavel bigint NOT NULL,
 data date NOT NULL,
 hora_inicio time(6) without time zone,
 hora_fim time(6) without time zone,
 motivo text
);


ALTER TABLE public.sge_visita_responsavel OWNER TO postgres;

--
-- TOC entry 1015 (class 1259 OID 14565238)
-- Name: sge_visita_responsavel_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sge_visita_responsavel_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sge_visita_responsavel_id_seq OWNER TO postgres;

--
-- TOC entry 13079 (class 0 OID 0)
-- Dependencies: 1015
-- Name: sge_visita_responsavel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sge_visita_responsavel_id_seq OWNED BY public.sge_visita_responsavel.id;


--
-- TOC entry 1016 (class 1259 OID 14565240)
-- Name: sgf_acordo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_acordo (
 id bigint NOT NULL,
 id_bas_empresa integer NOT NULL,
 id_bas_pessoa bigint,
 id_sge_aluno bigint,
 login character varying,
 data date,
 valor numeric(9,2),
 valor_entrada numeric(9,2),
 numero_parcelas integer,
 data_inicio date,
 desconto numeric(9,2),
 taxa_juros numeric(9,2),
 taxa_multa numeric(9,2),
 observacao text
);


ALTER TABLE public.sgf_acordo OWNER TO postgres;

--
-- TOC entry 13080 (class 0 OID 0)
-- Dependencies: 1016
-- Name: COLUMN sgf_acordo.data_inicio; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_acordo.data_inicio IS 'Vencimento Inicial';


--
-- TOC entry 1017 (class 1259 OID 14565246)
-- Name: sgf_acordo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_acordo_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_acordo_id_seq OWNER TO postgres;

--
-- TOC entry 13081 (class 0 OID 0)
-- Dependencies: 1017
-- Name: sgf_acordo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_acordo_id_seq OWNED BY public.sgf_acordo.id;


SET default_with_oids = false;

--
-- TOC entry 1018 (class 1259 OID 14565248)
-- Name: sgf_acordo_parcela; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_acordo_parcela (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sgf_acordo bigint NOT NULL,
 id_sgf_titulo_receber bigint,
 numero smallint NOT NULL,
 vencimento date,
 valor numeric(9,2) NOT NULL
);


ALTER TABLE public.sgf_acordo_parcela OWNER TO postgres;

--
-- TOC entry 1019 (class 1259 OID 14565251)
-- Name: sgf_acordo_parcela_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_acordo_parcela_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_acordo_parcela_id_seq OWNER TO postgres;

--
-- TOC entry 13082 (class 0 OID 0)
-- Dependencies: 1019
-- Name: sgf_acordo_parcela_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_acordo_parcela_id_seq OWNED BY public.sgf_acordo_parcela.id;


--
-- TOC entry 1020 (class 1259 OID 14565253)
-- Name: sgf_agente_cobrador; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_agente_cobrador (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(100) NOT NULL
);
ALTER TABLE ONLY public.sgf_agente_cobrador ALTER COLUMN id_bas_empresa SET STATISTICS 0;


ALTER TABLE public.sgf_agente_cobrador OWNER TO postgres;

--
-- TOC entry 13083 (class 0 OID 0)
-- Dependencies: 1020
-- Name: TABLE sgf_agente_cobrador; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgf_agente_cobrador IS 'Cadastra os agentes cobradores do sistema';


--
-- TOC entry 13084 (class 0 OID 0)
-- Dependencies: 1020
-- Name: COLUMN sgf_agente_cobrador.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_agente_cobrador.id IS 'Identificador sequencial da tabela, chave primaria composta com o campo id_bas_empresa';


--
-- TOC entry 13085 (class 0 OID 0)
-- Dependencies: 1020
-- Name: COLUMN sgf_agente_cobrador.id_bas_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_agente_cobrador.id_bas_empresa IS 'Identificador da tabela bas_empresa, chave primaria composta com o campo id';


--
-- TOC entry 13086 (class 0 OID 0)
-- Dependencies: 1020
-- Name: COLUMN sgf_agente_cobrador.nome; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_agente_cobrador.nome IS 'Descrição do agente cobrador';


--
-- TOC entry 1021 (class 1259 OID 14565256)
-- Name: sgf_agente_cobrador_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_agente_cobrador_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_agente_cobrador_id_seq OWNER TO postgres;

--
-- TOC entry 13087 (class 0 OID 0)
-- Dependencies: 1021
-- Name: sgf_agente_cobrador_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_agente_cobrador_id_seq OWNED BY public.sgf_agente_cobrador.id;


--
-- TOC entry 1022 (class 1259 OID 14565258)
-- Name: sgf_banco; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_banco (
 id bigint NOT NULL,
 nome character varying(100) NOT NULL,
 codigo character(3) NOT NULL,
 logo bytea,
 local_pagamento character varying(200)
);


ALTER TABLE public.sgf_banco OWNER TO postgres;

--
-- TOC entry 13088 (class 0 OID 0)
-- Dependencies: 1022
-- Name: COLUMN sgf_banco.logo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_banco.logo IS 'logomarca do banco';


--
-- TOC entry 1023 (class 1259 OID 14565264)
-- Name: sgf_banco_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_banco_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_banco_id_seq OWNER TO postgres;

--
-- TOC entry 13089 (class 0 OID 0)
-- Dependencies: 1023
-- Name: sgf_banco_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_banco_id_seq OWNED BY public.sgf_banco.id;


--
-- TOC entry 1024 (class 1259 OID 14565266)
-- Name: sgf_boleto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_boleto (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_pessoa bigint,
 id_sgf_conta_bancaria bigint,
 nosso_numero character varying(20),
 codigo_barra character varying(44),
 linha_digitavel character varying(60),
 valor numeric(9,2),
 desconto numeric(9,2),
 data_vencimento date,
 juros numeric(9,4),
 multa numeric(9,4),
 login_lancamento character varying(32),
 datahora_lancamento timestamp without time zone,
 login_cancelamento character varying(32),
 datahora_cancelamento timestamp without time zone,
 id_bas_estabelecimento bigint NOT NULL
);


ALTER TABLE public.sgf_boleto OWNER TO postgres;

--
-- TOC entry 1025 (class 1259 OID 14565269)
-- Name: sgf_boleto_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_boleto_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_boleto_id_seq OWNER TO postgres;

--
-- TOC entry 13090 (class 0 OID 0)
-- Dependencies: 1025
-- Name: sgf_boleto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_boleto_id_seq OWNED BY public.sgf_boleto.id;


--
-- TOC entry 1026 (class 1259 OID 14565271)
-- Name: sgf_boleto_retorno; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_boleto_retorno (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sgf_conta_bancaria bigint,
 login character varying(32),
 numero_arquivo bigint,
 nome_arquivo character varying,
 data_geracao date,
 data_registro timestamp(0) without time zone
);


ALTER TABLE public.sgf_boleto_retorno OWNER TO postgres;

--
-- TOC entry 13091 (class 0 OID 0)
-- Dependencies: 1026
-- Name: COLUMN sgf_boleto_retorno.numero_arquivo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_boleto_retorno.numero_arquivo IS 'Numero sequencial do arquivo';


--
-- TOC entry 1027 (class 1259 OID 14565277)
-- Name: sgf_boleto_retorno_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_boleto_retorno_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_boleto_retorno_id_seq OWNER TO postgres;

--
-- TOC entry 13092 (class 0 OID 0)
-- Dependencies: 1027
-- Name: sgf_boleto_retorno_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_boleto_retorno_id_seq OWNED BY public.sgf_boleto_retorno.id;


--
-- TOC entry 1028 (class 1259 OID 14565279)
-- Name: sgf_boleto_retorno_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_boleto_retorno_item (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sgf_boleto_retorno bigint NOT NULL,
 id_sgf_banco bigint NOT NULL,
 id_sgf_ocorrencia_retorno_boleto bigint,
 id_sgf_boleto bigint,
 nosso_numero character varying(20),
 valor_pago numeric(15,2),
 encargos numeric(15,2),
 descontos numeric(15,2),
 tarifa numeric(15,2),
 numero_sequencial integer,
 data_vencimento date,
 data_ocorrencia date,
 data_credito date
);


ALTER TABLE public.sgf_boleto_retorno_item OWNER TO postgres;

--
-- TOC entry 13093 (class 0 OID 0)
-- Dependencies: 1028
-- Name: COLUMN sgf_boleto_retorno_item.numero_sequencial; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_boleto_retorno_item.numero_sequencial IS 'Numero sequencial do registro';


--
-- TOC entry 13094 (class 0 OID 0)
-- Dependencies: 1028
-- Name: COLUMN sgf_boleto_retorno_item.data_ocorrencia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_boleto_retorno_item.data_ocorrencia IS 'data da baixa';


--
-- TOC entry 1029 (class 1259 OID 14565282)
-- Name: sgf_boleto_retorno_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_boleto_retorno_item_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_boleto_retorno_item_id_seq OWNER TO postgres;

--
-- TOC entry 13095 (class 0 OID 0)
-- Dependencies: 1029
-- Name: sgf_boleto_retorno_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_boleto_retorno_item_id_seq OWNED BY public.sgf_boleto_retorno_item.id;


--
-- TOC entry 1030 (class 1259 OID 14565284)
-- Name: sgf_boleto_titulo_receber; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_boleto_titulo_receber (
 id_bas_empresa bigint NOT NULL,
 id_sgf_boleto bigint NOT NULL,
 id_sgf_titulo_receber bigint NOT NULL
);


ALTER TABLE public.sgf_boleto_titulo_receber OWNER TO postgres;

--
-- TOC entry 1031 (class 1259 OID 14565287)
-- Name: sgf_caixa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_caixa (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_estabelecimento bigint NOT NULL,
 id_sgf_operador bigint NOT NULL,
 login character varying(32),
 data date,
 hora_abertura time without time zone,
 hora_fechamento time without time zone,
 hora_reabertura time without time zone,
 hora_refechamento time without time zone,
 saldo_inicial numeric(9,2),
 saldo_final numeric(9,2),
 saldo_din numeric(9,2),
 saldo_chq numeric(9,2),
 saldo_crt numeric(9,2),
 saldo_outra numeric(9,2),
 saldo_din_diferenca numeric(9,2)
);


ALTER TABLE public.sgf_caixa OWNER TO postgres;

--
-- TOC entry 1032 (class 1259 OID 14565290)
-- Name: sgf_caixa_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_caixa_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_caixa_id_seq OWNER TO postgres;

--
-- TOC entry 13096 (class 0 OID 0)
-- Dependencies: 1032
-- Name: sgf_caixa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_caixa_id_seq OWNED BY public.sgf_caixa.id;


--
-- TOC entry 1033 (class 1259 OID 14565292)
-- Name: sgf_caixa_sangria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_caixa_sangria (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sgf_caixa bigint NOT NULL,
 hora time without time zone,
 dinheiro numeric(9,2),
 cheque numeric(9,2),
 cartao numeric(9,2),
 nota_promissoria numeric(9,2),
 observacao character varying(200),
 data date
);


ALTER TABLE public.sgf_caixa_sangria OWNER TO postgres;

--
-- TOC entry 1034 (class 1259 OID 14565295)
-- Name: sgf_caixa_sangria_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_caixa_sangria_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_caixa_sangria_id_seq OWNER TO postgres;

--
-- TOC entry 13097 (class 0 OID 0)
-- Dependencies: 1034
-- Name: sgf_caixa_sangria_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_caixa_sangria_id_seq OWNED BY public.sgf_caixa_sangria.id;


SET default_with_oids = true;

--
-- TOC entry 1035 (class 1259 OID 14565297)
-- Name: sgf_caixa_suprimento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_caixa_suprimento (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sgf_caixa bigint NOT NULL,
 hora time without time zone,
 valor numeric(9,2),
 datareg timestamp without time zone
);


ALTER TABLE public.sgf_caixa_suprimento OWNER TO postgres;

--
-- TOC entry 1036 (class 1259 OID 14565300)
-- Name: sgf_caixa_suprimento_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_caixa_suprimento_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_caixa_suprimento_id_seq OWNER TO postgres;

--
-- TOC entry 13098 (class 0 OID 0)
-- Dependencies: 1036
-- Name: sgf_caixa_suprimento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_caixa_suprimento_id_seq OWNED BY public.sgf_caixa_suprimento.id;


SET default_with_oids = false;

--
-- TOC entry 1037 (class 1259 OID 14565302)
-- Name: sgf_cartao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_cartao (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_estabelecimento bigint,
 id_sgf_conta_bancaria bigint,
 id_sgf_plano_conta_credito bigint,
 id_sgf_plano_conta_debito bigint,
 bandeira character varying(50),
 tipo character(1),
 taxa numeric(9,2),
 dia_repasse smallint
);


ALTER TABLE public.sgf_cartao OWNER TO postgres;

--
-- TOC entry 13099 (class 0 OID 0)
-- Dependencies: 1037
-- Name: COLUMN sgf_cartao.tipo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_cartao.tipo IS 'D = Débito, C = Crédito';


--
-- TOC entry 1038 (class 1259 OID 14565305)
-- Name: sgf_cartao_credito; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_cartao_credito (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_estabelecimento bigint NOT NULL,
 id_sgf_plano_conta_credito bigint,
 id_sgf_plano_conta_debito bigint,
 bandeira character varying(100) NOT NULL,
 dia_credito integer NOT NULL,
 taxa_administracao numeric(5,2) NOT NULL
);


ALTER TABLE public.sgf_cartao_credito OWNER TO postgres;

--
-- TOC entry 1039 (class 1259 OID 14565308)
-- Name: sgf_cartao_credito_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_cartao_credito_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_cartao_credito_id_seq OWNER TO postgres;

--
-- TOC entry 13100 (class 0 OID 0)
-- Dependencies: 1039
-- Name: sgf_cartao_credito_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_cartao_credito_id_seq OWNED BY public.sgf_cartao_credito.id;


--
-- TOC entry 1040 (class 1259 OID 14565310)
-- Name: sgf_cartao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_cartao_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_cartao_id_seq OWNER TO postgres;

--
-- TOC entry 13101 (class 0 OID 0)
-- Dependencies: 1040
-- Name: sgf_cartao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_cartao_id_seq OWNED BY public.sgf_cartao.id;


--
-- TOC entry 1041 (class 1259 OID 14565312)
-- Name: sgf_cartao_repasse; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_cartao_repasse (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_estabelecimento bigint,
 id_sgf_cartao bigint,
 id_sgf_conta_bancaria bigint,
 tipo character(1),
 data date,
 data_referencia date,
 valor numeric(9,2),
 tarifa numeric(5,2),
 valor_taxa numeric(9,2),
 data_registro timestamp without time zone,
 login character varying(32)
);


ALTER TABLE public.sgf_cartao_repasse OWNER TO postgres;

--
-- TOC entry 13102 (class 0 OID 0)
-- Dependencies: 1041
-- Name: COLUMN sgf_cartao_repasse.tipo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_cartao_repasse.tipo IS 'A = Antecipação, N = Normal';


--
-- TOC entry 1042 (class 1259 OID 14565315)
-- Name: sgf_cartao_repasse_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_cartao_repasse_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_cartao_repasse_id_seq OWNER TO postgres;

--
-- TOC entry 13103 (class 0 OID 0)
-- Dependencies: 1042
-- Name: sgf_cartao_repasse_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_cartao_repasse_id_seq OWNED BY public.sgf_cartao_repasse.id;


--
-- TOC entry 1043 (class 1259 OID 14565317)
-- Name: sgf_compromisso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_compromisso (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_fornecedor bigint,
 login character varying(32) NOT NULL,
 id_bas_estabelecimento bigint,
 login_cancelamento character varying(32),
 data date,
 valor numeric(9,2),
 parcelas integer,
 juros numeric(9,4),
 multa numeric(9,4),
 vencimento_inicial date,
 descricao character varying(100),
 numero_doc character varying(20),
 data_doc date,
 data_cancelamento date,
 data_reg date,
 aviso_dias integer,
 ano integer,
 situacao integer,
 id_sgf_plano_conta_credito bigint,
 id_sgf_plano_conta_debito bigint,
 valor_bruto numeric(9,2),
 serie_nf character varying(20),
 icms numeric(9,2),
 icms_sub numeric(9,2),
 frete numeric(9,2),
 seguro numeric(9,2),
 desconto numeric(9,2),
 ipi numeric(9,2),
 iss numeric(9,2),
 iss_ret numeric(9,2),
 id_bas_centro_custo bigint,
 id_sgf_tipo_compromisso bigint,
 id_sgf_tipo_doc_cobranca bigint
);


ALTER TABLE public.sgf_compromisso OWNER TO postgres;

--
-- TOC entry 1044 (class 1259 OID 14565320)
-- Name: sgf_compromisso_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_compromisso_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_compromisso_id_seq OWNER TO postgres;

--
-- TOC entry 13104 (class 0 OID 0)
-- Dependencies: 1044
-- Name: sgf_compromisso_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_compromisso_id_seq OWNED BY public.sgf_compromisso.id;


--
-- TOC entry 1045 (class 1259 OID 14565322)
-- Name: sgf_configuracao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_configuracao (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sgf_tipo_titulo_receber_mensalidade bigint
);


ALTER TABLE public.sgf_configuracao OWNER TO postgres;

--
-- TOC entry 1046 (class 1259 OID 14565325)
-- Name: sgf_configuracao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_configuracao_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_configuracao_id_seq OWNER TO postgres;

--
-- TOC entry 13105 (class 0 OID 0)
-- Dependencies: 1046
-- Name: sgf_configuracao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_configuracao_id_seq OWNED BY public.sgf_configuracao.id;


--
-- TOC entry 1047 (class 1259 OID 14565327)
-- Name: sgf_conta_bancaria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_conta_bancaria (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sgf_banco bigint NOT NULL,
 id_sgf_plano_conta bigint,
 agencia character varying(7) NOT NULL,
 agencia_dv character varying(2) NOT NULL,
 endereco_agencia character varying(100),
 contato character varying(50),
 telefone_agencia character varying(11),
 numero_conta character varying(20) NOT NULL,
 numero_conta_dv character varying(2) NOT NULL,
 data_abertura date,
 data_encerramento date,
 nome character varying(50),
 operacao character varying(6),
 debito_conta character(1),
 proximo_cheque integer,
 ano integer,
 moeda integer DEFAULT 9,
 cedente_nome character varying(50),
 cedente_numero character varying(50),
 cedente_dv character varying(2),
 carteira character varying(6),
 convenio character varying(20),
 cobranca character varying(10),
 nosso_numero_atual character varying(20),
 fator_vencimento character(1),
 cobranca_registrada character(1),
 mensagem_boleto character varying(255),
 id_sgf_tipo_conta_bancaria bigint,
 id_sgf_layout_boleto bigint,
 pagamento character(1),
 boleto character(1)
);


ALTER TABLE public.sgf_conta_bancaria OWNER TO postgres;

--
-- TOC entry 13106 (class 0 OID 0)
-- Dependencies: 1047
-- Name: COLUMN sgf_conta_bancaria.debito_conta; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_conta_bancaria.debito_conta IS 'S=sim ou N=nao';


--
-- TOC entry 13107 (class 0 OID 0)
-- Dependencies: 1047
-- Name: COLUMN sgf_conta_bancaria.ano; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_conta_bancaria.ano IS 'ano de criacao';


--
-- TOC entry 13108 (class 0 OID 0)
-- Dependencies: 1047
-- Name: COLUMN sgf_conta_bancaria.fator_vencimento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_conta_bancaria.fator_vencimento IS 'S=sim ou N=nao';


--
-- TOC entry 13109 (class 0 OID 0)
-- Dependencies: 1047
-- Name: COLUMN sgf_conta_bancaria.cobranca_registrada; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_conta_bancaria.cobranca_registrada IS 'S=sim ou N=nao';


--
-- TOC entry 13110 (class 0 OID 0)
-- Dependencies: 1047
-- Name: COLUMN sgf_conta_bancaria.pagamento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_conta_bancaria.pagamento IS 'S = sim, N = Não, indicativo se permite debito em conta(pagamento online)';


--
-- TOC entry 13111 (class 0 OID 0)
-- Dependencies: 1047
-- Name: COLUMN sgf_conta_bancaria.boleto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_conta_bancaria.boleto IS 'S = sim, N = Não, indicativo se gera boleto';


--
-- TOC entry 1048 (class 1259 OID 14565334)
-- Name: sgf_conta_corrente_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_conta_corrente_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_conta_corrente_id_seq OWNER TO postgres;

--
-- TOC entry 13112 (class 0 OID 0)
-- Dependencies: 1048
-- Name: sgf_conta_corrente_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_conta_corrente_id_seq OWNED BY public.sgf_conta_bancaria.id;


--
-- TOC entry 1049 (class 1259 OID 14565336)
-- Name: sgf_desconto_tipo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_desconto_tipo (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(100) NOT NULL,
 data_cancelamento date,
 tipo_bolsista character(1),
 diferenciado character(1)
);


ALTER TABLE public.sgf_desconto_tipo OWNER TO postgres;

--
-- TOC entry 13113 (class 0 OID 0)
-- Dependencies: 1049
-- Name: COLUMN sgf_desconto_tipo.tipo_bolsista; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_desconto_tipo.tipo_bolsista IS 'S=sim e N=não';


--
-- TOC entry 13114 (class 0 OID 0)
-- Dependencies: 1049
-- Name: COLUMN sgf_desconto_tipo.diferenciado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_desconto_tipo.diferenciado IS 'S = Sim (Diferenciado), N = Não (Normal)';


--
-- TOC entry 1050 (class 1259 OID 14565339)
-- Name: sgf_desconto_tipo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_desconto_tipo_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_desconto_tipo_id_seq OWNER TO postgres;

--
-- TOC entry 13115 (class 0 OID 0)
-- Dependencies: 1050
-- Name: sgf_desconto_tipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_desconto_tipo_id_seq OWNED BY public.sgf_desconto_tipo.id;


--
-- TOC entry 1051 (class 1259 OID 14565341)
-- Name: sgf_item_servico; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_item_servico (
 id bigint NOT NULL,
 codigo character varying(8),
 nome character varying(500)
);


ALTER TABLE public.sgf_item_servico OWNER TO postgres;

--
-- TOC entry 1052 (class 1259 OID 14565347)
-- Name: sgf_item_servico_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_item_servico_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_item_servico_id_seq OWNER TO postgres;

--
-- TOC entry 13116 (class 0 OID 0)
-- Dependencies: 1052
-- Name: sgf_item_servico_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_item_servico_id_seq OWNED BY public.sgf_item_servico.id;


--
-- TOC entry 1053 (class 1259 OID 14565349)
-- Name: sgf_layout_boleto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_layout_boleto (
 id bigint NOT NULL,
 id_sgf_banco bigint NOT NULL,
 nome character varying(100) NOT NULL,
 ativo character(1) DEFAULT 'S'::bpchar NOT NULL,
 funcao_boleto_php character varying(25) NOT NULL,
 layout_boleto_php character varying(25) NOT NULL
);


ALTER TABLE public.sgf_layout_boleto OWNER TO postgres;

--
-- TOC entry 13117 (class 0 OID 0)
-- Dependencies: 1053
-- Name: COLUMN sgf_layout_boleto.ativo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_layout_boleto.ativo IS 'S = Sim, N - Não';


--
-- TOC entry 13118 (class 0 OID 0)
-- Dependencies: 1053
-- Name: COLUMN sgf_layout_boleto.funcao_boleto_php; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_layout_boleto.funcao_boleto_php IS 'Nome da função a ser chamada pelo boleto php';


--
-- TOC entry 1054 (class 1259 OID 14565353)
-- Name: sgf_layout_boleto_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_layout_boleto_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_layout_boleto_id_seq OWNER TO postgres;

--
-- TOC entry 13119 (class 0 OID 0)
-- Dependencies: 1054
-- Name: sgf_layout_boleto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_layout_boleto_id_seq OWNED BY public.sgf_layout_boleto.id;


--
-- TOC entry 1055 (class 1259 OID 14565355)
-- Name: sgf_material_subgrupo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_material_subgrupo_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_material_subgrupo_id_seq OWNER TO postgres;

--
-- TOC entry 13120 (class 0 OID 0)
-- Dependencies: 1055
-- Name: sgf_material_subgrupo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_material_subgrupo_id_seq OWNED BY public.sga_material_subgrupo.id;


--
-- TOC entry 1056 (class 1259 OID 14565357)
-- Name: sgf_motivo_inconsistencia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_motivo_inconsistencia (
 id bigint NOT NULL,
 nome character varying(100) NOT NULL
);


ALTER TABLE public.sgf_motivo_inconsistencia OWNER TO postgres;

--
-- TOC entry 1057 (class 1259 OID 14565360)
-- Name: sgf_motivo_inconsistencia_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_motivo_inconsistencia_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_motivo_inconsistencia_id_seq OWNER TO postgres;

--
-- TOC entry 13121 (class 0 OID 0)
-- Dependencies: 1057
-- Name: sgf_motivo_inconsistencia_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_motivo_inconsistencia_id_seq OWNED BY public.sgf_motivo_inconsistencia.id;


--
-- TOC entry 1058 (class 1259 OID 14565362)
-- Name: sgf_nfse_curso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_nfse_curso (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 cnae character varying(10),
 nome_cnae character varying(100),
 aliquota numeric(4,2),
 iss_retido character(1),
 percentual_iss_retido numeric(4,2),
 tributacao numeric(4,2),
 codigo_tributario character varying(20)
);


ALTER TABLE public.sgf_nfse_curso OWNER TO postgres;

--
-- TOC entry 1059 (class 1259 OID 14565365)
-- Name: sgf_nfse_curso_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_nfse_curso_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_nfse_curso_id_seq OWNER TO postgres;

--
-- TOC entry 13122 (class 0 OID 0)
-- Dependencies: 1059
-- Name: sgf_nfse_curso_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_nfse_curso_id_seq OWNED BY public.sgf_nfse_curso.id;


--
-- TOC entry 1060 (class 1259 OID 14565367)
-- Name: sgf_nfse_estabelecimento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_nfse_estabelecimento (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sgf_nfse_url bigint,
 id_sgf_item_servico bigint,
 repositorio_certificado_digital character varying(100),
 certificado_digital character varying(100),
 simples character(1),
 incentivador_cultural character(1),
 percentual_deducoes numeric(4,2),
 percentual_pis numeric(4,2),
 percentual_cofins numeric(4,2),
 percentual_ir numeric(4,2),
 percentual_csll numeric(4,2),
 percentual_outras_retencoes numeric(4,2),
 rps_serie character(1),
 rps_inicial integer,
 rps_final integer,
 rps_validade date,
 sigla_estabelecimento character varying(8),
 nfse_producao character(1),
 cnae character varying(10),
 nome_cnae character varying(100),
 aliquota numeric(4,2),
 iss_retido character(1),
 percentual_iss_retido numeric(4,2),
 tributacao numeric(4,2),
 codigo_tributario character varying(26)
);


ALTER TABLE public.sgf_nfse_estabelecimento OWNER TO postgres;

--
-- TOC entry 13123 (class 0 OID 0)
-- Dependencies: 1060
-- Name: COLUMN sgf_nfse_estabelecimento.id_sgf_nfse_url; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_nfse_estabelecimento.id_sgf_nfse_url IS 'URLs para NFS-e Municipal';


--
-- TOC entry 1061 (class 1259 OID 14565370)
-- Name: sgf_nfse_estabelecimento_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_nfse_estabelecimento_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_nfse_estabelecimento_id_seq OWNER TO postgres;

--
-- TOC entry 13124 (class 0 OID 0)
-- Dependencies: 1061
-- Name: sgf_nfse_estabelecimento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_nfse_estabelecimento_id_seq OWNED BY public.sgf_nfse_estabelecimento.id;


--
-- TOC entry 1062 (class 1259 OID 14565372)
-- Name: sgf_nfse_url; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_nfse_url (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 codigo_ibge integer NOT NULL,
 nome_municipio character varying(100) NOT NULL,
 url_envioloterps character varying(255) NOT NULL,
 url_consultarloterps character varying(255),
 url_consultarsituacaoloterps character varying(255),
 url_consultanfse character varying(255),
 url_consultanfserps character varying(255),
 url_consultasituacaonfse character varying(255),
 url_schema character varying(255)
);
ALTER TABLE ONLY public.sgf_nfse_url ALTER COLUMN id_bas_empresa SET STATISTICS 0;


ALTER TABLE public.sgf_nfse_url OWNER TO postgres;

--
-- TOC entry 1063 (class 1259 OID 14565378)
-- Name: sgf_nfse_url_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_nfse_url_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_nfse_url_id_seq OWNER TO postgres;

--
-- TOC entry 13125 (class 0 OID 0)
-- Dependencies: 1063
-- Name: sgf_nfse_url_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_nfse_url_id_seq OWNED BY public.sgf_nfse_url.id;


--
-- TOC entry 1064 (class 1259 OID 14565380)
-- Name: sgf_ocorrencia_cheque; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_ocorrencia_cheque (
 id bigint NOT NULL,
 codigo character(3) NOT NULL,
 descricao character varying(100),
 ativo character(1)
);


ALTER TABLE public.sgf_ocorrencia_cheque OWNER TO postgres;

--
-- TOC entry 1065 (class 1259 OID 14565383)
-- Name: sgf_ocorrencia_cheque_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_ocorrencia_cheque_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_ocorrencia_cheque_id_seq OWNER TO postgres;

--
-- TOC entry 13126 (class 0 OID 0)
-- Dependencies: 1065
-- Name: sgf_ocorrencia_cheque_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_ocorrencia_cheque_id_seq OWNED BY public.sgf_ocorrencia_cheque.id;


--
-- TOC entry 1066 (class 1259 OID 14565385)
-- Name: sgf_ocorrencia_remessa_boleto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_ocorrencia_remessa_boleto (
 id bigint NOT NULL,
 id_sgf_banco bigint NOT NULL,
 codigo character varying(20) NOT NULL,
 descricao character varying(100) NOT NULL
);


ALTER TABLE public.sgf_ocorrencia_remessa_boleto OWNER TO postgres;

--
-- TOC entry 1067 (class 1259 OID 14565388)
-- Name: sgf_ocorrencia_remessa_boleto_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_ocorrencia_remessa_boleto_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_ocorrencia_remessa_boleto_id_seq OWNER TO postgres;

--
-- TOC entry 13127 (class 0 OID 0)
-- Dependencies: 1067
-- Name: sgf_ocorrencia_remessa_boleto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_ocorrencia_remessa_boleto_id_seq OWNED BY public.sgf_ocorrencia_remessa_boleto.id;


--
-- TOC entry 1068 (class 1259 OID 14565390)
-- Name: sgf_ocorrencia_retorno_boleto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_ocorrencia_retorno_boleto (
 id bigint NOT NULL,
 id_sgf_banco bigint NOT NULL,
 descricao character varying(100) NOT NULL,
 codigo smallint NOT NULL
);


ALTER TABLE public.sgf_ocorrencia_retorno_boleto OWNER TO postgres;

--
-- TOC entry 1069 (class 1259 OID 14565393)
-- Name: sgf_ocorrencia_retorno_boleto_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_ocorrencia_retorno_boleto_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_ocorrencia_retorno_boleto_id_seq OWNER TO postgres;

--
-- TOC entry 13128 (class 0 OID 0)
-- Dependencies: 1069
-- Name: sgf_ocorrencia_retorno_boleto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_ocorrencia_retorno_boleto_id_seq OWNED BY public.sgf_ocorrencia_retorno_boleto.id;


--
-- TOC entry 1070 (class 1259 OID 14565395)
-- Name: sgf_operador; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_operador (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_estabelecimento bigint NOT NULL,
 id_bas_colaborador bigint,
 ativo character(1),
 supervisor character(1)
);


ALTER TABLE public.sgf_operador OWNER TO postgres;

--
-- TOC entry 13129 (class 0 OID 0)
-- Dependencies: 1070
-- Name: COLUMN sgf_operador.ativo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_operador.ativo IS 'S = Sim, N = Não';


--
-- TOC entry 13130 (class 0 OID 0)
-- Dependencies: 1070
-- Name: COLUMN sgf_operador.supervisor; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_operador.supervisor IS 'S = Sim, N = Não';


--
-- TOC entry 1071 (class 1259 OID 14565398)
-- Name: sgf_operador_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_operador_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_operador_id_seq OWNER TO postgres;

--
-- TOC entry 13131 (class 0 OID 0)
-- Dependencies: 1071
-- Name: sgf_operador_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_operador_id_seq OWNED BY public.sgf_operador.id;


--
-- TOC entry 1072 (class 1259 OID 14565400)
-- Name: sgf_operador_regime; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_operador_regime (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sgf_operador bigint,
 dia smallint,
 hora_inicio time without time zone,
 hora_fim time without time zone,
 ativo character(1)
);


ALTER TABLE public.sgf_operador_regime OWNER TO postgres;

--
-- TOC entry 13132 (class 0 OID 0)
-- Dependencies: 1072
-- Name: COLUMN sgf_operador_regime.dia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_operador_regime.dia IS '1 = Segunda, 2 = Terça, 3 = Quarta... 7 = Domingo';


--
-- TOC entry 13133 (class 0 OID 0)
-- Dependencies: 1072
-- Name: COLUMN sgf_operador_regime.ativo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_operador_regime.ativo IS 'S = sim, N = não';


--
-- TOC entry 1073 (class 1259 OID 14565403)
-- Name: sgf_operador_regime_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_operador_regime_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_operador_regime_id_seq OWNER TO postgres;

--
-- TOC entry 13134 (class 0 OID 0)
-- Dependencies: 1073
-- Name: sgf_operador_regime_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_operador_regime_id_seq OWNED BY public.sgf_operador_regime.id;


--
-- TOC entry 1074 (class 1259 OID 14565405)
-- Name: sgf_pagamento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_pagamento (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 login character varying(32) NOT NULL,
 id_sgf_caixa bigint,
 data date,
 hora time without time zone,
 desconto numeric(9,2),
 observacao character varying(200),
 login_cancelamento character varying(32),
 cancelamento_data date,
 cancelamento_motivo character varying(200),
 auditoria_data date,
 login_auditoria character varying(32),
 auditoria_status character(1),
 finalizado character(1),
 numero_pagamento bigint
);


ALTER TABLE public.sgf_pagamento OWNER TO postgres;

--
-- TOC entry 13135 (class 0 OID 0)
-- Dependencies: 1074
-- Name: COLUMN sgf_pagamento.auditoria_status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_pagamento.auditoria_status IS 'A=Auditado, R=Rejeitado';


--
-- TOC entry 13136 (class 0 OID 0)
-- Dependencies: 1074
-- Name: COLUMN sgf_pagamento.finalizado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_pagamento.finalizado IS 'S = Sim, N = Não';


--
-- TOC entry 1075 (class 1259 OID 14565411)
-- Name: sgf_pagamento_cartao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_pagamento_cartao (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sgf_cartao bigint,
 id_sgf_pagamento bigint,
 valor numeric(9,2),
 autorizacao character varying(50),
 parcelas smallint
);


ALTER TABLE public.sgf_pagamento_cartao OWNER TO postgres;

--
-- TOC entry 1076 (class 1259 OID 14565414)
-- Name: sgf_pagamento_cartao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_pagamento_cartao_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_pagamento_cartao_id_seq OWNER TO postgres;

--
-- TOC entry 13137 (class 0 OID 0)
-- Dependencies: 1076
-- Name: sgf_pagamento_cartao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_pagamento_cartao_id_seq OWNED BY public.sgf_pagamento_cartao.id;


--
-- TOC entry 1077 (class 1259 OID 14565416)
-- Name: sgf_pagamento_cheque; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_pagamento_cheque (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sgf_pagamento bigint NOT NULL,
 id_sgf_ocorrencia_cheque bigint,
 id_sgf_conciliacao bigint,
 numero character varying(10),
 serie character varying(10),
 data date,
 id_sgf_conta_bancaria bigint,
 beneficiario character varying(100),
 valor numeric(9,2)
);


ALTER TABLE public.sgf_pagamento_cheque OWNER TO postgres;

--
-- TOC entry 1078 (class 1259 OID 14565419)
-- Name: sgf_pagamento_cheque_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_pagamento_cheque_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_pagamento_cheque_id_seq OWNER TO postgres;

--
-- TOC entry 13138 (class 0 OID 0)
-- Dependencies: 1078
-- Name: sgf_pagamento_cheque_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_pagamento_cheque_id_seq OWNED BY public.sgf_pagamento_cheque.id;


--
-- TOC entry 1079 (class 1259 OID 14565421)
-- Name: sgf_pagamento_cheque_ocorrencia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_pagamento_cheque_ocorrencia (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sgf_ocorrencia_cheque bigint,
 id_sgf_pagamento_cheque bigint,
 login character varying(32),
 data_ocorrencia date,
 data_registro timestamp without time zone
);


ALTER TABLE public.sgf_pagamento_cheque_ocorrencia OWNER TO postgres;

--
-- TOC entry 1080 (class 1259 OID 14565424)
-- Name: sgf_pagamento_cheque_ocorrencia_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_pagamento_cheque_ocorrencia_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_pagamento_cheque_ocorrencia_id_seq OWNER TO postgres;

--
-- TOC entry 13139 (class 0 OID 0)
-- Dependencies: 1080
-- Name: sgf_pagamento_cheque_ocorrencia_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_pagamento_cheque_ocorrencia_id_seq OWNED BY public.sgf_pagamento_cheque_ocorrencia.id;


--
-- TOC entry 1081 (class 1259 OID 14565426)
-- Name: sgf_pagamento_dinheiro; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_pagamento_dinheiro (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sgf_pagamento bigint,
 valor numeric(9,2),
 id_sgf_conta_bancaria bigint,
 id_sgf_conciliacao bigint
);


ALTER TABLE public.sgf_pagamento_dinheiro OWNER TO postgres;

--
-- TOC entry 1082 (class 1259 OID 14565429)
-- Name: sgf_pagamento_dinheiro_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_pagamento_dinheiro_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_pagamento_dinheiro_id_seq OWNER TO postgres;

--
-- TOC entry 13140 (class 0 OID 0)
-- Dependencies: 1082
-- Name: sgf_pagamento_dinheiro_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_pagamento_dinheiro_id_seq OWNED BY public.sgf_pagamento_dinheiro.id;


--
-- TOC entry 1083 (class 1259 OID 14565431)
-- Name: sgf_pagamento_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_pagamento_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_pagamento_id_seq OWNER TO postgres;

--
-- TOC entry 13141 (class 0 OID 0)
-- Dependencies: 1083
-- Name: sgf_pagamento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_pagamento_id_seq OWNED BY public.sgf_pagamento.id;


--
-- TOC entry 1084 (class 1259 OID 14565433)
-- Name: sgf_plano_conta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_plano_conta (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 codigo character varying(30) NOT NULL,
 nome character varying(100) NOT NULL,
 categoria integer NOT NULL,
 status character(1) NOT NULL,
 conta_contabil_terceiro character varying(30),
 id_sgf_plano_conta bigint,
 data_criacao timestamp(0) without time zone
);


ALTER TABLE public.sgf_plano_conta OWNER TO postgres;

--
-- TOC entry 13142 (class 0 OID 0)
-- Dependencies: 1084
-- Name: COLUMN sgf_plano_conta.categoria; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_plano_conta.categoria IS '1=Ativo, 2=Passivo, 3=Receita, 4=Despesa';


--
-- TOC entry 13143 (class 0 OID 0)
-- Dependencies: 1084
-- Name: COLUMN sgf_plano_conta.status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_plano_conta.status IS 'A=Agrupamento D=Devedor C=Credor';


--
-- TOC entry 13144 (class 0 OID 0)
-- Dependencies: 1084
-- Name: COLUMN sgf_plano_conta.id_sgf_plano_conta; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_plano_conta.id_sgf_plano_conta IS 'Conta contabil Pai';


--
-- TOC entry 1085 (class 1259 OID 14565436)
-- Name: sgf_plano_conta_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_plano_conta_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_plano_conta_id_seq OWNER TO postgres;

--
-- TOC entry 13145 (class 0 OID 0)
-- Dependencies: 1085
-- Name: sgf_plano_conta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_plano_conta_id_seq OWNED BY public.sgf_plano_conta.id;


--
-- TOC entry 1086 (class 1259 OID 14565438)
-- Name: sgf_plano_pagamento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_plano_pagamento (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(100) NOT NULL,
 ano integer NOT NULL,
 data_cancelamento date
);


ALTER TABLE public.sgf_plano_pagamento OWNER TO postgres;

--
-- TOC entry 1087 (class 1259 OID 14565441)
-- Name: sgf_plano_pagamento_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_plano_pagamento_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_plano_pagamento_id_seq OWNER TO postgres;

--
-- TOC entry 13146 (class 0 OID 0)
-- Dependencies: 1087
-- Name: sgf_plano_pagamento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_plano_pagamento_id_seq OWNED BY public.sgf_plano_pagamento.id;


--
-- TOC entry 1088 (class 1259 OID 14565443)
-- Name: sgf_plano_pagamento_parcela; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_plano_pagamento_parcela (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sgf_plano_pagamento bigint NOT NULL,
 numero_parcela smallint NOT NULL,
 valor numeric(9,2) NOT NULL
);


ALTER TABLE public.sgf_plano_pagamento_parcela OWNER TO postgres;

--
-- TOC entry 1089 (class 1259 OID 14565446)
-- Name: sgf_plano_pagamento_parcela_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_plano_pagamento_parcela_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_plano_pagamento_parcela_id_seq OWNER TO postgres;

--
-- TOC entry 13147 (class 0 OID 0)
-- Dependencies: 1089
-- Name: sgf_plano_pagamento_parcela_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_plano_pagamento_parcela_id_seq OWNED BY public.sgf_plano_pagamento_parcela.id;


--
-- TOC entry 1090 (class 1259 OID 14565448)
-- Name: sgf_recebimento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_recebimento (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sgf_caixa bigint,
 login character varying(32) NOT NULL,
 desconto numeric(9,3),
 data timestamp without time zone,
 desconto_motivo character varying(100),
 observacao character varying(200),
 data_registro timestamp without time zone,
 cancelamento_data timestamp without time zone,
 cancelamento_login character varying(32),
 cancelamento_motivo character varying(200),
 data_credito date,
 finalizado character(1)
);


ALTER TABLE public.sgf_recebimento OWNER TO postgres;

--
-- TOC entry 13148 (class 0 OID 0)
-- Dependencies: 1090
-- Name: COLUMN sgf_recebimento.finalizado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_recebimento.finalizado IS 'N = Não, S = Sim';


--
-- TOC entry 1091 (class 1259 OID 14565454)
-- Name: sgf_recebimento_boleto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_recebimento_boleto (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sgf_recebimento bigint,
 id_sgf_conta_bancaria bigint,
 id_sgf_motivo_inconsistencia bigint,
 login_inconsistencia character varying(32),
 valor numeric(9,2),
 numero_sequencial_arquivo integer,
 numero_sequencial_registro integer,
 nosso_numero character varying(20),
 caminho_arquivo character varying(200),
 data_arquivo date,
 inconsistencia character(1),
 inconsistencia_data_solucao date,
 inconsistencia_obs character varying(200)
);


ALTER TABLE public.sgf_recebimento_boleto OWNER TO postgres;

--
-- TOC entry 13149 (class 0 OID 0)
-- Dependencies: 1091
-- Name: COLUMN sgf_recebimento_boleto.inconsistencia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_recebimento_boleto.inconsistencia IS 'S = sim, N = não';


--
-- TOC entry 1092 (class 1259 OID 14565457)
-- Name: sgf_recebimento_boleto_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_recebimento_boleto_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_recebimento_boleto_id_seq OWNER TO postgres;

--
-- TOC entry 13150 (class 0 OID 0)
-- Dependencies: 1092
-- Name: sgf_recebimento_boleto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_recebimento_boleto_id_seq OWNED BY public.sgf_recebimento_boleto.id;


--
-- TOC entry 1093 (class 1259 OID 14565459)
-- Name: sgf_recebimento_cartao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_recebimento_cartao (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sgf_cartao bigint,
 id_sgf_recebimento bigint,
 valor numeric(9,2),
 parcela smallint,
 autorizado character(1),
 cartao_auto character varying(50)
);


ALTER TABLE public.sgf_recebimento_cartao OWNER TO postgres;

--
-- TOC entry 13151 (class 0 OID 0)
-- Dependencies: 1093
-- Name: COLUMN sgf_recebimento_cartao.autorizado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_recebimento_cartao.autorizado IS 'S = Sim, N = Não';


--
-- TOC entry 1094 (class 1259 OID 14565462)
-- Name: sgf_recebimento_cartao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_recebimento_cartao_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_recebimento_cartao_id_seq OWNER TO postgres;

--
-- TOC entry 13152 (class 0 OID 0)
-- Dependencies: 1094
-- Name: sgf_recebimento_cartao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_recebimento_cartao_id_seq OWNED BY public.sgf_recebimento_cartao.id;


--
-- TOC entry 1095 (class 1259 OID 14565464)
-- Name: sgf_recebimento_cartao_parcela; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_recebimento_cartao_parcela (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sgf_recebimento_cartao bigint,
 parcela smallint,
 valor numeric,
 data_repasse date
);


ALTER TABLE public.sgf_recebimento_cartao_parcela OWNER TO postgres;

--
-- TOC entry 1096 (class 1259 OID 14565470)
-- Name: sgf_recebimento_cartao_parcela_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_recebimento_cartao_parcela_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_recebimento_cartao_parcela_id_seq OWNER TO postgres;

--
-- TOC entry 13153 (class 0 OID 0)
-- Dependencies: 1096
-- Name: sgf_recebimento_cartao_parcela_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_recebimento_cartao_parcela_id_seq OWNED BY public.sgf_recebimento_cartao_parcela.id;


--
-- TOC entry 1097 (class 1259 OID 14565472)
-- Name: sgf_recebimento_cheque; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_recebimento_cheque (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_estabelecimento bigint,
 id_sgf_banco bigint,
 id_sgf_recebimento bigint,
 id_bas_pessoa bigint,
 id_sgf_ocorrencia_cheque bigint,
 id_sgf_protesto bigint,
 id_sgf_conta_bancaria bigint,
 id_sgf_titulo_receber bigint,
 id_sge_departamento bigint,
 numero character varying(32),
 agencia character varying(7),
 conta character varying(20),
 nome character varying(100),
 data date,
 cpf_cnpj character varying(14),
 telefone character varying(20),
 tipo_cheque character(1),
 terceiro character(1) DEFAULT 'N'::bpchar,
 data_credito date,
 conferido character(1),
 valor numeric(9,2) NOT NULL,
 id_sgf_agente_cobrador bigint,
 data_inclusao timestamp(0) without time zone NOT NULL,
 ativo character(1),
 id_sgf_recebimento_cheque bigint
);


ALTER TABLE public.sgf_recebimento_cheque OWNER TO postgres;

--
-- TOC entry 13154 (class 0 OID 0)
-- Dependencies: 1097
-- Name: COLUMN sgf_recebimento_cheque.tipo_cheque; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_recebimento_cheque.tipo_cheque IS 'B = Bom, P = Pré-datado';


--
-- TOC entry 13155 (class 0 OID 0)
-- Dependencies: 1097
-- Name: COLUMN sgf_recebimento_cheque.terceiro; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_recebimento_cheque.terceiro IS 'S = Sim, N = Não';


--
-- TOC entry 13156 (class 0 OID 0)
-- Dependencies: 1097
-- Name: COLUMN sgf_recebimento_cheque.conferido; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_recebimento_cheque.conferido IS 'S = SIm, N = Não';


--
-- TOC entry 13157 (class 0 OID 0)
-- Dependencies: 1097
-- Name: COLUMN sgf_recebimento_cheque.ativo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_recebimento_cheque.ativo IS 'S=Sim, N=Nao';


--
-- TOC entry 13158 (class 0 OID 0)
-- Dependencies: 1097
-- Name: COLUMN sgf_recebimento_cheque.id_sgf_recebimento_cheque; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_recebimento_cheque.id_sgf_recebimento_cheque IS 'Para indicar o cheque substituido';


--
-- TOC entry 1098 (class 1259 OID 14565476)
-- Name: sgf_recebimento_cheque_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_recebimento_cheque_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_recebimento_cheque_id_seq OWNER TO postgres;

--
-- TOC entry 13159 (class 0 OID 0)
-- Dependencies: 1098
-- Name: sgf_recebimento_cheque_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_recebimento_cheque_id_seq OWNED BY public.sgf_recebimento_cheque.id;


--
-- TOC entry 1099 (class 1259 OID 14565478)
-- Name: sgf_recebimento_cheque_ocorrencia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_recebimento_cheque_ocorrencia (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sgf_ocorrencia_cheque bigint,
 id_sgf_recebimento_cheque bigint,
 id_sgf_conta_bancaria bigint,
 login character varying(32),
 data date,
 ordem smallint,
 lote integer,
 id_sgf_conciliacao bigint
);


ALTER TABLE public.sgf_recebimento_cheque_ocorrencia OWNER TO postgres;

--
-- TOC entry 1100 (class 1259 OID 14565481)
-- Name: sgf_recebimento_cheque_ocorrencia_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_recebimento_cheque_ocorrencia_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_recebimento_cheque_ocorrencia_id_seq OWNER TO postgres;

--
-- TOC entry 13160 (class 0 OID 0)
-- Dependencies: 1100
-- Name: sgf_recebimento_cheque_ocorrencia_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_recebimento_cheque_ocorrencia_id_seq OWNED BY public.sgf_recebimento_cheque_ocorrencia.id;


--
-- TOC entry 1101 (class 1259 OID 14565483)
-- Name: sgf_recebimento_deposito; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_recebimento_deposito (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sgf_recebimento bigint,
 id_sgf_conta_bancaria bigint NOT NULL,
 valor numeric(9,2),
 numero_documento character varying(20)
);


ALTER TABLE public.sgf_recebimento_deposito OWNER TO postgres;

--
-- TOC entry 1102 (class 1259 OID 14565486)
-- Name: sgf_recebimento_deposito_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_recebimento_deposito_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_recebimento_deposito_id_seq OWNER TO postgres;

--
-- TOC entry 13161 (class 0 OID 0)
-- Dependencies: 1102
-- Name: sgf_recebimento_deposito_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_recebimento_deposito_id_seq OWNED BY public.sgf_recebimento_deposito.id;


--
-- TOC entry 1103 (class 1259 OID 14565488)
-- Name: sgf_recebimento_desconto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_recebimento_desconto (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_estabelecimento bigint,
 id_sgf_titulo_receber bigint,
 id_sgf_recebimento bigint,
 descricao character varying(100),
 data_desconto date,
 valor numeric(9,2),
 data_cancelamento date,
 forma character(1)
);


ALTER TABLE public.sgf_recebimento_desconto OWNER TO postgres;

--
-- TOC entry 13162 (class 0 OID 0)
-- Dependencies: 1103
-- Name: COLUMN sgf_recebimento_desconto.forma; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_recebimento_desconto.forma IS 'P = percentual, V = valor fixo';


--
-- TOC entry 1104 (class 1259 OID 14565491)
-- Name: sgf_recebimento_desconto_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_recebimento_desconto_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_recebimento_desconto_id_seq OWNER TO postgres;

--
-- TOC entry 13163 (class 0 OID 0)
-- Dependencies: 1104
-- Name: sgf_recebimento_desconto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_recebimento_desconto_id_seq OWNED BY public.sgf_recebimento_desconto.id;


SET default_with_oids = true;

--
-- TOC entry 1105 (class 1259 OID 14565493)
-- Name: sgf_recebimento_dinheiro; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_recebimento_dinheiro (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sgf_recebimento bigint,
 valor numeric(9,2),
 datareg timestamp without time zone,
 valor_pago numeric(9,2),
 valor_troco numeric(9,2)
);


ALTER TABLE public.sgf_recebimento_dinheiro OWNER TO postgres;

--
-- TOC entry 1106 (class 1259 OID 14565496)
-- Name: sgf_recebimento_dinheiro_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_recebimento_dinheiro_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_recebimento_dinheiro_id_seq OWNER TO postgres;

--
-- TOC entry 13164 (class 0 OID 0)
-- Dependencies: 1106
-- Name: sgf_recebimento_dinheiro_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_recebimento_dinheiro_id_seq OWNED BY public.sgf_recebimento_dinheiro.id;


--
-- TOC entry 1107 (class 1259 OID 14565498)
-- Name: sgf_recebimento_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_recebimento_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_recebimento_id_seq OWNER TO postgres;

--
-- TOC entry 13165 (class 0 OID 0)
-- Dependencies: 1107
-- Name: sgf_recebimento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_recebimento_id_seq OWNED BY public.sgf_recebimento.id;


SET default_with_oids = false;

--
-- TOC entry 1108 (class 1259 OID 14565500)
-- Name: sgf_recebimento_nota_promissoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_recebimento_nota_promissoria (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_estabelecimento bigint,
 id_sgf_recebimento bigint,
 id_sgf_forma_recebimento bigint,
 id_sgf_conta_bancaria bigint,
 login character varying(32),
 id_bas_pessoa bigint,
 id_sgf_titulo_receber bigint,
 valor numeric(9,2),
 obs character varying(200),
 sequencia smallint,
 data_registro date,
 emitente character varying(100),
 cpf character varying(14),
 data_baixa date,
 conferido character(1),
 data_cancelamento date
);


ALTER TABLE public.sgf_recebimento_nota_promissoria OWNER TO postgres;

--
-- TOC entry 13166 (class 0 OID 0)
-- Dependencies: 1108
-- Name: COLUMN sgf_recebimento_nota_promissoria.conferido; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_recebimento_nota_promissoria.conferido IS 'S = sim, N = Não';


--
-- TOC entry 1109 (class 1259 OID 14565503)
-- Name: sgf_recebimento_nota_promissoria_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_recebimento_nota_promissoria_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_recebimento_nota_promissoria_id_seq OWNER TO postgres;

--
-- TOC entry 13167 (class 0 OID 0)
-- Dependencies: 1109
-- Name: sgf_recebimento_nota_promissoria_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_recebimento_nota_promissoria_id_seq OWNED BY public.sgf_recebimento_nota_promissoria.id;


--
-- TOC entry 1110 (class 1259 OID 14565505)
-- Name: sgf_remessa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_remessa (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sgf_conta_bancaria bigint NOT NULL,
 arquivo bytea,
 arquivo_nome character varying(100) NOT NULL,
 arquivo_caminho character varying(100) NOT NULL,
 prazo_protesto smallint NOT NULL,
 datahora_lancamento timestamp without time zone DEFAULT now() NOT NULL,
 login character varying(32)
);


ALTER TABLE public.sgf_remessa OWNER TO postgres;

--
-- TOC entry 1111 (class 1259 OID 14565512)
-- Name: sgf_remessa_boleto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_remessa_boleto (
 id_bas_empresa bigint NOT NULL,
 id_sgf_remessa bigint NOT NULL,
 id_sgf_boleto bigint NOT NULL
);


ALTER TABLE public.sgf_remessa_boleto OWNER TO postgres;

--
-- TOC entry 1112 (class 1259 OID 14565515)
-- Name: sgf_remessa_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_remessa_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_remessa_id_seq OWNER TO postgres;

--
-- TOC entry 13168 (class 0 OID 0)
-- Dependencies: 1112
-- Name: sgf_remessa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_remessa_id_seq OWNED BY public.sgf_remessa.id;


--
-- TOC entry 1113 (class 1259 OID 14565517)
-- Name: sgf_situacao_financeira; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_situacao_financeira (
 id bigint NOT NULL,
 nome character varying(100) NOT NULL,
 sigla character varying(8) NOT NULL
);


ALTER TABLE public.sgf_situacao_financeira OWNER TO postgres;

--
-- TOC entry 1114 (class 1259 OID 14565520)
-- Name: sgf_situacao_financeira_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_situacao_financeira_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_situacao_financeira_id_seq OWNER TO postgres;

--
-- TOC entry 13169 (class 0 OID 0)
-- Dependencies: 1114
-- Name: sgf_situacao_financeira_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_situacao_financeira_id_seq OWNED BY public.sgf_situacao_financeira.id;


--
-- TOC entry 1115 (class 1259 OID 14565522)
-- Name: sgf_situacao_remessa_boleto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_situacao_remessa_boleto (
 id bigint NOT NULL,
 descricao character varying(100) NOT NULL
);


ALTER TABLE public.sgf_situacao_remessa_boleto OWNER TO postgres;

--
-- TOC entry 1116 (class 1259 OID 14565525)
-- Name: sgf_situacao_remessa_boleto_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_situacao_remessa_boleto_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_situacao_remessa_boleto_id_seq OWNER TO postgres;

--
-- TOC entry 13170 (class 0 OID 0)
-- Dependencies: 1116
-- Name: sgf_situacao_remessa_boleto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_situacao_remessa_boleto_id_seq OWNED BY public.sgf_situacao_remessa_boleto.id;


--
-- TOC entry 1117 (class 1259 OID 14565527)
-- Name: sgf_situacao_retorno_boleto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_situacao_retorno_boleto (
 id bigint NOT NULL,
 id_sgf_banco bigint NOT NULL,
 descricao character varying(100) NOT NULL
);


ALTER TABLE public.sgf_situacao_retorno_boleto OWNER TO postgres;

--
-- TOC entry 1118 (class 1259 OID 14565530)
-- Name: sgf_situacao_retorno_boleto_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_situacao_retorno_boleto_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_situacao_retorno_boleto_id_seq OWNER TO postgres;

--
-- TOC entry 13171 (class 0 OID 0)
-- Dependencies: 1118
-- Name: sgf_situacao_retorno_boleto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_situacao_retorno_boleto_id_seq OWNED BY public.sgf_situacao_retorno_boleto.id;


--
-- TOC entry 1119 (class 1259 OID 14565532)
-- Name: sgf_tipo_compromisso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_tipo_compromisso (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sgf_plano_conta_debito bigint,
 id_sgf_plano_conta_credito bigint,
 nome character varying(50),
 descricao character varying(100)
);


ALTER TABLE public.sgf_tipo_compromisso OWNER TO postgres;

--
-- TOC entry 1120 (class 1259 OID 14565535)
-- Name: sgf_tipo_compromisso_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_tipo_compromisso_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_tipo_compromisso_id_seq OWNER TO postgres;

--
-- TOC entry 13172 (class 0 OID 0)
-- Dependencies: 1120
-- Name: sgf_tipo_compromisso_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_tipo_compromisso_id_seq OWNED BY public.sgf_tipo_compromisso.id;


--
-- TOC entry 1121 (class 1259 OID 14565537)
-- Name: sgf_tipo_conta_bancaria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_tipo_conta_bancaria (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(100) NOT NULL
);


ALTER TABLE public.sgf_tipo_conta_bancaria OWNER TO postgres;

--
-- TOC entry 1122 (class 1259 OID 14565540)
-- Name: sgf_tipo_conta_bancaria_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_tipo_conta_bancaria_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_tipo_conta_bancaria_id_seq OWNER TO postgres;

--
-- TOC entry 13173 (class 0 OID 0)
-- Dependencies: 1122
-- Name: sgf_tipo_conta_bancaria_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_tipo_conta_bancaria_id_seq OWNED BY public.sgf_tipo_conta_bancaria.id;


--
-- TOC entry 1123 (class 1259 OID 14565542)
-- Name: sgf_tipo_doc_cobranca; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_tipo_doc_cobranca (
 id bigint NOT NULL,
 descricao character varying(100),
 sigla character varying(8),
 almox character(1)
);


ALTER TABLE public.sgf_tipo_doc_cobranca OWNER TO postgres;

--
-- TOC entry 1124 (class 1259 OID 14565545)
-- Name: sgf_tipo_doc_cobranca_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_tipo_doc_cobranca_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_tipo_doc_cobranca_id_seq OWNER TO postgres;

--
-- TOC entry 13174 (class 0 OID 0)
-- Dependencies: 1124
-- Name: sgf_tipo_doc_cobranca_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_tipo_doc_cobranca_id_seq OWNED BY public.sgf_tipo_doc_cobranca.id;


--
-- TOC entry 1125 (class 1259 OID 14565547)
-- Name: sgf_tipo_titulo_receber; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_tipo_titulo_receber (
 id integer NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sgf_plano_conta_credito bigint,
 id_sgf_plano_conta_debito bigint,
 descricao character varying(100) NOT NULL,
 valor numeric(9,2),
 encargos character(1),
 desconto character(1),
 juros numeric(9,2),
 multa numeric(9,2),
 iss character(1),
 origem_receita integer,
 id_bas_estabelecimento bigint NOT NULL,
 id_bas_centro_custo bigint,
 data_cancelamento date,
 id_sgf_tipo_doc_cobranca bigint
);


ALTER TABLE public.sgf_tipo_titulo_receber OWNER TO postgres;

--
-- TOC entry 1126 (class 1259 OID 14565550)
-- Name: sgf_tipo_titulo_receber_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_tipo_titulo_receber_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_tipo_titulo_receber_id_seq OWNER TO postgres;

--
-- TOC entry 13175 (class 0 OID 0)
-- Dependencies: 1126
-- Name: sgf_tipo_titulo_receber_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_tipo_titulo_receber_id_seq OWNED BY public.sgf_tipo_titulo_receber.id;


--
-- TOC entry 1127 (class 1259 OID 14565552)
-- Name: sgf_titulo_pagamento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_titulo_pagamento (
 id_bas_empresa bigint NOT NULL,
 id_sgf_titulo_pagar bigint NOT NULL,
 a_pagar numeric(9,2),
 pago numeric(9,2),
 juros numeric(9,2),
 multa numeric(9,2),
 desconto numeric(9,2),
 dinheiro numeric(9,2),
 cheque numeric(9,2),
 cartao numeric(9,2),
 debito numeric(9,2),
 data_reg timestamp without time zone,
 id_sgf_pagamento bigint NOT NULL
);


ALTER TABLE public.sgf_titulo_pagamento OWNER TO postgres;

--
-- TOC entry 1128 (class 1259 OID 14565555)
-- Name: sgf_titulo_pagar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_titulo_pagar (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_sgf_compromisso bigint,
 login character varying(32) NOT NULL,
 login_cancel character varying(32),
 data_vencimento date,
 valor numeric(9,2),
 descricao character varying(100),
 data_cancelamento date,
 parcela integer,
 numero_doc character varying(20),
 data_reg timestamp without time zone,
 previsao character(1),
 val_pago numeric(9,2),
 desconto numeric(9,2),
 data_pagamento date,
 juros numeric(9,2),
 multa numeric(9,2),
 observacao character varying(200),
 id_bas_estabelecimento bigint,
 val_pago_dinheiro numeric(9,2),
 val_pago_cheque numeric(9,2),
 val_pago_cartao numeric(9,2),
 val_pago_debito numeric(9,2),
 data date,
 id_sgf_situacao_financeira bigint,
 motivo_cancelamento character varying(256)
);


ALTER TABLE public.sgf_titulo_pagar OWNER TO postgres;

--
-- TOC entry 1129 (class 1259 OID 14565561)
-- Name: sgf_titulo_pagar_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_titulo_pagar_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_titulo_pagar_id_seq OWNER TO postgres;

--
-- TOC entry 13176 (class 0 OID 0)
-- Dependencies: 1129
-- Name: sgf_titulo_pagar_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_titulo_pagar_id_seq OWNED BY public.sgf_titulo_pagar.id;


--
-- TOC entry 1130 (class 1259 OID 14565563)
-- Name: sgf_titulo_receber; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_titulo_receber (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_estabelecimento bigint NOT NULL,
 id_bas_pessoa bigint,
 id_sgf_situacao_financeira bigint NOT NULL,
 id_sge_aluno bigint,
 id_sge_contrato bigint,
 login character varying(32) NOT NULL,
 login_cancel character varying(32),
 id_sgf_conta_credito bigint,
 id_sgf_conta_debito bigint,
 id_sgf_tipo_titulo_receber bigint NOT NULL,
 id_sgf_acordo bigint,
 id_sge_atividade_pessoa bigint,
 id_sgf_agente_cobrador bigint,
 id_sge_turno_integral bigint,
 id_bas_centro_custo bigint,
 id_sge_transporte bigint,
 id_sgf_loterps bigint,
 id_sgf_rps bigint,
 parcela bigint,
 data_vencimento date,
 data_emissao date,
 data_inclusao timestamp without time zone DEFAULT ('now'::text)::timestamp without time zone,
 valor numeric(9,2),
 descricao character varying(64),
 ano_letivo bigint,
 data_cancelamento timestamp without time zone,
 motivo_cancelamento character varying(255),
 numero_parcela smallint,
 numero_lancamento bigint,
 antecipacao character(1) DEFAULT 'N'::bpchar,
 id_sga_venda bigint
);


ALTER TABLE public.sgf_titulo_receber OWNER TO postgres;

--
-- TOC entry 13177 (class 0 OID 0)
-- Dependencies: 1130
-- Name: COLUMN sgf_titulo_receber.parcela; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_titulo_receber.parcela IS 'Número da parcela que o título se refere';


--
-- TOC entry 13178 (class 0 OID 0)
-- Dependencies: 1130
-- Name: COLUMN sgf_titulo_receber.numero_parcela; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_titulo_receber.numero_parcela IS 'Número total de parcelas do título';


--
-- TOC entry 13179 (class 0 OID 0)
-- Dependencies: 1130
-- Name: COLUMN sgf_titulo_receber.antecipacao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgf_titulo_receber.antecipacao IS 'S = sim, N = Não';


--
-- TOC entry 1131 (class 1259 OID 14565568)
-- Name: sgf_titulo_receber_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_titulo_receber_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_titulo_receber_id_seq OWNER TO postgres;

--
-- TOC entry 13180 (class 0 OID 0)
-- Dependencies: 1131
-- Name: sgf_titulo_receber_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_titulo_receber_id_seq OWNED BY public.sgf_titulo_receber.id;


--
-- TOC entry 1132 (class 1259 OID 14565570)
-- Name: sgf_titulo_recebimento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_titulo_recebimento (
 id_bas_empresa bigint NOT NULL,
 id_sgf_titulo_receber bigint NOT NULL,
 id_sgf_recebimento bigint NOT NULL,
 id_bas_estabelecimento bigint NOT NULL,
 valor numeric(9,2),
 valor_pago numeric(9,2),
 juros numeric(9,2),
 multa numeric(9,2),
 desconto numeric(9,2),
 valor_dinheiro numeric(9,2),
 valor_cheque numeric(9,2),
 valor_cartao numeric(9,2),
 valor_boleto numeric(9,2),
 valor_deposito numeric(9,2),
 valor_nota_promissoria numeric(9,2),
 valor_cheque_predatado numeric(9,2),
 valor_cheque_avista numeric(9,2),
 data_registro timestamp without time zone
);


ALTER TABLE public.sgf_titulo_recebimento OWNER TO postgres;

--
-- TOC entry 1133 (class 1259 OID 14565573)
-- Name: sgf_transporte_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_transporte_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_transporte_id_seq OWNER TO postgres;

--
-- TOC entry 13181 (class 0 OID 0)
-- Dependencies: 1133
-- Name: sgf_transporte_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_transporte_id_seq OWNED BY public.sge_transporte.id;


--
-- TOC entry 1134 (class 1259 OID 14565575)
-- Name: sgf_transporte_ponto_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_transporte_ponto_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_transporte_ponto_id_seq OWNER TO postgres;

--
-- TOC entry 13182 (class 0 OID 0)
-- Dependencies: 1134
-- Name: sgf_transporte_ponto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_transporte_ponto_id_seq OWNED BY public.sge_transporte_ponto.id;


--
-- TOC entry 1135 (class 1259 OID 14565577)
-- Name: sgf_vencimento_dia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgf_vencimento_dia (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_estabelecimento bigint NOT NULL,
 dia smallint
);


ALTER TABLE public.sgf_vencimento_dia OWNER TO postgres;

--
-- TOC entry 1136 (class 1259 OID 14565580)
-- Name: sgf_vencimento_dia_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgf_vencimento_dia_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgf_vencimento_dia_id_seq OWNER TO postgres;

--
-- TOC entry 13183 (class 0 OID 0)
-- Dependencies: 1136
-- Name: sgf_vencimento_dia_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgf_vencimento_dia_id_seq OWNED BY public.sgf_vencimento_dia.id;


--
-- TOC entry 1137 (class 1259 OID 14565582)
-- Name: sgm_acao_preventiva_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_acao_preventiva_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_acao_preventiva_id_seq OWNER TO postgres;

--
-- TOC entry 1138 (class 1259 OID 14565584)
-- Name: sgm_acao_preventiva; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_acao_preventiva (
 id_bas_empresa bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_acao_preventiva_id_seq'::regclass) NOT NULL,
 data_acao date,
 observacao text,
 nome_contato_responsavel character varying(50),
 id_sgm_tipo_contato bigint,
 tipo_acao_preventiva bigint,
 id_bas_estabelecimento bigint
);


ALTER TABLE public.sgm_acao_preventiva OWNER TO postgres;

--
-- TOC entry 13184 (class 0 OID 0)
-- Dependencies: 1138
-- Name: TABLE sgm_acao_preventiva; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_acao_preventiva IS 'Merenda Escolar - Ação Preventiva';


--
-- TOC entry 1139 (class 1259 OID 14565591)
-- Name: sgm_acao_preventiva_agenda; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_acao_preventiva_agenda (
 id_bas_empresa bigint NOT NULL,
 id_sgm_acao_preventiva bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_acao_preventiva_id_seq'::regclass) NOT NULL,
 id_bas_estabelecimento bigint NOT NULL,
 data_visita date,
 hora_visita time without time zone,
 observacao text
);


ALTER TABLE public.sgm_acao_preventiva_agenda OWNER TO postgres;

--
-- TOC entry 13185 (class 0 OID 0)
-- Dependencies: 1139
-- Name: TABLE sgm_acao_preventiva_agenda; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_acao_preventiva_agenda IS 'Merenda Escolar - Ação Preventiva / Agenda';


--
-- TOC entry 1140 (class 1259 OID 14565598)
-- Name: sgm_acao_preventiva_agenda_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_acao_preventiva_agenda_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_acao_preventiva_agenda_id_seq OWNER TO postgres;

--
-- TOC entry 1141 (class 1259 OID 14565600)
-- Name: sgm_acao_preventiva_teste_aceitabilidade_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_acao_preventiva_teste_aceitabilidade_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_acao_preventiva_teste_aceitabilidade_id_seq OWNER TO postgres;

--
-- TOC entry 1142 (class 1259 OID 14565602)
-- Name: sgm_acao_preventiva_teste_aceitabilidade; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_acao_preventiva_teste_aceitabilidade (
 id_bas_empresa bigint NOT NULL,
 id_sgm_acao_preventiva bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_acao_preventiva_teste_aceitabilidade_id_seq'::regclass) NOT NULL,
 id_bas_estabelecimento bigint NOT NULL,
 id_sgm_cardapio bigint,
 id_sgm_metodo_teste bigint,
 observacao text,
 id_sge_curso bigint,
 id_sge_faixa_etaria bigint,
 id_sge_serie bigint,
 id_sge_turma bigint,
 id_sgm_receita bigint,
 id_sga_material bigint,
 data_visita date,
 hora_visita time without time zone,
 quantidade_alunos bigint,
 id_sgm_acao_preventiva_agenda bigint,
 responsavel character varying(50),
 caminho_anexo character varying(200),
 nota_teste character varying(5)
);


ALTER TABLE public.sgm_acao_preventiva_teste_aceitabilidade OWNER TO postgres;

--
-- TOC entry 13186 (class 0 OID 0)
-- Dependencies: 1142
-- Name: TABLE sgm_acao_preventiva_teste_aceitabilidade; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_acao_preventiva_teste_aceitabilidade IS 'Merenda Escolar - Ação Preventiva / Teste de Aceitabilidade';


--
-- TOC entry 1143 (class 1259 OID 14565609)
-- Name: sgm_acao_preventiva_teste_aceitabilidade_notas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_acao_preventiva_teste_aceitabilidade_notas_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_acao_preventiva_teste_aceitabilidade_notas_id_seq OWNER TO postgres;

--
-- TOC entry 1144 (class 1259 OID 14565611)
-- Name: sgm_acao_preventiva_teste_aceitabilidade_notas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_acao_preventiva_teste_aceitabilidade_notas (
 id_bas_empresa bigint NOT NULL,
 id_sgm_acao_preventiva bigint NOT NULL,
 id_sgm_acao_preventiva_teste_aceitabilidade bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_acao_preventiva_teste_aceitabilidade_notas_id_seq'::regclass) NOT NULL,
 id_sge_aluno bigint NOT NULL,
 nota numeric(9,2),
 descricao text
);


ALTER TABLE public.sgm_acao_preventiva_teste_aceitabilidade_notas OWNER TO postgres;

--
-- TOC entry 13187 (class 0 OID 0)
-- Dependencies: 1144
-- Name: TABLE sgm_acao_preventiva_teste_aceitabilidade_notas; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_acao_preventiva_teste_aceitabilidade_notas IS 'Merenda Escolar - Ação Preventiva / Notas';


--
-- TOC entry 1145 (class 1259 OID 14565618)
-- Name: sgm_baixa_lote_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_baixa_lote_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_baixa_lote_id_seq OWNER TO postgres;

--
-- TOC entry 1146 (class 1259 OID 14565620)
-- Name: sgm_baixa_lote; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_baixa_lote (
 id_bas_empresa bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_baixa_lote_id_seq'::regclass) NOT NULL,
 id_sga_almoxarifado bigint NOT NULL,
 id_bas_colaborador bigint,
 data_baixa date,
 observacao text,
 baixa_estoque character(1)
);


ALTER TABLE public.sgm_baixa_lote OWNER TO postgres;

--
-- TOC entry 13188 (class 0 OID 0)
-- Dependencies: 1146
-- Name: TABLE sgm_baixa_lote; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_baixa_lote IS 'Merenda Escolar - Baixa Lote';


--
-- TOC entry 1147 (class 1259 OID 14565627)
-- Name: sgm_baixa_lote_material_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_baixa_lote_material_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_baixa_lote_material_id_seq OWNER TO postgres;

--
-- TOC entry 1148 (class 1259 OID 14565629)
-- Name: sgm_baixa_lote_material; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_baixa_lote_material (
 id_bas_empresa bigint NOT NULL,
 id_sgm_baixa_lote bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_baixa_lote_material_id_seq'::regclass) NOT NULL,
 id_sga_material bigint NOT NULL,
 numero_lote character varying(10),
 data_validade_lote date,
 quantidade_baixa numeric(9,2)
);


ALTER TABLE public.sgm_baixa_lote_material OWNER TO postgres;

--
-- TOC entry 13189 (class 0 OID 0)
-- Dependencies: 1148
-- Name: TABLE sgm_baixa_lote_material; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_baixa_lote_material IS 'Merenda Escolar - Baixa Lote - Material';


--
-- TOC entry 1149 (class 1259 OID 14565633)
-- Name: sgm_cae_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_cae_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_cae_id_seq OWNER TO postgres;

--
-- TOC entry 1150 (class 1259 OID 14565635)
-- Name: sgm_cae; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_cae (
 id_bas_empresa bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_cae_id_seq'::regclass) NOT NULL,
 data_eleicao date,
 data_inicio_mandato date,
 data_termino_mandato date,
 numero_decreto character varying(15),
 ativo character(1),
 nome character varying(50),
 caminho_ata character varying(200)
);


ALTER TABLE public.sgm_cae OWNER TO postgres;

--
-- TOC entry 13190 (class 0 OID 0)
-- Dependencies: 1150
-- Name: TABLE sgm_cae; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_cae IS 'Merenda Escolar - CAE / Membro';


--
-- TOC entry 1151 (class 1259 OID 14565639)
-- Name: sgm_cae_agenda_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_cae_agenda_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_cae_agenda_id_seq OWNER TO postgres;

--
-- TOC entry 1152 (class 1259 OID 14565641)
-- Name: sgm_cae_agenda; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_cae_agenda (
 id_bas_empresa bigint NOT NULL,
 id_sgm_cae bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_cae_agenda_id_seq'::regclass) NOT NULL,
 id_bas_estabelecimento bigint NOT NULL,
 itens_inspecionados text,
 data_visita date,
 hora_visita timestamp without time zone,
 mostra_nao_conformidade character(1),
 nao_conformidade text,
 id_bas_colaborador_responsavel bigint
);


ALTER TABLE public.sgm_cae_agenda OWNER TO postgres;

--
-- TOC entry 13191 (class 0 OID 0)
-- Dependencies: 1152
-- Name: TABLE sgm_cae_agenda; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_cae_agenda IS 'Merenda Escolar - CAE / Agenda';


--
-- TOC entry 1153 (class 1259 OID 14565648)
-- Name: sgm_cae_membro_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_cae_membro_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_cae_membro_id_seq OWNER TO postgres;

--
-- TOC entry 1154 (class 1259 OID 14565650)
-- Name: sgm_cae_membro; Type: TABLE; Schema: public; Owner: pgadmin
--

CREATE TABLE public.sgm_cae_membro (
 id_bas_empresa bigint NOT NULL,
 id_sgm_cae bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_cae_membro_id_seq'::regclass) NOT NULL,
 id_bas_colaborador bigint,
 nome character varying(30),
 id_bas_funcao bigint NOT NULL,
 tipo_interno_externo character(1)
);


ALTER TABLE public.sgm_cae_membro OWNER TO pgadmin;

--
-- TOC entry 1155 (class 1259 OID 14565654)
-- Name: sgm_cantina_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_cantina_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_cantina_id_seq OWNER TO postgres;

--
-- TOC entry 1156 (class 1259 OID 14565656)
-- Name: sgm_cantina; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_cantina (
 id_bas_empresa bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_cantina_id_seq'::regclass) NOT NULL,
 id_sga_almoxarifado bigint NOT NULL,
 nome character varying(25) NOT NULL,
 descricao text
);


ALTER TABLE public.sgm_cantina OWNER TO postgres;

--
-- TOC entry 13192 (class 0 OID 0)
-- Dependencies: 1156
-- Name: TABLE sgm_cantina; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_cantina IS 'Merenda Escolar - Cantina';


--
-- TOC entry 1157 (class 1259 OID 14565663)
-- Name: sgm_cantina_membro_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_cantina_membro_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_cantina_membro_id_seq OWNER TO postgres;

--
-- TOC entry 1158 (class 1259 OID 14565665)
-- Name: sgm_cantina_membro; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_cantina_membro (
 id_bas_empresa bigint NOT NULL,
 id_sgm_cantina bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_cantina_membro_id_seq'::regclass) NOT NULL,
 id_bas_funcao bigint NOT NULL,
 nome character varying(25) NOT NULL,
 tipo_interno_externo character(1),
 id_bas_colaborador bigint
);


ALTER TABLE public.sgm_cantina_membro OWNER TO postgres;

--
-- TOC entry 13193 (class 0 OID 0)
-- Dependencies: 1158
-- Name: TABLE sgm_cantina_membro; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_cantina_membro IS 'Merenda Escolar - Cantina / Membro';


--
-- TOC entry 1159 (class 1259 OID 14565669)
-- Name: sgm_cardapio_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_cardapio_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_cardapio_id_seq OWNER TO postgres;

--
-- TOC entry 1160 (class 1259 OID 14565671)
-- Name: sgm_cardapio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_cardapio (
 id_bas_empresa bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_cardapio_id_seq'::regclass) NOT NULL,
 id_sgm_polo bigint,
 id_sgm_cardapio_tipo bigint NOT NULL,
 id_bas_estabelecimento bigint,
 id_sge_faixa_etaria bigint,
 id_sge_curso bigint,
 id_sge_serie bigint,
 id_sge_turma bigint,
 dias_semana character varying(13),
 valor_custo numeric(9,2),
 valor_calorico numeric(9,2),
 data_cardapio date,
 caminho_anexo character varying(200),
 situacao character(1),
 data_inativacao date,
 justificativa_inativacao text,
 nutricionista_responsavel character varying(100),
 nome character varying(200)
);


ALTER TABLE public.sgm_cardapio OWNER TO postgres;

--
-- TOC entry 13194 (class 0 OID 0)
-- Dependencies: 1160
-- Name: TABLE sgm_cardapio; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_cardapio IS 'Merenda Escolar - Cardápio';


--
-- TOC entry 13195 (class 0 OID 0)
-- Dependencies: 1160
-- Name: COLUMN sgm_cardapio.dias_semana; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgm_cardapio.dias_semana IS '1- domingo;2- segunda;3- terça;4- quarta;5- quinta;6- sexta;7- sábado';


--
-- TOC entry 1161 (class 1259 OID 14565678)
-- Name: sgm_cardapio_material; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_cardapio_material (
 id_bas_empresa bigint NOT NULL,
 id_sgm_cardapio bigint NOT NULL,
 id_sga_material bigint NOT NULL,
 quantidade_requisitada numeric(9,2) NOT NULL
);


ALTER TABLE public.sgm_cardapio_material OWNER TO postgres;

--
-- TOC entry 13196 (class 0 OID 0)
-- Dependencies: 1161
-- Name: TABLE sgm_cardapio_material; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_cardapio_material IS 'Merenda Escolar - Cardápio / Material';


--
-- TOC entry 1162 (class 1259 OID 14565681)
-- Name: sgm_cardapio_receita; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_cardapio_receita (
 id_bas_empresa bigint NOT NULL,
 id_sgm_cardapio bigint NOT NULL,
 id_sgm_receita bigint NOT NULL,
 quantidade_receita numeric(5,1)
);


ALTER TABLE public.sgm_cardapio_receita OWNER TO postgres;

--
-- TOC entry 13197 (class 0 OID 0)
-- Dependencies: 1162
-- Name: TABLE sgm_cardapio_receita; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_cardapio_receita IS 'Merenda Escolar - Cardápio / Receita';


--
-- TOC entry 1163 (class 1259 OID 14565684)
-- Name: sgm_cardapio_tipo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_cardapio_tipo_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_cardapio_tipo_id_seq OWNER TO postgres;

--
-- TOC entry 1164 (class 1259 OID 14565686)
-- Name: sgm_cardapio_tipo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_cardapio_tipo (
 id_bas_empresa bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_cardapio_tipo_id_seq'::regclass) NOT NULL,
 nome character varying(20) NOT NULL,
 horario_inicial time without time zone,
 horario_final time without time zone,
 cor_calendar character varying(8)
);


ALTER TABLE public.sgm_cardapio_tipo OWNER TO postgres;

--
-- TOC entry 13198 (class 0 OID 0)
-- Dependencies: 1164
-- Name: TABLE sgm_cardapio_tipo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_cardapio_tipo IS 'Merenda Escolar - Cardápio / Tipo';


--
-- TOC entry 1165 (class 1259 OID 14565690)
-- Name: sgm_checklist_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_checklist_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_checklist_id_seq OWNER TO postgres;

--
-- TOC entry 1166 (class 1259 OID 14565692)
-- Name: sgm_checklist; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_checklist (
 id_bas_empresa bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_checklist_id_seq'::regclass) NOT NULL,
 data_preenchimento date,
 id_bas_estabelecimento bigint,
 login_digitador character varying(32),
 id_bas_colaborador_responsavel bigint,
 id_sgm_grupo_checklist bigint,
 descricao text
);


ALTER TABLE public.sgm_checklist OWNER TO postgres;

--
-- TOC entry 13199 (class 0 OID 0)
-- Dependencies: 1166
-- Name: TABLE sgm_checklist; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_checklist IS 'Merenda Escolar - Checklist';


--
-- TOC entry 1167 (class 1259 OID 14565699)
-- Name: sgm_checklist_respostas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_checklist_respostas_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_checklist_respostas_id_seq OWNER TO postgres;

--
-- TOC entry 1168 (class 1259 OID 14565701)
-- Name: sgm_checklist_respostas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_checklist_respostas (
 id_bas_empresa bigint NOT NULL,
 id_sgm_checklist bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_checklist_respostas_id_seq'::regclass) NOT NULL,
 id_sgm_pergunta_checklist bigint NOT NULL,
 check_sim_nao_na_nota character varying(2),
 descricao text
);


ALTER TABLE public.sgm_checklist_respostas OWNER TO postgres;

--
-- TOC entry 13200 (class 0 OID 0)
-- Dependencies: 1168
-- Name: TABLE sgm_checklist_respostas; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_checklist_respostas IS 'Merenda Escolar - Checklist / Respostas';


--
-- TOC entry 1169 (class 1259 OID 14565708)
-- Name: sgm_classificacao_checklist_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_classificacao_checklist_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_classificacao_checklist_id_seq OWNER TO postgres;

--
-- TOC entry 1170 (class 1259 OID 14565710)
-- Name: sgm_classificacao_checklist; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_classificacao_checklist (
 id_bas_empresa bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_classificacao_checklist_id_seq'::regclass) NOT NULL,
 id_sgm_grupo_checklist bigint,
 total_sim numeric(9,2),
 total_nao numeric(9,2),
 total_na numeric(9,2),
 total_nota numeric(9,2),
 resultado_sim_maior text,
 resultado_nao_maior text,
 resultado_na_maior text,
 resultado_nota_maior text,
 resultado_sim_menor text,
 resultado_nao_menor text,
 resultado_na_menor text,
 resultado_nota_menor text
);


ALTER TABLE public.sgm_classificacao_checklist OWNER TO postgres;

--
-- TOC entry 13201 (class 0 OID 0)
-- Dependencies: 1170
-- Name: TABLE sgm_classificacao_checklist; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_classificacao_checklist IS 'Merenda Escolar - Classificação do Checklist';


--
-- TOC entry 1171 (class 1259 OID 14565717)
-- Name: sgm_classificacao_inspecao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_classificacao_inspecao_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_classificacao_inspecao_id_seq OWNER TO postgres;

--
-- TOC entry 1172 (class 1259 OID 14565719)
-- Name: sgm_classificacao_inspecao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_classificacao_inspecao (
 id_bas_empresa bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_classificacao_inspecao_id_seq'::regclass) NOT NULL,
 id_sgm_grupo_inspecao bigint,
 total_sim numeric(9,2),
 total_nao numeric(9,2),
 total_na numeric(9,2),
 total_nota numeric(9,2),
 resultado_sim_maior text,
 resultado_nao_maior text,
 resultado_na_maior text,
 resultado_nota_maior text,
 resultado_sim_menor text,
 resultado_nao_menor text,
 resultado_na_menor text,
 resultado_nota_menor text
);


ALTER TABLE public.sgm_classificacao_inspecao OWNER TO postgres;

--
-- TOC entry 13202 (class 0 OID 0)
-- Dependencies: 1172
-- Name: TABLE sgm_classificacao_inspecao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_classificacao_inspecao IS 'Merenda Escolar - Classificação do Inspecao';


--
-- TOC entry 1173 (class 1259 OID 14565726)
-- Name: sgm_configuracao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_configuracao_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_configuracao_id_seq OWNER TO postgres;

--
-- TOC entry 1174 (class 1259 OID 14565728)
-- Name: sgm_configuracao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_configuracao (
 id_bas_empresa bigint NOT NULL,
 id_bas_estabelecimento bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_configuracao_id_seq'::regclass) NOT NULL,
 data_inicio date,
 data_final date,
 id_sga_almoxarifado_unidade_controladora integer,
 categoria_material_merenda character varying(20),
 ativo character(1),
 media_estabelecimento numeric(9,2),
 qtd_dias_venc_verde bigint,
 qtd_dias_venc_amarelo bigint,
 qtd_dias_venc_vermelho bigint,
 texto_media_maior_igual text,
 texto_media_menor text
);


ALTER TABLE public.sgm_configuracao OWNER TO postgres;

--
-- TOC entry 13203 (class 0 OID 0)
-- Dependencies: 1174
-- Name: TABLE sgm_configuracao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_configuracao IS 'Merenda Escolar - Configuração / Parametrização';


--
-- TOC entry 1175 (class 1259 OID 14565735)
-- Name: sgm_consumo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_consumo_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_consumo_id_seq OWNER TO postgres;

--
-- TOC entry 1176 (class 1259 OID 14565737)
-- Name: sgm_consumo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_consumo (
 id_bas_empresa bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_consumo_id_seq'::regclass) NOT NULL,
 data_registro date,
 data_inicial date,
 data_final date,
 id_sgm_polo bigint,
 id_bas_estabelecimento bigint,
 id_sge_faixa_etaria bigint,
 id_sge_curso bigint,
 id_sge_serie bigint,
 id_sge_turma bigint,
 id_sgm_cardapio_tipo bigint,
 id_sgm_cardapio bigint,
 qtd_cardapio bigint
);


ALTER TABLE public.sgm_consumo OWNER TO postgres;

--
-- TOC entry 13204 (class 0 OID 0)
-- Dependencies: 1176
-- Name: TABLE sgm_consumo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_consumo IS 'Merenda Escolar - Consumo';


--
-- TOC entry 1177 (class 1259 OID 14565741)
-- Name: sgm_consumo_cardapio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_consumo_cardapio (
 id_bas_empresa bigint NOT NULL,
 id_sgm_consumo bigint NOT NULL,
 id_sgm_cardapio_tipo bigint NOT NULL,
 id_sgm_cardapio bigint NOT NULL,
 data_consumo date NOT NULL,
 quantidade_consumo numeric(9,2) NOT NULL
);


ALTER TABLE public.sgm_consumo_cardapio OWNER TO postgres;

--
-- TOC entry 13205 (class 0 OID 0)
-- Dependencies: 1177
-- Name: TABLE sgm_consumo_cardapio; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_consumo_cardapio IS 'Merenda Escolar - Consumo x Cardápio';


--
-- TOC entry 1178 (class 1259 OID 14565744)
-- Name: sgm_consumo_material; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_consumo_material (
 id_bas_empresa bigint NOT NULL,
 id_sgm_consumo bigint NOT NULL,
 id_sga_material bigint NOT NULL,
 quantidade_consumo numeric(9,2) NOT NULL,
 valor_consumo numeric(9,2)
);


ALTER TABLE public.sgm_consumo_material OWNER TO postgres;

--
-- TOC entry 13206 (class 0 OID 0)
-- Dependencies: 1178
-- Name: TABLE sgm_consumo_material; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_consumo_material IS 'Merenda Escolar - Consumo x Material';


--
-- TOC entry 1179 (class 1259 OID 14565747)
-- Name: sgm_consumo_material_lote_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_consumo_material_lote_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_consumo_material_lote_id_seq OWNER TO postgres;

--
-- TOC entry 1180 (class 1259 OID 14565749)
-- Name: sgm_consumo_material_lote; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_consumo_material_lote (
 id_bas_empresa bigint NOT NULL,
 id_sgm_consumo bigint NOT NULL,
 id_sga_material bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_consumo_material_lote_id_seq'::regclass) NOT NULL,
 numero_lote character varying(10),
 data_validade_lote date,
 quantidade_consumida numeric(9,2)
);


ALTER TABLE public.sgm_consumo_material_lote OWNER TO postgres;

--
-- TOC entry 13207 (class 0 OID 0)
-- Dependencies: 1180
-- Name: TABLE sgm_consumo_material_lote; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_consumo_material_lote IS 'Merenda Escolar - Consumo de Material x Lote';


--
-- TOC entry 1181 (class 1259 OID 14565753)
-- Name: sgm_estatistica_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_estatistica_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_estatistica_id_seq OWNER TO postgres;

--
-- TOC entry 1182 (class 1259 OID 14565755)
-- Name: sgm_estatistica; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_estatistica (
 id_bas_empresa bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_estatistica_id_seq'::regclass) NOT NULL,
 data_referencia_inicial date,
 data_referencia_final date,
 id_sgm_polo bigint,
 id_bas_estabelecimento bigint,
 id_sge_curso bigint,
 id_sge_faixa_etaria bigint,
 id_sge_serie bigint,
 id_sge_turma bigint,
 quantidade_alunos bigint,
 ativo character(1)
);


ALTER TABLE public.sgm_estatistica OWNER TO postgres;

--
-- TOC entry 13208 (class 0 OID 0)
-- Dependencies: 1182
-- Name: TABLE sgm_estatistica; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_estatistica IS 'Merenda Escolar - Estatísticas';


--
-- TOC entry 1183 (class 1259 OID 14565759)
-- Name: sgm_grupo_checklist_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_grupo_checklist_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_grupo_checklist_id_seq OWNER TO postgres;

--
-- TOC entry 1184 (class 1259 OID 14565761)
-- Name: sgm_grupo_checklist; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_grupo_checklist (
 id_bas_empresa bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_grupo_checklist_id_seq'::regclass) NOT NULL,
 nome character varying(30),
 descricao text,
 peso_grupo numeric(9,2)
);


ALTER TABLE public.sgm_grupo_checklist OWNER TO postgres;

--
-- TOC entry 13209 (class 0 OID 0)
-- Dependencies: 1184
-- Name: TABLE sgm_grupo_checklist; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_grupo_checklist IS 'Merenda Escolar - Grupo para o Checklist';


--
-- TOC entry 1185 (class 1259 OID 14565768)
-- Name: sgm_grupo_inspecao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_grupo_inspecao_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_grupo_inspecao_id_seq OWNER TO postgres;

--
-- TOC entry 1186 (class 1259 OID 14565770)
-- Name: sgm_grupo_inspecao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_grupo_inspecao (
 id_bas_empresa bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_grupo_inspecao_id_seq'::regclass) NOT NULL,
 nome character varying(30),
 descricao text,
 peso_grupo numeric(9,2)
);


ALTER TABLE public.sgm_grupo_inspecao OWNER TO postgres;

--
-- TOC entry 13210 (class 0 OID 0)
-- Dependencies: 1186
-- Name: TABLE sgm_grupo_inspecao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_grupo_inspecao IS 'Merenda Escolar - Grupo para o Inspecao';


--
-- TOC entry 1187 (class 1259 OID 14565777)
-- Name: sgm_inativacao_cardapio_receita_material_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_inativacao_cardapio_receita_material_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_inativacao_cardapio_receita_material_id_seq OWNER TO postgres;

--
-- TOC entry 1188 (class 1259 OID 14565779)
-- Name: sgm_inativacao_cardapio_receita_material; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_inativacao_cardapio_receita_material (
 id_bas_empresa bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_inativacao_cardapio_receita_material_id_seq'::regclass) NOT NULL,
 data_inativacao date,
 id_sgm_acao_preventiva bigint,
 id_sgm_cardapio bigint,
 id_sgm_receita bigint NOT NULL,
 id_sga_material bigint,
 id_sgm_motivo_inativacao bigint NOT NULL,
 observacao text,
 check_inativa character(1)
);


ALTER TABLE public.sgm_inativacao_cardapio_receita_material OWNER TO postgres;

--
-- TOC entry 13211 (class 0 OID 0)
-- Dependencies: 1188
-- Name: TABLE sgm_inativacao_cardapio_receita_material; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_inativacao_cardapio_receita_material IS 'Merenda Escolar - Inativação de Cardápio / Receita / Material';


--
-- TOC entry 1189 (class 1259 OID 14565786)
-- Name: sgm_indicador_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_indicador_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_indicador_id_seq OWNER TO postgres;

--
-- TOC entry 1190 (class 1259 OID 14565788)
-- Name: sgm_indicador; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_indicador (
 id_bas_empresa bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_indicador_id_seq'::regclass) NOT NULL,
 descricao text,
 data_registro date,
 id_bas_estabelecimento bigint,
 id_sge_curso bigint,
 id_sge_faixa_etaria bigint,
 id_sge_serie bigint,
 id_sge_turma bigint,
 id_sgm_acao_preventiva bigint,
 id_sge_aluno bigint
);


ALTER TABLE public.sgm_indicador OWNER TO postgres;

--
-- TOC entry 13212 (class 0 OID 0)
-- Dependencies: 1190
-- Name: TABLE sgm_indicador; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_indicador IS 'Merenda Escolar - Indicador';


--
-- TOC entry 1191 (class 1259 OID 14565795)
-- Name: sgm_indicador_aluno_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_indicador_aluno_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_indicador_aluno_id_seq OWNER TO postgres;

--
-- TOC entry 1192 (class 1259 OID 14565797)
-- Name: sgm_indicador_aluno; Type: TABLE; Schema: public; Owner: pgadmin
--

CREATE TABLE public.sgm_indicador_aluno (
 id_bas_empresa bigint NOT NULL,
 id_sgm_indicador bigint NOT NULL,
 id_sge_aluno bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_indicador_aluno_id_seq'::regclass) NOT NULL,
 descricao text
);


ALTER TABLE public.sgm_indicador_aluno OWNER TO pgadmin;

--
-- TOC entry 1193 (class 1259 OID 14565804)
-- Name: sgm_indicador_aluno_tipo_indicador_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_indicador_aluno_tipo_indicador_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_indicador_aluno_tipo_indicador_id_seq OWNER TO postgres;

--
-- TOC entry 1194 (class 1259 OID 14565806)
-- Name: sgm_indicador_aluno_tipo_indicador; Type: TABLE; Schema: public; Owner: pgadmin
--

CREATE TABLE public.sgm_indicador_aluno_tipo_indicador (
 id_bas_empresa bigint NOT NULL,
 id_sgm_indicador bigint NOT NULL,
 id_sgm_indicador_aluno bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_indicador_aluno_tipo_indicador_id_seq'::regclass) NOT NULL,
 id_sgm_tipo_indicador bigint NOT NULL,
 valor numeric(9,2)
);


ALTER TABLE public.sgm_indicador_aluno_tipo_indicador OWNER TO pgadmin;

--
-- TOC entry 1195 (class 1259 OID 14565810)
-- Name: sgm_indicador_carencia_nutriente_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_indicador_carencia_nutriente_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_indicador_carencia_nutriente_id_seq OWNER TO postgres;

--
-- TOC entry 1196 (class 1259 OID 14565812)
-- Name: sgm_indicador_carencia_nutriente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_indicador_carencia_nutriente (
 id_bas_empresa bigint NOT NULL,
 id_sgm_indicador bigint NOT NULL,
 id_sgm_nutriente bigint NOT NULL,
 observacao text,
 id bigint DEFAULT nextval('public.sgm_indicador_carencia_nutriente_id_seq'::regclass) NOT NULL
);


ALTER TABLE public.sgm_indicador_carencia_nutriente OWNER TO postgres;

--
-- TOC entry 13213 (class 0 OID 0)
-- Dependencies: 1196
-- Name: TABLE sgm_indicador_carencia_nutriente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_indicador_carencia_nutriente IS 'Merenda Escolar - Indicador / Carência de Nutrientes';


--
-- TOC entry 1197 (class 1259 OID 14565819)
-- Name: sgm_indicador_tipo_indicador_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_indicador_tipo_indicador_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_indicador_tipo_indicador_id_seq OWNER TO postgres;

--
-- TOC entry 1198 (class 1259 OID 14565821)
-- Name: sgm_indicador_tipo_indicador; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_indicador_tipo_indicador (
 id_bas_empresa bigint NOT NULL,
 id_sgm_indicador bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_indicador_tipo_indicador_id_seq'::regclass) NOT NULL,
 id_sgm_tipo_indicador bigint NOT NULL,
 valor numeric(9,2)
);


ALTER TABLE public.sgm_indicador_tipo_indicador OWNER TO postgres;

--
-- TOC entry 13214 (class 0 OID 0)
-- Dependencies: 1198
-- Name: TABLE sgm_indicador_tipo_indicador; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_indicador_tipo_indicador IS 'Merenda Escolar - Indicador x Tipo de Indicador';


--
-- TOC entry 1199 (class 1259 OID 14565825)
-- Name: sgm_inspecao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_inspecao_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_inspecao_id_seq OWNER TO postgres;

--
-- TOC entry 1200 (class 1259 OID 14565827)
-- Name: sgm_inspecao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_inspecao (
 id_bas_empresa bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_inspecao_id_seq'::regclass) NOT NULL,
 data_preenchimento date,
 id_bas_estabelecimento bigint,
 login_digitador character varying(32),
 id_bas_colaborador_responsavel bigint,
 id_sgm_grupo_inspecao bigint,
 descricao text
);


ALTER TABLE public.sgm_inspecao OWNER TO postgres;

--
-- TOC entry 13215 (class 0 OID 0)
-- Dependencies: 1200
-- Name: TABLE sgm_inspecao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_inspecao IS 'Merenda Escolar - Inspecao';


--
-- TOC entry 1201 (class 1259 OID 14565834)
-- Name: sgm_inspecao_respostas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_inspecao_respostas_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_inspecao_respostas_id_seq OWNER TO postgres;

--
-- TOC entry 1202 (class 1259 OID 14565836)
-- Name: sgm_inspecao_respostas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_inspecao_respostas (
 id_bas_empresa bigint NOT NULL,
 id_sgm_inspecao bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_inspecao_respostas_id_seq'::regclass) NOT NULL,
 id_sgm_pergunta_inspecao bigint NOT NULL,
 check_sim_nao_na_nota character varying(2),
 descricao text
);


ALTER TABLE public.sgm_inspecao_respostas OWNER TO postgres;

--
-- TOC entry 13216 (class 0 OID 0)
-- Dependencies: 1202
-- Name: TABLE sgm_inspecao_respostas; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_inspecao_respostas IS 'Merenda Escolar - Inspecao / Respostas';


--
-- TOC entry 1203 (class 1259 OID 14565843)
-- Name: sgm_mapa_entrega_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_mapa_entrega_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_mapa_entrega_id_seq OWNER TO postgres;

--
-- TOC entry 1204 (class 1259 OID 14565845)
-- Name: sgm_mapa_entrega; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_mapa_entrega (
 id_bas_empresa bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_mapa_entrega_id_seq'::regclass) NOT NULL,
 id_sgm_veiculo bigint,
 data_mapa date NOT NULL,
 data_inicial date,
 data_final date,
 situacao character(1)
);


ALTER TABLE public.sgm_mapa_entrega OWNER TO postgres;

--
-- TOC entry 13217 (class 0 OID 0)
-- Dependencies: 1204
-- Name: TABLE sgm_mapa_entrega; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_mapa_entrega IS 'Merenda Escolar - Mapa de Entrega';


--
-- TOC entry 1205 (class 1259 OID 14565849)
-- Name: sgm_mapa_entrega_estabelecimento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_mapa_entrega_estabelecimento (
 id_bas_empresa bigint NOT NULL,
 id_sgm_mapa_entrega bigint NOT NULL,
 id_bas_estabelecimento bigint NOT NULL
);


ALTER TABLE public.sgm_mapa_entrega_estabelecimento OWNER TO postgres;

--
-- TOC entry 13218 (class 0 OID 0)
-- Dependencies: 1205
-- Name: TABLE sgm_mapa_entrega_estabelecimento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_mapa_entrega_estabelecimento IS 'Merenda Escolar - Mapa de Entrega / Estabelecimento';


--
-- TOC entry 1206 (class 1259 OID 14565852)
-- Name: sgm_mapa_entrega_necessidade_material; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_mapa_entrega_necessidade_material (
 id_bas_empresa bigint NOT NULL,
 id_sgm_mapa_entrega bigint NOT NULL,
 id_sgm_necessidade_compra bigint NOT NULL,
 id_sga_material bigint NOT NULL,
 data_necessidade date NOT NULL,
 quantidade_material numeric(9,2) NOT NULL,
 data_entrega timestamp without time zone,
 id_bas_estabelecimento bigint NOT NULL
);


ALTER TABLE public.sgm_mapa_entrega_necessidade_material OWNER TO postgres;

--
-- TOC entry 13219 (class 0 OID 0)
-- Dependencies: 1206
-- Name: TABLE sgm_mapa_entrega_necessidade_material; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_mapa_entrega_necessidade_material IS 'Merenda Escolar - Mapa de Entrega / Necessidade de Material';


--
-- TOC entry 1207 (class 1259 OID 14565855)
-- Name: sgm_material; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_material (
 id_bas_empresa bigint NOT NULL,
 id_sga_material bigint NOT NULL,
 id_bas_estabelecimento bigint NOT NULL,
 caloria numeric(9,2),
 meses_entressafra character varying(38),
 id_sgm_material_substituto bigint,
 periodicidade_entrega_dias bigint,
 id_sgm_unidade_medida bigint,
 quantidade_unidade_medida numeric(9,2),
 situacao character(1),
 controla_validade character(1),
 digita_lote character(1),
 data_inativacao date,
 justificativa_inativacao text,
 id_sga_unidade_medida bigint
);


ALTER TABLE public.sgm_material OWNER TO postgres;

--
-- TOC entry 13220 (class 0 OID 0)
-- Dependencies: 1207
-- Name: COLUMN sgm_material.meses_entressafra; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgm_material.meses_entressafra IS '1 - Janeiro
2- Fevereiro
3- Março
4- Abril
5- Maio
6- Junho
7- Julho
8- Agosto
9- Setembro
10- Outubro
11- Novembro
12- Dezembro';


--
-- TOC entry 1208 (class 1259 OID 14565861)
-- Name: sgm_material_lote; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_material_lote (
 id_bas_empresa bigint NOT NULL,
 id_sga_material bigint NOT NULL,
 id_sga_almoxarifado bigint NOT NULL,
 numero_lote character varying(10) NOT NULL,
 data_validade_lote date NOT NULL,
 quantidade_atual numeric(9,2)
);


ALTER TABLE public.sgm_material_lote OWNER TO postgres;

--
-- TOC entry 13221 (class 0 OID 0)
-- Dependencies: 1208
-- Name: TABLE sgm_material_lote; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_material_lote IS 'Merenda Escolar - Material x Lote';


--
-- TOC entry 1209 (class 1259 OID 14565864)
-- Name: sgm_material_nutriente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_material_nutriente (
 id_bas_empresa bigint NOT NULL,
 id_sga_material bigint NOT NULL,
 id_sgm_nutriente bigint NOT NULL,
 id_sga_unidade_medida bigint,
 quantidade_nutriente numeric(9,2)
);


ALTER TABLE public.sgm_material_nutriente OWNER TO postgres;

--
-- TOC entry 13222 (class 0 OID 0)
-- Dependencies: 1209
-- Name: TABLE sgm_material_nutriente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_material_nutriente IS 'Merenda Escolar - Tabela Nutricional';


--
-- TOC entry 1210 (class 1259 OID 14565867)
-- Name: sgm_material_unidade_medida_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_material_unidade_medida_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_material_unidade_medida_id_seq OWNER TO postgres;

--
-- TOC entry 1211 (class 1259 OID 14565869)
-- Name: sgm_material_unidade_medida; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_material_unidade_medida (
 id_bas_empresa bigint NOT NULL,
 id_sga_material bigint NOT NULL,
 id_sga_unidade_medida_origem bigint NOT NULL,
 id_sga_unidade_medida_destino bigint NOT NULL,
 quantidade_origem numeric(9,2),
 quantidade_destino numeric(9,2),
 observacao_medida character varying(10),
 id bigint DEFAULT nextval('public.sgm_material_unidade_medida_id_seq'::regclass) NOT NULL,
 apelido_medida character varying(10)
);


ALTER TABLE public.sgm_material_unidade_medida OWNER TO postgres;

--
-- TOC entry 13223 (class 0 OID 0)
-- Dependencies: 1211
-- Name: TABLE sgm_material_unidade_medida; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_material_unidade_medida IS 'Merenda Escolar - Material x Unidade Medida';


--
-- TOC entry 1212 (class 1259 OID 14565873)
-- Name: sgm_metodo_teste_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_metodo_teste_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_metodo_teste_id_seq OWNER TO postgres;

--
-- TOC entry 1213 (class 1259 OID 14565875)
-- Name: sgm_metodo_teste; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_metodo_teste (
 id_bas_empresa bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_metodo_teste_id_seq'::regclass) NOT NULL,
 nome character varying(20),
 descricao text
);


ALTER TABLE public.sgm_metodo_teste OWNER TO postgres;

--
-- TOC entry 13224 (class 0 OID 0)
-- Dependencies: 1213
-- Name: TABLE sgm_metodo_teste; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_metodo_teste IS 'Merenda Escolar - Metodo Teste de Aceitabilidade';


--
-- TOC entry 1214 (class 1259 OID 14565882)
-- Name: sgm_motivo_inativacao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_motivo_inativacao_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_motivo_inativacao_id_seq OWNER TO postgres;

--
-- TOC entry 1215 (class 1259 OID 14565884)
-- Name: sgm_motivo_inativacao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_motivo_inativacao (
 id_bas_empresa bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_motivo_inativacao_id_seq'::regclass) NOT NULL,
 nome character varying(50),
 descricao text
);


ALTER TABLE public.sgm_motivo_inativacao OWNER TO postgres;

--
-- TOC entry 13225 (class 0 OID 0)
-- Dependencies: 1215
-- Name: TABLE sgm_motivo_inativacao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_motivo_inativacao IS 'Merenda Escolar - Motivo Inativação Cardápio / Receita / Material';


--
-- TOC entry 1216 (class 1259 OID 14565891)
-- Name: sgm_necessidade_compra_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_necessidade_compra_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_necessidade_compra_id_seq OWNER TO postgres;

--
-- TOC entry 1217 (class 1259 OID 14565893)
-- Name: sgm_necessidade_compra; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_necessidade_compra (
 id_bas_empresa bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_necessidade_compra_id_seq'::regclass) NOT NULL,
 id_sgm_polo bigint,
 id_bas_estabelecimento bigint,
 id_sge_faixa_etaria bigint,
 id_sge_serie bigint,
 id_sge_curso bigint,
 id_sge_turma bigint,
 id_sga_almoxarifado bigint,
 data_registro date NOT NULL,
 data_inicial date NOT NULL,
 data_final date NOT NULL,
 qtd_media_matricula bigint,
 situacao character(1),
 id_sgm_cardapio_tipo bigint,
 agrupamento_meses bigint
);


ALTER TABLE public.sgm_necessidade_compra OWNER TO postgres;

--
-- TOC entry 13226 (class 0 OID 0)
-- Dependencies: 1217
-- Name: TABLE sgm_necessidade_compra; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_necessidade_compra IS 'Merenda Escolar - Necessidade de Compra';


--
-- TOC entry 1218 (class 1259 OID 14565897)
-- Name: sgm_necessidade_compra_material; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_necessidade_compra_material (
 id_bas_empresa bigint NOT NULL,
 id_sgm_necessidade_compra bigint NOT NULL,
 id_sga_material bigint NOT NULL,
 data_necessidade date NOT NULL,
 id_sga_sugestao_compra_material bigint,
 quantidade_necessaria numeric(10,4),
 situacao character(1)
);


ALTER TABLE public.sgm_necessidade_compra_material OWNER TO postgres;

--
-- TOC entry 13227 (class 0 OID 0)
-- Dependencies: 1218
-- Name: TABLE sgm_necessidade_compra_material; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_necessidade_compra_material IS 'Merenda Escolar - Necessidade de Compra x Material';


--
-- TOC entry 1219 (class 1259 OID 14565900)
-- Name: sgm_nutriente_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_nutriente_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_nutriente_id_seq OWNER TO postgres;

--
-- TOC entry 1220 (class 1259 OID 14565902)
-- Name: sgm_nutriente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_nutriente (
 id bigint DEFAULT nextval('public.sgm_nutriente_id_seq'::regclass) NOT NULL,
 nome character varying(100) NOT NULL,
 id_sgm_unidade_medida bigint,
 quantidade_unidade_medida numeric(9,2)
);


ALTER TABLE public.sgm_nutriente OWNER TO postgres;

--
-- TOC entry 13228 (class 0 OID 0)
-- Dependencies: 1220
-- Name: TABLE sgm_nutriente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_nutriente IS 'Merenda Escolar - Nutriente';


--
-- TOC entry 1221 (class 1259 OID 14565906)
-- Name: sgm_orientacao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_orientacao_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_orientacao_id_seq OWNER TO postgres;

--
-- TOC entry 1222 (class 1259 OID 14565908)
-- Name: sgm_orientacao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_orientacao (
 id_bas_empresa bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_orientacao_id_seq'::regclass) NOT NULL,
 tipo_treina character(1),
 tema character varying(50),
 carga_horaria numeric(9,2),
 nome_palestrante_esquerda character varying(50),
 nome_palestrante_direita character varying(50),
 funcao_palestrante_esquerda character varying(50),
 funcao_palestrante_direita character varying(50),
 observacao text,
 id_sgm_acao_preventiva bigint
);


ALTER TABLE public.sgm_orientacao OWNER TO postgres;

--
-- TOC entry 13229 (class 0 OID 0)
-- Dependencies: 1222
-- Name: TABLE sgm_orientacao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_orientacao IS 'Merenda Escolar - Orientação';


--
-- TOC entry 1223 (class 1259 OID 14565915)
-- Name: sgm_orientacao_data_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_orientacao_data_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_orientacao_data_id_seq OWNER TO postgres;

--
-- TOC entry 1224 (class 1259 OID 14565917)
-- Name: sgm_orientacao_data; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_orientacao_data (
 id_bas_empresa bigint NOT NULL,
 id_sgm_orientacao bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_orientacao_data_id_seq'::regclass) NOT NULL,
 data_orientacao date,
 hora_inicial timestamp without time zone,
 hora_final timestamp without time zone
);


ALTER TABLE public.sgm_orientacao_data OWNER TO postgres;

--
-- TOC entry 13230 (class 0 OID 0)
-- Dependencies: 1224
-- Name: TABLE sgm_orientacao_data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_orientacao_data IS 'Merenda Escolar - Orientação / Data';


--
-- TOC entry 1225 (class 1259 OID 14565921)
-- Name: sgm_orientacao_data_participante_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_orientacao_data_participante_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_orientacao_data_participante_id_seq OWNER TO postgres;

--
-- TOC entry 1226 (class 1259 OID 14565923)
-- Name: sgm_orientacao_data_participante; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_orientacao_data_participante (
 id_bas_empresa bigint NOT NULL,
 id_sgm_orientacao bigint NOT NULL,
 id_sgm_orientacao_data bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_orientacao_data_participante_id_seq'::regclass) NOT NULL,
 id_bas_colaborador_participante bigint
);


ALTER TABLE public.sgm_orientacao_data_participante OWNER TO postgres;

--
-- TOC entry 13231 (class 0 OID 0)
-- Dependencies: 1226
-- Name: TABLE sgm_orientacao_data_participante; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_orientacao_data_participante IS 'Merenda Escolar - Orientação / Data / Participante';


--
-- TOC entry 1227 (class 1259 OID 14565927)
-- Name: sgm_orientacao_questionario_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_orientacao_questionario_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_orientacao_questionario_id_seq OWNER TO postgres;

--
-- TOC entry 1228 (class 1259 OID 14565929)
-- Name: sgm_orientacao_questionario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_orientacao_questionario (
 id_bas_empresa bigint NOT NULL,
 id_sgm_orientacao bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_orientacao_questionario_id_seq'::regclass) NOT NULL,
 questao text,
 tipo_questao character(1)
);


ALTER TABLE public.sgm_orientacao_questionario OWNER TO postgres;

--
-- TOC entry 13232 (class 0 OID 0)
-- Dependencies: 1228
-- Name: TABLE sgm_orientacao_questionario; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_orientacao_questionario IS 'Merenda Escolar - Orientação / Questionário';


--
-- TOC entry 1229 (class 1259 OID 14565936)
-- Name: sgm_pergunta_checklist_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_pergunta_checklist_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_pergunta_checklist_id_seq OWNER TO postgres;

--
-- TOC entry 1230 (class 1259 OID 14565938)
-- Name: sgm_pergunta_checklist; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_pergunta_checklist (
 id_bas_empresa bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_pergunta_checklist_id_seq'::regclass) NOT NULL,
 id_sgm_grupo_checklist bigint NOT NULL,
 tipo_pergunta character(1),
 nome character varying(200),
 peso_sim numeric(9,2),
 peso_nao numeric(9,2),
 peso_na numeric(9,2),
 peso_nota numeric(9,2),
 observacao text,
 ativo character(1)
);


ALTER TABLE public.sgm_pergunta_checklist OWNER TO postgres;

--
-- TOC entry 13233 (class 0 OID 0)
-- Dependencies: 1230
-- Name: TABLE sgm_pergunta_checklist; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_pergunta_checklist IS 'Merenda Escolar - pergunta para o Checklist';


--
-- TOC entry 1231 (class 1259 OID 14565945)
-- Name: sgm_pergunta_inspecao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_pergunta_inspecao_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_pergunta_inspecao_id_seq OWNER TO postgres;

--
-- TOC entry 1232 (class 1259 OID 14565947)
-- Name: sgm_pergunta_inspecao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_pergunta_inspecao (
 id_bas_empresa bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_pergunta_inspecao_id_seq'::regclass) NOT NULL,
 id_sgm_grupo_inspecao bigint NOT NULL,
 tipo_pergunta character(1),
 nome character varying(200),
 peso_sim numeric(9,2),
 peso_nao numeric(9,2),
 peso_na numeric(9,2),
 peso_nota numeric(9,2),
 observacao text,
 ativo character(1)
);


ALTER TABLE public.sgm_pergunta_inspecao OWNER TO postgres;

--
-- TOC entry 13234 (class 0 OID 0)
-- Dependencies: 1232
-- Name: TABLE sgm_pergunta_inspecao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_pergunta_inspecao IS 'Merenda Escolar - pergunta para o Inspecao';


--
-- TOC entry 1233 (class 1259 OID 14565954)
-- Name: sgm_polo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_polo_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_polo_id_seq OWNER TO postgres;

--
-- TOC entry 1234 (class 1259 OID 14565956)
-- Name: sgm_polo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_polo (
 id_bas_empresa bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_polo_id_seq'::regclass) NOT NULL,
 sigla character varying(7) NOT NULL,
 nome character varying(25) NOT NULL,
 descricao text,
 id_sga_almoxarifado_unidade_controladora bigint
);


ALTER TABLE public.sgm_polo OWNER TO postgres;

--
-- TOC entry 13235 (class 0 OID 0)
-- Dependencies: 1234
-- Name: TABLE sgm_polo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_polo IS 'Merenda Escolar - Polo';


--
-- TOC entry 1235 (class 1259 OID 14565963)
-- Name: sgm_programa_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_programa_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_programa_id_seq OWNER TO postgres;

--
-- TOC entry 1236 (class 1259 OID 14565965)
-- Name: sgm_programa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_programa (
 id_bas_empresa bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_programa_id_seq'::regclass) NOT NULL,
 nome character varying(100) NOT NULL,
 valor_percapita numeric(9,2)
);


ALTER TABLE public.sgm_programa OWNER TO postgres;

--
-- TOC entry 13236 (class 0 OID 0)
-- Dependencies: 1236
-- Name: TABLE sgm_programa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_programa IS 'Merenda Escolar - Programa';


--
-- TOC entry 1237 (class 1259 OID 14565969)
-- Name: sgm_programa_serie_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_programa_serie_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_programa_serie_id_seq OWNER TO postgres;

--
-- TOC entry 1238 (class 1259 OID 14565971)
-- Name: sgm_programa_verba_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_programa_verba_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_programa_verba_id_seq OWNER TO postgres;

--
-- TOC entry 1239 (class 1259 OID 14565973)
-- Name: sgm_programa_verba; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_programa_verba (
 id_bas_empresa bigint NOT NULL,
 id_sgm_programa bigint NOT NULL,
 fonte_recurso character(1) NOT NULL,
 id bigint DEFAULT nextval('public.sgm_programa_verba_id_seq'::regclass) NOT NULL,
 id_sge_curso bigint NOT NULL,
 id_sgf_recebimento_deposito bigint,
 numero_ob character varying(10),
 valor_repasse numeric(9,2),
 data_repasse date
);


ALTER TABLE public.sgm_programa_verba OWNER TO postgres;

--
-- TOC entry 13237 (class 0 OID 0)
-- Dependencies: 1239
-- Name: TABLE sgm_programa_verba; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_programa_verba IS 'Merenda Escolar - Programa / Verba';


--
-- TOC entry 1240 (class 1259 OID 14565977)
-- Name: sgm_recebimento_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_recebimento_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_recebimento_id_seq OWNER TO postgres;

--
-- TOC entry 1241 (class 1259 OID 14565979)
-- Name: sgm_recebimento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_recebimento (
 id_bas_empresa bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_recebimento_id_seq'::regclass) NOT NULL,
 id_bas_colaborador bigint,
 observacao text,
 data_recebimento date,
 id_sga_almoxarifado bigint NOT NULL
);


ALTER TABLE public.sgm_recebimento OWNER TO postgres;

--
-- TOC entry 13238 (class 0 OID 0)
-- Dependencies: 1241
-- Name: TABLE sgm_recebimento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_recebimento IS 'Merenda Escolar - Recebimento / Lote';


--
-- TOC entry 1242 (class 1259 OID 14565986)
-- Name: sgm_recebimento_lote_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_recebimento_lote_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_recebimento_lote_id_seq OWNER TO postgres;

--
-- TOC entry 1243 (class 1259 OID 14565988)
-- Name: sgm_recebimento_lote; Type: TABLE; Schema: public; Owner: pgadmin
--

CREATE TABLE public.sgm_recebimento_lote (
 id_bas_empresa bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_recebimento_lote_id_seq'::regclass) NOT NULL,
 id_sgm_recebimento bigint NOT NULL,
 quantidade_recebida numeric(9,2),
 data_validade_lote date,
 numero_lote character varying(10),
 id_sga_material bigint NOT NULL,
 quantidade_atual bigint NOT NULL
);


ALTER TABLE public.sgm_recebimento_lote OWNER TO pgadmin;

--
-- TOC entry 1244 (class 1259 OID 14565992)
-- Name: sgm_receita_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_receita_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_receita_id_seq OWNER TO postgres;

--
-- TOC entry 1245 (class 1259 OID 14565994)
-- Name: sgm_receita; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_receita (
 id_bas_empresa bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_receita_id_seq'::regclass) NOT NULL,
 data_registro date NOT NULL,
 nome character varying(50),
 modo_preparo text,
 valor_custo numeric(9,2),
 valor_calorico numeric(9,2),
 tipo character(1),
 caminho_anexo character varying(200),
 situacao character(1),
 data_inativacao date,
 nutricionista_responsavel character varying(100),
 justificativa_inativacao text
);


ALTER TABLE public.sgm_receita OWNER TO postgres;

--
-- TOC entry 13239 (class 0 OID 0)
-- Dependencies: 1245
-- Name: TABLE sgm_receita; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_receita IS 'Merenda Escolar - Receita';


--
-- TOC entry 1246 (class 1259 OID 14566001)
-- Name: sgm_receita_material; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_receita_material (
 id_bas_empresa bigint NOT NULL,
 id_sgm_receita bigint NOT NULL,
 id_sga_material bigint NOT NULL,
 id_sga_unidade_medida bigint,
 quantidade_material numeric(9,2),
 quantidade_convertida numeric(9,2)
);


ALTER TABLE public.sgm_receita_material OWNER TO postgres;

--
-- TOC entry 13240 (class 0 OID 0)
-- Dependencies: 1246
-- Name: TABLE sgm_receita_material; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_receita_material IS 'Merenda Escolar - Receita X Material';


--
-- TOC entry 1247 (class 1259 OID 14566004)
-- Name: sgm_solicitacao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_solicitacao_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_solicitacao_id_seq OWNER TO postgres;

--
-- TOC entry 1248 (class 1259 OID 14566006)
-- Name: sgm_solicitacao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_solicitacao (
 id_bas_empresa bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_solicitacao_id_seq'::regclass) NOT NULL,
 data_solicitacao date NOT NULL,
 id_bas_colaborador bigint NOT NULL,
 id_sgm_cantina_origem bigint NOT NULL,
 id_sgm_cantina_destino bigint NOT NULL,
 observacao text,
 situacao character(1)
);


ALTER TABLE public.sgm_solicitacao OWNER TO postgres;

--
-- TOC entry 13241 (class 0 OID 0)
-- Dependencies: 1248
-- Name: TABLE sgm_solicitacao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_solicitacao IS 'Merenda Escolar - Solicitação';


--
-- TOC entry 1249 (class 1259 OID 14566013)
-- Name: sgm_solicitacao_material_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_solicitacao_material_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_solicitacao_material_id_seq OWNER TO postgres;

--
-- TOC entry 1250 (class 1259 OID 14566015)
-- Name: sgm_solicitacao_material; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_solicitacao_material (
 id_bas_empresa bigint NOT NULL,
 id_sgm_solicitacao bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_solicitacao_material_id_seq'::regclass) NOT NULL,
 id_sga_material bigint NOT NULL,
 id_bas_colaborador bigint NOT NULL,
 login_digitador character varying(32),
 quantidade_solicitada numeric(9,2),
 quantidade_atendida numeric(9,2)
);


ALTER TABLE public.sgm_solicitacao_material OWNER TO postgres;

--
-- TOC entry 13242 (class 0 OID 0)
-- Dependencies: 1250
-- Name: TABLE sgm_solicitacao_material; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_solicitacao_material IS 'Merenda Escolar - Solicitação / Material';


--
-- TOC entry 1251 (class 1259 OID 14566019)
-- Name: sgm_tabela_referencia_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_tabela_referencia_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_tabela_referencia_id_seq OWNER TO postgres;

--
-- TOC entry 1252 (class 1259 OID 14566021)
-- Name: sgm_tabela_referencia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_tabela_referencia (
 id_bas_empresa bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_tabela_referencia_id_seq'::regclass) NOT NULL,
 id_sgm_polo bigint,
 id_bas_estabelecimento bigint,
 id_sge_faixa_etaria bigint,
 id_sge_curso bigint,
 id_sge_serie bigint,
 valor_calorico numeric(9,2)
);


ALTER TABLE public.sgm_tabela_referencia OWNER TO postgres;

--
-- TOC entry 13243 (class 0 OID 0)
-- Dependencies: 1252
-- Name: TABLE sgm_tabela_referencia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_tabela_referencia IS 'Merenda Escolar - Tabela Referência';


--
-- TOC entry 1253 (class 1259 OID 14566025)
-- Name: sgm_tabela_referencia_nutriente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_tabela_referencia_nutriente (
 id_bas_empresa bigint NOT NULL,
 id_sgm_tabela_referencia bigint NOT NULL,
 id_sgm_nutriente bigint NOT NULL,
 quantidade_nutriente numeric(9,2) NOT NULL,
 id_sgm_unidade_medida bigint,
 id_sga_unidade_medida bigint
);


ALTER TABLE public.sgm_tabela_referencia_nutriente OWNER TO postgres;

--
-- TOC entry 13244 (class 0 OID 0)
-- Dependencies: 1253
-- Name: TABLE sgm_tabela_referencia_nutriente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_tabela_referencia_nutriente IS 'Merenda Escolar - Tabela Referência x Nutriente';


--
-- TOC entry 1254 (class 1259 OID 14566028)
-- Name: sgm_tipo_contato_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_tipo_contato_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_tipo_contato_id_seq OWNER TO postgres;

--
-- TOC entry 1255 (class 1259 OID 14566030)
-- Name: sgm_tipo_contato; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_tipo_contato (
 id_bas_empresa bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_tipo_contato_id_seq'::regclass) NOT NULL,
 nome character varying(100)
);


ALTER TABLE public.sgm_tipo_contato OWNER TO postgres;

--
-- TOC entry 13245 (class 0 OID 0)
-- Dependencies: 1255
-- Name: TABLE sgm_tipo_contato; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_tipo_contato IS 'Merenda Escolar - Tipo de Contato';


--
-- TOC entry 1256 (class 1259 OID 14566034)
-- Name: sgm_tipo_indicador_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_tipo_indicador_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_tipo_indicador_id_seq OWNER TO postgres;

--
-- TOC entry 1257 (class 1259 OID 14566036)
-- Name: sgm_tipo_indicador; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_tipo_indicador (
 id_bas_empresa bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_tipo_indicador_id_seq'::regclass) NOT NULL,
 nome character varying(200)
);


ALTER TABLE public.sgm_tipo_indicador OWNER TO postgres;

--
-- TOC entry 13246 (class 0 OID 0)
-- Dependencies: 1257
-- Name: TABLE sgm_tipo_indicador; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_tipo_indicador IS 'Merenda Escolar - Tipo de Indicador';


--
-- TOC entry 1258 (class 1259 OID 14566040)
-- Name: sgm_veiculo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_veiculo_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_veiculo_id_seq OWNER TO postgres;

--
-- TOC entry 1259 (class 1259 OID 14566042)
-- Name: sgm_veiculo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_veiculo (
 id_bas_empresa bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_veiculo_id_seq'::regclass) NOT NULL,
 id_sgm_veiculo_marca bigint,
 id_sgm_veiculo_modelo bigint,
 placa character varying(7) NOT NULL,
 proprio character(1),
 capacidade_kg numeric(9,2),
 cor_calendar character varying(8)
);


ALTER TABLE public.sgm_veiculo OWNER TO postgres;

--
-- TOC entry 13247 (class 0 OID 0)
-- Dependencies: 1259
-- Name: TABLE sgm_veiculo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_veiculo IS 'Merenda Escolar - Veículo';


--
-- TOC entry 13248 (class 0 OID 0)
-- Dependencies: 1259
-- Name: COLUMN sgm_veiculo.proprio; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sgm_veiculo.proprio IS '0- Não
1- Sim';


--
-- TOC entry 1260 (class 1259 OID 14566046)
-- Name: sgm_veiculo_agenda_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_veiculo_agenda_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_veiculo_agenda_id_seq OWNER TO postgres;

--
-- TOC entry 1261 (class 1259 OID 14566048)
-- Name: sgm_veiculo_agenda; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_veiculo_agenda (
 id_bas_empresa bigint NOT NULL,
 id_sgm_veiculo bigint NOT NULL,
 id bigint DEFAULT nextval('public.sgm_veiculo_agenda_id_seq'::regclass) NOT NULL,
 id_bas_estabelecimento bigint NOT NULL,
 id_sgm_mapa_entrega bigint NOT NULL,
 id_sga_material bigint NOT NULL,
 quantidade_material numeric(9,2),
 data_veiculo date,
 hora_veiculo time without time zone
);


ALTER TABLE public.sgm_veiculo_agenda OWNER TO postgres;

--
-- TOC entry 13249 (class 0 OID 0)
-- Dependencies: 1261
-- Name: TABLE sgm_veiculo_agenda; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_veiculo_agenda IS 'Merenda Escolar - Veículo / Agenda';


--
-- TOC entry 1262 (class 1259 OID 14566052)
-- Name: sgm_veiculo_marca_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_veiculo_marca_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_veiculo_marca_id_seq OWNER TO postgres;

--
-- TOC entry 1263 (class 1259 OID 14566054)
-- Name: sgm_veiculo_marca; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_veiculo_marca (
 id bigint DEFAULT nextval('public.sgm_veiculo_marca_id_seq'::regclass) NOT NULL,
 nome character varying(50) NOT NULL
);


ALTER TABLE public.sgm_veiculo_marca OWNER TO postgres;

--
-- TOC entry 13250 (class 0 OID 0)
-- Dependencies: 1263
-- Name: TABLE sgm_veiculo_marca; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_veiculo_marca IS 'Merenda Escolar - Veículo / Marca';


--
-- TOC entry 1264 (class 1259 OID 14566058)
-- Name: sgm_veiculo_modelo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgm_veiculo_modelo_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgm_veiculo_modelo_id_seq OWNER TO postgres;

--
-- TOC entry 1265 (class 1259 OID 14566060)
-- Name: sgm_veiculo_modelo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgm_veiculo_modelo (
 id bigint DEFAULT nextval('public.sgm_veiculo_modelo_id_seq'::regclass) NOT NULL,
 id_sgm_veiculo_marca bigint,
 nome character varying(50) NOT NULL
);


ALTER TABLE public.sgm_veiculo_modelo OWNER TO postgres;

--
-- TOC entry 13251 (class 0 OID 0)
-- Dependencies: 1265
-- Name: TABLE sgm_veiculo_modelo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sgm_veiculo_modelo IS 'Merenda Escolar - Veículo / Modelo';


--
-- TOC entry 1283 (class 1259 OID 14694896)
-- Name: sgp_inatividade; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sgp_inatividade (
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(100) NOT NULL,
 sigla character(3)
);


ALTER TABLE public.sgp_inatividade OWNER TO postgres;

--
-- TOC entry 1282 (class 1259 OID 14694894)
-- Name: sgp_inatividade_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sgp_inatividade_id_seq
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;


ALTER TABLE public.sgp_inatividade_id_seq OWNER TO postgres;

--
-- TOC entry 13252 (class 0 OID 0)
-- Dependencies: 1282
-- Name: sgp_inatividade_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sgp_inatividade_id_seq OWNED BY public.sgp_inatividade.id;


--
-- TOC entry 1266 (class 1259 OID 14566064)
-- Name: view_max_curso_temp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view_max_curso_temp AS
 SELECT max(cur.id) AS id_sge_curso_max,
 cur2.id AS id_sge_curso
 FROM (public.sge_curso cur
 JOIN public.sge_curso cur2 ON ((upper(btrim((cur.nome)::text)) = upper(btrim((cur2.nome)::text)))))
 GROUP BY (upper(btrim((cur.nome)::text))), cur2.id
 ORDER BY (max(cur.id)), cur2.id;


ALTER TABLE public.view_max_curso_temp OWNER TO postgres;

--
-- TOC entry 1267 (class 1259 OID 14566069)
-- Name: view_max_serie_temp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view_max_serie_temp AS
 SELECT max(ser.id) AS id_sge_serie_max,
 ser2.id AS id_sge_serie
 FROM (public.sge_serie ser
 JOIN public.sge_serie ser2 ON (((ser.id_sge_curso = ser2.id_sge_curso) AND (upper(btrim((ser.nome)::text)) = upper(btrim((ser2.nome)::text))))))
 GROUP BY (upper(btrim((ser.nome)::text))), ser.id_sge_curso, ser2.id;


ALTER TABLE public.view_max_serie_temp OWNER TO postgres;

--
-- TOC entry 1268 (class 1259 OID 14566074)
-- Name: vw_bas_colaborador; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vw_bas_colaborador AS
 SELECT col.id AS id_bas_colaborador,
 col.id_bas_empresa,
 pes.nome AS nome_colaborador,
 col.id_bas_funcao,
 col.id_bas_profissao,
 pes.id AS id_bas_pessoa
 FROM (public.bas_colaborador col
 JOIN public.bas_pessoa pes ON (((pes.id_bas_empresa = col.id_bas_empresa) AND (col.id_bas_pessoa = pes.id))))
 ORDER BY pes.nome;


ALTER TABLE public.vw_bas_colaborador OWNER TO postgres;

--
-- TOC entry 1269 (class 1259 OID 14566079)
-- Name: vw_bas_colaborador_estabelecimento; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vw_bas_colaborador_estabelecimento AS
 SELECT col.id AS id_bas_colaborador,
 col.id_bas_empresa,
 ces.id_bas_estabelecimento,
 est.nome AS nome_estabelecimento,
 pes.nome AS nome_colaborador,
 col.id_bas_funcao,
 col.id_bas_profissao,
 pes.id AS id_bas_pessoa
 FROM (((public.bas_colaborador col
 JOIN public.bas_pessoa pes ON (((pes.id_bas_empresa = col.id_bas_empresa) AND (col.id_bas_pessoa = pes.id))))
 JOIN public.bas_colaborador_estabelecimento ces ON (((ces.id_bas_empresa = col.id_bas_empresa) AND (ces.id_bas_colaborador = col.id))))
 JOIN public.bas_estabelecimento est ON (((est.id_bas_empresa = ces.id_bas_empresa) AND (est.id = ces.id_bas_estabelecimento))))
 ORDER BY est.nome, pes.nome;


ALTER TABLE public.vw_bas_colaborador_estabelecimento OWNER TO postgres;

--
-- TOC entry 1270 (class 1259 OID 14566084)
-- Name: vw_est_curso_serie_turma; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vw_est_curso_serie_turma AS
 SELECT tur.id_bas_empresa,
 tur.id AS id_sge_turma,
 ser.id AS id_sge_serie,
 cur.id AS id_sge_curso,
 est.id AS id_bas_estabelecimento,
 tur.nome AS nome_turma,
 ser.nome AS nome_serie,
 cur.nome AS nome_curso,
 est.nome AS nome_estabelecimento
 FROM (((public.sge_turma tur
 JOIN public.sge_serie ser ON (((ser.id_bas_empresa = tur.id_bas_empresa) AND (ser.id = tur.id_sge_serie))))
 JOIN public.sge_curso cur ON (((cur.id_bas_empresa = ser.id_bas_empresa) AND (cur.id = ser.id_sge_curso))))
 JOIN public.bas_estabelecimento est ON (((est.id_bas_empresa = cur.id_bas_empresa) AND (cur.id_bas_estabelecimento = est.id))));


ALTER TABLE public.vw_est_curso_serie_turma OWNER TO postgres;

--
-- TOC entry 1271 (class 1259 OID 14566089)
-- Name: vw_est_curso_serie_turma_aluno_ano; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vw_est_curso_serie_turma_aluno_ano AS
 SELECT tal.id_bas_empresa,
 tal.id AS id_sge_turma_aluno,
 tur.id AS id_sge_turma,
 ser.id AS id_sge_serie,
 cur.id AS id_sge_curso,
 est.id AS id_bas_estabelecimento,
 tur.nome AS nome_turma,
 ser.nome AS nome_serie,
 cur.nome AS nome_curso,
 est.nome AS nome_estabelecimento,
 tal.ano_letivo,
 (((tur.nome)::text || ' - '::text) || (trn.nome)::text) AS nome_turma_turno
 FROM (((((public.sge_turma_aluno tal
 JOIN public.sge_turma tur ON (((tur.id_bas_empresa = tal.id_bas_empresa) AND (tur.id = tal.id_sge_turma))))
 JOIN public.sge_turno trn ON ((tur.id_sge_turno = trn.id)))
 JOIN public.sge_serie ser ON (((ser.id_bas_empresa = tur.id_bas_empresa) AND (ser.id = tur.id_sge_serie))))
 JOIN public.sge_curso cur ON (((cur.id_bas_empresa = ser.id_bas_empresa) AND (cur.id = ser.id_sge_curso))))
 JOIN public.bas_estabelecimento est ON (((est.id_bas_empresa = cur.id_bas_empresa) AND (cur.id_bas_estabelecimento = est.id))));


ALTER TABLE public.vw_est_curso_serie_turma_aluno_ano OWNER TO postgres;

--
-- TOC entry 1272 (class 1259 OID 14566094)
-- Name: vw_est_curso_serie_turma_aluno_ano_pessoa; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vw_est_curso_serie_turma_aluno_ano_pessoa AS
 SELECT tal.id_bas_empresa,
 tal.id AS id_sge_turma_aluno,
 tur.id AS id_sge_turma,
 ser.id AS id_sge_serie,
 cur.id AS id_sge_curso,
 est.id AS id_bas_estabelecimento,
 tur.nome AS nome_turma,
 ser.nome AS nome_serie,
 cur.nome AS nome_curso,
 est.nome AS nome_estabelecimento,
 tal.ano_letivo,
 alu.id AS id_sge_aluno,
 pes.id AS id_bas_pessoa,
 pes.nome AS nome_aluno,
 ser.ordem AS ordem_serie
 FROM ((((((public.sge_turma_aluno tal
 JOIN public.sge_turma tur ON (((tur.id_bas_empresa = tal.id_bas_empresa) AND (tur.id = tal.id_sge_turma))))
 JOIN public.sge_serie ser ON (((ser.id_bas_empresa = tur.id_bas_empresa) AND (ser.id = tur.id_sge_serie))))
 JOIN public.sge_curso cur ON (((cur.id_bas_empresa = ser.id_bas_empresa) AND (cur.id = ser.id_sge_curso))))
 JOIN public.sge_aluno alu ON (((alu.id_bas_empresa = tal.id_bas_empresa) AND (alu.id = tal.id_sge_aluno))))
 JOIN public.bas_pessoa pes ON (((alu.id_bas_empresa = pes.id_bas_empresa) AND (pes.id = alu.id_bas_pessoa))))
 JOIN public.bas_estabelecimento est ON (((est.id_bas_empresa = cur.id_bas_empresa) AND (cur.id_bas_estabelecimento = est.id))));


ALTER TABLE public.vw_est_curso_serie_turma_aluno_ano_pessoa OWNER TO postgres;

--
-- TOC entry 1273 (class 1259 OID 14566099)
-- Name: vw_est_curso_serie_turma_ano; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vw_est_curso_serie_turma_ano AS
 SELECT tur.id_bas_empresa,
 tur.id AS id_sge_turma,
 ser.id AS id_sge_serie,
 cur.id AS id_sge_curso,
 est.id AS id_bas_estabelecimento,
 tur.nome AS nome_turma,
 ser.nome AS nome_serie,
 cur.nome AS nome_curso,
 est.nome AS nome_estabelecimento,
 tan.ano_letivo
 FROM ((((public.sge_turma tur
 JOIN public.sge_serie ser ON (((ser.id_bas_empresa = tur.id_bas_empresa) AND (ser.id = tur.id_sge_serie))))
 JOIN public.sge_curso cur ON (((cur.id_bas_empresa = ser.id_bas_empresa) AND (cur.id = ser.id_sge_curso))))
 JOIN public.sge_turma_ano tan ON (((tur.id_bas_empresa = tan.id_bas_empresa) AND (tur.id = tan.id_sge_turma))))
 JOIN public.bas_estabelecimento est ON (((est.id_bas_empresa = cur.id_bas_empresa) AND (cur.id_bas_estabelecimento = est.id))));


ALTER TABLE public.vw_est_curso_serie_turma_ano OWNER TO postgres;

--
-- TOC entry 1274 (class 1259 OID 14566104)
-- Name: vw_material_professor; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vw_material_professor AS
 SELECT psm.id_bas_empresa AS empresa_id,
 cur.id_bas_estabelecimento AS estabelecimento_id,
 pes.nome AS professor_nome,
 col.id AS professor_id,
 cur.nome AS curso_nome,
 cur.id AS curso_id,
 ser.nome AS serie_nome,
 ser.id AS serie_id,
 tur.nome AS turma_nome,
 tur.id AS turma_id,
 mat.nome AS material_nome,
 (psm.quantidade * (count(*))::numeric) AS qtd_planejada,
 0 AS qtd_requisitada,
 tal.ano_letivo
 FROM (((((((public.sga_professor_serie_material psm
 JOIN public.sga_material mat ON (((psm.id_bas_empresa = mat.id_bas_empresa) AND (psm.id_sga_material = mat.id))))
 JOIN public.bas_colaborador col ON (((psm.id_bas_empresa = col.id_bas_empresa) AND (psm.id_bas_colaborador = col.id))))
 JOIN public.bas_pessoa pes ON (((col.id_bas_empresa = pes.id_bas_empresa) AND (col.id_bas_pessoa = pes.id))))
 JOIN public.sge_serie ser ON (((psm.id_bas_empresa = ser.id_bas_empresa) AND (psm.id_sge_serie = ser.id))))
 JOIN public.sge_turma tur ON (((ser.id_bas_empresa = tur.id_bas_empresa) AND (ser.id = tur.id_sge_serie))))
 JOIN public.sge_curso cur ON (((ser.id_bas_empresa = cur.id_bas_empresa) AND (ser.id_sge_curso = cur.id))))
 JOIN public.sge_turma_aluno tal ON (((tur.id_bas_empresa = tal.id_bas_empresa) AND (tur.id = tal.id_sge_turma))))
 GROUP BY psm.id_bas_empresa, cur.id_bas_estabelecimento, pes.nome, col.id, cur.nome, cur.id, ser.nome, ser.id, tur.nome, tur.id, mat.nome, psm.quantidade, 0::integer, tal.ano_letivo
UNION ALL
( SELECT req.id_bas_empresa AS empresa_id,
 alm.id_bas_estabelecimento AS estabelecimento_id,
 pes.nome AS professor_nome,
 col.id AS professor_id,
 cur.nome AS curso_nome,
 cur.id AS curso_id,
 ser.nome AS serie_nome,
 ser.id AS serie_id,
 tur.nome AS turma_nome,
 tur.id AS turma_id,
 mat.nome AS material_nome,
 0 AS qtd_planejada,
 rma.quantidade_atendida AS qtd_requisitada,
 date_part('YEAR'::text, req.data) AS ano_letivo
 FROM (((((((((public.sga_requisicao req
 JOIN public.sga_requisicao_material rma ON (((rma.id_bas_empresa = req.id_bas_empresa) AND (rma.id_sga_requisicao = req.id) AND (rma.situacao = ANY (ARRAY['A'::bpchar, 'P'::bpchar, 'C'::bpchar])))))
 JOIN public.sga_material mat ON (((rma.id_bas_empresa = mat.id_bas_empresa) AND (rma.id_sga_material = mat.id))))
 JOIN public.bas_colaborador col ON (((req.id_bas_empresa = col.id_bas_empresa) AND (req.id_bas_colaborador = col.id))))
 JOIN public.bas_pessoa pes ON (((col.id_bas_empresa = pes.id_bas_empresa) AND (col.id_bas_pessoa = pes.id))))
 JOIN public.sga_almoxarifado alm ON (((req.id_bas_empresa = alm.id_bas_empresa) AND (req.id_sga_almoxarifado = alm.id) AND (alm.tipo = 'C'::bpchar))))
 JOIN public.sge_professor_disciplina_turma pdt ON (((col.id_bas_empresa = pdt.id_bas_empresa) AND (col.id = pdt.id_sge_professor))))
 JOIN public.sge_turma tur ON (((pdt.id_bas_empresa = tur.id_bas_empresa) AND (pdt.id_sge_turma_modulo = tur.id))))
 JOIN public.sge_serie ser ON (((tur.id_bas_empresa = ser.id_bas_empresa) AND (tur.id_sge_serie = ser.id))))
 JOIN public.sge_curso cur ON (((ser.id_bas_empresa = cur.id_bas_empresa) AND (ser.id_sge_curso = cur.id))))
 GROUP BY req.id_bas_empresa, alm.id_bas_estabelecimento, pes.nome, col.id, cur.nome, cur.id, ser.nome, ser.id, tur.nome, tur.id, mat.nome, 0::integer, (date_part('YEAR'::text, req.data)), rma.quantidade_atendida
 ORDER BY req.id_bas_empresa, alm.id_bas_estabelecimento, pes.nome, col.id, cur.nome, cur.id, ser.nome, ser.id, tur.nome, tur.id, mat.nome, 0::integer, (date_part('YEAR'::text, req.data)));


ALTER TABLE public.vw_material_professor OWNER TO postgres;

--
-- TOC entry 1306 (class 1259 OID 21188169)
-- Name: vw_pessoa_endereco_limitado; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vw_pessoa_endereco_limitado AS
 SELECT bas_pessoa_endereco.id,
 bas_pessoa_endereco.id_bas_empresa,
 bas_pessoa_endereco.id_bas_pessoa,
 bas_pessoa_endereco.tipo_endereco,
 bas_pessoa_endereco.logradouro,
 bas_pessoa_endereco.numero,
 bas_pessoa_endereco.bairro,
 bas_pessoa_endereco.cidade,
 bas_pessoa_endereco.cep,
 bas_pessoa_endereco.uf,
 bas_pessoa_endereco.complemento,
 bas_pessoa_endereco.id_cso_municipio
 FROM public.bas_pessoa_endereco
 LIMIT 1;


ALTER TABLE public.vw_pessoa_endereco_limitado OWNER TO postgres;

--
-- TOC entry 1275 (class 1259 OID 14566109)
-- Name: vw_recebimento_aluno; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vw_recebimento_aluno AS
 SELECT (((ser.nome)::text || ' - '::text) || (tur.nome)::text) AS turma,
 pes.nome AS aluno,
 date_part('month'::text, ttr.data_vencimento) AS mes,
 sum(tre.valor_pago) AS recebido,
 ttr.valor,
 ttr.data_vencimento,
 ttr.id AS titulo_id,
 ttb.id AS tipo_titulo_id,
 tur.id AS turma_id,
 ttr.ano_letivo,
 alu.id AS aluno_id,
 sum((tre.juros + tre.multa)) AS encargos,
 sum(tre.desconto) AS desconto_pago,
 sum(COALESCE(cde.valor, (0)::numeric)) AS desconto_contrato,
 (COALESCE(ttr.valor, (0)::numeric) - ((sum(COALESCE(tre.valor_pago, (0)::numeric)) - sum((COALESCE(tre.juros, (0)::numeric) + COALESCE(tre.multa, (0)::numeric)))) + sum(COALESCE(tre.desconto, (0)::numeric)))) AS saldo,
 ttr.id_bas_empresa AS empresa_id,
 max(rec.data) AS data_pag
 FROM ((((((((((((public.sgf_titulo_receber ttr
 LEFT JOIN public.sge_contrato con ON (((con.id_bas_empresa = ttr.id_bas_empresa) AND (con.id = ttr.id_sge_contrato))))
 LEFT JOIN public.sge_contrato_desconto cde ON (((con.id_bas_empresa = cde.id_bas_empresa) AND (con.id = cde.id_sge_contrato))))
 JOIN public.sge_turma_aluno tua ON (((tua.id_bas_empresa = con.id_bas_empresa) AND (tua.id = con.id_sge_turma_aluno))))
 JOIN public.sge_aluno alu ON (((alu.id_bas_empresa = tua.id_bas_empresa) AND (alu.id = tua.id_sge_aluno))))
 JOIN public.bas_pessoa pes ON (((pes.id_bas_empresa = alu.id_bas_empresa) AND (pes.id = alu.id_bas_pessoa))))
 JOIN public.sge_turma tur ON (((tur.id_bas_empresa = tua.id_bas_empresa) AND (tur.id = tua.id_sge_turma))))
 JOIN public.sge_serie ser ON (((ser.id_bas_empresa = tua.id_bas_empresa) AND (ser.id = tua.id_sge_serie))))
 LEFT JOIN public.sge_contrato_desconto cod ON (((cod.id_bas_empresa = con.id_bas_empresa) AND (cod.id_sge_contrato = con.id))))
 JOIN public.sgf_tipo_titulo_receber ttb ON (((ttb.id_bas_empresa = ttr.id_bas_empresa) AND (ttb.id = ttr.id_sgf_tipo_titulo_receber))))
 JOIN public.sgf_situacao_financeira stf ON ((stf.id = ttr.id_sgf_situacao_financeira)))
 LEFT JOIN public.sgf_titulo_recebimento tre ON (((tre.id_bas_empresa = ttr.id_bas_empresa) AND (tre.id_sgf_titulo_receber = ttr.id))))
 LEFT JOIN public.sgf_recebimento rec ON (((tre.id_bas_empresa = rec.id_bas_empresa) AND (tre.id_sgf_recebimento = rec.id))))
 WHERE ((rec.cancelamento_data IS NULL) AND (ttr.id_sgf_situacao_financeira = ANY (ARRAY[(1)::bigint, (2)::bigint, (3)::bigint, (4)::bigint])))
 GROUP BY (((ser.nome)::text || ' - '::text) || (tur.nome)::text), pes.nome, (date_part('month'::text, ttr.data_vencimento)), ttr.valor, ttr.data_vencimento, ttr.id, ttb.id, tur.id, ttr.ano_letivo, alu.id, ttr.id_bas_empresa
 ORDER BY (((ser.nome)::text || ' - '::text) || (tur.nome)::text), pes.nome;


ALTER TABLE public.vw_recebimento_aluno OWNER TO postgres;

--
-- TOC entry 1276 (class 1259 OID 14566114)
-- Name: vw_sga_almoxarifado_material; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vw_sga_almoxarifado_material AS
 SELECT sga_material_estoque.id_bas_empresa,
 sga_material_estoque.id_sga_almoxarifado,
 sga_material_estoque.id_sga_material,
 sum(sga_material_estoque.quantidade) AS quantidade_total,
 CASE sum(sga_material_estoque.quantidade)
 WHEN 0 THEN round((sum((sga_material_estoque.valor_unitario * (1)::numeric)) / (1)::numeric), 2)
 ELSE round((sum((sga_material_estoque.valor_unitario * sga_material_estoque.quantidade)) / sum(sga_material_estoque.quantidade)), 2)
 END AS valor_medio_unitario,
 sum((sga_material_estoque.valor_unitario * sga_material_estoque.quantidade)) AS valor_total
 FROM public.sga_material_estoque
 GROUP BY sga_material_estoque.id_bas_empresa, sga_material_estoque.id_sga_almoxarifado, sga_material_estoque.id_sga_material;


ALTER TABLE public.vw_sga_almoxarifado_material OWNER TO postgres;

--
-- TOC entry 1277 (class 1259 OID 14566119)
-- Name: vw_sge_aula_planejada_executada; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vw_sge_aula_planejada_executada AS
 SELECT dis.id_bas_empresa,
 tur.id_sge_serie,
 apl.id_sge_turma,
 ass.id_sge_disciplina,
 count(*) AS tot_aula_planejada,
 0 AS tot_aula_executada
 FROM (((((public.sge_disciplina dis
 JOIN public.sge_assunto ass ON ((ass.id_sge_disciplina = dis.id)))
 JOIN public.sge_conteudo_programatico_assunto cpa ON ((cpa.id_sge_assunto = ass.id)))
 JOIN public.sge_conteudo_planejado cpl ON ((cpl.id_sge_conteudo_programatico_assunto = cpa.id)))
 JOIN public.sge_aula_planejada apl ON ((apl.id = cpl.id_sge_aula_planejada)))
 JOIN public.sge_turma tur ON ((tur.id = apl.id_sge_turma)))
 GROUP BY dis.id_bas_empresa, tur.id_sge_serie, apl.id_sge_turma, ass.id_sge_disciplina
UNION
 SELECT dis.id_bas_empresa,
 tur.id_sge_serie,
 apl.id_sge_turma,
 ass.id_sge_disciplina,
 0 AS tot_aula_planejada,
 count(*) AS tot_aula_executada
 FROM ((((((public.sge_disciplina dis
 JOIN public.sge_assunto ass ON ((ass.id_sge_disciplina = dis.id)))
 JOIN public.sge_conteudo_programatico_assunto cpa ON ((cpa.id_sge_assunto = ass.id)))
 JOIN public.sge_conteudo_planejado cpl ON ((cpl.id_sge_conteudo_programatico_assunto = cpa.id)))
 JOIN public.sge_aula_planejada apl ON ((apl.id = cpl.id_sge_aula_planejada)))
 JOIN public.sge_aula_planejada_executada ape ON ((ape.id_sge_aula_planejada = apl.id)))
 JOIN public.sge_turma tur ON ((tur.id = apl.id_sge_turma)))
 GROUP BY dis.id_bas_empresa, tur.id_sge_serie, apl.id_sge_turma, ass.id_sge_disciplina;


ALTER TABLE public.vw_sge_aula_planejada_executada OWNER TO postgres;

--
-- TOC entry 1278 (class 1259 OID 14566124)
-- Name: vw_sge_ocorrencia; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vw_sge_ocorrencia AS
 SELECT oco.id AS id_sge_ocorrencia,
 oco.id_bas_empresa,
 alu.id AS id_sge_aluno,
 pes.nome AS nome_aluno,
 oct.classificacao,
 oco.pontuacao AS pontos,
 oco.data
 FROM (((public.sge_ocorrencia oco
 JOIN public.sge_aluno alu ON (((oco.id_bas_empresa = alu.id_bas_empresa) AND (oco.id_sge_aluno = alu.id))))
 JOIN public.bas_pessoa pes ON (((alu.id_bas_empresa = pes.id_bas_empresa) AND (alu.id_bas_pessoa = pes.id))))
 JOIN public.sge_ocorrencia_tipo oct ON (((oco.id_bas_empresa = oct.id_bas_empresa) AND (oco.id_sge_ocorrencia_tipo = oct.id))))
 WHERE (oct.classificacao = 1)
UNION
 SELECT oco.id AS id_sge_ocorrencia,
 oco.id_bas_empresa,
 alu.id AS id_sge_aluno,
 pes.nome AS nome_aluno,
 oct.classificacao,
 oco.pontuacao AS pontos,
 oco.data
 FROM (((public.sge_ocorrencia oco
 JOIN public.sge_aluno alu ON (((oco.id_bas_empresa = alu.id_bas_empresa) AND (oco.id_sge_aluno = alu.id))))
 JOIN public.bas_pessoa pes ON (((alu.id_bas_empresa = pes.id_bas_empresa) AND (alu.id_bas_pessoa = pes.id))))
 JOIN public.sge_ocorrencia_tipo oct ON (((oco.id_bas_empresa = oct.id_bas_empresa) AND (oco.id_sge_ocorrencia_tipo = oct.id))))
 WHERE ((oct.classificacao = 2) AND (oco.data > (('now'::text)::date - '1 year'::interval)));


ALTER TABLE public.vw_sge_ocorrencia OWNER TO postgres;

--
-- TOC entry 1279 (class 1259 OID 14566129)
-- Name: vw_sgm_aluno; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vw_sgm_aluno AS
 SELECT turalu.id_bas_empresa,
 turalu.ano_letivo,
 tura.ativo,
 alu.id AS id_alu,
 pes.nome AS nome_alu,
 esta.id AS id_est,
 esta.nome AS nome_est,
 tura.id AS id_tur,
 tura.nome AS nome_tur,
 sera.id AS id_ser,
 sera.nome AS nome_ser,
 faia.id AS id_fai,
 faia.nome AS nome_fai,
 cura.id AS id_cur,
 cura.nome AS nome_cur
 FROM (((((((public.sge_turma_aluno turalu
 JOIN public.sge_aluno alu ON (((alu.id_bas_empresa = turalu.id_bas_empresa) AND (alu.id = turalu.id_sge_aluno))))
 JOIN public.bas_pessoa pes ON (((pes.id_bas_empresa = alu.id_bas_empresa) AND (pes.id = alu.id_bas_pessoa))))
 JOIN public.sge_turma tura ON (((tura.id_bas_empresa = turalu.id_bas_empresa) AND (tura.id = turalu.id_sge_turma))))
 JOIN public.sge_serie sera ON (((sera.id_bas_empresa = tura.id_bas_empresa) AND (sera.id = tura.id_sge_serie))))
 JOIN public.sge_faixa_etaria faia ON (((faia.id_bas_empresa = sera.id_bas_empresa) AND (faia.id = sera.id_sge_faixa_etaria))))
 JOIN public.sge_curso cura ON (((cura.id_bas_empresa = sera.id_bas_empresa) AND (cura.id = sera.id_sge_curso))))
 JOIN public.bas_estabelecimento esta ON (((esta.id_bas_empresa = cura.id_bas_empresa) AND (esta.id = cura.id_bas_estabelecimento))));


ALTER TABLE public.vw_sgm_aluno OWNER TO postgres;

SET default_with_oids = true;

--
-- TOC entry 1280 (class 1259 OID 14566134)
-- Name: x_bas_formatos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.x_bas_formatos (
 id bigint NOT NULL,
 fornecedor character varying(20),
 formato character varying(20),
 descricao character varying(100),
 pagina_formato character varying(10),
 pagina_orientacao character(1),
 unidade_medida character varying(3),
 form_largura numeric(10,4),
 form_altura numeric(10,4),
 margem_sup numeric(10,4),
 margem_inf numeric(10,4),
 margem_esq numeric(10,4),
 margem_dir numeric(10,4),
 colunas integer,
 linhas integer,
 etq_altura numeric(10,4),
 etq_largura numeric(10,4),
 etq_distancia_hor numeric(10,4),
 etq_distancia_ver numeric(10,4),
 fonte character varying(30),
 fonte_tam integer,
 liberado character(1)
);
