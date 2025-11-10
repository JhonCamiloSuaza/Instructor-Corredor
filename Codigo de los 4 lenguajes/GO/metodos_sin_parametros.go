package main

import (
	"fmt"
)


type Maquina struct {
	encendida bool
}

// Métodos asociados
func (m *Maquina) Encender() {
	m.encendida = true
	fmt.Println("Máquina encendida")
}

func (m *Maquina) Apagar() {
	m.encendida = false
	fmt.Println("Máquina apagada")
}

func (m *Maquina) EstaEncendida() bool {
	return m.encendida
}

func (m *Maquina) Reiniciar() {
	fmt.Println("Reiniciando...")
	m.encendida = false
	m.encendida = true
}

func (m *Maquina) Detener() {
	fmt.Println("Máquina detenida")
}

// --- Función principal ---
func MostrarMetodosSinParametros() {
	fmt.Println("Ejemplo: Métodos sin parámetros")
	m := Maquina{}

	m.Encender()
	m.Detener()
	fmt.Println("Estado encendida?:", m.EstaEncendida())
	m.Reiniciar()
	m.Apagar()
	fmt.Println()
}

func main_metodos_sin_parametros() {
	MostrarMetodosSinParametros()
}
