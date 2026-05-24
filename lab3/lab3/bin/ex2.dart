import 'dart:convert';

// 1. Create User class and User.fromJson constructor
class User {
  final String name;
  final String email;

  User({required this.name, required this.email});

  // Factory named constructor to parse Map data into User object
  User.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? 'Unknown',
        email = json['email'] ?? 'No Email';
}

class UserRepository {
  // 3. Use Future<List<User>> to return parsed data
  Future<List<User>> fetchUsersFromApi() async {
    // 2. Simulate JSON array response string from an API
    String mockRawJsonResponse = '''
    [
      {"name": "Duong Duc Minh", "email": "minhdd@fpt.edu.vn"},
      {"name": "Nguyen Hoang Trang", "email": "trangnh@gmail.com"},
      {"name": "Alex Johnson", "email": "alex.j@example.com"}
    ]
    ''';

    // Simulate network delay
    await Future.delayed(Duration(seconds: 1));

    // Decode the raw JSON string into a dynamic Dart List
    List<dynamic> decodedList = jsonDecode(mockRawJsonResponse);

    // Map each structure into a User instance and convert to a strongly-typed List
    return decodedList.map((item) => User.fromJson(item)).toList();
  }
}

void main() async {
  print('--- Exercise 2: User Repository with JSON ---');
  final userRepo = UserRepository();

  print('Calling API to fetch user accounts...');
  List<User> userList = await userRepo.fetchUsersFromApi();

  // 4. Display results with print()
  print('\nSuccessfully parsed ${userList.length} users:');
  for (var user in userList) {
    print('-> Name: ${user.name} | Contact: ${user.email}');
  }
}