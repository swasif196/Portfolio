import 'package:flutter/material.dart';
import 'authentication.dart';
import 'app_page.dart';
import 'stock.dart';
import 'display.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Authentication.initializeFirebase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Stocks';

    return MaterialApp(
      title: appTitle,
      home: Builder(
        builder: (context) => AppPage( // need builder to obtain correct context for navigator to work
          title: appTitle,
          body: MyCustomForm(),
        ),
      ),
    );
  }
}

enum SingingCharacter { US, CDN }

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);
  @override
  MyCustomFormState createState() {
    //const MyCustomForm({Key key}) : super(key: key);
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.

  SingingCharacter? _character = SingingCharacter.US;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    String symbol = "";
    return Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment:  MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  "Please Enter A Symbol To Search!",
                  style: TextStyle(fontSize: 24),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextFormField( // The validator receives the text that the user has entered.
                  decoration: const InputDecoration(
                    hintText: 'Enter A Symbol',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a valid symbol';
                    }
                    symbol = value.toUpperCase();
                  return null;
                  },
                ),
              ),
              ListTile(
                title: const Text('Us Markets'),
                leading: Radio<SingingCharacter>(
                  value: SingingCharacter.US,
                  groupValue: _character,
                  onChanged: (SingingCharacter? value) {
                    setState(() {
                      _character = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Canadian Markets'),
                leading: Radio<SingingCharacter>(
                  value: SingingCharacter.CDN,
                  groupValue: _character,
                  onChanged: (SingingCharacter? value) {
                    setState(() {
                      _character = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.5),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      Stock? stock = await Stock.getStock(symbol, _character == SingingCharacter.US ? "US" : "CDN");

                      if (stock == null){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid Symbol!")));
                      }
                      else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DisplayPage(stock: stock))
                        );
                      }
                    }
                  },
                child: Text('Search Symbol'),// Add TextFormFields and ElevatedButton here.
                )
            )
          ],
        ),
    );
  }
}
