-- MySQL dump 10.13  Distrib 5.7.29, for Linux (x86_64)
--
-- Host: localhost    Database: lab2
-- ------------------------------------------------------
-- Server version	5.7.29-0ubuntu0.18.04.1

DROP DATABASE   IF     EXISTS lab2;
CREATE DATABASE IF NOT EXISTS lab2;
USE lab2;


--
-- Table structure for table `entidade`
--

DROP TABLE IF EXISTS `entidade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entidade` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `modulo`
--

DROP TABLE IF EXISTS `modulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `modulo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_entidade` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nome_UNIQUE` (`nome`),
  KEY `fk_modulo_entidade1_idx` (`id_entidade`),
  CONSTRAINT `fk_modulo_entidade1` FOREIGN KEY (`id_entidade`) REFERENCES `entidade` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=150 DEFAULT CHARSET=utf8 PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `acao`
--

DROP TABLE IF EXISTS `acao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acao` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_modulo` int(11) NOT NULL,
  `nome` varchar(200) DEFAULT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `acao_unique` (`id_modulo`,`nome`),
  KEY `acao_FKIndex1` (`id_modulo`),
  CONSTRAINT `fk_3c339854-d704-11df-9779-00225ff8f3ee` FOREIGN KEY (`id_modulo`) REFERENCES `modulo` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=392 DEFAULT CHARSET=utf8 PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `aluno`
--

DROP TABLE IF EXISTS `aluno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aluno` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `senha` varchar(45) NOT NULL,
  `dt_cadastro` timestamp NULL DEFAULT NULL,
  `recuperar_senha_data` timestamp NULL DEFAULT NULL,
  `recuperar_senha_hash` varchar(256) DEFAULT NULL,
  `criar_conta_hash` varchar(256) DEFAULT NULL COMMENT 'para criação do acesso do aluno ao sistema',
  `ativo` char(1) DEFAULT NULL COMMENT 'Se aluno está ativo ou não: S#sim;N#Não',
  `login` varchar(20) NOT NULL,
  `aceite_termo` char(1) NOT NULL DEFAULT 'N' COMMENT 'se o aluno aceitou o termo de uso: S#Sim;N#Nao',
  `dt_nascimento` date DEFAULT NULL,
  `sexo` char(1) DEFAULT NULL COMMENT 'M#Masculino;F#Feminino',
  `moderado` char(1) DEFAULT 'N' COMMENT 'N#Não;S#Sim',
  `cpf` varchar(11) DEFAULT NULL COMMENT 'Somente os números do CPF',
  `cidade` varchar(100) DEFAULT NULL,
  `estado` varchar(100) DEFAULT NULL,
  `nacionalidade` varchar(100) DEFAULT NULL,
  `instituicao_ensino` varchar(150) DEFAULT NULL,
  `curso` varchar(150) DEFAULT NULL,
  `login_facial` char(1) NOT NULL DEFAULT 'N' COMMENT 'S#Sim;N#Não',
  PRIMARY KEY (`id`),
  UNIQUE KEY `login_UNIQUE` (`login`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8 COMMENT='Esta tabela vai manter todos\nos envios do aluno, para fins\n de uso com a I.A. posteriormente';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `laboratorio`
--

DROP TABLE IF EXISTS `laboratorio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `laboratorio` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(45) NOT NULL COMMENT 'Titulo do laboratório',
  `descricao` text COMMENT 'Descrição do laboratório',
  `termo_uso` text COMMENT 'termo de uso do laboratório',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Laboratorio contem as informações do curso em questão, serve como um agrupador de temas';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tema`
--

