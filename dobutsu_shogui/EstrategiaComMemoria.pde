import java.util.ArrayList;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.ResultSet;

import ai.memoria.DatabaseMemoria;
import ai.memoria.Estado;
import ai.Utils;

//lembra dos próprios jogos que ganhou.
class EstrategiaComMemoria extends Estrategia{
 
  public EstrategiaComMemoria(){
    super();
  }
  
  public Movimento escolherMovimento(Info info,ArrayList<Movimento>movimentos){
    return null;
  }
  
  public String infoToString(Info info){
      return Utils.infoToString(info);
    }
  
   public String getNome(){
    return "com memoria";
  }
  
  public String getEquipe(){
    return "ash ketchum";
  }
}

class MovimentoComValor extends Movimento{
  
  private Movimento original;
  private double valor;
  
  public MovimentoComValor(Movimento m,double valor){
    super(m.getPeca(),m.getX(),m.getY(),m.getTipo(),m.getJogador());
    this.valor = valor;
    this.original = m;
  }
  public double getValor(){
    return this.valor;
  }
  public Movimento getMovimentoOriginal(){
    return this.original;
  }
  public String toString(){
    return this.valor+"";
  }
}