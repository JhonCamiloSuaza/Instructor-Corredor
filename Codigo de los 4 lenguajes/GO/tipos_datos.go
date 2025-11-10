// EjemploTiposDatos.go
// Muestra 5 ejemplos por tipo de dato: numérico, texto, boolean, JSON(simulado), binario.

package main

import "fmt"

func mostrarTiposDatos() {
	fmt.Println(" Ejemplo: Tipos de datos ")

	//  5 numéricos 
	var a int = 10
	var b int64 = 3000000000
	var c int16 = 32000
	var d float32 = 4.5
	var e float64 = 99.99
	fmt.Printf("Numéricos: %d, %d, %d, %.2f, %.2f\n", a, b, c, d, e)

	//  5 textos (Strings) 
	s1 := "Camilo"
	s2 := "Universidad"
	s3 := "POO"
	s4 := "Ejemplo"
	s5 := "Go"
	fmt.Printf("Textos: %s, %s, %s, %s, %s\n", s1, s2, s3, s4, s5)

	//  5 booleanos true y 5 fals
	t1, t2, t3, t4, t5 := true, true, true, true, true
	f1, f2, f3, f4, f5 := false, false, false, false, false
	fmt.Printf("Booleans true: %t, %t, %t, %t, %t\n", t1, t2, t3, t4, t5)
	fmt.Printf("Booleans false: %t, %t, %t, %t, %t\n", f1, f2, f3, f4, f5)

	//  5 JSON simulados con strings 
	json1 := `{"nombre":"Camilo"}`
	json2 := `{"edad":20}`
	json3 := `{"activo":true}`
	json4 := `{"producto":"Teclado"}`
	json5 := `{"precio":199.99}`
	fmt.Printf("JSONs: %s, %s, %s, %s, %s\n", json1, json2, json3, json4, json5)

	// 5 binarios (byte arrays) 
	bin1 := []byte{1, 0, 1, 1}
	bin2 := []byte{0, 1, 0, 1}
	bin3 := []byte{1, 1, 1, 0}
	bin4 := []byte{0, 0, 1, 0}
	bin5 := []byte{1, 0, 0, 1}
	fmt.Printf("Binarios (longitudes): %d, %d, %d, %d, %d\n",
		len(bin1), len(bin2), len(bin3), len(bin4), len(bin5))

	fmt.Println()
}

func ejecutarTiposDatos() {
	mostrarTiposDatos()
}
