import wollok.game.*
import config.*

object juego {
    const property enemigos = []
    method iniciar() {
        


        game.width(37.33)
        game.height(20.66)
        game.boardGround("escenario.png")
        game.addVisual(jugador)
        
        game.onTick(10000, "Agregar enemigo", self.sumarEnemigoALaLista())
        game.on
        
        

        // game.onCollideDo(jugador, {obstaculo => enemigoFinal.colisionasteConJugador()})
        game.addVisual(enemigoFinal)
    }
    method sumarEnemigoALaLista() {
            if (enemigos.size() < 5) 
                enemigos.add(new enemigoFinal(position = game.at(0.randomUp(game.width()-1), 1)))
            else
                game.removeTickEvent("Agregar enemigo")
    }
}

class Enemigo{
    var position = null

    method initialize(){
        position = juego.posicionAleatoria()
        game.addVisual(self)
    }
    method image()
}

class enemigoFinal inherits Enemigo  {
    var vida = 400

    override method image( ) = "finalBossP1Izq.png"
}


object jugador {
    var property position = game.center()

    method image() = "jugador.png" 
    method position() = position
    method position (nueva) {
        position = nueva
    }
}