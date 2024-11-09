import wollok.game.*

object juego {
    method iniciar() {

        game.width(37.33)
        game.height(20.66)
        game.boardGround("stage.png")
        game.addVisualCharacter(aprendiz)
        game.onCollideDo(aprendiz, {obstaculo => obstaculo.colisionasteConAprenzdiz()})
        game.schedule(20000, {game.removeTickEvent("muestra obstaculo")})

        self.generarObstaculos()
        self.generarItems()
    }
    method generarObstaculos() {
        game.onTick(1000, "muestra obstaculo", {new Obstaculo().mostrar()})
    }
    method generarItems() {
        game.schedule(500, {self.generarItem()})
    }
    method generarItem() {
        const pos = self.posicionAleatoria()
        const item = new Item(position = pos)
        game.addVisual(item)
    }
    method posicionAleatoria() = game.at(0.randomUpTo(game.width()), 0.randomUpTo(game.height()))
    // method generarFinalBoss() {
    //     game.
    // }

}

class Obstaculo{
    var position = null

    method colisionasteConAprenzdiz(){
         aprendiz.recibirDanio()
    }
    method mostrar() {
        position = juego.posicionAleatoria()
        game.addVisual(self)
        self.moverseAleatoriamente()
    }
    method moverseAleatoriamente(){}
    method position() = position
    method image() = "obstaculo.png"
}
// class Obstaculo {
//     const property position
//     method colisionasteConAprenzdiz(){
//         aprendiz.recibirDanio()
//     }
// }

 class Item {
    var image = "item.png"
    const position

    method colisionasteConAprenzdiz(){
         aprendiz.recibirBeneficio()
    }
    method image() = image
    method position() = position 
 }

// class Personaje {
//     const property especialidad 
//     var property vida
//     var nivel = 1

//     method recibirDanio() {
//         if (nivel == 1) {
//             vida = 0.max(vida - 1)
//         }else {
//             nivel = nivel - 1
//         }
//     }
// }

// class Caballero {
  
// }

// class Arquero {
  
// }

// class Mago {

// }

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