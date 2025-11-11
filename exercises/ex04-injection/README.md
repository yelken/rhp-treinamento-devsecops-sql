# Ex04 — SQL Injection em SQL dinâmico

## Objetivo
Corrigir SQL dinâmico vulnerável em função PL/pgSQL.

## Passos
1. Analise `vulnerable_report.sql` e identifique o ponto vulnerável (ORDER BY dinâmico).
2. Implemente validação e whitelisting do parâmetro.
3. Evite concatenação direta em SQL dinâmico.

## Critério de aceite
- Função segura que só ordena por colunas permitidas.
- Ataques via strings maliciosas não funcionam.

## Dicas
- Use `CASE`/mapeamento para traduzir parâmetros em identificadores seguros.
- Veja `solutions/ex04-injection/secure_report.sql`.

## Nota: PII e PHI
- PII: dados pessoais identificáveis; PHI: PII com saúde.
- Injeções podem expor PII/PHI; sempre valide e faça whitelist de identificadores/ordenação e use `format(%I)`/binds.

