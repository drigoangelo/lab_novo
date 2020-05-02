# Laboratório virtual


### Observações:

* Variável que define se está em ambiente de produção: 
arquivo `lab\bib\classes\settings\Config.php` variável `$isProducao`.

* Configuração de banco de dados e email:
`bib\classes\settings\ConstantsConfig.php`

* Fazer uma cópia do arquivo `docker-compose.MODELO.yml` com o nome `docker-compose.yml`, e definir senha para o usuário root e lab2 nas linhas 16 e 19 desse arquivo, respectivamente. __ATENÇÃO:__ não excluir nem alterar o arquivo modelo. O arquivo criado `docker-compose.yml` está sendo ignorado pelo git e não precisa ser feito commit dele, pois contém configurações locais da senha do banco de dados!

* Criar um diretório `mysql` no mesmo local que está o arquivo `docker-compose.yml`. Não é preciso colocar nada nesse diretório, ele será utilizado pelo docker container do mysql.
---