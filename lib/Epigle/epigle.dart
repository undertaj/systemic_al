import 'dart:math';

import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';





class RecentsBody extends StatefulWidget {
  final List<List<CallLogEntry>> groups;
  const RecentsBody({super.key, required this.groups});

  @override
  State<RecentsBody> createState() => _RecentsBodyState();
}

class _RecentsBodyState extends State<RecentsBody> {
  final ScrollController _scrollController = ScrollController();
  final List<Color> codes = [const Color(0xff00821e), const Color(0xff7c0082),const Color(0xff210082),const Color(0xff668200),const Color(0xff820000)];




  @override
  Widget build(BuildContext context) {

    DateTime _date;
    String _listdate = "";
    DateTime _currentDate = DateTime.now();
    String today = "${_currentDate.day}-${_currentDate.month}-${_currentDate.year}";
    DateTime yesterday = DateTime.now().subtract(const Duration(days:1));
    String yest = "${yesterday.day}-${yesterday.month}-${yesterday.year}";
    print(today+yest+_listdate);

    String? getTime(DateTime time) {
      int h = time.hour;
      int m = time.minute;
      if(h >= 12) {
        if(h != 12) {
          h-= 12;
        }
        return "${h.toString().length == 1 ? '0': ''}$h:${m.toString().length == 1 ? '0': ''}$m PM";
      }
      else {
        if(h == 0) {
          h+=12;
        }
        return "${h.toString().length == 1 ? '0': ''}$h:${m.toString().length == 1 ? '0': ''}$m AM";
      }
    }
    // {entry.formattedNumber}', ),
    // {entry.cachedMatchedNumber}', ),
    // {entry.number}', ),
    // {entry.name}',),
    // {entry.callType}', ),
    // {DateTime.fromMillisecondsSinceEpoch(entry.timestamp!)}',),
    // {entry.duration}', ),
    // {entry.phoneAccountId}', ),
    // {entry.simDisplayName}', ),

    return Padding(
      padding: const EdgeInsets.only(left:21.0, right: 21.0, top:10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: const Color(0xffE7E6EE),
            ),
            child: Text(

              today == _listdate ? "Today" : (_listdate == yest ? "Yesterday" : _listdate),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            )),


          ListView.builder(

              itemCount: widget.groups.length,
                  itemBuilder:
                      (context, index) {
                    List<List<CallLogEntry>> groups = widget.groups;

                    // Check if number is null


                    if (index >= groups.length)
                      return const SizedBox(height: 0,);
                    print("Length is: ${groups[index].length}");
                    if (groups[index].isEmpty)
                      return const SizedBox(height: 0,);

                    if (groups[index].isNotEmpty) {
                      // _date = DateTime.fromMillisecondsSinceEpoch(
                      //     groups[index][0].timestamp!);
                      // _listdate = "${_date.day}-${_date.month}-${_date.year}";
                    }
                    var firstEntry = groups[index][0];
                    return Padding(

                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: InkWell(
                          onTap: () {
                            // Navigator.push(context, MaterialPageRoute(builder: (context) =>DialerPage()));
                          },
                          child: Container(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                          radius: 26.44,
                                          // backgroundImage: AssetImage('assets/images/face1.jpeg'),
                                          backgroundColor: codes[Random().nextInt(5)].withOpacity(0.4),
                                          child: Text(
                                            firstEntry.name == null || firstEntry.name == "" ? "" : ((firstEntry.name).toString())[0].toUpperCase(),
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          )
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 12.75),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            SizedBox(
                                              width: MediaQuery.of(context).size.width * 0.5,
                                              child: Text(
                                                (firstEntry.name == null ? (firstEntry.number ?? "") : firstEntry.name).toString(),
                                                style: const TextStyle(
                                                    fontSize: 16.59,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xff676578)
                                                ),
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            (firstEntry.name != null) ?
                                            Row(
                                              children: [
                                                Text(firstEntry.number.toString(),
                                                  style: const TextStyle(
                                                      fontSize: 12.44,
                                                      fontWeight: FontWeight.w400,
                                                      color: Color(0xff9B98A4)
                                                  ),
                                                ),
                                                const SizedBox(width: 6),
                                                (groups[index].length > 1) ?
                                                Text(
                                                  "(${groups[index].length})",
                                                  style: const TextStyle(
                                                      fontSize: 12.44,
                                                      fontWeight: FontWeight.w400,
                                                      color: Color(0xff9B98A4)
                                                  ),
                                                ) :const SizedBox(height: 0),
                                              ],
                                            ):const SizedBox(height: 0),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 85,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [

                                        SizedBox(
                                          height: 14,
                                          width: 14,
                                          child: SvgPicture.asset(
                                            firstEntry.callType == CallType.outgoing
                                                ? 'assets/icons/outgoing.svg'
                                                :
                                            (firstEntry.callType == CallType.incoming ?
                                            'assets/icons/incoming.svg' :
                                            'assets/icons/missed.svg'),
                                            color:
                                            firstEntry.callType == CallType.missed
                                                ? const Color(0xffE85461)
                                                : const Color(0xff93CB80),
                                            fit: BoxFit.scaleDown,
                                          ),
                                        ),

                                        Text(
                                          getTime(DateTime.fromMillisecondsSinceEpoch(firstEntry.timestamp!))!,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff9B98A4)
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ]
                            ),
                          ),
                        ),
                      ),
                    );
                  }

            ),
          // Container(
          //   height: 300,
          //   width: 300,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(160),
          //     color: Color(0xffE7E6EE),
          //   ),
          //
          //   child: CustomNav(),
          // ),

        ],
      ),
    );
  }
}

