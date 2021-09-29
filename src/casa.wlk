object casa {
	var property viveres = 50
	var property reparaciones = 0
	var property mantenimiento = full
	var property cuenta = cuentaCorriente
	
	method hayViveresSuficientes() {
		return viveres > 40
	}
	
	method hayQueReparar() {
		return reparaciones > 0
	}
	
	method enOrden() {
		return not self.hayQueReparar() and self.hayViveresSuficientes()
	}
	
	method agregarReparacion(valor) {
		reparaciones += valor
	}
	
	method comprarViveres(porcentaje, calidad) {
		cuenta.extraer(porcentaje * calidad)		
		viveres = viveres + porcentaje
	}
	
	method reparar() {
		cuenta.extraer(reparaciones)
		reparaciones = 0
	}
	
	method puedePagar(monto, resto) {
		return cuenta.saldo() - monto > resto
	}
	
	method mantener() {
		mantenimiento.mantener(self)
	}
}

object cuentaCorriente {
	
	var property saldo = 0
		
	method extraer(monto) {
		saldo -= monto		
	}
	
	method depositar(monto) {
		saldo += monto
	}
	
}

object full {
	
	method mantener(casa) {
		const porcentaje = if(casa.enOrden()) 100 - casa.viveres() else 40 
		casa.comprarViveres(porcentaje, 5)
		if(casa.puedePagar(casa.reparaciones(), 1000)) {
			casa.reparar()
		}	
	}
}
