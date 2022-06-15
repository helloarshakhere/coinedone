String sectominutehour(int sec) {
  int hour = sec ~/ 3600;
  int min = (sec % 3600) ~/ 60;
  if (hour == 0) {
    return "${min.toString().padLeft(2, '0')}m";
  } else if (min == 0) {
    return "${hour}h";
  } else {
    return "${hour}h${min.toString().padLeft(2, '0')}m";
  }
}
