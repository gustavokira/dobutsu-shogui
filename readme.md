Dobutsu Shogui

Peças:
Leão
Elefante
Girafa
Pintinho
Galo

Classes

Estrategia
A classe Estrategia é uma classe abstrata e tem somente um método chamado "escolherMovimento" que recebe dois argumentos: o estado atual do jogo e uma lista de movimentos possíveis.

	public Movimento escolherMovimento(Info info,ArrayList<Movimento>movimentos);

Toda estratégia deve ser uma classe derivada da classe Estrategia e reimplementar o método escolherMovimento.
Toda estratégia deve ter um nome.
Toda estratégia deve ter uma equipe responsável.

Modalidades:
1) info2 contra info2
Participação nesta liga é obrigatória, salvo indicado pelo professor.

2) info2 contra bots
Participação desta liga não é obrigatória.
Caso um dos bots dos parcicipantes ganhe de todos os bots inimigos.

Regras:
1) Toda versão de estratégia que vencer cada etapa deverá ser disponibilizada para todos os outros estudantes.
2) Recomenda-se o versionamento das estratégias.
3) Recomenda-se buscar ideias para estratégias com outras pessoas pessoas além do professor da disciplina.
4) Recomenda-se que as equipes troquem informações sobre as estratégias a fim de vencer o verdadeiro inimigo.

1) Uma estratégia deve retornar o movimento escolhido a cada turno. Cada resposta deve ser dada em menos de 4000ms. Se não responder neste tempo, o jogo encerra e a vitória é dada ao oponente.

2) O uso de qualquer estratégia que explore algum tipo de "bug" será desqualificada. 

Notas:
As notas poderão ser diferentes para cada itegrante da equipe.
Serão usadas para compor a nota final:
1) O processo de desenvolvimento da ou das estratégias.
2) O processo de implementação da ou das estratégias.
3) Apresentação da estratégia ou das estratégias pela equipe.
4) Caso a equipe encontre um bug e tenha uma sugestão de como corrigí-lo, poderá ganhar nota extra por isso.

obs:
1) Estratégias muito semelhantes de equipes diferentes poderão ser submetidas a uma análise mais profunda e as equipes serão arguidas. Caso as respostas não sejam satisfatórias, a equipe podera perder a nota; Este tipo de caso será tratado como um caso equivalente a um  trabalho copiado.
2) O código entregue deve ser legível, caso seja cifrado de alguma maneira, poderá não ser aceito.
3) Qualquer regra pode ser mudada de acordo com o andamento do exercício.
4) Casos não comtemplados neste documento será decididos com uma consulta aos participantes. Entretanto, a decisão final caberá ao professor.
