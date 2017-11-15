import java.util.ArrayList;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.ResultSet;

import ai.memoria.DatabaseMemoria;
import ai.memoria.Estado;

//lembra dos próprios jogos que ganhou.
class EstrategiaProbabilistica extends EstrategiaComMemoria{
 
  int random = 0;
  int visitado = 0;
  int meuId;
  int turno;
  DatabaseMemoria db;   
  int maxVisitas = 2273;//valor preconfigurado. SELECT max(visitado) FROM movimento_em_estado;
  public EstrategiaProbabilistica(){
    super();
    turno = 0;
    db = new DatabaseMemoria("dobutsu-aleatorio", "root", "");
    try{
      db.abrirConexao();
    }catch(Exception e){
      println(e);
    }
    
  }
  
  public Movimento escolherMovimento(Info info,ArrayList<Movimento>movimentos){
    this.meuId = info.getEu().getId();
    
    String idEstado = infoToString(info);
    ArrayList<Estado>estados = null;
    
    try{
      estados = db.getMovimentosPorEstado(idEstado,this.meuId);
    }catch(Exception e){
      println(e);
    }
    
    ArrayList<MovimentoComValor> movimentosComValorPositivo = new ArrayList<MovimentoComValor>();
    ArrayList<MovimentoComValor> movimentosComValorNegativo = new ArrayList<MovimentoComValor>();
    ArrayList<Movimento> nuncaVistosAntes = new ArrayList<Movimento>();
    
    if(estados != null){
      
      for(Movimento m:movimentos){
        Estado escolhido = null;
        
        for(Estado e:estados){
          
          if(
            m.getX() == e.x &&
            m.getY() == e.y &&
            m.getTipo().equals(e.origem) &&
            m.getPeca().getNome().equals(e.peca)
          ){
            escolhido = e;
            break;
          }
        }
        
        if(escolhido != null){
          int visitado = escolhido.visitado;
          double ep = 100*(double)visitado/maxVisitas;
          double ganhou = ((double)escolhido.ganhou/visitado)*ep;
          double perdeu = ((double)escolhido.perdeu/visitado)*ep;
          double v = ganhou-perdeu;
          if(v >= 0){
            MovimentoComValor mv = new MovimentoComValor(m,v);
            movimentosComValorPositivo.add(mv);
          }else{
            MovimentoComValor mv = new MovimentoComValor(m,v);
            movimentosComValorNegativo.add(mv);
          }
        }else{
          nuncaVistosAntes.add(m);
        }
      }
    }
    
    this.turno++;
    
    Movimento escolhido = null;
    
    
    
    if(movimentosComValorPositivo.size()>0){
      Collections.sort(movimentosComValorPositivo,new Comparator<MovimentoComValor>(){
        @Override  
        public int compare(MovimentoComValor o1, MovimentoComValor o2) {
          if(o1.getValor() > o2.getValor()){
            return -1;
          }else{
            return 1;
          }
        }
      });
      escolhido = movimentosComValorPositivo.get(0).getMovimentoOriginal();
    }
    else if(nuncaVistosAntes.size()>0){
      Random r = new Random();
      int i = r.nextInt(nuncaVistosAntes.size());
      random++;
      escolhido = nuncaVistosAntes.get(i);
    }
    else if(movimentosComValorNegativo.size()>0){
      Collections.sort(movimentosComValorNegativo,new Comparator<MovimentoComValor>(){
        @Override  
        public int compare(MovimentoComValor o1, MovimentoComValor o2) {
          if(o1.getValor() > o2.getValor()){
            return -1;
          }else{
            return 1;
          }
        }
      });
      escolhido = movimentosComValorNegativo.get(movimentosComValorNegativo.size()-1).getMovimentoOriginal();
    }
    return escolhido;
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
    return "prob";
  }
  
  public String getEquipe(){
    return "ash ketchum";
  }
}