import player.*
import juego.*
import enemigos.*
import niveles.*
import wollok.game.*


class ItemDeSalud {
    const property position
    const property image 
    method curacion()
}

class ItemDeAccion {
    const position
    const property image 
}

object puerta{
    const position = game.at(32,15)
    method image() = "portal1.png"
    method position() = position
    method colisionar(alguien){
        // game.say(cartelFinalizacion,"JUEGO TERMINADO")
        juego.terminar()
    }
}
//Cuando golpeamos al boss final podemos validar en cada golpe si la vida del boss es 0, y en el caso de que su vida de 0, haga el addVisual de la llave que abre la puerta.

object llave inherits ItemDeAccion(position = game.at(30,15), image = "llave.png"){
    // const position = game.at(30,15)

    method position() = position
    // method image() = "llave1.png"
    method colisionar(alguien){
        game.addVisual(puerta)
        game.removeVisual(self)
    }
}

object oro inherits ItemDeAccion(position = game.at(3, 15), image = "oro.png") {
    method position() = position
    method valorQueOtorga() = 1000
    method colisionar(alguien){
        alguien.sumarPuntos()
        game.removeVisual(self)
        game.removeVisual(self)
    }
}


object helado inherits ItemDeSalud (position = game.at(27,8), image = "helado.png") {
    // const property position = game.at(27,8)
    // const property curacion = 20
    override method curacion() = 20

    // method image() = "manzana1.png"
    method colisionar(alguien){
        alguien.comer(self)
        alguien.pasarDeNivel()
        game.removeVisual(self)
    }
}

object frutoEspacial inherits ItemDeSalud(position = game.at(6,15), image = "frutaEspacial.png"){
    // const property position = game.at(6,15)
    // const property curacion = 20
     override method curacion() = 50
    // method image() = "frutaEspacial.png"
    method colisionar(alguien){
        alguien.comer(self)
        alguien.pasarDeNivel()
        game.removeVisual(self)
    }
}


object cartelFinalizacion{
    method position() = game.at(11, 8)
    method image() {
        return if(jugador.vida() == 0)
            "gameOver1.png"
        else
            "win2.png"
    }
}

object stats {
    // method position() = game.at(1, game.height() - 1)
    method position() = game.center()
    method statsDelJugador() {
        game.say(self, "Jugador: " + jugador.vida())
    }
    method statsDelBoss() {
        game.say(self, "Boss: " + enemigoFinal.vida())
    }
    method statsEnemigosComunes() {}
    method text() = "Puntos: " + jugador.puntos()
}