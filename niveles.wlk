import juego.*
import wollok.game.*
import player.*
import objetosRandom.*
import enemigos.*

object nivelDesertico{
    const property velocidadDeEnemigos = 600
    const property enemigos = [     new EnemigoComunDesierto(position = game.at(7,1)),
                                    new EnemigoComunDesierto(position = game.at(13,1)),
                                    new EnemigoComunDesierto(position = game.at(18,1))]
    
    
    method suelo() = 1
    method tipoDeEnemigo() = EnemigoComunDesierto
    method positionXEscalera() = 27
    method positionYMaximaEscalera() = 7
    method siguienteNivel() = nivelHelado
    method spawnearEnemigos(){enemigos.forEach({a => game.addVisual(a)})}
}
object nivelHelado{
    const property velocidadDeEnemigos = 400
    const property enemigos = [     new EnemigoComunHelado(position = game.at(8,8)),
                                    new EnemigoComunHelado(position = game.at(14,8))]

    method tipoDeEnemigo() = EnemigoComunHelado
    method positionXEscalera() = 6
    method positionYMaximaEscalera() = 14
    method siguienteNivel() = nivelLunar
    method suelo() = 8
    method spawnearEnemigos() {enemigos.forEach({a => game.addVisual(a)})}
}
object nivelLunar{  
    method tipoDeEnemigo() {}
    method nuevoEnemigo() {}
    method siguienteNivel() {}
    method suelo() = 15
    method positionXEscalera() = 6
    method positionYMaximaEscalera() = 14
    method spawnearEnemigos(){}
}