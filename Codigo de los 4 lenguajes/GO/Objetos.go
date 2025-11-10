// EjemploObjetos.go
// Muestra 5 objetos distintos creados a partir de estructuras reales y usa sus métodos.

package main

import "fmt"

//  Definición de estructuras 

// Persona representa una persona con nombre, edad y si está activa
type PersonaObjetos struct {
	Nombre string
	Edad   int
	Activo bool
}

func (p PersonaObjetos) MostrarInfo() {
	fmt.Printf("Persona -> Nombre: %s, Edad: %d, Activo: %t\n", p.Nombre, p.Edad, p.Activo)
}

// Carro representa un vehículo con marca, año y precio
type CarroObjetos struct {
	Marca  string
	Anio   int
	Precio float64
}

func (c CarroObjetos) MostrarInfo() {
	fmt.Printf("Carro -> Marca: %s, Año: %d, Precio: %.2f\n", c.Marca, c.Anio, c.Precio)
}

// Animal representa un animal con tipo, nombre y si es doméstico
type AnimalObjetos struct {
	Tipo      string
	Nombre    string
	Domestico bool
}

func (a AnimalObjetos) MostrarInfo() {
	fmt.Printf("Animal -> Tipo: %s, Nombre: %s, Doméstico: %t\n", a.Tipo, a.Nombre, a.Domestico)
}

// Libro representa un libro con título, autor y número de páginas
type LibroObjetos struct {
	Titulo  string
	Autor   string
	Paginas int
}

func (l LibroObjetos) MostrarInfo() {
	fmt.Printf("Libro -> Título: %s, Autor: %s, Páginas: %d\n", l.Titulo, l.Autor, l.Paginas)
}

// Computador representa un computador con marca, memoria RAM y si tiene disco SSD
type ComputadorObjetos struct {
	Marca string
	Ram   int
	SSD   bool
}

func (c ComputadorObjetos) MostrarInfo() {
	fmt.Printf("Computador -> Marca: %s, RAM: %d GB, SSD: %t\n", c.Marca, c.Ram, c.SSD)
}

//  Función principal

func mostrarEjemploObjetosDetallado() {
	fmt.Println("=== Ejemplo: Objetos ===")

	// 1) Persona
	persona1 := PersonaObjetos{"Ana", 30, true}
	persona1.MostrarInfo()

	// 2) Carro
	carro1 := CarroObjetos{"Honda", 2018, 18000.0}
	carro1.MostrarInfo()

	// 3) Animal
	animal1 := AnimalObjetos{"Gato", "Michi", true}
	animal1.MostrarInfo()

	// 4) Libro
	libro1 := LibroObjetos{"Java Básico", "María", 150}
	libro1.MostrarInfo()

	// 5) Computador
	comp1 := ComputadorObjetos{"Lenovo", 8, true}
	comp1.MostrarInfo()

	fmt.Println()
}
