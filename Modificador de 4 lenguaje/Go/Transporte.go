package main

type Transporte struct {
	Tipo string
}

func NewTransporte() Transporte {
	return Transporte{Tipo: "Desconocido"}
}