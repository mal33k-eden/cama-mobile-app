import 'dart:convert';
import 'dart:io';
import 'package:cama/api/files.dart';
import 'package:cama/models/document.dart';
import 'package:cama/models/training.dart';
import 'package:cama/shared/flavors.dart';
import 'package:cama/shared/form_kits.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FileProvider extends ChangeNotifier {
  bool isFileSelected = false;
  bool isWatchable = false;
  bool isDocUpdated = false;
  late SharedPreferences prefs;
  bool isSetMyDocs = false;
  bool isSetMyTrainings = false;
  List<MyDocument>? _allDocs = [];
  List<MyTraining>? _allTraining = [];
  //
  FileProvider() {
    init();
  }
  init() async {
    prefs = await SharedPreferences.getInstance();
  }

  getAllFiles(token) async {
    await fetchMyDocs(token);
    await fetchMyTrainings(token);
  }

  Future<bool> fetchMyDocs(String token) async {
    _allDocs = [];
    isSetMyDocs = false;
    await FilesApi(token: token).docs().then((data) {
      if (data.statusCode == 201) {
        setDocuments(jsonDecode(data.body));
        isSetMyDocs = true;
      }
    });
    return isSetMyDocs;
  }

  Future<bool> fetchMyTrainings(String token) async {
    _allTraining = [];
    isSetMyTrainings = false;
    await FilesApi(token: token).trainings().then((data) {
      if (data.statusCode == 201) {
        setTrainings(jsonDecode(data.body));
        isSetMyTrainings = true;
      }
    });
    return isSetMyTrainings;
  }

  Future<bool> updateDocument(
      {required Map<String, dynamic> body, required String token}) async {
    isDocUpdated = false;
    await FilesApi(token: token).documentUpload(body: body).then((data) {
      print(data.body);
      if (data.statusCode == 201) {
        isDocUpdated = true;
      } else {
        isDocUpdated = false;
        //print(data.body);
        Map<String, dynamic> result = json.decode(data.body);
      }
    });
    notifyListeners();
    return isDocUpdated;
  }

  Future<bool> updateTraining(
      {required Map<String, dynamic> body, required String token}) async {
    isDocUpdated = false;
    await FilesApi(token: token).trainingUpload(body: body).then((data) {
      print(data.body);
      if (data.statusCode == 201) {
        isDocUpdated = true;
      } else {
        isDocUpdated = false;
        //print(data.body);
        Map<String, dynamic> result = json.decode(data.body);
      }
    });
    notifyListeners();
    return isDocUpdated;
  }

  Future pickFileTrigger(scaffoldState) async {
    updateSelectStatus(false);
    BuildContext context = scaffoldState.currentContext;
    return await showModalBottomSheet(
        backgroundColor: Flavor.primaryToDark,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Text(
                'Select File Type',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white),
              ),
              Divider(),
              SizedBox(
                height: 20,
              ),
              ListTile(
                leading: new Icon(
                  Icons.camera_sharp,
                  color: Colors.white,
                ),
                title: new Text(
                  'Camera Image',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () async {
                  Navigator.pop(context);
                  isWatchable = true;
                  return await camaPickImageFile(
                      src: 'camera', scaffoldState: scaffoldState);
                },
              ),
              ListTile(
                leading: new Icon(
                  Icons.photo_sharp,
                  color: Colors.white,
                ),
                title: new Text(
                  'Gallery Image',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () async {
                  Navigator.pop(context);
                  isWatchable = true;
                  return await camaPickImageFile(
                      src: 'gallery', scaffoldState: scaffoldState);
                },
              ),
              ListTile(
                leading: new Icon(
                  Icons.picture_as_pdf_sharp,
                  color: Colors.white,
                ),
                title: new Text(
                  'PDF',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () async {
                  Navigator.pop(context);
                  isWatchable = true;
                  return await camaPickPDFFile(scaffoldState: scaffoldState);
                },
              ),
            ],
          );
        });
  }

  Future camaPickPDFFile({required var scaffoldState}) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result == null) {
        setWatchable(false);
        await showCustomAlert(
            scaffoldState: scaffoldState,
            title: 'Error',
            message: 'No file was selected.');
      } else {
        savePath(File(result.files.single.path.toString()));
        setWatchable(false);
      }
    } on PlatformException catch (e) {
      setWatchable(false);
      await showCustomAlert(
          scaffoldState: scaffoldState,
          title: 'File Permission Error',
          message:
              'you will need to give the app permission to your files inother to select and upload files.');
    }
  }

  Future camaPickImageFile(
      {required String src, required var scaffoldState}) async {
    ImageSource source =
        (src == 'camera') ? ImageSource.camera : ImageSource.gallery;
    try {
      XFile? image = await ImagePicker().pickImage(source: source);
      if (image == null) {
        await showCustomAlert(
            scaffoldState: scaffoldState,
            title: 'Error',
            message: 'No file was selected.');
        setWatchable(false);
      } else {
        savePath(File(image.path));
        setWatchable(false);
      }
    } on PlatformException catch (e) {
      setWatchable(false);
      await showCustomAlert(
          scaffoldState: scaffoldState,
          title: 'File Permission Error',
          message:
              'you will need to give the app permission to your camera and gallery in other to upoad images.');
    }
  }

  updateSelectStatus(bool val) {
    isFileSelected = val;
    if (!val) {
      unSavePath();
    }
    notifyListeners();
  }

  void savePath(File _path) async {
    await prefs.setString('selectedFile', _path.path);
    updateSelectStatus(true);
  }

  void unSavePath() async {
    await prefs.setString('selectedFile', 'null');
    updateSelectStatus(true);
  }

  Future getPath() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('selectedFile') ?? null;
  }

  void setWatchable(bool val) {
    isWatchable = val;
    notifyListeners();
  }

  void setDocuments(docs) {
    var all = docs['data'];
    all.forEach((data) => _allDocs?.add(MyDocument.fromJson(data)));
    print(_allDocs!.length);
    isSetMyDocs = true;

    notifyListeners();
  }

  void setTrainings(trainings) {
    var all = trainings['data'];
    all.forEach((data) => _allTraining?.add(MyTraining.fromJson(data)));
    isSetMyTrainings = true;
    notifyListeners();
  }

  List<MyDocument>? myDocs() {
    return _allDocs;
  }

  List<MyTraining>? myTrainings() {
    return _allTraining;
  }
}
