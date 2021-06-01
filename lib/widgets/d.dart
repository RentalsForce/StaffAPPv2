void main() {

  int fizzCheck = 3;
  int buzzCheck = 5;

  var fizzString = 'Fizz';
  var buzzString = 'Buzz';

  bool checkBuzz(int i){
    if(i % buzzCheck == 0){

      return true;
    }
    return false;
  }

  bool checkFizz(int i){
    if(i % fizzCheck == 0){

      return true;
    }
    return false;
  }

  bool checkFizzBuzz(int i){

    if(i % (fizzCheck*buzzCheck) == 0 ){

      return true;
    }
    return false;
  }

  for (int i = 1; i <= 100; i++) {

    String answer = "";

    if(checkFizz(i)){
      answer = answer + fizzString;
    }
    if(checkBuzz(i)){
      answer = answer + buzzString;
    }

    if(answer.length > 0) {
      print(answer);
    }
    else {
      print(i);
    }


  }




}



