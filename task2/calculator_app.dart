// Task 1: Calculator App
// Name: Mussie Workneh
// ID: ATE/9096/15

import "dart:async";
class Calculator{
  final String name;
  static Duration duration = Duration(seconds: 1, milliseconds: 500); // a time of 1.5 seconds
  List<String> historyLog = []; // a list to store a record of compiled calculations
  // this constractor automatically assignes the entered parameter to name.
  Calculator(this.name){}
  // for add, subtruct and multiply, they return after performing the approprate opperation
  double add(double a, double b) => a + b;
  double subtract(double a, double b) => a - b;
  double multiply(double a, double b) => a * b;
  // for divide we first check if the devisor is 0 and gives an error if zero
  double divide(double a, double b){
    if (b == 0){
      throw ArgumentError("Can not divide by zero.");
    }
    return a / b; // gives the result if b is not zero
  }
  // computeAsync computes the given number according to the operation after some delay
  Future<double> computeAsync(double a, double b, String operation) async{
    double result;// a variable to store the final result
    // identify which operation is asked
    switch(operation){
      case "add":
        result = this.add(a, b);
        break;
      case "subtract":
        result = this.subtract(a, b);
        break;
      case "multiply":
        result = this.multiply(a, b);
        break;
      case "divide":
        result = this.divide(a, b);
        break;
      default:
        //gives an error if the operation doesn't exist
        throw UnknownOperation(operation); 
    }
    await Future.delayed(duration);// creates a delay of 1.5 seconds 
    return result;// gives the computed result if the operation exists
  }
  // show the results on console/terminal
  Future<void> displayResults(double a, double b, String operation) async{
    /*
      since there are some thrown errors in divide and computeAsync
      we catch the errors to display approprately
    */
    try{
      final double result = await this.computeAsync(a, b, operation); // hold till the value is computed
      print("$operation($a, $b) = $result"); // display the result withthe method used
      this.historyLog.add("$operation($a, $b) = $result"); // record in history log
    } catch(e){ // captures thrown errors from performing the computation in try
      print("Error $e");// display the error
    }
  }
  /* 
    to display the results for chain computing operations
    which is the same as displayResults except taking list of numbers
  */
  Future<void> displayChainedResults(List<double> numbers, String operation) async{
    try {
      final double result = await this.computeChained(numbers, operation);
      print("$operation$numbers = $result");
      this.historyLog.add("$operation$numbers = $result");
    } catch (e){
      print("Error $e");
    }
  }
  // displays all past calculation
  Future<void> printHistory() async{
    await Future.delayed(duration); // waits 1.5 seconds
    print("--- ${this.name} History Log ---"); // a title
    // itterate through the list to display each log in a separate line
    for (String history in this.historyLog){
      print(history);
    }
    print("--------------------------------"); // to show the end of the log
  }
  //  applies the operation sequentially across all values in a given list
  Future<double> computeChained(List<double> numbers, String operation) async{
    double result;
    switch (operation){
      case "adding":
        result = numbers.fold(0, (previous, element) => add(previous, element));
        break;
      case "multiplying":
        result = numbers.fold(1, (previous, element) => multiply(previous, element));
      default:
        throw UnknownOperation(operation);
    }
    await Future.delayed(duration);
    return result;
  }
}
// custom exception class for wrong operations used
class UnknownOperation implements Exception{
  // we can't extend from Exception because it is an abstruct interface class
  final String message; // the variable to hold  
  UnknownOperation(this.message);
  /*
    to show we are overriding the parent's function we use "@override"
    it is not required but it is great for readability
  */
  @override  
  String toString() => "Unknown Operation: $message"; // shows the custom message we want
}
Future<void> main() async{
  final cal = Calculator("MyCalculator"); // create an instance(object) of Calculator
  print("--- ${cal.name} ---");
  print("Case 1: Sequential execution");
  final start1 = DateTime.now();
  await cal.displayResults(10, 4, "add");
  await cal.displayResults(10, 4, "subtract");
  await cal.displayResults(10, 4, "multiply");
  await cal.displayResults(10, 4, "divide");
  await cal.displayResults(15, 3, "divide");
  await cal.displayResults(10, 0, "divide");
  await cal.displayResults(10, 4, "square");
  await cal.displayChainedResults([1, 2, 3, 4], "adding");
  await cal.displayChainedResults([1, 2, 3, 4], "multiplying");
  await cal.displayChainedResults([1, 2, 3, 4], "dividing");
  print("All Calculations Completed!\n");
  await cal.printHistory(); 
  final end1 = DateTime.now();
  print("\nCase 2: Parallel execution");
  final start2 = DateTime.now();
  await Future.wait([
    cal.displayResults(10, 4, "add"),
    cal.displayResults(10, 4, "subtract"),
    cal.displayResults(10, 4, "multiply"),
    cal.displayResults(10, 4, "divide"),
    cal.displayResults(15, 3, "divide"),
    cal.displayResults(10, 0, "divide"),
    cal.displayResults(10, 4, "square"),
    cal.displayChainedResults([1, 2, 3, 4], "adding"),
    cal.displayChainedResults([1, 2, 3, 4], "multiplying"),
    cal.displayChainedResults([1, 2, 3, 4], "dividing"),
    cal.printHistory()
  ]);
  final end2 = DateTime.now();
  print("\nTime taken for sequential execution: ${end1.difference(start1)}");
  print("Time taken for parallel execution: ${end2.difference(start2)}");
  /**
   * When awaiting each displayResult(), it took about 12 seconds and
   * When using Future.await(), it took about 1.51 seconds
   * This is because Future.await() is computing the operations parallely.
   * Parallel computing is faster because all the operations are starts and
   * runs at the same time so, the time it finishes is smaller.
   * 
   * To find the time it takes to perform each cases, I created a DateTime variable
   * to store the time that operation starts and ends at the beginning and ending of 
   * each sections respectively. Finally, finding the differences between the end and start 
   * gave us the total time it takes to compute each cases.
  */
}