Jogo jogo;
Gui gui;
public void setup(){
  size(401,600);
  //torneio();
  
  Estrategia e1 = new EstrategiaComMemoriaPropria();
  Estrategia e2 = new EstrategiaAleatoria();
  //Estrategia e2 = new EstrategiaComMemoriaPropria();
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

public void draw(){
  gui.desenhar();
  
  if(jogo.continuar()){
    println(jogo.getTurno());
     jogo.turno();
     delay(jogo.getVelocidade());
   }
}

//public void torneio(){
//  Torneio torneio;
//  Estrategia e1 = new EstrategiaComMemoriaPropria();
//  Estrategia e2 = new EstrategiaComMemoriaPropria();
//  //Estrategia e3 = new EstrategiaAleatoria();
//  torneio = new Torneio(5);
//  torneio.adicionarEstrategia(e1);
//  torneio.adicionarEstrategia(e2);
//  //torneio.adicionarEstrategia(e3);
//  torneio.rodar();
//  exit();
//}