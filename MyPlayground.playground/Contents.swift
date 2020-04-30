import Foundation

class VendingMachineProduct {
    var name: String
    var amount: Int
    var price: Double

    init(name: String, amount: Int, price: Double) {
        self.name = name
        self.amount = amount
        self.price = price
    }
}

enum VendingMachineError: Error {
    case productNotFound
    case productUnavailable
    case productStuck
    case insufficientFunds
    case calculoDoTroco
}

extension VendingMachineError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .productNotFound:
            return "Produto não encontrado"
        case .productUnavailable:
            return "Produto não disponível"
        case .productStuck:
            return "Falha ao entregar o produto"
        case .insufficientFunds:
            return "Dinheiro insuficiente"
        case .calculoDoTroco:
            return "Não foi possível retornar o troco"
        }
    }
}

class VendingMachine {
    private var estoque: [VendingMachineProduct]
    private var money: Double?
    
    init(products: [VendingMachineProduct]) {
        self.estoque = products
        self.money = 0.0
    }
    
    func getProduct(named name: String, with money: Double) throws {
        self.money? += money

        let produtoOptional = estoque.first { (produto) -> Bool in
            return produto.name == name
        }

        guard let produto = produtoOptional else { throw VendingMachineError.productNotFound }

        guard produto.amount > 0 else { throw VendingMachineError.productUnavailable }

        guard produto.price <= money else { throw VendingMachineError.insufficientFunds }

        produto.amount -= 1
        self.money? -= produto.price

        if Int.random(in: 0...100) < 10 {
            throw VendingMachineError.productStuck
        }
    }
    
    func getTroco() throws -> Double {
        guard let money = self.money else { throw VendingMachineError.calculoDoTroco }
        self.money = 0.0

        return money
    }
}

let vendingMachine = VendingMachine(products:[
    VendingMachineProduct(name: "Bala", amount: 10, price: 2.3),
    VendingMachineProduct(name: "Salgadinho", amount: 0, price: 8.5),
    VendingMachineProduct(name: "Biscoito", amount: 1, price: 2.0),
    VendingMachineProduct(name: "Bulacha", amount: 100, price: 10000.3),
    VendingMachineProduct(name: "Chocolate", amount: 5, price: 5.3)
    ])

do {
    // Se algum try der errado, cancela todo o block do Do
    try vendingMachine.getProduct(named: "Bala", with: 2.0)
    try vendingMachine.getProduct(named: "Salgadinho", with: 10.0)
} catch {
    print(error.localizedDescription)
}

/*
 É possível fazer mais de um catch ou colocar um switch dentro do catch (mostra no exemplo abaixo)
*/

//do {
//    try vendingMachine.getProduct(named: "Bala", with: 4.0)
//    try vendingMachine.getProduct(named: "Salgadinho", with: 10.0)
//} catch {
//    switch error {
//    case VendingMachineError.productNotFound:
//        print("Faz algo aqui")
//    default:
//        print("Q")
//    }
//}

