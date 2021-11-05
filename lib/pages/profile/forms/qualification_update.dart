import 'package:cama/providers/provider_auth.dart';
import 'package:cama/shared/avart_icon.dart';
import 'package:cama/shared/form_kits.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UpdateQualification extends StatefulWidget {
  UpdateQualification({Key? key}) : super(key: key);

  @override
  State<UpdateQualification> createState() => _UpdateQualificationState();
}

class _UpdateQualificationState extends State<UpdateQualification> {
  final yearController = TextEditingController();
  final courseController = TextEditingController();
  final qualifyController = TextEditingController();
  final _FormKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var args;
  bool toCreate = true;
  int updateId = 0;
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () {
      args = ModalRoute.of(context)!.settings.arguments;
      var q = args!["qualification"];
      if (q != null) {
        setState(() {
          toCreate = false;
          courseController.text = q['course'];
          yearController.text = q['year'];
          qualifyController.text = q['qualification'];
          updateId = q['id'];
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    yearController.dispose();
    courseController.dispose();
    qualifyController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final isLoading = context.watch<AuthProvider>().loading;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text((toCreate) ? 'Add Qualification' : 'Update Qualification'),
        actions: [
          TextButton(
            onPressed: () {
              _submitForm(auth, _scaffoldKey);
            },
            child: Center(
              child: (isLoading)
                  ? CustomActivityIndicator(size: 10)
                  : Text(
                      (toCreate) ? 'Add ' : 'Save',
                      style: TextStyle(color: Colors.white),
                    ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Form(
          key: _FormKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              TextFormField(
                decoration: textFieldDecorator.copyWith(
                    label: const Text('Course'),
                    prefixIcon: Icon(Icons.business_center_sharp),
                    hintText: 'e.g Business Admin'),
                validator: (val) => validateTextField(val),
                controller: courseController,
                // The validator receives the text that the user has entered.
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: textFieldDecorator.copyWith(
                    label: const Text('Qualification'),
                    prefixIcon: Icon(Icons.badge_sharp),
                    hintText: 'e.g Master Of Science'),
                controller: qualifyController,
                validator: (val) => validateTextField(val),
                // The validator receives the text that the user has entered.
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: textFieldDecorator.copyWith(
                  label: const Text('Year Completed'),
                  hintText: 'e.g 2021',
                  prefixIcon: Icon(Icons.calendar_today_sharp),
                ),
                controller: yearController,
                validator: (val) => validateTextField(val),
                // The validator receives the text that the user has entered.
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitForm(auth, scaffoldState) async {
    Map<String, dynamic> body = {};
    body['course'] = courseController.text;
    body['qualification'] = qualifyController.text;
    body['year'] = yearController.text;
    body['action'] = 'insert';
    if (!toCreate) {
      body['id'] = updateId;
      body['action'] = 'update';
    }
    await auth.updateQualification(body: body, token: auth.token);
    if (auth.isProfileUpdate) {
      showSnackBar(context: context, message: 'Profile updated');
      Navigator.pop(context);
    } else {
      await showCustomAlert(
          scaffoldState: scaffoldState,
          title: 'Error',
          message: 'something went wrong try again');
      Navigator.pop(context);
    }
  }
}