DROP TABLE IF EXISTS `tema`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tema` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_laboratorio` int(11) NOT NULL,
  `titulo` varchar(45) NOT NULL COMMENT 'Titulo do Tema',
  `descricao` text COMMENT 'Uma descrição do que o tema contém',
  `icone` varchar(45) DEFAULT NULL COMMENT 'O ícone a ser exibido na página principal (devendo ser do font-awesome)',
  `ordem` int(11) DEFAULT NULL COMMENT 'campo usado para ordenar tema.',
  `imagem_capa` varchar(255) DEFAULT NULL COMMENT 'Imagem que aparece como capa do tema',
  `log_del` char(1) DEFAULT 'N',
  PRIMARY KEY (`id`),
  KEY `fk_tema_laboratorio1_idx` (`id_laboratorio`),
  CONSTRAINT `fk_tema_laboratorio1` FOREIGN KEY (`id_laboratorio`) REFERENCES `laboratorio` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='O tema agrupa várias atividades, servindo apenas para prover este contexto.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `atividade`
--

DROP TABLE IF EXISTS `atividade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `atividade` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_tema` int(11) NOT NULL,
  `titulo` varchar(150) NOT NULL COMMENT 'O titulo da atividade',
  `descricao` longtext COMMENT 'Uma descrição da atividade',
  `tipo` char(3) DEFAULT NULL COMMENT 'Define o tipo de atividade a ser realizado:\\nRPT;Escuta e repetição dos diálogos\\nPRC;Preenchimento de balões em branco\\nVID;Vídeo com explicação\\nPRN;Exercício de pronúncias;REL#Relacionar Colunas',
  `log_del` char(1) DEFAULT 'N',
  `ordem` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_atividade_tema1_idx` (`id_tema`),
  CONSTRAINT `fk_atividade_tema1` FOREIGN KEY (`id_tema`) REFERENCES `tema` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=205 DEFAULT CHARSET=utf8 COMMENT='As atividades são os mapeamentos de tarefas. Cada tarefa tem particularidades que indicam o que será realizado (na execução da tarefa) pelo aluno, exemplo: gravar um audio, enviar uma foto/video, preencher lacunas, entre outras.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `aluno_acesso`
--

DROP TABLE IF EXISTS `aluno_acesso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aluno_acesso` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_aluno` int(11) NOT NULL,
  `dt_registro` timestamp NULL DEFAULT NULL,
  `recurso` char(3) DEFAULT NULL COMMENT 'O recurso define a tela que estava acessando:\\nLOG: Acesso (login)\\nATV: Atividade Visualizar\\nATE: Atividade Executar',
  `id_atividade` int(11) DEFAULT NULL COMMENT 'id da atividade acessada',
  PRIMARY KEY (`id`),
  KEY `fk_aluno_acesso_aluno1_idx` (`id_aluno`),
  KEY `fk_aluno_acesso_atividade1_idx` (`id_atividade`),
  CONSTRAINT `fk_aluno_acesso_aluno1` FOREIGN KEY (`id_aluno`) REFERENCES `aluno` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_aluno_acesso_atividade1` FOREIGN KEY (`id_atividade`) REFERENCES `atividade` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2178 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `aluno_atividade`
--

DROP TABLE IF EXISTS `aluno_atividade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aluno_atividade` (
  `id_aluno` int(11) NOT NULL,
  `id_atividade` int(11) NOT NULL,
  `arquivo` longblob NOT NULL,
  `nome` varchar(255) NOT NULL,
  `tipo` varchar(255) NOT NULL,
  `score` varchar(3) NOT NULL,
  `log_data` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_aluno`,`id_atividade`),
  KEY `fk_aluno_atividade_atividade1_idx` (`id_atividade`),
  KEY `fk_aluno_atividade_aluno1_idx` (`id_aluno`),
  CONSTRAINT `fk_aluno_atividade_aluno1` FOREIGN KEY (`id_aluno`) REFERENCES `aluno` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_aluno_atividade_atividade1` FOREIGN KEY (`id_atividade`) REFERENCES `atividade` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Esta tabela vai manter sempre o ultimo envio do aluno';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `aluno_atividade_envios`
--

DROP TABLE IF EXISTS `aluno_atividade_envios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aluno_atividade_envios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_aluno` int(11) NOT NULL,
  `id_atividade` int(11) NOT NULL,
  `arquivo` longblob NOT NULL,
  `nome` varchar(255) NOT NULL,
  `tipo` varchar(255) NOT NULL,
  `score` varchar(3) NOT NULL,
  `log_data` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_aluno_atividade1_atividade1_idx` (`id_atividade`),
  KEY `fk_aluno_atividade1_aluno1_idx` (`id_aluno`),
  CONSTRAINT `fk_aluno_atividade1_aluno1` FOREIGN KEY (`id_aluno`) REFERENCES `aluno` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_aluno_atividade1_atividade1` FOREIGN KEY (`id_atividade`) REFERENCES `atividade` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=277 DEFAULT CHARSET=utf8 COMMENT='Esta tabela vai manter todos os envios do aluno';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `aluno_atividade_tipo`
--

DROP TABLE IF EXISTS `aluno_atividade_tipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aluno_atividade_tipo` (
  `id_aluno` int(11) NOT NULL,
  `id_atividade` int(11) NOT NULL,
  `tipo` char(3) NOT NULL COMMENT 'Define o tipo de atividade a ser realizado:\\nRPT;Escuta e repetição dos diálogos\\nPRC;Preenchimento de balões em branco\\nVID;Vídeo com explicação\\nPRN;Exercício de pronúncias;REL#Relacionar Colunas',
  `valor` text NOT NULL COMMENT 'Dividir ''_'' para cada resposta caso tenha mais de uma ',
  `log_data` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_aluno`,`id_atividade`),
  KEY `fk_aluno_atividade_opcao_aluno2_idx` (`id_aluno`),
  KEY `fk_aluno_atividade_opcao_atividade2_idx` (`id_atividade`),
  CONSTRAINT `fk_aluno_atividade_opcao_aluno2` FOREIGN KEY (`id_aluno`) REFERENCES `aluno` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_aluno_atividade_opcao_atividade2` FOREIGN KEY (`id_atividade`) REFERENCES `atividade` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Esta tabela vai manter sempre o ultimo envio do aluno\nsendo que deverá guardar o tipo';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `aluno_atividade_tipo_envios`
--

DROP TABLE IF EXISTS `aluno_atividade_tipo_envios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aluno_atividade_tipo_envios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `aluno_id` int(11) NOT NULL,
  `atividade_id` int(11) NOT NULL,
  `tipo` char(3) NOT NULL COMMENT 'Define o tipo de atividade a ser realizado:\\nRPT;Escuta e repetição dos diálogos\\nPRC;Preenchimento de balões em branco\\nVID;Vídeo com explicação\\nPRN;Exercício de pronúncias;REL#Relacionar Colunas',
  `valor` text NOT NULL COMMENT 'Dividir ''_'' para cada resposta caso tenha mais de uma ',
  `log_data` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_aluno_atividade_opcao_aluno1_idx` (`aluno_id`),
  KEY `fk_aluno_atividade_opcao_atividade1_idx` (`atividade_id`),
  CONSTRAINT `fk_aluno_atividade_opcao_aluno1` FOREIGN KEY (`aluno_id`) REFERENCES `aluno` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_aluno_atividade_opcao_atividade1` FOREIGN KEY (`atividade_id`) REFERENCES `atividade` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Esta tabela vai manter todos os envios do aluno sendo que deverá guardar o tipo';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `aluno_imagem`
