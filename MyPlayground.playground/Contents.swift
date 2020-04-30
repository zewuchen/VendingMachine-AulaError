import Foundation

struct VendingMachineProduct {
    var name: String
    var amount: Int
    var price: Double
}

class VendingMachine {
    private var estoque: [VendingMachineProduct]
    
    init(products: [VendingMachineProduct]) {
        self.estoque = products
    }
    
    func getProduct(named name: String, with money: Double) throws {
        
    }
    
    func getTroco() -> Double {
        
    }
}

