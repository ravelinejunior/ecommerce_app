import 'dart:io';

import 'package:ecommerce_app/datas/ml_detail.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

const String TEXT_SCANNER = "TEXT_SCANNER";
const String BARCODE_SCANNER = "BARCODE_SCANNER";
const String LABEL_SCANNER = "LABEL_SCANNER";
const String FACE_SCANNER = "FACE_SCANNER";

class IAScreen extends StatefulWidget {
  IAScreen({Key key}) : super(key: key);
  @override
  _IAScreenState createState() => _IAScreenState();
}

class _IAScreenState extends State<IAScreen> {
  static const String CAMERA_SOURCE = "CAMERA";
  static const String GALLERY_SOURCE = "GALLERY";

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  File _file;
  String _selectedScanner = TEXT_SCANNER;

  @override
  Widget build(BuildContext context) {
    final columns = List<Widget>();
    columns.add(buildRowTitle(context, "Selecione o tipo de Scanner"));
    columns.add(buildSelectScannerRowWidget(context));
    columns.add(buildRowTitle(context, "Selecione a Imagem"));
    columns.add(buildSelectImageRowWidget(context));

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("Inteligência Artificial"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: columns,
        ),
      ),
    );
  }

  Widget buildRowTitle(BuildContext context, String title) {
    return Center(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline,
      ),
    ));
  }

  Widget buildSelectImageRowWidget(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              splashColor: Colors.blueGrey,
              onPressed: () {
                onPickImageSelected(CAMERA_SOURCE);
              },
              child: const Text('Camera')),
        )),
        Expanded(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              splashColor: Colors.blueGrey,
              onPressed: () {
                onPickImageSelected(GALLERY_SOURCE);
              },
              child: const Text('Gallery')),
        ))
      ],
    );
  }

  Widget buildSelectScannerRowWidget(BuildContext context) {
    return Wrap(
      children: <Widget>[
        RadioListTile<String>(
          title: Text('Text Recognition'),
          groupValue: _selectedScanner,
          value: TEXT_SCANNER,
          onChanged: onScannerSelected,
        ),
        RadioListTile<String>(
          title: Text('Barcode Scanner'),
          groupValue: _selectedScanner,
          value: BARCODE_SCANNER,
          onChanged: onScannerSelected,
        ),
        RadioListTile<String>(
          title: Text('Label Scanner'),
          groupValue: _selectedScanner,
          value: LABEL_SCANNER,
          onChanged: onScannerSelected,
        ),
        RadioListTile<String>(
          title: Text('Face Scanner'),
          groupValue: _selectedScanner,
          value: FACE_SCANNER,
          onChanged: onScannerSelected,
        )
      ],
    );
  }

  Widget buildImageRow(BuildContext context, File file) {
    return SizedBox(
        height: 500.0,
        child: Image.file(
          file,
          fit: BoxFit.fitWidth,
        ));
  }

  Widget buildDeleteRow(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: RaisedButton(
            color: Colors.red,
            textColor: Colors.white,
            splashColor: Colors.blueGrey,
            onPressed: () {
              setState(() {
                _file = null;
              });
              ;
            },
            child: const Text('Delete Image')),
      ),
    );
  }

  void onScannerSelected(String scanner) {
    setState(() {
      _selectedScanner = scanner;
    });
  }

  void onPickImageSelected(String source) async {
    var imageSource;
    if (source == CAMERA_SOURCE) {
      imageSource = ImageSource.camera;
    } else {
      imageSource = ImageSource.gallery;
    }

    final scaffold = _scaffoldKey.currentState;

    try {
      final file = await ImagePicker.pickImage(source: imageSource);
      if (file == null) {
        throw Exception('File is not available');
      }

      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => MLDetail(file, _selectedScanner)),
      );
    } catch (e) {
      scaffold.showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }
}
