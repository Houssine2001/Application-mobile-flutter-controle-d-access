import 'package:appflutter/model/user.model.dart';
import 'package:appflutter/repository/user.repo.dart';
import 'package:flutter/material.dart';

class AddUserPage extends StatelessWidget {
  const AddUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _ctrname = TextEditingController();
    final _ctrtime = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(height: 20,),
              TextField(
                controller: _ctrname,
                style: TextStyle(fontSize: 22),
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(40) ))

                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: _ctrtime,
                style: TextStyle(fontSize: 22),
                decoration: InputDecoration(
                    labelText: 'Time',
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(40) ))

                ),
              ),
              SizedBox(height: 30,),
             /* ElevatedButton(
                  onPressed:(){
                    final user = User(name: _ctrname.text, time: _ctrtime.text);
                    addUser(user);
                    _ctrname.text='';
                    _ctrtime.text='';

                  },

                  child: Container
                    (width: double.infinity,
                    child:Icon(Icons.add , size: 32,),
                  )
              )*/

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [


                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      elevation: 5,
                    ),
                    onPressed: () {
                      final user = User(name: _ctrname.text, time: _ctrtime.text);
                      addUser(user);
                      _ctrname.text='';
                      _ctrtime.text='';
                    },
                    child: Text(
                      "Add New User",
                      /*style: TextStyle(
                        fontSize: 20,
                      ),*/
                    ),
                  ),
                ],
              ),


            ],
          ),
        ),
      ),
    );
  }
}
