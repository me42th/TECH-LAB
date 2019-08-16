php artisan make:model bas_afastamento_tipo;
    id bigint NOT NULL,
    nome character varying(50) NOT NULL,
    sigla character varying(3) NOT NULL
);


php artisan make:model bas_alocacao;
    id bigint NOT NULL,
    id_bas_empresa bigint NOT NULL,
    login character varying(32) NOT NULL,
    id_bas_alocacao_tipo bigint NOT NULL,
    hora_inicio time without time zone NOT NULL,
    hora_fim time without time zone NOT NULL,
    motivo character varying(255),
    data date NOT NULL,
    id_bas_usuario bigint NOT NULL,
    datahora_inicio timestamp without time zone NOT NULL,
    datahora_fim timestamp without time zone NOT NULL,
    assunto character varying(60),
    descricao character varying(255),
    ativo character(1) NOT NULL
);


php artisan make:model bas_alocacao_log;
 id bigint DEFAULT nextval('public.bas_alocacao_log_id_seq1'::regclass) NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_alocacao bigint NOT NULL,
 id_bas_alocacao_status bigint NOT NULL,
 login character varying,
 observacao text
);

php artisan make:model bas_alocacao_sala;
 id_bas_empresa bigint NOT NULL,
 id_bas_alocacao bigint NOT NULL,
 id_bas_sala bigint NOT NULL
);

php artisan make:model bas_alocacao_status;
 id bigint NOT NULL,
 nome character varying(50) NOT NULL
);

php artisan make:model bas_alocacao_equipamento;
    id_bas_empresa bigint NOT NULL,
    id_bas_alocacao bigint NOT NULL,
    id_bas_equipamento bigint NOT NULL
);


php artisan make:model bas_alocacao_tipo;
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(50) NOT NULL
);


php artisan make:model bas_anamnese;
 id bigint DEFAULT nextval('public.sge_anamnese_id_seq'::regclass) NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(100) NOT NULL,
 data_criacao date DEFAULT now()
);

php artisan make:model bas_anamnese_categoria_pergunta;
 id bigint DEFAULT nextval('public.sge_anamnese_categoria_pergunta_id_seq'::regclass) NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(100) NOT NULL
);


php artisan make:model bas_anamnese_pergunta;
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_pergunta bigint NOT NULL,
 id_bas_anamnese bigint NOT NULL,
 ordem bigint
);

php artisan make:model bas_area_conhecimento;
 id bigint NOT NULL,
 id_bas_empresa integer NOT NULL,
 nome character varying(100) NOT NULL,
 id_sge_disciplina bigint,
 id_bas_area_conhecimento bigint
);


php artisan make:model bas_assinatura_documento;
 id bigint DEFAULT nextval('public.bas_pessoa_secretario_id_seq'::regclass) NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_pessoa bigint NOT NULL,
 data_inicio date DEFAULT now(),
 data_fim date,
 tipo character(1) NOT NULL,
 autorizacao character varying(50),
 data_autorizacao date,
 id_bas_estabelecimento bigint,
 id_sge_curso bigint
);


php artisan make:model bas_atendimento_suporte;
 id integer NOT NULL,
 id_bas_colaborador_solicitacao bigint NOT NULL,
 id_bas_colaborador_execucao bigint NOT NULL,
 tipo_ocorrencia integer NOT NULL,
 data_conclusao date,
 data_ocorrencia date NOT NULL,
 data_inclusao_registro date NOT NULL,
 hora_ocorrencia time(0) without time zone NOT NULL,
 status_ocorrencia integer NOT NULL,
 descricao_ocorrencia text NOT NULL,
 diagnostico_ocorrencia text,
 resposta_ocorrencia text,
 anexo_ocorrencia character varying(100),
 id_bas_tipo_assunto_suporte bigint NOT NULL,
 criticidade integer NOT NULL,
 id_bas_estabelecimento bigint,
 usr_login character varying,
 id_bas_estabelecimento_origem bigint,
 id_bas_estabelecimento_destino bigint,
 id_bas_empresa bigint,
 id_bas_centro_custo bigint
);


