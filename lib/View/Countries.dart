import 'package:covid_tracker/Services/state_services.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({Key? key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices=StatesServices();
    return Scaffold(
      appBar: AppBar(
        title: Text('Countries List'),
      ),
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchController,
              onChanged: (value){
                setState(() {
                  
                });
              },
              decoration: InputDecoration(
                contentPadding:const EdgeInsets.symmetric(horizontal: 24),
                hintText: 'Search the counties name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
          ),
          // yaha ka code again likho video say...
          //yes sir this is in complete so iam start ..
          Expanded(
            child: FutureBuilder(
              future: statesServices.countriesListApi(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (!snapshot.hasData) {// not nahi lagaiya tham means agar data nahi hay to loading show karay is waja say issue aaraha tha
                // ok ab kar loo complete
                // may nay yeh wala project kafi arsay pehaly sir asif taj ka daikh kar kiya tha very helpfull tha...
                // ok best of luck show me.. ch
                // aur android studio kay shortcuts be sath sath learn kar loo....ok
                //ok but sir this is my previous project now to do list also have a lot of error so...can you check thsis
                return ListView.builder(
                    itemCount:4,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                          baseColor: Colors.blueGrey.withOpacity(.6),
                          highlightColor:Colors.blueGrey.withOpacity(.6),
                        child: Column(
                            children: [
                              ListTile(
                                title:Container(height: 10,width: 89,color: Colors.white,),
                                subtitle:Container(height: 10,width: 89,color: Colors.white,),

                                leading: Container(height: 50,width: 50,color: Colors.white,),
                              ),
                            ]

                        ));

                    });
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      String name =snapshot.data![index]['country'];

                      if(searchController.text.isEmpty){
                        return Column(
                            children: [
                              ListTile(
                                title:Text(snapshot.data![index]['country']),
                                subtitle:Text(snapshot.data![index]['cases'].toString()),
                                leading: Image(
                                    height:50,
                                    width: 50,
                                    image: NetworkImage(
                                        snapshot.data![index]['countryInfo']['flag']
                                    )),
                              ),
                            ]
                        );

    }
                      else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
    return Column(
    children: [
    ListTile(
    title:Text(snapshot.data![index]['country']),
    subtitle:Text(snapshot.data![index]['cases'].toString()),
    leading: Image(
    height:50,
    width: 50,
    image: NetworkImage(
    snapshot.data![index]['countryInfo']['flag']
    )),
    ),
    ]
    );
    }

                      else{
                        Container();
                      }


                });
              }
            }),
          )
        ]),
      ),
    );
  }
}
