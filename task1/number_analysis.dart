// Task 1: Number Analysis App
// Name: Mussie Workneh
// ID: ATE/9096/15

void main() {
  // create a list of numbers
  final List<int> numbers = [34, -7, 89, 12, -45, 67, 3, 100, -2, 55];
  int maxNumber = findMax(numbers); 
  int minNumber = findMin(numbers); 
  int sum = calculateSum(numbers); 
  double average = calculateAverage(numbers);
  int negatives = countNegative(numbers);
  List<int> sortedList = selectionSort(numbers);
  // here we display the result by using string interpolation "${}"
  // to add the variables declared above
  print("Number Analysis Result");
  print("======================");
  print("Numbers: $numbers");
  print("Maximum Value: $maxNumber");
  print("Minimum Value: $minNumber");
  print("Sum          : $sum");
  print("Average      : $average");
  print("Negative Number(s): $negatives");
  print("Sorted List  : $sortedList");
}
// find the maximum number from a list of integers
int findMax(List<int> numbers) {
  // identifies the list is empty or not before continuing. stops if empty.
  if (numbers.isEmpty) return 0;  
  int max = numbers[0]; // set the first value as the maximum
  // compare the initial value(max) with the rest of numbers in the list
  for (int i = 1; i < numbers.length; i++) {
    // if the number is lessthan max value we skip it
    if (numbers[i] <= max) continue;
    // if the number is greaterthan max we set that number as the new max value
    max = numbers[i];
  }
  return max; // finally return the maximum value
}
// find the minimum number from a list of integers
int findMin(List<int> numbers) {
  // identifies the list is empty or not before continuing. stops if empty.
  if (numbers.isEmpty) return 0; 
  int min = numbers[0]; // set the first value as the minimum
  for (int i = 1; i < numbers.length; i++) {
    // if the number is greaterthan min value we skip it
    if (numbers[i] >= min) continue;
    // if the number is lessthan min we set that number as the new min value
    min = numbers[i];
  }
  return min; // finally return the minimum value
}
// calculate the sum of numbers in the list
int calculateSum(List<int> numbers) {
  // identifies the list is empty or not before continuing. stops if empty.
  if (numbers.isEmpty) return 0; 
  int sum = 0; // initialize variable "sum" to store the calculated value
  for (int number in numbers) {
    sum += number; // we add each numbers in the list to "sum"
  }
  return sum; // finally return the calculated value
}
// calculate the average of numbers in the list
double calculateAverage(List<int> numbers) {
  // identifies the list is empty or not before continuing. stops if empty.
  if (numbers.isEmpty) return 0; 
  // instead of writting the code we did in "calculateSum" we simply call it
  // then divide it to the length of the list will give us the average value of the list
  double average = calculateSum(numbers) / numbers.length; // we store the average value in a variable
  return average; // finally return the calculated value
}
// count how many negative numbers there are
int countNegative(List<int> numbers){
  /* identifies if there are any negative numbers in the list or if it is null.
    this is made to clearify initialy before itterating or searching the list
    and if the min number is positive there is no way we could find a negative number 
    in the list so wew reduse the cost of itterating before hand
  */
  if(findMin(numbers) >= 0 || numbers.isEmpty){
    return 0; // returns 0 if the min number is positive or empty list
  }
  int count = 0; // declare a variable for the count
  // itterates through the number list
  for(int number in numbers) {
    if (number < 0) count++; // if there is a negative number the count will go up by 1
  }
  return count; // return the number of negatives in the list
}
// selection sort algorithm for ordering elements in increasing order
List<int> selectionSort(List<int> numbers) {
  for (int i = 0; i < numbers.length - 1; i++){
    int minPos = i; // we take the initial position as a min value position
    // compare the starting position value(minPos) with the rest of elements 
    // to find the current min value(excludind the sorted part)
    for (int j = i + 1; j < numbers.length; j++){
      // search for a number that is lessthan the value in minPos
      if(numbers[j] < numbers[minPos]){
        // if the value in j is lessthan minPos we take that as the new position of the min value
        minPos = j;
      }  
    }
    // checks if there is a another min value
    if (minPos != i){
      // switch the values of the initial(i) and current(minPos) position values
      int temp = numbers[i]; // a dummy variable that keeps i's value from getting lost
      numbers[i] = numbers[minPos];
      numbers[minPos] = temp;
    }
  }
  return numbers; // gives back the sorted value of the list
}