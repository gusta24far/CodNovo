import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myapp/api/instrucao.dart';
import 'package:myapp/domain/instrucoes.dart';

import '../api/google_maps_page.dart';

class Uso extends StatefulWidget {
  const Uso({super.key});

  @override
  State<Uso> createState() => _UsoState();
}

class _UsoState extends State<Uso> {
  TextEditingController remedioController = TextEditingController();

  Future<List<Instrucao>>? futureInstrucao;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF15b5b0),
        body: Column(
          children: [
            const SizedBox(height: 100),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50.0),
                    topLeft: Radius.circular(50.0),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 16),
                      Text(
                        'Insira o nome do remédio para ver as instruções',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          color: const Color(0xFF15b5b0),
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 32),
                      TextFormField(
                        controller: remedioController,
                        decoration: buildInputDecoration(
                          'Remédio',
                          suffixIcon: IconButton(

                            onPressed: onPressedIconButton,
                            icon: const Icon(Icons.search),
                          ),
                        ),
                        cursorColor: const Color(0xFF15b5b0),
                      ),
                      const SizedBox(height: 16),
                      FutureBuilder<List<Instrucao>>(
                        future: futureInstrucao,
                        builder: (context, snapshot) {

                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.all(32.0),
                                child: CircularProgressIndicator(
                                  color: Color(0xFF15b5b0),
                                ),
                              ),
                            );
                          }


                          if (snapshot.hasError) {
                            return TextFormField(
                              key: const ValueKey('error'),
                              initialValue: 'Ocorreu um erro: ${snapshot.error}',
                              readOnly: true,
                              maxLines: 5,
                              decoration: buildInputDecoration('Erro!'),
                              cursorColor: const Color(0xFF15b5b0),
                            );
                          }

                          if (snapshot.hasData) {


                            if (snapshot.data!.isEmpty) {
                              return TextFormField(
                                key: const ValueKey('not_found'),
                                initialValue: 'Remédio não encontrado.',
                                readOnly: true,
                                maxLines: 5,
                                decoration: buildInputDecoration('Instruções de uso'),
                                cursorColor: const Color(0xFF15b5b0),
                              );
                            }

                            Instrucao instrucao = snapshot.data!.first;

                            return TextFormField(

                              key: ValueKey(instrucao.regra),
                              initialValue: instrucao.regra,
                              readOnly: true,
                              maxLines: 5,
                              decoration: buildInputDecoration('Instruções de uso'),
                              cursorColor: const Color(0xFF15b5b0),
                            );
                          }


                          return TextFormField(
                            key: const ValueKey('initial'),
                            readOnly: true,
                            maxLines: 5,
                            decoration: buildInputDecoration('Instruções de uso'),
                            cursorColor: const Color(0xFF15b5b0),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: buildFloatingActionButton(),
      ),
    );

  }

  onPressedIconButton() {
    String nome = remedioController.text;
    if (nome.trim().isEmpty) {
      showSnackBar('Por favor, insira o nome de um remédio.');
      return;
    }

    setState(() {
      futureInstrucao = InstrucaoApi().findByNome(nome);
    });
  }

  showSnackBar(String snackBarMessage) {
    SnackBar snackBar = SnackBar(content: Text(snackBarMessage));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  buildInputDecoration(String name, {Widget? suffixIcon}) {
    return InputDecoration(
      suffixIcon: suffixIcon,
      label: Text(name),
      floatingLabelStyle: GoogleFonts.montserrat(
        color: const Color(0xFF15b5b0),
        fontWeight: FontWeight.w600,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          width: 2,
          color: Color(0xFF15b5b0),
        ),
      ),
    );
  }
  
  buildFloatingActionButton () {
    return FloatingActionButton(onPressed: () async {
      List<Location> locations = await locationFromAddress("Arapiraca");
      LatLng position = LatLng(locations[0].latitude, locations[0].longitude);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return GoogleMapsPage(position: position);
          },
        ),
      );
    }, child: Icon(Icons.map));
  }
  
}