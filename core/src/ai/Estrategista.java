package ai;

import java.util.ArrayList;
import java.util.HashMap;

import core.Casa;
import core.Info;
import core.LogJava;
import core.Movimento;
import core.Peca;
import core.Replay;
import core.ReplayJava;
import core.Tabuleiro;

public class Estrategista {

	
	
	public Movimento colocarASalvo(Info info, ArrayList<Movimento> movimentos) {
		int[][] perigo = new int[3][4];
		
		ArrayList<Peca> pecasInimigo = new ArrayList<Peca>();
		ArrayList<Peca> pecasMinhas = new ArrayList<Peca>();
		for (int i = 0; i < 3; i++) {
			for (int j = 0; j < 4; j++) {
				perigo[i][j] = 0;
				Casa c = info.getTabuleiro().getCasa(i, j);
				if (c.temPeca()) {
					Peca p = c.getPeca();
					if (p.getDono().getId() != info.getEu().getId()) {
						pecasInimigo.add(p);
					}else{
						pecasMinhas.add(p);
					}
				}
			}
		}

		for (Peca p : pecasInimigo) {
			int[][] matriz = p.getMatrizDeMovimento();
			for (int i = 0; i < matriz.length; i++) {
				int x = p.getX() + matriz[i][0];
				int y = p.getY() + matriz[i][1];
				if (x > 0 && x < 3 && y > 0 && y < 4) {
					perigo[x][y] = perigo[x][y]-1;
				}
			}
		}
		
		for (Peca p : pecasMinhas) {
			int[][] matriz = p.getMatrizDeMovimento();
			for (int i = 0; i < matriz.length; i++) {
				int x = p.getX() + matriz[i][0];
				int y = p.getY() + matriz[i][1];
				if (x > 0 && x < 3 && y > 0 && y < 4) {
					perigo[x][y] = perigo[x][y]+1;
				}
			}
		}

		for (Movimento m : movimentos) {
			if (m.getTipo().equals("colocar") && perigo[m.getX()][m.getY()] > 0) {
				Peca p = m.getPeca();
				if(p.getNome().equals("gir")){
					return m;
				}
				if(p.getNome().equals("ele")){
					return m;
				}
				if(p.getNome().equals("pin")){
					return m;
				}
			}
		}
		return null;
	}

	public Movimento leaoIrParaOFim(Info info, ArrayList<Movimento> movimentos) {
		for (Movimento m : movimentos) {
			if (m.getPeca().getNome().equals("leo")) {
				if (m.getY() == 0 && m.getJogador().getId() == 2) {
					return m;
				}
				if (m.getY() == 3 && m.getJogador().getId() == 1) {
					return m;
				}
			}
		}
		return null;
	}

	public Movimento fecharLeao(Info info, ArrayList<Movimento> movimentos) {
		for (Movimento m : movimentos) {
			JogoSimulacao j = new JogoSimulacao(new EstrategiaAleatoriaSimulacao(), new EstrategiaAleatoriaSimulacao());
			j.iniciar();
			LogJava l = new LogJava();
			Replay r = new ReplayJava(l.getTimeStamp());
			j.setLog(l);
			j.setReplay(r);
			j.stringToInfo(info.getEu().getId(), Utils.infoToString(info));
			j.criarInfo();
			Info ij = j.getInfo();
			Movimento escolhido = null;
			for (Movimento mj : ij.getMovimentos()) {
				if (mj.getX() == m.getX() && mj.getY() == m.getY()
						&& mj.getPeca().getNome().equals(m.getPeca().getNome()) && mj.getTipo().equals(m.getTipo())) {
					escolhido = mj;
				}
			}

			j.turno(escolhido);
			j.criarInfo();

			Info i = j.getInfo();

			if (i.getMovimentos().size() == 0) {
				return m;
			}

		}
		return null;
	}

	public Movimento material(Info info, ArrayList<Movimento> movimentos) {
		HashMap<String, Integer> valores = new HashMap<String, Integer>();
		valores.put("leo", 0);
		valores.put("gir", 16);
		valores.put("ele", 9);
		valores.put("gal", 4);
		valores.put("pin", 1);
		ArrayList<Movimento> movimentosQueValem = new ArrayList<Movimento>();
		ArrayList<Integer> valoresDosMovimentos = new ArrayList<Integer>();
		for (int i = 0; i < movimentos.size(); i++) {
			Movimento m = movimentos.get(i);
			int destinoX = m.getX();
			int destinoY = m.getY();
			Tabuleiro t = info.getTabuleiro();
			Casa destino = t.getCasa(destinoX, destinoY);
			if (destino.temPeca()) {
				Peca noDestino = destino.getPeca();
				int valor1 = valores.get(m.getPeca().getNome());
				int valor2 = valores.get(noDestino.getNome());
				if (valor2 > valor1) {
					movimentosQueValem.add(m);
					valoresDosMovimentos.add(valor2 - valor1);
				}
			}
		}
		int idx = -1;
		int melhorValor = 0;
		for (int i = 0; i < valoresDosMovimentos.size(); i++) {
			if (valoresDosMovimentos.get(i) > melhorValor) {
				melhorValor = valoresDosMovimentos.get(i);
				idx = i;
			}
		}
		if (idx != -1) {
			return movimentosQueValem.get(idx);
		}
		return null;
	}

	public Movimento matar(Info info, ArrayList<Movimento> movimentos) {
		HashMap<String, Integer> valores = new HashMap<String, Integer>();
		valores.put("leo", 0);
		valores.put("gal", 4);
		valores.put("gir", 3);
		valores.put("ele", 2);
		valores.put("pin", 1);

		for (int i = 0; i < movimentos.size(); i++) {
			Movimento m = movimentos.get(i);

			String nome = m.getPeca().getNome();

			if (nome == "pin") {

				int destinoX = m.getX();
				int destinoY = m.getY();
				Tabuleiro t = info.getTabuleiro();
				Casa destino = t.getCasa(destinoX, destinoY);

				if (destino.temPeca()) {
					return m;
				}
			} else if (nome == "ele") {

				int destinoX = m.getX();
				int destinoY = m.getY();
				Tabuleiro t = info.getTabuleiro();
				Casa destino = t.getCasa(destinoX, destinoY);

				if (destino.temPeca()) {
					return m;
				}
			} else if (nome == "gir") {

				int destinoX = m.getX();
				int destinoY = m.getY();
				Tabuleiro t = info.getTabuleiro();
				Casa destino = t.getCasa(destinoX, destinoY);

				if (destino.temPeca()) {
					return m;
				}
			} else if (nome == "gal") {

				int destinoX = m.getX();
				int destinoY = m.getY();
				Tabuleiro t = info.getTabuleiro();
				Casa destino = t.getCasa(destinoX, destinoY);

				if (destino.temPeca()) {
					return m;
				}
			} else if (nome == "leo") {

				int destinoX = m.getX();
				int destinoY = m.getY();
				Tabuleiro t = info.getTabuleiro();
				Casa destino = t.getCasa(destinoX, destinoY);

				if (destino.temPeca()) {
					return m;
				}
			}
		}
		return null;
	}
}
