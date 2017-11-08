import java.util.ArrayList;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.ResultSet;

import ai.memoria.DatabaseMemoria;
import ai.memoria.Estado;

//lembra dos próprios jogos que ganhou.
class EstrategiaComMemoria extends EstrategiaAleatoria{
 
  int random = 0;
  int visitado = 0;
  int meuId;
  int turno;
  DatabaseMemoria db;   
  int maxVisitas = 2273;//valor preconfigurado. SELECT max(visitado) FROM movimento_em_estado;
  public EstrategiaComMemoria(){
    super();
    turno = 0;
    db = new DatabaseMemoria("dobutsu-aleatorio", "root", "");
    try{
      db.abrirConexao();
    }catch(Exception e){
      println(e);
    }
    
  }
  
  public String infoToString(Info info){
      String saida = "";
    
    for(int i = 0;i<info.getTabuleiro().getLargura();i++){
        for(int j = 0;j<info.getTabuleiro().getAltura();j++){
          String peca = "---";
          int direcao = 0;
          if(info.getTabuleiro().getCasa(i, j).temPeca()){
            peca = info.getTabuleiro().getCasa(i, j).getPeca().getNome();
            
            int donoId = info.getTabuleiro().getCasa(i, j).getPeca().getDono().getId();
            direcao = 1;
            if(donoId == 2){
              direcao = -1;
            }
          }
          
          String c = i+","+j+","+peca+","+direcao;
          c+=":";
          
          saida+=c;
        }
      }
    saida = saida.substring(0,saida.length()-1);
    saida+=";";
    
    int[] maoJ1 = new int[3];
    int[] maoJ2 = new int[3];
    Jogador jogador1 = info.getEu();
    Jogador jogador2 = info.getOponente();
    if(info.getEu().getId() == 2){
      jogador2 = info.getEu();
      jogador1 = info.getOponente();
    }
      ArrayList<Peca> pecasNaMaoJ1 = jogador1.getPecasNaMao();
      ArrayList<Peca> pecasNaMaoJ2 = jogador2.getPecasNaMao();
      
      for(Peca p:pecasNaMaoJ1){
        if(p.getNome().equals("pin")){
          maoJ1[0]++;
        }
        if(p.getNome().equals("ele")){
          maoJ1[1]++;
        }
        if(p.getNome().equals("gir")){
          maoJ1[2]++;
        }
    }
      for(int m:maoJ1){
        saida+= m+",";
      }
      saida = saida.substring(0, saida.length()-1);
      saida +=":";
      for(Peca p:pecasNaMaoJ2){
        if(p.getNome().equals("pin")){
          maoJ2[0]++;
        }
        if(p.getNome().equals("ele")){
          maoJ2[1]++;
        }
        if(p.getNome().equals("gir")){
          maoJ2[2]++;
        }
    }
      for(int m:maoJ2){
        saida+= m+",";
      }
      saida = saida.substring(0, saida.length()-1);
    
    return saida;
    }
  
   public String getNome(){
    return "com memoria";
  }
  
  public String getEquipe(){
    return "ash ketchum";
  }
}

class MovimentoComValor extends Movimento{
  
  private Movimento original;
  private double valor;
  
  public MovimentoComValor(Movimento m,double valor){
    super(m.getPeca(),m.getX(),m.getY(),m.getTipo(),m.getJogador());
    this.valor = valor;
    this.original = m;
  }
  public double getValor(){
    return this.valor;
  }
  public Movimento getMovimentoOriginal(){
    return this.original;
  }
  public String toString(){
    return this.valor+"";
  }
}