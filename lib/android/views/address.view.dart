import 'package:flutter/material.dart';

class AddressView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text("Endereço do Contato"),
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: 80,
              child: ListTile(
                title: Text(
                  "Endereço atual",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Av. dos Devs, 500",
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      "Natal/RN",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                isThreeLine: true,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 80,
              child: TextFormField(
                decoration: InputDecoration(labelText: "Pesquisar..."),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.blue.withOpacity(0.2),
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.my_location),
          onPressed: () {},
        ));
  }
}
