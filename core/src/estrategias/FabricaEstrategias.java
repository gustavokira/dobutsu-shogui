package estrategias;

import core.Estrategia;

public class FabricaEstrategias {

	public static Estrategia instanciarAlemao(){
		return new EstrategiaAlemaoJava();
	}
	public static Estrategia instanciarMatar(){
		return new EstrategiaMatarJava();
	}
	public static Estrategia instanciarChacina(){
		return new EstrategiaChacinaJava();
	}
	public static Estrategia instanciarGirafaGodi(){
		return new EstrategiaGirafaGodiJava();
	}
}
