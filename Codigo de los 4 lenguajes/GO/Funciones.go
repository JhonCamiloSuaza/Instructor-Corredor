// EjemploFunciones.go
// Muestra 5 funciones (métodos con retorno) con ejemplos reales.

package main

import (
	"fmt"
	"strings"
)

type PersonaFunciones struct {
	Nombre string
	Edad   int
	Activo bool
}

// 1) esMayor
func esMayor(edad int) bool {
	return edad >= 18
}

// 2) areaRectangulo
func areaRectangulo(base, altura float64) float64 {
	return base * altura
}

// 3) aplicarDescuento
func aplicarDescuento(precio float64, porcentaje float64) float64 {
	return precio * (1 - porcentaje/100.0)
}

// 4) inicial
func inicial(nombre string) string {
	if len(nombre) > 0 {
		return string(nombre[0])
	}
	return ""
}

// 5) repetir
func repetir(s string, veces int) string {
	return strings.Repeat(s, veces)
}

// Función equivalente al método mostrar()
func mostrarFuncionesEjemplo() {
	fmt.Println("=== Ejemplo: Funciones con retorno ===")

	p := PersonaFunciones{"Sofia", 19, false}

	fmt.Println("Nombre persona:", p.Nombre)
	fmt.Println("Es mayor?:", esMayor(p.Edad))
	fmt.Println("Área rectángulo 3x4:", areaRectangulo(3, 4))
	fmt.Println("Precio con descuento (100, 10%):", aplicarDescuento(100.0, 10))
	fmt.Println("Obtener inicial nombre:", inicial(p.Nombre))
	fmt.Println("Repetir 'Go' 3 veces:", repetir("Go", 3))

	fmt.Println()
}
