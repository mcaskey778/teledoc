import 'dart:async';

class DateValidators{


  static final StreamTransformer<int,int> monthValidator = StreamTransformer<int,int>.fromHandlers(
      handleData: (month,sink){
        if(1 <= month && month <= 12){
          sink.add(month);
        }else{
          sink.addError("Month must be between 1 and 12");
        }
      }
  );

  static final StreamTransformer<int,int> yearValidator = StreamTransformer<int,int>.fromHandlers(
      handleData: (year,sink){
        if(0 <= year){
          sink.add(year);
        }else{
          sink.addError("Year must be positive");
        }
      }
  );

}