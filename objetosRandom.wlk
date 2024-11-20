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
    const property position
    const property image 
}

object portal{
    const position = game.at(32,15)
    method image() = "portal1.png"
    method position() = position
    method colisionar(alguien){
        juego.terminar()
    }
}


object llave inherits ItemDeAccion(position = game.at(30,15), image = "llave.png"){
    method colisionar(alguien){
        game.addVisual(portal)
        game.removeVisual(self)
    }
}

object oro inherits ItemDeAccion(position = game.at(3, 15), image = "oro.png") {
    method valorQueOtorga() = 1000
    method colisionar(alguien){
        alguien.sumarPuntos(self.valorQueOtorga())
        game.removeVisual(self)
        game.removeVisual(self)
    }
}


object helado inherits ItemDeSalud (position = game.at(27,8), image = "helado.png") {
    override method curacion() = 20

    method colisionar(alguien){
        alguien.comer(self)
        alguien.pasarDeNivel()
        game.removeVisual(self)
    }
}

object frutoEspacial inherits ItemDeSalud(position = game.at(6,15), image = "frutaEspacial.png"){
    override method curacion() = 50
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

object puntos {
    method position() = game.at(1,19)
    method statsDelJugador() {
        game.say(self, "Jugador: " + jugador.vida())
    }
    method statsDelBoss() {
        game.say(self, "Boss: " + enemigoFinal.vida())
    }
    method statsEnemigosComunes() {}
    method text() = "Puntos: " + jugador.puntos()
    method textColor() = "FF0000FF"
}

object puntosDeVida {
    method position() = game.at(1,20)
    method text() = "Vida: " + jugador.vida()
    method textColor() = "FF0000FF"
    method textSize() = 90
}

object pantallaDeInicio {
    method position() = game.origin()
    method image() = "ninjafondo3.png"
    method interactuar(){
        game.removeVisual(self)
    }
}