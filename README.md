# delphi-person-db
Repositório destinado a um teste admissional

## Antes de utilizar

O banco de dados escolhido foi o SQLite por simplicidade. Então antes de rodar o projeto tem que criar um arquivo `database.db` vazio,
preencher corretamente o campo `Database` da conexão com o caminho absoluto do arquivo e rodar [o script do schema](/schema.sql) na conexão.

## Organização

`Database` são arquivos relacionados ao banco de dados e entidades.

`PersonScreen` é a tela principal onde é possível criar pessoas e editá-las.

`SearchScreen` é o modal de pesquisa, é possível pesquisar pessoas cadastradas no banco pelo nome ou cpf.

`Validation` é o código relacionado à validação dos dados. Cpf, nome e `TPerson` mais específicamente.

