import 'package:cama/models/agency.dart';
import 'package:cama/providers/provider_agency.dart';
import 'package:cama/providers/provider_auth.dart';
import 'package:cama/shared/flavors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllAgencies extends StatefulWidget {
  const AllAgencies({Key? key}) : super(key: key);

  @override
  State<AllAgencies> createState() => _AllAgenciesState();
}

class _AllAgenciesState extends State<AllAgencies> {
  late final AgencyProvider _agencyProvider;
  late final AuthProvider _authProvider;
  List<MyAgency>? _agencies = [];
  @override
  void initState() {
    _agencies!.length = 0;
    // TODO: implement initState
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _agencyProvider = Provider.of<AgencyProvider>(context, listen: false);
      _authProvider = Provider.of<AuthProvider>(context, listen: false);

      _getAgeciesData();
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _agencies = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // actions: [Icon(Icons.tune_sharp)],
        title: Text('Agencies'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: (_agencies!.length > 0)
              ? ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  primary: false,
                  itemCount: _agencies!.length,
                  itemBuilder: (BuildContext context, int index) {
                    var agency = _agencies!.elementAt(index);
                    return ListView(
                      shrinkWrap: true,
                      primary: false,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, 'agency-profile',
                                  arguments: {'agency': agency});
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 13),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                offset: Offset(4.0, 4.0),
                                                blurRadius: 15,
                                                color: Flavor
                                                    .primaryToDark.shade50,
                                                spreadRadius: 5),
                                            BoxShadow(
                                                offset: Offset(-4.0, -4.0),
                                                blurRadius: 15,
                                                color: Colors.white10,
                                                spreadRadius: 5),
                                          ],
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              radius: 50,
                                              child:
                                                  Image.network(agency.logo)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            agency.name,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Text(agency.email,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                              '${agency.postcode}, ${agency.town}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Flavor.primaryToDark,
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(4.0, 4.0),
                                        blurRadius: 25,
                                        color: Colors.grey.shade300,
                                        spreadRadius: 8),
                                    BoxShadow(
                                        offset: Offset(-4.0, -4.0),
                                        blurRadius: 25,
                                        color: Colors.white10,
                                        spreadRadius: 8),
                                  ]),
                            ),
                          ),
                        ),
                      ],
                    );
                  })
              : Text('loading'),
        ),
      ),
    );
  }

  void _getAgeciesData() async {
    await _agencyProvider.fetchMyAgencies(_authProvider.token!);
    if (_agencyProvider.isSetMyAgencies) {
      setState(() {
        _agencies = _agencyProvider.myAgencies()!;
      });
    }
  }
}
