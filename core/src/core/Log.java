package core;

import java.util.*; 

public abstract class Log{
	protected String pasta;
	protected ArrayList<String>entradas;
  protected String header;
  protected String meta;
  protected String timestamp;
  protected boolean ligado;
  
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
  public void definirEmpate(){
	    this.meta = "ganhador,0";
	  }
  
  public abstract void salvar();
  
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