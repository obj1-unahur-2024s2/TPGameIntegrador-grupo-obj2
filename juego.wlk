import wollok.game.*
import config.*
import Elementos.*

object juego {
    method iniciar() {
        game.width(37.33)
        game.height(20.66)
        game.boardGround("escenario.png")
        game.addVisual(puerta)
        game.addVisual(jugador)
        // game.addVisual(new EnemigoComunHelado(position = game.at(5,1)))
        game.addVisual(palanca)
        game.addVisual(new EnemigoComunHelado(position = game.at(10, 8)))
        game.addVisual(new EnemigoComunDesierto(position = game.at(10, 1)))
        game.addVisual(new Moneda(position = game.at(0.randomUpTo(30), nivelHelado.suelo())))
        game.addVisual(new Moneda(position = game.at(0.randomUpTo(30), nivelHelado.suelo())))
        game.addVisual(new Moneda(position = game.at(0.randomUpTo(30), nivelHelado.suelo())))
        
        config.teclasDelJugador()
    }
}

object config{
    method teclasDelJugador(){
        keyboard.a().onPressDo({if(jugador.position().x() > 0 and !(jugador.estaEnUnaEscalera())){
                                    jugador.position(jugador.position().left(1))
                                    jugador.image("jugadorL.png")
                                    }})
        keyboard.d().onPressDo({if(jugador.position().x() < game.width() - 3 and !(jugador.estaEnUnaEscalera())){
                                     jugador.position(jugador.position().right(1))
                                     jugador.image("jugadorR.png")
                                     }})
        keyboard.w().onPressDo({if(jugador.estaEnUnaEscalera()) 
                                    jugador.position(jugador.position().up(1))
                                    jugador.image()
                                    })
        keyboard.e().onPressDo({if(jugador.position() == palanca.position() && palanca.activaciones() == 0){ 
                                    jugador.pasarDeNivel()
                                    palanca.accionar()
                                }})
        keyboard.space().onPressDo({if(!jugador.estaEnUnaEscalera()) jugador.saltar()})
        keyboard.enter().onPressDo({if(!jugador.estaEnUnaEscalera()) jugador.atacar()})
    }
    method colicionesDelJugador(){
        game.onCollideDo(jugador, {a => a.colicionar(jugador)})
    }
}