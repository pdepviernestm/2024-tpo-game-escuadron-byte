
class Jugador{
    const manojugador = []
    const montojugador = []
    const cartasAJugar = []

    var property puntaje = 0
    var property escobas = 0

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
    }

    method tengoMayorCantidadCartas() = (self.cantidadMontoJugador() > 20)
    method tengo7deVelo() = (montojugador.any({carta => carta.valorCarta() == 7 && carta.paloCarta() == "oro"}))

    method tengoMayorCantidadOros() = montojugador.filter({carta => carta.paloCarta() == "oro"}).size() > 5

    method tengoTodosOros() = montojugador.filter({carta => carta.paloCarta() == "oro"}).size() == 10

    method tengoSetenta() = montojugador.filter({carta => carta.valorCarta() == 7}).size() > 2 //Por regla, si ambos tienen 2 sietes nadie suma puntos

    method contabilizarEscobas() {
        escobas +=1
    }

    method puntajeTotal() = puntaje + escobas 

    method visualizarCartasMano(altura) {
        var cont = 4
        self.mostrarMano().forEach(
      { carta =>
        game.addVisual(carta)
        carta.position(game.at(cont + 4, altura))
        cont = cont + 4
      }
    )
    cont = 4
      
    }
  
}
