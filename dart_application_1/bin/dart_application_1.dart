void main() {
  // 1 & 2. Declare variables using core types
  String name = 'Minh';
  int age = 22;
  double gpa = 8.5;
  bool isGraduatingSoon = true;

  // 3. Use print() and string interpolation ($var, ${expr})
  print('--- Exercise 1: Student Info ---');
  print('Name: $name');
  print('Age: $age');
  
  // Using expressions inside ${}
  print('Current GPA: $gpa. Is GPA excellent? ${gpa >= 8.0 ? "Yes" : "No"}');
  print('Graduating soon: $isGraduatingSoon');
}