import 'dart:io';
import 'dart:math';
import 'converter.dart';

void main() {
  // _testWithInput();
  _testWithLoop();
}

// Prueba ingresando un numero [max: 999999999.99]
void _testWithInput() {
  stdout.write('Escriba un numero: ');
  String? inputValue = stdin.readLineSync();
  if (inputValue != null) {
    String convertedNumber = converter(inputValue);
    print(convertedNumber);
  }
}

// Prueba ingresando un numero de repeticiones aleatorias
void _testWithLoop() {
  stdout.write('Escriba un numero maximo de valores aleatorios: ');
  String? inputValue = stdin.readLineSync();
  if (inputValue != null) {
    for (int i = 0; i < int.parse(inputValue); i++) {
      int number = Random().nextInt(1000000000);
      int decimal = Random().nextInt(100);
      String numberString = '$number.$decimal';
      String convertedNumber = converter(numberString);
      print(convertedNumber);
    }
  }
}
