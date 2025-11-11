# Ex21 — Princípio do Menor Dado (minimização de dados)

## Objetivo
Aplicar o princípio do menor dado: retornar apenas as colunas e linhas estritamente necessárias, reduzindo exposição de PII/PHI e custo de execução.

## Passos
1. Analise `queries/bad.sql` (retorna colunas/linhas demais).
2. Reescreva selecionando só colunas necessárias e filtre por tempo/departamento.
3. Valide tamanho do resultado, colunas e custo com `EXPLAIN ANALYZE`.

## Critério de aceite
- Nenhuma PII desnecessária.
- Número de colunas/linhas reduzido e custo menor que a versão ruim.

## Dicas
- Evite `SELECT *`. Prefira colunas de chave/medidas/atributos estritamente requeridos.

## Nota: PII e PHI
- PII: dados pessoais identificáveis; PHI: PII com saúde.
- Minimizar dados é a primeira camada de proteção (antes de mascarar/criptografar).


