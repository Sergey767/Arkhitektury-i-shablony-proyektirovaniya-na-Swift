import UIKit

protocol Coffee {
    var cost: Int { get }
}

class SimpleCoffee: Coffee {
    
    var cost: Int {
        return 50
    }
}

protocol CoffeeDecorator: Coffee {
    var ingredients: Coffee { get }
    
    init(ingredients: Coffee)
}

class Milk: CoffeeDecorator {
    let ingredients: Coffee
    
    var cost: Int {
        return ingredients.cost + 30
    }
    
    required init(ingredients: Coffee) {
        self.ingredients = ingredients
    }
}

class Whip: CoffeeDecorator {
    let ingredients: Coffee
    
    var cost: Int {
        return ingredients.cost + 40
    }
    
    required init(ingredients: Coffee) {
        self.ingredients = ingredients
    }
}

class Sugar: CoffeeDecorator {
    let ingredients: Coffee
    
    var cost: Int {
        return ingredients.cost + 15
    }
    
    required init(ingredients: Coffee) {
        self.ingredients = ingredients
    }
}

class Сhocolate: CoffeeDecorator {
    let ingredients: Coffee
    
    var cost: Int {
        return ingredients.cost + 20
    }
    
    required init(ingredients: Coffee) {
        self.ingredients = ingredients
    }
}

class NutSyrup: CoffeeDecorator {
    let ingredients: Coffee
    
    var cost: Int {
        return ingredients.cost + 25
    }
    
    required init(ingredients: Coffee) {
        self.ingredients = ingredients
    }
}

var simpleCoffee = SimpleCoffee()
print("цена обычного кофе \(simpleCoffee.cost)")

var milkCoffee = Milk(ingredients: simpleCoffee)
print("цена кофе c молоком без сахара \(milkCoffee.cost)")

var milkAndSugarCoffee = Milk(ingredients: Sugar(ingredients: simpleCoffee))
print("цена кофе с молоком \(milkAndSugarCoffee.cost)")

var whipAndMilkCoffee = Whip(ingredients: milkAndSugarCoffee)
print("цена взбитого кофе с молоком \(whipAndMilkCoffee.cost)")

var chocolateCoffee = Сhocolate(ingredients: Milk(ingredients: Sugar(ingredients: simpleCoffee)))
print("цена кофе с шоколадом и молоком \(chocolateCoffee.cost)")

var nutSyrupCoffee = NutSyrup(ingredients: Sugar(ingredients: simpleCoffee))
print("цена кофе с ореховым сиропом \(nutSyrupCoffee.cost)")

