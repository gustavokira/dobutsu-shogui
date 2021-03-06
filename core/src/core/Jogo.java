package core;

import java.util.ArrayList;

public class Jogo {

	public static int PRE = 0;
	public static int JOGANDO = 1;
	public static int FIM = 2;

	protected FabricaPecaCore fabricaPeca;
	protected Log log;
	protected Replay replay;
	protected int velocidade;

	protected TabuleiroCore tabuleiro;
	protected JogadorCore jogador1;
	protected JogadorCore jogador2;
	protected JogadorCore jogadorAtivo;
	protected JogadorCore ganhador;
	protected int turno;
	protected Info info;

	protected int estado;
	protected int maxTurnos;
	protected boolean invertido = false;

	public Jogo(Estrategia e1, Estrategia e2) {

		this.fabricaPeca = new FabricaPecaCore();

		this.tabuleiro = new TabuleiroCore();
		this.turno = 0;
		this.maxTurnos = 500;

		this.velocidadeNormal();
		this.estado = PRE;
		
		this.jogador1 = new JogadorCore(e1, 1);
		this.jogador2 = new JogadorCore(e2, 2);
		this.jogadorAtivo = jogador1;
		
	}
	
	public Jogo(){
		this.fabricaPeca = new FabricaPecaCore();
		this.tabuleiro = new TabuleiroCore();
		this.turno = 0;
		this.maxTurnos = 500;

		this.velocidadeNormal();
		this.estado = PRE;
	}
	public void setComputador(Estrategia e, int i){
		switch (i) {
			case 1: this.jogador1 = new JogadorCore(e, 1); break;
			case 2: this.jogador2 = new JogadorCore(e, 2); break;
			default: break;
		}
	}
	
	public void inverter(){
		this.invertido = !this.invertido;
	}

	public void adicinarPecasInvertido(){
		PecaCore g = fabricaPeca.criarGirafaParaBaixo();
		this.jogador1.colocarPeca(g);
		g.setDono(this.jogador1);
		this.tabuleiro.addPeca(g, 0, 0);

		PecaCore l = fabricaPeca.criarLeaoParaBaixo();
		this.jogador1.colocarPeca(l);
		l.setDono(this.jogador1);
		this.tabuleiro.addPeca(l, 1, 0);

		PecaCore e = fabricaPeca.criarElefanteParaBaixo();
		this.jogador1.colocarPeca(e);
		e.setDono(this.jogador1);
		this.tabuleiro.addPeca(e, 2, 0);

		PecaCore p = fabricaPeca.criarPintinhoParaBaixo();
		this.jogador1.colocarPeca(p);
		p.setDono(this.jogador1);
		this.tabuleiro.addPeca(p, 1, 1);
		
		PecaCore g2 = fabricaPeca.criarGirafaParaCima();
		this.jogador2.colocarPeca(g2);
		g2.setDono(this.jogador2);
		this.tabuleiro.addPeca(g2, 0, 3);

		PecaCore l2 = fabricaPeca.criarLeaoParaCima();
		this.jogador2.colocarPeca(l2);
		l2.setDono(this.jogador2);
		this.tabuleiro.addPeca(l2, 1, 3);

		PecaCore e2 = fabricaPeca.criarElefanteParaCima();
		this.jogador2.colocarPeca(e2);
		e2.setDono(this.jogador2);
		this.tabuleiro.addPeca(e2, 2, 3);

		PecaCore p2 = fabricaPeca.criarPintinhoParaCima();
		this.jogador2.colocarPeca(p2);
		p2.setDono(this.jogador2);
		this.tabuleiro.addPeca(p2, 1, 2);
	}
	
	public void adicionarPecas(){
		PecaCore g = fabricaPeca.criarGirafaParaBaixo();
		this.jogador1.colocarPeca(g);
		g.setDono(this.jogador1);
		this.tabuleiro.addPeca(g, 0, 0);

		PecaCore l = fabricaPeca.criarLeaoParaBaixo();
		this.jogador1.colocarPeca(l);
		l.setDono(this.jogador1);
		this.tabuleiro.addPeca(l, 1, 0);

		PecaCore e = fabricaPeca.criarElefanteParaBaixo();
		this.jogador1.colocarPeca(e);
		e.setDono(this.jogador1);
		this.tabuleiro.addPeca(e, 2, 0);

		PecaCore p = fabricaPeca.criarPintinhoParaBaixo();
		this.jogador1.colocarPeca(p);
		p.setDono(this.jogador1);
		this.tabuleiro.addPeca(p, 1, 1);
		
		PecaCore g2 = fabricaPeca.criarGirafaParaCima();
		this.jogador2.colocarPeca(g2);
		g2.setDono(this.jogador2);
		this.tabuleiro.addPeca(g2, 2, 3);

		PecaCore l2 = fabricaPeca.criarLeaoParaCima();
		this.jogador2.colocarPeca(l2);
		l2.setDono(this.jogador2);
		this.tabuleiro.addPeca(l2, 1, 3);

		PecaCore e2 = fabricaPeca.criarElefanteParaCima();
		this.jogador2.colocarPeca(e2);
		e2.setDono(this.jogador2);
		this.tabuleiro.addPeca(e2, 0, 3);

		PecaCore p2 = fabricaPeca.criarPintinhoParaCima();
		this.jogador2.colocarPeca(p2);
		p2.setDono(this.jogador2);
		this.tabuleiro.addPeca(p2, 1, 2);
	}
	
