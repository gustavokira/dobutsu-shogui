Jogo jogo;

public void setup(){
  size(600,600);
  Estrategia e1 = new Estrategia();
  Estrategia e2 = new Estrategia();
  jogo = new Jogo(e1,e2);
 
}

public void draw(){
   jogo.desenhar();
   jogo.turno();
   delay(500);
}