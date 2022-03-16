import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const _DrawerHeaderWidget(),
          ListTile(
            title: const Text('Home'),
            leading: const Icon(Icons.home),
            onTap: () {
              Navigator.pushNamed(context, 'home');
            },
          ),
          ListTile(
            title: const Text('Setting'),
            leading: const Icon(Icons.settings),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'settings');
            },
          ),
        ],
      ),
    );
  }
}

class _DrawerHeaderWidget extends StatelessWidget {
  const _DrawerHeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: const CircleAvatar(
        radius: 50,
        backgroundColor: Color(0xffFDCF09),
        child: CircleAvatar(
          radius: 55,
          backgroundImage: NetworkImage(
            'https://avatars.githubusercontent.com/u/46093689?v=4',
          ),
        ),
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.8),
            BlendMode.dstATop,
          ),
          image: const NetworkImage(
            'https://images.unsplash.com/photo-1518791841217-8f162f1e1131?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
          ),
          fit: BoxFit.cover,
          opacity: 1,
        ),
      ),
    );
  }
}
