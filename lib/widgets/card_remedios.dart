import 'package:myapp/domain/remedio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardRemedios extends StatefulWidget {
  Remedio medicamento;

  CardRemedios({
    required this.medicamento,
    super.key,
  });

  @override
  State<CardRemedios> createState() => _CardRemediosState();
}

class _CardRemediosState extends State<CardRemedios> {
  
  Remedio get medicamento => widget.medicamento;
  

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD), 
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          buildText(
            text: medicamento.nome, 
            fontSize: 17.0,
            fontWeight: FontWeight.w600,
          ),
          
          const SizedBox(height: 8), 
          
          
          Row(
            children: [
              const Icon(Icons.medical_services, size: 16), 
              const SizedBox(width: 4),
              buildText(
                text: medicamento.dose, 
                fontSize: 14.0,
                color: Colors.black,
              ),
            ],
          ),
          
         
          buildText(text: medicamento.descricao), 
          buildText(text: medicamento.idade), 
          buildText(text: medicamento.frequencia),
        ],
      ),
    );
  }

  buildText({required text, color, fontSize, fontWeight}) {
    return Text(
      text, 
      style: GoogleFonts.inter(
        color: Colors.black, 
        fontSize: 14.0, 
        fontWeight: fontWeight, 
      ),
    );
  }
}