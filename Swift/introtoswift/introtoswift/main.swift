//
//  main.swift
//  introtoswift
//
//  Created by Zhou Ti on 22/6/17.
//  Copyright © 2017 com.MMT-AGENT. All rights reserved.
//

import Foundation
//let individualScores = [75, 43, 103, 87, 12]
//
//var teamscore = 0
//
//for i in individualScores {
//    if i > 50 {
//        teamscore += 3
//    } else {
//        teamscore += 1
//    }
//}
//
//print(teamscore)

//var greeting = "hello"
//var name: String? = "roger federer"
//if name != nil {
//    greeting = "hello, \(name!)"
//} else {
//    greeting = "hello, Ti"
//}
//print(greeting)

//let nickName: String? = nil
//let fullName: String = "John Appleseed"
//let informalGreeting = "Hi \(nickName ?? fullName)"
//
//let vegtable: String = "red pepper"
//switch vegtable {
//case "apple":
//    print("it's an apple")
//case let y where y.hasPrefix("red"):
//    print("no, i don't like it, it's \(y)")
//default: break
//}

//let interestingNumbers = [
//    "Prime": [2, 3, 5, 7, 11, 13],
//    "Fibonacci": [1, 1, 2, 3, 5, 8],
//    "Square": [1, 4, 9, 16, 25],
//]
//var largest = 0
//for (_, numbers) in interestingNumbers {
//    for number in numbers {
//        if number > largest {
//            largest = number
//        }
//    }
//}
//print(largest)

//var total = 0
//for i in 0..<5 {
//    total += i
//}
//print(total)
//var total = 5
//for i in 5..<20 {
//    total += 1
//}
//print(total)
//
//func sum(a: Int, b: Int) -> (){
//    print("\(a + b)")
//}
//sum(a: 1, b: 2)

//func statics(num: [Int]) -> (min: Int, max: Int, avg: Int) {
//    var l = 0
//    var s = 100
//    var sum = 0
//    for i in num {
//        if i > l {
//            l = i
//        }
//        if i < s {
//            s = i
//        }
//        sum += i
//    }
//    let avg = sum / (num.count)
//    return (s, l, avg)
//}
//
//let num = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
//print(statics(num: num).avg)

//class Animal {
//    var name: String
//    init(name: String) {
//        self.name = name
//    }
//    func display() {
//        print("name is \(self.name)")
//    }
//}
//
//class Monkey: Animal {
//    var sex: String = ""
//    init(name: String, sex: String) {
//        self.sex = sex
//        super.init(name: name)
//    }
//    override func display() {
//        print("name is \(self.name). sex is \(self.sex)")
//    }
//}
//
//var a: Animal = Animal(name: "cat")
//a.name = "dog"
//a.display()
//var b: Monkey = Monkey(name: "monkey", sex: "male")
//b.display()




















