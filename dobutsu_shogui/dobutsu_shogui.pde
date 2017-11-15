import core.Log;

Jogo jogo;
Gui gui;
int c = 0;
int max = 5;

int jogador1Pontos = 0;
int jogador2Pontos = 0;
int empates = 0;

public void setup(){
  size(401,600);
  setGame();
}

public void draw(){
  gui.desenhar();
  
  if(jogo.continuar()){
     jogo.turno();
     delay(jogo.getVelocidade());
   }else if(c == max){
     salvarBatch();
     c++;
     //exit();
   }
   else if(c<max){
     JogadorCore ganhador = jogo.getGanhador();
     if(ganhador != null){
       int i = ganhador.getId();
       if(i == 1){
         jogador1Pontos++;
       }
       else{
         jogador2Pontos++;
       }
     }else{
       empates++;
     }
     println(c);
     c++;
     if(c<max){
       setGame();
     }
   }
}

public void setGame(){
  Estrategia e1 = null;
  Estrategia e2 = null;
    //e1 = new EstrategiaMCTS();
    e1 = new EstrategiaParaTeste();
    //e2 = new EstrategiaMatadora();
     e2 = new EstrategiaMatar();
  
  //cria o jogo com as duas estratégias
  jogo = new Jogo(e1,e2);
  //cria a classe responsável por fazer os logs.
  Log l = new LogProcessing();
  //coloca a classe no jogo
  jogo.setLog(l);
  
  //cria a classe responsável por fazer os replays.
  Replay r = new ReplayProcessing(l.getTimeStamp());
  //coloca a classe no jogo.
  jogo.setReplay(r);
  
  //liga replay.  
  //jogo.salvarReplay();// comentar essa para desligar replays.
  //liga salvar log. 
  //jogo.salvarLog();// comentar essa para desligar logs.
  
  //define a velocidade do jogo. Metodos para definir velocidade:
  //velocidadeDevagar
  //velocidadeNormal
  //velocidadeRapida
  //velocidadeMuitoRapida
  jogo.velocidadeRapida();
  
  //inicia o jogo
  jogo.iniciar();
  //coloca o jogo dentro da classe que denha a interface.
  gui = new GuiProto(jogo);
}

//metodo para salvar duelos longos
public void salvarBatch(){
  Date d = new Date(); 
  String timestamp = d.getTime()+"";
  String arquivo = "longo-prazo/"+timestamp+".txt";
   PrintWriter output = createWriter(arquivo);
    String s1 = jogo.getJogador1().getId()+","+jogo.getJogador1().getNomeEstrategia()+","+jogo.getJogador1().getNomeEquipe();
    String s2 = jogo.getJogador2().getId()+","+jogo.getJogador2().getNomeEstrategia()+","+jogo.getJogador2().getNomeEquipe();
    output.println(s1+","+jogador1Pontos);
    output.println(s2+","+jogador2Pontos);
    output.flush();  // Writes the remaining data to the file
    output.close();  // Finishes the file
}