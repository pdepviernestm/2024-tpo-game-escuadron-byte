import cartas.*
import jugador.*
object tablero{
    const mazo = []
    const mesa = []

    method anadirCartaMesa(carta) = mesa.add(carta)
    
    method saberPuntajeMesa() = mesa.map({carta => carta.valorCarta()}).sum()
    
    method agarrarCarta() {
        if (mazo.isEmpty()) throw new DomainException (message = "El mazo esta vacio")
        const carta = mazo.anyOne()
        mazo.remove(carta)
        return carta
    }

    method llenarMazoPalo() {
    const num = [1, 2, 3, 4, 5, 6, 7, 10, 11, 12]
    const palos = ["oro", "copa", "basto", "espada"]
    
    palos.forEach({palo => 
        num.forEach({ncarta => 
            mazo.add(new Cartas(valor = ncarta, palo = palo))
        })
    })
}

    method llenarMesa() {
        (1..4).forEach({
            _ => if(!mazo.isEmpty()){ 
                const carta = self.agarrarCarta()
                self.anadirCartaMesa(carta)
                }
        })
        return mesa
    }
}