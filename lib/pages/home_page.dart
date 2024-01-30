import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_demo_tutorial/models/user_model.dart';

import '../shimmer/home_page_shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  late List<UserModel> users;

  _getUsers() async {
    await Future.delayed(const Duration(seconds: 3));

    users = fakeUsers;
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    _getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Users",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: isLoading
          ? const HomePageShimmer()
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (BuildContext context, int index) {
                UserModel user = users[index];
                return ListTile(
                  leading: SizedBox(
                    height: 50,
                    width: 50,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: FancyShimmerImage(
                            errorWidget: const Icon(
                              Icons.close,
                              color: Colors.red,
                            ),
                            shimmerBaseColor:
                                isDark ? Colors.white12 : Colors.grey.shade300,
                            shimmerHighlightColor:
                                isDark ? Colors.white24 : Colors.grey.shade100,
                            imageUrl: user.imageUrl)),
                  ),
                  title: Text(user.name),
                  subtitle: Text(
                    user.bio,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
            ),
    );
  }
}
