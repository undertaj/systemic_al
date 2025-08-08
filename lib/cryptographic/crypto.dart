/*
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
// import 'package:instagram_login/instagram_login.dart';

class HomePage extends StatefulWidget {

  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
*/

/*
class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/images/face1.jpeg'),
                backgroundColor: Colors.white.withOpacity(0.2),

                child: Container(
                  // height: 35,
                  // width: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: Color(0xffff38ae),
                          width: 1,
                        )
                    ),
                    child: CircleAvatar(
                      radius: 14,
                      backgroundImage: AssetImage('assets/images/face1.jpeg'),
                    )
                )
            )
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Riya William', style: TextStyle(fontSize: 18, color: Color(0xffFF3A8E), fontWeight: FontWeight.w600),),
            Text('Welcome', style: TextStyle(fontSize: 14, color: Color(0xff22172A), fontWeight: FontWeight.w400),),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: SvgPicture.asset('assets/images/notif.svg', width: 36,height: 36,),
          ),
        ],

      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 70,
        items: [
          Icon(Icons.home_filled, color: Colors.white,),
          SvgPicture.asset('assets/images/location.svg'),

          Icon(Icons.add,color: Colors.white,),
          Icon(Icons.people_alt_outlined,color: Colors.white,),
          SvgPicture.asset('assets/images/chat.svg'),
        ],
        backgroundColor: Color(0x00000000),
        color: Color(0xff2c272c),
        buttonBackgroundColor: Color(0xffff38ae),

      ),
      body: Container(
        child: Column(
            children: [
              SizedBox(height: 80),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xffFF3A8E).withOpacity(0.12),
                      spreadRadius: -1,
                      blurRadius: 4,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.only(
                            topLeft: Radius.circular(22),
                            bottomLeft: Radius.circular(22),
                          ),
                        ),

                        height: 56,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 12,),
                            SvgPicture.asset('assets/images/search.svg',),
                            SizedBox(width: 12,),
                            Text('Search your Partner', style: TextStyle(color: Color(0xffA1B0CC), fontSize: 12, fontWeight: FontWeight.w400),),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 56,
                      width: 56,
                      decoration: BoxDecoration(
                        color: Color(0xffFF3A8E),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(22),
                          topRight: Radius.circular(22),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                        child: SvgPicture.asset('assets/images/filters.svg', width: 24, height: 24,),

                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 12, top: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Text(
                        'Status', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, fontFamily: 'poppins'),
                      ),
                    ),
                    SizedBox(height: 18,),
                    Container(
                      height: 99,
                      width: MediaQuery.of(context).size.width -12,
                      child: ListView(
                        scrollDirection: Axis.horizontal,

                        children: [
                          StatusWidget(name: 'My Tale'),
                          StatusWidget(name: 'Mani'),
                          StatusWidget(name: 'karthik'),
                          StatusWidget(name: 'Vimal'),
                          StatusWidget(name: 'Vibhu'),
                          StatusWidget(name: 'Mani'),

                        ],
                      ),
                    )
                  ],

                ),
              ),
              Container(
                  margin: EdgeInsets.all(16),


                  child: Column(
                    children: [
                      Container(
                        height: 37,
                        width: double.infinity,
                        child: TabBar(
                          tabs: [
                            Tab(text: 'Make Friends'),
                            Tab(text: 'soulmate'),
                          ],
                          unselectedLabelStyle: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            height: 1.5,
                            color: Color(0xff2C272C),
                          ),
                          labelStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              height: 1.5,
                              color: Color(0xffFF3A8E)
                          ),
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorColor: Color(0xffff3a8e),
                          controller: _tabController,
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height*0.4,
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 26, left: 4, right: 4),
                        child:
                          TabBarView(
                              controller: _tabController,
                              children: [
                                SingleChildScrollView(
                                  child: Column(

                                    children: [
                                      CardWidget(),
                                      SizedBox(height: 16,),
                                      CardWidget(),
                                      SizedBox(height: 16,),
                                    ],
                                  ),
                                ),
                                SingleChildScrollView(
                                  child: Column(

                                    children: [
                                      CardWidget(),
                                      SizedBox(height: 16,),
                                      CardWidget(),
                                      SizedBox(height: 16,),
                                    ],
                                  ),
                                ),

                              ]),

                      )
                    ],
                  )
              )
            ]
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  const CardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Container(
            height: 323,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(

                  image: AssetImage('assets/images/card_image.jpeg',),
                  fit: BoxFit.cover,
                ),
                gradient: LinearGradient(
                    colors: [
                      Color(0xff000000),
                      Color(0xff000000),
                    ]
                )
            ),
            // width: MediaQuery.of(context).size.width - 24,
            width: double.infinity,
          ),
          Container(
            height: 323,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),

                gradient: LinearGradient(
                    begin: FractionalOffset.topLeft,
                    end: FractionalOffset.bottomRight,
                    colors: [
                      Colors.black.withOpacity(0.0),
                      Colors.black,
                    ],
                    stops: [
                      0.0,
                      1.0
                    ])
            ),


          ),
          Positioned(
              top: 20,
              left: 16,
              child: Container(
                width: MediaQuery.of(context).size.width* 0.8,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                          children: [
                            Container(
                              height: 26,
                              width: 26,
                              margin: EdgeInsets.only(top: 4, bottom: 3),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      color: Colors.black,
                                      width: 1
                                  )
                              ),
                              child: CircleAvatar(
                                // radius: 25,
                                  backgroundImage: AssetImage('assets/images/face1.jpeg',)
                              ),
                            ),
                            SizedBox(width: 7,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text('Keerthi Karthick', style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500, letterSpacing: 0.1, fontFamily: 'Poppins',  ),  ),
                                    // SvgPicture.asset('assets/images/verified.svg'),
                                    SizedBox(width: 4,),
                                    Image.asset('assets/images/verified2.png'),
                                  ],
                                ),
                                Text('Athlete 🏅', style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.w400, letterSpacing: 0.15, fontFamily: 'Open sans'),),
                              ],
                            ),
                          ]
                      ),
                      ElevatedButton(onPressed: (){},
                          style: ElevatedButton.styleFrom(
                            // fixedSize: Size(80, 32,),
                              backgroundColor: Color(0x4affffff),
                              side: BorderSide(
                                width: 1,
                                color: Color(0xaaffffff),
                              )
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.directions_run, color: Colors.white,),
                                Text('Run', style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500, letterSpacing: 0.1, fontFamily: 'Poppins',  ),),
                              ]
                          )
                      )
                    ]
                ),
              )
          ),
          Positioned(
              top: 142,
              left: 16,
              child: Container(
                  width: 240,
                  child: Text('There\'s a lot of room for improvement, your  are always welcome 😍',
                    style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600, letterSpacing: 0.1, fontFamily: 'Poppins',  ),)
              )
          ),
          for(int i = 0; i < 5; i++)
            Positioned(
              top: 225,
              left: 16+ double.parse((10*i).toString()),
              child: Container(
                height: 28,
                width: 28,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Color(0x40ffffff),
                      width: 1,

                    )
                ),
                child: CircleAvatar(

                  radius: 14,
                  backgroundImage: AssetImage('assets/images/face1.jpeg',),
                ),
              ),

            ),
          Positioned(
            top: 232,
            left: 92,
            child: Text('+5 more', style: TextStyle(fontSize: 9, color: Color(0x8cffffff), fontWeight: FontWeight.w500, letterSpacing: 0.1, fontFamily: 'Poppins',  ),),
          ),
          Positioned(
              top: 271,
              left: 86,
              child: Container(
                child: Row(
                    children: [
                      IconButton(onPressed: (){},
                          style: ElevatedButton.styleFrom(
                            // fixedSize: Size(80, 32,),
                            backgroundColor: Color(0x3affffff),
                            side: BorderSide(
                              width: 1,
                              color: Color(0xaaffffff),
                            ),

                          ),
                          icon: SvgPicture.asset('assets/images/like_button.svg')
                      ),
                      SizedBox(width: 20,),
                      IconButton(onPressed: (){},
                          style: ElevatedButton.styleFrom(
                            // fixedSize: Size(80, 32,),
                            backgroundColor: Color(0x4affffff),
                            side: BorderSide(
                              width: 1,
                              color: Color(0xaaffffff),
                            ),

                          ),
                          icon: SvgPicture.asset('assets/images/chat.svg')
                      ),
                      SizedBox(width: 20,),
                      IconButton(onPressed: (){},
                          style: ElevatedButton.styleFrom(
                            // fixedSize: Size(80, 32,),
                            backgroundColor: Color(0x4affffff),
                            side: BorderSide(
                              width: 1,
                              color: Color(0xaaffffff),
                            ),

                          ),
                          icon: SvgPicture.asset('assets/images/three_dots.svg')
                      ),

                    ]
                ),
              )
          ),
        ]
    );
  }
}


class StatusWidget extends StatelessWidget {
  final String name;
  const StatusWidget({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(75),
                  border: Border.all(
                    color: Color(0xffFFC9E0),
                    width: 2,
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: CircleAvatar(

                  radius: 33,
                  backgroundImage: AssetImage('assets/images/face1.jpeg'),
                ),
              ),
            ),
            SizedBox(height: 8,),
            Text('${name}',style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'poppins',height: 0.86 ),),
          ],
        ),
        SizedBox(width: 6,),
      ],
    );
  }
}





class MyHomePage1 extends StatelessWidget {
  final FacebookLogin facebookLogin = FacebookLogin();
  final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
  final InstagramLogin instagramLogin = InstagramLogin(
    clientId: 'YOUR_INSTAGRAM_CLIENT_ID',
    redirectUri: 'YOUR_REDIRECT_URI',
  );

  void _loginWithFacebook() async {
    final result = await facebookLogin.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
      // Get access token
        final token = result.accessToken.token;
        print('Logged in with Facebook! Token: $token');
        break;
      case FacebookLoginStatus.cancelledByUser:
        print('Facebook login cancelled by user.');
        break;
      case FacebookLoginStatus.error:
        print('Facebook login error: ${result.errorMessage}');
        break;
    }
  }

  void _loginWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
        final String token = googleAuth.accessToken;
        print('Logged in with Google! Token: $token');
      }
    } catch (error) {
      print('Google login error: $error');
    }
  }

  void _loginWithInstagram() async {
    final result = await instagramLogin.authorize(context);
    if (result.status == InstagramLoginStatus.success) {
      final token = result.session.token;
      print('Logged in with Instagram! Token: $token');
    } else if (result.status == InstagramLoginStatus.cancelledByUser) {
      print('Instagram login cancelled by user.');
    } else {
      print('Instagram login error: ${result.errorMessage}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Social Login Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FacebookSignInButton(
              onPressed: _loginWithFacebook,
              text: 'Login with Facebook',
            ),
            GoogleSignInButton(
              onPressed: _loginWithGoogle,
              text: 'Login with Google',
            ),
            RaisedButton(
              onPressed: _loginWithInstagram,
              child: Text('Login with Instagram'),
            ),
          ],
        ),
      ),
    );
  }
}

*/