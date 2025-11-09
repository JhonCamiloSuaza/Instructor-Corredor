// EjemploClases.go
// Define 5 estructuras reales: Persona, Carro, Animal, Libro, Computador
// Cada estructura tiene atributos y un método MostrarInfo() para imprimir su información.

package main

import (
	"fmt"
)

// 1) Persona
type PersonaClases struct {
	Nombre string
	Edad   int
	Activo bool
}

func (p PersonaClases) MostrarInfo() {
	fmt.Printf("Persona  nombre: %s, edad: %d, activo: %t\n", p.Nombre, p.Edad, p.Activo)
}

// 2) Carro
type CarroClases struct {
	Marca  string
	Modelo int
	Precio float64
}

func (c CarroClases) MostrarInfo() {
	fmt.Printf("Carro  marca: %s, modelo: %d, precio: %.2f\n", c.Marca, c.Modelo, c.Precio)
}

// 3) Animal
type AnimalClases struct {
	Especie   string
	Nombre    string
	Domestico bool
}

func (a AnimalClases) MostrarInfo() {
	fmt.Printf("Animal  especie: %s, nombre: %s, doméstico: %t\n", a.Especie, a.Nombre, a.Domestico)
}

// 4) Libro
type LibroClases struct {
	Titulo  string
	Autor   string
	Paginas int
}

func (l LibroClases) MostrarInfo() {
	fmt.Printf("Libro  título: %s, autor: %s, páginas: %d\n", l.Titulo, l.Autor, l.Paginas)
}

// 5) Computador
type ComputadorClases struct {
	Marca     string
	RamGb     int
	Encendido bool
}

func (c ComputadorClases) MostrarInfo() {
	fmt.Printf("Computador  marca: %s, RAM: %dGB, encendido: %t\n", c.Marca, c.RamGb, c.Encendido)
}

// Función principal equivalente al método mostrar()
func mostrarEjemploClases() {
	fmt.Println("Ejemplo: Clases reales ")

	p := PersonaClases{"Camilo", 20, true}
	c := CarroClases{"Toyota", 2020, 35000.0}
	a := AnimalClases{"Perro", "Firulais", true}
	l := LibroClases{"POO en Go", "Autor X", 250}
	pc := ComputadorClases{"Dell", 16, false}

	p.MostrarInfo()
	c.MostrarInfo()
	a.MostrarInfo()
	l.MostrarInfo()
	pc.MostrarInfo()

	fmt.Println()
}
