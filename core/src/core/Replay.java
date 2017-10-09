package core;

public abstract class Replay{
   protected String pasta;
   protected String padrao;
   protected boolean ligado;
   
   public Replay(String timestamp){
     this.padrao = timestamp+"-######.png";
     this.pasta = "replays/"+timestamp+"/";
     this.ligado = false;
   }
   
   abstract public void salvarSeEstiverLigado();
   
   public void ligar(){
     this.ligado = true;
   }
   public boolean estaLigado(){
     return this.ligado;
   }
}