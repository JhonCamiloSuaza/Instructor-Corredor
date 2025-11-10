// EjemploModificadores.go
// Demuestra el equivalente a los modificadores de acceso de Java en Go.

package main

import "fmt"

// En Go:
// - Las variables o funciones que **empiezan con mayúscula** son públicas (exportadas).
// - Las que **empiezan con minúscula** son privadas (solo visibles dentro del paquete).
// - No existe "protected" ni "default" como en Java.
// - Los valores "estáticos" se simulan con variables globales o constantes.

// Estructura que representa la clase ModificadoresDemo
type ModificadoresDemo struct {
	Publico    string // (public) accesible desde cualquier parte del paquete o si se exporta
	privado    string // (private) solo visible dentro de este archivo o paquete
	protegido  string // no existe protected, pero simulamos comportamiento
	porDefecto string // sin exportar, se comporta como default
}

// Variable global (equivalente a static en Java)
var Estatico = "soyEstatico"

// Método (función asociada a la estructura)
func (d *ModificadoresDemo) MostrarTodos() {
	fmt.Println("publico:", d.Publico)
	fmt.Println("privado:", d.privado)
	fmt.Println("protegido:", d.protegido)
	fmt.Println("porDefecto:", d.porDefecto)
	fmt.Println("estatico:", Estatico)
}

// Función equivalente al método mostrar() de Java
func mostrarEjemploModificadores() {
	fmt.Println(" Ejemplo: Modificadores de acceso ")

	// Crear una instancia
	d := ModificadoresDemo{
		Publico:    "soyPublico",
		privado:    "soyPrivado",
		protegido:  "soyProtegido",
		porDefecto: "soyPorDefecto",
	}

	// Mostrar todos los valores
	d.MostrarTodos()

	// Acceso directo a variable "estática" (global)
	fmt.Println("Acceso estático directo:", Estatico)
	fmt.Println()
}
