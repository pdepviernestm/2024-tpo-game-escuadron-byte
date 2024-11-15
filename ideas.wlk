
class Jugador {
    const manojugador = [] 
    const montojugador = []
    const cartasLevantadas = []
    const mano = false
    var puntaje = 0
    var escobas = 0

    method mostrarManoJugador() = manojugador
    method mostrarMontoJugador() = montojugador 
    method cantidadMontoJugador() = montojugador.size()
    method cantidadManoJugador() = manojugador.size()
    method anadirCartaMonto(carta) = montojugador.add(carta)
    method anadirVariasCartasMonto(cartas) = montojugador.addAll(cartas)
    method eliminarCartaMano(carta) = manojugador.remove(carta)
    method anadirCartaMano(carta) = manojugador.add(carta)
    method puntajeJugador() = puntaje
    method detectarMano() = mano
    method limpiarCartasLevantadas() = cartasLevantadas.clear()
    method mostrarCartasLevantadas() = cartasLevantadas
    method anadirCartasLevantadas(carta) = cartasLevantadas.add(carta)
    method cantidadEscobas() = escobas
    method sumarPuntaje() {puntaje += 1}
    method resetearEscobas() { escobas = 0 }

    method tirarCarta(carta) {
        self.eliminarCartaMano(carta)
        tablero.anadirCartaMesa(carta)
    }

    method levantarCarta(carta) {
        if (tablero.mostrarMesa().any({_carta => {_carta.paloCarta() == carta.paloCarta() && _carta.valorCarta() == carta.valorCarta()}})) {
            self.anadirCartasLevantadas(carta)
            tablero.eliminarCartaMesa(carta)
        }
    }

    method hayEscobadeMano() {
        if (self.detectarMano()) {
            self.anadirVariasCartasMonto(tablero.mostrarMesa())
            tablero.limpiarMesa()
            escobas = escobas + 1  // Incrementar escobas
        }
    }

    method tengoMayorCantidadCartas() = (self.cantidadMontoJugador() > 20)
    method tengo7deVelo() = (montojugador.any({carta => carta.valorCarta() == 7 && carta.paloCarta() == "oro"}))

    method tengoMayorCantidadOros() {
        if (montojugador.any({carta => carta.paloCarta() == "oro"})) {
            (montojugador.filter({carta => carta.paloCarta() == "oro"}).size() > 5)
        }
    }

    method tengoTodosOros() {
        if (montojugador.any({carta => carta.paloCarta() == "oro"})) {
            (montojugador.filter({carta => carta.paloCarta() == "oro"}).size() == 10)                   
        }
    }

    method tengoSetenta() {
        if (montojugador.any({carta => carta.valorCarta() == 7})) {
            (montojugador.filter({carta => carta.valorCarta() == 7}).size() > 2)        
        }
    }

    method hayJugada(carta) = (carta.valorCarta() + cartasLevantadas.map({x => x.valorCarta()}).sum() == 15)

    method tengoCarta(carta) = (manojugador.any({ccarta => ccarta.valorCarta() == carta.valorCarta() && ccarta.paloCarta() == carta.paloCarta()}))

method verificarJugada(carta) {
    if (!self.tengoCarta(carta)) {
        return false
    }
    
    if (self.hayJugada(carta)) {
        return true
    }
    
    tablero.anadirCartaMesa(cartasLevantadas)
    self.limpiarCartasLevantadas()
    return false
}

    method jugada(carta) {
        if (self.detectarMano()) {
            if (self.tengoCarta(carta)) {
                if (self.verificarJugada(carta)) {
                    self.anadirCartaMonto(carta)
                    self.anadirVariasCartasMonto(cartasLevantadas)
                    self.limpiarCartasLevantadas()
                    self.eliminarCartaMano(carta)
                    escobas = escobas + 1
                    tablero.hacerMano()
                }
            }
        }
    }

    method levantarCartasAlTerminarRonda() {
        if (self.detectarMano()) {
            self.anadirVariasCartasMonto(tablero.mostrarMesa())
            tablero.limpiarMesa()
        }
    }
}

class Cartas {
    const valor 
    const palo
    method valorCarta() = valor
    method paloCarta() = palo
    method image() = ""
} 

// Falta: eliminar repetición línea 48, valor de cartas 10, 11, 12
object tablero {
    const mazo = []
    const jugadores = []
    const mesa = []
    var cartasarepartir = []

    method limpiarMesa() = mesa.clear()
    method limpiarMazo() = mazo.clear()
    method eliminarCartaMesa(carta) = mesa.remove(carta)
    method eliminarCartaMazo(carta) = mazo.remove(carta)
    method cantidadMazo() = mazo.size()
    method cantidadMesa() = mesa.size()
    method cantidadJugadores() = jugadores.size()
    method mostrarMazo() = mazo
    method mostrarMesa() = mesa 
    method mostrarJugadores() = jugadores
    method conocerMano() = jugadores.find({jugador => jugador.detectarMano()})
    method ponerCartaMazo(carta) = mazo.add(carta) // método para caso de prueba
    method anadirCartaMesa(carta) = mesa.add(carta)

    method verificarEscobadeMano() = (self.saberPuntajeMesa() == 15)
    method saberPuntajeMesa() = mesa.map({carta => carta.valorCarta()}).sum()

    method hacerMano() = jugadores.forEach({jugador => jugador.convertirMano()})
    method anadirJugadores(jugador) = jugadores.add(jugador)

