import 'package:flutter/material.dart';
import 'package:photos/screens/photo.page.dart';
import 'dashboard.dart';
import 'day.dart';
import 'infosapis.dart';
void main()=>runApp(MyApp());
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentPage = DrawerSections.dashboard;

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.dashboard) {
      container = DashboardPage();
    } else if (currentPage == DrawerSections.photos) {
      container = PhotoPage();
    } else if (currentPage == DrawerSections.infosapi) {
      container = Mail();
    } else if (currentPage == DrawerSections.day) {
      container = DayPage();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: Text("Final Project"),
      ),
      body: container,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                MyDrawerList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget MyDrawerList() {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Dashboard", Icons.dashboard_outlined,
              currentPage == DrawerSections.dashboard ? true : false),
          menuItem(2, "Photos", Icons.people_alt_outlined,
              currentPage == DrawerSections.photos ? true : false),
          menuItem(3, "Api Email", Icons.event,
              currentPage == DrawerSections.infosapi ? true : false),
          menuItem(4, "Day", Icons.notes,
              currentPage == DrawerSections.day ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.dashboard;
            } else if (id == 2) {
              currentPage = DrawerSections.photos;
            } else if (id == 3) {
              currentPage = DrawerSections.infosapi;
            } else if (id == 4) {
              currentPage = DrawerSections.day;
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSections {
  dashboard,
  photos,
  infosapi,
  day,

}
