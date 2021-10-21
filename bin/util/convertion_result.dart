// Clase para controlar la conversion y realizar las condiciones especiales
class ConvertionResult {
  final String convertedNumber;
  final int number;
  final bool isTeen;

  ConvertionResult({
    required this.convertedNumber,
    required this.number,
    this.isTeen = false,
  });

  ConvertionResult.empty({
    this.convertedNumber = '',
    this.number = 0,
    this.isTeen = false,
  });
}
