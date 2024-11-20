import juego.*
import objetosRandom.*
import enemigos.*
import niveles.*
import wollok.game.*
object jugador {
    const property damage = 20
    var property lookAt = "right"
    var image = "jugadorR.png"
    var position = game.at(0,self.nivelActual().suelo())
    var nivelActual = nivelDesertico
    var vida = 100
    var puntos = 0

    
    method vida() = vida
    method image() = image 
    method image(newImage) {image = newImage}
    method imagenNormal() = "jugadorR.png"
    method position() = position
    method position (newPosition) {position = newPosition}

    method pasarDeNivel(){
            nivelActual = nivelActual.siguienteNivel()
    }
    method nivelActual() = nivelActual
    method estaEnUnaEscalera() = self.position().x() == nivelActual.positionXEscalera() and self.position().y() <= nivelActual.positionYMaximaEscalera()



    method saltar() {
        if(self.position().y() == nivelActual.suelo()){
            self.subir()
            self.cambiarImagenCorrectaDeSalto()
            game.schedule(500,{self.bajar()})
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
    method sumarPuntos(cantidad) {puntos += cantidad}
    method puntos() = puntos


    method atacar(){
        if(lookAt == "right"){
            if(!game.getObjectsIn(position.right(2)).isEmpty() ){
                const enemigo = game.getObjectsIn(position.right(2)).first()
                enemigo.recibirAtaque()
            }
            self.cambiarAImagenCorrectaAtaque()
        }
        else{
            if(!game.getObjectsIn(position.left(2)).isEmpty()){
                const enemigo = game.getObjectsIn(position.left(2)).first()
                enemigo.recibirAtaque()
            }
            self.cambiarAImagenCorrectaAtaque()
        }
    }


    method cambiarAImagenCorrectaAtaque(){
        if(lookAt == "left"){
            image = "jugadorAtaque1L.png" 
        }else{ 
            image = "jugadorAtaque1R.png"
        }
        game.schedule(300, {if(image == "jugadorAtaque1L.png") image = "jugadorL.png" else image = "jugadorR.png"})
    }

    
    method recibirAtaque(poder) {
        vida = 0.max(vida - poder)

        if ( vida > 0 && image == "jugadorR.png")
            image = "jugadorDR.png"
        else if(vida > 0 && image == "jugadorL.png")
            image = "jugadorDL.png"
        else if(vida == 0 && image == "jugadorR.png"){
            image = "jugadorMR1.png"
            self.morir()
        }
        else if(vida == 0 && image == "jugadorL.png"){
            image = "jugadorML1.png"
            self.morir()
        }
        game.schedule(300, {if(image == "jugadorDR.png") image = "jugadorR.png" else image = "jugadorL.png"})
    }
    
    
    method morir() {
        if(self.lookAt()=="rigth")
            image = "jugadorMR2.png"
        else
            image = "jugadorML2.png"
        juego.terminar()
    } 
}