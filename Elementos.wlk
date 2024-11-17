import juego.*
import wollok.game.*

////////////////////////////////////////////////////////Enemigos///////////////////////////////////////////////////////
class Enemigo{
    var position
    var property vida 

    // method vida(inicial) {
    //     vida = inicial
    // }
    // method vida() = vida
    method position() = position
    method image()
    method movimientoAleatorio() {
        if (self.position().x() < game.width()-1)
            self.position().x() + 1
        else
            self.position().x() - 1
    }
    method recibirDanio() {
        if ( (self.position() - jugador.position()).abs() == 1  )
            vida = vida - jugador.danioDeAtaque()
    } 
    method morir() {
        if (vida == 0)
            self.image() = "enemigoDeHieloRD.png"
    }
}

class EnemigoComunDesierto inherits Enemigo (vida = 60){
    // override method vida() = 60
    override method image() = "escorpionR.png"
    // override method movimientoAleatorio() {
    //     if (self.position().x() < game.width()-1)
    //         self.position(self.position().right()+1)
    //     else

    // }
}

class EnemigoComunHelado inherits Enemigo (vida = 80){
    // override method vida() = 80
    override method image() = "enemigoDeHieloR.png"
}
class EnemigoComunLunar inherits Enemigo (vida = 100){
    // override method vida() = 100
    override method image() = "enemigoLunar.png"
}

class EnemigoFinal inherits Enemigo (vida = 400) {
    // override method vida() = 400
    override method image() = "finalBossP1Izq.png"
}

////////////////////////////////////////////////////////Items///////////////////////////////////////////////////////
class Item {
    var position
    method postion() = position
    method image()
}

class ItemDeVida inherits Item {
    method aumentarVida() 
}

class ItemDeAccion inherits Item {
    method permitirAccion()
}

class ItemDePuntuacion inherits Item {
    method sumarPuntos()
}
class Manzana inherits ItemDeVida {
    override method aumentarVida() = 25
    override method image() = "manzana.png"
}
class Comida inherits ItemDeVida {
    override method aumentarVida() = 50
    override method image() = "comida.png"
}
class Oro inherits ItemDePuntuacion {
    override method sumarPuntos() = 100
    override method image() = "oro.png"
}
class Llave inherits ItemDeAccion {
    override method permitirAccion() {
        puerta.estado(abierta)
    } 
    override method image() = "llave.png"
}

////////////////////////////////////////////////////Jugador///////////////////////////////////////////////////////////


object jugador {
    var direccion = right
    var position = game.at(0,self.nivelActual().spawnCorrecto())
    var nivelActual = nivelDesertico
    var vida = 100
    var danioDeAtaque = 20
    var image = "jugadorR.png"
    method image() = image 
    method image(newImage) {image = newImage}

    method position() = position
    method position (newPosition) {position = newPosition}
    method pasarDeNivel(){
            nivelActual = nivelActual.siguienteNivel()
            game.say(self,"pase de nivel")
    }
    method nivelActual() = nivelActual
    method estaEnUnaEscalera() = self.position().x() == nivelActual.positionXEscalera() and self.position().y() <= nivelActual.positionYMaximaEscalera()
    method estaParaPasarDeNivel() = self.position().x() == 27 and self.position().y() == nivelActual.positionYMaximaEscalera() 
    method colicionar(){self.pasarDeNivel()}


    method direccion() = direccion
    method seMueveHacia(unaDireccion) {
        direccion = unaDireccion
    }
    method danioDeAtaque() = danioDeAtaque
    method atacar() {
        self.direccion()
        if (direccion == left) {
            self.image("jugadorAtaque1L.png")
            self.image("jugadorAtaque2L.png")
            // self.image("jugadorL.png")
        }
        else {
            self.image("jugadorAtaque1R.png")
            self.image("jugadorAtaque2R.png")
            // self.image("jugadorR.png")
        } 
        Enemigo.recibirDanio() 
        Enemigo.morir()
    } 
    method saltar(){

    }
}

object right {
    method EquivaleA() {
        jugador.image("jugadorR.png")
    }
}
object left {
    method EquivaleA() {
        jugador.image("jugadorL.png")
    }
}
object up {
    method EquivaleA() {
        jugador.image("jugadorUp1.png")
    }
}
object down {
    method EquivaleA() {
        jugador.image("jugadorUp2.png")
    }
}

object palanca {
    var apagado = true
    var property activaciones = 0
    const position = game.at(0,8)
    method image() = "palanca" + if(apagado) "Apagada.png" else "Encendida.png"
    method position() = position
    method accionar() {
            apagado = !apagado
            activaciones += 1
        }
}

object puerta{
    var property estado = cerrada
    const position = game.at(34,15)
    method image() = self.estado().image()
    method position() = position
    // method estado() = estado
}

object abierta {
    method image() = "puertaA2.png"
}

object cerrada {
    method image() = "puertaC2.png"
}

////////////////////////////////////////////////Niveles////////////////////////////////////////////////////


object nivelDesertico{
    const property velocidadDeEnemigos = 600

    method spawnCorrecto() = 1
    method tipoDeEnemigo() = EnemigoComunDesierto
    method nuevoEnemigo() {new EnemigoComunDesierto(position = game.at(5,1))}
    method nuevoItem() {new Oro(position = game.at(7,1))}
    method positionXEscalera() = 27
    method positionYMaximaEscalera() = 7
    method siguienteNivel() = nivelHelado
}
object nivelHelado{
    const property velocidadDeEnemigos = 400
    const enemigoHelado = new EnemigoComunHelado(position = game.at(1,7))
    method tipoDeEnemigo() = EnemigoComunHelado
    // method nuevoEnemigo() {new EnemigoComunHelado(position = game.at(5,7))}
    method movimientoDelEnemigo() {
        enemigoHelado.movimientoAleatorio()
    }
    method positionXEscalera() = 5
    method positionYMaximaEscalera() = 14
    method siguienteNivel() = nivelLunar
}
object nivelLunar{
    const property velocidadDeEnemigos = 200
    method tipoDeEnemigo() = EnemigoComunLunar
    method nuevoEnemigo() {new EnemigoComunHelado(position = game.at(5,7))}
    method siguienteNivel() {}
}