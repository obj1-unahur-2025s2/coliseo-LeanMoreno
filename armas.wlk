class ArmaDeFilo{
    const property filo
    const property longitud

    //method valorCorrecto() = filo >= 0 && filo >= 1

    method initialize(){
        if(!filo.between(0, 1)) self.error("Filo entre 0 y 1")
    }

    method valorAtaque() = filo*longitud
}

class ArmaContundente{
    const property peso

    method valorAtaque() = peso 
}

object casco{
    method defensa(gladiador) = 10
}

object escudo{
    method defensa(gladiador) = 5 + gladiador.destreza()*0.1
}