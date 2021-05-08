import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Covid19Class> fetchCases() async {
  final response =
  await http.get(Uri.parse('https://api.covid19india.org/data.json'));

  if (response.statusCode == 200) {
    return Covid19Class.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

class Covid19Class {
  List<Statewise> statewise;

  Covid19Class(
      {
        this.statewise
      }
      );

  Covid19Class.fromJson(Map<String, dynamic> json) {
    if (json['statewise'] != null) {
      statewise = new List<Statewise>();
      json['statewise'].forEach((v) {
        statewise.add(new Statewise.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.statewise != null) {
      data['statewise'] = this.statewise.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Statewise {
  String active;
  String confirmed;
  String deaths;
  String deltaconfirmed;
  String deltadeaths;
  String deltarecovered;
  String lastupdatedtime;
  String migratedother;
  String recovered;
  String state;
  String statecode;
  String statenotes;

  Statewise(
      {this.active,
        this.confirmed,
        this.deaths,
        this.deltaconfirmed,
        this.deltadeaths,
        this.deltarecovered,
        this.lastupdatedtime,
        this.migratedother,
        this.recovered,
        this.state,
        this.statecode,
        this.statenotes});

  Statewise.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    confirmed = json['confirmed'];
    deaths = json['deaths'];
    deltaconfirmed = json['deltaconfirmed'];
    deltadeaths = json['deltadeaths'];
    deltarecovered = json['deltarecovered'];
    lastupdatedtime = json['lastupdatedtime'];
    migratedother = json['migratedother'];
    recovered = json['recovered'];
    state = json['state'];
    statecode = json['statecode'];
    statenotes = json['statenotes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['confirmed'] = this.confirmed;
    data['deaths'] = this.deaths;
    data['deltaconfirmed'] = this.deltaconfirmed;
    data['deltadeaths'] = this.deltadeaths;
    data['deltarecovered'] = this.deltarecovered;
    data['lastupdatedtime'] = this.lastupdatedtime;
    data['migratedother'] = this.migratedother;
    data['recovered'] = this.recovered;
    data['state'] = this.state;
    data['statecode'] = this.statecode;
    data['statenotes'] = this.statenotes;
    return data;
  }
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Covid19Class> currentStateCase;

  var a = 37;//State Data Code

  @override
  void initState() {
    super.initState();
    currentStateCase = fetchCases();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: ListView.builder(
          itemCount: a,
          itemBuilder: (context,i) {
            return Center(
              child: FutureBuilder<Covid19Class>(
                future: currentStateCase,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    /*return Column(
                  children: [

                    Row(
                      children: [
                        Text('State : ${snapshot.data.statewise.elementAt(i).state}')
                      ],
                    ),
                    Row(
                      children: [
                        Text('Active : ${snapshot.data.statewise.elementAt(i).active}')
                      ],
                    ),
                    Row(
                      children: [
                        Text('Confirmed : ${snapshot.data.statewise.elementAt(i).confirmed}')
                      ],
                    ),
                    Row(
                      children: [
                        Text('Death : ${snapshot.data.statewise.elementAt(i).deaths}')
                      ],
                    ),

                    Row(
                      children: [
                        Text('Last Updated Time : ${snapshot.data.statewise.elementAt(i).lastupdatedtime}')
                      ],
                    ),
                    Row(
                      children: [
                        Text('Migrated To Other States : ${snapshot.data.statewise.elementAt(i).migratedother}')
                      ],
                    ),
                    Row(
                      children: [
                        Text('Recovered : ${snapshot.data.statewise.elementAt(i).recovered}')
                      ],
                    ),
                    Row(
                      children: [
                        Text('State Code : ${snapshot.data.statewise.elementAt(i).statecode}')
                      ],
                    ),
                  ],
                );*/

                    return SizedBox(
                        height: 70,
                        width: double.maxFinite,
                        child: Card(
                          elevation: 10,
                          shadowColor: Colors.yellow,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  if(snapshot.data.statewise.elementAt(i).statecode == 'DN')
                                    Text(
                                      'Dadra and Daman '
                                          '(${snapshot.data.statewise.elementAt(i).statecode})',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    )
                                  else
                                    Text(
                                    '${snapshot.data.statewise.elementAt(i).state} '
                                        '(${snapshot.data.statewise.elementAt(i).statecode})',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        'Active',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.red
                                        ),
                                      )
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        '${snapshot.data.statewise.elementAt(i).active}',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            color: Colors.red
                                        ),
                                      )
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        '',
                                      )
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        'Recovered',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.green
                                        ),
                                      )
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        '${snapshot.data.statewise.elementAt(i).recovered}',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            color: Colors.green
                                        ),
                                      )
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        'Deceased',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.grey
                                        ),
                                      )
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        '${snapshot.data.statewise.elementAt(i).deaths}',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            color: Colors.grey
                                        ),
                                      )
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        '',
                                      )
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        'Confirmed',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.purple
                                        ),
                                      )
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        '${snapshot.data.statewise.elementAt(i).confirmed}',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            color: Colors.purple
                                        ),
                                      )
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  // By default, show a loading spinner.
                  return CircularProgressIndicator();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}