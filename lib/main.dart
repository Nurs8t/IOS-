
void main() {
  //1
  {
    for (int i = 1; i <= 10; i++) {
      for (int j = 1; j <= 10; j++) {
        print('$i x $j = ${i * j}');
      }
      print('');
    }
  }


  //2
  int day = 28;
  int month = 2;
  int year = 2024;

  bool bday = false;

  if (year % 400 == 0) {
    bday = true;
  } else if (year % 4 == 0 && year % 100 != 0) {
    bday = true;
  }

  int days;

  if (month == 1) {
    days = 31;
  }
  else if (month == 2) {
    if (bday) {
      days = 29;
    } else {
      days = 28;
    }
  } else if (month == 3) {
    days = 31;
  } else if (month == 4) {
    days = 30;
  } else if (month == 5) {
    days = 31;
  } else if (month == 6) {
    days = 30;
  } else if (month == 7) {
    days = 31;
  } else if (month == 8) {
    days = 31;
  } else if (month == 9) {
    days = 30;
  } else if (month == 10) {
    days = 31;
  } else if (month == 11) {
    days = 30;
  } else {
    days = 31;
  }

  if (day < 1 || day > days) {
    print("invalid date");
  } else if (day < days) {
    print("${day + 1}.$month.$year");
  } else if (month < 12) {
    print("1.${month + 1}.$year");
  } else {
    print("1.1.${year + 1}");
  }




  //3

  String text = "flutter mobile development";

  int count = 0;

  for (int i = 0; i < text.length; i++) {
    String letter = text[i].toLowerCase();

    if ("aeiou".contains(letter)) {
      count++;
    }
  }

  print("Vowels: $count");


  //4

  List<int> numbers = [14, 88, 3, 42, 99, 12, 67];

  int min = numbers[0];
  int max = numbers[0];

  for (int i = 1; i < numbers.length; i++) {
    if (numbers[i] < min) {
      min = numbers[i];
    }

    if (numbers[i] > max) {
      max = numbers[i];
    }
  }

  print("Min: $min");
  print("Max: $max");


  //5

  int number = 3;

  bool isPrime = true;

  if (number < 2) {
    isPrime = false;
  } else {
    for (int i = 2; i < number; i++) {
      if (number % i == 0) {
        isPrime = false;
        break;
      }
    }
  }

  print("\nTASK 5:");

  if (isPrime) {
    print("$number -> prime number");
  } else {
    print("$number -> not prime number");
  }
}


