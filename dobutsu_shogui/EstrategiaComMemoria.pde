import java.util.ArrayList;

//lembra dos próprios jogos que ganhou.
class EstrategiaComMemoriaPropria extends Estrategia{
 
  JSONArray json;
  HashMap<String,Integer> historico;
  HashMap<String,JSONObject> memoria;
  int meuId;
  int turno;
  String arquivo = "estrategia-data/memoria-propria.json";
  
  public EstrategiaComMemoriaPropria(){
    super();
    turno = 0;
    historico = new HashMap<String,Integer>();
    memoria = new HashMap<String,JSONObject>();
    
    File file =new File(sketchPath(arquivo));
    
    if(file.exists()){
      this.json = loadJSONArray(arquivo);
  
      for (int i = 0; i < this.json.size(); i++) {
        
        JSONObject j = this.json.getJSONObject(i);  
        String id = j.getString("id");
    
        this.memoria.put(id,j);
      }
    }
    
  }
  
  public Movimento escolherMovimento(Info info,ArrayList<Movimento>movimentos){
    this.meuId = info.getEu().getId();
    Movimento m = null;
    double valorAtual = 0;
    for(Movimento opcao:movimentos){
      String s = opcao.toString();
      if(this.memoria.containsKey(s)){
        if(m == null){
          m = opcao;
          valorAtual = this.memoria.get(s).getDouble("value");
        }else if(valorAtual < this.memoria.get(s).getDouble("value")){
          m = opcao;
          valorAtual = this.memoria.get(s).getDouble("value");
        }
      }
    }
    
    if(m == null){
      int r = int(random(movimentos.size()));
      m = movimentos.get(r);
    }

    
    String s = m.toString(); 
    historico.put(s,turno);
    this.turno++;
    return m;
  }
  
  public String getNome(){
    return "com memoria";
  }
  
  public String getEquipe(){
    return "ash ketchum";
  }
  
  public void terminar(int idGanhador){
    
    if(this.json == null){
      this.json = new JSONArray();
    }
    
    if(idGanhador == meuId){
      
      for(String id:this.memoria.keySet()){
        JSONObject j = this.memoria.get(id);
        
        if(this.historico.containsKey(id)){
            double d = (double)this.historico.get(id)/this.turno;
            int qty = j.getInt("qty")+1;
            double value = (j.getDouble("value")+d)/(qty);
            j.setDouble("value",value);
            j.setInt("qty",qty);
        }
      }
      
      for(String id:this.historico.keySet()){
        JSONObject j = this.memoria.get(id);
        double d = (double)this.historico.get(id)/this.turno;
        if(j == null){
          j = new JSONObject();
          j.setString("id",id);
          j.setDouble("value",d);
          j.setInt("qty",1);
          this.json.append(j);
        }
      }
          
      saveJSONArray(json, this.arquivo);
    }
  }
}