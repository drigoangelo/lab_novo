# INICIALIZAÇÃO DO MYSQL

Este diretório contém os scripts de insert para inicialização do banco de dados, com as configurações iniciais.

O arquivo `restore.sh` executa os scripts na ordem correta para evitar erros, por exemplo, com foreign keys.

Antes de executar esse arquivo, alterar a senha do mysql no início do arquivo `SENHA="minhasenha"` substituindo `minhasenha` pela senha correta.