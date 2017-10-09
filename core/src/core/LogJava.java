package core;

import java.io.BufferedWriter;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;

public class LogJava extends Log{

	Writer writer = null;
	private String arquivo;
	
	@Override
	public void salvar() {
		try {
			
			this.arquivo = this.timestamp+".log";
		    String saida = this.meta+"\n"+this.header+"\n";
			
		    for(String e:entradas){
		      saida+=e+"\n";
		    }
			
		    writer = new BufferedWriter(new OutputStreamWriter(
		          new FileOutputStream(this.pasta+"/"+arquivo), "utf-8"));
		    writer.write(saida);
		} catch (IOException ex) {
		  // report
		} finally {
		   try {writer.close();} catch (Exception ex) {/*ignore*/}
		}
	}

}
