
class Jugador{
    const manojugador = []
    const montojugador = []
    const cartasAJugar = []

    var puntaje = 0
    var escobas = 0

    var property turno = 0

    method mostrarMano() = manojugador
    method mostrarMonto() = montojugador 
    method mostrarCartasAJugar() = cartasAJugar 

    method cantidadManoJugador() = manojugador.size()
    method cantidadMontoJugador() = montojugador.size()

    method eliminarCartaMano(carta) = manojugador.remove(carta)
    method limpiarCartasAJugar() = cartasAJugar.clear()
    method anadirCartaMano(carta) = manojugador.add(carta)
    method anadirCartaMonto(carta) = montojugador.add(carta)
    method anadirCartaAJugar(carta) = cartasAJugar.add(carta)

    method sumarPuntaje() {puntaje += 1}

    method hayJugada() = (cartasAJugar.map({x => x.valorCarta()}).sum() == 15)

    method jugada() {
                    cartasAJugar.forEach({ _carta => self.anadirCartaMonto(_carta)
                                                     self.eliminarCartaMano(_carta)})
                    self.limpiarCartasAJugar()
                    escobas = escobas + 1
    }

    method tengoMayorCantidadCartas() = (self.cantidadMontoJugador() > 20)
    method tengo7deVelo() = (montojugador.any({carta => carta.valorCarta() == 7 && carta.paloCarta() == "oro"}))

    method tengoMayorCantidadOros() = (montojugador.any({carta => carta.paloCarta() == "oro"}) 
                                        &&
                                       montojugador.filter({carta => carta.paloCarta() == "oro"}).size() > 5)

    method tengoTodosOros() = (montojugador.any({carta => carta.paloCarta() == "oro"})
                                        &&
                               montojugador.filter({carta => carta.paloCarta() == "oro"}).size() == 10)

    method tengoSetenta() = (montojugador.any({carta => carta.valorCarta() == 7})
                                        &&
                             montojugador.filter({carta => carta.valorCarta() == 7}).size() > 2)

    method contabilizarEscobas() {
        puntaje += escobas
        escobas = 0
    }
}
