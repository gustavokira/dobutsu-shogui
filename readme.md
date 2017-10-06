# Dobutsu Shogui

Peças:
Leão
Elefante
Girafa
Pintinho
Galo

## Classes

### Estrategia
A classe Estrategia é uma classe abstrata e tem um método chamado "escolherMovimento" que recebe dois argumentos: o estado atual do jogo e uma lista de movimentos possíveis.
```
	public Movimento escolherMovimento(Info info,ArrayList<Movimento>movimentos);
```

Toda estratégia deve ser uma classe derivada da classe Estrategia e reimplementar o método escolherMovimento.
Toda estratégia deve ter um nome, implementada pelo retorno do método "getNome".
Toda estratégia deve ter uma equipe responsável, implementada pelo retorno do método "getEquipe".

### Jogador
  #### public int getId()
  retorna um número inteiro que representa o id do jogador no jogo atual. 
  Se for 1, o jogador está na parte superior do tabuleiro e começa o jogo. Caso seja 2, o jogador esta na parte inferior do tabuleiro.
   
  public ArrayList<Peca> getPecasNaMao();
  retorna um ArrayList com objetos do tipo Peca que representam as peças na mão do jogador.

### Info
A classe info tem 4 métodos públicos importantes:
  
  public Tabuleiro getTabuleiro();
  retorna um objeto do tipo Tabuleiro para uso.
  
  ```
  Tabuleiro t = info.getTabuleiro();
  ```
  
  public Jogador getOponente();
  retorna um objeto do tipo Jogador que representa o oponente para uso.
  
  public ArrayList<Movimento> getMovimentos();
  retorna um ArrayList com objetos do tipo Movimento com os movimentos possíveis
  
  public Jogador getEu();
  retorna um objeto do tipo Jogador que representa a si jogador para uso.

### Tabuleiro
Classe responsável por representar o tabuleiro.

#### public Casa getCasa(int x, int y)
	retorna um objeto do tipo de Casa dado o seu x e o seu y.
	
#### public int getLargura()
	retorna um inteiro que representa a quantidade de colunas existentes no tabuleiro.
	
#### public int getAltura()
	retorna um inteiro que representa a quantidade de linhas existentes no tabuleiro.
	
#### public ArrayList<Peca> getPecas()
	retorna um ArrayList com todas as Pecas existentes no tabuleiro. Não inclui peças na "mão" dos jogadores. 
	
#### public ArrayList<Casa> getCasasVazias()
	retorna um ArrayList com todas as Casas Vazias dentro do tabuleiro.

pasta replays:
Onde ficam salvos os replays. O nome da pasta é o timestamp do começo do jogo.

pasta logs:
Onde ficam salvos os logs. O nome do arquivo é o timestamp do começo do jogo.


## Modalidades:
1) info2 contra info2
Participação nesta liga é obrigatória, salvo indicado pelo professor.

2) info2 contra bots
Participação desta liga não é obrigatória.
Caso um dos bots dos parcicipantes ganhe de todos os bots inimigos.

## Regras:
1) Toda versão de estratégia que vencer cada etapa deverá ser disponibilizada para todos os outros estudantes.

2) Uma estratégia deve retornar o movimento escolhido a cada turno. Cada resposta deve ser dada em menos de 4000ms. Se não responder neste tempo, o jogo encerra e a vitória é dada ao oponente.

3) O uso de qualquer estratégia que explore algum tipo de "bug" será desqualificada. 

## Recomendações:
1) Recomenda-se o versionamento das estratégias.
2) Recomenda-se buscar ideias para estratégias com outras pessoas pessoas além do professor da disciplina.
3) Recomenda-se que as equipes troquem informações sobre as estratégias a fim de vencer o verdadeiro inimigo.

## Notas:
As notas poderão ser diferentes para cada itegrante da equipe.
Serão usadas para compor a nota final:

1) O processo de desenvolvimento da ou das estratégias.
2) O processo de implementação da ou das estratégias.
3) Apresentação da estratégia ou das estratégias pela equipe.
4) Caso a equipe encontre um bug e tenha uma sugestão de como corrigí-lo, poderá ganhar nota extra por isso.

## obs:
1) Estratégias muito semelhantes de equipes diferentes poderão ser submetidas a uma análise mais profunda e as equipes serão arguidas. Caso as respostas não sejam satisfatórias, a equipe podera perder a nota; Este tipo de caso será tratado como um caso equivalente a um  trabalho copiado.
2) O código entregue deve ser legível, caso seja cifrado de alguma maneira, poderá não ser aceito.
3) Qualquer regra pode ser mudada de acordo com o andamento do exercício.
4) Casos não comtemplados neste documento será decididos com uma consulta aos participantes. Entretanto, a decisão final caberá ao professor.
