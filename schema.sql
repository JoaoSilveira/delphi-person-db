create table if not exists Person (
  id integer primary key,
  ativo boolean not null,
  cpf text not null unique,
  nome text not null,
  obs text
);

create index if not exists PersonNameIndex
on Person(nome);