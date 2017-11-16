package ai.montecarlo;

import java.util.ArrayList;
import java.util.Random;

import ai.EstrategiaAleatoriaSimulacao;
import ai.JogoSimulacao;
import core.Estrategia;
import core.Info;
import core.Jogador;
import core.JogadorCore;
import core.LogJava;
import core.Movimento;
import core.Peca;
import core.Replay;
import core.ReplayJava;

public class SimularMonteCarlo {

	public static void main(String[] args) {
		
//		MonteCarloTreeSearch mcts = new MonteCarloTreeSearch(1,null,1000,0);
//		mcts.run();
//		mcts.getMovimento();
		
		System.out.println("Monte");
		
		for(int i =0;i<10;i++){
			JogoSimulacao jogo = new JogoSimulacao(new EstrategiaMCTS(), new EstrategiaAleatoriaSimulacao());
			
			LogJava l = new LogJava();
			Replay r = new ReplayJava(l.getTimeStamp());
			
			jogo.setLog(new LogJava());
			jogo.setReplay(r);
			jogo.iniciar();
			while(jogo.continuar()){
				jogo.turno();
			}
			JogadorCore ganhador = jogo.getGanhador();
			System.out.println(ganhador.getId());
		}	
	}
}

class EstrategiaMCTS extends Estrategia{
	 
	@Override
	  public Movimento escolherMovimento(Info info,ArrayList<Movimento>movimentos){
	   
	    String infoStr = infoToString(info);
	    int i = info.getEu().getId();

	    MonteCarloTreeSearch mcts = new MonteCarloTreeSearch(i,infoStr,20,1);
	    mcts.run();
	    Movimento melhor= mcts.getMovimento();
	    Movimento escolhido= null;
	    for(Movimento m:movimentos){
	       int x = m.getX();
	       int y = m.getY();
	       String nome= m.getPeca().getNome();
	       
	       if(melhor.getX() == x && melhor.getY() == y && nome == melhor.getPeca().getNome()){
	         escolhido = m;
	       }
	    }
	    if(escolhido == null){
	    	Random r = new Random();
	    	int ir = r.nextInt(movimentos.size());
	      return movimentos.get(ir);
	    }
	       
	    return escolhido;
	  }
	  
	  public String getNome(){
	    return "mcts";
	  }
	  
	  public String getEquipe(){
	    return "ash ketchum";
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
	
	}