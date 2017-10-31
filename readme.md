# Dobutsu Shogui
jogo criado por Madoka Kitao. 

ESte software está dividido em duas partes: core e dobutsu_shogui. O core está escrito em Java e o dobutsu_shogui em Processing. No core estão as classes que simulam o jogo de tabuleiro original e no dobutsu_shogui os códigos que serão editados/extendidos para a atividade.

## Regras do Jogo
Este jogo é jogado por dois jogadores.



Um detalhamento das regras encontra-se no arquivo [en-dobutsu.pdf](https://github.com/gustavokira/dobutsu-shogui/blob/master/en-dobutsu.pdf) (em inglês). 


Outros nomes: yokai no mori, animal shogui.

Peças:
* Leão
* Elefante
* Girafa
* Pintinho
* Galo

## Classes

### [Estrategia](https://github.com/gustavokira/dobutsu-shogui/blob/master/core/src/core/Estrategia.java)
A classe Estrategia é uma classe abstrata e tem um método chamado "escolherMovimento" que recebe dois argumentos: o estado atual do jogo e uma lista de movimentos possíveis.
```
public Movimento escolherMovimento(Info info,ArrayList<Movimento>movimentos);
```
Toda estratégia deve ser uma classe derivada da classe Estrategia e reimplementar o método escolherMovimento.
Toda estratégia deve ter um nome, implementada pelo retorno do método "getNome".
Toda estratégia deve ter uma equipe responsável, implementada pelo retorno do método "getEquipe".

#### public Movimento escolherMovimento(Info info,ArrayList<Movimento>movimentos)
Este é o método que deve ser obrigatoriamente implementado para que uma estratégia funcione de fato. O jogo passa como parâmetros para o método um objeto do tipo Info e um ArrayList com objetos do tipo Movimento.
```
//implementação da escolha aleatória
public Movimento escolherMovimento(Info info,ArrayList<Movimento>movimentos){
	//sorteia um número randômico
	int r = int(random(movimentos.size()));
	//retorna o movimento com o indice sorteado.
	return movimentos.get(r);
}
```

#### public String getNome()
Método que deve ser reimplementado na classe de estratégia com o objetivo de identificar um nome para a estratégia. Ver exemplo na classe [EstrategiaAleatoria](https://github.com/gustavokira/dobutsu-shogui/blob/master/dobutsu_shogui/EstrategiaAleatoria.pde)
```
public String getNome(){
	return "aleatória";
}
```

#### public String getEquipe()
Método que deve ser reimplementado na classe de estratégia com o objetivo de identificar uma equipe para a estratégia, uma vez que podem existir estratégias com mesmo nome. Ver exemplo na classe [EstrategiaAleatoria](https://github.com/gustavokira/dobutsu-shogui/blob/master/dobutsu_shogui/EstrategiaAleatoria.pde)
```
public String getEquipe(){
	return "ash ketchum";
}
```

### [EstrategiaAleatoria](https://github.com/gustavokira/dobutsu-shogui/blob/master/dobutsu_shogui/EstrategiaAleatoria.pde)
Estratégia base que será usada como referência de desempenho. De todas os movimentos possíveis, ela escolhe uma qualquer com uma mesma probabilidade.
```
// é preciso usar o extends para que exista a relação de herança com a classe Estrategia
class EstrategiaAleatoria extends Estrategia{
 
  //reimplementação do método que efetivamente executa a estratégia.
  public Movimento escolherMovimento(Info info,ArrayList<Movimento>movimentos){
    int r = int(random(movimentos.size()));
    return movimentos.get(r);
  }
  
  //método que dá nome a estratégia
  public String getNome(){
    return "aleatória";
  }
  
  //método que dá nome a equipe
  public String getEquipe(){
    return "ash ketchum";
  }
}
```
  
### [Movimento](https://github.com/gustavokira/dobutsu-shogui/blob/master/core/src/core/Movimento.java)
Classe responsável por abstrair um movimento que um jogador pode fazer. Um movimento é composto por uma peça, uma posição x e uma y de destino, o jogador que pode fazer esse movimento e um tipo(colocar ou mover).

#### public String getTipo()
Retorna o tipo do movimento. Os movimentos podem ser de colocar ou de mover uma peça. Colocar, significa colocar uma peça em uma posição x e y livre. Mover implica em mover uma peça de uma posição x, y para outra posição x, y.
```
//pega o primeiro movimento
Movimento m = movimentos.get(0);
println(m.getTipo()); //será mostrado colocar ou mover;
```
  
#### public Peca getPeca()
Retorna um objeto do tipo Peca ao qual o movimento condiz.
```
//pega o primeiro movimento
Movimento m = movimentos.get(0);
Peca p = m.getPeca(); //pega a peça associada ao movimento;
```
  
#### public int getX()
Retorna a posição y de destino da peça do movimento em questão.
```
//pega todos os movimentos um por um
for(int i =0;i<movimentos.size();i++){
	Movimento m = movimentos.get(i);
	println(m.getX());//escreve todos os valores de x dos destinos de todas as peças que podem movimentar-se
}
```
  
#### public int getY()
Retorna a posição y de destino da peça do movimento em questão.
```
//pega o segundo movimento
Movimento m = movimentos.get(1);
println(m.getY());//escreve  o valor do y do destino da peça
```
  
#### public Jogador getJogador()
Retorna o jogador o qual pode fazer esse movimento.
```
//pega o segundo movimento
Movimento m = movimentos.get(1);
Jogador j = m.getJogador();
```
  
### [Jogador](https://github.com/gustavokira/dobutsu-shogui/blob/master/core/src/core/Jogador.java)
Classe que representa um jogador. Um jogador tem um id e peças em sua mão. Representa tanto o oponente quanto o o próprio jogador.

#### public int getId()
Retorna um número inteiro que representa o id do jogador no jogo atual. 
Se for 1, o jogador está na parte superior do tabuleiro e começa o jogo. Caso seja 2, o jogador esta na parte inferior do tabuleiro.
```
Jogador eu = info.getEu();
int i = eu.getId();
if(i == 1){
	println("estou jogando em cima");
}else{
	println("estou jogando em baixo");
}
```
   
#### public ArrayList<Peca> getPecasNaMao();
retorna um ArrayList com objetos do tipo Peca que representam as peças na mão do jogador.
```
Jogador j = new Jogador();
ArrayList<Peca> pecas = j.getPecasNaMao();
```	

### [Info](https://github.com/gustavokira/dobutsu-shogui/blob/master/core/src/core/Info.java)
A classe info tem 4 métodos públicos importantes:
  
  #### public Tabuleiro getTabuleiro();
  retorna um objeto do tipo Tabuleiro para uso.
  
  ```
  Tabuleiro t = info.getTabuleiro();
  ```
  
  #### public Jogador getOponente();
  retorna um objeto do tipo Jogador que representa o oponente para uso.
  ```
  Jogador opp = info.getOponente();
  int i = opp.getId();
  if(i == 1){
	println("opp esta jogando em cima");
  }else{
  	println("opp esta jogando em baixo");
  }
  ```
  
  #### public Jogador getEu();
  retorna um objeto do tipo Jogador que representa a si jogador para uso.
  ```
  Jogador eu = info.getEu();
  int i = eu.getId();
  if(i == 1){
	println("eu estou jogando em cima");
  }else{
  	println("eu estou jogando em baixo");
  }
  ```
  
  #### public ArrayList<Movimento> getMovimentos();
  retorna um ArrayList com objetos do tipo Movimento com os movimentos possíveis.
  ```
  //ex: contar quantos movimentos são de colocar ou de mover.
  int mv = 0;
  int cl = 0;
  for(int i =0;i<movimentos.size();i++){
  	Movimento m = movimentos.get(i);
	String tipo = m.getTipo();
	if(tipo.equals("mover")){
		mv++;
	}else{
		cl++;
	}
  }
  ```
  
### [Tabuleiro](https://github.com/gustavokira/dobutsu-shogui/blob/master/core/src/core/Tabuleiro.java)
Classe responsável por representar o tabuleiro.

#### public Casa getCasa(int x, int y)
retorna um objeto do tipo de Casa dado o seu x e o seu y.
  
  ```
  Tabuleiro t = info.getTabuleiro();
  Casa c = t.getCasa(0,0);
  ```
	
#### public int getLargura()
retorna um inteiro que representa a quantidade de colunas existentes no tabuleiro.
```
Tabuleiro t = info.getTabuleiro();
int largura = t.getLargura();
println(largura); //será mostrado 3;
```
  
#### public int getAltura()
retorna um inteiro que representa a quantidade de linhas existentes no tabuleiro.
```
Tabuleiro t = info.getTabuleiro();
int altura = t.getAltura();
println(altura); //será mostrado 4;
```

#### public ArrayList<Peca> getPecas()
retorna um ArrayList com todas as Pecas existentes no tabuleiro. Não inclui peças na "mão" dos jogadores. 
```
Tabuleiro t = info.getTabuleiro();
ArrayList<Peca> pecasNoTabuleiro = t.getPecas();
```
	
#### public ArrayList<Casa> getCasasVazias()
retorna um ArrayList com todas as Casas Vazias dentro do tabuleiro.
```
Tabuleiro t = info.getTabuleiro();
ArrayList<Casa> vazias = t.getCasasVazias();
```

### [Casa](https://github.com/gustavokira/dobutsu-shogui/blob/master/core/src/core/Casa.java)
Classe que representa uma casa do tabueiro.

#### public int getX();
retorna um inteiro que representa a posição x da casa.
```
Tabuleiro t = info.getTabuleiro();
Casa c = t.getCasa(2,1);
int x = c.getX();
println(x); //será mostrado 2;
```
  
#### public int getY();
retorna um inteiro que representa a posição y da casa.
```
Tabuleiro t = info.getTabuleiro();
Casa c = t.getCasa(2,1);
int y = c.getY();
println(y); //será mostrado 1;
```
  
#### public boolean temPeca();
retorna verdadeiro se existe uma peça nesta casa.
```
//no começo do jogo
Tabuleiro t = info.getTabuleiro();
Casa c1 = t.getCasa(0,0);
boolean b1 = c1.temPeca();
println(b1); //será mostrado true;

Casa c2 = t.getCasa(0,1);
boolean b2 = c2.temPeca();
println(b2); //será mostrado false;
```

#### public Peca getPeca();
retorna um objeto do tipo Peca que representa a peça nesta casa.
```
//no começo do jogo
Tabuleiro t = info.getTabuleiro();
Casa c1 = t.getCasa(0,0);
boolean b1 = c1.temPeca();
if(b1){
	Peca p = c1.getPeca();
	println(p.getNome()); //será mostrado gir.
}
```

### [Peca](https://github.com/gustavokira/dobutsu-shogui/blob/master/core/src/core/Peca.java)

#### public int getX()
retorna um inteiro que representa a posição x da peça.
  
#### public int getY()
retorna um inteiro que representa a posição y da peça.
  
#### public int getId()
retorna o id da peça. Cada peça tem um id único.
   
#### public Jogador getDono()
retorna um objeto jogador que representa o dono da peça.
```
Tabuleiro t = info.getTabuleiro();
Casa c = t.getCasa(0,0);
Peca p = c.getPeca();
Jogador j = p.getDono();
//o jogador j será o primeiro jogador no começo do jogo.
```  
  
#### public String getNome()
retorna o nome da peça, sempre é uma palavra com três 
- Girafa - "gir"
- Pintinho - "pin"
- Elefante - "ele"
- Leão - "leo"
- Galo - "gal"

```
Tabuleiro t = info.getTabuleiro();
Casa c = t.getCasa(0,0);
Peca p = c.getPeca();
String nome = p.getNome();
println(nome);
//deverá ser impresso o nome "gir" de girafa.
```

#### public int[][] getMatrizDeMovimento()
retorna uma matriz 3x3 que representa os movimentos de uma peça.

A matriz abaixo representa os movimentos do pintinho.
```
[0][1][0]
[0][0][0]
[0][0][0]
```

A matriz abaixo representa os movimentos do leão.
```
[1][1][1]
[1][0][1]
[1][1][1]
```

A matriz abaixo representa os movimentos do elefante.
```
[1][0][1]
[0][0][0]
[1][0][1]
```

A matriz abaixo representa os movimentos da girafa.
```
[0][1][0]
[1][0][1]
[0][1][0]
```

## Logs e Replays:
No arquivo [dobutsu_shogui.pde](https://github.com/gustavokira/dobutsu-shogui/blob/master/dobutsu_shogui/dobutsu_shogui.pde) existe a possibilidade de ligar e desligar a possibilidade de salvar logs e replays.

```
 //liga replay.  
  jogo.salvarReplay();// comentar essa para desligar replays.
  //liga salvar log. 
  jogo.salvarLog();// comentar essa para desligar logs.
```

### pasta replays:
Onde ficam salvos os replays. O nome da pasta é o timestamp do começo do jogo.

### pasta logs:
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

## Testando uma estratégia:

No arquivo [dobutsu_shogui.pde](https://github.com/gustavokira/dobutsu-shogui/blob/master/dobutsu_shogui/dobutsu_shogui.pde) existe uma função chamada setGame que define as condições iniciais do jogo. Para mudar uma estratégia, é preciso somente instanciar a sua no lugar de uma das que estão lá.

Ex: Trocar o objeto instanciado em e1 e/ou e2 pela sua.

```
public void setGame(){
  //cria a primeira estratégia
  Estrategia e1 = new EstrategiaAleatoria();
  
  //cria a segunda estratégia
  Estrategia e2 = new EstrategiaGirafaAntesDeTudo(); //aqui está sendo usada uma estratégia diferente da aleatória.
```

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