class ContactsBody extends StatelessWidget {
  final List<String> character = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"];
  ContactsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:21.0, top:10),
      child: Row(
        children: [
          Expanded(
            flex: 9,
            child: ListView.builder(
              itemCount: 7,

              itemBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 19.44),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 26.44,
                        backgroundImage: AssetImage('assets/images/face1.jpeg'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 12.75),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text('Akash',
                              style: TextStyle(
                                  fontSize: 16.59,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff676578)
                              ),
                            ),
                            Text('+972 76 264 861 6',
                              style: TextStyle(
                                  fontSize: 12.44,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff9B98A4)
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: 26,
              itemBuilder: (context, index) {
                return Text(character[index],
                  style: const TextStyle(
                    fontSize: 11.98,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff9B98A4),

                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ChatsBody extends StatefulWidget {
  const ChatsBody({super.key});

  @override
  State<ChatsBody> createState() => _ChatsBodyState();
}

class _ChatsBodyState extends State<ChatsBody> {
  final TextEditingController _controller = TextEditingController();

  final List<Map<String, dynamic>> _messages = [
    {'message': 'Hello', 'isMe': false, 'isAudio': false},
    {'message': 'Hi', 'isMe': true, 'isAudio': false},
    {'message': 'How are you?', 'isMe': false, 'isAudio': false},
    {'message': 'I am fine', 'isMe': true, 'isAudio': false},
    {'message': 'What about you?', 'isMe': true, 'isAudio': false},
    {'message': 'I am also fine', 'isMe': false, 'isAudio': false},
    {'message': 'Good to hear that', 'isMe': true, 'isAudio': false},
    {
      'message': 'Can I help you with anything?',
      'isMe': false,
      'isAudio': false
    },
    {'message': 'No, thanks', 'isMe': true, 'isAudio': false},
    {'message': 'Okay', 'isMe': false, 'isAudio': false},
    {'message': 'Bye', 'isMe': true, 'isAudio': false},
    {'message': 'Bye', 'isMe': false, 'isAudio': false},
    {'message': 'Lorem ipsum dolor sit amet', 'isMe': false, 'isAudio': false},
    {'message': 'Consectetur adipiscing elit', 'isMe': true, 'isAudio': false},
    {
      'message':
      'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
      'isMe': false,
      'isAudio': false,
    },
    {'message': 'Ut enim ad minim veniam', 'isMe': true, 'isAudio': false},
    {
      'message': '02:45',
      'isMe': false,
      'isAudio': true,
    },
    {
      'message':
      'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur',
      'isMe': true,
      'isAudio': false,
    },
    {
      'message': 'Excepteur sint occaecat cupidatat non proident',
      'isMe': false,
      'isAudio': false
    },
    {
      'message':
      'Sunt in culpa qui officia deserunt mollit anim id est laborum',
      'isMe': true,
      'isAudio': false
    },
  ];

  void _addMessage(String message, bool isMe) {
    setState(() {
      _messages.add({'message': message, 'isMe': isMe});
    });
    _controller.clear();
  }

  @override
  void initState() {
    _controller.addListener(() {
      setState(() {
        _controller.text;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _messages.length,
            reverse: true,
            itemBuilder: (context, index) {
              index = _messages.length - 1 - index;
              final message = _messages[index]['message'];
              final isMe = _messages[index]['isMe'];
              final isAudio = _messages[index]['isAudio'];

              return ListTile(
                title: Align(
                  alignment:
                  isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.6,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                    decoration: BoxDecoration(
                      color: isMe
                          ? const Color(0xff5755D9)
                          : const Color(0xff484554).withOpacity(0.08),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(isMe ? 16.0 : 0.0),
                        topRight: Radius.circular(isMe ? 0.0 : 16.0),
                        bottomLeft: const Radius.circular(16.0),
                        bottomRight: const Radius.circular(16.0),
                      ),
                    ),
                    child: isAudio
                        ? Column(
                      mainAxisAlignment: isMe
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      crossAxisAlignment: isMe
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                color: Color(0xff9B98A4),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.play_arrow,
                                color: Color(0xffF4F4F6),
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Expanded(
                              child: Image.asset(
                                'assets/images/audio_wave.png',
                                width: 140,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          message,
                          textAlign:
                          isMe ? TextAlign.right : TextAlign.left,
                          style: TextStyle(
                            color: isMe
                                ? const Color(0xffF4F4F6)
                                : const Color(0xff9B98A4),
                            fontWeight: FontWeight.w400,
                            fontSize: 12.0,
                            fontFamily:
                            GoogleFonts.montserrat().fontFamily,
                          ),
                        ),
                      ],
                    )
                        : Text(
                      message,
                      style: TextStyle(
                        color: isMe
                            ? const Color(0xffF4F4F6)
                            : const Color(0xff484554),
                        fontWeight: FontWeight.w400,
                        fontFamily: GoogleFonts.inter().fontFamily,
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const Divider(
          height: 1,
          color: Color(0xff9B98A4),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 4.0,
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/icons/camera.svg',
                width: 24,
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 4.0,
                  vertical: 16,
                ),
                width: MediaQuery.of(context).size.width * 0.7,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                height: 38,
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Type Message...',
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0.0,
                      horizontal: 8.0,
                    ),
                    hintStyle: const TextStyle(
                      color: Color(0xff9B98A4),
                      fontWeight: FontWeight.w400,
                      fontSize: 13.0,
                      fontFamily: 'Inter',
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide: BorderSide(
                        color: const Color(0xff9B98A4).withOpacity(0.3),
                        width: 0.3,
                      ),
                    ),
                  ),
                ),
              ),
              _controller.text.isEmpty
                  ? Container(
                width: 38,
                height: 38,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff5755D9),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.mic,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _addMessage('02:45', true);
                  },
                ),
              )
                  : IconButton(
                icon: const Icon(
                  Icons.send,
                  color: Color(0xff5755D9),
                ),
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    _addMessage(
                      _controller.text,
                      true,
                    ); // Sent by the current user
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SliverListT extends StatelessWidget {
  final List<List<CallLogEntry>> groups;
  final List<Color> codes = [const Color(0xff00821e), const Color(0xff7c0082),const Color(0xff210082),const Color(0xff668200),const Color(0xff820000)];
  SliverListT({super.key, required this.groups});

  String? getTime(DateTime time) {
    int h = time.hour;
    int m = time.minute;
    if(h >= 12) {
      if(h != 12) {
        h-= 12;
      }

      return "${h.toString().length == 1 ? '0': ''}$h:${m.toString().length == 1 ? '0': ''}$m PM";
    }
    else {
      if(h == 0) {
        h+=12;
      }
      return "${h.toString().length == 1 ? '0': ''}$h:${m.toString().length == 1 ? '0': ''}$m AM";
    }
  }


  @override
  Widget build(BuildContext context) {
    // void showSnackbar(String message) {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     content: Text(message),
    //   ));
    // }
    return SliverList(
      delegate: SliverChildBuilderDelegate(
          childCount: groups.length,

              (context, index) {

                // Check if number is null


            if (index >= groups.length)
              return const SizedBox(height: 0,);
            print("Length is: ${groups[index].length}");
            if (groups[index].isEmpty)
              return const SizedBox(height: 0,);

            if (groups[index].isNotEmpty) {
              // _date = DateTime.fromMillisecondsSinceEpoch(
              //     groups[index][0].timestamp!);
              // _listdate = "${_date.day}-${_date.month}-${_date.year}";
            }
            var firstEntry = groups[index][0];
            return Padding(

              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal:21.0),
              child: InkWell(
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) =>DialerPage()));
                },
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                              radius: 26.44,
                              // backgroundImage: AssetImage('assets/images/face1.jpeg'),
                              backgroundColor: codes[Random().nextInt(5)].withOpacity(0.4),
                              child: Text(
                                firstEntry.name == null || firstEntry.name == "" ? "" : ((firstEntry.name).toString())[0].toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              )
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.75),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.5,
                                  child: Text(
                                    (firstEntry.name == null ? (firstEntry.number ?? "") : firstEntry.name).toString(),
                                    style: const TextStyle(
                                        fontSize: 16.59,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff676578)
                                    ),
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                (firstEntry.name != null) ?
                                Row(
                                  children: [
                                    Text(firstEntry.number.toString(),
                                      style: const TextStyle(
                                          fontSize: 12.44,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff9B98A4)
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    (groups[index].length > 1) ?
                                    Text(
                                      "(${groups[index].length})",
                                      style: const TextStyle(
                                          fontSize: 12.44,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff9B98A4)
                                      ),
                                    ) :const SizedBox(height: 0),
                                  ],
                                ):const SizedBox(height: 0),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 85,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [

                            SizedBox(
                              height: 14,
                              width: 14,
                              child: SvgPicture.asset(
                                firstEntry.callType == CallType.outgoing
                                    ? 'assets/icons/outgoing.svg'
                                    :
                                (firstEntry.callType == CallType.incoming ?
                                'assets/icons/incoming.svg' :
                                'assets/icons/missed.svg'),
                                color:
                                firstEntry.callType == CallType.missed
                                    ? const Color(0xffE85461)
                                    : const Color(0xff93CB80),
                                fit: BoxFit.scaleDown,
                              ),
                            ),

                            Text(
                              getTime(DateTime.fromMillisecondsSinceEpoch(firstEntry.timestamp!))!,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff9B98A4)
                              ),
                            ),

                          ],
                        ),
                      ),
                    ]
                ),
              ),
            );
          }

      ),


    );
  }
}


