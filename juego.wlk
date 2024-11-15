import wollok.game.*
import config.*
import Elementos.*

object juego {
    method iniciar() {
        game.width(37.33)
        game.height(20.66)
        game.boardGround("escenariook.png")
        game.addVisual(jugador)
        // game.addVisual(new EnemigoComunHelado(position = game.at(5,1)))
        game.addVisual(boton)
        game.addVisual(puerta)
        game.addVisual(new EnemigoComunHelado(position = game.at(10, 8)))
        config.movimientoParaElJugador()
    }
}

object config{
    method movimientoParaElJugador(){
        keyboard.a().onPressDo({if(jugador.position().x() > 0 and !(jugador.estaEnUnaEscalera())) jugador.position(jugador.position().left(1))})
        keyboard.d().onPressDo({if(jugador.position().x() < game.width() - 3 and !(jugador.estaEnUnaEscalera())) jugador.position(jugador.position().right(1))})
        keyboard.w().onPressDo({if(jugador.estaEnUnaEscalera()) jugador.position(jugador.position().up(1))})
        // keyboard.s().onPressDo({alguien.position(alguien.position().down(1))})
        game.onCollideDo(jugador, {algo => algo.colicionoConElJugador(jugador)})
    }
    
}