class ReplayProcessing extends Replay{

   public void salvarSeEstiverLigado(){
     if(this.ligado){
       saveFrame(this.pasta+this.padrao);
     }
   }
}