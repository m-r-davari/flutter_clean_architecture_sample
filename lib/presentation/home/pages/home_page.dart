import 'package:flutter/material.dart';

import '../../ip/with_provider/pages/ip_page.dart' as IpPageWithProvider;
import '../../ip/with_riverpod/pages/ip_page.dart' as IpPageWithRiverPod;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Clean Architecture Sample'),
      ),
      body: _bodyWidget(),
    );
  }

  Widget _bodyWidget(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (ctx)=> IpPageWithProvider.IpPage()));
              },
              child: const Text('Whats My IP - With Provider')
          ),
          const SizedBox(height: 8,),
          ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (ctx)=> const IpPageWithRiverPod.IpPage()));
              },
              child: const Text('Whats My IP - With RiverPod')
          )
        ],
      ),
    );
  }
}
