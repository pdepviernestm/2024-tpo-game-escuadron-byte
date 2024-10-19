
class Jugador{
    const manojugador = []
    const montojugador = []
    const cartasAJugar = []

    var escobas = 0

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

    method hayJugada() = (cartasAJugar.map({x => x.valorCarta()}).sum() == 15)

    method jugada() {
                    cartasAJugar.forEach({ _carta => self.anadirCartaMonto(_carta) })
                    self.limpiarCartasAJugar()
                    //self.eliminarCartaMano(carta)
                    escobas = escobas + 1
    }
}
