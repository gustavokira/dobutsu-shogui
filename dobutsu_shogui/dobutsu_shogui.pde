Jogo jogo;

public void setup(){
  size(600,600);
  Estrategia e1 = new EstrategiaAleatoria();
  Estrategia e2 = new EstrategiaAleatoria();
  jogo = new Jogo(e1,e2);
 
}

public void draw(){
   jogo.desenhar();
   if(jogo.continuar()){
     jogo.turno();
     delay(1000);
     println("turno "+jogo.getTurno());
   }
}