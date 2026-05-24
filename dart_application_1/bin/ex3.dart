// 4. Create functions using normal and arrow syntax
// Normal syntax
String checkGrade(double score) {
  if (score >= 8.0) return 'Good';
  if (score >= 5.0) return 'Pass';
  return 'Fail';
}

// Arrow syntax
int calculateCredits(int subjects, int creditsPerSubject) => subjects * creditsPerSubject;

void main() {
  print('--- Exercise 3: Control Flow & Functions ---');

  // 1. Write an if/else block to check score
  double myScore = 7.5;
  print('Score: $myScore -> Result: ${checkGrade(myScore)}');

  // 2. Write a switch case for day of week
  int day = 3;
  switch (day) {
    case 1:
      print('Monday: Code UI');
      break;
    case 2:
      print('Tuesday: Setup Database');
      break;
    case 3:
      print('Wednesday: Write API');
      break;
    default:
      print('Other day: Relax');
  }

  // 3. Loop through a collection
  List<String> techStack = ['Dart', 'Flutter', 'Firebase'];

  print('\n-- Using standard for loop --');
  for (int i = 0; i < techStack.length; i++) {
    print('Tech $i: ${techStack[i]}');
  }

  print('\n-- Using for-in loop --');
  for (String tech in techStack) {
    print('Learning $tech');
  }

  print('\n-- Using forEach() --');
  techStack.forEach((tech) => print('Mastering $tech'));

  // Test arrow function
  print('\nTotal credits for 3 subjects: ${calculateCredits(3, 3)}');
}