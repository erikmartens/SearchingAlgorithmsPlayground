//: [Return to the Table of Contents](Table%20of%20Contents) | [Next](@next)
//:
//: ---
//: ## Linear Searching
//: ---
//:
//: ### About
//:
//: Linear or sequential searching is the simplest searching algorithm. Bascially you go through you entire set until you find what you are looking for. Or in the case of trying to find multiple identical entries, looking at every single element. It is a bit like when you loose your key and look into every drawer in your house until finding it. For this reason the algorithm has a very high complexity, meaning that it requires a lot of comparisons between the search key and the elements of the set. But it is the only one of the shown algorithms that works with unsorted sets.
//:
//: ### Complexity (Number of Comparisons)
//:
//: - _Best Case:_ 1 (first element)
//: - _Worst Case:_ n (n = total number of elements)
//: - _Average (Succesful):_ n/2
//: - _Average (Unsuccesful):_ n
//:
//: ---
//:
//: ### Before Starting
//:
//: A visual representation is a great aid for getting ideas accross. When seeing anything for the first time, it may help to grasp the concept in a playful manner first. Therefore before jumping into implementation, take a look at the [visual representation of linear searching](Interactive%20Demonstration). It is interactive too.
//:
//: ---
//:
//: ### Lesson 1 - Let's get Started - A Simple Implementation
//:
//: The following implementation is a very simple adaptation of the linear searching algorithm. Try to understand it before moving on. This algorithm only works for Integer Arrays and returns the first hit, then terminates. The function returns an optional Int `Int?` because the set may not contain the searched value.
//:
//: ---

func linearSearchFor(integer key: Int, inArray set: [Int]) -> Int? {
    // loop through the entire set
    for i in 0..<set.count {
        
        // compare every search key to the current element from the set
        if key == set[i] {
            
            // return the element at the current index if the comparison succees
            return set[i]
        }
    }
    
    // return nil if nothing was found
    return nil
}

//: ---
//:
//: Let's modify the algorithm to give us the number of comparisons...
//:
//: ---

func linearSearchComparisonsFor(integer key: Int, inArray set: [Int]) -> Int? {
    
    // added a variable to store the amount of comparisons
    var comparisons = 0
    
    for i in 0..<set.count {
        
        // a comparison has occured, up the count
        comparisons += 1
        
        if key == set[i] {
            return comparisons
        }
    }
    
    // return the number of comparisons after an unsuccessful run
    return comparisons
}

//: ---
//:
//: ...and then try it on the four complexity cases:
//: 1. The searched element is at the first position of the set (`index = 0` in the Array)
//: 2. The searched element is at the middle of the set
//: 3. The searched element is at the last position of the set (`index = array.count - 1`)
//: 4. The searched element is not a part of the set
//:
//: ---

let mySet = [76, 23, 104, 59, 9, 1, 200, 7, 8, 6, 16, 76, 76, 23, 28, 99, 104, 1, 12] // array.count == 19

// Case 1
let myKey1 = 76
linearSearchComparisonsFor(integer: myKey1, inArray: mySet)

// Case 2
let myKey2 = 6
linearSearchComparisonsFor(integer: myKey2, inArray: mySet)

// Case 3
let myKey3 = 16
linearSearchComparisonsFor(integer: myKey3, inArray: mySet)

// Case 4
let myKey4 = 44
linearSearchComparisonsFor(integer: myKey4, inArray: mySet)

//: ---
//:
//: ### Lesson 2 - Making the Algorithm More Advanced
//:
//: With Swift the already short algorithm can become even shorter. The Swift syntax allows for loops with built in conditions. This may especially be interesting if you are coming from a different programming language where such a swift syntax (pun intended) is not available. Have a look:
//:
//: ---

func swiftLinearSearchFor(integer key: Int, inArray set: [Int]) -> Int? {
    for i in 0..<set.count where key == set[i] {
        return set[i]
    }
    return nil
}