php artisan make:model bas_atendimento_suporte_log;
 id bigint NOT NULL,
 id_bas_colaborador_solicitacao bigint NOT NULL,
 id_bas_colaborador_execucao bigint,
 tipo_ocorrencia integer,
 data_conclusao date,
 data_ocorrencia date NOT NULL,
 data_inclusao_registro date NOT NULL,
 hora_ocorrencia time without time zone NOT NULL,
 status_ocorrencia integer NOT NULL,
 descricao_ocorrencia text NOT NULL,
 diagnostico_ocorrencia text,
 resposta_ocorrencia text,
 anexo_ocorrencia character varying(100),
 id_bas_tipo_assunto_suporte bigint,
 criticidade integer NOT NULL,
 id_bas_estabelecimento bigint,
 usr_login character varying,
 id_bas_estabelecimento_origem bigint,
 id_bas_estabelecimento_destino bigint,
 id_bas_empresa bigint,
 id_bas_centro_custo bigint,
 id_bas_servico bigint,
 data_exclusao date,
 user_login_exclusao character varying(100)
);

php artisan make:model bas_atestado_tipo;
 id bigint NOT NULL,
 nome character varying(50) NOT NULL,
 sigla character varying(3) NOT NULL
);


php artisan make:model bas_bairro;
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(100)
);


php artisan make:model bas_centro_custo;
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_estabelecimento bigint NOT NULL,
 codigo character varying(11) NOT NULL,
 nome character varying(100) NOT NULL,
 id_bas_centro_custo bigint,
 agrupamento character(1),
 cota_financeira numeric(9,2),
 cota_quantidade smallint,
 id_bas_colaborador bigint
);


php artisan make:model bas_cid;
 id bigint NOT NULL,
 subgrupo character varying(5),
 descricao character varying(270)
);


php artisan make:model bas_colaborador;
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_pessoa bigint NOT NULL,
 id_bas_funcao bigint,
 id_bas_profissao bigint,
 id_bas_centro_custo bigint,
 matricula character varying(20),
 data_admissao date,
 data_demissao date,
 ativo character(1) NOT NULL,
 gestor character(1),
 id_bas_nivel_servidor bigint,
 id_bas_cargo bigint,
 id_bas_tipo_fonte_pagadora bigint,
 salario_bruto numeric(6,2),
 carga_mensal smallint,
 id_bas_vinculo_empregaticio bigint,
 id_sgp_inatividade bigint
);


php artisan make:model bas_colaborador_afastamento;
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_colaborador bigint,
 id_bas_estabelecimento bigint,
 id_bas_afastamento_tipo bigint,
 id_bas_colaborador_substituto bigint,
 data_inicial date,
 data_final date,
 observacao text,
 login character varying(32),
 data date
);


php artisan make:model bas_colaborador_atestado;
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_estabelecimento bigint,
 id_bas_colaborador bigint,
 id_bas_atestado_tipo bigint,
 id_bas_cid bigint,
 data_inicial date,
 data_final date,
 ano_letivo smallint,
 medico character varying(100),
 hospital character varying(100),
 tipo character(1),
 observacao text
);


php artisan make:model bas_colaborador_atestado_falta;
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_colaborador_atestado bigint NOT NULL,
 data date,
 justificada character(1),
 abonada character(1),
 mes smallint,
 quantidade smallint,
 observacao text
);


php artisan make:model bas_colaborador_beneficio;
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_colaborador bigint,
 id_bas_tipo_beneficio bigint,
 utilizou character(1),
 observacao text
);


php artisan make:model bas_colaborador_capacitacao;
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_colaborador bigint,
 situacao character(1),
 curso character varying(100),
 instituicao character varying(100),
 ano_inicial smallint,
 ano_final smallint,
 tipo character(1)
);


php artisan make:model bas_colaborador_dias_trabalhados;
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_estabelecimento bigint,
 id_bas_colaborador bigint,
 ano_letivo smallint,
 jan smallint,
 fev smallint,
 mar smallint,
 abr smallint,
 mai smallint,
 jun smallint,
 jul smallint,
 ago smallint,
 sete smallint,
 "out" smallint,
 nov smallint,
 dez smallint
);


