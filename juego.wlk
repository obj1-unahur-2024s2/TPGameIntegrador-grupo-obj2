import wollok.game.*
import player.*
import niveles.*
import enemigos.*
import objetosRandom.*
object juego {
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
        nivelDesertico.spawnearEnemigos()
        nivelHelado.spawnearEnemigos()
        game.addVisual(pantallaDeInicio)

        config.teclasDelJugador()
        config.teclasDeInicio()
        config.colisionesDelJugador()
    }
    method terminar(){
        game.addVisual(cartelFinalizacion)
        game.stop()
    }
}
object config{
    var activacionesDeSonido = 0
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
        keyboard.space().onPressDo({if(!jugador.estaEnUnaEscalera()) jugador.saltar()})
        keyboard.enter().onPressDo({if(!jugador.estaEnUnaEscalera()) jugador.atacar()})
        keyboard.enter().onPressDo({if(activacionesDeSonido == 0){ 
                                        sound.playMusic()
                                        activacionesDeSonido += 1
                                    }})
        
    }
    method colisionesDelJugador(){
        game.onCollideDo(jugador, {a => a.colisionar(jugador)})
    }
    method teclasDeInicio(){
        keyboard.enter().onPressDo({pantallaDeInicio.interactuar()})
    }
}
object sound{
    const sonido = game.sound("musica1.mp3")

    method playMusic(){
        sonido.shouldLoop(true)
        game.schedule(500, {sonido.play()})
    }
}