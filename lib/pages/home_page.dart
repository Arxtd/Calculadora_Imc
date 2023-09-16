import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  double imcResult = 0.0;

  void calculateImc({required double height, required double weight}) {
    final double imc = weight / (height * height);
    setState(() {
      imcResult = imc;
    });
  }

  String imcCategory({required double imcResult}) {
    if (imcResult < 1) {
      return '';
    } else if (imcResult >= 1 && imcResult <= 18.5) {
      return 'Baixo peso';
    } else if (imcResult >= 18.6 && imcResult <= 24.0) {
      return 'Peso normal';
    } else if (imcResult >= 25.0 && imcResult <= 29.9) {
      return 'Sobrepeso';
    } else if (imcResult >= 30 && imcResult <= 34.9) {
      return 'Obesidade Grau I';
    } else if (imcResult >= 35 && imcResult <= 39.0) {
      return 'Obesidade Grau II';
    } else {
      return 'Obesidade Grau III';
    }
  }

  void clearResult() {
    imcResult = 0.0;
    heightController.clear();
    weightController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Calculadora de IMC',
        ),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Peso'),
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextField(
                controller: heightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Altura'),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                        onPressed: () {
                          if (heightController.text.isNotEmpty &&
                              weightController.text.isNotEmpty) {
                            calculateImc(
                                height: double.parse(heightController.text),
                                weight: double.parse(weightController.text));
                          }

                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        child: const Text('Calcular')),
                  )
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              imcResult > 1.0
                  ? Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.3)),
                      child: Column(
                        children: [
                          const Text('Resultado'),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            imcResult.toStringAsFixed(2),
                            style: const TextStyle(fontSize: 35.0),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            imcCategory(imcResult: imcResult),
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(
                      height: 20.0,
                    ),
              imcResult > 1
                  ? Row(
                      children: [
                        Expanded(
                            child: ElevatedButton(
                          child: const Text('Limpar'),
                          onPressed: () {
                            clearResult();
                          },
                        ))
                      ],
                    )
                  : const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}
