import cartas.*
import jugador.*
object tablero{
    const mazo = []
    const mesa = []
    const jugadores = []

    method mostrarMazo() = mazo
    method mostrarMesa() = mesa

    var i = 0
    method moverDer(indice) {
        i = (indice + 1) % mesa.size() 
        return i
    }
    method moverIzq(indice) {
        i = (indice - 1 + mesa.size()) % mesa.size() 
        return i
    }

    method jugadorConTurno() = jugadores.find({j => j.turno() == 1})

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
    }

    method repartirJugadores() {
        (1..3).forEach({n => jugadores.forEach({jugador => jugador.anadirCartaMano(self.agarrarCarta())})})
    }
    
    method anadirJugadores(jugador) = jugadores.add(jugador)

    method jugada(jugador) {
            const cartasARemover = jugador.mostrarCartasAJugar()
            cartasARemover.forEach({ _carta => mesa.remove(_carta) }) 
    }

    

    method cambiarTurno() {
        const jugadorActual = self.jugadorConTurno()
        const proximoJugador = jugadores.find({ j => j != jugadorActual })
        jugadorActual.turno(0)
        proximoJugador.turno(1)
    } 
}
