Este repositório foi criado com o objetivo de desenvolver e consolidar a camada de domínio e serviços em Dart, de forma totalmente desacoplada da interface Flutter. A ideia principal é ganhar mais experiência e conforto com a linguagem Dart antes de partir para a construção completa da aplicação com Flutter.

Aqui estou estruturando o projeto pensando em boas práticas de arquitetura, separando responsabilidades e evitando qualquer dependência direta da UI. Dessa forma, o código fica mais limpo, testável e reutilizável, permitindo que a interface seja apenas uma camada de consumo das regras de negócio.

O foco atual está na construção do “back-end” da aplicação, incluindo:

Entidades de domínio

Regras de negócio

Serviços independentes da interface

Organização voltada para escalabilidade e manutenção

Nos próximos passos, pretendo implementar:

Persistência de dados (banco de dados)

Exportação de arquivos

Um gerador de dados para testes e simulações

Esse projeto funciona como um laboratório de aprendizado e experimentação, preparando toda a base da aplicação antes da integração com o Flutter, garantindo uma fundação sólida e bem estruturada para o app final.
