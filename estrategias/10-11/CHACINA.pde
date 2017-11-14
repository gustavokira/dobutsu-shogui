import java.util.ArrayList;

class EstrategiaChacina extends Estrategia { 
  public Movimento escolherMovimento(Info info, ArrayList<Movimento>movimentos) { 
    Movimento melhorMovimento = null; 
    for (Movimento m : movimentos) { 
      Casa alvo = info.getTabuleiro().getCasa(m.getX(), m.getY()); 
      if (m.getPeca().getNome().equals("leo") && m.getY() == 3) { 
        melhorMovimento = m;
      } else if (alvo.getPeca() != null) { 
        Peca p = alvo.getPeca(); 
        if (p.getNome().equals("gal")) { 
          melhorMovimento = m;
        } else if (p.getNome().equals("ele")) { 
          melhorMovimento = m;
        } else if (p.getNome().equals("pin")) { 
          melhorMovimento = m;
        } else if (p.getNome().equals("gir")) { 
          melhorMovimento = m;
        } else { 
          print("Erro 01");
        }
      } else if (melhorMovimento == null) { 
        if (m.getPeca().getNome().equals("leo") && m.getY() < m.getPeca().getY()) { 
          melhorMovimento = m;
        } else if (m.getTipo().equals(Movimento.COLOCAR)) { 
          melhorMovimento = m;
        }
      }
    } 
    if (melhorMovimento == null) { 
      melhorMovimento = movimentos.get(new Random().nextInt(movimentos.size()));
    } 
    return melhorMovimento;
  } 
  public String getNome() { 
    return "Chacina";
  } 
  public String getEquipe() { 
    return "Equipe Rocket";
  }
}