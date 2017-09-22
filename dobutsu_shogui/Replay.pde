class Replay{
   private String pasta;
   private String padrao;
   private boolean ligado;
   
   public Replay(String timestamp){
     this.padrao = timestamp+"-######.png";
     this.pasta = "replays/"+timestamp+"/";
     this.ligado = false;
   }
   public void salvarSeEstiverLigado(){
     if(this.ligado){
       saveFrame(this.pasta+this.padrao);
     }
   }
   public void ligar(){
     this.ligado = true;
   }
   public boolean estaLigado(){
     return this.ligado;
   }
}