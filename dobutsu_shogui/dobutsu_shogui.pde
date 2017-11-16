import core.Log;
import java.util.*;

Jogo jogo;
Gui gui;

Duelo duelo = new Duelo();
    
public void setup(){
  size(401,600);

  //quantidade de jogos
  duelo.quantidade = 3;
 
  setGame();
}

public void draw(){
  gui.desenhar();
  
  if(jogo.continuar()){
     jogo.turno();
     delay(jogo.getVelocidade());
   }else if(duelo.turno == duelo.quantidade){
     duelo.salvarBatch();
     duelo.terminouUmJogo();
   }
   else if(duelo.turno<duelo.quantidade){
     JogadorCore ganhador = jogo.getGanhador();
     if(ganhador != null){
       int ganhadorId = ganhador.getId();
       
       if(ganhadorId == 1){ duelo.jogador1Ganhou(); }
       else{ duelo.jogador2Ganhou(); }
       
       println((duelo.turno+1)+" ganhador:"+ganhador.getId());
     }else{
       duelo.empatou();
       println((duelo.turno+1)+" empate");
     }
     
     duelo.terminouUmJogo();
     
     if(duelo.turno<duelo.quantidade){
       setGame();
     }
   }
}

public void setGame(){
  
  Estrategia e1 = new EstrategiaParaTeste();
  Estrategia e2 = new EstrategiaMatar();

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
  
  //jogo.inverter(); // descomentar para o jogo voltar ao que era antes (dois elefantes no mesmo lado).
  
  //liga replay.  
  //jogo.salvarReplay();// comentar essa para desligar replays.
  //liga salvar log. 
  //jogo.salvarLog();// comentar essa para desligar logs.
  
  //define a velocidade do jogo. Metodos para definir velocidade:
  //jogo.velocidadeDevagar();
  //jogo.velocidadeNormal();
  //jogo.velocidadeRapida();
  //jogo.velocidadeMuitoRapida();
  jogo.velocidadeMaxima();
  
  //inicia o jogo
  jogo.iniciar();
  //coloca o jogo dentro da classe que denha a interface.
  gui = new GuiProto(jogo);
}

//classes auxiliares
class LogProcessing extends Log{
    private PrintWriter output;

  public void salvar(){
    String arquivo = this.timestamp+".log";
    this.output = createWriter(this.pasta+"/"+arquivo); 
    this.output.println(this.meta);
    this.output.println(this.header);
    for(String e:entradas){
      this.output.println(e);
    }
    this.output.flush();  // Writes the remaining data to the file
    this.output.close();  // Finishes the file
   }
}

class ReplayProcessing extends Replay{

   public ReplayProcessing(String timestamp){
     super(timestamp);
   }
  
   public void salvarSeEstiverLigado(){
     if(this.ligado){
       saveFrame(this.pasta+this.padrao);
     }
   }
}

class Duelo{
  int quantidade;
  int turno;
  int jogador1Pontos;
  int jogador2Pontos;
  int empates;
  
  public Duelo(){
    this.turno = 0;
    this.empates = 0;
    this.jogador1Pontos = 0;
    this.jogador2Pontos = 0;
  }
  public void empatou(){
    this.empates++;
  }
  public void jogador1Ganhou(){
    this.jogador1Pontos++;
  }
  public void jogador2Ganhou(){
    this.jogador2Pontos++;
  }
  
  public void terminouUmJogo(){
    this.turno++;
  }
  
  public void salvarBatch(){
    Date d = new Date(); 
    String timestamp = d.getTime()+"";
    String arquivo = "longo-prazo/"+timestamp+".txt";
    PrintWriter output = createWriter(arquivo);
    String s1 = jogo.getJogador1().getId()+","+jogo.getJogador1().getNomeEstrategia()+","+jogo.getJogador1().getNomeEquipe();
    String s2 = jogo.getJogador2().getId()+","+jogo.getJogador2().getNomeEstrategia()+","+jogo.getJogador2().getNomeEquipe();
    output.println(s1+","+duelo.jogador1Pontos);
    output.println(s2+","+duelo.jogador2Pontos);
    output.flush();  // Writes the remaining data to the file
    output.close();  // Finishes the file
  }
}