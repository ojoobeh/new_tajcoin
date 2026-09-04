part of 'utils.dart';



bool isPersian(){
  return (getData('language') ?? 'en')=='fa';
}