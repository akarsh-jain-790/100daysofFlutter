import 'package:flutter/material.dart';
import 'package:flutter_project/app/common_widgets/show_alert_dialog.dart';
import 'package:flutter_project/services/services.dart';
import 'package:provider/provider.dart';

import '../../services/auth.dart';

class JobsPage extends StatelessWidget {

  Future<void> _signOut(BuildContext context) async{
    try{
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth?.signOut();
    }catch(e){
      print("Unable to logout ${e.toString()}");
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async{
    final didRequestSignOut = await showAlertDialog(
        context,
        title: "Logout",
        content: "Are you sure you want to logout?",
        cancelActionText: "Cancel",
        defaulActionText: "Logout"
    );
    if(didRequestSignOut == true){
      _signOut(context);
    }
  }

  void _createJob(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    database.createJob({
      'name': 'Blogging' ,
      'ratePerHour': 10
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jobs"),
        actions: <Widget>[
          TextButton(
            onPressed: () => _confirmSignOut(context),
            child: const Text(
              "Logout",
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createJob(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
