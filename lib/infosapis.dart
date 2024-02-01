import 'api_call.dart';
import 'package:flutter/material.dart';
class Mail extends StatefulWidget {
  const Mail({Key? key}) : super(key: key);

  @override
  State<Mail> createState() => _MailState();
}

class _MailState extends State<Mail> {
  late Future<List<Users>> users;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    users = getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: FutureBuilder<List<Users>>(
                future: users,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(snapshot.data![index].name),
                            subtitle: Text(snapshot.data![index].email),
                            trailing: Text(snapshot.data![index].username),
                          );
                        });
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
          ),
        ));
  }
}