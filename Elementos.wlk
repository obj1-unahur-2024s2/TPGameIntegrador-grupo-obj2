import juego.*
import wollok.game.*

////////////////////////////////////////////////////////Enemigos//////////////////////////////////////////////
class Enemigo{
    var position
    method position() = position
    method image()
    method estaMuerto() = false
    method colicionar(){}
    method recibirAtaque(){}
}

class EnemigoComunDesierto inherits Enemigo{
    override method image() = "escorpionR.png"
}

class EnemigoComunHelado inherits Enemigo{
    override method image() = "enemigoDeHielo.png"
}
class EnemigoComunLunar inherits Enemigo{
    override method image() = "enemigoLunar.png"
}

object enemigoFinal {
    var vida = 400
    const property damage = 30

    method vida() = vida
    method position() = game.at(20,15)
    method image() = "finalBossP1Izq.png"
    method atacar(alguien){

    }
    method recibirAtaque(poder){
        vida = 0.max(vida - poder)
    }
}

















////////////////////////////////////////////////////Jugador///////////////////////////////////////////////////////////


object jugador {
    var position = game.at(0,self.nivelActual().suelo())
    var nivelActual = nivelDesertico
    var vida = 100
    var damage = 20
    var image = "jugadorR.png"
    var estrellasRecolectadas = 0

    method estrellasRecolectadas() = estrellasRecolectadas
    method sumarEstrella() {estrellasRecolectadas += 1}

    method image() = image 
    method image(newImage) {image = newImage}
    method imagenNormal() = "jugadorR.png"
    method position() = position
    method position (newPosition) {position = newPosition}

    method pasarDeNivel(){
            nivelActual = nivelActual.siguienteNivel()
            game.say(self,"Siguiente nivel! Preparado?")
    }
    method nivelActual() = nivelActual
    method estaEnUnaEscalera() = self.position().x() == nivelActual.positionXEscalera() and self.position().y() <= nivelActual.positionYMaximaEscalera()



    method saltar() {
        if(self.position().y() == nivelActual.suelo()){
            self.subir()
            game.schedule(500,{self.bajar()})
            game.schedule(250,{self.image("jugadorJR2.png")})
            game.schedule(550,{self.imagenNormal()})
        }
    }
    method cambiarImagenCorrectaDeSalto(){
        if(image == "jugadorR.png") image = "jugadorJR1.png" else image = "jugadorJR1L.png"
        game.schedule(550, {if(image == "jugadorJR1.png") image = "jugadorR.png" else image = "jugadorL.png"})
    }
    method subir(){position = position.up(1)}
    method bajar(){position = position.down(1)}
    
    
    method comer(algo) {vida = 100.min(vida + algo.curacion())}
    method atacar(enemigo){
        if(self.position().x() - enemigo.position().x() <= 2){  
            if(self.nivelActual().enemigos().isEmpty() and self.nivelActual() == nivelLunar){
                if(enemigoFinal.vida() == 20){
                    self.cambiarAImagenCorrecta()
                    enemigoFinal.recibirAtaque(damage)
                    game.removeVisual(enemigoFinal)
                    game.addVisual(llave)
                }
                else {
                    self.cambiarAImagenCorrecta()
                    enemigoFinal.recibirAtaque(damage)
                }
            }
            else if(!enemigo.estaMuerto()){
                self.cambiarAImagenCorrecta()
                enemigo.recibirAtaque(damage)
            }
        }
    }
    method cambiarAImagenCorrecta(){
        if(image == "jugadorL.png") image = "jugadorAtaque1L.png" else image = "jugadorAtaque1R.png"
        game.schedule(300, {if(image == "jugadorAtaque1L.png") image = "jugadorL.png" else image = "jugadorR.png"})
    }
    
    method recibirAtaque(poder) {vida = 0.max(vida - enemigoFinal.damage())}
    method enemigosCorrectosQueAtacar(){
        return nivelActual.enemigos().first()
    }
    method animacionAtaque(){

    }
}














////////////////////////////Elementos Variados//////////////////////////////////////////////


object puerta{
    const position = game.at(34,15)
    method image() = "puertaCerrada2.png"
    method position() = position
    method colicionar(alguien){
        game.say(alguien,"Lo logramos!")
        game.schedule(1300, {juego.terminar()})
    }
}
//Cuando golpeamos al boss final podemos validar en cada golpe si la vida del boss es 0, y en el caso de que su vida de 0, haga el addVisual de la llave que abre la puerta.

object llave{
    const position = game.at(30,15)

    method position() = position
    method image() = "llave1.png"
    method colicionar(alguien){
        game.addVisual(puerta)
        game.removeVisual(self)
    }
}


object manzana{
    const property position = game.at(27,8)
    const property curacion = 20

    method image() = "manzana1.png"
    method colicionar(alguien){
        alguien.comer(self)
        alguien.pasarDeNivel()
        game.removeVisual(self)
    }
}

object carne{
    const property position = game.at(6,15)
    const property curacion = 20

    method image() = "frutaEspacial.png"
    method colicionar(alguien){
        alguien.comer(self)
        alguien.pasarDeNivel()
        game.removeVisual(self)
    }
}

















////////////////////////////////////////////////Niveles////////////////////////////////////////////////////


object nivelDesertico{
    const property velocidadDeEnemigos = 600
    const property enemigos = [     new EnemigoComunDesierto(position = game.at(2.randomUpTo(9),1)),
                                    new EnemigoComunDesierto(position = game.at(9.randomUpTo(15),1)),
                                    new EnemigoComunDesierto(position = game.at(15.randomUpTo(23),1))]

    method suelo() = 1
    method tipoDeEnemigo() = EnemigoComunDesierto
    method nuevoEnemigo() {new EnemigoComunDesierto(position = game.at(5,1))}
    method positionXEscalera() = 27
    method positionYMaximaEscalera() = 7
    method siguienteNivel() = nivelHelado
}
object nivelHelado{
    const property velocidadDeEnemigos = 400
    const property enemigos = [     new EnemigoComunHelado(position = game.at(24.randomUpTo(17),8)),
                                    new EnemigoComunHelado(position = game.at(17.randomUpTo(9),8)),
                                    new EnemigoComunHelado(position = game.at(10.randomUpTo(7),8))]

    method tipoDeEnemigo() = EnemigoComunHelado
    method nuevoEnemigo() {new EnemigoComunHelado(position = game.at(5,7))}
    method positionXEscalera() = 6
    method positionYMaximaEscalera() = 14
    method siguienteNivel() = nivelLunar
    method suelo() = 8
}
object nivelLunar{
    const property velocidadDeEnemigos = 200
    const property enemigos = [     new EnemigoComunLunar(position = game.at(7.randomUpTo(12),15)),
                                    new EnemigoComunLunar(position = game.at(12.randomUpTo(18),15)),
                                    new EnemigoComunLunar(position = game.at(18.randomUpTo(24),15))]

    method tipoDeEnemigo() = EnemigoComunLunar
    method nuevoEnemigo() {new EnemigoComunHelado(position = game.at(5,7))}
    method siguienteNivel() {}
    method suelo() = 15
    method positionXEscalera() = 6
    method positionYMaximaEscalera() = 14
}