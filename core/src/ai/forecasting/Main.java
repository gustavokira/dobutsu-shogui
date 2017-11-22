package ai.forecasting;

import ai.EstrategiaAleatoriaSimulacao;
import ai.EstrategiaParaTeste;
import ai.JogoSimulacao;
import core.Estrategia;
import core.JogadorCore;
import core.LogJava;
import core.Replay;
import core.ReplayJava;
import estrategias.EstrategiaWaifuJava;

public class Main {

	public static void main(String[] args){
		
		for(int i =0;i<10;i++){
			Estrategia e2 = new EstrategiaWaifuJava();
//			Estrategia e2 = new EstrategiaAleatoriaSimulacao();
//			Estrategia e2 = new EstrategiaParaTeste();
//			Estrategia e2 = new EstrategiaMinMaxJava();
			Estrategia e1 = new EstrategiaAlphaBetaJava();
			JogoSimulacao jogo = new JogoSimulacao(e1,e2);
			LogJava l = new LogJava();
			Replay r = new ReplayJava(l.getTimeStamp());
			jogo.setLog(new LogJava());
			jogo.setReplay(r);
			jogo.iniciar();
			
			while(jogo.continuar()){
				jogo.turno();
			}
			JogadorCore j = jogo.getGanhador();
			if(j != null){
				Estrategia ganhadora = j.getEstrategia();
				System.out.println(ganhadora);
			}else{
				System.out.println("--");
			}
		}
		
		
//		Board b = case5();
//		boolean bo = b.isFinal();
//		System.out.println(bo);
//		ArrayList<Move> moves = b.getMoviments(1);
//		for(Move m:moves){
//			System.out.println(m);
//		}
//		
//		boolean bo = false;
//		
//		b = regular();
//		bo = b.isFinal();
//		System.out.println(bo);
//		ArrayList<Move> moves = b.getMoviments(1);
//		for(Move m:moves){
//			System.out.println(m);
//		}
//		System.out.println("");
//		b.tick(moves.get(0));
//		moves = b.getMoviments(1);
//		for(Move m:moves){
//			System.out.println(m);
//		}
//		System.out.println("");
//		b.tick(moves.get(4));
//		moves = b.getMoviments(2);
//		for(Move m:moves){
//			System.out.println(m);
//		}
//		
//		
//		
//		b = case1();
//		bo = b.isFinal();
//		System.out.println(bo);
//		
//		b = case2();
//		bo = b.isFinal();
//		System.out.println(bo);
//		
//		b = case3();
//		bo = b.isFinal();
//		System.out.println(bo);
//		
//		
//		b = case4();
//		bo = b.isFinal();
//		System.out.println(bo);
	}
	
	public static Board case1(){
		Board b = new Board();
		Piece p = new Piece();
		p.setName("leo");
		p.setOwnerId(1);
		b.getSquare(1, 1).setPiece(p);
		
		Piece p2 = new Piece();
		p2.setName("leo");
		p2.setOwnerId(2);
		b.getSquare(1, 3).setPiece(p2);
		
		Piece p3 = new Piece();
		p3.setName("ele");
		p3.setOwnerId(1);
		b.getSquare(1, 2).setPiece(p3);
		
		return b;
	}
	
	public static Board case2(){
		Board b = new Board();
		Piece p = new Piece();
		p.setName("leo");
		p.setOwnerId(1);
		b.getSquare(0, 3).setPiece(p);
		
		Piece p2 = new Piece();
		p2.setName("leo");
		p2.setOwnerId(2);
		b.getSquare(2, 1).setPiece(p2);
				
		return b;
	}
	
	public static Board case3(){
		Board b = new Board();
		Piece p = new Piece();
		p.setName("leo");
		p.setOwnerId(1);
		b.getSquare(0, 0).setPiece(p);
		
		
		Piece p2 = new Piece();
		p2.setName("leo");
		p2.setOwnerId(2);
		b.getSquare(1, 2).setPiece(p2);
		
		Piece p3 = new Piece();
		p3.setName("gir");
		p3.setOwnerId(2);
		b.getSquare(0, 1).setPiece(p3);
		
		Piece p4 = new Piece();
		p4.setName("pin");
		p4.setOwnerId(2);
		b.getSquare(1, 1).setPiece(p4);
		return b;
	}
	
	public static Board case4(){
		Board b = new Board();
		Piece p = new Piece();
		p.setName("leo");
		p.setOwnerId(1);
		b.getSquare(0, 0).setPiece(p);
		
		Piece p2 = new Piece();
		p2.setName("leo");
		p2.setOwnerId(2);
		b.getSquare(2, 3).setPiece(p2);
		
		Piece p3 = new Piece();
		p3.setName("gir");
		p3.setOwnerId(2);
		b.getSquare(0, 1).setPiece(p3);
		
		Piece p5 = new Piece();
		p5.setName("gir");
		p5.setOwnerId(2);
		b.getSquare(1, 2).setPiece(p5);
		
		Piece p4 = new Piece();
		p4.setName("pin");
		p4.setOwnerId(1);
		b.getSquare(0, 2).setPiece(p4);
		
		Piece p6 = new Piece();
		p6.setName("pin");
		p6.setOwnerId(2);
		b.getSquare(0, 2).setPiece(p6);
		

		Piece p7 = new Piece();
		p7.setName("ele");
		p7.setOwnerId(2);
		b.getSquare(2, 1).setPiece(p7);
		return b;
	}
	
	public static Board case5(){
		Board b = new Board();
		
		Piece p = new Piece();
		p.setName("leo");
		p.setOwnerId(1);
		b.getSquare(1, 0).setPiece(p);
		
		Piece p2 = new Piece();
		p2.setName("leo");
		p2.setOwnerId(2);
		b.getSquare(1, 3).setPiece(p2);
		
		Piece p3 = new Piece();
		p3.setName("gir");
		p3.setOwnerId(1);
		b.getSquare(1, 1).setPiece(p3);
		
		Piece p5 = new Piece();
		p5.setName("ele");
		p5.setOwnerId(1);
		b.getSquare(2, 0).setPiece(p5);
		
		Piece p4 = new Piece();
		p4.setName("ele");
		p4.setOwnerId(2);
		b.getSquare(1, 2).setPiece(p4);
		
		Piece p6 = new Piece();
		p6.setName("gir");
		p6.setOwnerId(2);
		b.getSquare(2, 3).setPiece(p6);
		return b;
	}
}
