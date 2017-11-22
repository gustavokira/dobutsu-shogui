package ai.forecasting;

import java.util.ArrayList;

import core.Estrategia;
import core.Info;
import core.Movimento;

public class EstrategiaAlphaBetaJava extends Estrategia{

	public Movimento escolherMovimento(Info info,ArrayList<Movimento>movimentos){
		Board b = Boards.infoToBoard(info);
		AlphaBeta alphabeta = new AlphaBeta(b, info.getEu().getId());
		Move move = alphabeta.run(3);
		
		for(Movimento m:movimentos){
			int mx = m.getX();
			int my = m.getY();
			int moveX = move.getDestinyX();
			int moveY = move.getDestinyY();
			String mNome = m.getPeca().getNome();
			String moveName = move.getPieceName();

			if( move.getType() == 'c' && m.getTipo().equals("colocar") && 
					mx == moveX && my == moveY && mNome.equals(moveName)
					){
				return m;
			}
			else if( move.getType() == 'm' && m.getTipo().equals("mover") && 
					mx == moveX && my == moveY && mNome.equals(moveName) &&
					m.getPeca().getX() == move.getOriginX() &&
					m.getPeca().getY() == move.getOriginY()
					){
				return m;
			}
		}

		return null;
	}
	public String getNome(){
		return "alpha";
	}

	public String getEquipe(){
		return "ash";
	}
}
