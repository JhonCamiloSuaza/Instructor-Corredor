package main

import "fmt"

type Perro struct {
	Animal
	Edad int
}
//Constructor Con Parametros
func NewPerro(nombre, raza string, edad int) Perro {
	return Perro{
		Animal: NewAnimal(nombre, raza),
		Edad:   edad,
	}
}

func (d Perro) HacerSonido() {
	fmt.Println("El perro ladra: ¡Guau guau!")
}

func (d Perro) Informacion() {
	fmt.Println("Nombre:", d.Nombre)
	fmt.Println("Raza:", d.Raza)
	fmt.Println("Edad:", d.Edad)
}