--

DROP TABLE IF EXISTS `aluno_imagem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aluno_imagem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_aluno` int(11) NOT NULL,
  `url_imagem` varchar(150) NOT NULL,
  `url_pickle` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_aluno_imagem_aluno1_idx` (`id_aluno`),
  CONSTRAINT `fk_aluno_imagem_aluno1` FOREIGN KEY (`id_aluno`) REFERENCES `aluno` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `conteudo`
--

DROP TABLE IF EXISTS `conteudo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conteudo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(255) NOT NULL,
  `id_atividade` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_conteudo_atividade1_idx` (`id_atividade`),
  CONSTRAINT `fk_conteudo_atividade1` FOREIGN KEY (`id_atividade`) REFERENCES `atividade` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=725 DEFAULT CHARSET=utf8 COMMENT='Dentro de uma atividade o aluno poderá realizar uma, ou mais, tarefas. Cada tarefa é executada baseada em um conteúdo, ex: Ler um trecho de uma tirinha, visualizar um vídeo e gravar uma parte, ouvir um áudio e enviar uma resposta. Dentro da ATIVIDADE pode haver mais de um conteúdo, e cada um pode (não obrigatóriamente) ser respondido.';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `conteudo_formulario`
--

DROP TABLE IF EXISTS `conteudo_formulario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conteudo_formulario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_conteudo` int(11) NOT NULL,
  `tipo` char(3) NOT NULL COMMENT 'NOT#Vazio;TXT#Caixa de texto;MEI#Múltipla escolha (Individual);MEV#Múltipla escolha (Vários)',
  `enunciado` text,
  PRIMARY KEY (`id`),
  KEY `fk_conteudo_formulario_conteudo1_idx` (`id_conteudo`),
  CONSTRAINT `fk_conteudo_formulario_conteudo1` FOREIGN KEY (`id_conteudo`) REFERENCES `conteudo` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=645 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Table structure for table `aluno_opcao`
--

DROP TABLE IF EXISTS `aluno_opcao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aluno_opcao` (
  `id_aluno` int(11) NOT NULL,
  `id_conteudo_formulario` int(11) NOT NULL,
  `valor` text NOT NULL COMMENT 'Dividir ''_'' para cada resposta caso tenha mais de uma ',
  `log_data` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_aluno`,`id_conteudo_formulario`),
  KEY `fk_aluno_has_formulario_opcao_aluno1_idx` (`id_aluno`),
  KEY `fk_aluno_opcao_conteudo_formulario1_idx` (`id_conteudo_formulario`),
  CONSTRAINT `fk_aluno_has_formulario_opcao_aluno1` FOREIGN KEY (`id_aluno`) REFERENCES `aluno` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_aluno_opcao_conteudo_formulario1` FOREIGN KEY (`id_conteudo_formulario`) REFERENCES `conteudo_formulario` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Esta tabela vai manter sempre o ultimo envio do aluno';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `aluno_opcao_envios`
--

DROP TABLE IF EXISTS `aluno_opcao_envios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aluno_opcao_envios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_aluno` int(11) NOT NULL,
  `id_conteudo_formulario` int(11) NOT NULL,
  `valor` text NOT NULL COMMENT 'Dividir ''_'' para cada resposta caso tenha mais de uma ',
  `log_data` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_aluno_has_formulario_opcao_aluno1_idx` (`id_aluno`),
  KEY `fk_aluno_opcao_conteudo_formulario1_idx` (`id_conteudo_formulario`),
  CONSTRAINT `fk_aluno_has_formulario_opcao_aluno10` FOREIGN KEY (`id_aluno`) REFERENCES `aluno` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_aluno_opcao_conteudo_formulario10` FOREIGN KEY (`id_conteudo_formulario`) REFERENCES `conteudo_formulario` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8 COMMENT='Esta tabela vai manter todos os envios do aluno';
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Table structure for table `idioma`
--

DROP TABLE IF EXISTS `idioma`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `idioma` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(45) DEFAULT NULL,
  `sigla` varchar(10) DEFAULT NULL,
  `padrao` tinyint(1) DEFAULT NULL COMMENT 'So devera haver um padrao. Se o idioma nao estiver definido ao acessar o portal, devera carregar por preferencia o padrao (ou o primeiro encontrado se nao houver padrao)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Table structure for table `atividade_coluna`
--

DROP TABLE IF EXISTS `atividade_coluna`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `atividade_coluna` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_idioma` int(11) NOT NULL,
  `id_atividade` int(11) NOT NULL,
  `coluna1` int(11) NOT NULL,
  `coluna2` int(11) NOT NULL COMMENT 'Deve ser correspondente a coluna 1 para esta correto',
  `tipo1` char(3) NOT NULL COMMENT 'TEX#Texto;IMG#Imagem;VID#Vídeo',
  `tipo2` char(3) NOT NULL COMMENT 'TEX#Texto;IMG#Imagem;VID#Vídeo',
  `coluna1Text` text COMMENT 'Caso o tipo seja TEX - Não obrigatório\nPode ter para os outros tipos também, caso queira.',
  `coluna2Text` text COMMENT 'Caso o tipo seja TEX - Não obrigatório\nPode ter para os outros tipos também, caso queira.',
  PRIMARY KEY (`id`,`id_idioma`),
  KEY `fk_atividade_relacionar_coluna_atividade1_idx` (`id_atividade`),
  KEY `fk_atividade_relacionar_idioma1_idx` (`id_idioma`),
  CONSTRAINT `fk_atividade_relacionar_coluna_atividade1` FOREIGN KEY (`id_atividade`) REFERENCES `atividade` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_atividade_relacionar_idioma1` FOREIGN KEY (`id_idioma`) REFERENCES `idioma` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=287 DEFAULT CHARSET=utf8 COMMENT='Cadastrar um para cada idioma, a atividade pode ter várias colunas relacionando pelo numero.\nEx: coluna (repete) - texto\n1- Texto qualquer\n1- Outro qualquer\n\nSe necessário deve-se tratar tudo pelo id da atividade';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `atividade_coluna_arquivo`
--

DROP TABLE IF EXISTS `atividade_coluna_arquivo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `atividade_coluna_arquivo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_atividade_coluna` int(11) NOT NULL,
  `coluna` int(11) NOT NULL,
  `arquivo` longblob NOT NULL COMMENT 'O arquivo',
  `nome` varchar(255) NOT NULL COMMENT 'O nome do arquivo',
  `tipo` varchar(255) NOT NULL COMMENT 'O tipo (mime/type) do arquivo',
  PRIMARY KEY (`id`),
  KEY `fk_atividade_relacionar_arquivo_atividade_relacionar_coluna_idx` (`id_atividade_coluna`),
  CONSTRAINT `fk_atividade_relacionar_arquivo_atividade_relacionar_coluna1` FOREIGN KEY (`id_atividade_coluna`) REFERENCES `atividade_coluna` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=162 DEFAULT CHARSET=utf8 COMMENT='Deve-se adicionar 2 arquivos caso as colunas tenham arquivos';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `atividade_idioma`
