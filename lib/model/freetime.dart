import 'package:flutter/material.dart';

class freetime {
  int limit;
  int usage;
  freetime({required this.limit, required this.usage});
}

class screentime {
  int classtime;
  int study;
  int free;
  int total;
  screentime(
      {required this.classtime,
      required this.study,
      required this.free,
      required this.total});
}

class devices {
  String devicename;
  int usage;
  Icon iconname;
  devices(
      {required this.devicename, required this.usage, required this.iconname});
}

class userdata {
  List<devices> devicedata;
  freetime freetimedata;
  screentime screentimedata;
  userdata(
      {required this.devicedata,
      required this.freetimedata,
      required this.screentimedata});
}
