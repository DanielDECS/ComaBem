# Coma Bem

Projeto academico para o aplicativo Coma Bem, com modelagem de banco de dados,
script SQL e classes Dart para acesso aos dados.

## Arquivos principais

- `der_coma_bem.xml`: DER criado no Draw.io.
- `database.sql`: criacao do banco, tabelas, CRUD em SQL e usuarios com permissoes.
- `lib/models`: classes de objeto da Atividade 3.
- `lib/database`: classes de conexao e autenticacao da Atividade 4.
- `lib/repositories`: rotinas documentadas de insercao, consulta, alteracao e exclusao.

## Tabelas representadas

- `restaurante`
- `prato`
- `avaliacao_prato`

## Perfis de acesso

- `admin_coma_bem`: usuario com permissao total no banco `coma_bem`.
- `leitura_coma_bem`: usuario com permissao apenas para consultas.

## Observacao

As credenciais usadas no codigo seguem o exemplo definido no arquivo
`database.sql`, com finalidade didatica.
