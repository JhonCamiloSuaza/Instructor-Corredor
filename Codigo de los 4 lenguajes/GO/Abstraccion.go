// EjemploAbstraccion.go
// Ejemplos reales de abstracción: structs, métodos e interfaces en Go.

package main

import (
	"fmt"
)

// 1) Figura (abstracción mediante interfaz)
type Figura interface {
	Area() float64
	MostrarArea()
}

type Rectangulo struct {
	Base, Altura float64
}

func (r Rectangulo) Area() float64 {
	return r.Base * r.Altura
}

func (r Rectangulo) MostrarArea() {
	fmt.Printf("Área = %.2f\n", r.Area())
}

// 2) Vehiculo (abstracción con método)
type Vehiculo interface {
	Arrancar()
}

type Moto struct{}

func (m Moto) Arrancar() {
	fmt.Println("Moto arrancó")
}

// 3) Empleado (interfaz)
type Empleado interface {
	CalcularPago() float64
	ObtenerNombre() string
}

type EmpleadoPlanta struct {
	Nombre  string
	Salario float64
}

func (e EmpleadoPlanta) CalcularPago() float64 {
	return e.Salario
}

func (e EmpleadoPlanta) ObtenerNombre() string {
	return e.Nombre
}

// 4) AnimalAbstracto (abstracción)
type AnimalAbstracto interface {
	Hablar()
}

type Perro struct{}

func (p Perro) Hablar() {
	fmt.Println("Guau")
}

// 5) Electrodomestico (abstracción)
type Electrodomestico interface {
	Encender()
}

type Televisor struct{}

func (t Televisor) Encender() {
	fmt.Println("Televisor encendido")
}

// Función principal equivalente a mostrar()
func mostrar() {
	fmt.Println(" Ejemplo: Abstracción ")

	var f Figura = Rectangulo{Base: 3, Altura: 4}
	f.MostrarArea()

	var v Vehiculo = Moto{}
	v.Arrancar()

	var e Empleado = EmpleadoPlanta{"Laura", 1200}
	fmt.Printf("Pago: %.2f\n", e.CalcularPago())

	var a AnimalAbstracto = Perro{}
	a.Hablar()

	var el Electrodomestico = Televisor{}
	el.Encender()

	fmt.Println()
}

func EjecutarMostrar() {
	mostrar()
}
