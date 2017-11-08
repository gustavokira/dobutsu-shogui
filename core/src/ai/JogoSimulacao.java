package ai;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

import core.CasaCore;
import core.Estrategia;
import core.Galo;
import core.Info;
import core.JogadorCore;
import core.Jogo;
import core.Movimento;
import core.Peca;
import core.PecaCore;
import core.Pintinho;
import core.Tabuleiro;
import core.TabuleiroCore;

public class JogoSimulacao extends Jogo{
	
	public JogoSimulacao(Estrategia e1, Estrategia e2) {
		super(e1, e2);
	}
	
	public void moverPecaParaMao(PecaCore p, JogadorCore j){
	    super.moverPecaParaMao(p, j);
	}
	
	public void moverPecaNoTabuleiro(PecaCore p, int x,int y){
		 super.moverPecaNoTabuleiro(p, x, y);
	}
	
	public void colocarPecaNoTabuleiro(PecaCore p, int x,int y){
		  super.colocarPecaNoTabuleiro(p, x, y);
	}
	
	public void criarInfo(){
	    super.criarInfo();
	  }
	
	public void transformarEmGalo(PecaCore p){
		super.transformarEmGalo(p);
	}
	
	public void setTurno(int t){
		super.turno = t;
	}
	public int getTurno(){
		return super.turno;
	}
	public Info getInfo(){
		return super.info;
	}
	public JogadorCore getOutroJogador(JogadorCore j){
		return super.getOutroJogador(j);
	}
		
	public void stringToInfo(int jogador, String s){
		
		if(this.getJogadorAtivo().getId() != jogador){
			this.trocarJogadorAtivo();
		}
		
		ArrayList<PecaCore> pecas = new ArrayList<PecaCore>();
	    pecas.addAll(this.jogador1.getPecasNaMao());
	    pecas.addAll(this.jogador2.getPecasNaMao());
	    pecas.addAll(this.tabuleiro.getPecas());
	    
	    this.jogador1.getPecasNaMao().clear();
	    this.jogador2.getPecasNaMao().clear();
	    
	    for(int i = 0;i<this.tabuleiro.getLargura();i++){
	    	for(int j = 0;j<this.tabuleiro.getAltura();j++){
	    		this.tabuleiro.getCasa(i, j).removerPeca();
	    	}
	    }
	    
		String[] linhas = s.split(";");
		String[] casas = linhas[0].split(":");
		String[] maos = linhas[1].split(":");
		
		String[] j1 = maos[0].split(",");
		String[] j2 = maos[1].split(",");
		
		int pinQty1 = Integer.parseInt(j1[0]);
		for(int i =0;i<pinQty1;i++){
			PecaCore pc = null;
			for(PecaCore p: pecas){
				if(p.getNome().equals("pin")){
	    			pc = pecas.remove(pecas.indexOf(p));
	    			break;
	    		}
			}
			this.jogador1.colocarPeca(pc);
		    pc.setDono(this.jogador1);
		    if(pc.getDirecao() == -1){
		    	pc.mudarDirecao();
		    }
		    this.jogador1.colocarPecaNaMao(pc);
		}
		int eleQty1 = Integer.parseInt(j1[1]);
		for(int i =0;i<eleQty1;i++){
			PecaCore pc = null;
			for(PecaCore p: pecas){
				if(p.getNome().equals("ele")){
	    			pc = pecas.remove(pecas.indexOf(p));
	    			break;
	    		}
			}
			this.jogador1.colocarPeca(pc);
		    pc.setDono(this.jogador1);
		    if(pc.getDirecao() == -1){
		    	pc.mudarDirecao();
		    }
		    this.jogador1.colocarPecaNaMao(pc);
		}
		int girQty1 = Integer.parseInt(j1[2]);
		for(int i =0;i<girQty1;i++){
			PecaCore pc = null;
			for(PecaCore p: pecas){
				if(p.getNome().equals("gir")){
	    			pc = pecas.remove(pecas.indexOf(p));
	    			break;
	    		}
			}
			this.jogador1.colocarPeca(pc);
		    pc.setDono(this.jogador1);
		    if(pc.getDirecao() == -1){
		    	pc.mudarDirecao();
		    }
		    this.jogador1.colocarPecaNaMao(pc);
		}
		
		int pinQty2 = Integer.parseInt(j2[0]);
		for(int i =0;i<pinQty2;i++){
			PecaCore pc = null;
			for(PecaCore p: pecas){
				if(p.getNome().equals("pin")){
	    			pc = pecas.remove(pecas.indexOf(p));
	    			break;
	    		}
			}
			this.jogador2.colocarPeca(pc);
		    pc.setDono(this.jogador2);
		    if(pc.getDirecao() == 1){
		    	pc.mudarDirecao();
		    }
		    this.jogador2.colocarPecaNaMao(pc);
		}
		int eleQty2 = Integer.parseInt(j2[1]);
		for(int i =0;i<eleQty2;i++){
			PecaCore pc = null;
			for(PecaCore p: pecas){
				if(p.getNome().equals("ele")){
	    			pc = pecas.remove(pecas.indexOf(p));
	    			break;
	    		}
			}
			this.jogador2.colocarPeca(pc);
		    pc.setDono(this.jogador2);
		    if(pc.getDirecao() == 1){
		    	pc.mudarDirecao();
		    }
		    this.jogador2.colocarPecaNaMao(pc);
		}
		int girQty2 = Integer.parseInt(j2[2]);
		for(int i =0;i<girQty2;i++){
			PecaCore pc = null;
			for(PecaCore p: pecas){
				if(p.getNome().equals("gir")){
	    			pc = pecas.remove(pecas.indexOf(p));
	    			break;
	    		}
			}
			this.jogador2.colocarPeca(pc);
		    pc.setDono(this.jogador2);
		    if(pc.getDirecao() == 1){
		    	pc.mudarDirecao();
		    }
		    this.jogador2.colocarPecaNaMao(pc);
		}
		
		
		
		for(String casa:casas){
			String[] itens = casa.split(",");
			int x = Integer.parseInt(itens[0]);
			int y = Integer.parseInt(itens[1]);
			String nome = itens[2];
			int direcao = Integer.parseInt(itens[3]);
			PecaCore pc = null;
			boolean transformar = false;
			for(PecaCore p: pecas){
				if(p.getNome().equals(nome)){
	    			pc = pecas.remove(pecas.indexOf(p));
	    			break;
	    		}
				if(nome.equals("gal") && p.getNome().equals("pin")){
	    			pc = pecas.remove(pecas.indexOf(p));
	    			transformar = true;
	    			break;
	    		}
			}
			if(pc != null){
				pc.setX(x);
				pc.setY(y);
				if(pc.getDirecao() != direcao){
					pc.mudarDirecao();
				}
				if(pc.getDirecao() == PecaCore.CIMA){
					pc.setDono(this.getJogador2());
				}else{
					pc.setDono(this.getJogador1());
				}
				if(transformar){
					pc = ((Pintinho)pc).transformar();
				}
				this.tabuleiro.getCasa(x, y).colocarPeca(pc);
			}
		}
	}