class HomeEpigle extends StatefulWidget {
  const HomeEpigle({super.key});

  @override
  State<HomeEpigle> createState() => _HomeEpigleState();
}
class _HomeEpigleState extends State<HomeEpigle> with SingleTickerProviderStateMixin {
  int selectedIndex = 6;
  int _currentIndex = 0;
  late AnimationController _controller;
  late Animation _animation;
  List<CallLogEntry> callLogEntries= [];
  List<List<CallLogEntry>> groups= [];

  @override
  void initState() {
    // TODO: implement initState
    _currentIndex = 0;


    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),

    );
    _animation = Tween<Offset>(
      begin: const Offset(0.0, -1.0), // Start position (top)
      end: const Offset(0.0, 0.0),    // End position (center)
    ).animate(_controller);
    getCalls();
    print("Call log entries length = ${callLogEntries.length}");


    _controller.forward(from: 0.7);
    // init();
    super.initState();
  }
  void getCalls() async {
    callLogEntries = (await CallLog.get()).toList();
    print('${callLogEntries[0].name}');
    groupCalls();
    // setState(() {});
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ),);
  }

  void groupCalls(){
    Map<String, List<CallLogEntry>> keyMap = {};
    int k = 0;
    for (var entry in callLogEntries) {
      // Check if name is null

      var date = DateTime.fromMillisecondsSinceEpoch(entry.timestamp!);
      while((k++)<30) {
        print("Name + date ${entry.name} ${date}");
      }
      String key = '${entry.number}_${date.year}-${date.month}-${date.day}';
      if(keyMap.containsKey(key)) {
        keyMap[key]?.add(entry);
      }
      else {
        keyMap[key] = [];
      }
    }
    groups = keyMap.values.toList();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }


  Widget _buildIconButton({required Widget icon, required int index}) {
    // print("Index = $index SleectedIndex = $selectedIndex");
    int x = (selectedIndex - index);

    print("X = $x");
    final double angle = 2 * pi * (x-2) / 8;
    // print("X=$x Angle=$angle");
    final double radius = MediaQuery.of(context).size.width * 0.88 / 2.59;
    print("Offset = ${radius * cos(angle)} ${radius * sin(angle)}");
    final double offsetX = 0 + radius * cos(angle);
    final double offsetY = 0 + radius * sin(angle);
    final double angle2 = 2 * pi * (index) / 8;
    print("Offset = ${radius * cos(angle2)} ${radius * sin(angle2)}");
    final double offsetX2 = 0 + radius * cos(angle2);
    final double offsetY2 = 0 + radius * sin(angle2);


    return

      AnimatedContainer(
        duration: const Duration(seconds: 2),
        alignment: Alignment.center,
        child: Transform.translate(

          offset: Offset(
            radius*cos(angle*_controller.value),radius*sin(angle*_controller.value)
          ),
          child: IconButton(
            iconSize: 14,
            // style: ElevatedButton.styleFrom(
            //   padding: EdgeInsets.all(20)
            //
            // ),




            onPressed: () {
              selectedIndex = index;
              _controller.forward(from: 0);
              // setState(() {
              //   _controller.forward(from: 0);
                // _controller.animateTo(1, curve: Curves.easeIn);
                // _controller.animateTo(1, curve: Curves.easeIn);
                // if (index % 3 == 0) {
                //   _currentIndex = 0;
                //   // _pageController.jumpToPage(0);
                // }
                // else if (index % 3 == 1) {
                //   _currentIndex = 1;
                //   // _pageController.jumpToPage(1);
                // }
                // else {
                //   _currentIndex = 2;
                //   // _pageController.jumpToPage(2);
                // }
              //   print("Selected Index = $selectedIndex");
              //   print("----------------SET STATED---------\n\n");
              // });
            },
            icon: icon,
            ),
        ),
      );
  }



  List<String> iconType = ["chat", "home", "call"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      body:
          Column(
            children: [
              AppBar(
                // pinned: true,
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.white,
                toolbarHeight: 64,
                leading:
                (0 == 0)  ?
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: SvgPicture.asset(
                    'assets/icons/menu.svg',
                    // height: 40,
                    // width: 40,
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>const ProfilePage()));
                  },
                ) : (
                    _currentIndex == 1 ?
                    IconButton(
                      padding: EdgeInsets.zero,
                      icon: SvgPicture.asset(
                        'assets/icons/back_icon.svg',
                        height: 20,
                        width: 20,
                      ),
                      onPressed: () {
                      },
                    ) :
                    IconButton(
                      // padding: EdgeInsets.zero,
                      icon: SvgPicture.asset(
                        'assets/icons/menu.svg',
                        // height: 40,
                        // width: 40,
                      ),
                      onPressed: () {},
                    )
                ),
                bottom: 0 == 0 ?
                PreferredSize(
                  preferredSize: const Size.fromHeight(50),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(bottom: 9),
                            labelText: 'Recent Calls',
                            labelStyle: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                            hintText: '',
                            fillColor: Colors.white,
                            filled: true,
                            suffixIcon: IconButton(
                              icon: SvgPicture.asset(
                                'assets/icons/search.svg',
                                height: 16.8,
                                width: 16.17,
                              ),
                              onPressed: () {},
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6,),
                        const Divider(
                          height: 0.31,
                          color: Color(0xff9B98A4),
                        ),
                        const SizedBox(height: 8,),
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: const Color(0xffE7E6EE),
                            ),
                            child: const Text(
                              "Today",
                              // today == _listdate ? "Today" : (_listdate == yest ? "Yesterday" : _listdate),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            )),
                      ],
                    ),
                  ),
                ) :
                (
                    _currentIndex == 1 ?
                    PreferredSize(
                      preferredSize: const Size.fromHeight(50),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Column(
                          children: [
                            Container(

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 36.39/2,
                                        backgroundImage: AssetImage('assets/images/face2.jpg'),

                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 12.75),
                                        child: Text('Karthick',
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff484554),
                                            letterSpacing: 0.13,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    icon: SvgPicture.asset(
                                      'assets/icons/search.svg',
                                      height: 16.8,
                                      width: 16.17,
                                    ),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 6,),
                            const Divider(
                              height: 0.31,
                              color: Color(0xff9B98A4),
                            )
                          ],
                        ),
                      ),
                    ) :
                    PreferredSize(
                      preferredSize: const Size.fromHeight(50),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Column(
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(bottom: 9),
                                hintText: 'Contacts List',
                                hintStyle: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                suffixIcon: IconButton(
                                  icon: SvgPicture.asset(
                                    'assets/icons/search.svg',
                                    height: 16.8,
                                    width: 16.17,
                                  ),
                                  onPressed: () {},
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                            const SizedBox(height: 6,),
                            const Divider(
                              height: 0.31,
                              color: Color(0xff9B98A4),
                            )
                          ],
                        ),
                      ),
                    )
                ),

              ),
              FutureBuilder (
                future: CallLog.get(),
                builder:
                    ( context,snapshot) {
                  print("SNAPSHOT DATA");
                  print(snapshot.data);
                  groupCalls();
                  print(groups);
                      if(snapshot.connectionState == ConnectionState.done) {
                        List<String> icon_type = ["chat", "home", "call"];
                        callLogEntries = snapshot.data!.toList();
                        if (callLogEntries.isEmpty) {
                          return const Center(child: CircularProgressIndicator(),);
                        } else {
                          return Column(
                              children: [

                              [
                                RecentsBody(groups:  groups,),
                                // ChatsBody(),
                                const ChatsBody(),
                                ContactsBody(),
                              ][0],


                            ]);
                        }
                      }else {
                        return const Center(child: CircularProgressIndicator(),);
                      }
                    },
              ),
              Stack(
                children: [
                  Positioned(
                    left: MediaQuery.of(context).size.width * 0.07,
                    right: MediaQuery.of(context).size.width * 0.07,
                    bottom: -((MediaQuery.of(context).size.width * 0.86)* 0.71),
                    // bottom: 0,
                    child: Container(

                      width: MediaQuery.of(context).size.width * 0.88,
                      height: MediaQuery.of(context).size.width * 0.88,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffE7E6EE),

                      ),
                      child:


                      Stack(

                          children: [

                            for(int index = 0; index < 8; index++)
                              _buildIconButton(
                                  icon: SvgPicture.asset(
                                      'assets/icons/${iconType[index %
                                          3]}_nav.svg'),
                                  index: index)

                          ]


                      ),

                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: MediaQuery.of(context).size.width/3,
                    right: MediaQuery.of(context).size.width/3,
                    child: SvgPicture.asset('assets/images/nav_bar_pointer.svg'),
                  )
                ],
              ),
            ],
          ),


    );

  }
}

