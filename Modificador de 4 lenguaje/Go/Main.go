package main
import "fmt"

func main() {

	fmt.Println("Ejemplo 1: Constructor sin Parametros")
	carro := NewCarro()
	carro.Mover()
	carro.Informacion()

	fmt.Println("Ejemplo 2: Constructor Con Parametros")
	perro := NewPerro("Perro", "Pincher", 5)
	perro.HacerSonido()
	perro.Informacion()

	fmt.Println("Ejemplo 3: Constructor Sobrecargado")
	cel := NewTelefonoFull("Opo", "80", 7500.0)
	cel.Encender()
	cel.Informacion()

	fmt.Println("Ejemplo 4: Constructor Copia")
	est := NewEstudiante("Camilo", 22, "Ingeniería")
	est2 := NewEstudianteCopy(est)
	est.Saludar()
	est2.Informacion()

	fmt.Println("Ejemplo 5: Constructor Con Parametros ")
	novela := NewNovela("IT", "Elif", 1200, "ficción")
	novela.Abrir()
	novela.Informacion()
}