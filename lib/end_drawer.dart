
import 'package:flutter/material.dart';

class MyEndDrawer extends StatelessWidget {
  const MyEndDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width/2.5,
      child: SafeArea(
        child: ListView(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: ListTile(
                title: const Text('About Us'),
                trailing: const Icon(Icons.arrow_forward_ios_sharp),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const AboutUs()));
                },
              ),
            ),
            // Add more ListTiles for additional options if needed
          ],
        ),
      ),
    );
  }
}

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        centerTitle: true,
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           Center(
            child: Text('Mr.HappiestMan'),
          ),
        ],
      ),
    );
  }
}
