import armas.*

class Mirmillon{
  var vida = 100
  const fuerza
  const arma
  var armadura

  method cambiarArmadura(unaArmadura){
    armadura = unaArmadura
  }

  method fuerza() = fuerza

  method vida() = vida

  method estaVivo() = vida > 0

  method destreza() = 15

  method poderAtaque() = arma.valorAtaque() + fuerza

  method defensa() = armadura.defensa() + self.destreza()

  method atacar(enemigo){
    if(self.puedeInfringirDanio(enemigo) && enemigo.estaVivo()){
      enemigo.sufrirDanio(self.poderAtaque() - enemigo.defensa())
    }
  }

  method sufrirDanio(unValor){
    vida = (vida - unValor).max(0)
  }

  method puedeInfringirDanio(enemigo) = self.poderAtaque() > enemigo.defensa()

  method pelear(enemigo){
    self.atacar(enemigo)
    enemigo.atacar(self)
  }

  
  method curar(){
    vida = 100
  }

  method crearGrupo(otroGladiador) = new Grupo(nombre = "mirmillolandia", gladiadores = #{self,otroGladiador})
}

class Dimachaerus{
  var vida = 100
  var destreza
  const armas = []

  method fuerza() = 10

  method agregarArma(unArma){
    armas.add(unArma)
  }

  method quitarArma(unArma){
    armas.remove(unArma)
  }

  method estaVivo() = vida > 0

  method vida() = vida

  method poderAtaque() = armas.sum({arma => arma.valorAtaque()}) + self.fuerza()

  method defensa() = destreza / 2

  method danio(unLuchador) = self.poderAtaque() - unLuchador.defensa()

  method recibirAtaque(unLuchador){
    vida = vida - unLuchador.danio(self)
  }

  method destreza() = destreza

  method atacar(enemigo){
    if(self.puedeInfringirDanio(enemigo) && enemigo.estaVivo()){
      enemigo.sufrirDanio(self.poderAtaque() - enemigo.defensa())
      destreza += 1
    }
  }

  
  method sufrirDanio(unValor){
    vida = (vida - unValor).max(0)
  }

  method puedeInfringirDanio(enemigo) = self.poderAtaque() > enemigo.defensa()

  method pelear(enemigo){
    self.atacar(enemigo)
    enemigo.atacar(self)
  }

  method curar(){
    vida = 100
  }

  method crearGrupo(otroGladiador) = 
    new Grupo(
      nombre = "D-" + (self.poderAtaque() + otroGladiador.poderAtaque()).toString(), 
      gladiadores = #{self,otroGladiador}
    )
}

class Grupo{
  const property nombre
  var cantPeleas = 0
  const gladiadores = #{}

  method agregarGladia(gladiador){
      gladiadores.add(gladiador)
  }

  method sacarGladia(gladiador){
      gladiadores.remove(gladiador)
  }

  method gladiadoresVivos() = gladiadores.filter({gladia => gladia.estaVivo()})

  method hayAlgunGladiaVivo() = gladiadores.any({gladia => gladia.estaVivo()})

  method campeon() = self.gladiadoresVivos().max({gladia => gladia.fuerza()})

  method pelearCon(otroGrupo){
    if(self.hayAlgunGladiaVivo() && otroGrupo.hayAlgunGladiaVivo()){
      self.campeon().pelear(otroGrupo.campeon())
    }
  }

  method registrarPelea(){cantPeleas +=1}

  //Aca utilizamos algo llamado RANGO
  method combatir(otroGrupo){
    (1..3).forEach({self.pelearCon(otroGrupo)})
    self.registrarPelea()
    otroGrupo.registrarPelea()
  }

  method curar(){
    gladiadores.forEach({gladia => gladia.curar()})
  }
}

object coliseo{

}
