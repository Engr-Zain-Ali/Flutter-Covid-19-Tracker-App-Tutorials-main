import 'package:covid_tracker/Services/state_services.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:covid_tracker/Model/WorldStatesModel.dart';
import 'package:covid_tracker/View/Countries.dart';

class NextScreen extends StatefulWidget {
  const NextScreen({Key? key});

  @override
  State<NextScreen> createState() => _NextScreenState();
}

class _NextScreenState extends State<NextScreen> with TickerProviderStateMixin {
  late final AnimationController _animationController =
      AnimationController(duration: const Duration(seconds: 6), vsync: this)
        ..repeat();
  @override
// void dispose(){
//   super.dispose();
//   _animationController.dispose();
// }
  final colorList = <Color>[
    Color(0xff4285f4),
    Color(0xff1aa260),
    Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .01),
              FutureBuilder(
                  future: statesServices.fecthWorldStatesRecords(),
                  builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                    if (!snapshot.hasData) {
                      return Expanded(
                        flex: 1,
                        child: SpinKitRotatingCircle(
                          color: Colors.white,
                          size: 50.0,
                          controller: _animationController,
                        ),
                      );
                    } else {

                      return Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              Container(
                                width: 300,
                                height: 150,
                                child: PieChart(
                                  dataMap: {
                                    "Total": double.parse(
                                        snapshot.data!.cases.toString()),
                                    "recovered": double.parse(
                                        snapshot.data!.recovered.toString()),
                                    "Deaths": double.parse(
                                        snapshot.data!.deaths.toString()),
                                  },
                                  chartValuesOptions:const ChartValuesOptions(
                                    showChartValuesInPercentage: true,
                                  ),
                                  animationDuration:
                                      Duration(milliseconds: 1200),
                                  chartType: ChartType.ring,
                                  colorList: colorList,
                                  legendOptions:const LegendOptions(
                                      legendPosition: LegendPosition.left),
                                ),
                              ),
                              SizedBox(height: 30),
                              Card(
                                child: Column(
                                  children: [
                                    ResuableRow(
                                        rowColor: Colors.blue,

                                        title: 'Total',
                                        value: snapshot.data!.cases.toString()),
                                    ResuableRow(
                                        rowColor: Colors.green,
                                        title: 'Recovered',
                                        value: snapshot.data!.recovered
                                            .toString()),
                                    ResuableRow(
                                        rowColor: Colors.red,
                                        title: 'Deaths',
                                        value:
                                            snapshot.data!.deaths.toString()),
                                    ResuableRow(
                                        rowColor: Colors.blueGrey,
                                        title: 'active',
                                        value:
                                            snapshot.data!.active.toString()),
                                    ResuableRow(
                                        rowColor: Colors.pink,
                                        title: 'Today-cases',
                                        value: snapshot.data!.todayCases
                                            .toString()),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                  onPressed: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CountriesList(),),),
                                  child: Text('Track to another countries')),
                            ],
                          ));

//ap kay pass vs code hay?
                      //nhi sir
                      // vs code may kafi easy ho jata haychalay khair
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class ResuableRow extends StatelessWidget {
  String title, value;

  ResuableRow({Key? key, required this.value, required this.title, required MaterialColor rowColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 5, top: 10),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(title),
            Text(value),
          ]),
        ),
        SizedBox(height: 5),
        Divider(),
      ],
    );
  }
}
