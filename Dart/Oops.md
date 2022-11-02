# Oops in Dart

```
void main(){
  final person = Person();
  print(person.name);
}

class Person{
  String? name;
  int? age;
  double? height;
}
```

Note: You can't declear variable using var or final in class, you need to write Type.

##   Class constructors
```
void main(){
  final person = Person(name: "Matt", age:18, height: 1.6);
  print(person.name);
}

class Person{
  Person({this.name, this.age, this.height});
  final String? name;
  final int? age;
  final double? height;
}
```

##   Class Methods
```
void main(){
  final person = Person(name: "Matt", age:18, height: 1.6);
  print(person.describe());
}

class Person{
  Person({this.name, this.age, this.height});
  final String? name;
  final int? age;
  final double? height;
  
  String describe(){
    return "Hey, I'm $name";
  }
}
```


## Inheritance
```
void main(){
  final person = Person(name: "Matt", age:18, height: 1.6);
  print(person.describe());
  final employee = Employee(texCode: "AB143", salary:50000);
  print(employee.describe());
}

class Person{
  Person({this.name, this.age, this.height});
  final String? name;
  final int? age;
  final double? height;
  
  String describe(){
    return "Hey, I'm $name";
  }
}

class Employee extends Person{
  Employee({this.texCode, this.salary});
  final String? texCode;
  final int? salary;
}
```

##  The super constructor
```
void main(){
  final employee = Employee(name: "Matt", age:18, height: 1.6, texCode: "AB143", salary:50000);
  print(employee.describe());
}

class Person{
  Person({this.name, this.age, this.height});
  final String? name;
  final int? age;
  final double? height;
  
  String describe(){
    return "Hey, I'm $name";
  }
}

class Employee extends Person{
  Employee({String? name, int? age, double? height, this.texCode, this.salary}) 
  : super(name: name, age: age, height: height);
  final String? texCode;
  final int? salary;
}
```

##   Overriding the toString method

```
void main(){
  final employee = Employee(name: "Matt", age:18, height: 1.6, texCode: "AB143", salary:50000);
  print(employee.describe());
  print(employee.toString());
}

class Person{
  Person({this.name, this.age, this.height});
  final String? name;
  final int? age;
  final double? height;
   
  @override
  String toString() => "name: $name, age: $age, height: $height";
  
  String describe(){
    return "Hey, I'm $name";
  }
}

class Employee extends Person{
  Employee({String? name, int? age, double? height, this.texCode, this.salary}) 
  : super(name: name, age: age, height: height);
  final String? texCode;
  final int? salary;
  
  @override
  String toString() => "${super.toString()} and salary: $salary";
}
```
 
 ## Abstract classes

```
void main(){
  final employee = Square(side: 10.0);
  print(employee.area());
}

abstract class Shape{
   double area();
}

class Square implements Shape{
  Square({this.side});
  double? side;
  
  @override
  double area() => side * side;
}
```
