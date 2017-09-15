class Peca{
  private int x;
  private int y;
  private int largura;
  private int altura;
  private int direcao;
  protected PImage img;
  protected Jogador dono;
  
  public static final int CIMA = -1;
  public static final int BAIXO = 1;
  
  public Peca(int d){
    this.direcao = d;
    this.largura = 80;
    this.altura = 80;
  }
  
  
  
  public int getX(){
    return this.x;
  }
  
  public int getY(){
    return this.y;
  }
  public void setX(int x){
    this.x = x;
  }
  
  public void setY(int y){
    this.y = y;
  } 
  
  public PImage getImage(){
    return this.img;
  }
  
  public void desenhar(int offx, int offy){
    //if(this.direcao == Peca.BAIXO){
    //  pushMatrix();
    //  translate(offx,offy);
    //  rotate(PI);
    //  image(this.img, offx, offy,this.largura, this.altura);
    //  popMatrix();
    //}else{
        image(this.img, offx, offy,this.largura, this.altura);
    //}

  }

}