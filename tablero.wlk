import cartas.*
import jugador.*
object tablero{
    const mazo = []
    const mesa = []
    const jugadores = []

    method mostrarMazo() = mazo
    method mostrarMesa() = mesa

    method anadirCartaMesa(carta) = mesa.add(carta)
    
    method saberPuntajeMesa() = mesa.map({carta => carta.valorCarta()}).sum()
    
    method agarrarCarta() {
        if (mazo.isEmpty()) throw new Exception(message="No hay cartas en el mazo")
        const carta = mazo.anyOne()
        mazo.remove(carta)
        return carta
    }

    method llenarMazo() {
    const num = [1, 2, 3, 4, 5, 6, 7, 10, 11, 12]
    const palos = ["oro", "copa", "basto", "espada"]
    
    palos.forEach({palo => 
        num.forEach({ncarta => 
            mazo.add(new Cartas(valor = ncarta, palo = palo))})
                })
    }

    method llenarMesa() {
        (1..4).forEach({
            cartas => self.anadirCartaMesa(self.agarrarCarta())
        })
        return mesa
    }

    method repartirJugadores() {
        (1..3).forEach({n => jugadores.forEach({jugador => jugador.anadirCartaMano(self.agarrarCarta())})})
    }
    
    method anadirJugadores(jugador) = jugadores.add(jugador)

    method jugada(jugador, carta) {
        if(jugador.hayJugada(carta)) {
            const cartasARemover = jugador.mostrarCartasAJugar()
            mesa.remove([carta,cartasARemover])  
        }
        return mesa
    }
}
