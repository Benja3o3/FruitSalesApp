import 'package:flutter/material.dart';
import 'package:frontend/api/auth.dart';
import 'package:frontend/models/profile.dart';
import 'package:provider/provider.dart';
import 'package:frontend/providers/userProvider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Auth auth = Auth();
  late Profile profile = Profile();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Text(context.watch<userProvider>().username),
            Text(context.watch<userProvider>().token),
            ElevatedButton(
                onPressed: () async {
                  final staticUserProvider =
                      Provider.of<userProvider>(context, listen: false);
                  final response =
                      await auth.getProfile(staticUserProvider.token);
                  setState(() {
                    profile = response;
                  });
                },
                child: Text("Get Datos")),
            Text(profile.username)
          ],
        ),
      ),
    );
  }
}
