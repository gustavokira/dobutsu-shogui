Jogo jogo;
Gui gui;
public void setup(){
  size(401,600);
  setGame();
}

public void draw(){
  gui.desenhar();
  
  if(jogo.continuar()){
     jogo.turno();
     delay(jogo.getVelocidade());
   }
   //else{
   //  setGame();
   //}
}

public void setGame(){
  Estrategia e1 = new EstrategiaAleatoria();
  Estrategia e2 = new EstrategiaAleatoria();
  jogo = new Jogo(e1,e2);
  jogo.setLog(new LogProcessing());
  Log l = new LogProcessing();
  Replay r = new ReplayProcessing(l.getTimeStamp());
  jogo.setReplay(r);
  jogo.salvarReplay();
  jogo.salvarLog();
  jogo.velocidadeMuitoRapida();
  
  jogo.iniciar();
  gui = new GuiProto(jogo);
}