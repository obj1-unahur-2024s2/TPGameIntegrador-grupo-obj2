import player.*
import juego.*
import objetosRandom.*
import niveles.*
import wollok.game.*
class Enemigo{
    var position
    var vida
    var lookAt = "right"
    var property image


    method cambiarDireccion() {lookAt = "left"}
    method vida() = vida
    method position() = position
    method colisionar(alguien){
        alguien.recibirAtaque(self.damage())
    }
    method recibirAtaque(){
        vida = 0.max(vida - jugador.damage())
        if(self.estaMuerto()){
            game.removeVisual(self)
        }
    }
    method damage() 
    method estaMuerto() = vida == 0


    method initialize() {
        game.onTick(350, "enemigo", {self.desplazarseADerecha()})
    }

    method desplazarse(){
        if(lookAt == "right"){
            self.desplazarseADerecha()
        }else{
            self.desplazarseAIzquierda()
        }
    }

    method desplazarseADerecha(){
        if(!self.estaEnLimiteRight()){
            self.moverDerecha()
        }else{

            self.desplazarseAIzquierda()
        }
    }

    method desplazarseAIzquierda(){
        if(!self.estaEnLimiteLeft()){
            self.moverIzquierda()
        }else{
            self.desplazarseADerecha()
        }
    }

    method estaEnLimiteLeft()
    method estaEnLimiteRight()
    
    // method limiteADerecha() = game.width() - 1
    // method limiteAIzquierda() = self.position().x() == 1
    // method desplazarse() {
    //     if(!self.limiteADerecha() && direccion == 1)
    //         self.moverDerecha()
    //     else if(self.limiteADerecha() && direccion == 1) {
    //         direccion = 0
    //         self.cambiarOrientacion()
    //     }    

    //     if(! self.limiteAIzquierda() && direccion == 0)
    //         self.moverIzquierda()
    //     else if(self.limiteAIzquierda() && direccion == 0) {
    //         direccion = 1
    //         self.cambiarOrientacion()
    //     }
    // }
    method moverDerecha() {
        position = position.right(1)
    }
    method moverIzquierda() {
        position = position.left(1)
    }
    method cambiarOrientacion()
    // method direccion() = direccion
   
    // method mover(unaDireccion) {
    //     unaDireccion.movimiento()
    // }
        
}

// object right {
//     method movimiento() {
//         Enemigo.position().right(1) 
//     } 
// }
// object left {
//     method movimiento() {
//         Enemigo.position().left(1)
//     }  
// }

class EnemigoComunDesierto inherits Enemigo (vida = 40, image = "escorpionR.png"){
    // override method image() = "escorpionR.png"
    override method damage() = 5
    override method estaEnLimiteLeft() = self.position().x() == 4
    override method estaEnLimiteRight() = self.position().x() == 10
    override method cambiarOrientacion() {
        if (image == "escorpionR.png")
            image = "escorpionL.png"
        else
            image = "escorpionR.png"
    }
}

class EnemigoComunHelado inherits Enemigo (vida = 60, image = "enemigoDeHieloR.png"){
    // override method image() = "enemigoDeHieloR.png"
    override method damage() = 10
    override method estaEnLimiteRight() = self.position().x() == 20
    override method estaEnLimiteLeft() = self.position().x() == 7
    override method cambiarOrientacion() {
        if (image == "enemigoDeHieloL.png")
            image = "enemigoDeHieloR.png"
        else
            image = "enemigoDeHieloL.png"
    }
}
// class EnemigoComunLunar inherits Enemigo{
//     override method image() = "enemigoLunar.png"
//     override method damage() = 15
// }

object enemigoFinal inherits Enemigo (position = game.at(20,15), vida = 100, image = "finalBossR.png")  {
    var direccionDeAtaque = null
    
    method direccionDeAtaque() = direccionDeAtaque
    override method damage() = 30
    method dirigirAtaque() {
        if (image == "finalBossR.png")
            return 1 
        else
            return 0
    }
    method atacar() {
        // const ataques = new FireBall()
        direccionDeAtaque = self.dirigirAtaque()
        game.onTick(300, "ataque", new FireBall(direccion = self.direccionDeAtaque()))
        // new FireBall(direccion = self.direccionDeAtaque())
    }
    override method estaEnLimiteRight() = self.position().x() == 22
    override method estaEnLimiteLeft() = self.position().x() == 8
    override method cambiarOrientacion() {
        if (image == "finalBossR.png")
            image = "finalBossL.png"
        else
            image = "finalBossR.png"
    }
}

// class FireBall inherits Enemigo (vida = 1000, image = "fireball.png") {
//     // method image() = "fireBall.png"
//     // override method position() = enemigoFinal.position()
//     override method damage() = 25
//     override method limiteADerecha() = self.position().x() == 0
//     override method limiteAIzquierda() = self.position().x() == game.width()
// }

class FireBall {
    var position = enemigoFinal.position()
    var property direccion

    method image() = "fireBall.png"
    method position() = position
    method damage() = 25
    method limiteADerecha() = self.position().x() > game.width() - 3
    method limiteAIzquierda() = self.position().x() < 2

    method initialize() {
        game.onTick(300, "fireBall", {self.trayectoria()})
    }
    method trayectoria() {
        if(! self.limiteADerecha() )
            self.moverDerecha()
        else
            game.removeVisual(self) 

        if(! self.limiteAIzquierda())
            self.moverIzquierda()
        else {
            game.removeVisual(self)
        }
    }
     method moverDerecha() {
        position = position.right(1)
    }
    method moverIzquierda() {
        position = position.left(1)
    }
    method cambiarOrientacion() {
        if (enemigoFinal.image() == "finalBossR.png")
            direccion == 1
        else 
            direccion == 0
    }
    method colicionar(alguien){
        alguien.recibirAtaque(self.damage())
    }
}
