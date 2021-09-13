import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:queen_ott_app/GuitarLessons/guitar_video_fetchin_service.dart';
import 'package:queen_ott_app/musicPages/musicService/music_fetching_service.dart';
import 'package:queen_ott_app/screens/landing_page.dart';
import 'package:queen_ott_app/services/add_series_services.dart';
import 'package:queen_ott_app/services/auth_service.dart';
import 'package:queen_ott_app/services/series_fetching_service.dart';
import 'package:queen_ott_app/services/upload_service.dart';
import 'package:queen_ott_app/services/video_fetching_service.dart';
import 'package:queen_ott_app/themes/dark_theme.dart';

import 'musicPages/home_page.dart';

Future<void> main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        Provider<AuthBase>(create: (_) => Auth()),
        Provider<UploadService>(create: (_) => UploadService()),
        ChangeNotifierProvider<AddSeriesServices>(
            create: (_) => AddSeriesServices(FirebaseFirestore.instance)),
        ChangeNotifierProvider<SeriesFetchingService>(
            create: (_) => SeriesFetchingService(FirebaseFirestore.instance)),
        ChangeNotifierProvider<VideoFetchingService>(
            create: (_) => VideoFetchingService(FirebaseFirestore.instance)),
        ChangeNotifierProvider<MusicFetchingService>(
            create: (_) => MusicFetchingService(FirebaseFirestore.instance)),
        ChangeNotifierProvider<GuitarService>(
            create: (_) => GuitarService(FirebaseFirestore.instance)),
      ],
      child: MaterialApp(
        title: 'Queen App',
        theme: darkTheme,
        debugShowCheckedModeBanner: false,
        // home: HomePage(),
        home: LandingPage(),
      ),
    );
  }
}
