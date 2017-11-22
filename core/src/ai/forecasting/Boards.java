package ai.forecasting;

import core.Info;
import core.Peca;

public class Boards {

	public static Board infoToBoard(Info info){
		Board b = new Board();
		for(int i =0;i<3;i++){
			for(int j=0;j<4;j++){
				Peca p = info.getTabuleiro().getCasa(i, j).getPeca();
				
				if(p != null){
					Piece np = new Piece();
					np.setName(p.getNome());
					np.setOwnerId(p.getDono().getId());
					b.getSquare(i,j).setPiece(np);
				}
			}
		}
		for(Peca p :info.getEu().getPecasNaMao()){
			Piece np = new Piece();
			np.setName(p.getNome());
			np.setOwnerId(p.getDono().getId());
			b.getPlayerById(info.getEu().getId()).addPiece(np);
		}
		for(Peca p :info.getOponente().getPecasNaMao()){
			Piece np = new Piece();
			np.setName(p.getNome());
			np.setOwnerId(p.getDono().getId());
			b.getPlayerById(info.getOponente().getId()).addPiece(np);
		}
		return b;
	}
	public static Board init(){
		Board b = new Board();
		
		Piece p = new Piece();
		p.setName("gir");
		p.setOwnerId(1);
		b.getSquare(0, 0).setPiece(p);
		
		Piece p2 = new Piece();
		p2.setName("leo");
		p2.setOwnerId(1);
		b.getSquare(1, 0).setPiece(p2);
		
		Piece p3 = new Piece();
		p3.setName("ele");
		p3.setOwnerId(1);
		b.getSquare(2, 0).setPiece(p3);
		
		Piece p4 = new Piece();
		p4.setName("pin");
		p4.setOwnerId(1);
		b.getSquare(1, 1).setPiece(p4);
		
		Piece p5 = new Piece();
		p5.setName("pin");
		p5.setOwnerId(2);
		b.getSquare(1, 2).setPiece(p5);
		
		Piece p6 = new Piece();
		p6.setName("ele");
		p6.setOwnerId(2);
		b.getSquare(0, 3).setPiece(p6);
		
		Piece p7 = new Piece();
		p7.setName("leo");
		p7.setOwnerId(2);
		b.getSquare(1, 3).setPiece(p7);
		
		Piece p8 = new Piece();
		p8.setName("gir");
		p8.setOwnerId(2);
		b.getSquare(2, 3).setPiece(p8);
		return b;
	}
}
