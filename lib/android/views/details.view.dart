import 'package:camera/camera.dart';
import 'package:contacts/android/views/address.view.dart';
import 'package:contacts/android/views/editor-contact.view.dart';
import 'package:contacts/android/views/home.view.dart';
import 'package:contacts/android/views/loading.view.dart';
import 'package:contacts/android/views/take-picture.view.dart';
import 'package:contacts/models/contact.model.dart';
import 'package:contacts/repositories/contact.repository.dart';
import 'package:contacts/shared/contacts-details-description.widget.dart';
import 'package:contacts/shared/contacts-details-image.widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'crop-picture.view.dart';

class DetailsView extends StatefulWidget {
  final int id;
  DetailsView({
    @required this.id,
  });
  @override
  _DetailsViewState createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _repository = new ContactRepository();

  onDelete() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: new Text("Exclusão de Contato"),
          content: new Text("Deja excluir esse contato?"),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("Excluir"),
              onPressed: delete,
            )
          ],
        );
      },
    );
  }

  delete() {
    _repository.delete(widget.id).then((_) {
      onSucess();
    }).catchError((_) {
      onError();
    });
  }

  onSucess() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeView(),
      ),
    );
  }

  onError() {
    final snackBar = SnackBar(
      content: Text("Ops, algo deu errado!"),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  takePicture() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TakePictureView(
          camera: firstCamera,
        ),
      ),
    ).then((imagePath) {
      cropPicture(imagePath);
    });
  }

  cropPicture(path) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CropPictureView(
          path: path,
        ),
      ),
    ).then((imagePath) {
      updateImage(imagePath);
    });
  }

  updateImage(path) async {
    _repository.updateImage(widget.id, path).then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _repository.getContact(widget.id),
      builder: (ctx, snp) {
        if (snp.hasData) {
          ContactModel contact = snp.data;
          return page(context, contact);
        } else {
          return LoadingView();
        }
      },
    );
  }

  @override
  Widget page(BuildContext context, ContactModel model) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Contato"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
              width: double.infinity,
            ),
            ContactDetailsImage(
              image: model.image,
            ),
            SizedBox(
              height: 10,
            ),
            ContactDetailsDescription(
              name: model.name,
              email: model.email,
              phone: model.phone,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FlatButton(
                  shape: CircleBorder(
                    side: BorderSide.none,
                  ),
                  child: Icon(
                    Icons.phone,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: () {
                    launch("tel://${model.phone}");
                  },
                  color: Theme.of(context).primaryColor,
                ),
                FlatButton(
                  shape: CircleBorder(
                    side: BorderSide.none,
                  ),
                  child: Icon(
                    Icons.email,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: () {
                    launch("mailto://${model.email}");
                  },
                  color: Theme.of(context).primaryColor,
                ),
                FlatButton(
                  shape: CircleBorder(
                    side: BorderSide.none,
                  ),
                  child: Icon(
                    Icons.camera_enhance,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: takePicture,
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              child: ListTile(
                title: Text(
                  "Endereço",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      model.addressLine1 ?? "Nenhum endereço cadastrado",
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      model.addressLine2 ?? "",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                isThreeLine: true,
                trailing: FlatButton(
                  shape: CircleBorder(
                    side: BorderSide.none,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddressView()));
                  },
                  child: Icon(
                    Icons.pin_drop,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Container(
                width: double.infinity,
                height: 50,
                color: Color(0xFFFF0000),
                child: FlatButton(
                    child: Text(
                      "Excluir Contato",
                      style: TextStyle(color: Theme.of(context).accentColor),
                    ),
                    onPressed: onDelete),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditorContactView(model: model),
            ),
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.edit,
          color: Theme.of(context).accentColor,
        ),
      ),
    );
  }
}
