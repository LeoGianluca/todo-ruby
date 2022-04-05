
# ToDo - Ruby CLI

## Sobre

Foi desenvolvido um sistema baseado em linha de comando com ruby. O sistema conta com as **funções de criação, remoção e listagem de tarefas** que são **salvas em um arquivo *.CSV***.

### Estrutura

```bash
  .
  ├── tmp
  │   └── task.csv
  ├── README.md
  ├── test_todo.rb
  └── todo.rb
```

## Execução do projeto

Para que seja possível a execução do código é necessário possuir o ruby instalado e as Gem's:

- CSV (gem install csv);
- Minitest (gem install minitest).

Clone o projeto e abra o diretório:

```bash
  git clone https://github.com/LeoGianluca/todo-ruby && cd todo-ruby.
```

Instale as dependências:

```bash
  bundle install
```

Para saber as opções do sistema execute no diretório: *`ruby todo.rb`*

```bash
  ==== ToDo List ====

  ruby todo.rb add ['nome', 'descricao', 'status (OPEN / PENDING / CLOSE)']
  ruby todo.rb delete 1 - [Insira o ID do item]
  ruby todo.rb list
```

Para execução dos testes unitários execute no diretório: *`ruby test_todo.rb`*.

### Exemplo

```bash
  # Criar tarefa
  ruby todo.rb add "Jogar o Lixo" "Tarefa para jogar lixo" "OPEN"
```

```bash
  # Excluir tarefa
  ruby todo.rb delete 1 #Id da tarefa
```

```bash
  # Listar tarefas
  ruby todo.rb list
```


## Aplicação do SOLID

O projeto está dividido em três classes:

- Task: Utilizada como Controller;
- List: Utilizada como Model;
- ToDo: Utilizada como classe inicializadora e menu de opções.

As classes e seus métodos mantém o princípio da responsabilidade onde cada funcionalidade está centrada em uma única responsabilidade dentro do sistema desenvolvido. Assim sendo:
- A classe Task cuida e gerencia a inicialização das variáveis que estão sendo utilizadas em cada um dos métodos, sendo elas: id, name, description, status, created_at, updated_at.
- A classe List está fazendo a manipulação dos dados (adição, listagem e remoção) no arquivo *tasks.csv*.
- A classe ToDo apenas recebe os argumentos digitados com base na escolha do usuário.
Os métodos estão isolados o que propicia a expansão do código (Princípio Aberto-Fechado) sem que sejam necessárias modificações no que está desenvolvido, com apenas referências para as variáveis que em sua maioria estão publicadas em suas classes, que podem ser referenciadas. 

Devido a sua natureza não é acredito ser necessária a aplicação de métodos de derivação ou abstração como o Princípio da substituição de Liskov ou Princípio da Segregação da Interface, pois não era algo tão expansivo que apresentaria diversificação de tarefas devido às opções de nome e descrição de cada tarefa.
