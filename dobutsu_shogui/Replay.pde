class Replay{
   private String pasta;
   private String padrao;
   
   public Replay(String timestamp){
     this.padrao = timestamp+"-######.png";
     this.pasta = "replays/"+timestamp+"/";
   }
   public void salvar(){
     saveFrame(this.pasta+this.padrao); 
   }
}