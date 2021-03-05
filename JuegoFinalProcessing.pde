
import ddf.minim.*;

Minim minim;
AudioPlayer player;
AudioPlayer iniciop;

//Posiciones del coche macQueen
int x= 220;
int y = 420;

//Puntuacion
int puntuacion = 0;

//Tiempo
float tiempo = 5;

//Posiciones de las monedas
int posXmonedaIzquierda = 123;
int posXmonedaCentro = 220;
int posXmonedaDerecha = 317;
int posYmonedaIzquierda, posYmonedaCentro, posYmonedaDerecha = 0;

//Pianos de la carretera
int ladoIzquierdo = 103;
int ladoDerecho = 396;

//Controladores de escenas
boolean gameOver = false;
boolean movimiento = true;
boolean pantallaInicial = true;
boolean premio = false;

//Imagenes
PImage vehiculo; 
PImage pantallaInicio;
PImage botonInicio;
PImage titulo;
PImage pianoIz;
PImage pianoDch;
PImage moneda;
PImage copa;
PImage rayotriste;

void setup() {
  
  //Cargamos el sonido
  minim = new Minim(this);
  player = minim.loadFile("musicote.wav");
  iniciop = minim.loadFile("musicainicio.wav");

  inicio();
  size(500, 500);
}

//Metodo de la pantalla inicial
void inicio() {
  iniciop.play();
  pantallaInicio = loadImage("pantallaInicio.jpg");
  botonInicio = loadImage("start.png");
  titulo = loadImage("titulo.png");
  image(pantallaInicio, 0, 140);
  image(titulo, 0, 0);
  image(botonInicio, 10, 130);
  fill(0);
  textSize(12);
  text("Obtén una gran puntuación y serás recompensado como un campeón... :P", 35, 120);
  textSize(7);
  text("500", 10, 328);
}

void draw() {

  if (pantallaInicial) {

    inicio();
  }

  if (!pantallaInicial && !gameOver) {

    juego();
    moverMonedas();
   
  }

  if (!pantallaInicial && !gameOver && !premio) {

    juego();
    moverMonedas();
  
  }

  //Si se cumplen estas condiciones, mostramos la pantalla de gameOver
  if (gameOver && !pantallaInicial) {
    gameOver();
  }

  if (premio) {

    copaPiston();
  }

  //Funcion de pulsar el raton
  if (mousePressed) {
    if (mouseButton == LEFT) {
      pantallaInicial= false;
      gameOver = false;
      puntuacion = 0;
    }

    if (mouseButton == LEFT && pantallaInicial==false && gameOver==true) {

      gameOver = false;
      pantallaInicial = false;
    }

    if (mouseButton == LEFT && premio == true) {

      premio = false;
      gameOver = false;
      pantallaInicial = false;
    }
  }
}

void juego() {
    
  iniciop.pause();
  //cargamos la musica
  player.play();
  
  //Cargamos las imagenes
  vehiculo = loadImage("vehiculo.png");
  pianoIz = loadImage("pianoIzquierda.jpg");
  pianoDch = loadImage("pianoDerecha.jpg");
  moneda = loadImage("moneda.jpg");
  background(150, 150, 150);

  strokeWeight(0);
  image(pianoIz, 0, 0);
  
  fill(255);
  strokeWeight(10);
  line (100, 0, 100, 500);

  strokeWeight(0);
  image(pianoDch, 400, 0);

  strokeWeight(10);
  line (400, 0, 400, 500);
  strokeWeight(10);
  stroke(255);

  //Lineas carretera
  line (200, 10, 200, 100);
  line (200, 140, 200, 230);
  line (200, 270, 200, 360);
  line (200, 400, 200, 490);

  //Lineas carretera
  line (297, 10, 297, 100);
  line (297, 140, 297, 230);
  line (297, 270, 297, 360);
  line (297, 400, 297, 490);
  
  //Imagen del rayo macqueen
  image(vehiculo, x, y);
  
  //Imagenes de las monedas
  image(moneda, posXmonedaIzquierda, posYmonedaIzquierda);
  image(moneda, posXmonedaCentro, posYmonedaCentro-120);
  image(moneda, posXmonedaDerecha, posYmonedaDerecha-60);

  fill(0);
  rect(0, 0, 500, 40);
  fill(255);
  textSize(20);
  text("Puntuacion: " + puntuacion, 16, 28);

  tiempo = tiempo-0.015;
  text("Tiempo: " + nf(tiempo, 0, 0), 352, 28);

  if (tiempo <=0) {

    gameOver();
  }

  //Premio sorpresa
  if (puntuacion == 500) {

    copaPiston();
  }
}

