# Ex01 — Higiene de repositório e governança de mudanças

## Objetivo
Garantir práticas básicas de governança: donos claros, política de segurança, template de PR e checklist de revisão.

## Passos
1. Crie `CODEOWNERS` com responsáveis por `db/**`, `exercises/**`, `solutions/**`.
2. Crie `SECURITY.md` com como reportar vulnerabilidades e SLA de resposta.
3. Crie `.github/pull_request_template.md` com checklist mínima:
   - [ ] Sem segredos expostos
   - [ ] Lint de SQL passou
   - [ ] Migrações revisadas
4. Sugestão: configurar proteção de branch (fora do repo local).

## Critério de aceite
- Arquivos presentes e versionados; conteúdo mínimo preenchido.

## Dicas
- Veja exemplos prontos em `solutions/ex01-higiene-repo/`.


## Nota: PII e PHI
- PII: dados pessoais que identificam uma pessoa (ex.: nome, CPF/RG, endereço, telefone, e-mail, data de nascimento, IP, biometria).
- PHI: PII associada a informações de saúde (ex.: exames, diagnósticos, internações).
- Neste treinamento, evite expor PII/PHI em código, issues, PRs e exemplos; use dados sintéticos e controles como RBAC/RLS, mascaramento e criptografia.

## O que é `CODEOWNERS` e como escrever
`CODEOWNERS` é um arquivo usado pelo GitHub para mapear partes do repositório a donos (usuários ou times). Efeitos práticos:
- Solicita revisão automática dos donos quando há mudanças nos arquivos/pastas mapeados.
- Pode ser exigido pelo branch protection (ex.: “Require review from Code Owners”).

Onde colocar:
- `/.github/CODEOWNERS` (preferencial) ou `/CODEOWNERS` na raiz. O primeiro encontrado é usado.

Sintaxe (ordem importa; a primeira regra que casa vence):
- `padrão path` seguido por um ou mais donos (`@org/time` ou `@usuario`).
- Exemplos de padrões: `*`, `db/**`, `exercises/ex0*/**`, `*.sql`

Exemplos práticos:
```txt
# Dono padrão do repositório
* @dados-rhp-core

# Tabelas, schemas e migrações: time core
/db/* @dados-rhp-core

# Exercícios: time de instrutores
/exercises/* @dados-rhp-trainers
/solutions/* @dados-rhp-trainers

# Arquivos de CI: responsável pela plataforma
/.github/* @rhp-devops
```
Boas práticas:
- Mantenha regras específicas acima das genéricas.
- Use times (`@org/time`) para evitar bloqueios por ausência de indivíduos.
- Revise se os times têm permissão de leitura no repo (senão o GitHub não requisita review).

## Como escrever uma política de segurança (`SECURITY.md`)
Objetivo: orientar como reportar vulnerabilidades de forma segura e definir expectativas.

Elementos recomendados:
- Como reportar: e-mail seguro ou formulário; evitar issues públicas.
- Escopo: o que está coberto (este repo/sistemas relacionados).
- SLA de resposta: ex.: confirmação em 3 dias úteis; mitigação em 10.
- Versões/suporte: o que será corrigido (ex.: main + último release).
- Divulgação responsável: fluxo de correção antes de tornar público.
- Safe harbor: compromisso de não acionar medidas punitivas para pesquisa de boa-fé.
- Dados sensíveis: não enviar PII/PHI reais nos relatos; usar dados sintéticos.

Modelo inicial (adapte nomes/contatos):
```md
# Política de Segurança
Obrigado por ajudar a manter este projeto seguro.

## Reporte de vulnerabilidades
- Envie um e-mail para security@hospitalportugues.org.br com detalhes e steps para reproduzir.
- Não abra issues públicas com informações sensíveis.
- Não inclua PII/PHI reais; use dados sintéticos.

## SLA
- Confirmação de recebimento: até 3 dias úteis.
- Avaliação e plano de mitigação: até 10 dias úteis.

## Escopo
- Este repositório e componentes diretamente relacionados ao seu uso (ambiente de treino).

## Divulgação responsável
- Trabalharemos com você até a correção estar disponível; pedimos embargo público até então.

## Safe harbor
- Pesquisas de boa-fé conduzidas de acordo com esta política não serão alvo de ação legal.
```

## Checklist de implementação (neste exercício)
1) Criar `/.github/CODEOWNERS` (ou `/CODEOWNERS`) com donos por escopo (db, exercises, solutions, CI).
2) Criar `/SECURITY.md` com itens: como reportar, SLA, escopo, divulgação responsável, safe harbor.
3) Criar `/.github/pull_request_template.md` com checklist de segurança/qualidade.
4) (Opcional) Ativar “Require review from Code Owners” na proteção da branch principal.