    method agarrarCarta() {
        cartasarepartir = mazo.anyOne()
        mazo.remove(cartasarepartir)
        return cartasarepartir
    }

    method repartirJugadores() {
        (1..3).forEach({cartas => jugadores.forEach({jugador => jugador.anadirCartaMano(self.agarrarCarta())})})
    }
   
     method llenarMesa() {
        const cartasRepartidas = []
        (1..4).forEach({
            cartas => self.anadirCartaMesa(self.agarrarCarta())
            cartasRepartidas.add(cartas)
        })
        if (self.verificarEscobadeMano()) {
            jugadores.filter({jugador => jugador.hayEscobadeMano()})
        }
        return cartasRepartidas
    } 

     method llenarMazo() {
        const num = [1, 2, 3, 4, 5, 6, 7, 10, 11, 12]
        num.forEach({ncarta => mazo.add(new Cartas(valor = ncarta, palo = "oro"))})
        num.forEach({ncarta => mazo.add(new Cartas(valor = ncarta, palo = "copa"))})
        num.forEach({ncarta => mazo.add(new Cartas(valor = ncarta, palo = "basto"))})
        num.forEach({ncarta => mazo.add(new Cartas(valor = ncarta, palo = "espada"))})
    } 

    method contarPuntaje() { // Aplicar criterios de puntuación a los jugadores
        jugadores.forEach({jugador => 
            if (jugador.tengoMayorCantidadCartas()) jugador.sumarPuntaje()
            if (jugador.tengo7deVelo()) jugador.sumarPuntaje()
            if (jugador.tengoSetenta()) jugador.sumarPuntaje()
            if (jugador.tengoTodosOros()) {
                (1..2).forEach({x => jugador.sumarPuntaje()})
            } else if (jugador.tengoMayorCantidadOros()) {
                jugador.sumarPuntaje()
            }
        })
    }

    method finalizarRonda() {
        if (mazo.size() == 0) {
            jugadores.forEach({jugador => jugador.levantarCartasAlTerminarRonda() and jugador.resetearEscobas()})
            self.contarPuntaje()
        }
    }
} 

object bot inherits Jugador {
    const jugadasDisponibles = []

    // Devuelve las jugadas disponibles
    method verJugadas() = jugadasDisponibles
    
    // Añade una jugada a la lista de jugadas disponibles
    method anadirJugadas(jugada) = jugadasDisponibles.add(jugada)

    // Devuelve una carta de la mano del bot
    method devolverCartaMano(indice) = self.mostrarManoJugador().get(indice)

    // Devuelve una carta de la mesa
    method devolverCartaMesa(indice) = tablero.mostrarMesa().get(indice)

    // Busca todas las posibles jugadas sumando cartas de la mano y la mesa que den 15
    method buscarJugadas() {
        jugadasDisponibles.clear()  // Limpiamos las jugadas previas

        (0..self.cantidadManoJugador() - 1).forEach({ x =>
            const cartasMesa = []

            (0..tablero.cantidadMesa() - 1).forEach({ y =>
                cartasMesa.add(self.devolverCartaMesa(y))
                const valorTotal = self.devolverCartaMano(x).valorCarta() + cartasMesa.map({ carta => carta.valorCarta() }).sum()
                
                if (valorTotal == 15) {
                    const nuevaJugada = [self.devolverCartaMano(x), cartasMesa].flatten()
                    if (not jugadasDisponibles.any({ jugada => jugada == nuevaJugada })) {
                        self.anadirJugadas(nuevaJugada)
                    }
                }
            })
        })
    }

    // Elige la mejor jugada disponible en base a prioridades
    method elegirJugada() {
        if (jugadasDisponibles.isEmpty()) return false

        const jugadaPrioritaria = jugadasDisponibles.find({ jugada =>
            self.hayTodosOros(jugada) or self.hay7deVelo(jugada) or self.haySetenta(jugada)
        })

        return if (jugadaPrioritaria != null) jugadaPrioritaria else jugadasDisponibles.anyOne()
    }

    // Ejecuta la jugada seleccionada
    method hacerJugada() {
        if (self.detectarMano()) {
            self.buscarJugadas()  // Buscar jugadas antes de hacer la jugada
            const jugadaSeleccionada = self.elegirJugada()

            if (!jugadaSeleccionada) {
                // Si no hay jugada, tirar cualquier carta de la mano
                self.tirarCarta(self.mostrarManoJugador().anyOne())
            }

            const cartaJugada = jugadaSeleccionada.get(0)  // Primera carta es la jugada principal
            self.eliminarCartaMano(cartaJugada)
            tablero.eliminarCartaMesa(jugadaSeleccionada.copyWithout(cartaJugada))
            self.anadirCartaMonto(cartaJugada)
            self.anadirVariasCartasMonto(jugadaSeleccionada.copyWithout(cartaJugada))
            escobas = escobas + 1  // Sumar escobas si fue una jugada válida
            tablero.hacerMano()
        }

    }

    // Métodos auxiliares para detectar jugadas especiales
    method hay7deVelo(jugada) = jugada.any({ carta => carta.valorCarta() == 7 and carta.paloCarta() == "oro" })
    method hayOros(jugada) = jugada.any({ carta => carta.paloCarta() == "oro" })
    method hayTodosOros(jugada) = jugada.all({ carta => carta.paloCarta() == "oro" })
    method haySetenta(jugada) = jugada.any({ carta => carta.valorCarta() == 7 })
}