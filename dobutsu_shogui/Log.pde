import java.util.*; 

class LogProcessing extends Log{
  
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
}