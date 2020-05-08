# Laboratório virtual


### Configuração do ambiente:

* Variável que define se está em ambiente de produção: 
arquivo `src/bib/classes/settings/Config.php` variável `$isProducao`.

* Idealmente, a senha de acesso ao banco de dados será individual: cada desenvolvedor terá a sua, e a do banco de dados de produção será definida apenas pelo administrador do servidor de produção. Ainda estamos ajustando para essa forma de trabalho, então, por enquanto, será necessária a atualização de alguns arquivos e tomar cuidado para que cada desenvolvedor não faça commit da sua senha particular.

* Para definir a senha do mysql, criar um arquivo chamado `.env` com as seguintes definições, substituindo a palavra senha pela respectiva senha:

```
MYSQL_ROOT_PASSWORD=senha
MYSQL_PASSWORD=senha
```

* Configuração de banco de dados e email:
`src/bib/classes/settings/ConstantsConfig.php`

* É necessário criar um diretório `mysql` no caminho `docker/lab-mysql/`. Esse diretório será utilizado pelo container docker do mysql e precisa existir e estar vazio na primeira vez que for subir o ambiente. Os dados ficarão salvos nesse dietório.

* Para iniciar a aplicação, executar o comando `docker-compose up` no terminal, a partir do diretório raiz do projeto (o diretório que contém o arquivo `docker-compose.yml`). O sistema pode ser acessado navegando para `localhost/lab`.

* Após iniciar o sistema pela primeira vez, é necessário executar os scripts de inicialização do banco de dados. Esse script fará o INSERT dos dados necessários para que a aplicação funcione. Para executar esse script, seguir as orientações do [arquivo de inicizlização do banco de dados](db/data_backup/README.md).

---