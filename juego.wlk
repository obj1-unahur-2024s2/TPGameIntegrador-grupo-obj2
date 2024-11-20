import wollok.game.*
import player.*
import niveles.*
import enemigos.*
import objetosRandom.*
object juego {
    method pantallaInicial(){
        game.width(37.33)
        game.height(20.66)
        game.boardGround("fondoDeInicio.png")
        config.teclasDeInicio()
    }


    method iniciar() {
        game.width(37.33)
        game.height(20.66)
        game.boardGround("escenario.png")
        game.addVisual(jugador)
        game.addVisual(helado)
        game.addVisual(frutoEspacial)
        game.addVisual(oro)
        game.addVisual(enemigoFinal)
        game.addVisual(puntos)
        game.addVisual(puntosDeVida)
        
        config.teclasDelJugador()
        config.colisionesDelJugador()
        nivelDesertico.spawnearEnemigos()
        nivelHelado.spawnearEnemigos()
    }
    method terminar(){
        game.addVisual(cartelFinalizacion)
        game.stop()
    }
}

object config{
    method teclasDelJugador(){
        keyboard.a().onPressDo({if(jugador.position().x() > 0 and !(jugador.estaEnUnaEscalera())){
                                    jugador.position(jugador.position().left(1))
                                    jugador.image("jugadorL.png")
                                    jugador.lookAt("left")
                                    }})
        keyboard.d().onPressDo({if(jugador.position().x() < game.width() - 3 and !(jugador.estaEnUnaEscalera())){
                                     jugador.position(jugador.position().right(1))
                                     jugador.image("jugadorR.png")
                                     jugador.lookAt("right")
                                     }})
        keyboard.w().onPressDo({if(jugador.estaEnUnaEscalera()) 
                                    jugador.position(jugador.position().up(1))
                                    jugador.image("jugadorUp1.png")
                                    })
        // keyboard.e().onPressDo({if(jugador.position() == palanca.position() && palanca.activaciones() == 0){ 
        //                             jugador.pasarDeNivel()
        //                             palanca.accionar()
        //                         }})
        keyboard.space().onPressDo({if(!jugador.estaEnUnaEscalera()) jugador.saltar()})
        keyboard.enter().onPressDo({if(!jugador.estaEnUnaEscalera()) jugador.atacar()})
    }
    method colisionesDelJugador(){
        game.onCollideDo(jugador, {a => a.colisionar(jugador)})
    }
    method musica(){

    }
    method teclasDeInicio(){
        keyboard.enter().onPressDo({})
    }
}