package main

import (
	"fmt"
)

// --- Struct Calculadora ---
type Calculadora struct{}

// Métodos asociados a Calculadora
func (c Calculadora) Sumar(a, b int) int {
	return a + b
}

func (c Calculadora) Multiplicar(a, b int) int {
	return a * b
}

func (c Calculadora) CalcularIVA(precio float64) float64 {
	return precio * 0.19
}

func (c Calculadora) RegistrarPersona(nombre string, edad int) {
	fmt.Printf("  Registrado: %s, %d años\n", nombre, edad)
}

func (c Calculadora) EsMayor(edad int) bool {
	return edad >= 18
}

// --- Función principal ---
func MostrarMetodosConParametros() {
	fmt.Println("Ejemplo: Métodos con parámetros")
	calc := Calculadora{}

	fmt.Println("Sumar 2+3 =", calc.Sumar(2, 3))
	fmt.Println("Multiplicar 4*5 =", calc.Multiplicar(4, 5))
	fmt.Println("Calcular IVA de 100 =", calc.CalcularIVA(100.0))
	fmt.Println("Registrar persona:")
	calc.RegistrarPersona("María", 22)
	fmt.Println("Verificar mayor (edad 17):", calc.EsMayor(17))
	fmt.Println()
}

func main_metodos_parametros() {
	MostrarMetodosConParametros()
}
