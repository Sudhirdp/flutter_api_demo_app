import 'package:flutter/material.dart';
import 'package:flutter_api_learn/services/user_api.dart';
import '../model/random_user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<User> users = [];

  Future<void> fetchUsers()async{
    final response= await UserApi.fetchUsers();
    setState(() {
      users=response;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rest API Call'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          final color = user.gender == 'male' ? Colors.green : Colors.red;
          return ListTile(
            title: Text(user.fullName),
            leading: ClipRRect(
              borderRadius:BorderRadius.circular(10),
              child:Image.network(user.picture.thumbnail),
            ),
            subtitle: Text(user.location.city), 
            tileColor: color,
          );
        },
      ),
    );
  }
}
