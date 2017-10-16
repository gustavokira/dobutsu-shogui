package ai;

import core.Estrategia;
import core.Info;
import core.JogadorCore;
import core.Jogo;
import core.PecaCore;

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
	
	public void transformarEmGalo(PecaCore p){
		
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
}
