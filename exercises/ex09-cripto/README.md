# Ex09 — Criptografia de coluna com pgcrypto

## Objetivo
Criptografar `ssn` e/ou `phone` em repouso usando `pgp_sym_encrypt` com chave em variável de sessão.

## O que é pgcrypto e por que usar
`pgcrypto` é uma extensão do PostgreSQL que provê funções de criptografia. Aqui usaremos criptografia simétrica (mesma chave para cifrar e decifrar) com `pgp_sym_encrypt`/`pgp_sym_decrypt`. A chave NUNCA deve ser armazenada em tabela/código; neste exercício, usaremos uma variável de sessão (`app.encryption_key`) apenas para fins didáticos.

Benefícios:
- Dados sensíveis ficam armazenados como `bytea` (cifrados) no disco/backup.
- Leitura em claro só ocorre se a sessão fornecer a chave correta.

## Passos
1. Garanta `CREATE EXTENSION pgcrypto;` (já feito em `db/init/00_extensions.sql`).
2. Escolha a estratégia de migração:
   - Recomendado (mais seguro): criar novas colunas `phone_enc BYTEA` e `ssn_enc BYTEA`, manter as originais temporariamente para migração e depois remover/limpar.
   - Alternativa (mais intrusiva): alterar tipo das colunas originais para `BYTEA` (exige mais cuidado e janelas de manutenção).
3. Crie funções utilitárias que dependem da chave na sessão:
   - `set_encrypted_phone(p_id INT, p_plain TEXT)` → cifra e grava em `phone_enc` usando `pgp_sym_encrypt(p_plain, current_setting('app.encryption_key'))`.
   - `get_decrypted_phone(p_id INT)` → lê `phone_enc` e decifra via `pgp_sym_decrypt(..., current_setting('app.encryption_key'))`.
4. Migre dados legados: para cada registro com `phone/ssn` preenchido, grave a versão cifrada em `phone_enc/ssn_enc` (requer a chave na sessão).
5. Valide: sem chave, a leitura clara deve falhar; com chave, deve funcionar.

## Critério de aceite
- Dados armazenados criptografados (bytea).
- Consulta de leitura requer `SET app.encryption_key = '...'`.

## Como testar (exemplo)
1) Defina a chave na sessão (didático):
```sql
SET app.encryption_key = 'sua_chave_segura'; -- não versionar, não registrar em logs
```
2) Migre os dados existentes (implemente no `crypto.sql`):
```sql
-- Após implementar as funções e colunas no arquivo do exercício:
SELECT hospital_data.set_encrypted_phone(1, '5551-1111');
SELECT hospital_data.get_decrypted_phone(1);
```
3) Verifique o armazenamento cifrado:
```sql
SELECT phone, phone_enc FROM hospital_data.patients WHERE id = 1;
-- phone_enc deve ser BYTEA (conteúdo ilegível), e phone pode ser limpo após a migração validada
```
4) Sem chave definida, a leitura clara deve falhar:
```sql
RESET app.encryption_key;
SELECT hospital_data.get_decrypted_phone(1); -- Deve lançar exceção
```

## Cuidados
- Nunca commit/registrar chaves em repositório, CI ou logs.
- Em produção, use um gerenciador de segredos (ex.: Vault, AWS KMS) e rotação periódica.
- Planeje como lidar com rotação de chave (recriptografia, versionamento de chaves).

## Dicas
- Veja `solutions/ex09-cripto/crypto.sql` para uma implementação de referência.

## Nota: PII e PHI
- PII: dados pessoais identificáveis (ex.: `ssn`, `phone`).
- PHI: PII com informações de saúde.
- Criptografia em repouso reduz o impacto de vazamentos/roubo de mídia/backup; combine com RBAC/RLS.

