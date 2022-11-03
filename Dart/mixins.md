## Mixins

```
mixin BMI{
  double calculteBMI(double? weight, double? height){
    return weight / (height * height);
  }
}

class Person with BMI {
  Person({this.name, this.age, this.height, this.weight});
  final String? name;
  final int? age;
  final double? height;
  final double? weight;
  
  double get bmi => calculteBMI(weight, height);
}

void main(){
  final person = Person(name: "Matt", age: 18, height: 1.2, weight: 9.2);
  print(person.bmi);
} 
```
