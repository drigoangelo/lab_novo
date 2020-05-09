# Laboratório virtual

### GIT LFS

Este repositório está utilizando [Large File Storage](https://git-lfs.github.com/). Antes de baixar o repositório é necessário instalar o LFS conforme instruções [nesse link](https://git-lfs.github.com/). Após a instalação do LFS basta usar o git normalmente que os arquivos grandes (administrados pelo LFS) serão atualizados automaticamente.

---

### Configuração do ambiente:

* Variável que define se está em ambiente de produção: 
arquivo `src/bib/classes/settings/Config.php` variável `$isProducao`.

* Idealmente, a senha de acesso ao banco de dados será individual: cada desenvolvedor terá a sua, e a do banco de dados de produção será definida apenas pelo administrador do servidor de produção. Ainda estamos ajustando para essa forma de trabalho, então, por enquanto, será necessária a atualização de alguns arquivos e tomar cuidado para que cada desenvolvedor não faça commit da sua senha particular.

* Para definir a senha do mysql, criar um arquivo chamado `.env` com as seguintes definições, substituindo a palavra senha pela respectiva senha, e alterando possíveis configurações locais.

```
MYSQL_ROOT_PASSWORD=senha
MYSQL_PASSWORD=senha
MYSQL_HOST=lab-mysql
MYSQL_PORT=3306
MYSQL_USER=lab2
MYSQL_DATABASE=lab2
MYSQL_CHARSET=utf8
```

* Configuração de banco de dados e email:
`src/bib/classes/settings/ConstantsConfig.php`

__IMPORTANTE__: O código foi alterado de forma a utilizar as variáveis de ambiente para conectar com o banco de dados. Se o servidor não for usar o docker, deve-se definir essas variáveis no servidor onde será executado o apache.

* É necessário criar os diretórios:

    - `docker/lab-mysql`: Diretório para arquivos relativos ao container lab-mysql.
    - `docker/lab-mysql/mysql`: Diretório no qual serão salvos os arquivos da base de dados.
    - `docker/lab-webserver/facialRecognitionLogin`: Diretório usado para salvar imagens de reconhecimento facial para login.
    - `docker/lab-webserver/logs`. Diretório de logs do apache.

Essa estrutura pode ser criada executando os seguintes comandos:

Windows:

```batch
mkdir docker\lab-mysql\mysql
mkdir docker\lab-webserver\facialRecognitionLogin
mkdir docker\lab-webserver\logs
```

Unix:

```bash
mkdir -p docker/{lab-mysql/mysql,lab-webserver/{facialRecognitionLogin,logs}}
```


* Para iniciar a aplicação, executar o comando `docker-compose up` no terminal, a partir do diretório raiz do projeto (o diretório que contém o arquivo `docker-compose.yml`). O sistema pode ser acessado navegando para `localhost/lab`.

* Após iniciar o sistema pela primeira vez, é necessário executar os scripts de inicialização do banco de dados. Esse script fará o INSERT dos dados necessários para que a aplicação funcione. Para executar esse script, seguir as orientações do [arquivo de inicizlização do banco de dados](db/data_backup/README.md).

---