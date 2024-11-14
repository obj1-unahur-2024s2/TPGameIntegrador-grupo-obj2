class Personaje {
     const property especialidad 
     var vida
     var nivel = 1

     method recibirDanio() {
         if (nivel == 1) {
             self.perderVida(1)
         }else {
             nivel = nivel - 1
         }
     }
     method perderVida(cantidad) {vida = 0.max(vida - cantidad)}
 }

class Caballero {
  
}

class Arquero {
  
}

class Mago {

}

object aprendiz {
    var property position = game.center()

    method image() = "aprendiz.png" 
    method position() = position
    method position (nueva) {
        position = nueva
    }
    method recibirDanio() {}
    method recibirBeneficio(){}
}
