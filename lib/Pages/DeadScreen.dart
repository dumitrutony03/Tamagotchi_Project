import 'package:flutter/material.dart';

class DeadScreen extends StatefulWidget {
  const DeadScreen({super.key});

  @override
  State<DeadScreen> createState() => _DeadScreenState();
}

class _DeadScreenState extends State<DeadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('DeadScreen'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,

          /// DEAD TAMAGOTCHI GIF
          children: <Widget>[
            // Add the Tamagotchi image here
            Image.network(
              'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/291382b1-7579-4c49-ad47-cf14b8d59a12/d7a9caj-daa6d044-527b-44b7-940a-9bdddb5535da.gif?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcLzI5MTM4MmIxLTc1NzktNGM0OS1hZDQ3LWNmMTRiOGQ1OWExMlwvZDdhOWNhai1kYWE2ZDA0NC01MjdiLTQ0YjctOTQwYS05YmRkZGI1NTM1ZGEuZ2lmIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.Necjg2dxJj-MDNaZoPCo6eWanCKwn9UGq-27JolGnkU',
              height: 128,
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              width: 42.0,
              height: 42.0,
              child: ElevatedButton(
                child: const Text('Get back to Tami'),
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/Tamagotchi');
                  // Navigator.pop(context);
                  // Get.to(TamagotchiScreen());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
