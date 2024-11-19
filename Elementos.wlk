import juego.*
import wollok.game.*

////////////////////////////////////////////////////////Enemigos//////////////////////////////////////////////
class Enemigo{
    var position
    var vida
    var direccion = 1
    var property image

    method vida() = vida
    method position() = position
    method colisionar(alguien){
        alguien.recibirAtaque(self.damage())
    }
    method recibirAtaque(){
        vida = 0.max(vida - jugador.damage())
        if(self.estaMuerto()){
            game.removeVisual(self)
        }
    }
    method damage() 
    method estaMuerto() = vida == 0


    method initialize() {
        game.onTick(300, "enemigo", {self.desplazarse()})
    }
    
    method limiteADerecha() = game.width() - 1
    method limiteAIzquierda() = self.position().x() == 1
    method desplazarse() {
        if(! self.limiteADerecha() && direccion == 1)
            self.moverDerecha()
        else if(self.limiteADerecha() && direccion == 1) {
            direccion = 0
            self.cambiarOrientacion()
        }    

        if(! self.limiteAIzquierda() && direccion == 0)
            self.moverIzquierda()
        else if(self.limiteAIzquierda() && direccion == 0) {
            direccion = 1
            self.cambiarOrientacion()
        }
    }
    method moverDerecha() {
        position = position.right(1)
    }
    method moverIzquierda() {
        position = position.left(1)
    }
    method cambiarOrientacion()
    // method direccion() = direccion
   
    // method mover(unaDireccion) {
    //     unaDireccion.movimiento()
    // }
        
}

// object right {
//     method movimiento() {
//         Enemigo.position().right(1) 
//     } 
// }
// object left {
//     method movimiento() {
//         Enemigo.position().left(1)
//     }  
// }

class EnemigoComunDesierto inherits Enemigo (vida = 40, image = "escorpionR.png"){
    // override method image() = "escorpionR.png"
    override method damage() = 5
    override method limiteADerecha() = self.position().x() > game.width() - 3
    override method limiteAIzquierda() = self.position().x() < 1
    override method cambiarOrientacion() {
        if (image == "escorpionR.png")
            image = "escorpionL.png"
        else
            image = "escorpionR.png"
    }
}

class EnemigoComunHelado inherits Enemigo (vida = 60, image = "enemigoDeHieloR.png"){
    // override method image() = "enemigoDeHieloR.png"
    override method damage() = 10
    override method limiteADerecha() = self.position().x() == 20
    override method limiteAIzquierda() = self.position().x() == 1
    override method cambiarOrientacion() {
        if (image == "enemigoDeHieloL.png")
            image = "enemigoDeHieloR.png"
        else
            image = "enemigoDeHieloL.png"
    }
}
// class EnemigoComunLunar inherits Enemigo{
//     override method image() = "enemigoLunar.png"
//     override method damage() = 15
// }

object enemigoFinal inherits Enemigo (position = game.at(20,15), vida = 400, image = "finalBossR.png")  {
    override method damage() = 30
    override method limiteADerecha() = self.position().x() == 22
    override method limiteAIzquierda() = self.position().x() == 8
    override method cambiarOrientacion() {
        if (image == "finalBossR.png")
            image = "finalBossL.png"
        else
            image = "finalBossR.png"
    }
}

















////////////////////////////////////////////////////Jugador///////////////////////////////////////////////////////////


object jugador {
    var position = game.at(0,self.nivelActual().suelo())
    var nivelActual = nivelDesertico
    var vida = 100
    const property damage = 20
    var image = "jugadorR.png"
    var estrellasRecolectadas = 0
    var property lookAt = "right"

