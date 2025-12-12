import UIKit

var greeting = "Hello, playground"
var abcd = 1

var multiline = """
I am a multiline String.
I might look weird, but I am really very simple.
At times I could be very useful!
"""
print(multiline)

var myNum: Float = 12.5
print(myNum)
print(type(of: myNum))

var intNum:Float = 13
print(intNum)
print(    "My Double number is \(myNum). My number is \(myNum). And, my multiline string is \(multiline)")




// COLLECTIONS

// 1. ARRAY - store same kind of values

// EMPTY ARRAY
var carMakes = [String]()

// INITIALIZED ARRAY
var carMakesSecond = ["Toyota", "Honda"]


// 2. SET - store diff kind of values but unique only

// Creating an empty set of strings...
var colors = Set<String>()

// working with a set where we will not change the elements in the future
let immuatableColors = Set(["blue", "black", "red"])


// 3. TUPLE - store diff kind of values, cannot add or remove but can update the values
// Simple tuple
var myTuple = ("Mark", 20)
// We can also define the names of the elements
var yourTuple = (name:"Julie", age:23)

//print tuples
print("myTuple: \(myTuple), yourTuple: \(yourTuple)")



// 4. DICTIONARY - store data in key value pairs
/*
 The keys can be of any type.
 The values can be of any type.
 Once a dictionary is created,
 The type for all keys has to be the same.
 The type for all values has to be the same.
 */

// CREATE EMPTY DICTIONARY
var carCounts = [String: Int]()


// CREATE DICTIONARY WITH PREDEFINED VALUES
var carCounts = [
    "Toyota": 2,
    "Mazda": 1,
    "Honda":10
]

print(carCounts)