	public void setLog(Log log) {
		this.log = log;
	}

	public void setReplay(Replay replay) {
		this.replay = replay;
	}

	protected void criarInfo() {
		this.info = new Info(this, this.jogadorAtivo);
	}

	protected PecaCore acharPecaNoCore(Peca p) {
		ArrayList<PecaCore> pecas = new ArrayList<PecaCore>();
		pecas.addAll(this.jogador1.getPecasNaMao());
		pecas.addAll(this.jogador2.getPecasNaMao());
		pecas.addAll(this.tabuleiro.getPecas());

		for (PecaCore pc : pecas) {
			if (pc.getId() == p.getId()) {
				return pc;
			}
		}

		return null;
	}

	public void iniciar() {
		if(this.invertido){
			this.adicinarPecasInvertido();
		}else{
			this.adicionarPecas();
		}
		this.estado = JOGANDO;
	};

	public boolean turno() {
		if (this.turno == this.maxTurnos) {
			this.irParafim();
			return false;
		}

		// cria o objeto que será passado para o jogador
		this.criarInfo();
		
		// se não existem movimentos disponíveis, o jogo acabou
		if (this.info.getMovimentos().size() == 0) {
			this.ganhador = this.getOutroJogador(this.jogadorAtivo);
			this.irParafim();
			return false;
		}

		if(this.info.getMovimentos().size() > 0){
			// se existem movimentos disponíveis, o jogo não acabou
			Movimento m = this.jogadorAtivo.jogar(this.info);
	
			int px = m.getX();
			int py = m.getY();
			PecaCore p = acharPecaNoCore(m.getPeca());
	
			if (m.getTipo().equals("mover")) {
				CasaCore c = this.tabuleiro.getCasa(px, py);
				if (c.temPeca()) {
					PecaCore alvo = c.getPeca();
					this.moverPecaParaMao(alvo, this.jogadorAtivo);
				}
				this.moverPecaNoTabuleiro(p, px, py);
	
				if (p.getClass() == Pintinho.class) {
					this.transformarEmGalo(p);
				}
			} else if (m.getTipo().equals("colocar")) {
				this.colocarPecaNoTabuleiro(p, px, py);
			}
			this.log.adicionar(this.turno, m, this.jogadorAtivo);
			this.replay.salvarSeEstiverLigado();
	
			JogadorCore ganhador = this.verificarLeoesNosFins();
			if (ganhador != null) {
				this.ganhador = ganhador;
				this.irParafim();
				return false;
			}
	
			this.trocarJogadorAtivo();
			this.turno++;
			return true;
		}
		
		return false;
	}

	protected void irParafim() {
		this.estado = FIM;

		if (this.log.estaLigado()) {
			if (this.ganhador != null) {
				this.log.definirIdDoGanhador(this.ganhador.getId());
			} else {
				this.log.definirEmpate();
			}
			this.log.salvar();
			this.jogador1.terminar(this.ganhador.getId());
			this.jogador2.terminar(this.ganhador.getId());
		}
		this.replay.salvarSeEstiverLigado();
	}

	protected JogadorCore verificarLeoesNosFins() {
		ArrayList<PecaCore> pecas = this.tabuleiro.getPecasLeoes();
		for (PecaCore p : pecas) {
			if (p.getDono() == this.jogador1 && p.getY() == 3) {
				return this.jogador1;
			}
			if (p.getDono() == this.jogador2 && p.getY() == 0) {
				return this.jogador2;
			}
		}
		return null;
	}

