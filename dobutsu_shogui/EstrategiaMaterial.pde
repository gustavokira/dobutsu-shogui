
class EstrategiaMaterial extends Estrategia{
 
  public Movimento escolherMovimento(Info info,ArrayList<Movimento>movimentos){
    HashMap<String,Integer> valores = new HashMap<String,Integer>();
    valores.put("leo",0);
    valores.put("gal",3);
    valores.put("gir",2);
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
      int r = int(random(movimentos.size()));
      return movimentos.get(r);
    }else{
      int r = int(random(movimentosQueValem.size()));
      return movimentos.get(r);
    }
  }
  
  public String getNome(){
    return "material";
  }
  
  public String getEquipe(){
    return "ash ketchum";
  }
}