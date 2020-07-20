import 'package:contacts/ios/styles.dart';
import 'package:flutter/cupertino.dart';

class AddressView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: Text("Endereço"),
            trailing: CupertinoButton(
              onPressed: () {},
              child: Icon(
                CupertinoIcons.location,
                color: primaryColor,
              ),
            ),
          ),
          SliverFillRemaining(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Endereço Atual",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Av. dos Devs, 500",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Natal/RN",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: CupertinoTextField(
                    placeholder: "Pesquisar...",
                  ),
                ),
                Expanded(
                  child: Container(
                    color: primaryColor.withOpacity(0.2),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
