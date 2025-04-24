import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.grey[300],
                            child: Icon(
                              Icons.person,
                              size: 60,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'pirnce kumar',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                      side: const BorderSide(
                                        color: Colors.blue,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text('Edit my details'),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              const Row(
                                children: [
                                  Text('21  ', style: TextStyle(fontSize: 16)),
                                  Text(
                                    'Male  ',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text('India', style: TextStyle(fontSize: 16)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Text(
                        'Achievements',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          _achievementTile('Sentinel', Colors.blue),
                          _achievementTile('Editor', Colors.orange),
                          _achievementTile('Communicator', Colors.teal),
                        ],
                      ),
                      const SizedBox(height: 32),
                      const Align(
                        //alignment: Alignment.centerLeft,
                        child: Text(
                          'Interests',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 10,
                        children: const [
                          _tag('Technology and Gadgets'),
                          _tag('Cultural Exchange'),
                          _tag('Science and Nature'),
                        ],
                      ),
                      const SizedBox(height: 32),
                      const Align(
                        // alignment: Alignment.centerLeft,
                        child: Text(
                          'Goals',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const _tag('#CulturalExchange'),
                      const SizedBox(height: 32),
                      Row(
                        children: const [
                          Text(
                            'About Me',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 12),
                          Text('Edit', style: TextStyle(color: Colors.blue)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                        child: const Text(
                          'I GIVE RISPECT',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _achievementTile extends StatelessWidget {
  final String title;
  final Color color;

  const _achievementTile(this.title, this.color);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontSize: 16)),
          const Text('Unranked'),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'lv. 0',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Container(height: 5, width: 100, color: Colors.grey[300]),
        ],
      ),
    );
  }
}

class _tag extends StatelessWidget {
  final String text;

  const _tag(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.orange[300],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }
}

// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 CircleAvatar(
//                   radius: 60,
//                   backgroundColor: Colors.grey[300],
//                   child: Icon(Icons.person, size: 60, color: Colors.grey[600]),
//                 ),

//                 const SizedBox(width: 20),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         const Text(
//                           'pirnce kumar',
//                           style: TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(width: 8),
//                         TextButton(
//                           onPressed: () {},
//                           style: TextButton.styleFrom(
//                             side: const BorderSide(color: Colors.blue),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                           ),
//                           child: const Text('Edit my details'),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
