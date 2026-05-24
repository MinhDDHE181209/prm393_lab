void main() {
  print('--- Exercise 2: Collections & Operators ---');
  
  // 1. Create a List of integers
  List<int> scores = [7, 8, 9, 10];
  
  // 2. Use arithmetic & comparison operators
  int totalScore = scores[0] + scores[1]; // Addition (+)
  bool isPass = totalScore >= 10 && scores[0] != 0; // Comparison (>=, !=) and Logical (&&)
  
  print('Sum of first two scores: $totalScore');
  print('Did pass the condition? $isPass');

  // 3. Create a Set (unique values) and a Map (key-value)
  Set<String> subjects = {'Java Web', 'Software Engineering', 'Java Web'}; 
  Map<String, String> studentRoles = {
    'SE123': 'Project Manager',
    'SE124': 'Developer'
  };

  // 4. Use indexing, add(), remove(), and map access
  scores.add(6); // Add to list
  scores.remove(7); // Remove from list
  print('Scores after update: $scores');
  
  // Set only keeps unique values, so 'Java Web' only appears once
  print('Subjects in Set: $subjects'); 
  
  print('Role of SE123: ${studentRoles['SE123']}'); // Map access
}