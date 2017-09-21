class Log{
  private String pasta;
  private ArrayList<String>entradas;
  private PrintWriter output;
  private String header;
  public Log(){
    this.pasta = "logs";
    this.entradas = new ArrayList<String>();
    this.header = "turno,equipe,estrategia,id,x inicial,y inicial, x final, y final, peca, movimento";
  }
  public void adicionar(int turno,Movimento m,JogadorCore j){
    String entrada= turno+","+j.getNomeEquipe()+","+j.getNomeEstrategia()+","+m.toString();
    this.entradas.add(entrada);
  }
  public void salvar(){
    String arquivo = this.getTimeStamp()+".log";
    this.output = createWriter(this.pasta+"/"+arquivo); 
    this.output.println(this.header);
    for(String e:entradas){
      this.output.println(e);
    }
    this.output.flush();  // Writes the remaining data to the file
    this.output.close();  // Finishes the file
   }
  
  private String getTimeStamp(){
    int dia = day(); 
    int mes = month();
    int ano = year();   
    int segundos = second();  // Values from 0 - 59
    int minutos = minute();  // Values from 0 - 59
    int hora = hour();    // Values from 0 - 23
    
    String timestamp = ""+ano;
    
    if(mes < 10){
      timestamp+="0"+mes;
    }else{
      timestamp+=mes;
    }
    
    if(dia < 10){
      timestamp+="0"+dia;
    }else{
      timestamp+=dia;
    }
    
    if(hora < 10){
      timestamp+="0"+hora;
    }else{
      timestamp+=hora;
    }
    
    if(minutos < 10){
      timestamp+="0"+minutos;
    }else{
      timestamp+=minutos;
    }
    
    if(segundos < 10){
      timestamp+="0"+segundos;
    }else{
      timestamp+=segundos;
    }
    
    return timestamp;
  }
  
}