# A tour of the Dart language


## A basic Dart program

```
// Define a function.
void main(){
  String name = "Akarsh";
  print("Hey, I'm $name");
}
```
Note: To define Strings in dart you can use both single and double quotes.

## String interpolation -> 
``` 
$String 
// for expressions
${String.length}
```

Note: Can use Var to declear type at compile time. 
    ### (var = mutable)
    ### (final = immutable)

Dart supports nullable and non-nullable versions of the the following built-in types:

- Numbers (num, int, double)
- Strings (String)
- Booleans (bool)
- Lists (List, also known as arrays)
- Sets (Set)
- Maps (Map)
- Symbols (Symbol)
- The value null (Null) 
- Dynamic

In Dart, constant variables must contain constant values. However, non-constant variables can still contain constant values, and values themselves can also be marked const.

```
var foo = const []; // foo is not constant, but the value it points to is.
  // You can reassign foo to a different list value,
  // but its current list value cannot be altered. 

const baz = []; // Equivalent to `const []`
```
## Optional parameters, nullability and default values
```
String person(String name, [int? age = 0.0]){
  return "$name $age ";
}

```

## Named parameters
```
String person({String name, int age}){
  return "$name $age ";
}

print(person(name: "Matt", age: 28));
```

##  Arrow operator
```
String person(String name, [int? age]) =>
  "$name and height is $age ";
```
