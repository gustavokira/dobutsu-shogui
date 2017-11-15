package estrategias;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Random;

import core.Estrategia;
import core.Info;
import core.Tabuleiro;
import core.Movimento;
import core.Peca;
import core.Casa;

class EstrategiaMaterialJava extends Estrategia{
 
  public Movimento escolherMovimento(Info info,ArrayList<Movimento>movimentos){
    HashMap<String,Integer> valores = new HashMap<String,Integer>();
    valores.put("leo",0);
    valores.put("gal",4);
    valores.put("gir",3);
    valores.put("ele",2);
    valores.put("pin",1);
    ArrayList<Movimento> movimentosQueValem = new ArrayList<Movimento>(); 
    for(int i =0;i<movimentos.size();i++){
      Movimento m = movimentos.get(i);
      int destinoX = m.getX();
      int destinoY = m.getY();
      Tabuleiro t = info.getTabuleiro();
      Casa destino = t.getCasa(destinoX,destinoY);
      if(destino.temPeca()){
        Peca noDestino = destino.getPeca();
        int valor1 = valores.get(m.getPeca().getNome());
        int valor2 = valores.get(noDestino.getNome());
        if(valor2 > valor1){
          movimentosQueValem.add(m);
        }
      }
    }
    if(movimentosQueValem.size() == 0){
      Random random = new Random();
	  int r = random.nextInt(movimentos.size());
      return movimentos.get(r);
    }else{
      Random random = new Random();
		int r = random.nextInt(movimentosQueValem.size());
      return movimentosQueValem.get(r);
    }
  }
  
  public String getNome(){
    return "material";
  }
  
  public String getEquipe(){
    return "ash ketchum";
  }
}