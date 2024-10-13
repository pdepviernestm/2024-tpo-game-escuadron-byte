class Jugador{
    const manojugador = []

    method mostrarMano() = manojugador
    method cantidadManoJugador() = manojugador.size()
    method eliminarCartaMano(carta) = manojugador.remove(carta)
    method anadirCartaMano(carta) = manojugador.add(carta)

}