//: ---
//:
//: ### Lesson 3 - Finding Every Occurance
//:
//: Getting only the first hit usually is not very helpful. What if you are searching through a list of contacts and two people have the same last name? What if the returned result isn't the person you are looking for? No matter whether the list is sorted or not, the result may not be the desired person. We will now modify the algorithm, to give us every result. You should already have an idea how this may look like...:
//:
//: ---

func linearSearchForEvery(integer key: Int, inArray set: [Int]) -> [Int]? {
    // a container for the results
    var results = [Int]()
    
    // loop through the set and log every hit
    for i in 0..<set.count where key == set[i] {
        results.append(set[i])
    }
    
    // Only return the array if there was at least one hit
    if !results.isEmpty {
        return results
    }
    return nil
}

//: ---
//:
//: Let's see it in action:
//:
//: ---

let searchResults = linearSearchForEvery(integer: 76, inArray: mySet)

//: ---
//:
//: ### Lesson 4 - Providing Context
//:
//: The previous results probably were not too exciting. We already knew the keys beforehand, why search for them and them get them again? Where's the real life application here? Let's use an array type collection to make sense of all we have learned so far. Let's suppose you have a lot of files a folder and you want to get the contents of a specific file returned:
//:
//: ---

let myFiles: [String: String] = ["homework": "6C6F72656D20697073756D", "scholarship_application": "49276420626520736F20686170707921", "presentation": "312D392D3230303720393A3431504454", "addressBook": "687474703A2F2F6572696B6D617274656E732E6465"]

//: ---
//:
//: > The following function already uses the Swift syntax for accessing collections, but underneath a searching algorithm is doing the work.
//:
//: We need to modify the algorithm, before it can deal with the collection above:
//:
//: ---

func linearSearchForEvery(string key: String, inCollection arrayCollection: [String: String]) -> String? {
    
    // access the value via the key, keep in mind that the key-value-pair may not exist
    guard let result = arrayCollection[key] else {
        return nil
    }
    return result
}

//:
//: ---
//:
//: Afterwards we can see the result:
//:
//: ---

let fileContent = linearSearchForEvery(string: "homework", inCollection: myFiles)


//: ---
//:
//: ### Bonus Lesson - Providing Further Context by Searching Within a Text Passage
//: _Advanced_
//:
//: Now that you know how linear searching functions, we can move on to more advanced stuff. In the following we will take it to the next level, by searching for a word within a sentence. The algorithm will look for every occurence of the search phrase. Instead of just returning the searched string, let's modify it, to show that it worked (simulating the highlighting of the string, when searching through a long document). The function therefore will return a Boolean <Bool>, which will be true if the string was found and modified. Take a look at the implementation first:
//:
//: > It is typically not a good practice to modify function parameters within the function itself. With Swift this is only possible, when the parameters are marked with the keyword `inout`, making it easy for the user of the function to understand its nature. Otherwise parameters are constants. However in other programming languages a fail safe may not be built in.
//:
//: ---

import Foundation

func linearSearchFor(string key: String, inPassage inputString: inout String) -> Bool {
    
    // we need to remeber whether there was a modification
    var didModifyInput = false
    
    // we will separate the passage into words and store the before comparing them to the key
    var words = inputString.components(separatedBy: " ")
    
    // loop through the array containing the individual words and modify every occurance
    for i in 0..<words.count where words[i] == key {
        
        // perform the modification
        words[i] = words[i].uppercased()
        
        // there was a modification, let's rememeber it
        didModifyInput = true
    }
    
    // put the passage back together and override the original
    inputString = words.reduce("") { a, b in
        "\(a) \(b)"
    }
    
    // tell whether there was a modification
    return didModifyInput
}

//: ---
//:
//: The result will be displayed via the console, via the `print()` statement. You can see the result by activating the console. Let's see what we get:
//:
//: ---

var myPassage = "I thoroughly enjoy coding with Swift. The language very advanced and a lot of fun. Do you also enjoy using Swift?"
linearSearchFor(string: "enjoy", inPassage: &myPassage)
print(myPassage)

//: ---
//:
//: [Return to the Table of Contents](Table%20of%20Contents) | [Next](@next)
