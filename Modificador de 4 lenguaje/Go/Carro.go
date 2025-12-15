package main

import "fmt"

type Carro struct {
	Transporte
	Marca  string
	Modelo int
}

//Constructor Sin Parametros
func NewCarro() Carro {
	return Carro{
		Transporte: NewTransporte(),
		Marca:      "Toyota",
		Modelo:     2020,
	}
}

func (c Carro) Mover() {
	fmt.Println("El carro está en movimiento.")
}

func (c Carro) Informacion() {
	fmt.Println("Tipo:", c.Tipo)
	fmt.Println("Marca:", c.Marca)
	fmt.Println("Modelo:", c.Modelo)
}