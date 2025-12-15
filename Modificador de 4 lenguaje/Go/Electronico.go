package main

type Electronico struct {
	Marca string
}

func NewElectronico(marca string) Electronico {
	return Electronico{Marca: marca}
}