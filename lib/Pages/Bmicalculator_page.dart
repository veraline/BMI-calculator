import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BmiCalculator extends StatefulWidget {
  const BmiCalculator({Key? key}) : super(key: key);

  @override
  State<BmiCalculator> createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  @override
  void dispose() {
    // Dispose the controllers when the widget is disposed
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void calculateBMI(BuildContext context) {
    double height = double.parse(_heightController.text) / 100;
    double weight = double.parse(_weightController.text);

    double bmi = weight / (height * height);

    // bottom sheet
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          decoration: const BoxDecoration(
            color: Color(0xFF8DB8DB),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Container(
                  width: 100,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Your BMI is: ${bmi.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 24, color: Colors.white),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Interpretation:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'BMI < 18.5: Underweight\nBMI 18.5 - 24.9: Normal weight\nBMI 25.0 - 29.9: Overweight\nBMI > 30.0: Obesity',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('BMI Calculator')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: AvatarContainer(
                    gender: 'Male',
                    image: 'Assets/boy.png',
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: AvatarContainer(
                    gender: 'Female',
                    image: 'Assets/girl 2.png',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: 'Enter weight',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                            const BorderSide(color: Color(0xFF8DB8DB)))),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Kg',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _heightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: 'Enter height',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                            const BorderSide(color: Color(0xFF8DB8DB)))),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Cm',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                calculateBMI(context);
                print('Pressed');
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFF8DB8DB),
                ),
                child: const Center(
                  child: Text(
                    'Calculate BMI',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AvatarContainer extends StatefulWidget {
  final String gender;
  final String image;

  const AvatarContainer({
    required this.gender,
    required this.image,
    Key? key,
  }) : super(key: key);

  @override
  State<AvatarContainer> createState() => _AvatarContainerState();
}

class _AvatarContainerState extends State<AvatarContainer> {
  bool _isActive = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isActive = !_isActive;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: _isActive ? Colors.blue : Colors.black,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Image.asset(
                widget.image,
                width: 70,
                height: 70,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.gender,
              style: const TextStyle(fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