class DialerPage extends StatelessWidget {
  const DialerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(30.79),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Dialing',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff9B98A4)
                ),
              ),
              const SizedBox(height: 29.5,),

              Container(
                height: 222,
                width: 222,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 111.60,
                      backgroundColor: const Color(0xff5755D9).withOpacity(0.1),
                    ),
                    Positioned(
                      top: 19.61,
                      left: 19.61,
                      child: CircleAvatar(
                        radius: 91.99,
                        backgroundColor: const Color(0xff5755D9).withOpacity(0.3),
                      ),
                    ),
                    Positioned(
                      top: 35.97,
                      left: 35.85,
                      child: CircleAvatar(
                        radius: 75.76,

                        backgroundColor: const Color(0xff5755D9).withOpacity(0.7),
                      ),
                    ),




                    const Positioned(
                      top: 54.33,
                      left: 54.33,
                      child: CircleAvatar(
                      radius: 57.2,
                      backgroundImage: AssetImage('assets/images/face1.jpeg'),
                      ),
                    ),
                  ]
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Anitha Office',
                    style: TextStyle(
                      fontSize: 24.88,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff484554)
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on_outlined,
                        color: Color(0xff9B98A4),
                        size: 16,
                      ),
                      Text('Bangalore, India',
                        style: TextStyle(
                          color: Color(0xff9B98A4),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.02,
                        ),
                      ),
                    ],
                  ),
                  Text('+91 9428573945',
                    style: TextStyle(
                      color: Color(0xff484554),
                      fontSize: 24.88,
                      fontWeight: FontWeight.w400
                    ),

                  )
                ],
              ),
              const SizedBox(height: 36.33,),
              const Divider(
                height: 0.93,
                color: Color(0xff9B98A4),
              ),
              const SizedBox(height: 39.89,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      SvgPicture.asset('assets/icons/mute_icon.svg'),
                      const SizedBox(height: 6.45,),
                      const Text('Mute',
                        style: TextStyle(
                          color: Color(0xff9B98A4),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.03,
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      SvgPicture.asset('assets/icons/bluetooth_icon.svg'),
                      const SizedBox(height: 6.45,),
                      const Text('Bluetooth',
                        style: TextStyle(
                          color: Color(0xff9B98A4),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.03,
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      SvgPicture.asset('assets/icons/hold_icon.svg'),
                      const SizedBox(height: 6.45,),
                      const Text('Hold',
                        style: TextStyle(
                          color: Color(0xff9B98A4),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.03,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 43,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset('assets/icons/keypad.svg'),
                  ),
                  IconButton(
                    onPressed: () {},
                    // color: Color(0xff5755D9).withOpacity(0.15),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(const Color(0xff5755D9).withOpacity(0.15)),
                      fixedSize: MaterialStateProperty.all(const Size(71.84, 71.84)),

                    ),


                    icon: SvgPicture.asset('assets/icons/call_end.svg'),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset('assets/icons/volume.svg'),
                  ),
                ],
              ),

            ],
          ),
        )
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset('assets/icons/cross.svg'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),



      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 18.77,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Menu',
              style: TextStyle(

                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: Color(0xff2D2D41),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 26.71),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/home_profile.svg'),
                      const SizedBox(width: 28,),
                      const Text('Home',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff484554),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28,),
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/notif_profile.svg'),
                      const SizedBox(width: 28,),
                      const Text('Notifications',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff484554),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28,),
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/block_profile.svg'),
                      const SizedBox(width: 28,),
                      const Text('Block User',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff484554),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28,),
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/faq_profile_icon.svg'),
                      const SizedBox(width: 28,),
                      const Text('FAQ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff484554),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28,),
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/feedback_profile.svg'),
                      const SizedBox(width: 28,),
                      const Text('Send Feedback',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff484554),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28,),
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/invite_profile.svg'),
                      const SizedBox(width: 28,),
                      const Text('Invite Friends',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff484554),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28,),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 200,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Positioned(
              top: 107,
              left: MediaQuery.of(context).size.width * 0.07,
              child: Container(
                width: 336,
                height: 336,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffE7E6EE),

                ),
                child: null,
              ),
            ),
            Positioned(
              bottom: 0,
              left: MediaQuery.of(context).size.width/3,
              right: MediaQuery.of(context).size.width/3,
              child: SvgPicture.asset('assets/images/nav_bar_pointer.svg'),
            ),
            Positioned(
              bottom: 38.65,
              left: MediaQuery.of(context).size.width * 0.34,
                right: MediaQuery.of(context).size.width * 0.34,
                child: const CircleAvatar(
                  radius: 55,
                  backgroundImage: AssetImage('assets/images/profile_face.jpg'),
                )
            ),
          ],
        ),
      ),

    );
  }
}




class CircularDialpad extends StatefulWidget {
  @override
  _CircularDialpadState createState() => _CircularDialpadState();
}

class _CircularDialpadState extends State<CircularDialpad> {
  late PageController _pageController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _selectedIndex,
      viewportFraction: 0.4,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Circular Dialpad'),
      ),
      body: Center(
        child: SizedBox(
          height: 700,
          child: PageView.builder(
            controller: _pageController,
            itemCount: 10,
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return DialpadItem(index: index, selectedIndex: _selectedIndex);
            },
          ),
        ),
      ),
    );
  }
}

class DialpadItem extends StatelessWidget {
  final int index;
  final int selectedIndex;
  final double radius = 100; // Radius of the circle

  const DialpadItem({required this.index, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    double angle = 2 * pi / 10 * index; // Angle between each number

    // Calculate the position of the number around the circumference of the circle
    double x = radius * cos(angle);
    double y = radius * sin(angle);

    return GestureDetector(
      onTap: () {
        print('Selected: $index');
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 40), // Adjust the margin as needed
        transform: Matrix4.translationValues(x, y, 0),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == selectedIndex ? Colors.blue : Colors.grey,
          ),
          child: Center(
            child: Text(
              index.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

