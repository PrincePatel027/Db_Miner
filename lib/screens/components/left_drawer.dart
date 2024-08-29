import 'package:flutter/material.dart';

class LeftDrawer extends StatefulWidget {
  const LeftDrawer({super.key});

  @override
  State<LeftDrawer> createState() => _LeftDrawerState();
}

class _LeftDrawerState extends State<LeftDrawer> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Drawer(
      backgroundColor: const Color(0xFF8280EB),
      child: Column(
        children: [
          const DrawerHeader(
            padding: EdgeInsets.all(0),
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF8280EB),
              ),
              margin: EdgeInsets.all(0),
              currentAccountPicture: CircleAvatar(
                child: Icon(Icons.supervised_user_circle_outlined),
              ),
              accountName: Text("Prince Patel"),
              accountEmail: Text("princeghadiya699@gmail.com"),
            ),
          ),
          SizedBox(height: height * 0.02),
          Text(
            "Change Theme",
            style: TextStyle(
              fontSize: width * 0.04,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: height * 0.01),
          RadioListTile(
            title: const Text("Light theme"),
            value: "theme",
            groupValue: "Light",
            onChanged: (value) {},
          ),
          RadioListTile(
            title: const Text("Dark theme"),
            value: "theme",
            groupValue: "Dark",
            onChanged: (value) {},
          ),
          RadioListTile(
            title: const Text("System theme"),
            value: "system",
            groupValue: "Dark",
            onChanged: (value) {},
          ),
          const Divider(),
          Text(
            "Settings",
            style: TextStyle(
              fontSize: width * 0.04,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
