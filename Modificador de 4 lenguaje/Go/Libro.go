package main

type Libro struct {
	Titulo string
	Autor  string
}

func NewLibro(titulo, autor string) Libro {
	return Libro{Titulo: titulo, Autor: autor}
}