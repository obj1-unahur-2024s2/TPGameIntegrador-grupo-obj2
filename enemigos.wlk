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


    method cambiarADireccion(direccion) {lookAt = direccion}
    method vida() = vida
    method position() = position
    method colisionar(alguien){
        alguien.recibirAtaque(self.damage())
    }
    method recibirAtaque(){
        vida = 0.max(vida - jugador.damage())
        if(self.estaMuerto()){
            game.removeVisual(self)
            self.otorgarPuntos()
            self.funcionEspecial()
        }
    }
    method otorgarPuntos()
    method damage() 
    method estaMuerto() = vida == 0
    method funcionEspecial(){}


    method initialize() {
        game.onTick(350, "enemigo", {self.desplazarse()})
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
            self.cambiarOrientacion()
            self.moverDerecha()
        }else{
            self.cambiarADireccion("left")
            self.desplazarseAIzquierda()
        }
    }

    method desplazarseAIzquierda(){
        if(!self.estaEnLimiteLeft()){
            self.cambiarOrientacion()
            self.moverIzquierda()
        }else{
            self.cambiarADireccion("right")
            self.desplazarseADerecha()
        }
    }

    method estaEnLimiteLeft()
    method estaEnLimiteRight()
    method moverDerecha() {
        position = position.right(1)
    }
    method moverIzquierda() {
        position = position.left(1)
    }
    method cambiarOrientacion()
}


class EnemigoComunDesierto inherits Enemigo (vida = 40, image = "escorpionR.png"){
    override method damage() = 5
    override method estaEnLimiteLeft() = self.position().x() == 4
    override method estaEnLimiteRight() = self.position().x() == 24
    override method cambiarOrientacion() {
        if (lookAt == "left")
            image = "escorpionL.png"
        else
            image = "escorpionR.png"
    }
    override method otorgarPuntos() { jugador.sumarPuntos(150)}
}

class EnemigoComunHelado inherits Enemigo (vida = 60, image = "enemigoDeHieloR.png"){
    override method damage() = 10
    override method estaEnLimiteRight() = self.position().x() == 24
    override method estaEnLimiteLeft() = self.position().x() == 7
    override method cambiarOrientacion() {
        if (lookAt == "right")
            image = "enemigoDeHieloR.png"
        else
            image = "enemigoDeHieloL.png"
    }
    override method otorgarPuntos() {jugador.sumarPuntos(300)}
}


object enemigoFinal inherits Enemigo (position = game.at(20,15), vida = 100, image = "finalBossR.png")  {
    override method damage() = 30
    override method estaEnLimiteRight() = self.position().x() == 22
    override method estaEnLimiteLeft() = self.position().x() == 8
    override method cambiarOrientacion() {
        if (lookAt == "left")
            image = "finalBossL.png"
        else
            image = "finalBossR.png"
    }
    override method otorgarPuntos() {jugador.sumarPuntos(600)}
    override method funcionEspecial() {game.addVisual(llave)}
}