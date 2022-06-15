import 'dart:convert';
import 'dart:developer';
import 'package:coinedone/bloc/userdataget_bloc.dart';
import 'package:coinedone/sectohr.dart';
import 'package:coinedone/model/freetime.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'circularindicator.dart';

class mainscreen extends StatefulWidget {
  const mainscreen({Key? key}) : super(key: key);

  @override
  _mainscreenState createState() => _mainscreenState();
}

class _mainscreenState extends State<mainscreen> {
  String name = "Micheal";
  bool showmore = false;
  final ScrollController _controller = ScrollController();
  TextStyle timedashboard =
      TextStyle(fontWeight: FontWeight.w400, fontSize: 14);



  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Icon(
              Icons.settings_outlined,
              color: Colors.black,
            )
          ],
          leading: Padding(
            padding:
                const EdgeInsets.only(left: 8, right: 6, top: 8, bottom: 8),
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      colors: [Color(0xffbFFFBA3), Color(0xffbE330BC)])),
            ),
          ),
          title: Text(
            name,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          backgroundColor: Color(0xffbFFFFFF),
        ),
        body: (BlocBuilder<UserdatagetBloc, UserdatagetState>(
          builder: (context, state) {
            if (state is LoadedState) {
              return Container(
                child: SingleChildScrollView(
                  controller: _controller,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Center(
                          child: Text(
                            "Dashboard",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 24),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 80),
                        child: circlegraph(
                          colorOccurrences: {
                            Colors.blue:
                                state.userdataval.screentimedata.classtime,
                            Color(0xffbFF9E57):
                                state.userdataval.screentimedata.study,
                            Colors.green: state.userdataval.screentimedata.free
                          },
                          height: MediaQuery.of(context).size.width / 4,
                          totaltime: sectominutehour(
                              state.userdataval.screentimedata.total),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 5),
                                        width: 7,
                                        height: 7,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.blue),
                                      ),
                                      Text(
                                        "Class",
                                        style: timedashboard,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    sectominutehour(state
                                        .userdataval.screentimedata.classtime),
                                    style: timedashboard.copyWith(
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 5),
                                        width: 7,
                                        height: 7,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0XFFBFF9E57)),
                                      ),
                                      Text(
                                        "Study",
                                        style: timedashboard,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    sectominutehour(
                                        state.userdataval.screentimedata.study),
                                    style: timedashboard.copyWith(
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 5),
                                        width: 7,
                                        height: 7,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.green),
                                      ),
                                      Text(
                                        "Free-time",
                                        style: timedashboard,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    sectominutehour(
                                        state.userdataval.screentimedata.free),
                                    style: timedashboard.copyWith(
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 30, left: 12, right: 12, bottom: 20),
                        child: Divider(
                          color: Colors.black26,
                          height: 2,
                        ),
                      ),
                      Center(
                          child: Text(
                        "Free-time Usage",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 20),
                      )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "Used",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      ),
                                      Text(
                                        sectominutehour(state
                                            .userdataval.freetimedata.usage),
                                        style: TextStyle(
                                            color: Colors.lightGreen,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 24),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Max",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      ),
                                      Text(
                                        sectominutehour(state
                                            .userdataval.freetimedata.limit),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 24),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: LinearProgressIndicator(
                                  color: Colors.green,
                                  backgroundColor: Colors.white,
                                  minHeight: 20.0,
                                  value: state.userdataval.freetimedata.usage /
                                      state.userdataval.freetimedata.limit),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Container(
                                width: MediaQuery.of(context).size.width - 30,
                                child: OutlinedButton(
                                  onPressed: () {},
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                        width: 1.0, color: Colors.blue),
                                  ),
                                  child: const Text("Extend Free-time"),
                                ),
                              ),
                            ),
                            TextButton(
                                onPressed: () {},
                                child: Text("Change Time Restrictions")),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 30, left: 12, right: 12, bottom: 20),
                              child: Divider(
                                color: Colors.black26,
                                height: 2,
                              ),
                            ),
                            Center(
                                child: Text(
                              "By Devices",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                            )),
                          ],
                        ),
                      ),
                      Container(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: (showmore)
                              ? state.userdataval.devicedata.length
                              : 2,
                          itemBuilder: (buildContext, i) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                state.userdataval.devicedata[i].iconname,
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                        state.userdataval.devicedata[i]
                                            .devicename,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18)),
                                    Text(
                                        sectominutehour(state
                                            .userdataval.devicedata[i].usage),
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18))
                                  ],
                                )
                              ],
                            );
                          },
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              showmore = !showmore;

                              _controller.animateTo(200.0,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                            });
                          },
                          child: Text((showmore)?"Show Less":"See All Devices")),
                    ],
                  ),
                ),
              );
            } else if (state is FailToload) {
              return Center(
                child: TextButton(
                  child: Text(
                    "retry",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    context.read<UserdatagetBloc>().add(LoadEvent());
                  },
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          },
        )));
  }
}
