String KtoC(String f) {
  double t = double.parse(f);
  t = t-273.15;
  f = t.toStringAsFixed(1);
  return f;
}

String capitalizeFirstLetter(String s) {
  if (s.isEmpty) {
    return s;
  }
  return s.substring(0, 1).toUpperCase() + s.substring(1);
}

DateTime unixtotime(String s){
    int unix=int.tryParse(s)??0;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(unix * 1000);
    return dateTime;
}

String time(String s){
  DateTime dateTime = unixtotime(s);
  String dt=dateTime.toString();
  dt=dt.substring(10,16);
  dt=timeformatchange(dt);
  // print(dt);
  return dt;
}

String timeformatchange(String t){
  String h=t.substring(0,3);
  String m=t.substring(4,6);
  String time='';
  int H=int.parse(h);
  if(h=='00'){
    time="12$m AM";
  }
  else if(H<12){
    time="$t AM";
  }
  else if(H==12){
    time="$t PM";
  }
  else{
    time="${H-12}:$m PM";
  }
  return time;
}