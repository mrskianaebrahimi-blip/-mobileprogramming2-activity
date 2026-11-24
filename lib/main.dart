
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dart Exercises',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ExercisePage(),
    );
  }
}

class ExercisePage extends StatelessWidget {
  const ExercisePage({super.key});

  @override
  Widget build(BuildContext context) {

    // Exercise 1: Product Information

    String productName = 'Laptop';
    double productPrice = 45000000;
    int productCount = 2;
    bool isAvailable = true;

    // final: Value assigned only once
    final registrationDate = DateTime.now();

    // const: Compile-time constant
    const double taxRate = 0.09;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dart Programming Exercises'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),

        children: [

          const Text(
            'Exercise 1: Product Information',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text('Product Name: $productName'),
                  Text('Product Price: $productPrice Toman'),
                  Text('Product Count: $productCount'),
                  Text('Available: $isAvailable'),

                  const Divider(),

                  Text('Registration Date: $registrationDate'),
                  const Text('Tax Rate: 9%'),

                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            'Difference between final and const',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    'final:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),

                  Text(
                    'A final variable can only be assigned once. '
                    'Its value can be determined at runtime.',
                  ),

                  SizedBox(height: 12),

                  Text(
                    'const:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),

                  Text(
                    'A const variable is a compile-time constant '
                    'and its value cannot change.',
                  ),

                  SizedBox(height: 12),

                  Text('Example:'),

                  Text('final currentTime = DateTime.now();'),
                  Text('const taxRate = 0.09;'),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
