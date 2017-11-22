class EstrategiaWaifu extends Estrategia {
  private EstrategiaTestarTodas e1;
  private EstrategiaTestarTodas e2;
  private boolean comecei;

  public Movimento escolherMovimento(Info info, ArrayList<Movimento>movimentos) {
    int depth = 4;
    comecei = info.getEu().getId() == 1;
    e1 = new EstrategiaTestarTodas("e1");
    e2 = new EstrategiaTestarTodas("e2");
    JogoCopia jogoInicial = new JogoCopia(e1, e2, info, comecei);

    ArrayList<Movimento> melhoresMovimentos = new ArrayList<Movimento>();
    float maiorValor = Integer.MIN_VALUE;
    float cValor;

    for (int i = 0; i < movimentos.size(); i++) {
      try {
        JogoCopia jogoCopia = new JogoCopia(jogoInicial);
        e1.setMovement(i);
        jogoCopia.turno(e1);
        cValor = min(jogoCopia, depth - 1);
      } 
      catch (CloneNotSupportedException e) {
        cValor = Integer.MIN_VALUE;
        print("Clone Erro");
      }
      if (cValor > maiorValor) {
        maiorValor = cValor;
        melhoresMovimentos = new ArrayList<Movimento>();
        melhoresMovimentos.add(movimentos.get(i));
      } else if (cValor == maiorValor) {
        melhoresMovimentos.add(movimentos.get(i));
      }
    }

    return melhoresMovimentos.get(int(random(melhoresMovimentos.size())));
  }

  private float min(JogoCopia jogoOriginal, int depth) throws CloneNotSupportedException {
    jogoOriginal.setJogadorAtivo(e2);
    jogoOriginal.criarInfo();
    if (jogoOriginal.getGanhador() != null) {
      return avaliarFinal(jogoOriginal.getGanhador());
    } else if (depth == 0) { 
      return avaliar(jogoOriginal.getInfo());
    }
    float menorValor = Integer.MAX_VALUE;

    for (int i = 0; i < jogoOriginal.getInfo().getMovimentos().size(); i++) {
      JogoCopia jogoCopia = new JogoCopia(jogoOriginal);
      e2.setMovement(i);
      jogoCopia.turno(e2);
      float avaliacao = max(jogoCopia, depth - 1);
      if (avaliacao <= menorValor) {
        menorValor = avaliacao;
      }
    }
    return menorValor;
  }

  private float max(JogoCopia jogoOriginal, int depth) throws CloneNotSupportedException {
    jogoOriginal.setJogadorAtivo(e1);
    jogoOriginal.criarInfo();
    if (jogoOriginal.getGanhador() != null) {
      return avaliarFinal(jogoOriginal.getGanhador());
    } else if (depth == 0 ) { 
      return avaliar(jogoOriginal.getInfo());
    }
    float maiorValor = Integer.MIN_VALUE;
    for (int i = 0; i <  jogoOriginal.getInfo().getMovimentos().size(); i++) {
      JogoCopia jogoCopia = new JogoCopia(jogoOriginal);
      e1.setMovement(i);
      jogoCopia.turno(e1);
      float avaliacao = min(jogoCopia, depth - 1);
      if (avaliacao >= maiorValor) { 
        maiorValor = avaliacao;
      }
    }
    return maiorValor;
  }

  private int avaliarFinal(JogadorCoreCopia j) {
    if ((j.getId() == 1 && comecei) || (j.getId() == 2 && !comecei)) {
      return Integer.MAX_VALUE;
    } else {
      return Integer.MIN_VALUE;
    }
  }

  private float avaliar(InfoCopia i) {
    JogadorCopia eu;
    JogadorCopia oponente;
    if ((i.getEu().getId() == 1 && comecei) || (i.getEu().getId() == 2 && !comecei)) {
      eu = i.getEu();
      oponente = i.getOponente();
    } else {
      eu = i.getOponente();
      oponente = i.getEu();
    }
    return pontuar(i, eu) - pontuar(i, oponente);
  }

  private float pontuar(InfoCopia i, JogadorCopia j) {
    return somarPecas(i, j);
  }

  private float somarPecas(InfoCopia i, JogadorCopia j) {
    float pinV = 1;
    float galV = 1.7;
    float girV = 1.5;
    float eleV = 1.6;

    int sum = 0;
    ArrayList<PecaCopia> minhasPecas = new ArrayList<PecaCopia>();
    for (PecaCopia p : i.getTabuleiro().getPecas()) {
      if (p.getDono().getId() == j.getId()) {
        minhasPecas.add(p);
      }
    }
    minhasPecas.addAll(j.getPecasNaMao());
    for (PecaCopia p : minhasPecas) {
      String nomePeca = p.getNome();
      if (nomePeca.equals("pin")) {
        sum += pinV;
      } else if (nomePeca.equals("gal")) {
        sum += galV;
      } else if (nomePeca.equals("gir")) {
        sum += girV;
      } else if (nomePeca.equals("ele")) {
        sum += eleV;
      } else if (nomePeca.equals("leo")) {
      } else {
        print("Achei");
      }
    }

    return sum;
  }

  //toda estratégia deve ter um nome.
  public String getNome() {
    return "Waifu 11";
  }

  //toda estratégia deve ter um nome de equipe.
  public String getEquipe() {
    return "Unnamed";
  }

  class EstrategiaTestarTodas extends EstrategiaCopia {
    private int movement = 0;
    private String nome;

    public EstrategiaTestarTodas(String nome) {
      this.nome = nome;
    }

    public MovimentoCopia escolherMovimento(InfoCopia info, ArrayList<MovimentoCopia>movimentos) {
      return movimentos.get(movement);
    }

    public void setMovement(int movement) {
      this.movement = movement;
    }

    public String getNome() {
      return nome;
    }

    public String getEquipe() {
      return "Unnamed";
    }

    public EstrategiaCopia clone() throws CloneNotSupportedException {
      return (EstrategiaCopia) super.clone();
    }
  }

  /////////////////////////////////////////////////////
  ////////////////////////////////////////////////////
  ///////////////////////////////////////////////////
  public class TabuleiroCoreCopia {
    public CasaCoreCopia[][] casas;
    private int largura;
    private int altura;

    public TabuleiroCoreCopia(TabuleiroCoreCopia clone, JogadorCoreCopia j1, JogadorCoreCopia j2) {
      this.altura = clone.altura;
      this.largura = clone.largura;
      casas = new CasaCoreCopia[this.largura][this.altura];
      for (int i = 0; i < largura; i++) {
        for (int j = 0; j < altura; j++) {
          if (clone.casas[i][j].getPeca() != null) {
            if (clone.casas[i][j].getPeca().getDono().getId() == j1.getId()) {
              this.casas[i][j] = new CasaCoreCopia(clone.casas[i][j], j1);
            } else {
              this.casas[i][j] = new CasaCoreCopia(clone.casas[i][j], j2);
            }
          } else {
            this.casas[i][j] = new CasaCoreCopia(clone.casas[i][j], null);
          }
        }
      }
    }

    public TabuleiroCoreCopia() {
      this.largura = 3;
      this.altura = 4;

      this.criarCasas();
    }

    private void criarCasas() {
      casas = new CasaCoreCopia[this.largura][this.altura];
      for (int i =0; i<this.largura; i++) {
        for (int j =0; j<this.altura; j++) {
          this.casas[i][j] = new CasaCoreCopia(i, j);
        }
      }
    }

    public void addPeca(PecaCoreCopia p, int x, int y) {
      this.casas[x][y].colocarPeca(p);
    }

    public void removerPeca(PecaCoreCopia p) {
      int px = p.getX();
      int py = p.getY();
      this.casas[px][py].removerPeca();
    }

    public CasaCoreCopia getCasa(int x, int y) {
      if (x < 0 || x > this.largura-1 || y < 0 || y > this.altura-1) {
        return null;
      } else {
        return this.casas[x][y];
      }
    }

    public int getLargura() {
      return this.largura;
    }

    public int getAltura() {
      return this.altura;
    }

    public ArrayList<PecaCoreCopia> getPecas() {
      ArrayList<PecaCoreCopia> pecas = new ArrayList<PecaCoreCopia>(); 
      for (int i =0; i<this.largura; i++) {
        for (int j =0; j<this.altura; j++) {

          if (this.casas[i][j].temPeca())
            pecas.add(this.casas[i][j].getPeca());
        }
      }
      return pecas;
    }

    public ArrayList<PecaCoreCopia> getPecasLeoes() {
      return this.getPecasPorTipo(Leao.class);
    }
    public ArrayList<PecaCoreCopia> getPecasPintinhos() {
      return this.getPecasPorTipo(Pintinho.class);
    }

    private ArrayList<PecaCoreCopia> getPecasPorTipo(Class c) {
      ArrayList<PecaCoreCopia> pecas = new ArrayList<PecaCoreCopia>(); 
      for (int i =0; i<this.largura; i++) {
        for (int j =0; j<this.altura; j++) {

          if (this.casas[i][j].temPeca() && this.casas[i][j].getPeca().getClass() == c) {
            pecas.add(this.casas[i][j].getPeca());
          }
        }
      }
      return pecas;
    }
  }

  public class TabuleiroCopia {
    private int largura;
    private int altura;
    private CasaCopia[][] casas;
    private ArrayList<PecaCopia> pecas;

    public TabuleiroCopia(TabuleiroCoreCopia tc, JogadorCopia j1, JogadorCopia j2) {
      this.largura = 3;
      this.altura = 4;
      this.pecas = new ArrayList<PecaCopia>();

      this.casas = new CasaCopia[this.largura][this.altura];
      for (int i =0; i<this.largura; i++) {
        for (int j =0; j<this.altura; j++) {

          if ( tc.getCasa(i, j).temPeca() ) {

            PecaCoreCopia pc = tc.getCasa(i, j).getPeca();
            JogadorCopia jogador = null;

            if (pc.getDono().getId() == j1.getId()) {
              jogador = j1;
            } else {
              jogador = j2;
            }
            PecaCopia p = new PecaCopia(pc, jogador);
            this.pecas.add(p);
            this.casas[i][j] = new CasaCopia(i, j, p);
          } else {
            this.casas[i][j] = new CasaCopia(i, j, null);
          }
        }
      }
    }

    public CasaCopia getCasa(int x, int y) {
      if (x < 0 || x > this.largura-1 || y < 0 || y > this.altura-1) {
        return null;
      } else {
        return this.casas[x][y];
      }
    }

    public int getLargura() {
      return this.largura;
    }

    public int getAltura() {
      return this.altura;
    }

    public ArrayList<PecaCopia> getPecas() {
      return this.pecas;
    }


    public ArrayList<CasaCopia> getCasasVazias() {
      ArrayList<CasaCopia> casas = new ArrayList<CasaCopia>(); 
      for (int i =0; i<this.largura; i++) {
        for (int j =0; j<this.altura; j++) {

          if (!this.casas[i][j].temPeca())
            casas.add(this.casas[i][j]);
        }
      }
      return casas;
    }
  }

  public class PintinhoCopia extends PecaCoreCopia {
    public PintinhoCopia(int id, int d) {
      super(id, d);
      this.nome = "pin";
    }

    public PecaCoreCopia transformar() {
      PecaCoreCopia g = new GaloCopia(this.getId(), this.direcao);
      g.setDono(this.dono);
      return g;
    }

    public int[][] getMatrizDeMovimento() {
      int[][] movimento = {
        {0, -1}
      };

      if (this.direcao == PecaCore.BAIXO) {
        movimento[0][1] = movimento[0][1]*-1;
      }
      return movimento;
    }
  }

  public class PecaCoreCopia {

    private int id;
    private int x;
    private int y;
    protected int direcao;

    protected String nome;
    protected JogadorCoreCopia dono;

    public static final int CIMA = -1;
    public static final int BAIXO = 1;

    public PecaCoreCopia(int id, int d) {
      this.direcao = d;
      this.id = id;
    }

    public void mudarDirecao() {
      if (this.direcao == CIMA) {
        this.direcao = BAIXO;
      } else {
        this.direcao = CIMA;
      }
    }

    public void setId(int id) {
      this.id = id;
    }

    public int getX() {
      return this.x;
    }

    public int getY() {
      return this.y;
    }
    public void setX(int x) {
      this.x = x;
    }

    public void setY(int y) {
      this.y = y;
    } 

    public void setDono(JogadorCoreCopia j) {
      this.dono = j;
    }

    public JogadorCoreCopia getDono() {
      return this.dono;
    }

    public String getNome() {
      return this.nome;
    }

    public void setNome(String nome) {
      this.nome = nome;
    }

    public int getId() {
      return this.id;
    }

    public int[][] getMatrizDeMovimento() {
      return null;
    }

    public int getDirecao() {
      return this.direcao;
    }
  }

  public class PecaCopia {
    private int x;
    private int y;
    private int id;
    private String nome;
    private JogadorCopia dono;
    protected int direcao;
    private int[][] matrizDeMovimento;

    public PecaCopia(PecaCoreCopia p, JogadorCopia dono) {
      this.x = p.getX();
      this.y = p.getY();
      this.id = p.getId();
      this.dono = dono;
      this.nome = p.getNome();
      if (p.getMatrizDeMovimento() == null) {
        print("c");
      }
      this.matrizDeMovimento = p.getMatrizDeMovimento();
    }

    public int getX() {
      return this.x;
    }

    public int getY() {
      return this.y;
    }

    public int getId() {
      return this.id;
    }

    public JogadorCopia getDono() {
      return this.dono;
    }

    public void setDono(JogadorCopia dono) {
      this.dono = dono;
    }

    public void setX(int x) {
      this.x = x;
    }

    public void setY(int y) {
      this.y = y;
    }

    public String getNome() {
      return this.nome;
    }
    public int[][] getMatrizDeMovimento() {
      return this.matrizDeMovimento;
    }
    public String toString() {
      return "peca:"+this.x+","+this.y+","+this.nome+","+this.dono.getId()+";\n";
    }

    public int getDirecao() {
      return this.direcao;
    }
  }

  public class MovimentoCopia {

    public static final String MOVER = "mover";
    public static final String COLOCAR = "colocar";

    private PecaCopia peca;
    private String tipo;
    private int x;
    private int y;
    private JogadorCopia jogador;

    public MovimentoCopia(PecaCopia p, int x, int y, String tipo, JogadorCopia j) {
      this.x = x;
      this.y = y;
      this.tipo = tipo;
      this.peca = p;
      this.jogador = j;
    }

    public String getTipo() {
      return this.tipo;
    }

    public PecaCopia getPeca() {
      return this.peca;
    }
    public int getX() {
      return this.x;
    }
    public int getY() {
      return this.y;
    }

    public JogadorCopia getJogador() {
      return this.jogador;
    }

    public String toString() {
      return jogador.getId()+","+peca.getX()+","+peca.getY()+","+this.x+","+this.y+","+this.peca.getNome()+","+tipo;
    }
  }

  public class LeaoCopia extends PecaCoreCopia {

    public LeaoCopia(int id, int d) {
      super(id, d);
      this.nome = "leo";
    }

    public int[][] getMatrizDeMovimento() {
      int[][] movimento = {
        {-1, -1}, {0, -1}, {1, -1}, 
        {-1, 0}, {1, 0}, 
        {-1, 1}, {0, 1}, {1, 1}
      };
      return movimento;
    }
  }

  public class JogoCopia {

    protected FabricaPecaCoreCopia fabricaPeca;

    protected TabuleiroCoreCopia tabuleiro;
    protected JogadorCoreCopia jogador1;
    protected JogadorCoreCopia jogador2;
    protected JogadorCoreCopia jogadorAtivo;
    protected JogadorCoreCopia ganhador;
    protected InfoCopia info;
    private boolean comecei;

    public JogoCopia (JogoCopia clone) {
      this.jogador1 = new JogadorCoreCopia (clone.jogador1);
      this.jogador2 = new JogadorCoreCopia (clone.jogador2);
      this.tabuleiro = new TabuleiroCoreCopia(clone.tabuleiro, jogador1, jogador2);
    }

    public JogoCopia (EstrategiaCopia e1, EstrategiaCopia e2, Info info, boolean comecei) {
      this.comecei = comecei;
      this.fabricaPeca = new FabricaPecaCoreCopia();

      this.tabuleiro = new TabuleiroCoreCopia();
      if (comecei) {
        this.jogador1 = new JogadorCoreCopia(e1, 1);
        this.jogador2 = new JogadorCoreCopia(e2, 2);
      } else {
        this.jogador1 = new JogadorCoreCopia(e1, 2);
        this.jogador2 = new JogadorCoreCopia(e2, 1);
      }
      this.jogadorAtivo = jogador1;

      ArrayList<Peca> minhasPecas = new ArrayList<Peca>();
      ArrayList<Peca> pecasOponente = new ArrayList<Peca>();
      ArrayList<Peca> pecasNaMinhaMao = info.getEu().getPecasNaMao();
      ArrayList<Peca> pecasNaMaoOponente = info.getOponente().getPecasNaMao();

      for (Peca p : info.getTabuleiro().getPecas()) {
        if (p.getDono().getId() == jogador1.getId()) {
          minhasPecas.add(p);
        } else {
          pecasOponente.add(p);
        }
      }
      if (comecei) {
        this.criarPecasJogadorCima(jogador1, minhasPecas);
        this.criarPecasJogadorBaixo(jogador2, pecasOponente);
        this.colocarPecasNaMaoJogadorCima(jogador1, pecasNaMinhaMao);
        this.colocarPecasNaMaoJogadorBaixo(jogador2, pecasNaMaoOponente);
      } else {
        this.criarPecasJogadorBaixo(jogador1, minhasPecas);
        this.criarPecasJogadorCima(jogador2, pecasOponente);
        this.colocarPecasNaMaoJogadorBaixo(jogador1, pecasNaMinhaMao);
        this.colocarPecasNaMaoJogadorCima(jogador2, pecasNaMaoOponente);
      }
    }

    private void colocarPecasNaMaoJogadorCima(JogadorCoreCopia j, ArrayList<Peca> pecas) {
      for (Peca p : pecas) {
        if (p.getNome().equals("pin")) {
          PecaCoreCopia newP = fabricaPeca.criarPintinhoParaBaixo(p.getId());
          j.colocarPecaNaMao(newP);
          newP.setDono(j);
        } else if (p.getNome().equals("gal")) {
          PecaCoreCopia newP = fabricaPeca.criarPintinhoParaBaixo(p.getId());
          j.colocarPecaNaMao(newP);
          newP.setDono(j);
        } else if (p.getNome().equals("ele")) {
          PecaCoreCopia newP = fabricaPeca.criarPintinhoParaBaixo(p.getId());
          j.colocarPecaNaMao(newP);
          newP.setDono(j);
        } else if (p.getNome().equals("gir")) {
          PecaCoreCopia newP = fabricaPeca.criarPintinhoParaBaixo(p.getId());
          j.colocarPecaNaMao(newP);
          newP.setDono(j);
        } else if (p.getNome().equals("leo")) {
          PecaCoreCopia newP = fabricaPeca.criarPintinhoParaBaixo(p.getId());
          j.colocarPecaNaMao(newP);
          newP.setDono(j);
        }
      }
    }

    private void criarPecasJogadorCima(JogadorCoreCopia j, ArrayList<Peca> pecas) {
      for (Peca p : pecas) {
        if (p.getNome().equals("pin")) {
          PecaCoreCopia newP = fabricaPeca.criarPintinhoParaBaixo(p.getId());
          j.colocarPeca(newP);
          newP.setDono(j);
          this.tabuleiro.addPeca(newP, p.getX(), p.getY());
        } else if (p.getNome().equals("gal")) {
          PecaCoreCopia newP = fabricaPeca.criarGaloParaBaixo(p.getId());
          j.colocarPeca(newP);
          newP.setDono(j);
          this.tabuleiro.addPeca(newP, p.getX(), p.getY());
        } else if (p.getNome().equals("ele")) {
          PecaCoreCopia newP = fabricaPeca.criarElefanteParaBaixo(p.getId());
          j.colocarPeca(newP);
          newP.setDono(j);
          this.tabuleiro.addPeca(newP, p.getX(), p.getY());
        } else if (p.getNome().equals("gir")) {
          PecaCoreCopia newP = fabricaPeca.criarGirafaParaBaixo(p.getId());
          j.colocarPeca(newP);
          newP.setDono(j);
          this.tabuleiro.addPeca(newP, p.getX(), p.getY());
        } else if (p.getNome().equals("leo")) {
          PecaCoreCopia newP = fabricaPeca.criarLeaoParaBaixo(p.getId());
          j.colocarPeca(newP);
          newP.setDono(j);
          this.tabuleiro.addPeca(newP, p.getX(), p.getY());
        }
      }
    }

    private void colocarPecasNaMaoJogadorBaixo(JogadorCoreCopia j, ArrayList<Peca> pecas) {
      for (Peca p : pecas) {
        if (p.getNome().equals("pin")) {
          PecaCoreCopia newP = fabricaPeca.criarPintinhoParaCima(p.getId());
          j.colocarPecaNaMao(newP);
          newP.setDono(j);
        } else if (p.getNome().equals("gal")) {
          PecaCoreCopia newP = fabricaPeca.criarGaloParaCima(p.getId());
          j.colocarPecaNaMao(newP);
          newP.setDono(j);
        } else if (p.getNome().equals("ele")) {
          PecaCoreCopia newP = fabricaPeca.criarElefanteParaCima(p.getId());
          j.colocarPecaNaMao(newP);
          newP.setDono(j);
        } else if (p.getNome().equals("gir")) {
          PecaCoreCopia newP = fabricaPeca.criarGirafaParaCima(p.getId());
          j.colocarPecaNaMao(newP);
          newP.setDono(j);
        } else if (p.getNome().equals("leo")) {
          PecaCoreCopia newP = fabricaPeca.criarLeaoParaCima(p.getId());
          j.colocarPecaNaMao(newP);
          newP.setDono(j);
        }
      }
    }

    private void criarPecasJogadorBaixo(JogadorCoreCopia j, ArrayList<Peca> pecas) {
      for (Peca p : pecas) {
        if (p.getNome().equals("pin")) {
          PecaCoreCopia newP = fabricaPeca.criarPintinhoParaCima(p.getId());
          j.colocarPeca(newP);
          newP.setDono(j);
          this.tabuleiro.addPeca(newP, p.getX(), p.getY());
        } else if (p.getNome().equals("gal")) {
          PecaCoreCopia newP = fabricaPeca.criarGaloParaCima(p.getId());
          j.colocarPeca(newP);
          newP.setDono(j);
          this.tabuleiro.addPeca(newP, p.getX(), p.getY());
        } else if (p.getNome().equals("ele")) {
          PecaCoreCopia newP = fabricaPeca.criarElefanteParaCima(p.getId());
          j.colocarPeca(newP);
          newP.setDono(j);
          this.tabuleiro.addPeca(newP, p.getX(), p.getY());
        } else if (p.getNome().equals("gir")) {
          PecaCoreCopia newP = fabricaPeca.criarGirafaParaCima(p.getId());
          j.colocarPeca(newP);
          newP.setDono(j);
          this.tabuleiro.addPeca(newP, p.getX(), p.getY());
        } else if (p.getNome().equals("leo")) {
          PecaCoreCopia newP = fabricaPeca.criarLeaoParaCima(p.getId());
          j.colocarPeca(newP);
          newP.setDono(j);
          this.tabuleiro.addPeca(newP, p.getX(), p.getY());
        }
      }
    }

    public void criarInfo() {
      this.info = new InfoCopia(this, this.jogadorAtivo);
    }

    private PecaCoreCopia acharPecaNoCore(PecaCopia p) {
      ArrayList<PecaCoreCopia> pecas = new ArrayList<PecaCoreCopia>();
      pecas.addAll(this.jogador1.getPecasNaMao());
      pecas.addAll(this.jogador2.getPecasNaMao());
      pecas.addAll(this.tabuleiro.getPecas());

      for (PecaCoreCopia pc : pecas) {
        if (pc.getId() == p.getId()) {
          return pc;
        }
      }

      return null;
    }

    private JogadorCoreCopia acharJogador(EstrategiaCopia e) {
      if (e.getNome().equals("e1")) {
        return jogador1;
      } else if (e.getNome().equals("e2")) {
        return jogador2;
      } else {
        print("Erro acharJogador");
        return null;
      }
    }

    public boolean turno(EstrategiaCopia e) {

      this.jogadorAtivo = acharJogador(e);

      //cria o objeto que será passado para o jogador  
      this.criarInfo();

      //se existem movimentos disponíveis, o jogo não acabou
      if (this.info.getMovimentos().size()>0) {
        MovimentoCopia m = this.jogadorAtivo.jogar(this.info);

        int px = m.getX();
        int py = m.getY();
        PecaCoreCopia p = acharPecaNoCore(m.getPeca());

        if (m.getTipo().equals("mover")) {
          CasaCoreCopia c = this.tabuleiro.getCasa(px, py);
          if (c.temPeca()) {
            PecaCoreCopia alvo = c.getPeca();
            this.moverPecaParaMao(alvo, this.jogadorAtivo);
          }
          this.moverPecaNoTabuleiro(p, px, py);

          if (p.getClass() == PintinhoCopia.class) {
            this.transformarEmGalo(p);
          }
        } else if (m.getTipo().equals("colocar")) {
          this.colocarPecaNoTabuleiro(p, px, py);
        }
        //this.log.adicionar(this.turno, m,this.jogadorAtivo);
        //se não existem movimentos disponíveis, o jogo acabou
      } else {
        this.ganhador = this.getOutroJogador(this.jogadorAtivo);
        return false;
      }

      JogadorCoreCopia ganhador = this.verificarLeoesNosFins();
      if (ganhador != null) {
        this.ganhador = ganhador;
        return false;
      }

      return true;
    }

    private JogadorCoreCopia verificarLeoesNosFins() {
      ArrayList<PecaCoreCopia> pecas = this.tabuleiro.getPecasLeoes();
      for (PecaCoreCopia p : pecas) {
        if ((p.getDono().getId() == this.jogador1.getId() && p.getY() == 3 && comecei) || (p.getDono().getId() == this.jogador1.getId() && p.getY() == 0 && !comecei)) {
          return this.jogador1;
        }
        if ((p.getDono().getId() == this.jogador2.getId() && p.getY() == 0 && comecei) || (p.getDono().getId() == this.jogador2.getId() && p.getY() == 3 && !comecei)) {
          return this.jogador2;
        }
      }
      return null;
    }
    private void transformarEmGalo(PecaCoreCopia p) {
      if (
        (p.getDono() == this.jogador1 && p.getY() == 3) ||
        (p.getDono() == this.jogador2 && p.getY() == 0)
        ) {

        int x = p.getX();
        int y = p.getY();
        PecaCoreCopia n = ((PintinhoCopia)p).transformar();
        this.tabuleiro.removerPeca(p);
        this.tabuleiro.addPeca(n, x, y);
      }
    }

    protected void moverPecaParaMao(PecaCoreCopia p, JogadorCoreCopia j) {
      this.tabuleiro.removerPeca(p);
      if (p.getClass() == GaloCopia.class) {
        p = ((GaloCopia) p).transformar();
      }
      j.colocarPecaNaMao(p);
      j.colocarPeca(p);
      p.setDono(j);
      p.mudarDirecao();
    }

    protected void moverPecaNoTabuleiro(PecaCoreCopia p, int x, int y) {
      this.tabuleiro.removerPeca(p);
      this.tabuleiro.addPeca(p, x, y);
    }
    protected void colocarPecaNoTabuleiro(PecaCoreCopia p, int x, int y) {
      this.jogadorAtivo.removePecaDaMao(p);
      this.tabuleiro.addPeca(p, x, y);
    }

    public TabuleiroCoreCopia getTabuleiro() {
      return this.tabuleiro;
    }
    public JogadorCoreCopia getJogador1() {
      return this.jogador1;
    }
    public JogadorCoreCopia getJogador2() {
      return this.jogador2;
    }

    public JogadorCoreCopia getGanhador() {
      return this.ganhador;
    }

    private JogadorCoreCopia getOutroJogador(JogadorCoreCopia j) {
      if (j.getId() == this.jogador1.getId()) {
        return this.jogador2;
      } else {
        return this.jogador1;
      }
    } 

    public void setJogadorAtivo(EstrategiaCopia e) {
      this.jogadorAtivo = acharJogador(e);
    }

    public InfoCopia getInfo() throws CloneNotSupportedException {
      return this.info;
    }
  }


  public class JogadorCoreCopia {
    private int id;
    private ArrayList<PecaCoreCopia>pecas;
    private ArrayList<PecaCoreCopia>pecasNaMao;
    private EstrategiaCopia estrategia;

    public JogadorCoreCopia (JogadorCoreCopia clone) {
      this.id = clone.id;
      this.pecas = new  ArrayList<PecaCoreCopia>();
      this.pecasNaMao = new  ArrayList<PecaCoreCopia>();

      for (PecaCoreCopia p : clone.pecas) {
        this.pecas.add(new FabricaPecaCoreCopia().criarPecaCore(p, this));
      }
      for (PecaCoreCopia p : clone.pecasNaMao) {
        this.pecasNaMao.add(new FabricaPecaCoreCopia().criarPecaCore(p, this));
      }

      this.estrategia = clone.estrategia;
    }

    public JogadorCoreCopia (EstrategiaCopia e, int id) {
      this.estrategia = e;
      this.id = id;
      this.pecasNaMao = new ArrayList<PecaCoreCopia>();
      this.pecas = new ArrayList<PecaCoreCopia>();
    }

    public ArrayList<PecaCoreCopia> getPecas() {
      return this.pecas;
    }

    public MovimentoCopia jogar(InfoCopia info) {
      return this.estrategia.escolherMovimento(info, info.getMovimentos());
    }

    public void colocarPeca(PecaCoreCopia p) {
      this.pecas.add(p);
    }

    public void removePeca(PecaCoreCopia p) {
      this.pecas.remove(p);
    }

    public void colocarPecaNaMao(PecaCoreCopia p) {
      this.pecasNaMao.add(p);
    }

    public void removePecaDaMao(PecaCoreCopia p) {
      this.pecasNaMao.remove(p);
    }

    public ArrayList<PecaCoreCopia> getPecasNaMao() {
      return this.pecasNaMao;
    }
    public int getId() {
      return this.id;
    }
    public EstrategiaCopia getEstrategia() {
      return this.estrategia;
    }
    public String getNomeEquipe() {
      return this.estrategia.getNome();
    }
    public String getNomeEstrategia() {
      return this.estrategia.getEquipe();
    }
  }

  public class JogadorCopia {
    private int id;
    private ArrayList<PecaCopia>pecasNaMao;

    public JogadorCopia(JogadorCoreCopia jogador) {
      this.id = jogador.getId();
      this.pecasNaMao = new ArrayList<PecaCopia>();

      ArrayList<PecaCoreCopia> pecasNaMaoOriginal = jogador.getPecasNaMao();
      for (PecaCoreCopia pc : pecasNaMaoOriginal) {
        PecaCopia p = new PecaCopia(pc, this);
        this.pecasNaMao.add(p);
      }
    }

    public int getId() {
      return this.id;
    }
    public ArrayList<PecaCopia> getPecasNaMao() {
      return this.pecasNaMao;
    }
    public String toString() {
      return "jogador:\n"+this.pecasNaMao;
    }
  }

  public class InfoCopia {
    private TabuleiroCopia tabuleiro;
    private JogadorCopia jogador1;
    private JogadorCopia jogador2;
    private JogadorCopia jogadorAtual;
    private int idDoJogadorAtual;
    private ArrayList<MovimentoCopia>movimentos;
    private boolean meuLeaoEstaSendoAtacado;

    //para criar um objeto Info, é preciso ter o estado atual do jogo e quem é o jogador que deve fazer um movimento.
    public InfoCopia (JogoCopia jogo, JogadorCoreCopia j) {
      this.idDoJogadorAtual = j.getId();
      this.jogador1 = new JogadorCopia(jogo.getJogador1());
      this.jogador2 = new JogadorCopia(jogo.getJogador2());

      if (this.idDoJogadorAtual == this.jogador1.getId()) {
        this.jogadorAtual = this.jogador1;
      } else {
        this.jogadorAtual = this.jogador2;
      }

      this.tabuleiro = new TabuleiroCopia(jogo.getTabuleiro(), jogador1, jogador2);
      this.movimentos = new ArrayList<MovimentoCopia>();
      this.meuLeaoEstaSendoAtacado = false;

      ArrayList<PecaCopia> pecas = this.tabuleiro.getPecas();
      ArrayList<PecaCopia> pecasMinhas = new ArrayList<PecaCopia>();
      ArrayList<PecaCopia> pecasOponente = new ArrayList<PecaCopia>();
      PecaCopia meuLeao = null;

      for (PecaCopia p : pecas) {
        if (p.getDono().getId() == this.idDoJogadorAtual) {
          pecasMinhas.add(p);
          if (p.getNome().equals("leo")) {
            meuLeao = p;
          }
        } else {
          pecasOponente.add(p);
        }
      }

      ArrayList<PecaCopia> atacandoLeao = this.leaoEmPerigo(pecasOponente, meuLeao);
      boolean[][] matrizDeAtaque = this.criarMatrizDeAtaque(pecasOponente);
      if (atacandoLeao.size() > 0) {
        this.meuLeaoEstaSendoAtacado = true;
      }


      for (PecaCopia p : pecasMinhas) {           
        int[][] matriz = p.getMatrizDeMovimento();
        for (int i =0; i<matriz.length; i++) {
          int x = p.getX()+matriz[i][0];
          int y = p.getY()+matriz[i][1];

          //somente movimentos dentro do tabuleiro.
          if ( !(x < 0 || x > this.tabuleiro.getLargura()-1 || y< 0 || y > this.tabuleiro.getAltura()-1)) {
            CasaCopia c = this.tabuleiro.getCasa(x, y);
            PecaCopia destino = c.getPeca();



            //se for o leao, não pode mover onde o oponente esta atacando!
            if (p.getNome().equals("leo")) {

              if (destino != null && !matrizDeAtaque[x][y] && destino.getDono() != p.getDono()) {
                MovimentoCopia m = new MovimentoCopia(p, x, y, "mover", this.jogadorAtual);
                this.movimentos.add(m);
              }

              if (destino == null && !matrizDeAtaque[x][y]) {
                MovimentoCopia m = new MovimentoCopia(p, x, y, "mover", this.jogadorAtual);
                this.movimentos.add(m);
              }
            } else {

              //se o meu leão está sendo atacado, posso matar os atacantes.
              if (this.meuLeaoEstaSendoAtacado) {
                for (PecaCopia atl : atacandoLeao) {
                  if (destino != null && atl.getId() == destino.getId() && destino.getDono() != p.getDono()) {
                    MovimentoCopia m = new MovimentoCopia(p, x, y, "mover", this.jogadorAtual);
                    this.movimentos.add(m);
                  }
                }
              } else {
                if (destino != null && destino.getDono() != p.getDono()) {
                  MovimentoCopia m = new MovimentoCopia(p, x, y, "mover", this.jogadorAtual);
                  this.movimentos.add(m);
                }

                if (destino == null) {
                  MovimentoCopia m = new MovimentoCopia(p, x, y, "mover", this.jogadorAtual);
                  this.movimentos.add(m);
                }
              }
            }
          }
        }
      }

      if (!this.meuLeaoEstaSendoAtacado) {
        pecasMinhas.clear();
        if (this.idDoJogadorAtual == this.jogador1.getId()) {
          pecasMinhas = this.jogador1.getPecasNaMao();
        } else {
          pecasMinhas = this.jogador2.getPecasNaMao();
        }

        ArrayList<CasaCopia>casasVazias = this.tabuleiro.getCasasVazias();
        for (PecaCopia p : pecasMinhas) {
          for (CasaCopia c : casasVazias) {
            MovimentoCopia m = new MovimentoCopia(p, c.getX(), c.getY(), "colocar", this.jogadorAtual);
            this.movimentos.add(m);
          }
        }
      }
    }

    public TabuleiroCopia getTabuleiro() {
      return this.tabuleiro;
    }

    private ArrayList<PecaCopia> leaoEmPerigo(ArrayList<PecaCopia>pecas, PecaCopia leao) {
      ArrayList<PecaCopia>atacantes = new ArrayList<PecaCopia>();
      for (PecaCopia p : pecas) {
        int[][] matriz = p.getMatrizDeMovimento();
        for (int i =0; i<matriz.length; i++) {
          int x = p.getX()+matriz[i][0];
          int y = p.getY()+matriz[i][1];

          if (x == leao.getX() && y == leao.getY()) {
            atacantes.add(p);
          }
        }
      }
      return atacantes;
    }

    private boolean[][] criarMatrizDeAtaque(ArrayList<PecaCopia>pecas) {
      boolean[][] matrizDeAtaque = new boolean[this.tabuleiro.getLargura()][this.tabuleiro.getAltura()];
      for (PecaCopia p : pecas) {
        int[][] matriz = p.getMatrizDeMovimento();
        for (int i =0; i<matriz.length; i++) {
          int x = p.getX()+matriz[i][0];
          int y = p.getY()+matriz[i][1];

          if ( !(x < 0 || x > this.tabuleiro.getLargura()-1 || y< 0 || y > this.tabuleiro.getAltura()-1)) {
            matrizDeAtaque[x][y] = true;
          }
        }
      }
      return matrizDeAtaque;
    }

    public JogadorCopia getOponente() {
      if (this.idDoJogadorAtual == this.jogador1.getId()) {
        return this.jogador2;
      } else {
        return this.jogador1;
      }
    }

    public ArrayList<MovimentoCopia> getMovimentos() {
      return this.movimentos;
    }

    public JogadorCopia getEu() {
      if (this.idDoJogadorAtual == this.jogador1.getId()) {
        return this.jogador1;
      } else {
        return this.jogador2;
      }
    }
  }

  public class GirafaCopia extends PecaCoreCopia {
    public GirafaCopia(int id, int d) {
      super(id, d);
      this.nome = "gir";
    }

    public int[][] getMatrizDeMovimento() {
      int[][] movimento = {
        {0, -1}, 
        {-1, 0}, {1, 0}, 
        {0, 1}
      };
      return movimento;
    }
  }

  public class GaloCopia extends PecaCoreCopia {
    public GaloCopia(int id, int d) {
      super(id, d);
      this.nome = "gal";
    }

    public PecaCoreCopia transformar() {
      PecaCoreCopia p = new PintinhoCopia(this.getId(), this.direcao);
      p.setDono(this.dono);
      return p;
    }

    public int[][] getMatrizDeMovimento() {
      int[][] movimento = {
        {-1, -1}, {0, -1}, {1, -1}, 
        {-1, 0}, {1, 0}, 
        {0, 1}
      };

      if (this.direcao == PecaCore.BAIXO) {
        for (int i =0; i<movimento.length; i++) {
          movimento[i][0] = movimento[i][0]*(-1);
          movimento[i][1] = movimento[i][1]*(-1);
        }
      }


      return movimento;
    }
  }

  //classe abstrata responsável por definir aquilo que é obrigatório ao definir uma estratégia.
  public abstract class EstrategiaCopia {

    //método que de fato define a estrategia
    public abstract MovimentoCopia escolherMovimento(InfoCopia info, ArrayList<MovimentoCopia>movimentos);

    //toda estratégia deve ter um nome.
    public abstract String getNome();

    //toda estratégia deve ter um nome de equipe.
    public abstract String getEquipe();
  }
  class FabricaPecaCoreCopia {
    public PecaCoreCopia criarPecaCore (PecaCoreCopia clone, JogadorCoreCopia jogadorClone) {
      PecaCoreCopia p;
      if (clone.getNome().equals("leo")) {
        if (jogadorClone.getId() == 1) {
          p = this.criarLeaoParaBaixo(clone.getId());
        } else {
          p = this.criarLeaoParaCima(clone.getId());
        }
      } else if (clone.getNome().equals("gir")) {
        if (jogadorClone.getId() == 1) {
          p = this.criarGirafaParaBaixo(clone.getId());
        } else {
          p = this.criarGirafaParaCima(clone.getId());
        }
      } else if (clone.getNome().equals("ele")) {
        if (jogadorClone.getId() == 1) {
          p = this.criarElefanteParaBaixo(clone.getId());
        } else {
          p = this.criarElefanteParaCima(clone.getId());
        }
      } else if (clone.getNome().equals("pin")) {
        if (jogadorClone.getId() == 1) {
          p = this.criarPintinhoParaBaixo(clone.getId());
        } else {
          p = this.criarPintinhoParaCima(clone.getId());
        }
      } else if (clone.getNome().equals("gal")) {
        if (jogadorClone.getId() == 1) {
          p = this.criarGaloParaBaixo(clone.getId());
        } else {
          p = this.criarGaloParaCima(clone.getId());
        }
      } else {
        print("Erro criar Peca");
        p = this.criarGaloParaCima(clone.getId());
      }
      p.setDono(jogadorClone);
      p.setX(clone.getX());
      p.setY(clone.getY());
      return p;
    }

    public PecaCoreCopia criarLeaoParaBaixo(int id) {
      return new LeaoCopia(id, PecaCore.BAIXO);
    }
    public PecaCoreCopia criarLeaoParaCima(int id) {
      return new LeaoCopia(id, PecaCore.CIMA);
    }

    public PecaCoreCopia criarElefanteParaBaixo(int id) {
      return new ElefanteCopia(id, PecaCore.BAIXO);
    }
    public PecaCoreCopia criarElefanteParaCima(int id) {
      return new ElefanteCopia(id, PecaCore.CIMA);
    }

    public PecaCoreCopia criarGirafaParaCima(int id) {
      return new GirafaCopia(id, PecaCore.CIMA);
    }
    public PecaCoreCopia criarGirafaParaBaixo(int id) {
      return new GirafaCopia(id, PecaCore.BAIXO);
    }

    public PecaCoreCopia criarPintinhoParaCima(int id) {
      return new PintinhoCopia(id, PecaCore.CIMA);
    }
    public PecaCoreCopia criarPintinhoParaBaixo(int id) {
      return new PintinhoCopia(id, PecaCore.BAIXO);
    }

    public PecaCoreCopia criarGaloParaCima(int id) {
      return new GaloCopia(id, PecaCore.CIMA);
    }
    public PecaCoreCopia criarGaloParaBaixo(int id) {
      return new GaloCopia(id, PecaCore.BAIXO);
    }
  } 

  public class ElefanteCopia extends PecaCoreCopia {
    public ElefanteCopia(int id, int d) {
      super(id, d);
      this.nome = "ele";
    }

    public int[][] getMatrizDeMovimento() {
      int[][] movimento = {
        {-1, -1}, {1, -1}, 
        {-1, 1}, {1, 1}
      };
      return movimento;
    }
  }

  class CasaCoreCopia {
    private int x;
    private int y;
    private PecaCoreCopia peca;

    public CasaCoreCopia(CasaCoreCopia clone, JogadorCoreCopia jogadorClone) {
      this.x = clone.x;
      this.y = clone.y;
      if (jogadorClone != null) {
        this.peca = new FabricaPecaCoreCopia().criarPecaCore (clone.peca, jogadorClone);
        this.peca.setX(this.x);
        this.peca.setY(this.y);
        this.peca.setDono(jogadorClone);
      } else {
        this.peca = null;
      }
    }

    public CasaCoreCopia(int x, int y) {
      this.x = x;
      this.y = y;
    }

    public void colocarPeca(PecaCoreCopia p) {
      this.peca = p;
      this.peca.setX(this.x);
      this.peca.setY(this.y);
    }

    public int getX() {
      return this.x;
    }
    public int getY() {
      return this.y;
    }

    public boolean temPeca() {
      if (this.peca == null) {
        return false;
      } else {
        return true;
      }
    }

    public void removerPeca() {
      this.peca = null;
    }

    public PecaCoreCopia getPeca() {
      return this.peca;
    }
  }

  public class CasaCopia {
    private int x;
    private int y;
    private PecaCopia peca;

    public CasaCopia(int x, int y, PecaCopia p) {
      this.x = x;
      this.y = y;
      this.peca = p;
    }

    public int getX() {
      return this.x;
    }
    public int getY() {
      return this.y;
    }

    public boolean temPeca() {
      if (this.peca == null) {
        return false;
      } else {
        return true;
      }
    }

    public PecaCopia getPeca() {
      return this.peca;
    }
  }
}