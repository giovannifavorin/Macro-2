# Macro 2
 Macro 2, Projeto final da Apple Developer Academy

# Padrões de Branches e Commits

## Branches

- **`main`**: Branch principal contendo o código pronto para envio para a loja.
- **`develop`**: Branch de desenvolvimento, onde novas funcionalidades são integradas.
- **`feature/nome-da-feature`**: Branches criadas a partir de `develop` para o desenvolvimento de novas funcionalidades.
- **`hotfix/nome-do-hotfix`**: Branches criadas para correções urgentes em produção.

## Commits

Siga o padrão de mensagens de commits abaixo:

- **`feat: descrição da nova funcionalidade`**: Para adição de novas funcionalidades.
  - Exemplo: `feat: adicionar autenticação de usuários`
- **`fix: descrição do bug corrigido`**: Para correção de bugs.
  - Exemplo: `fix: corrigir bug no cadastro`
- **`refactor: descrição da refatoração`**: Para mudanças de código que não alteram a funcionalidade.
  - Exemplo: `refactor: otimizar função de login`

## Passo a Passo para Merge

1. **Crie uma branch de feature ou hotfix**:
   - Para desenvolver uma nova funcionalidade, crie uma branch a partir de `develop`:  
     ```bash
     git checkout develop
     git checkout -b feature/nome-da-feature
     ```
   - Para correções urgentes em produção, crie uma branch a partir de `main`:  
     ```bash
     git checkout main
     git checkout -b hotfix/nome-do-hotfix
     ```

2. **Desenvolva suas mudanças** e faça commits seguindo o padrão descrito na seção de commits.

3. **Abra um Pull Request (PR)**:
   - Para features, faça o PR da sua branch `feature/nome-da-feature` para `develop`.
   - Para hotfixes, faça o PR da sua branch `hotfix/nome-do-hotfix` para `main` e `develop` (para garantir que as correções também cheguem ao código em desenvolvimento).

4. **Realize a revisão e o merge**:
   - Após a aprovação do PR, faça o merge da sua branch de volta para `develop` (para features) ou para `main` e `develop` (para hotfixes).

5. **Delete a branch**:
   - Após o merge, delete a branch de feature ou hotfix, pois ela não será mais necessária.
     ```bash
     git branch -d feature/nome-da-feature
     git branch -d hotfix/nome-do-hotfix
     ```

6. **Para releases**:
   - Quando `develop` estiver pronto para uma nova versão, crie uma branch `release/nome-da-release` a partir de `develop` para realizar testes finais e correções de pequenos bugs. Depois, faça o merge para `main` e `develop`.
