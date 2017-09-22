import java.util.*; 

class Log{
  private String pasta;
  private ArrayList<String>entradas;
  private PrintWriter output;
  private String header;
  private String meta;
  private String timestamp;
  private boolean ligado;
  
  public Log(){
    this.pasta = "logs";
    this.meta = "";
    this.entradas = new ArrayList<String>();
    this.header = "turno,equipe,estrategia,id,x inicial,y inicial, x final, y final, peca, movimento";
    Date d = new Date(); 
    this.timestamp = d.getTime()+"";
    this.ligado = false;
    
  }
  public void adicionar(int turno,Movimento m,JogadorCore j){
    String entrada= turno+","+j.getNomeEquipe()+","+j.getNomeEstrategia()+","+m.toString();
    this.entradas.add(entrada);
  }
  public void definirIdDoGanhador(int id){
    this.meta = "ganhador,"+id;
  }
  public void salvar(){
    String arquivo = this.timestamp+".log";
    this.output = createWriter(this.pasta+"/"+arquivo); 
    this.output.println(this.meta);
    this.output.println(this.header);
    for(String e:entradas){
      this.output.println(e);
    }
    this.output.flush();  // Writes the remaining data to the file
    this.output.close();  // Finishes the file
   }
   public String getTimeStamp(){
     return this.timestamp;
   }
  
  public void ligar(){
     this.ligado = true;
   }
   public boolean estaLigado(){
     return this.ligado;
   }
  
}