import 'package:flutter/material.dart';
import 'package:court_craze/services/network.dart';
import 'package:court_craze/services/urls.dart';
import 'package:court_craze/json/jsons.dart';
import 'package:provider/provider.dart';
import 'package:court_craze/components/games_widgets/gamelst.dart';

class Games extends StatefulWidget {
  const Games({super.key});

  @override
  State<Games> createState() => _GamesState();
}

class _GamesState extends State<Games> {
  DateTime _selectedDate = DateTime.now();
  @override
  void initState() {
    _selectedDate = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Theme.of(context).canvasColor,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime(DateTime.now().year - 2),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null && pickedDate != _selectedDate) {
                    setState(() {
                      _selectedDate = pickedDate;
                    });
                  }
                },
                child: Text(
                  "${_selectedDate.toLocal()}".split(' ')[0],
                ),
              ),
            ],
          ),
        ),
        body:
            // Provider.of<JsonFiles>(context, listen: false).getGames() == null
            //     ?
            FutureBuilder(
                future: Network.getJson(Urls.seasonGames(_selectedDate)),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    Provider.of<JsonFiles>(context, listen: false)
                        .setGames(snapshot.data);
                    dynamic json = snapshot.data;
                    return SeasonGames(
                      jsonFile: json,
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error,
                            size: 50,
                          ),
                          Text("An error occured!"),
                        ],
                      ),
                    );
                  } else if (snapshot.data == null) {
                    return const Center(child: Text('Loading....'));
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })
        );
  }
}
