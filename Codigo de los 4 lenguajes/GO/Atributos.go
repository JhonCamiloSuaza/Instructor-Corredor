// EjemploAtributos.go
// Muestra 5 atributos distintos y cómo usarlos en Go
package main

import (
	"fmt"
)

// 1) Producto: estructura con 5 atributos
type ProductoAtributos struct {
	Codigo     int
	Nombre     string
	Precio     float64
	Disponible bool
	Imagen     []byte 
}

func (p ProductoAtributos) Mostrar() {
	fmt.Printf("Producto  código: %d, nombre: %s, precio: %.2f, disponible: %t, imagenBytes: %d\n",
		p.Codigo, p.Nombre, p.Precio, p.Disponible, len(p.Imagen))
}

// 2) Persona
type PersonaAtributos struct {
	Nombre     string
	Edad       int
	Disponible bool
}

func (p PersonaAtributos) MostrarInfo() {
	fmt.Printf("Persona -> nombre: %s, edad: %d, disponible: %t\n", p.Nombre, p.Edad, p.Disponible)
}

// 3) Carro
type CarroAtributos struct {
	Marca  string
	Anio   int
	Precio float64
}

func (c CarroAtributos) MostrarInfo() {
	fmt.Printf("Carro -> marca: %s, año: %d, precio: %.2f\n", c.Marca, c.Anio, c.Precio)
}

// 4) Libro
type LibroAtributos struct {
	Titulo  string
	Autor   string
	Paginas int
}

func (l LibroAtributos) MostrarInfo() {
	fmt.Printf("Libro -> título: %s, autor: %s, páginas: %d\n", l.Titulo, l.Autor, l.Paginas)
}

// 5) Computador
type ComputadorAtributos struct {
	Marca      string
	MemoriaRAM int
	Encendido  bool
}

func (c ComputadorAtributos) MostrarInfo() {
	fmt.Printf("Computador -> marca: %s, RAM: %d GB, encendido: %t\n", c.Marca, c.MemoriaRAM, c.Encendido)
}

// Función equivalente a mostrar()
func mostrarEjemploAtributos() {
	fmt.Println(" Ejemplo: Atributos ")

	// Producto con 5 atributos
	p := ProductoAtributos{Codigo: 1001, Nombre: "Auriculares", Precio: 79.99, Disponible: true, Imagen: []byte{1, 0, 1}}
	p.Mostrar()

	// Ejemplos rápidos de otros objetos
	per := PersonaAtributos{"Luis", 28, true}
	per.MostrarInfo()

	car := CarroAtributos{"Mazda", 2019, 22000.0}
	car.MostrarInfo()

	lib := LibroAtributos{"Aprende Go", "Carlos", 320}
	lib.MostrarInfo()

	pc := ComputadorAtributos{"Lenovo", 32, true}
	pc.MostrarInfo()

	fmt.Println()
}
