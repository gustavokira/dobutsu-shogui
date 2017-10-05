class ReplayProcessing extends Replay{

   public ReplayProcessing(String timestamp){
     super(timestamp);
   }
  
   public void salvarSeEstiverLigado(){
     if(this.ligado){
       saveFrame(this.pasta+this.padrao);
     }
   }
}