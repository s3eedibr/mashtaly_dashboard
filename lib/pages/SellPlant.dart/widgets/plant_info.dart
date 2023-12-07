import 'package:flutter/material.dart';

class UserName extends StatelessWidget {
  const UserName({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
                child: Column(children: [
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 60.0,
                      backgroundImage: NetworkImage(
                          'https://pps.whatsapp.net/v/t61.24694-24/367830185_1332801800668516_5325477058315588699_n.jpg?ccb=11-4&oh=01_AdStlrjK8hPYF4J7xE9SZd1hVhjbYWFR8x38RiovlMVz7Q&oe=657A2FAA&_nc_sid=e6ed6c&_nc_cat=100'),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'User Name',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Articles',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 200.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        'https://dfstudio-d420.kxcdn.com/wordpress/wp-content/uploads/2019/06/digital_camera_photo-1080x675.jpg')),
                              ),
                            ),
                            Text(
                              'How to plant',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),
                            Text(
                              'by mhamd bl3awi',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'How to plant',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),
                            Text(
                              'by mhamd bl3awi',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  'Plants for sell',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 200.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      'https://dfstudio-d420.kxcdn.com/wordpress/wp-content/uploads/2019/06/digital_camera_photo-1080x675.jpg')),
                            ),
                          ),
                          Text(
                            'How to plant',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                          ),
                          Text(
                            'by mhamd bl3awi',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 60.0,
                          ),
                          Expanded(
                            child: MaterialButton(
                                color: Colors.green,
                                height: 50.0,
                                child: Text(
                                  'Reset Password',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () {}),
                          ),
                          SizedBox(
                            width: 60.0,
                          ),
                          Expanded(
                            child: MaterialButton(
                                color: Colors.green,
                                height: 50.0,
                                child: Text(
                                  'Activate',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () {}),
                          ),
                          SizedBox(
                            width: 60.0,
                          ),
                          Expanded(
                            child: MaterialButton(
                                color: Colors.orange[800],
                                height: 50.0,
                                child: Text(
                                  'Deactivate',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () {}),
                          ),
                          SizedBox(
                            width: 60.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
            ]))));
  }
}
// MaterialButton(
// color: Colors.red,
// height: 50.0,
// child:
// Text(
// 'reset password',
//
// style: TextStyle(
// fontSize: 15.0,
// fontWeight: FontWeight.bold,
// color: Colors.white,
// ),
// ),
// onPressed: (){}
// ),
