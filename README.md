# pokedex_challenge

Projeto Flutter criado em resposta ao (desafio)['https://github.com/snapfi/mobile-code-challenge'].
Para realizar a implementação do código, foram seguidos alguns conceitos em termos de arquitetura,
(design)['https://www.figma.com/file/oyy40kpPCamOuJOQu1uYMo/Pok%C3%A9dex-(Community)?type=design&node-id=1016%3A1461&t=1525zdN4ReXRfE6d-1'] e testes.

Em relação à arquitetura e injeção de dependências, foi implementado seguindo os preceitos da clean
architecture com o uso de ferramentas nativas do Flutter para gerenciamento de estado, juntamente
com a biblioteca RxDart.

Para a injeção de dependências, foi utilizada a biblioteca flutter_modular em conjunto com a
biblioteca DIO para requisições HTTP/HTTPS e, por último, a biblioteca Mockito para criar classes
falsas voltadas para testes unitários.

# Como executar o projeto?

Basta apenas rodar o comando abaixo com um celular plugado ao computador ou com um emulador de dispositivos mobile aberto.

flutter run

# Como executar os testes?

Primeiramente, é necessário gerar os mocks necessários para algumas dependências utilizadas pelo
aplicativo.

O seguinte comando deve ser executado:

flutter pub run build_runner build --delete-conflicting-outputs

Por fim, basta apenas executar o comando:

flutter test

Dessa forma, os testes implementados serão executados."
