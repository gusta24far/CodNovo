import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/widgets/card_remedios.dart';
import 'package:myapp/db/remedios_dao.dart';

class Remedios extends StatefulWidget {
  const Remedios({super.key});
  @override
  State<Remedios> createState() => _RemediosState();
}
class _RemediosState extends State<Remedios> {
  List listaMedicamentos = [];
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    loadData();
  }
  

  loadData() async {
    listaMedicamentos = await RemediosDao().listarRemedios();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Meus Remédios',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Icon(
                Icons.account_circle,
                color: Colors.white,
                size: 32,
              ),
            ],
          ),
          backgroundColor: const Color(0xFF15b5b0),
        ),
        body: buildBody(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
              print(selectedIndex);
            });
          },
          backgroundColor: const Color(0xFF15b5b0),
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.white,
          selectedLabelStyle: const TextStyle(fontSize: 10),
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.medical_services),
              label: "Medicamentos",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment),
              label: 'Consulta',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: 'Agenda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.support_agent),
              label: 'Ouvidoria',
            ),
          ],
        ),
      ),
    );
  }

  buildBody() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          Expanded(
            child: ListView.builder(
              itemCount: listaMedicamentos.length, 
              itemBuilder: (context, i) {
                return CardRemedios(
                  medicamento: listaMedicamentos[i],
                );
              },
            ),
          ),

          const SizedBox(height: 10),
         
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  disabledBackgroundColor: Colors.cyan,
                  disabledForegroundColor: Colors.white,
                ),
                child: const Text(
                  'Voltar',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  buildText({required text, color, fontSize, fontWeight}) {
    return Text(
      text,
      style: GoogleFonts.inter(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}