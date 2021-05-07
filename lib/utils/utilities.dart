class Utils{
  static String getUserName(String email){
    return "live:${email.split('@')[0]}";
  }
}