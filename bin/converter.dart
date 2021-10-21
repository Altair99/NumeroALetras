import 'util/convertion_result.dart';
import 'util/converter_values.dart';

String converter(String number) {
  String convertedNumber = '';
  String decimal = '00';

  // Dividimos el numero para obtener los dicimales por separado
  List<String> splitNumbers = number.split(RegExp(r'[.]'));
  if (splitNumbers.length > 1) {
    number = splitNumbers[0];
    decimal = splitNumbers[1];
  }

  if (number.length > 9) {
    return 'Valor demasiado grande, el limite del numero es 999,999,999';
  }
  if (int.parse(number) == 0) return '0 -> cero 00/100 M.N';

  // Obtenemos una lista se strings que contengan grupos de 3 digitos
  List<String> subNumbers = _getSubNumbers(number);

  List<String> convertedNumbers = [];
  for (String str in subNumbers) {
    ConvertionResult hundred = ConvertionResult.empty();
    ConvertionResult ten = ConvertionResult.empty();
    ConvertionResult unit = ConvertionResult.empty();
    if (str.length == 3) {
      hundred = _getHundred(str[0]);
      ten = _getTen(str[1], unitNumber: str[2]);
      unit = _getUnit(str[2], ten);
    } else if (str.length == 2) {
      ten = _getTen(str[0], unitNumber: str[1]);
      unit = _getUnit(str[1], ten);
    } else if (str.length == 1) {
      unit = _getUnit(str[0], ten);
    }
    convertedNumbers.add(
      hundred.convertedNumber + ten.convertedNumber + unit.convertedNumber,
    );
  }

  for (int i = 0; i < convertedNumbers.length; i++) {
    if (i == 1) {
      convertedNumber = '${convertedNumbers[i]} mil' + convertedNumber;
    } else if (i == 2) {
      convertedNumber = '${convertedNumbers[i]} millones' + convertedNumber;
    } else {
      convertedNumber = convertedNumbers[i] + convertedNumber;
    }
  }

  // Retornamos este string compuesto, modificar a lo que se desea retornar
  return ('$number.$decimal -> $convertedNumber $decimal/100 M.N')
      .toUpperCase();
}

ConvertionResult _getHundred(String number) {
  int numberDigit = int.parse(number);
  ConvertionResult result = ConvertionResult.empty();
  if (numberDigit != 0) {
    result = ConvertionResult(
      convertedNumber: ' ${ConverterValues.hundred[numberDigit - 1]}',
      number: numberDigit,
    );
  } else {
    result = ConvertionResult(
      convertedNumber: ' ',
      number: numberDigit,
    );
  }

  return result;
}

ConvertionResult _getTen(String number, {String unitNumber = '0'}) {
  int unitDigit = int.parse(unitNumber);
  int numberDigit = int.parse(number);
  if (numberDigit == 1 && unitDigit != 0) {
    return ConvertionResult(
      convertedNumber: ' ${ConverterValues.teens[unitDigit - 1]}',
      number: numberDigit,
      isTeen: true,
    );
  } else if (numberDigit == 2 && unitDigit == 0) {
    return ConvertionResult(
      convertedNumber: ' veinte',
      number: numberDigit,
    );
  } else if (numberDigit != 0) {
    return ConvertionResult(
      convertedNumber: ' ${ConverterValues.ten[numberDigit - 1]}',
      number: numberDigit,
    );
  } else {
    return ConvertionResult(
      convertedNumber: '',
      number: numberDigit,
    );
  }
}

ConvertionResult _getUnit(String number, ConvertionResult tenResult) {
  int numberDigit = int.parse(number);
  if (!tenResult.isTeen) {
    if (numberDigit != 0) {
      if (tenResult.number == 0) {
        return ConvertionResult(
            convertedNumber: ' ${ConverterValues.unit[numberDigit - 1]}',
            number: numberDigit);
      } else if (tenResult.number == 2) {
        return ConvertionResult(
            convertedNumber: ConverterValues.unit[numberDigit - 1],
            number: numberDigit);
      } else {
        return ConvertionResult(
            convertedNumber: ' y ${ConverterValues.unit[numberDigit - 1]}',
            number: numberDigit);
      }
    } else {
      return ConvertionResult(convertedNumber: '', number: numberDigit);
    }
  } else {
    return ConvertionResult(convertedNumber: '', number: numberDigit);
  }
}

List<String> _getSubNumbers(String number) {
  int count = (number.length / 3).ceil();
  List<String> subsStrings = [];
  int start = number.length - 3;
  int end = number.length;

  for (int i = 0; i < count; i++) {
    if (start < 0) {
      start = 0;
    }
    subsStrings.add(number.substring(start, end));
    end = start;
    start = start - 3;
  }
  return subsStrings;
}
