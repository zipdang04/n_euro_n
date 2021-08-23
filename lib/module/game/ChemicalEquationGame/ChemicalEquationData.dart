import 'dart:math';

//them PTHH vao dong 9
//yeu cau co cach giua cac dau + va ->
//bao ngoai PTHH la 2 dau '
//sau khi hoan than cac yeu cay tren, them dau , vao cuoi dong va Enter de them PTHH tiep theo

List<String> dataChemical = [
  '2Mg + 1O2 -> 2MgO',
  '4P + 5O2 -> 2P2O5',
  '2KClO3 -> 2KCl + 3O2',
  '16HCl + 2KMnO4 -> 2MnCl2 + 2KCl + 5Cl2 + 8H2O',
  '1C12H22O11 + 1H2O -> 2C6H12O6',
  '1C12H22O11 + 12O2 -> 12CO2 + 11H2O',
  '3C6H5CHCH2 + 10KMnO4 -> 3C6H5COOK + 3K2CO3 + 1KOH + 10MnO2 + 4H2O',
  '1C2H5OH -> 1C2H4 + 1H2O',
  '1C2H5OH + 1CH3COOH <-> 1CH3COOC2H5 + 1H2O',
  '2C2H5OH + 2Na -> 2C2H5ONa + 1H2',
  '1H2SO4 + 1KClO4 -> 1HClO4 + 1KHSO4',
  '1KMnO4 + 3C2H4 + 4H2O -> 4C2H4(OH)2 + 2KOH + 2MnO2',
  '1HCHO + 2Br2 + 1H2O -> 2HBr + 1CO2',
  '2AgNO3 + 1H2O + 4NH3 + 1HCOOH -> 1(NH4)2CO3 + 2Ag + 2NH4NO3',
  '2O2 + 1C2H4O2 -> 2H2O + 2CO2',
  '3C2H5OH + 1C2H4O2 -> 3H2O + 2C4H8O',
  '1C6H6 + 3Cl -> 1C6H6Cl6',
  '1H2 + 1C6H5CHCH2 -> 1C6H5CH2CH3',
  '4H2SO4 + 1Ba(AlO2)2 + -> 1Al2(SO4)3 + 4H2O + 1BaSO4',
  '2H2O + 2NaHSO4 + 1Ba(AlO2)2 -> 2Al(OH)3 + 1Na2SO4 + 1BaSO4',
  '1Ba(AlO2)2 + 1Na2CO3 + 4H2O -> 1BaCO3 + 2Al(OH)3 + 2NaOH',
  '3H2O + 3Na2CO3 + 2FeCl3 -> 6NaCl + 3CO2 + 2Fe(OH)3',
  '2NaOH + 1CuCl2 -> 1Cu(OH)2 + 2NaCl',
];

class equationChemical {
  String _questionChemical = '';
  String _answerChemical = '';

  equationChemical(this._questionChemical, this._answerChemical);

  String getQuestionChemical() {
    return _questionChemical;
  }

  String getAnswerChemical() {
    return _answerChemical;
  }
}

bool isInt(String value) {
  for (int i = 0; i <= 9; ++i)
    if (value == i.toString()) return true;

  return false;
}

equationChemical getChemicalQuestion() {
  Random random = Random();
  int n, tmp;
  String question = '', answer = '';

  n = random.nextInt(dataChemical.length);
  String value = ' ' + dataChemical[n];

  int elements = 0;
  for (int i = 0; i < value.length; ++i)
    if ((value[i] == ' ')&&(isInt(value[i+1]))) ++elements;

  n = random.nextInt(elements) + 1;
  tmp = n;
  for (int i = 0; i < value.length; ++i)
    if ((value[i] == ' ')&&(isInt(value[i+1])))
      if (tmp > 1) --tmp;
      else {
        question = value.substring(0, i + 1) + '☐';
        for (int j = i + 1; j < value.length; ++j) {
          answer = answer + value.substring(j,j+1);
          if (isInt(value[j]) && (!isInt(value[j + 1]))) {
            question = question + value.substring(j + 1);
            break;
          }
        }
        break;
      }

  return equationChemical(question, answer) ;
}