php artisan make:model bas_colaborador_estabelecimento;
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_colaborador bigint NOT NULL,
 id_bas_estabelecimento bigint NOT NULL,
 id_bas_colaborador_antigo bigint,
 id_bas_centro_custo bigint,
 gestor character(1),
 carga_horaria integer,
 ano smallint,
 data_inicial date,
 data_final date
);


php artisan make:model bas_colaborador_estabelecimento_chamadas;
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_colaborador bigint NOT NULL,
 id_bas_centro_custo bigint NOT NULL,
 id_bas_estabelecimento bigint NOT NULL,
 visualiza character(1),
 altera character(1),
 cria character varying
);


php artisan make:model bas_cargo;
 id bigint NOT NULL,
 nome character varying(50) NOT NULL,
 sigla character varying(3) NOT NULL
);


php artisan make:model bas_colaborador_funcao;
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_colaborador_estabelecimento bigint NOT NULL,
 id_bas_funcao bigint NOT NULL,
 carga_horaria smallint,
 data_inicio date,
 data_fim date
);


php artisan make:model bas_colaborador_outros_documentos;
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_colaborador bigint,
 nome_documento character varying(100),
 valor character varying(100),
 id_bas_outros_documentos bigint
);


php artisan make:model bas_colaborador_treinamento;
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_colaborador bigint NOT NULL,
 id_bas_treinamento bigint NOT NULL
);


php artisan make:model bas_config_dias_letivos;
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 ano_letivo smallint,
 dias smallint
);


php artisan make:model bas_configuracao;
 id bigint NOT NULL,
 id_seg_modulo bigint,
 nome character varying(50),
 valor text
);


php artisan make:model bas_emails_enviados;
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_mensagem_email bigint,
 id_bas_colaborador bigint,
 data_hora timestamp without time zone,
 numero_lote bigint,
 nome_lote character varying(100),
 login character varying(32)
);


php artisan make:model bas_empresa;
 id bigint NOT NULL,
 id_bas_grupo bigint NOT NULL,
 razao_social character varying(100) NOT NULL,
 nome_fantasia character varying(60) NOT NULL,
 tipo character(1),
 pasta character varying(80) NOT NULL,
 imagem text,
 prefixo_relatorio character varying(10),
 portal character varying,
 qtd_alunos integer,
 qtd_dias_cadastro integer,
 implantacao character(1),
 envia_email character(1),
 label_campo_serie character varying(50)
);


php artisan make:model bas_equipamento;
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_estabelecimento bigint,
 id_bas_equipamento_tipo bigint,
 codigo character varying(20),
 nome character varying(60),
 modelo character varying(60),
 numero_serie character varying(60),
 ativo character(1) DEFAULT 'S'::bpchar,
 login character varying NOT NULL,
 data_criacao timestamp(0) without time zone DEFAULT now() NOT NULL,
 id_bas_fornecedor bigint
);


php artisan make:model bas_equipamento_tipo;
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(100) NOT NULL
);


php artisan make:model bas_estabelecimento;
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(100) NOT NULL,
 cnpj character varying(14),
 inscricao_estadual character varying(11),
 inscricao_municipal character varying(11),
 logradouro character varying(100) NOT NULL,
 numero_logradouro character varying(10) NOT NULL,
 bairro character varying(100) NOT NULL,
 cidade character varying(100) NOT NULL,
 cep character varying(10),
 data_autorizacao date,
 resolucao character varying(100),
 data_resolucao date,
 portaria character varying(100),
 data_portaria date,
 telefone character varying(15),
 fax character varying(15),
 uf character(2),
 ano_padrao smallint,
 sms_usuario character varying(30),
 sms_senha character varying(60),
 sms_proxy_porta integer,
 sms_proxy_user character varying(100),
 sms_proxy_senha character varying(60),
 sms_proxy_ip character varying(100),
 mail_smtp_server character varying(100),
 mail_smtp_user character varying(100),
 mail_smtp_pass character varying(20),
 mail_from character varying(100),
 id_bas_colaborador_recebe_email_atendimento bigint,
 id_sgf_nfse_estabelecimento bigint,
 matriz character(1) DEFAULT 'N'::bpchar,
 tipo character(1),
 imagem text,
 prefixo_relatorio character varying(50),
 codigo_inep integer,
 id_sgm_polo integer
);