	protected void transformarEmGalo(PecaCore p) {
		if ((p.getDono() == this.jogador1 && p.getY() == 3) || (p.getDono() == this.jogador2 && p.getY() == 0)) {

			int x = p.getX();
			int y = p.getY();
			PecaCore n = ((Pintinho) p).transformar();
			this.tabuleiro.removerPeca(p);
			this.tabuleiro.addPeca(n, x, y);

		}
	}

	protected void moverPecaParaMao(PecaCore p, JogadorCore j) {
		this.tabuleiro.removerPeca(p);
		if (p.getClass() == Galo.class) {
			p = ((Galo) p).transformar();
		}
		j.colocarPecaNaMao(p);
		j.colocarPeca(p);
		p.setDono(j);
		p.mudarDirecao();
	}

	protected void moverPecaNoTabuleiro(PecaCore p, int x, int y) {
		this.tabuleiro.removerPeca(p);
		this.tabuleiro.addPeca(p, x, y);
	}

	protected void colocarPecaNoTabuleiro(PecaCore p, int x, int y) {
		this.jogadorAtivo.removePecaDaMao(p);
		this.tabuleiro.addPeca(p, x, y);
	}

	protected void trocarJogadorAtivo() {
		if (this.jogadorAtivo == this.jogador1) {
			this.jogadorAtivo = this.jogador2;
		} else {
			this.jogadorAtivo = this.jogador1;
		}
	}

	public TabuleiroCore getTabuleiro() {
		return this.tabuleiro;
	}

	public JogadorCore getJogador1() {
		return this.jogador1;
	}

	public JogadorCore getJogador2() {
		return this.jogador2;
	}

	protected void criarPecasJogador1() {
		PecaCore g = fabricaPeca.criarGirafaParaBaixo();
		this.jogador1.colocarPeca(g);
		g.setDono(this.jogador1);
		this.tabuleiro.addPeca(g, 0, 0);

		PecaCore l = fabricaPeca.criarLeaoParaBaixo();
		this.jogador1.colocarPeca(l);
		l.setDono(this.jogador1);
		this.tabuleiro.addPeca(l, 1, 0);

		PecaCore e = fabricaPeca.criarElefanteParaBaixo();
		this.jogador1.colocarPeca(e);
		e.setDono(this.jogador1);
		this.tabuleiro.addPeca(e, 2, 0);

		PecaCore p = fabricaPeca.criarPintinhoParaBaixo();
		this.jogador1.colocarPeca(p);
		p.setDono(this.jogador1);
		this.tabuleiro.addPeca(p, 1, 1);
	}

	protected void criarPecasJogador2() {
		PecaCore g = fabricaPeca.criarGirafaParaCima();
		this.jogador2.colocarPeca(g);
		g.setDono(this.jogador2);
		this.tabuleiro.addPeca(g, 0, 3);

		PecaCore l = fabricaPeca.criarLeaoParaCima();
		this.jogador2.colocarPeca(l);
		l.setDono(this.jogador2);
		this.tabuleiro.addPeca(l, 1, 3);

		PecaCore e = fabricaPeca.criarElefanteParaCima();
		this.jogador2.colocarPeca(e);
		e.setDono(this.jogador2);
		this.tabuleiro.addPeca(e, 2, 3);

		PecaCore p = fabricaPeca.criarPintinhoParaCima();
		this.jogador2.colocarPeca(p);
		p.setDono(this.jogador2);
		this.tabuleiro.addPeca(p, 1, 2);
	}

	public int getTurno() {
		return this.turno;
	}

	public boolean temGanhador() {
		if (this.ganhador != null) {
			return true;
		} else {
			return false;
		}
	}

	public JogadorCore getGanhador() {
		return this.ganhador;
	}

	protected JogadorCore getOutroJogador(JogadorCore j) {
		if (j.getId() == this.jogador1.getId()) {
			return this.jogador2;
		} else {
			return this.jogador1;
		}
	}

	public boolean continuar() {
		if (this.estado == JOGANDO) {
			return true;
		} else
			return false;
	}

	public void salvarReplay() {
		this.replay.ligar();
	}

	public void salvarLog() {
		this.log.ligar();
	}

	public int getVelocidade() {
		return this.velocidade;
	}

	public void setMaximoDeTurnos(int i) {
		this.maxTurnos = i;
	}

	public void velocidadeDevagar() {
		this.velocidade = 5000;
	}

	public void velocidadeNormal() {
		this.velocidade = 1000;
	}

	public void velocidadeRapida() {
		this.velocidade = 500;
	}

	public void velocidadeMuitoRapida() {
		this.velocidade = 10;
	}
	
	public void velocidadeMaxima() {
		this.velocidade = 0;
	}
}