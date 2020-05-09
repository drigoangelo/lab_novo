#!/bin/bash

cd /application/db/data_backup/

mysql -u lab2 -p$MYSQL_PASSWORD lab2 < dump_entidade.sql
mysql -u lab2 -p$MYSQL_PASSWORD lab2 < dump_modulo.sql
mysql -u lab2 -p$MYSQL_PASSWORD lab2 < dump_acao.sql
mysql -u lab2 -p$MYSQL_PASSWORD lab2 < dump_aluno.sql
mysql -u lab2 -p$MYSQL_PASSWORD lab2 < dump_laboratorio.sql
mysql -u lab2 -p$MYSQL_PASSWORD lab2 < dump_tema.sql
mysql -u lab2 -p$MYSQL_PASSWORD lab2 < dump_atividade.sql
mysql -u lab2 -p$MYSQL_PASSWORD lab2 < dump_aluno_acesso.sql
mysql -u lab2 -p$MYSQL_PASSWORD lab2 < dump_aluno_atividade.sql
mysql -u lab2 -p$MYSQL_PASSWORD lab2 < dump_aluno_atividade_envios.sql
mysql -u lab2 -p$MYSQL_PASSWORD lab2 < dump_aluno_atividade_tipo.sql
mysql -u lab2 -p$MYSQL_PASSWORD lab2 < dump_aluno_atividade_tipo_envios.sql
mysql -u lab2 -p$MYSQL_PASSWORD lab2 < dump_aluno_imagem.sql
mysql -u lab2 -p$MYSQL_PASSWORD lab2 < dump_conteudo.sql
mysql -u lab2 -p$MYSQL_PASSWORD lab2 < dump_conteudo_formulario.sql
mysql -u lab2 -p$MYSQL_PASSWORD lab2 < dump_aluno_opcao.sql
mysql -u lab2 -p$MYSQL_PASSWORD lab2 < dump_aluno_opcao_envios.sql
mysql -u lab2 -p$MYSQL_PASSWORD lab2 < dump_idioma.sql
mysql -u lab2 -p$MYSQL_PASSWORD lab2 < dump_atividade_coluna.sql
mysql -u lab2 -p$MYSQL_PASSWORD lab2 < dump_atividade_coluna_arquivo.sql
mysql -u lab2 -p$MYSQL_PASSWORD lab2 < dump_atividade_idioma.sql
mysql -u lab2 -p$MYSQL_PASSWORD lab2 < dump_atividade_opcao.sql
mysql -u lab2 -p$MYSQL_PASSWORD lab2 < dump_biblioteca_imagem.sql
mysql -u lab2 -p$MYSQL_PASSWORD lab2 < dump_biblioteca_musica.sql
mysql -u lab2 -p$MYSQL_PASSWORD lab2 < dump_biblioteca_obra_arte.sql
mysql -u lab2 -p$MYSQL_PASSWORD lab2 < dump_biblioteca_video.sql
mysql -u lab2 -p$MYSQL_PASSWORD lab2 < dump_configuracao.sql
mysql -u lab2 -p$MYSQL_PASSWORD lab2 < dump_constantes.sql
mysql -u lab2 -p$MYSQL_PASSWORD lab2 < dump_conteudo_arquivo.sql
mysql -u lab2 -p$MYSQL_PASSWORD lab2 < dump_formulario_opcao.sql
mysql -u lab2 -p$MYSQL_PASSWORD lab2 < dump_laboratorio_idioma.sql
mysql -u lab2 -p$MYSQL_PASSWORD lab2 < dump_perfil.sql
mysql -u lab2 -p$MYSQL_PASSWORD lab2 < dump_usuario.sql
mysql -u lab2 -p$MYSQL_PASSWORD lab2 < dump_log_admin.sql
mysql -u lab2 -p$MYSQL_PASSWORD lab2 < dump_modulo_menu.sql
mysql -u lab2 -p$MYSQL_PASSWORD lab2 < dump_pagina.sql
mysql -u lab2 -p$MYSQL_PASSWORD lab2 < dump_pagina_idioma.sql
mysql -u lab2 -p$MYSQL_PASSWORD lab2 < dump_perfil_modulo_menu.sql
mysql -u lab2 -p$MYSQL_PASSWORD lab2 < dump_permissao.sql
mysql -u lab2 -p$MYSQL_PASSWORD lab2 < dump_tema_idioma.sql