php artisan make:model bas_estabelecimento_dias_letivos;
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_estabelecimento bigint,
 ano_letivo smallint,
 jan smallint,
 fev smallint,
 mar smallint,
 abr smallint,
 mai smallint,
 jun smallint,
 jul smallint,
 ago smallint,
 sete smallint,
 "out" smallint,
 nov smallint,
 dez smallint
);



php artisan make:model bas_estabelecimento_resumo_ano;
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_estabelecimento bigint NOT NULL,
 ano_letivo smallint,
 quantidade_salas_escola character varying(4),
 quantidade_total_salas character varying(4),
 quantidade_funcionarios character varying(4),
 quantidade_dependencias_salas character varying(4)
);


php artisan make:model bas_estabelecimento_setor_mes_falta;
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_estabelecimento bigint,
 id_bas_centro_custo bigint,
 id_bas_colaborador bigint,
 ano_letivo smallint,
 mes smallint,
 dia1 smallint,
 dia2 smallint,
 dia3 smallint,
 dia4 smallint,
 dia5 smallint,
 dia6 smallint,
 dia7 smallint,
 dia8 smallint,
 dia9 smallint,
 dia10 smallint,
 dia11 smallint,
 dia12 smallint,
 dia13 smallint,
 dia14 smallint,
 dia15 smallint,
 dia16 smallint,
 dia17 smallint,
 dia18 smallint,
 dia19 smallint,
 dia20 smallint,
 dia21 smallint,
 dia22 smallint,
 dia23 smallint,
 dia24 smallint,
 dia25 smallint,
 dia26 smallint,
 dia27 smallint,
 dia28 smallint,
 dia29 smallint,
 dia30 smallint,
 dia31 smallint,
 observacao text,
 total_mensal smallint
);


php artisan make:model bas_estado_civil;
 id bigint NOT NULL,
 nome character varying(30) NOT NULL
);


php artisan make:model bas_fabricante;
 id bigint NOT NULL,
 nome character varying(60)
);


php artisan make:model bas_feriado;
 id bigint NOT NULL,
 id_bas_empresa bigint,
 nome character varying(60) NOT NULL,
 mes integer,
 dia integer,
 tipo character varying(100),
 cidade character varying(30),
 uf character(2)
);


php artisan make:model bas_fornecedor;
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_pessoa bigint NOT NULL,
 data_inclusao date NOT NULL,
 ativo character(1) NOT NULL,
 pessoa_contato character varying(100)
);


php artisan make:model bas_funcao;
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(100),
 tipo character(1),
 cbo character varying(8)
);


php artisan make:model bas_grau_instrucao;
 id bigint NOT NULL,
 nome character varying(60) NOT NULL,
 cso_professor_escolaridade bigint
);


php artisan make:model bas_grau_parentesco;
 id bigint NOT NULL,
 nome character varying(50) NOT NULL
);


php artisan make:model bas_grupo;
 id bigint NOT NULL,
 nome character varying(100) NOT NULL,
 imagem text,
 pasta_virtual_sge character varying(200),
 pasta_virtual_sga character varying(200),
 pasta_virtual_sgb character varying(200),
 pasta_virtual_sgm character varying(200),
 codigo_google_analytics character varying(20),
 img_login text,
 pasta_virtual_sgp character varying(200),
 pasta_virtual_transporteuniversitario character varying(200)
);



php artisan make:model bas_idioma;
 id bigint NOT NULL,
 nome character varying(50) NOT NULL
);


php artisan make:model bas_marca_equipamento;
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(100) NOT NULL
);


php artisan make:model bas_mensagem;
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 login character(32) NOT NULL,
 assunto character varying(100) NOT NULL,
 conteudo text NOT NULL,
 data_hora timestamp(0) without time zone DEFAULT now() NOT NULL
);


