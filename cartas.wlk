class Cartas {
    var valor
    var palo
    var property position = game.at(50, 50)

    method initialize(valorInicial, paloInicial) {
        valor = valorInicial
        palo = paloInicial
    }

    method valorCarta() {
        return valor
    }

    method paloCarta() {
        return palo
    }

    method image() {
        return palo + valor + ".png"
    }
}