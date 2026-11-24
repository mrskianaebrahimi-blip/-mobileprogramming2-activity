
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Exercise 4: Closure Counter
int Function() createCounter() {
  int count = 0;

  return () {
    count++;
    return count;
  };
}

// Exercise 5: Filter Prices
List<double> filterPrices(List<double> prices, double limit) {
  return prices.where((price) => price > limit).toList();
}

double calculateTotal(List<double> prices) {
  return prices.fold(0.0, (sum, price) => sum + price);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dart Exercises',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const ExercisePage(),
    );
  }
}

class ExercisePage extends StatefulWidget {
  const ExercisePage({super.key});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  // Exercise 1: Product Information
  final String productName = 'Laptop';
  final double productPrice = 45000000;
  final int productCount = 2;
  final bool isAvailable = true;

  final DateTime registrationDate = DateTime.now();
  static const double taxRate = 0.09;

  bool showProduct = false;

  // Exercise 2: Discount Calculator
  final TextEditingController priceController =
      TextEditingController(text: '2000000');

  final TextEditingController discountController =
      TextEditingController(text: '25');

  String discountResult = '';

  void calculateDiscount() {
    final price = double.tryParse(priceController.text);
    final discount = double.tryParse(discountController.text);

    if (price == null ||
        discount == null ||
        !price.isFinite ||
        !discount.isFinite ||
        price < 0 ||
        discount < 0 ||
        discount > 100) {
      setState(() {
        discountResult = 'Please enter valid values.';
      });
      return;
    }

    final discountAmount = price * discount / 100;
    final finalPrice = price - discountAmount;

    setState(() {
      discountResult =
          'Discount Amount: $discountAmount Toman\n'
          'Final Price: $finalPrice Toman';
    });
  }

  // Exercise 3: Shopping List
  final List<String> shoppingList = ['Milk', 'Bread', 'Eggs'];

  final TextEditingController itemController =
      TextEditingController();

  String shoppingMessage = '';

  void addItem() {
    final item = itemController.text.trim();

    if (item.isEmpty) {
      setState(() {
        shoppingMessage = 'Enter an item first.';
      });
      return;
    }

    setState(() {
      shoppingList.add(item);
      shoppingMessage = '$item added successfully.';
      itemController.clear();
    });
  }

  void removeItem(String item) {
    setState(() {
      shoppingList.remove(item);
      shoppingMessage = '$item removed successfully.';
    });
  }

  // Exercise 4: Counter Using Closure
  late final int Function() counter = createCounter();

  int counterValue = 0;

  void increaseCounter() {
    setState(() {
      counterValue = counter();
    });
  }

  // Exercise 5: Price Filter
  final List<double> prices = [
    10000,
    25000,
    50000,
    75000,
    120000,
  ];

  final TextEditingController limitController =
      TextEditingController(text: '30000');

  List<double> filteredPrices = [];
  double totalPrice = 0;
  String priceMessage = '';

  void filterAndCalculate() {
    final limit = double.tryParse(limitController.text);

    if (limit == null || !limit.isFinite || limit < 0) {
      setState(() {
        priceMessage = 'Enter a valid price limit.';
        filteredPrices = [];
        totalPrice = 0;
      });
      return;
    }

    final result = filterPrices(prices, limit);
    final total = calculateTotal(result);

    setState(() {
      filteredPrices = result;
      totalPrice = total;
      priceMessage = 'Filtering completed successfully.';
    });
  }

  // Reusable Section Title
  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }

  // Reusable Input Field
  Widget inputField(
    String label,
    TextEditingController controller, {
    bool numeric = true,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: controller,
        keyboardType: numeric
            ? const TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  // Reusable Result Card
  Widget resultCard(Widget child) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }

  @override
  void dispose() {
    priceController.dispose();
    discountController.dispose();
    itemController.dispose();
    limitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dart Programming Exercises'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Exercise 1
          sectionTitle('Exercise 1: Product Information'),

          resultCard(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Product information is stored in variables.',
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showProduct = !showProduct;
                    });
                  },
                  child: Text(
                    showProduct
                        ? 'Hide Information'
                        : 'Show Information',
                  ),
                ),
                if (showProduct) ...[
                  const Divider(),
                  Text('Product Name: $productName'),
                  Text('Price: $productPrice Toman'),
                  Text('Quantity: $productCount'),
                  Text('Available: $isAvailable'),
                  Text('Registration: $registrationDate'),
                  Text('Tax Rate: ${taxRate * 100}%'),
                  const Divider(),
                  const Text(
                    'final: Assigned once; can be initialized at runtime.',
                  ),
                  const Text(
                    'const: A compile-time constant.',
                  ),
                  const Text(
                    'final currentTime = DateTime.now();',
                  ),
                  const Text('const taxRate = 0.09;'),
                ],
              ],
            ),
          ),

          // Exercise 2
          sectionTitle('Exercise 2: Discount Calculator'),

          resultCard(
            Column(
              children: [
                inputField('Product Price', priceController),
                inputField('Discount Percentage', discountController),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: calculateDiscount,
                    child: const Text('Calculate Discount'),
                  ),
                ),
                if (discountResult.isNotEmpty) ...[
                  const Divider(),
                  Text(
                    discountResult,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Exercise 3
          sectionTitle('Exercise 3: Shopping List'),

          resultCard(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                inputField(
                  'New Shopping Item',
                  itemController,
                  numeric: false,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: addItem,
                    child: const Text('Add Item'),
                  ),
                ),
                const Divider(),
                const Text(
                  'Current Shopping List:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                if (shoppingList.isEmpty)
                  const Text('The shopping list is empty.'),
                ...shoppingList.map(
                  (item) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.shopping_basket),
                    title: Text(item),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () => removeItem(item),
                    ),
                  ),
                ),
                Text(
                  'Total Items: ${shoppingList.length}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (shoppingMessage.isNotEmpty)
                  Text(shoppingMessage),
              ],
            ),
          ),

          // Exercise 4
          sectionTitle('Exercise 4: Counter Using Closure'),

          resultCard(
            Column(
              children: [
                const Text('Counter Value:'),
                Text(
                  '$counterValue',
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: increaseCounter,
                  icon: const Icon(Icons.add),
                  label: const Text('Increase Counter'),
                ),
                const Text(
                  'The function remembers its previous value '
                  'between calls.',
                ),
              ],
            ),
          ),

          // Exercise 5
          sectionTitle('Exercise 5: Price Filter'),

          resultCard(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Available Prices:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(prices.join(', ')),
                inputField('Minimum Price Limit', limitController),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: filterAndCalculate,
                    child: const Text('Filter and Calculate Total'),
                  ),
                ),
                if (priceMessage.isNotEmpty) ...[
                  const Divider(),
                  Text(priceMessage),
                  const Text(
                    'Prices above the limit:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  if (filteredPrices.isEmpty)
                    const Text('No prices found.'),
                  ...filteredPrices.map(
                    (price) => Text('$price Toman'),
                  ),
                  const Divider(),
                  Text(
                    'Total: $totalPrice Toman',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(height: 24),

          const Center(
            child: Text(
              'All Five Exercises',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

      ),
    );
  }
}
