import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:systemic_altruism_/bloc/bloc_cubit.dart';
import 'package:workmanager/workmanager.dart';
import 'Epigle/epigle.dart';

void callbackDispatcher() {
  Workmanager().executeTask((dynamic task, dynamic inputData) async {
    print('Background Services are Working!');
    try {
      final Iterable<CallLogEntry> cLog = await CallLog.get();
      print('Queried call log entries');

      return true;
    } on PlatformException catch (e, s) {
      print(e);
      print(s);
      return true;
    }
  });
}

void main() {
  runApp(const MyApp());
  // Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Systemic Altruism',
      theme: ThemeData(

        useMaterial3: true,
      ),
      // home: const ProductsPage(),
      home: HomeEpigle(),
      // home: CircularDialpad(),
      // home: SemicircularNavBar(),
    );
  }
}



class GradientText extends StatelessWidget {
  const GradientText(
      this.text, {
        required this.gradient,
        this.style,
      });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late final BlocCubit _bloccubit;
  // late bool _canPop;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _canPop = false;
    _bloccubit = BlocCubit();
  }


  @override
  Widget build(BuildContext context) {

    return PopScope(
      canPop: false,
        onPopInvoked: (_) {
          _bloccubit.cancelTimer();
          showDialog(context: context, builder: (context) {
            return AlertDialog(
              title: Text('Are you sure you want to exit?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      Navigator.of(context).pop();
                      // _canPop = true;
                      SystemNavigator.pop();
                      // Navigator.of(context).pop();
                    });



                  },
                  child: Text('Yes'),
                ),
              ],
            );

          });

    },
    child: Scaffold(
      appBar: AppBar(
        title: Text('Systemic Altruism'),
      ),
      body: BlocBuilder<BlocCubit, PageState>(
        bloc: _bloccubit,
        builder: (context, state) {
          if(state is PageInitial) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GradientText(
                      'Find That Dude',
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xff9946cc),
                          Color(0xff2581cc),
                        ],
                      ),
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Figure out someone\'s entire internet presence, from just a photo',
                    ),
                    SizedBox(height: 8,),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.account_circle,
                            size: 40,
                            color: Color(0xff545c73),
                          ),
                          SizedBox(width: 8,),
                          GestureDetector(
                            onTap: () async{

                              try {
                                final XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                                // await ImageController().uploadImage(pickedFile!);
                                _bloccubit.showResults();
                              } catch (e) {
                                print(e);
                              }
                            },
                            child: Container(
                              width: 200,
                              height: 33,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    Color(0xff875df0),
                                    Color(0xff619df6),
                                  ],
                                ),

                              ),

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.file_upload_outlined, color: Colors.white),
                                  SizedBox(width: 7,),
                                  Text('Upload Image' , style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ),
                          ),
                        ]
                    ),
                    SizedBox(height: 20,),
                    // Image.network(
                    //   'http://localhost:8000/api/random/',
                    //   width: 200,
                    //   height: 200,
                    // ),
                  ],
                ),
              ),
            );
          }
          if(state is PageLoaded) {
            if(!state.startedTimer) {
              _bloccubit.startTimer(state.pages);
            }
          return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GradientText(
                        'Results',
                        gradient: LinearGradient(
                          colors: <Color>[
                            Color(0xff9946cc),
                            Color(0xff2581cc),
                          ],
                        ),
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // BlocListener<BlocCubit, PageState>(
                      //     listener: (context, state) {
                      //       if(state is PageLoaded) {
                      //         _bloccubit.startTimer();
                      //
                      //       }
                      //     },
                      // ),
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: GridView.builder(
                          // itemCount: state.pages.length,
                          itemCount: state.pages.length,
                            itemBuilder: (context, index) {
                              return Container(
                                child: ShimmerLoading(
                                  isLoading: false,
                                  child: CardListItem(
                                    isLoading: false,
                                  ),
                                ),
                              );
                            },
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Number of columns
                            crossAxisSpacing: 10.0, // Spacing between columns
                            mainAxisSpacing: 10.0, // Spacing between rows
                            childAspectRatio: 1.0, // Aspect ratio of each child (width / height)
                          )
                        ),
                      )
                    ],
                  ),
              )

          );
          }
          return Center(
            child: Text("Nothing to show"),
          );
        },
      )

    ));
  }


}

class CardListItem extends StatelessWidget {
  const CardListItem({
    super.key,
    required this.isLoading,
  });

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: _buildImage(),
    );
  }

  Widget _buildImage() {
    return AspectRatio(
      aspectRatio: 16 / 20,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            'https://media.istockphoto.com/id/513247652/photo/panoramic-beautiful-view-of-mount-ama-dablam.jpg?s=1024x1024&w=is&k=20&c=ZKAEiIpjE9z6pmpZFVvnG_ymfsrZD7wFVPoB0LpLDYA=',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
























class ShimmerLoading extends StatefulWidget {
  const ShimmerLoading({
    super.key,
    required this.isLoading,
    required this.child,
  });

  final bool isLoading;
  final Widget child;

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading> {
  static const _shimmerGradient = LinearGradient(
    colors: [
      Color(0xFFEBEBF4),
      Color(0xFFF4F4F4),
      Color(0xFFEBEBF4),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );
  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) {
      return widget.child;
    }

    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        return _shimmerGradient.createShader(bounds);
      },
      child: widget.child,
    );
  }
}
