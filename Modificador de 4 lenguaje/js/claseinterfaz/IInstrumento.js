class IInstrumento {
    tocar() {
        throw new Error("Método 'tocar' debe ser implementado.");
    }
}

module.exports = IInstrumento;
