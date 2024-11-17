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
        
        config.teclasDelJugador()
    }
}

object config{
    method teclasDelJugador(){
        keyboard.a().onPressDo({if(jugador.position().x() > 0 and !(jugador.estaEnUnaEscalera())){
                                    jugador.position(jugador.position().left(1))
                                    jugador.image("jugadorL.png")
                                    jugador.seMueveHacia(left)
                                    }})
        keyboard.d().onPressDo({if(jugador.position().x() < game.width() - 3 and !(jugador.estaEnUnaEscalera())){
                                     jugador.position(jugador.position().right(1))
                                     jugador.image("jugadorR.png")
                                     jugador.seMueveHacia(right)
                                     }})
        keyboard.w().onPressDo({if(jugador.estaEnUnaEscalera()) 
                                    jugador.position(jugador.position().up(1))
                                    jugador.image("jugadorUp1.png")
                                    jugador.seMueveHacia(up)
                                    })
        keyboard.s().onPressDo({if(jugador.estaEnUnaEscalera() && jugador.position().y() > 0) 
                                    jugador.position(jugador.position().down(1))
                                    jugador.image("jugadorUp2.png")
                                    jugador.seMueveHacia(down)
                                    })
        keyboard.e().onPressDo({if(jugador.position() == palanca.position() && palanca.activaciones() == 0){ 
                                    jugador.pasarDeNivel()
                                    palanca.accionar()
                                }})
        keyboard.r().onPressDo({ 
                                    jugador.atacar()
                                    
                                })
        keyboard.g().onPressDo({ 
                                    jugador.position(jugador.position().up(1))
                                    jugador.image("jugadorJR1.png")
                                })
    }
}