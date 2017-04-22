//: [Return to the Table of Contents](Table%20of%20Contents) | [Next](@next)
//:
//: ---
//: ## Binary Searching
//: ---
//:
//: ### About
//:
//: The binary search algorithm is based on the devide and conquer principle and requires a sorted set. It is very efficient because it can make generate a statement with much fewer comparisons compared to the linear search. The idea behind it is that always checks the middle element of a set. If it is not the searched value, it will either continue with the left-side or right-side sub-set, depending on whether the key is smaller or larger than the value at the middle position. The process then starts over with the consequent sub-set.
//:
//: ### Complexity (Number of Comparisons)
//:
//: - _Best Case:_ 1 (middle element)
//: - _Worst Case:_ ~log(2)n (n = total number of elements)
//: - _Average (Succesful):_ ~log(2)n
//: - _Average (Unsuccesful):_ ~log(2)n
//:
//: ---
//:
//: ### Before Starting
//:
//: A visual representation is a great aid for getting ideas accross. When seeing anything for the first time, it may help to grasp the concept in a playful manner first. Therefore before jumping into implementation, take a look at the [visual representation of binary searching](Interactive%20Demonstration). It is interactive too.
//:
//: ---
//:
//: ### Lesson 1 - Let's get Started - A Simple Implementation
//:
//: The following implementation is a very simple adaptation of the binary searching algorithm. Try to understand it before moving on. This algorithm only works for Integer Arrays and returns the first hit, then terminates. The function returns an optional Int `Int?` because the set may not contain the searched value. In this first lesson we will take a look at an iterative implementation.
//:
//: ---

func binaryIterativeSearchFor(integer key: Int, inArray set: [Int]) -> Int? {
    
    // we will store the bounds of the current sub-set
    var lowerBound = 0
    var upperBound = set.count - 1
    
    // we are comparing the middle value of the subset until the subset has a length of zero
    while lowerBound <= upperBound {
        // rememeber the current middle index
        let middle = Int((lowerBound + upperBound)/2)
        
        // key was found
        if key == set[middle] {
            return set[middle]
        
        // key was not found, can only be contained in the left-side subset
        } else if key < set[middle] {
            upperBound = middle - 1
            
        // key was not found, can only be contained in the right-side subset
        } else {
            lowerBound = middle + 1
        }
    }
    
    // we did not find anything
    return nil
}

//: ---
//:
//: Let's modify the algorithm to give us the number of comparisons...
//:
//: ---

func binaryIterativeSearchComparisonsFor(integer key: Int, inArray set: [Int]) -> Int {
    // added a variable to store the amount of comparisons
    var comparisons = 0
    var lowerBound = 0
    var upperBound = set.count - 1
    
    while lowerBound <= upperBound {
        
        // a comparison occurs every time this loop is entered
        comparisons += 1
        
        let middle = Int((lowerBound + upperBound)/2)
        
        if key == set[middle] {
            return comparisons
        } else if key < set[middle] {
            upperBound = middle - 1
        } else {
            lowerBound = middle + 1
        }
    }
    
    // return the number of comparisons after an unsuccessful run
    return comparisons
}

//: ---
//:
//: ...and then try it on the four complexity cases:
//: 1. The searched element is at the first position of the set (`index = 0` in the Array)
//: 2. The searched element is at the middle of the set (`index = Int(array.count / 2)` in the Array)
//: 3. The searched element is at the last position of the set (`index = array.count - 1`)
//: 4. The searched element is not a part of the set
//:
//: ---

var mySet = [76, 23, 104, 59, 9, 1, 200, 7, 8, 6, 16, 76, 76, 23, 28, 99, 104, 1, 12] // array.count == 19
mySet.sort()

// Case 1
let myKey1 = 1
binaryIterativeSearchComparisonsFor(integer: myKey1, inArray: mySet) // compared to 1 comparison with linear searching

// Case 2
let myKey2 = 23
binaryIterativeSearchComparisonsFor(integer: myKey2, inArray: mySet) // compared to 10 comparison with linear searching

// Case 3
let myKey3 = 200
binaryIterativeSearchComparisonsFor(integer: myKey3, inArray: mySet) // compared to 11 comparison with linear searching

// Case 4
let myKey4 = 44
binaryIterativeSearchComparisonsFor(integer: myKey4, inArray: mySet) // compared to 19 comparison with linear searching

//: > We see that binary search has a clear advantage over the linear approach. No matter where the element is or if it is inlcuded at all, the average amount of comparisons is ~log(2)n.
//: ---
//:
//: ### Lesson 2 - Making the Algorithm More Advanced
//:
//: With Swift's declarative syntax it is easy to build a recursive version of the algorithm that is based on a single function. Have a look:
//:
//: ---

func binaryRecursiveSearchFor(integer key: Int, inArray set: [Int]) -> Int? {
    
    // declare the recursive function: the inner function will be called recursively with the new bounds
    func binarySearchFor(integer key: Int, inArray set: [Int], withLowerBound lower: Int, withUpperBound upper: Int) -> Int? {
        if upper < lower {
            return nil
        }
        
        let middle = Int((lower + upper)/2)
        
        if key == set[middle] {
            return set[middle]
        } else if key < set[middle] {
            return binarySearchFor(integer: key, inArray: set, withLowerBound: lower, withUpperBound: middle - 1)
        } else {
            return binarySearchFor(integer: key, inArray: set, withLowerBound: middle + 1, withUpperBound: upper)
        }
    }
    
    // start the procedure
    return binarySearchFor(integer: key, inArray: set, withLowerBound: 0, withUpperBound: set.count - 1)
}

//: ---
//:
//: ### Bonus Lesson - The Swifter Version
//:
//: The algorithm now is recursive instead of iterative, but can we make it shorter?
//:
//: ---

func binarySwiftRecursiveSearchFor(integer key: Int, inArray set: inout [Int]) -> Int? {
    let middle = Int((set.count - 1)/2)
    
    if set.isEmpty {
        return nil
    }
    if key == set[middle] {
        return set[middle]
    }
    
    var subset = Array(set[0..<middle])
    if key > set[middle] {
        subset = Array(set[(middle + 1)..<set.count])
    }
    return binarySwiftRecursiveSearchFor(integer: key, inArray: &subset)
}

//: > We are modifying a parameter that was passed into to the function. This is usually not good practice as the user of the function must remember to make a copy of the asset first, in case the modification is unwanted. This example was created to show you the power of the Swift Syntax.
//: ---
//:
//: [Return to the Table of Contents](Table%20of%20Contents) | [Next](@next)
