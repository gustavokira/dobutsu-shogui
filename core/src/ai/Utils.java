package ai;

import java.util.ArrayList;

import core.Casa;
import core.Info;
import core.Jogador;
import core.Movimento;
import core.Peca;
import core.Tabuleiro;

public class Utils {
	
	public static Movimento acharMovimento(Movimento movimento, ArrayList<Movimento> movimentos){
		for(Movimento m:movimentos){
			if(compararMovimentos(m,movimento)){
				return m;
			}
		}
		return null;
	}
	
	public static boolean compararMovimentos(Movimento m1, Movimento m2){
		if( m1.getJogador().getId() == m2.getJogador().getId() &&
				m1.getPeca().getX() == m2.getPeca().getX() &&
				m1.getPeca().getY() == m2.getPeca().getY() &&
				m1.getPeca().getNome().equals(m2.getPeca().getNome()) &&
				m1.getTipo().equals(m2.getTipo()) &&
				m1.getX() == m2.getX() &&
				m1.getY() == m2.getY()
			){
				return true;
			}
		else{
			return false;
		}
	}

	public static String infoToString(Info info){
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
	
	public static boolean temLeaoAoFim(Info info){
		Tabuleiro t = info.getTabuleiro();
		for(int i = 0;i<3;i++){
			Casa c = t.getCasa(i, 0);
			if(
				c.temPeca() && 
				c.getPeca().getNome().equals("leo") &&
				c.getPeca().getDono().getId() == 2
			){
				return true;
			}
		}
		for(int i = 0;i<3;i++){
			Casa c = t.getCasa(i, 3);
			if(
				c.temPeca() && 
				c.getPeca().getNome().equals("leo") &&
				c.getPeca().getDono().getId() == 1
			){
				return true;
			}
		}
		
		
		return false;
	}
	
	public static Peca pegarLeaoPorId(Info info, int jogadorId){
		Tabuleiro t = info.getTabuleiro();
		for(Peca p : t.getPecas()){
			if(p.getNome().equals("leo") && p.getDono().getId() == jogadorId){
				return p;
			}
		}
		return null;
	}
	
	public static ArrayList<Peca> atacantesDeUmaPeca(Info info, Peca peca) {
		ArrayList<Peca> atacantes = new ArrayList<Peca>();
		
		for (Peca p : info.getTabuleiro().getPecas()) {
			if(peca.getDono().getId() != p.getDono().getId()){
				int[][] matriz = p.getMatrizDeMovimento();
				for (int i = 0; i < matriz.length; i++) {
					int x = p.getX() + matriz[i][0];
					int y = p.getY() + matriz[i][1];
	
					if (x == peca.getX() && y == peca.getY()) {
						atacantes.add(p);
					}
				}
			}
		}
		return atacantes;
	}

	public static boolean[][] criarMatrizDeAtaque(Info info, ArrayList<Peca> pecas) {
		
		boolean[][] matrizDeAtaque = new boolean[3][4];
		for (Peca p : pecas) {
			int[][] matriz = p.getMatrizDeMovimento();
			for (int i = 0; i < matriz.length; i++) {
				int x = p.getX() + matriz[i][0];
				int y = p.getY() + matriz[i][1];

				if (!(x < 0 || x > 3 - 1 || y < 0 || y > 4 - 1)) {
					matrizDeAtaque[x][y] = true;
				}
			}
		}
		return matrizDeAtaque;
	}

	public static ArrayList<Movimento> criarMovimentosPossiveis(Info info, Peca p){
		ArrayList<Movimento> movimentos = new ArrayList<Movimento>();
		int[][] matriz = p.getMatrizDeMovimento();
		for (int i = 0; i < matriz.length; i++) {
			int x = p.getX() + matriz[i][0];
			int y = p.getY() + matriz[i][1];
			
			if (! (x < 0 || x > 3 - 1 || y < 0 || y > 4 - 1)) {
				Casa c = info.getTabuleiro().getCasa(x, y);
				Peca destino = c.getPeca();
				
				if (destino != null && destino.getDono() != p.getDono()) {
					Movimento m = new Movimento(p, x, y, "mover", p.getDono());
					movimentos.add(m);
				}

				if (destino == null) {
					Movimento m = new Movimento(p, x, y, "mover", p.getDono());
					movimentos.add(m);
				}
			}
		}
		return movimentos;
	}
}
