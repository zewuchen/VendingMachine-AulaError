import Foundation

struct VendingMachineProduct {
    var name: String
    var amount: Int
    var price: Double
}

//TODO: Definir os erros

class VendingMachine {
    private var estoque: [VendingMachineProduct]
    
    init(products: [VendingMachineProduct]) {
        self.estoque = products
    }
    
    func getProduct(named name: String, with money: Double) throws {
        //TODO: receber o dinheiro e salvar em uma variável
        //TODO: achar o produto que o cliente quer
        //TODO: ver se ainda tem esse produto
        //TODO: ver se o dinheiro é o suficiente pro produto
        //TODO: entregar o produto
    }
    
    func getTroco() -> Double {
        //TODO: devolver o dinheiro que não foi gasto
    }
}

