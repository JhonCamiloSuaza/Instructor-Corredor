// EjemploEncapsulacion.go
// Presenta 5 ejemplos de encapsulación en Go: estructuras con campos privados y métodos Get/Set.

package main

import (
	"fmt"
)

// 1) CuentaBancaria
type CuentaBancaria struct {
	titular string
	saldo   float64
}

func NuevaCuentaBancaria(titular string, saldo float64) CuentaBancaria {
	return CuentaBancaria{titular: titular, saldo: saldo}
}

func (c *CuentaBancaria) GetTitular() string  { return c.titular }
func (c *CuentaBancaria) SetTitular(t string) { c.titular = t }
func (c *CuentaBancaria) GetSaldo() float64   { return c.saldo }
func (c *CuentaBancaria) SetSaldo(s float64)  { c.saldo = s }

// 2) Usuario
type Usuario struct {
	username string
	password string
}

func NuevoUsuario(u, p string) Usuario {
	return Usuario{username: u, password: p}
}

func (u *Usuario) GetUsername() string  { return u.username }
func (u *Usuario) SetUsername(n string) { u.username = n }
func (u *Usuario) GetPassword() string  { return u.password }
func (u *Usuario) SetPassword(p string) { u.password = p }

// 3) ProductoEncapsulado
type ProductoEncapsulado struct {
	codigo int
	nombre string
	precio float64
}

func NuevoProductoEncapsulado(codigo int, nombre string, precio float64) ProductoEncapsulado {
	return ProductoEncapsulado{codigo: codigo, nombre: nombre, precio: precio}
}

func (p *ProductoEncapsulado) GetCodigo() int           { return p.codigo }
func (p *ProductoEncapsulado) SetCodigo(c int)          { p.codigo = c }
func (p *ProductoEncapsulado) GetNombre() string        { return p.nombre }
func (p *ProductoEncapsulado) SetNombre(n string)       { p.nombre = n }
func (p *ProductoEncapsulado) GetPrecio() float64       { return p.precio }
func (p *ProductoEncapsulado) SetPrecio(precio float64) { p.precio = precio }

// 4) EstudianteEnc
type EstudianteEnc struct {
	nombre string
	edad   int
}

func NuevoEstudianteEnc(nombre string, edad int) EstudianteEnc {
	return EstudianteEnc{nombre: nombre, edad: edad}
}

func (e *EstudianteEnc) GetNombre() string  { return e.nombre }
func (e *EstudianteEnc) SetNombre(n string) { e.nombre = n }
func (e *EstudianteEnc) GetEdad() int       { return e.edad }
func (e *EstudianteEnc) SetEdad(ed int)     { e.edad = ed }

// 5) Orden
type Orden struct {
	id     int
	pagada bool
}

func NuevaOrden(id int, pagada bool) Orden {
	return Orden{id: id, pagada: pagada}
}

func (o *Orden) GetId() int       { return o.id }
func (o *Orden) SetId(id int)     { o.id = id }
func (o *Orden) IsPagada() bool   { return o.pagada }
func (o *Orden) SetPagada(p bool) { o.pagada = p }

// Función equivalente al método mostrar()
func mostrarEncapsulacion() {
	fmt.Println("--- Ejemplo: Encapsulación (Get/Set) ---")

	cb := NuevaCuentaBancaria("Camilo", 1500.0)
	fmt.Printf("Titular: %s, Saldo: %.2f\n", cb.GetTitular(), cb.GetSaldo())
	cb.SetSaldo(2000.0)
	fmt.Printf("Saldo actualizado: %.2f\n", cb.GetSaldo())

	u := NuevoUsuario("camilo1er", "secreto")
	fmt.Printf("Usuario: %s\n", u.GetUsername())
	u.SetPassword("nuevo")
	fmt.Println("Password cambiado")

	pe := NuevoProductoEncapsulado(10, "Mouse", 25.5)
	fmt.Printf("Producto: %s, Precio: %.2f\n", pe.GetNombre(), pe.GetPrecio())
	pe.SetPrecio(20.0)
	fmt.Printf("Precio actualizado: %.2f\n", pe.GetPrecio())

	est := NuevoEstudianteEnc("Ana", 21)
	fmt.Printf("Estudiante: %s\n", est.GetNombre())
	est.SetEdad(22)
	fmt.Printf("Edad actualizada: %d\n", est.GetEdad())

	ord := NuevaOrden(500, false)
	fmt.Printf("Orden pagada?: %t\n", ord.IsPagada())
	ord.SetPagada(true)
	fmt.Printf("Orden pagada ahora: %t\n", ord.IsPagada())

	fmt.Println()
}
