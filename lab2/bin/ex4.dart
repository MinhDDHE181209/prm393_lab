// 1. Create a class Car with one property and a method
class Car {
  String brand;

  // Constructor
  Car(this.brand);

  // 2. Create a named constructor
  Car.unknown() : brand = 'Unknown Brand';

  void drive() {
    print('$brand is driving with a combustion engine.');
  }
}

// 3. Create a subclass that overrides a method
class ElectricCar extends Car {
  int batteryLife;

  // Call superclass constructor
  ElectricCar(String brand, this.batteryLife) : super(brand);

  // Overriding the drive method
  @override
  void drive() {
    print('$brand is driving silently. Battery left: $batteryLife%');
  }
}

void main() {
  print('--- Exercise 4: Intro to OOP ---');

  // 4. Instantiate objects and print results
  Car normalCar = Car('Toyota');
  normalCar.drive();

  Car weirdCar = Car.unknown();
  weirdCar.drive();

  ElectricCar tesla = ElectricCar('Tesla Model 3', 85);
  tesla.drive();
}