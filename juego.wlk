import wollok.game.*
import config.*
import Elementos.*
object juego {
    // const property enemigosDesierto = [new EnemigoComunDesierto(position = game.at(2.randomUpTo(9),1)),
    //                           new EnemigoComunDesierto(position = game.at(9.randomUpTo(15),1)),
    //                           new EnemigoComunDesierto(position = game.at(15.randomUpTo(23),1))]
    // const property enemigosHelados = [new EnemigoComunHelado(position = game.at(24.randomUpTo(17),8)),
    //                           new EnemigoComunHelado(position = game.at(17.randomUpTo(9),8)),
    //                           new EnemigoComunHelado(position = game.at(10.randomUpTo(7),8))]
    // const property enemigosLunares = [new EnemigoComunLunar(position = game.at(7.randomUpTo(12),15)),
    //                           new EnemigoComunLunar(position = game.at(12.randomUpTo(18),15)),
    //                           new EnemigoComunLunar(position = game.at(18.randomUpTo(24),15))]
    method iniciar() {
        game.width(37.33)
        game.height(20.66)
        game.boardGround("escenario.png")
        game.addVisual(stats)
        // game.addVisual(puerta)
        game.addVisual(jugador)
        game.addVisual(llave)
        game.addVisual(helado)
        game.addVisual(frutoEspacial)
        game.addVisual(oro)
        game.addVisual(enemigoFinal)
        game.addVisual(new FireBall(direccion = enemigoFinal.direccionDeAtaque()))
        //game.addVisual(new EnemigoComunDesierto(position = game.at(10, 1)))
        // game.addVisual(new EnemigoComunHelado(position = game.at(5,1)))
        // game.addVisual(new Moneda(position = game.at(0.randomUpTo(30), nivelHelado.suelo())))
        // game.addVisual(new Moneda(position = game.at(0.randomUpTo(30), nivelHelado.suelo())))
        // game.addVisual(new Moneda(position = game.at(0.randomUpTo(30), nivelHelado.suelo())))
        
        config.teclasDelJugador()
        config.colisionesDelJugador()
        jugador.nivelActual().enemigos().forEach({a => game.addVisual(a)})
        // enemigosHelados.forEach({a => game.addVisual(a)})
        // enemigosLunares.forEach({a => game.addVisual(a)})
    }
    method terminar(){
        // game.removeVisual(jugador)
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
}