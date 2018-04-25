# minesweeper
**_CAMP💣 MINAD💣_**

Este repositório armazena a solução Ruby para o game Campo Minado (Minesweeper).

> Campo minado é um popular jogo de computador para um jogador. Foi inventado por Robert Donner em 1989 e tem como objectivo revelar um campo de minas sem que alguma seja detonada.
 > - Wikipedia

### Instalação

Para a instalação correta da aplicação, deve-ser baixá-la do repositório e instalar suas dependências. Para isso, pode-se seguir os passos abaixo:
```

$ git clone https://github.com/laurindofljunior/minesweeper.git
$ cd minesweeper
$ bundle install
```

### Execução

A aplicação possui uma configuração padrão de 10 x 10 com 10 bombas espalhadas aleatoriamente. Para a execução deste modo de jogo, basta executar o comando abaixo:

```shell

$ ruby lib/Minesweeper.rb
```

A aplicação também permite que seja informado um tamanho de board e quantidade de bombas a serem espalhadas pelo mapa. Desta forma pode-se utilizar o comando:

```shell

$ ruby lib/Minesweeper.rb 3 4 5
```

No comando acima, os valores `3`, `4` e `5` representam a quantidade de `quadrantes no eixo Y`, quantidade de `quadrantes no eixo X` e quantidade de `bombas no mapa`, nessa ordem.

Abaixo uma imagem do board criado.

![alt minesweeper.001.png](https://github.com/laurindofljunior/minesweeper/raw/master/images/minesweeper.001.png "minesweeper.001.png")


### Classes

`Minesweeper.rb` Classe principal para a execução do Game.

`TerminalView.rb` Camada de visualização (View) para exibir o Game.

`Game.rb` Classe principal e responsável por gerir o fluxo e ações do game.

`GameBoard.rb` Representa o tabuleiro do Game.

`Coordinate.rb` Classe responsável por representar coordenadas de um elemento.

`ConfigDefault.rb` Valores padrões para a aplicação. Aplica os valores padrões quando alguns destes não são informados na execução do Game.


### Estrutura do projeto

Seguindo as boas práticas para estruturar projetos *Ruby*, o projeto segue a estrutura abaixo:
```
minesweeper
  |-- images
  |-- lib
  |     |--minesweeper
  |     |    |-- ConfigDefault.rb
  |     |    |-- Coordinate.rb
  |     |    |-- Game.rb
  |     |    |-- GameBoard.rb
  |     |    |-- TerminalView.rb
  |     |--Minesweeper.rb
  |--.gitignore
  |--Gemfile
  |--Gemfile.lock
  |--LICENSE
  |--README.md   
```


### ScreenShots

![alt minesweeper.001.png](https://github.com/laurindofljunior/minesweeper/raw/master/images/minesweeper.001.png "minesweeper.001.png")

![alt minesweeper.002.png](https://github.com/laurindofljunior/minesweeper/raw/master/images/minesweeper.002.png "minesweeper.002.png")

![alt minesweeper.003.png](https://github.com/laurindofljunior/minesweeper/raw/master/images/minesweeper.003.png "minesweeper.003.png")

![alt minesweeper.004.png](https://github.com/laurindofljunior/minesweeper/raw/master/images/minesweeper.004.png "minesweeper.004.png")

![alt minesweeper.005.png](https://github.com/laurindofljunior/minesweeper/raw/master/images/minesweeper.005.png "minesweeper.005.png")

![alt minesweeper.006.png](https://github.com/laurindofljunior/minesweeper/raw/master/images/minesweeper.006.png "minesweeper.006.png")

![alt minesweeper.007.png](https://github.com/laurindofljunior/minesweeper/raw/master/images/minesweeper.007.png "minesweeper.007.png")
