import 'package:flutter/material.dart';
import 'package:news/models/user_models.dart';
import 'package:news/service/local/notification_service.dart';
import 'package:timezone/data/latest.dart' as tz;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    tz.initializeTimeZones();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title:const Text("Alert App")),
        body: FutureBuilder(builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            List<UserModel> data = snapshot.data as List<UserModel>;
            return ListView.builder(itemBuilder: (context, index) {
              return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (DismissDirection direction) async {
                    if (direction == DismissDirection.startToEnd) {
                      await NotificationService().showNotification(
                          id: index,
                          title: "Ogohlantirish",
                          body: "${data[index].name} o'chorildi");
                    }
                  },child: ListTile(title: Text(data[index].name.toString()),
                  ),
                  );
            },
            itemCount: data.length,);
          }
        }));
  }
}