php artisan make:model bas_mensagem_email;
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_mensagem_tipo bigint NOT NULL,
 titulo character varying(70) NOT NULL,
 mensagem text NOT NULL
);


php artisan make:model bas_mensagem_enviada;
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_estabelecimento bigint NOT NULL,
 login character varying(32) NOT NULL,
 id_bas_pessoa bigint NOT NULL,
 conteudo text NOT NULL,
 data_hora timestamp(6) without time zone NOT NULL,
 erro character(1) NOT NULL,
 celular character varying(20),
 tipo_mensagem character(1) NOT NULL,
 email character varying(120)
);


php artisan make:model bas_mensagem_sms;
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_mensagem_tipo bigint NOT NULL,
 mensagem character varying(160) NOT NULL,
 titulo character varying(70) NOT NULL
);


php artisan make:model bas_mensagem_tipo;
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_estabelecimento bigint NOT NULL,
 nome character varying(50)
);


php artisan make:model bas_mensagem_usuario;
 id_bas_empresa bigint NOT NULL,
 id_bas_mensagem bigint NOT NULL,
 login character varying NOT NULL,
 lida character(1) DEFAULT 'N'::bpchar NOT NULL
);

php artisan make:model bas_nivel_servidor;
 id bigint NOT NULL,
 nome character varying(50) NOT NULL,
 sigla character varying(3) NOT NULL
);


php artisan make:model bas_ocorrencia_reclamacao;
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


php artisan make:model bas_ocorrencia_reclamacao_parecer;
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_ocorrencia_reclamacao bigint NOT NULL,
 data_acao date NOT NULL,
 acao text NOT NULL
);


php artisan make:model bas_outros_documentos;
 id bigint NOT NULL,
 nome character varying(50) NOT NULL,
 sigla character varying(3) NOT NULL
);


php artisan make:model bas_pergunta;
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(300) NOT NULL,
 tipo_resposta character(1) NOT NULL,
 id_bas_anamnese_categoria_pergunta bigint
);


php artisan make:model bas_pergunta_resposta;
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_pergunta bigint NOT NULL,
 id_bas_resposta bigint NOT NULL
);


php artisan make:model bas_pessoa;
 id bigint DEFAULT nextval('public.bas_pessoa_id_seq'::regclass) NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(100) NOT NULL,
 email character varying(60),
 tipo_pessoa character(1) DEFAULT 'F'::bpchar
);


php artisan make:model bas_pessoa_cnh;
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


php artisan make:model bas_pessoa_conta_bancaria;
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


php artisan make:model bas_pessoa_coordenador;
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_pessoa_coordenador bigint NOT NULL,
 id_bas_pessoa_coordenado bigint NOT NULL,
 id_sge_curso bigint,
 data_inicial date NOT NULL,
 data_final date,
 data_registro timestamp without time zone
);


php artisan make:model bas_pessoa_endereco;
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


php artisan make:model bas_pessoa_fisica;
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


php artisan make:model bas_pessoa_juridica;
 id_bas_pessoa bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_ramo_atividade bigint,
 razao_social character varying(100) NOT NULL,
 cnpj character varying(16),
 inscricao_estadual character varying(50),
 inscricao_municipal character varying(50),
 site character varying(60)
);

php artisan make:model bas_pessoa_telefone;
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 id_bas_pessoa bigint NOT NULL,
 tipo_telefone character(1),
 telefone character varying(11)
);

php artisan make:model bas_profissao;
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(100),
 tipo character(1),
 cbo character varying(8)
);


php artisan make:model bas_raca_cor;
 id bigint NOT NULL,
 nome character varying(50) NOT NULL,
 codigo_censo character(1)
);

php artisan make:model bas_ramo_atividade;
 id bigint NOT NULL,
 id_bas_empresa bigint NOT NULL,
 nome character varying(100) NOT NULL
);

php artisan make:model bas_relatorio_personalizavel;
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

php artisan make:model bas_religiao;
 id bigint NOT NULL,
 nome character varying(50) NOT NULL
);