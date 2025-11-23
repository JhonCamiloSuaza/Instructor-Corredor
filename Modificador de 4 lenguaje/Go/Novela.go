package main

import "fmt"

type Novela struct {
	Libro
	Paginas int
	Genero  string
}

func NewNovela(titulo, autor string, paginas int, genero string) Novela {
	return Novela{
		Libro:   NewLibro(titulo, autor),
		Paginas: paginas,
		Genero:  genero,
	}
}

func (n Novela) Abrir() {
	fmt.Println("Abriendo la novela...")
}

func (n Novela) Informacion() {
	fmt.Println("Título:", n.Titulo)
	fmt.Println("Autor:", n.Autor)
	fmt.Println("Páginas:", n.Paginas)
	fmt.Println("Género:", n.Genero)
}