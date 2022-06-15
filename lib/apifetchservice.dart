import 'dart:convert';

import 'package:coinedone/model/freetime.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class apifetchdata {
  final _baseUri = "api.mocklets.com";

  Future<userdata> getdata() async {
    screentime? screentimedata;
    freetime? freetimedata;
    List<devices> deviceslist = [];
    try {
      final url = Uri.https(_baseUri, "/p68289/screentime");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var bodylog = jsonDecode(response.body);

        if (bodylog['success']) {
          screentimedata = screentime(
              classtime: bodylog['data']['screenTime']['class'],
              study: bodylog['data']['screenTime']['study'],
              free: bodylog['data']['screenTime']['free'],
              total: bodylog['data']['screenTime']['total']);
          freetimedata = freetime(
              limit: bodylog['data']['freeTime']['limit'],
              usage: bodylog['data']['freeTime']['usage']);

          for (int i = 0; i < bodylog['data']['devices'].length; i++) {
            var tempdata = bodylog['data']['devices'][i]['name']
                .toString()
                .split(' ')
                .last
                .toLowerCase();
            if (tempdata == "phone") {
              deviceslist.add(
                devices(
                  devicename: bodylog['data']['devices'][i]['name'],
                  usage: bodylog['data']['devices'][i]['usage'],
                  iconname: Icon(Icons.phone_android_outlined, size: 70),
                ),
              );
            } else if (tempdata == "laptop") {
              deviceslist.add(
                devices(
                  devicename: bodylog['data']['devices'][i]['name'],
                  usage: bodylog['data']['devices'][i]['usage'],
                  iconname: Icon(Icons.laptop_mac_outlined, size: 70),
                ),
              );
            } else if (tempdata == "tablet") {
              deviceslist.add(
                devices(
                  devicename: bodylog['data']['devices'][i]['name'],
                  usage: bodylog['data']['devices'][i]['usage'],
                  iconname: Icon(Icons.tablet_android_outlined, size: 70),
                ),
              );
            }
          }
          return userdata(
              devicedata: deviceslist,
              freetimedata: freetimedata,
              screentimedata: screentimedata);
        } else {
          throw Exception("Fail to fetch");
        }
      } else {
        throw Exception("Connection Failure");
      }
    } catch (err) {
      rethrow;
    }
  }
}
