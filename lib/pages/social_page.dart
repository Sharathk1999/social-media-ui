import 'package:flutter/material.dart';


class SocialPage extends StatefulWidget {
  const SocialPage({super.key});

  @override
  State<SocialPage> createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("The weeknd"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: SearchMember());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top image and community details
            Stack(
              children: [
                Image.network(
                  'https://example.com/image.jpg', // Replace with the actual image URL
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                const Positioned(
                  bottom: 16,
                  left: 16,
                  child: Text(
                    'The weeknd',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Community - 11K Members',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod vestibulum lacus, nec consequat nulla efficitur sit amet...',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: List.generate(
                      5,
                      (index) => const Chip(
                        label: Text('Outdoor'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Media, docs and links',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 100,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(
                        5,
                        (index) => Container(
                          width: 100,
                          margin: const EdgeInsets.only(right: 8),
                          child: Image.network('https://example.com/media.jpg'),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    leading: const Icon(Icons.notifications_off),
                    title: const Text('Mute notification'),
                    trailing: Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                        });
                      },
                    ),
                  ),
                  const ListTile(
                    leading:  Icon(Icons.clear),
                    title: Text('Clear chat'),
                  ),
                  const ListTile(
                    leading: Icon(Icons.lock),
                    title: Text('Encryption'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.exit_to_app),
                    title: const Text('Exit community'),
                    onTap: () {
                      // Exit community action
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.report),
                    title: const Text('Report'),
                    onTap: () {
                      // Report action
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchMember extends SearchDelegate<String> {
  final members = List.generate(10, (index) => 'Yashika, 29, India');
  final recentMembers = ['Yashika, 29, India'];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, "null");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView(
      children: members
          .where((member) => member.toLowerCase().contains(query.toLowerCase()))
          .map<ListTile>((member) => ListTile(
                title: RichText(
                  text: TextSpan(
                    text: member.substring(0, query.length),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: member.substring(query.length),
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                trailing: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Add'),
                ),
              ))
          .toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentMembers
        : members.where((member) => member.toLowerCase().contains(query.toLowerCase())).toList();
    return ListView(
      children: suggestionList
          .map<ListTile>((member) => ListTile(
                title: RichText(
                  text: TextSpan(
                    text: member.substring(0, query.length),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: member.substring(query.length),
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                trailing: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Add'),
                ),
              ))
          .toList(),
    );
  }
}