Jogo jogo;
public void setup(){
  size(300,400);
  Estrategia e1 = new EstrategiaAleatoria();
  Estrategia e2 = new EstrategiaAleatoria();
  jogo = new Jogo(e1,e2);
}

public void draw(){
   jogo.desenhar();
   if(jogo.continuar()){
     jogo.turno();
     delay(10);
   }
}