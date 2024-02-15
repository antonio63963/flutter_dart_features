
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;
// Есть куки манагер и есть куки хранилище  cookie_jar- разные либы но из одного пакета!!!
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';

const apiUsers = 'https://jsonplaceholder.typicode.com/use';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final dio = Dio();
  bool isCache = false;

  @override
  void initState() {
    super.initState();
    dio.interceptors.add(LogInterceptor());
    dio.options.baseUrl = 'https://jsonplaceholder.typicode.com';
    InterceptorsWrapper cacheInterceptor = InterceptorsWrapper(
      onRequest: (options, handler) {
        print('HO-Ho!! Interceptor!!!');
        return handler.next(options);
      }
    );
    dio.interceptors.add(cacheInterceptor);
    PersistCookieJar persistCookieJar = PersistCookieJar();
    dio.interceptors.add(CookieManager(persistCookieJar));
  }

  Future<String?> getUsers() async {
    try {
      final Response resp = await dio.get('/users');
      developer.log(resp.toString(), name: 'Rsps');
      print('JSON: ${resp.data}');
      return 'Ups';
    } on DioException catch (err) {
      print('Error+++++: ${err.response?.statusCode}');
      if (err.response?.statusCode == 404) {}
    } finally {
      print('hohoh');
    }
    print('hoho2222');
    return 'hohoh2';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('DIO'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              ElevatedButton(onPressed: getUsers, child: Text('Get Users')),
              Switch(value: isCache, onChanged: (value) => setState(() {
                isCache = value;
              }),),
            ],
          ),
        ),
      ),
    );
  }
}
