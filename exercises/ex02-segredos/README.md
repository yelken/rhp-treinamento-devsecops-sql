# Ex02 — Gestão de segredos (sem credenciais expostas)

## Objetivo
Aprender a conectar no banco sem “queimar” usuário/senha no repositório (sem credenciais hardcoded).

## Instruções iniciais (sem precisar de shell script)
Você tem duas opções simples para testar a conexão:

- Opção A: Criar um arquivo `.env` local (não versionado) e usar um comando `psql`.
- Opção B: Usar o comando `psql` passando a senha por variável de ambiente temporária.

O repositório já ignora `.env` via `.gitignore`.

### Passo 1) Crie seu `.env` local (não comite!)
Crie o arquivo `.env` na raiz do projeto com este conteúdo (ajuste se necessário):

```txt
DB_HOST=localhost
DB_PORT=5432
DB_NAME=hospital
DB_USER=rhp
DB_PASSWORD=rhp_password
```

Confirme que `.env` não aparece em “Changes” no Git (está no `.gitignore`).

### Passo 2) Teste a conexão (sem script)
Use o arquivo `exercises/ex02-segredos/test_connection.sql` para validar.

- Git Bash (Windows) / macOS / Linux:
```bash
export PGPASSWORD="rhp_password"
psql -h localhost -p 5432 -U rhp -d hospital -f exercises/ex02-segredos/test_connection.sql
```

- PowerShell (Windows):
```powershell
$env:PGPASSWORD = "rhp_password"
psql -h localhost -p 5432 -U rhp -d hospital -f exercises/ex02-segredos/test_connection.sql
```

Se preferir, substitua os valores acima pelos do seu `.env` manualmente.

Observação: o uso do `PGPASSWORD` acima é apenas para teste local e não deve ser versionado. Para automação, prefira gerenciadores de segredos.

### Passo 3) Veja o anti-exemplo (não use em produção)
Abra `scripts/connect_insecure.sh`. Ele usa credenciais fixas/hardcoded no arquivo. O objetivo do exercício é evitar esse padrão. Não comite credenciais em:
- arquivos `.sh`, `.ps1`, `.sql`
- variáveis em `.yml` de CI
- código ou comentários

### Passo 4) (Opcional) Script seguro de referência
Se quiser um exemplo de automação, veja `solutions/ex02-segredos/scripts/connect_secure.sh`. Ele lê variáveis do `.env` local e monta a URI em tempo de execução, sem armazenar senhas no repositório.

## Critério de aceite
- Existe um `.env` local (não commitado) com as variáveis de conexão.
- A conexão funciona ao executar o `test_connection.sql`.
- Não há credenciais commitadas em scripts/SQL/CI (use o histórico do Git e o Gitleaks para checar).

## Dicas
- Rode um scan local de segredos antes de commitar:
```bash
gitleaks detect --no-git -c .gitleaks.toml
```
- Nunca suba `.env` ou arquivos com senhas. Se subiu por engano, apague do Git e troque a credencial.

## Nota: PII e PHI
- PII: dados pessoais identificáveis (ex.: nome, CPF/RG, endereço, telefone, e-mail, data de nascimento, IP, biometria).
- PHI: PII associada a saúde (ex.: exames, diagnósticos, internações).
- Jamais coloque PII/PHI ou segredos (senhas, chaves) em repositório; proteja com variáveis de ambiente e gerenciadores de segredo.


