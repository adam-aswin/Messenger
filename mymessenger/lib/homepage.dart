import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {
  late TabController _tabController;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Future logout() async {
    final googleSignIn = GoogleSignIn();
    try {
      if (await googleSignIn.isSignedIn()) {
        await FirebaseAuth.instance.signOut();
        await googleSignIn.signOut();
        if (await googleSignIn.isSignedIn()) {
          await googleSignIn.disconnect();
        } else {
          print("User not signed In");
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color.fromARGB(255, 238, 228, 255),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Messenger",
          style: TextStyle(
            // fontSize: 20,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          style: IconButton.styleFrom(),
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
          icon: Icon(
            Icons.more_horiz,
            color: Colors.black,
          ),
        ),
        actions: [],
        bottom: TabBar(
          controller: _tabController,
          dividerColor: const Color.fromARGB(255, 238, 228, 255),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.deepPurple,
          ),
          tabs: [
            Tab(
              icon: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.chat,
                    size: 16,
                  ),
                  Text("Chats"),
                ],
              ),
            ),
            Tab(
              icon: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.group,
                    size: 16,
                  ),
                  Text("Groups"),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 238, 228, 255),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: DrawerHeader(
                child: Text(""),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: logout,
                  icon: Icon(Icons.logout),
                ),
                SizedBox(
                  width: 8,
                ),
                Text("Logout"),
              ],
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            // color: Colors.deepPurple,
            padding: EdgeInsets.only(bottom: 20, right: 20),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return ListTile();
                    },
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FloatingActionButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/details");
                        },
                        child: Icon(Icons.message),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Text("Groups"),
          ),
        ],
      ),
    );
  }
}
