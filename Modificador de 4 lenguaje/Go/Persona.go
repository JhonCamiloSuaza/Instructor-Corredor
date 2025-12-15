package main

type Persona struct {
	Nombre string
	Edad   int
}

func NewPersona(nombre string, edad int) Persona {
	return Persona{Nombre: nombre, Edad: edad}
}