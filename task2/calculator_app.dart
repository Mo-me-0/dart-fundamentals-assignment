// Task 1: Calculator App
// Name: Mussie Workneh
// ID: ATE/9096/15

import "dart:async";
class Calculator{
  final String name;
  static Duration duration = Duration(seconds: 1, milliseconds: 500); // a time of 1.5 seconds
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
        throw ArgumentError("Unknown operation: $operation."); 
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
    }catch(e){ // captures thrown errors from performing the computation in try
      print("Error $e");// display the error
    }
  }
}
Future<void> main() async{
  final cal = Calculator("MyCalculator"); // create an instance(object) of Calculator
  print("--- ${cal.name} ---");
  await cal.displayResults(10, 4, "add");
  await cal.displayResults(10, 4, "subtract");
  await cal.displayResults(10, 4, "multiply");
  await cal.displayResults(10, 4, "divide");
  await cal.displayResults(15, 3, "divide");
  await cal.displayResults(10, 0, "divide");
  await cal.displayResults(10, 4, "square");
  print("All Calculations Completed!");
}