	public String inverterId(String id){
		String[] linhas = id.split(";");
		String[] casas = linhas[0].split(":");
		String[] maos = linhas[1].split(":");
		
		String invertido = "";
		
		for(String c:casas){
			String[] itens = c.split(",");
			String s = "";
			
			int x = Integer.parseInt(itens[0]);
			int dx = 1-x;
			x = x+(2*dx);
			s+=x+",";
			
			int y = Integer.parseInt(itens[1]);
			int dy = 2-y;
			y = y+(2*dy)-1;
			s+=y+",";
			
			
			s+=itens[2]+",";
			
			if(itens[3].equals("1")){
				s+="-1";
			}else if(itens[3].equals("-1")){
				s+="1";
			}else{
				s+="0";
			}
			invertido+= s+":";
		}
		
		invertido = invertido.substring(0, invertido.length()-1)+";";
		invertido=  invertido+maos[1]+":"+maos[0];
		
		
		return invertido;
	}
		
	public String infoToString(){
		String saida = "";
		
		for(int i = 0;i<this.tabuleiro.getLargura();i++){
	    	for(int j = 0;j<this.tabuleiro.getAltura();j++){
	    		String peca = "---";
	    		int direcao = 0;
	    		if(this.tabuleiro.getCasa(i, j).temPeca()){
	    			peca = this.tabuleiro.getCasa(i, j).getPeca().getNome();
	    			direcao = this.tabuleiro.getCasa(i, j).getPeca().getDirecao();
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
	    ArrayList<PecaCore> pecasNaMaoJ1 = this.getJogador1().getPecasNaMao();
	    ArrayList<PecaCore> pecasNaMaoJ2 = this.getJogador2().getPecasNaMao();
	    
	    for(PecaCore p:pecasNaMaoJ1){
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
	    for(PecaCore p:pecasNaMaoJ2){
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

	public int getEstado() {
		return this.estado;
	}
	
	public void setEstado(int estado) {
		this.estado = estado;
	}
	
	public JogadorCore getJogadorAtivo(){
		return this.jogadorAtivo;
	}
	public void trocarJogadorAtivo(){
		super.trocarJogadorAtivo();
	}
	
	public boolean turno(Movimento m){
		  if(this.turno == this.maxTurnos){
			  this.irParafim();
		      return false;
		  }
		  
	    //se existem movimentos disponíveis, o jogo não acabou
	    if(this.info.getMovimentos().size()>0){
	      
	      int px = m.getX();
	      int py = m.getY();
	      PecaCore p = acharPecaNoCore(m.getPeca());
	      
	      if(m.getTipo().equals("mover")){
	        CasaCore c = this.tabuleiro.getCasa(px,py);
	        if(c.temPeca()){
	          PecaCore alvo = c.getPeca();
	          this.moverPecaParaMao(alvo, this.jogadorAtivo);
	        }
	        this.moverPecaNoTabuleiro(p,px,py);
	        
	        if(p.getClass() == Pintinho.class){
	          this.transformarEmGalo(p);
	        }
	      }
	      else if(m.getTipo().equals("colocar")){
	        this.colocarPecaNoTabuleiro(p,px,py);
	      }
	      this.log.adicionar(this.turno, m,this.jogadorAtivo);
	      this.replay.salvarSeEstiverLigado();
	    //se não existem movimentos disponíveis, o jogo acabou  
	    }else{
	      this.ganhador = this.getOutroJogador(this.jogadorAtivo);
	      this.irParafim();
	      return false;
	    }
	    
	    
	    JogadorCore ganhador = this.verificarLeoesNosFins();
	    if(ganhador != null){
	      this.ganhador = ganhador;
	      this.irParafim();
	      return false;
	    }
	    
	    this.trocarJogadorAtivo();
	    this.turno++;
	    return true;
	  }
}
