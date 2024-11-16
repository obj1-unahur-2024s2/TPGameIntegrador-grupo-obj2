import juego.*
import wollok.game.*

////////////////////////////////////////////////////////Enemigos//////////////////////////////////////////////
class Enemigo{
    var position
    method position() = position
    method image()
}

class EnemigoComunDesierto inherits Enemigo{
    override method image() = "murcielagoIzq.png"
}

class EnemigoComunHelado inherits Enemigo{
    override method image() = "enemigoDeHielo.png"
}
class EnemigoComunLunar inherits Enemigo{
    override method image() = "enemigoLunar.png"
}

class EnemigoFinal inherits Enemigo  {
    var vida = 400
    override method image() = "finalBossP1Izq.png"
}

////////////////////////////////////////////////////Jugador///////////////////////////////////////////////////////////


object jugador {
    var position = game.at(0,self.nivelActual().spawnCorrecto())
    var nivelActual = nivelDesertico
    var vida = 100
    var damage = 20
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
    method atacar(){}
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
    const position = game.at(34,15)
    method image() = "puertaCerrada2.png"
    method position() = position
}

////////////////////////////////////////////////Niveles////////////////////////////////////////////////////


object nivelDesertico{
    const property velocidadDeEnemigos = 600

    method spawnCorrecto() = 1
    method tipoDeEnemigo() = EnemigoComunDesierto
    method nuevoEnemigo() {new EnemigoComunDesierto(position = game.at(5,1))}
    method positionXEscalera() = 27
    method positionYMaximaEscalera() = 7
    method siguienteNivel() = nivelHelado
}
object nivelHelado{
    const property velocidadDeEnemigos = 400

    method tipoDeEnemigo() = EnemigoComunHelado
    method nuevoEnemigo() {new EnemigoComunHelado(position = game.at(5,7))}
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