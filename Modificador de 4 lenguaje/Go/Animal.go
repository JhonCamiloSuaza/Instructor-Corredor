package main

type Animal struct {
	Nombre string
	Raza   string
}

func NewAnimal(nombre, raza string) Animal {
	return Animal{Nombre: nombre, Raza: raza}
}