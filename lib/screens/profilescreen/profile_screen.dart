import 'package:buying/screens/profilescreen/profileprovider.dart';
import 'package:buying/widget/textwidgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, profileProvider, _) {
          List<Widget> profileDetails = [
            _buildProfileTile('Gender', profileProvider.gender),
            _buildProfileTile('Height', profileProvider.height),
            _buildProfileTile('Weight', profileProvider.weight),
            _buildProfileTile('Age', profileProvider.age.toString()),
            // _buildProfileTile('Goals', _buildChipList(profileProvider.goals) ),
            _buildProfileTile('Experience', profileProvider.experience),
            _buildProfileTile('Equipment', profileProvider.equipment),
            // _buildProfileTile('Interests', _buildChipList(profileProvider.interests) ),
            // _buildProfileTile('Focus', _buildChipList(profileProvider.focus) ),
          ];

          return ListView(children: profileDetails);
        },
      ),
    );
  }

  Widget _buildProfileTile(String title, String value) {
    return ListTile(
      title: Text(title),
      trailing: Chip(label: Text(value)),
    );
  }

  Widget _buildChipList(List<String> items) {
    return Wrap(
      children: List.generate(
        items.length,
            (index) => Chip(label: Text(items[index])),
      ),
    );
  }
}
