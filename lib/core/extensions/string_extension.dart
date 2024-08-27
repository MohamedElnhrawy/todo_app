extension StringExt on String {
  String get obscureEmail  {
    final int index = indexOf('@');
    var userName = substring(0,index);
    final domain = substring(index + 1);
    userName = '${userName[0]}***${userName[userName.length-1]}';
    return '$userName@$domain';
  }
}