--

DROP TABLE IF EXISTS `atividade_idioma`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `atividade_idioma` (
  `id_idioma` int(11) NOT NULL,
  `id_atividade` int(11) NOT NULL,
  `titulo` varchar(90) DEFAULT NULL,
  `descricao` longtext,
  PRIMARY KEY (`id_idioma`,`id_atividade`),
  KEY `fk_idioma_atividade_atividade1_idx` (`id_atividade`),
  KEY `fk_idioma_atividade_idioma1_idx` (`id_idioma`),
  CONSTRAINT `fk_idioma_atividade_atividade1` FOREIGN KEY (`id_atividade`) REFERENCES `atividade` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_idioma_atividade_idioma1` FOREIGN KEY (`id_idioma`) REFERENCES `idioma` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `atividade_opcao`
--

DROP TABLE IF EXISTS `atividade_opcao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `atividade_opcao` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `valor` varchar(50) DEFAULT NULL COMMENT 'É o "label" do campo',
  `valor_fonetico` varchar(100) DEFAULT NULL COMMENT 'representação fonética da resposta. É maior por que a fonética pode ser diferente',
  `id_atividade` int(11) NOT NULL,
  `correta` char(1) NOT NULL DEFAULT 'N' COMMENT 'Campo   de verificação da opção correta da atividade, somente uma opção será marcada com S = Sim, o padrão é N = Não. ',
  PRIMARY KEY (`id`),
  KEY `fk_atividade_campo_atividade1_idx` (`id_atividade`),
  CONSTRAINT `fk_atividade_campo_atividade1` FOREIGN KEY (`id_atividade`) REFERENCES `atividade` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `biblioteca_imagem`
--

DROP TABLE IF EXISTS `biblioteca_imagem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `biblioteca_imagem` (
  `id` int(11) NOT NULL,
  `titulo` varchar(150) NOT NULL,
  `estilo` varchar(150) DEFAULT NULL,
  `ano` varchar(4) DEFAULT NULL,
  `fonte` text,
  `link` text,
  `palavra_chave` text NOT NULL,
  `arquivo` longblob,
  `arquivo_name` varchar(255) DEFAULT NULL,
  `arquivo_type` varchar(255) DEFAULT NULL,
  `arquivo_size` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `biblioteca_musica`
--

DROP TABLE IF EXISTS `biblioteca_musica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `biblioteca_musica` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(150) NOT NULL,
  `compositor` varchar(150) DEFAULT NULL,
  `estilo` varchar(150) DEFAULT NULL,
  `interprete` varchar(150) DEFAULT NULL,
  `ano` varchar(4) DEFAULT NULL,
  `fonte` text,
  `palavra_chave` text NOT NULL,
  `arquivo` longblob,
  `arquivo_name` varchar(255) DEFAULT NULL,
  `arquivo_type` varchar(255) DEFAULT NULL,
  `arquivo_size` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `biblioteca_obra_arte`
--

DROP TABLE IF EXISTS `biblioteca_obra_arte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `biblioteca_obra_arte` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(150) NOT NULL,
  `nome_artista` varchar(150) DEFAULT NULL,
  `estilo_arte` varchar(150) DEFAULT NULL,
  `ano` varchar(4) DEFAULT NULL,
  `fonte` text,
  `palavra_chave` text NOT NULL,
  `arquivo` longblob,
  `arquivo_name` varchar(255) DEFAULT NULL,
  `arquivo_type` varchar(255) DEFAULT NULL,
  `arquivo_size` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `biblioteca_video`
--

DROP TABLE IF EXISTS `biblioteca_video`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `biblioteca_video` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(150) NOT NULL,
  `nome_autor` varchar(150) DEFAULT NULL,
  `ano` varchar(4) DEFAULT NULL,
  `fonte` text,
  `palavra_chave` text NOT NULL,
  `arquivo` longblob,
  `arquivo_name` varchar(255) DEFAULT NULL,
  `arquivo_type` varchar(255) DEFAULT NULL,
  `arquivo_size` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `configuracao`
--

DROP TABLE IF EXISTS `configuracao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `configuracao` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sistema` varchar(255) NOT NULL,
  `empresa` varchar(255) DEFAULT NULL,
  `endereco` varchar(255) DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  `twitter` varchar(255) DEFAULT NULL,
  `facebook` varchar(255) DEFAULT NULL,
  `email` text COMMENT 'Pode ser vários separados por ,',
  `telefone` text COMMENT 'Pode ser vários separados por ,',
  `email_contato` text COMMENT 'Pode ser vários separados por ,',
  `titulo_contato` varchar(255) DEFAULT NULL,
  `relatorio_logo` varchar(255) DEFAULT NULL COMMENT 'Logo que sera apresentada nos relatórios por padrão',
  `relatorio_cabecalho` text COMMENT 'Cabeçalho que sera apresentado nos relatórios por padrão',
  `log_usuario` varchar(20) DEFAULT NULL,
  `log_data` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Registro único de configuracao';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `constantes`
--

DROP TABLE IF EXISTS `constantes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `constantes` (
  `chave` varchar(50) NOT NULL,
  `valor` text,
  PRIMARY KEY (`chave`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `conteudo_arquivo`
--

DROP TABLE IF EXISTS `conteudo_arquivo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conteudo_arquivo` (
  `id_conteudo` int(11) NOT NULL,
  `arquivo` longblob NOT NULL COMMENT 'O arquivo',
  `nome` varchar(255) NOT NULL COMMENT 'O nome do arquivo',
  `tipo` varchar(255) NOT NULL COMMENT 'O tipo (mime/type) do arquivo',
  PRIMARY KEY (`id_conteudo`),
  KEY `fk_conteudo_audio_idx` (`id_conteudo`),
  CONSTRAINT `fk_conteudo_audio` FOREIGN KEY (`id_conteudo`) REFERENCES `conteudo` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Table structure for table `formulario_opcao`
--

DROP TABLE IF EXISTS `formulario_opcao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formulario_opcao` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_conteudo_formulario` int(11) NOT NULL,
  `valor` varchar(50) DEFAULT NULL COMMENT 'É o "label" do campo',
  `correta` char(1) DEFAULT 'N' COMMENT 'Campo   de verificação da opção correta da atividade, somente uma opção será marcada com S = Sim, o padrão é N = Não. ',
  PRIMARY KEY (`id`),
  KEY `fk_formulario_opcao_conteudo_formulario1_idx` (`id_conteudo_formulario`),
  CONSTRAINT `fk_formulario_opcao_conteudo_formulario1` FOREIGN KEY (`id_conteudo_formulario`) REFERENCES `conteudo_formulario` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=259 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Table structure for table `laboratorio_idioma`
--

DROP TABLE IF EXISTS `laboratorio_idioma`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `laboratorio_idioma` (
  `id_idioma` int(11) NOT NULL,
  `id_laboratorio` int(11) NOT NULL,
  `titulo` varchar(45) DEFAULT NULL,
  `descricao` text,
  `termo_uso` text,
  PRIMARY KEY (`id_idioma`,`id_laboratorio`),
  KEY `fk_idioma_laboratorio_laboratorio1_idx` (`id_laboratorio`),
  KEY `fk_idioma_laboratorio_idioma1_idx` (`id_idioma`),
  CONSTRAINT `fk_idioma_laboratorio_idioma1` FOREIGN KEY (`id_idioma`) REFERENCES `idioma` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_idioma_laboratorio_laboratorio1` FOREIGN KEY (`id_laboratorio`) REFERENCES `laboratorio` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `perfil`
--

DROP TABLE IF EXISTS `perfil`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `perfil` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `ativo` char(1) NOT NULL DEFAULT '1',
  `log_usuario` varchar(20) DEFAULT NULL,
  `log_del` char(1) DEFAULT NULL,
  `log_data` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_perfil` int(11) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `login` varchar(20) NOT NULL,
  `senha` varchar(200) NOT NULL COMMENT 'Padrao: 321321',
  `email` varchar(150) NOT NULL,
  `superuser` char(1) DEFAULT '0',
  `foto` varchar(255) DEFAULT NULL,
  `ativo` char(1) NOT NULL DEFAULT '1',
  `recupera_senha_data` timestamp NULL DEFAULT NULL,
  `recuperar_senha_hash` varchar(256) DEFAULT NULL,
  `data_inicio` date NOT NULL COMMENT 'Data de início da validade ',
  `data_final` date DEFAULT NULL COMMENT 'Data final da validade ',
  `log_usuario` varchar(20) DEFAULT NULL,
  `log_del` char(1) DEFAULT 'N',
  `log_data` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `login_UNIQUE` (`login`),
  KEY `usuarios_FKIndex1` (`id_perfil`),
  CONSTRAINT `fk_3c11a0d2-d704-11df-9779-00225ff8f3ee` FOREIGN KEY (`id_perfil`) REFERENCES `perfil` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `log_admin`
--

DROP TABLE IF EXISTS `log_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `login` varchar(20) NOT NULL,
  `data_hora` timestamp NULL DEFAULT NULL,
  `acao` varchar(200) DEFAULT NULL,
  `tipo_operacao` char(1) DEFAULT NULL COMMENT 'O#Operação de Banco;A#Acesso ao sistema',
  `descricao` text,
  `ip` varchar(255) DEFAULT NULL,
  `nome_host` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_log_admin_usuario1_idx` (`id_usuario`),
  CONSTRAINT `fk_log_admin_usuario1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2007 DEFAULT CHARSET=utf8 PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `modulo_menu`
--

DROP TABLE IF EXISTS `modulo_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `modulo_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  `class` varchar(100) DEFAULT NULL,
  `icon` varchar(100) DEFAULT NULL,
  `ordem` int(11) DEFAULT NULL,
  `log_usuario` varchar(20) DEFAULT NULL,
  `log_del` char(1) DEFAULT 'N',
  `log_data` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nome_UNIQUE` (`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pagina`
--

DROP TABLE IF EXISTS `pagina`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pagina` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(45) NOT NULL COMMENT 'titulo da página',
  `conteudo` text COMMENT 'conteudo da página',
  `target` char(1) DEFAULT 'N',
  `ordem` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='Página de conteúdo demonstrativo/instrutivo';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pagina_idioma`
--

DROP TABLE IF EXISTS `pagina_idioma`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pagina_idioma` (
  `id_pagina` int(11) NOT NULL,
  `id_idioma` int(11) NOT NULL,
  `titulo` varchar(45) DEFAULT NULL,
  `conteudo` text,
  PRIMARY KEY (`id_pagina`,`id_idioma`),
  KEY `fk_pagina_has_idioma_idioma1_idx` (`id_idioma`),
  KEY `fk_pagina_has_idioma_pagina1_idx` (`id_pagina`),
  CONSTRAINT `fk_pagina_has_idioma_idioma1` FOREIGN KEY (`id_idioma`) REFERENCES `idioma` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_pagina_has_idioma_pagina1` FOREIGN KEY (`id_pagina`) REFERENCES `pagina` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `perfil_modulo_menu`
--

DROP TABLE IF EXISTS `perfil_modulo_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `perfil_modulo_menu` (
  `id_perfil` int(11) NOT NULL,
  `id_modulo_menu` int(11) NOT NULL,
  PRIMARY KEY (`id_perfil`,`id_modulo_menu`),
  KEY `fk_perfil_has_modulo_menu_modulo_menu1_idx` (`id_modulo_menu`),
  KEY `fk_perfil_has_modulo_menu_perfil1_idx` (`id_perfil`),
  CONSTRAINT `fk_perfil_has_modulo_menu_modulo_menu1` FOREIGN KEY (`id_modulo_menu`) REFERENCES `modulo_menu` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_perfil_has_modulo_menu_perfil1` FOREIGN KEY (`id_perfil`) REFERENCES `perfil` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `permissao`
--

DROP TABLE IF EXISTS `permissao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissao` (
  `id_perfil` int(11) NOT NULL,
  `id_modulo` int(11) NOT NULL,
  PRIMARY KEY (`id_perfil`,`id_modulo`),
  KEY `modulo_has_perfil_FKIndex1` (`id_modulo`),
  KEY `modulo_has_perfil_FKIndex2` (`id_perfil`),
  CONSTRAINT `fk_3c1d6034-d704-11df-9779-00225ff8f3ee` FOREIGN KEY (`id_modulo`) REFERENCES `modulo` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_3c28dcca-d704-11df-9779-00225ff8f3ee` FOREIGN KEY (`id_perfil`) REFERENCES `perfil` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `tema_idioma`
--

DROP TABLE IF EXISTS `tema_idioma`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tema_idioma` (
  `id_tema` int(11) NOT NULL,
  `id_idioma` int(11) NOT NULL,
  `titulo` varchar(45) DEFAULT NULL,
  `descricao` text,
  PRIMARY KEY (`id_tema`,`id_idioma`),
  KEY `fk_tema_idioma_idioma1_idx` (`id_idioma`),
  KEY `fk_tema_idioma_tema1_idx` (`id_tema`),
  CONSTRAINT `fk_tema_idioma_idioma1` FOREIGN KEY (`id_idioma`) REFERENCES `idioma` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_tema_idioma_tema1` FOREIGN KEY (`id_tema`) REFERENCES `tema` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

