import 'dart:async';

class UserValidators{


  static final StreamTransformer<String,String> emailValidator = StreamTransformer<String,String>.fromHandlers(
      handleData: (email,sink){
        if(email.contains("@")){
          sink.add(email);
        }else{
          sink.addError("Email is not valid");
        }
      }
  );

  static final StreamTransformer<String,String> passwordValidator = StreamTransformer<String,String>.fromHandlers(
      handleData: (password,sink){
        if(password.length>4){
          sink.add(password);
        }else{
          sink.addError("Password length should be greater than 4 chars.");
        }
      }
  );

}