package main

import "fmt"

type Telefono struct {
	Electronico
	Modelo string
	Precio float64
}

// Constructor 1
func NewTelefono(modelo string) Telefono {
	return Telefono{
		Electronico: NewElectronico("Genérica"),
		Modelo:     modelo,
		Precio:     0,
	}
}

// Constructor 2 (sobrecargado)
func NewTelefonoFull(marca, modelo string, precio float64) Telefono {
	return Telefono{
		Electronico: NewElectronico(marca),
		Modelo:     modelo,
		Precio:     precio,
	}
}

func (s Telefono) Encender() {
	fmt.Println("Encendiendo el smartphone...")
}

func (s Telefono) Informacion() {
	fmt.Println("Marca:", s.Marca)
	fmt.Println("Modelo:", s.Modelo)
	fmt.Println("Precio:", s.Precio)
}