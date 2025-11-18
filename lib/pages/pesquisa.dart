import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/api/search.dart';
import 'package:myapp/domain/info.dart';

class Pesquisa extends StatefulWidget {
  const Pesquisa({super.key});

  @override
  State<Pesquisa> createState() => _PesquisaState();
}

class _PesquisaState extends State<Pesquisa> {
  TextEditingController cnpjController = TextEditingController();

  Future<Info>? futureInfo;

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
                        'Insira o CNPJ para consultar distribuidor',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          color: const Color(0xFF15b5b0),
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 32),
                      TextFormField(
                        controller: cnpjController,
                        decoration: buildInputDecoration(
                          'CPNJ',
                          suffixIcon: IconButton(
                            onPressed: onPressedIconButton,
                            icon: const Icon(Icons.search),
                          ),
                        ),
                        cursorColor: const Color(0xFF15b5b0),
                      ),
                      const SizedBox(height: 16),

                      
                      FutureBuilder<Info>(
                        future: futureInfo,
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
                        
                            String errorMessage =
                                'Ocorreu um erro: ${snapshot.error}';
                                              
                            return TextFormField(
                              key: const ValueKey('error'),
                              initialValue: errorMessage,
                              readOnly: true,
                              maxLines: 5,
                              decoration: buildInputDecoration('Erro!'),
                              cursorColor: const Color(0xFF15b5b0),
                            );
                          }

                          
                          if (snapshot.hasData) {
                    
                            Info info = snapshot.data!;

                            return TextFormField(
                              key: ValueKey(info.info),
                              initialValue: info.info,
                              readOnly: true,
                              maxLines: 5,
                              decoration: buildInputDecoration( 'Informações do distribuidor de remédios'),
                              cursorColor: const Color(0xFF15b5b0),
                            );
                          }

                          
                          return TextFormField(
                            key: const ValueKey('initial'),
                            readOnly: true,
                            maxLines: 5,
                            decoration: buildInputDecoration(
                                'Informações do distribuidor de remédios'),
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
      ),
    );
  }

  onPressedIconButton() {
    String cnpj = cnpjController.text;

    if (cnpj.trim().isEmpty) {
      showSnackBar('Por favor, insira o CNPJ.');
      return;
    }

    setState(() {
      futureInfo = InfoApi().findByCnpj(cnpj);
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
}