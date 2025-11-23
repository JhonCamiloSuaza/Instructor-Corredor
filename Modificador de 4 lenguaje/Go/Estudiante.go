package main

import "fmt"

type Estudiante struct {
	Persona
	Programa string
}

// Constructor normal
func NewEstudiante(nombre string, edad int, programa string) Estudiante {
	return Estudiante{
		Persona:  NewPersona(nombre, edad),
		Programa: programa,
	}
}

// Constructor COPIA
func NewEstudianteCopy(e Estudiante) Estudiante {
	return Estudiante{
		Persona:  e.Persona,
		Programa: e.Programa,
	}
}

func (e Estudiante) Saludar() {
	fmt.Println("Hola, soy un estudiante.")
}

func (e Estudiante) Informacion() {
	fmt.Println("Nombre:", e.Nombre)
	fmt.Println("Edad:", e.Edad)
	fmt.Println("Programa:", e.Programa)
}
