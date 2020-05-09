# INICIALIZAÇÃO DO MYSQL

Este diretório contém os scripts de insert para inicialização do banco de dados, com as configurações iniciais.

O arquivo `restore.sh` executa os scripts na ordem correta para evitar erros, por exemplo, com foreign keys.

Executar o seguinte comando no terminal:

```
docker exec lab-mysql bash /application/db/data_backup/executar.sh
```