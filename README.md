# sw_teste


# Description

O projeto possui as seguintes funcionalidades:

 - Autenticação via `username` e `password`
 - Atualização dos tokens via `refreshToken`
 - Cancelamento de token, `logout`
 - Recuperação de um usuário através do `token`
 - Recuperação orders
 - Filtrar as orders por todas, `pendentes` e `finalizadas`, ou apenas `pendentes`
 - Finalização de uma order
 - Criação de uma order

# Technical description

Para construção do aplicativo usamos os seguintes `packages` e `implementações`:

`provider` e `ChangeNotifier`: Respectivamente, para injeção de dependências no contexto e gerenciamento de estados com `ValueNotifier`.

`get_it`: Para criar nossos `services` e injetar dependências para toda aplicação.

`go_router`: Optei pelo uso do `go_router` para a navegação, e também pela navegação com contexto, caso contrário, para navegar sem o contexto, poderia criar um `ServiceNavigation` injetado com `get_it` para recuperar meu `router`.

`Enhanced Enums`: Implementação para definição e aplicação nos cabeçalhos das requisições http, com `Enhanced Enum` posso definir o tipo e atribuir valores para evitar conversões do `enum` em si usando `type` atributo.

`Dart define`: Implementação para manter nossa url fora da aplicação até o momento do nosso build.

`Either`: Implementação para o tratamento de erros, facilitando a obtenção de mais de um tipo esperado, podendo ser nosso objeto desejado, ou nosso `AppError` como classe padrão que recupera nossas mensagens de erro vindas dda API.

`flutter_secure_storage`: Para o armazenamento seguro dos tokens.

`intl`: Para formatar nossas datas.

`http`: Para ser nosso client e nos facilitar com as requisições para a `API`

*observação:* Todos os packages externos estão nas versões mais recentes encontradas.

# Observações

Quando vou fazer a chamada de cancelamento de token (`cancelToken()`), recebo uma resposta em branco e o respectivo `status code`, portanto optei por retornar um `bool` caso receba uma resposta de sucesso ou nossa classe padrão `AppError` para lidar com um posspivel erro vindo da `API`.

Também simulei todas as exceções da `API` para `Erro inesperado` para deixar mais simples, e foquei no tratamento dos erros da `API`.

# Run project
Flutter: `3.27.3`
Dart: `3.6.1`
DevTools: `2.40.2`

`flutter run --dart-define=BASE_URL=https://dev-techtest.swfast.com.br`
