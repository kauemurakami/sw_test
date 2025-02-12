# sw_teste

  1 - Description<br/>
  2 - Technical description<br/>
  3 - Observations<br/>
  4 - Architectural design<br/>
  5 - Run project

### Description

O projeto possui as seguintes funcionalidades:

 - Autenticação via `username` e `password`
 - Atualização dos tokens via `refreshToken`
 - Cancelamento de token, `logout`
 - Recuperação de um usuário através do `token`
 - Recuperação orders
 - Filtrar as orders por todas, `pendentes` e `finalizadas`, ou apenas `pendentes`
 - Finalização de uma order
 - Criação de uma order

### Technical description

Para construção do aplicativo usamos os seguintes `packages` e `implementações`:

`get_it`: Para criar nossos `services` e injetar dependências em nossa aplicação.

`provider` e `ChangeNotifier`: Respectivamente, para injeção de dependências no contexto e gerenciamento de estados com `ValueNotifier`.

`go_router`: Optei pelo uso do `go_router` para a navegação, e também pela navegação com contexto, caso contrário, para navegar sem o contexto, poderia criar um `ServiceNavigation` injetado com `get_it` para recuperar meu `router`, podendo assim navegar via router sem uso de contexto, mas optei pelo uso do contexto para deixar mais legível e compreensivo.

`Enhanced Enums`: Implementação para definição e aplicação nos cabeçalhos das requisições http, com `Enhanced Enum` posso definir o `type` e atribuir valores para evitar conversões do `enum` em si usando `type` atributo.

`Dart define`: Implementação para manter nossa url fora da aplicação até o momento da nossa build.

`Either`: Implementação para o tratamento de erros, facilitando a obtenção de mais de um tipo esperado, podendo ser nosso objeto desejado, ou nosso `AppError` como classe padrão que recupera nossas mensagens de erro vindas da `API`.

`flutter_secure_storage`: Para o armazenamento seguro dos tokens.

`intl`: Para formatar nossas datas.

`http`: Para ser nosso client e facilitar as requisições para a `API`.

*observação:* Todos os packages externos estão nas versões mais recentes encontradas até o dia de `11/02/2025`.

### Architectural design
Usando o padrão MVVM - Model-View-ViewModel

```shell
lib/
  constants/
  enums/
  models/
  repository/
    x_repository.dart
  routes/
    delegate/
    transitions/
    routes.dart
  services/
  utils/
    functions/
    extensions/
  view_model/
    x_controller.dart -> nomeei meus providers como controllers
  views/
    example/
      widgets/ -> widgets internos desta view
    example_view.dart -> widget principal
  widgets/ -> widgets que podem ser usados em mais de uma view
  main.dart
```

### Observations

Quando vou fazer a chamada de cancelamento de token (`cancelToken()`), recebo uma resposta em branco e o respectivo `status code`, portanto optei por retornar um `bool` caso receba uma resposta de sucesso ou nossa classe padrão `AppError` para lidar com um possível erro vindo da `API`.

Em relação aos `repositories` fiquei em dúvida sobre o que esperavam ver, e como já possuo injeção de duas dependências, `AuthService` e `ApiService`, para não criar mais singletons via `get_it`, optei apenas por instanciar meus `repository` em meus `controllers`, apenas para variar a implementação, mas poderiam facilmente ser injetados via `get_it`, o que deixariam eles disponíveis por toda aplicação, como queria eles apenas localmente, dentro de meu respectivo `controller`,  tomei essa decisão, deixando claro minha opção, mas também ciente do método de implementação via injeção de dependências com `get_it`.

Também simulei todas as exceções da `API` para `Erro inesperado` para deixar mais simples, e foquei no tratamento dos erros vindos da `API`.<br/>
Portanto ao receber uma exceção, retorno nossa classe padrão `AppError` com a mensagem de `Erro inesperado` por padrão.

# Run project
`Flutter: 3.27.3`<br/>
`Dart: 3.6.1`<br/>
`DevTools: 2.40.2`

`flutter run --dart-define=BASE_URL=https://dev-techtest.swfast.com.br`

**Atenção** defina o `--dart-define`, como mostrado no comando acima, para que possamos recuperar nossa `BASE_URL` via `Environment` do Dart.<br/>
Isso é importante, para não deixar nossa url exposta antes do momento da build, e optei por não definir um valor padrão, portanto este comando é obrigatório.
