package ai.memoria;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.mysql.jdbc.Connection;

public class DatabaseMemoria {
	private String database;
	private String user;
	private String password;
	private Connection conn;
	public DatabaseMemoria(String db, String u, String pass){
		this.database = db;
		this.user = u;
		this.password = pass;
	}
	public void abrirConexao() throws SQLException{
		this.conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/"
				+this.database
				+"?user="+this.user
				+"&password="+this.password
		);
	}
	public void fecharConexao() throws SQLException{
		this.conn.close();
	}
	
	public ArrayList<Estado> getMovimentosPorEstado(String estado,int jogadorId) throws SQLException{
		String query = "select * from movimento_em_estado where estado=? and jogador=?";
		
		PreparedStatement stmt = conn.prepareStatement(query);
		stmt.setString(1, estado);
		stmt.setInt(2, jogadorId);
		ResultSet rs = stmt.executeQuery();
		ArrayList<Estado> estados = new ArrayList<Estado>();
		while(rs.next()){
			int x = rs.getInt("destino_x");
	        int y = rs.getInt("destino_y");
	        int v = rs.getInt("visitado");
	        int g = rs.getInt("ganhou");
	        int p = rs.getInt("perdeu");
	        String peca = rs.getString("peca_nome");
	        String origem = rs.getString("origem");
	        Estado e = new Estado();
	        e.visitado = v;
	        e.ganhou = g;
	        e.perdeu = p;
	        e.peca = peca;
	        e.id = estado;
	        e.origem = origem;
	        e.jogadorId = jogadorId;
	        e.x = x;
	        e.y = y;
	        estados.add(e);
		}
		return estados;
	}
	
	public Estado getEstadoPorChave(String estado, int jogadorId, String peca, int x, int y,String origem) throws SQLException{

		String query = "select * from movimento_em_estado where estado=?"
				+ " and jogador =?"
				+ " and peca_nome =?"
				+ " and destino_x =?"
				+ " and destino_y =?"
				+ " and origem =?"
				+ ";";
		
		PreparedStatement stmt = conn.prepareStatement(query);
		stmt.setString(1, estado);
		stmt.setInt(2, jogadorId);
		stmt.setString(3, peca);
		stmt.setInt(4,x);
		stmt.setInt(5,y);
		stmt.setString(6, origem);
		
		Estado e = null;
		ResultSet rs = stmt.executeQuery();
		if(rs.next()){
	    	int v = rs.getInt("visitado");
	        int g = rs.getInt("ganhou");
	        int p = rs.getInt("perdeu");
	        e = new Estado();
	        e.visitado = v;
	        e.ganhou = g;
	        e.perdeu = p;
	        e.peca = peca;
	        e.id = estado;
	        e.origem = origem;
	        e.jogadorId = jogadorId;
	        e.x = x;
	        e.y = y;
		};
		stmt.close();
	    return e;
	}
	
	public void atulizarEstado(String estado,int visitado, int ganhou, int perdeu, int jogadorId,String peca,int x, int y, String origem) throws SQLException{
		
		String query = "update movimento_em_estado set "
				+ "visitado=?, "
				+ "ganhou=?, "
				+ "perdeu=? "
				+ " where estado=? and "
				+ "jogador=? and "
				+ "peca_nome=? and "
				+ "destino_x=? and "
				+ "destino_y=? and "
				+ "origem=?;";
		
		PreparedStatement stmt = conn.prepareStatement(query);
		stmt.setInt(1, visitado);
		stmt.setInt(2, ganhou);
		stmt.setInt(3, perdeu);
		stmt.setString(4, estado);
		stmt.setInt(5, jogadorId);
		stmt.setString(6, peca);
		stmt.setInt(7,x);
		stmt.setInt(8,y);
		stmt.setString(9, origem);
		stmt.execute();
		stmt.close();
	}
	public void criarEstado(String estado,boolean ganhou, int jogadorId,String peca,int x, int y, String origem) throws SQLException{
		int g = 1;
		int p = 0;
		String hash = ""+estado.hashCode();
		if(ganhou == false){
			g = 0;
			p = 1;
		}
		String query = "insert into movimento_em_estado "
				+ "(estado,visitado,ganhou,perdeu, jogador, peca_nome, destino_x, destino_y, origem, hash) "
				+ "values (?,?,?,?,?,?,?,?,?,?);";
		
		PreparedStatement stmt = conn.prepareStatement(query);
		stmt.setString(1, estado);
		stmt.setInt(2, 1);
		stmt.setInt(3, g);
		stmt.setInt(4, p);
		stmt.setInt(5, jogadorId);
		stmt.setString(6, peca);
		stmt.setInt(7,x);
		stmt.setInt(8,y);
		stmt.setString(9, origem);
		stmt.setString(10, hash);
		stmt.execute();
		stmt.close();
	}
}
