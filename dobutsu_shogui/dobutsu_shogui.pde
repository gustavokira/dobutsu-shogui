Jogo jogo;
Gui gui;
int c = 0;
int max = 100;

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
   }else if(c<max){
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
     setGame();
     println(c);
     c++;
   }else if(c == max){
     salvarBatch();
     c++;
     //exit();
   }
}

public void setGame(){
  Estrategia e1 = new EstrategiaAleatoria();
  //Estrategia e2 = new EstrategiaAleatoria();
  Estrategia e2 = new EstrategiaGirafaAntesDeTudo();
  jogo = new Jogo(e1,e2);
  jogo.setLog(new LogProcessing());
  Log l = new LogProcessing();
  Replay r = new ReplayProcessing(l.getTimeStamp());
  jogo.setReplay(r);
  
  //jogo.salvarReplay();
  jogo.salvarLog();
  
  jogo.velocidadeMuitoRapida();
  
  jogo.iniciar();
  gui = new GuiProto(jogo);
}

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