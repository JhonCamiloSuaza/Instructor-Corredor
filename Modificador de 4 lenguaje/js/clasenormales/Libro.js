class Libro {
    constructor(titulo, autor) {
        this.titulo = titulo;
        this.autor = autor;
    }

    static copiar(libroExistente) {
        return new Libro(libroExistente.titulo, libroExistente.autor);
    }

    mostrar() {
        console.log(`Libro: "${this.titulo}" de ${this.autor}`);
    }
}

module.exports = Libro;