//Metodo para movernos con nuestro coche
void keyPressed() {

  if (key == CODED) {

    if (keyCode == LEFT) {

      x = x -97;

      if (x<=123) {

        x =123;
        image(vehiculo, 123, y, 60, 60);
      } else {

        if (movimiento) {
          image(vehiculo, x, y, 60, 60);
          movimiento = false;
        }
      }
      juego();
    } else if (keyCode == RIGHT) {

      x = x +97;

      if (x>=317) {

        x =317;
        image(vehiculo, 317, y, 60, 60);
      } else {

        if (movimiento) {
          image(vehiculo, x, y, 60, 60);
          movimiento = false;
        }
      }
      juego();
    }
  } else {
    println("No puedes moverte asi");
  }
}

//Metodo para que las monedas se muevan automaticamente hacia abajo
void moverMonedas() {

  //Mover moneda de la izquierda
  if (posYmonedaIzquierda<=480) {

    posYmonedaIzquierda +=2;  

    if (puntuacion>=100) {

      posYmonedaIzquierda +=3;
    }

    if (puntuacion>=200) {

      posYmonedaIzquierda +=4;
    }
  }  

  //Mover moneda del centro
  if (posYmonedaCentro<=600) {

    posYmonedaCentro +=2;

    if (puntuacion>=100) {

      posYmonedaCentro +=3;
    }

    if (puntuacion>=200) {

      posYmonedaCentro +=4;
    }
  }  

  //Mover moneda de la derecha
  if (posYmonedaDerecha<=620) {

    posYmonedaDerecha +=2;

    if (puntuacion>=100) {

      posYmonedaDerecha +=3;
    }

    if (puntuacion>=200) {

      posYmonedaDerecha +=4;
    }
  }

  //Colision de moneda izquierda
  if ((posYmonedaIzquierda >= 368 && x == 123) || (posYmonedaIzquierda >= 368+20 && x == 123) || (posYmonedaIzquierda >= 368+30 && x == 123) || 
    (posYmonedaIzquierda >= 368+40 && x == 123) || (posYmonedaIzquierda >= 368+50 && x == 123) || (posYmonedaIzquierda >= 368+60 && x == 123) || 
    (posYmonedaIzquierda >= 368+65 && x == 123) || (posYmonedaIzquierda >= 368+70 && x == 123)) {

    posYmonedaIzquierda = 0;
    puntuacion+=10;
  }

  //Colision de moneda central
  if ((posYmonedaCentro >= 488 && x == 220) || (posYmonedaCentro >= 488+20 && x == 220) || (posYmonedaCentro >= 488+30 && x == 220) || 
    (posYmonedaCentro >= 488+40 && x == 220) || (posYmonedaCentro >= 488+50 && x == 220) || (posYmonedaCentro >= 488+60 && x == 220) || 
    (posYmonedaCentro >= 488+65 && x == 220) || (posYmonedaCentro >= 488+70 && x == 220)) {

    posYmonedaCentro = 0;
    puntuacion+=10;
  }

  //Colision de moneda derecha
  if ((posYmonedaDerecha >= 428 && x == 317) || (posYmonedaDerecha >= 428+20 && x == 317) || (posYmonedaDerecha >= 428+30 && x == 317) || 
    (posYmonedaDerecha >= 428+40 && x == 317) || (posYmonedaDerecha >= 428+50 && x == 317) || (posYmonedaDerecha >= 428+60 && x == 317) ||
    (posYmonedaDerecha >= 428+65 && x == 317) || (posYmonedaDerecha >= 428+70 && x == 317)) {

    posYmonedaDerecha = 0;
    puntuacion+=10;
  }
  
  //Reinicio de las monedas para que vuelvan a salir
  if (posYmonedaDerecha >= 620) {

    posYmonedaDerecha = 0;
  }

  if (posYmonedaCentro >= 600) {

    posYmonedaCentro = 0;
  }

  if (posYmonedaIzquierda >= 480) {

    posYmonedaIzquierda = 0;
  }
}

//Pantalla de game over
void gameOver() {
  
  player.rewind();
  background(0);
  textSize(50);
  fill(255,0,0);
  text("GAME OVER", 105, 200);
  textSize(25);
  fill(255);
  text("Puntuación: " + puntuacion, 155, 250);
  text("Click para volver a jugar", 100, 400);
  
  rayotriste = loadImage("triste.jpg");
  image(rayotriste, 200,260,100,100);
  gameOver = true;
  tiempo = 30;
}

//Pantalla de premio especial
void copaPiston() {
  
  copa = loadImage("copapiston.jpg");
  image(copa, 0, 0, 500, 500);
  premio = true;
  tiempo = 30;
}