    method estrellasRecolectadas() = estrellasRecolectadas
    method sumarEstrella() {estrellasRecolectadas += 1}
    method vida() = vida

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
            self.cambiarImagenCorrectaDeSalto()
            game.schedule(500,{self.bajar()})
            // game.schedule(250,{self.image("jugadorJR2.png")})
        }
    }
    method cambiarImagenCorrectaDeSalto(){
        if(image == "jugadorR.png") image = "jugadorJR1.png" else image = "jugadorJR1L.png"
        game.schedule(550, {if(image == "jugadorJR1.png") image = "jugadorR.png" else image = "jugadorL.png"})
    }
    method subir(){position = position.up(1)}
    method bajar(){position = position.down(1)}
    
    //getObjectIn()
    
    method comer(algo) {vida = 100.min(vida + algo.curacion())}
   

    method colisionar(algo) {}

    // method atacar(enemigo){
    //     if(self.position().x() - enemigo.position().x() <= 2){  
    //         self.pelearConJefeFinalSiDebe()
    //         if(!enemigo.estaMuerto()){
    //             self.cambiarAImagenCorrecta()
    //             enemigo.recibirAtaque(damage)
    //         }
    //         else{
    //             nivelActual.enemigos().remove(nivelActual.enemigos().first())
    //         }
    //     }
    // }

    method atacar(){
        if(lookAt == "right"){
            if(!game.getObjectsIn(position.right(1)).isEmpty() ){
                const enemigo = game.getObjectsIn(position.right(1)).first()
                enemigo.recibirAtaque()
            }
            self.cambiarAImagenCorrectaAtaque()
        }
        else{
            if(!game.getObjectsIn(position.left(1)).isEmpty() ){
                const enemigo = game.getObjectsIn(position.left(1)).first()
                enemigo.recibirAtaque()
            }
            self.cambiarAImagenCorrectaAtaque()
        }
    }





    method cambiarAImagenCorrectaAtaque(){
        if(image == "jugadorL.png") image = "jugadorAtaque1L.png" else image = "jugadorAtaque1R.png"
        game.schedule(300, {if(image == "jugadorAtaque1L.png") image = "jugadorL.png" else image = "jugadorR.png"})
    }

    method pelearConEnemigoSiHay(enemigo){
        if(!enemigo.estaMuerto()){
                self.cambiarAImagenCorrectaAtaque()
                enemigo.recibirAtaque(damage)
            }
            else{
                nivelActual.enemigos().remove(nivelActual.enemigos().first())
            }
    }

    // method pelearConJefeFinalSiDebe(){
    //     if(self.nivelActual().enemigos().isEmpty() and self.nivelActual() == nivelLunar){
    //             if(enemigoFinal.vida() == 20){
    //                 self.cambiarAImagenCorrectaAtaque()
    //                 enemigoFinal.recibirAtaque(damage)
    //                 game.removeVisual(enemigoFinal)
    //                 game.addVisual(llave)
    //             }
    //             else {
    //                 self.cambiarAImagenCorrectaAtaque()
    //                 enemigoFinal.recibirAtaque(damage)
    //             }
    //         }
    // }
    
    method recibirAtaque(poder) {
        vida = 0.max(vida - poder)
        if ( vida > 0 && self.lookAt()=="rigth")
            image = "jugadorDR"
        else if(vida > 0 && self.lookAt()=="left" )
            image = "jugadorDR"
        else if(vida == 0 && self.lookAt()=="rigth"){
            image = "jugadorMR1"
            self.morir()
        }
        else {
            image = "jugadorML1"
            self.morir()
        }
    }
    method morir() {
        juego.terminar()
    } 
    // method recibirAtaque(poder) {vida = 0.max(vida - enemigoFinal.damage())}
    method enemigosCorrectosQueAtacar(){
        return nivelActual.enemigos().first()
    }
    method animacionAtaque(){

    }
}














////////////////////////////Elementos Variados//////////////////////////////////////////////

class ItemDeSalud {
    const property position
    const property image 
    method curacion()
}

class ItemDeAccion {
    const position
    const property image 
}

object puerta{
    const position = game.at(32,15)
    method image() = "portal1.png"
    method position() = position
    method colisionar(alguien){
        // game.say(cartelFinalizacion,"JUEGO TERMINADO")
        juego.terminar()
    }
}
//Cuando golpeamos al boss final podemos validar en cada golpe si la vida del boss es 0, y en el caso de que su vida de 0, haga el addVisual de la llave que abre la puerta.

object llave inherits ItemDeAccion(position = game.at(30,15), image = "llave1.png"){
    // const position = game.at(30,15)

    method position() = position
    // method image() = "llave1.png"
    method colisionar(alguien){
        game.addVisual(puerta)
        game.removeVisual(self)
    }
}


object helado inherits ItemDeSalud (position = game.at(27,8), image = "helado.png") {
    // const property position = game.at(27,8)
    // const property curacion = 20
    override method curacion() = 20

    // method image() = "manzana1.png"
    method colisionar(alguien){
        alguien.comer(self)
        alguien.pasarDeNivel()
        game.removeVisual(self)
    }
}

object frutoEspacial inherits ItemDeSalud(position = game.at(6,15), image = "frutaEspacial.png"){
    // const property position = game.at(6,15)
    // const property curacion = 20
     override method curacion() = 50
    // method image() = "frutaEspacial.png"
    method colisionar(alguien){
        alguien.comer(self)
        alguien.pasarDeNivel()
        game.removeVisual(self)
    }
}


object cartelFinalizacion{
    method position() = game.center()
    method image() {
        return if(jugador.vida() == 0)
            "gameOver.png"
        else
            "win.png"
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
    // method nuevoEnemigo() {new EnemigoComunDesierto(position = game.at(5,1))}
    method positionXEscalera() = 27
    method positionYMaximaEscalera() = 7
    method siguienteNivel() = nivelHelado
    method activarEnemigos() {
        enemigos.forEach({e => e.moverseAleatoriamente()})
    }
}
object nivelHelado{
    const property velocidadDeEnemigos = 400
    const property enemigos = [     new EnemigoComunHelado(position = game.at(24.randomUpTo(17),8)),
                                    new EnemigoComunHelado(position = game.at(17.randomUpTo(9),8)),
                                    new EnemigoComunHelado(position = game.at(10.randomUpTo(7),8))]

    method tipoDeEnemigo() = EnemigoComunHelado
    // method nuevoEnemigo() {new EnemigoComunHelado(position = game.at(5,7))}
    method positionXEscalera() = 6
    method positionYMaximaEscalera() = 14
    method siguienteNivel() = nivelLunar
    method suelo() = 8
}
object nivelLunar{
    const property velocidadDeEnemigos = 200
    // const property enemigos = [     new EnemigoComunLunar(position = game.at(vida = 40,7.randomUpTo(12),15)),
    //                                 new EnemigoComunLunar(position = game.at(12.randomUpTo(18),15)),
    //                                 new EnemigoComunLunar(position = game.at(18.randomUpTo(24),15))]

    method tipoDeEnemigo() {}
    method nuevoEnemigo() {}
    method siguienteNivel() {}
    method suelo() = 15
    method positionXEscalera() = 6
    method positionYMaximaEscalera() = 14
}