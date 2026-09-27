import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const DadosApp());
}

class DadosApp extends StatelessWidget {
  const DadosApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dados',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      home: const DadosPage(),
    );
  }
}

class DadosPage extends StatelessWidget {
  const DadosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Pessoa> pessoas = [
      Pessoa(
        nome: 'EDERSON DA SILVA',
        link: 'https://drive.google.com/drive/folders/1suRzwtRwJ1IyKxuyxMDPF07_jLL75GCJ?usp=drive_link',
        cor: const Color(0xFFFF6B6B),
      ),
      Pessoa(
        nome: 'ANY RITA',
        link: 'https://drive.google.com/drive/folders/1gx7Dizw5--fXII5lVNAw01QI3EX1tmtc?usp=drive_link',
        cor: const Color(0xFF4ECDC4),
      ),
      Pessoa(
        nome: 'AVR JOSEFINO',
        link: 'https://drive.google.com/drive/folders/1hzV08oQRQUZXTFfUj-hspR3s3T0S3nWf?usp=drive_link',
        cor: const Color(0xFFFFE66D),
      ),
      Pessoa(
        nome: 'SIRETE ARRUBES',
        link: 'https://drive.google.com/drive/folders/1FMy_ZfMll54BYq4Eh88mvZKQEFqM50ao?usp=drive_link',
        cor: const Color(0xFF95E1D3),
      ),
      Pessoa(
        nome: 'GABRIELA ARRUBES\nLEANDRO',
        link: 'https://drive.google.com/drive/folders/1S9vMANFD-osLX7F7fyl7Nqu7zeyu6f5X?usp=drive_link',
        cor: const Color(0xFFC7CEEA),
      ),
      Pessoa(
        nome: 'ANDREW DE SOUZA',
        link: 'https://drive.google.com/drive/folders/1lSLUGvddwnft1xf0HgGqCJVYMAP3HWUl?usp=drive_link',
        cor: const Color(0xFFFF9FF3),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dados',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1,
        ),
        itemCount: pessoas.length,
        itemBuilder: (context, index) {
          return CartaoPessoa(
            pessoa: pessoas[index],
          );
        },
      ),
    );
  }
}

class CartaoPessoa extends StatefulWidget {
  final Pessoa pessoa;

  const CartaoPessoa({
    Key? key,
    required this.pessoa,
  }) : super(key: key);

  @override
  State<CartaoPessoa> createState() => _CartaoPessoaState();
}

class _CartaoPessoaState extends State<CartaoPessoa>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.95).animate(_animController);
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _abrirLink() async {
    final Uri url = Uri.parse(widget.pessoa.link);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        _animController.forward();
      },
      onTapUp: (_) {
        _animController.reverse();
        _abrirLink();
      },
      onTapCancel: () {
        _animController.reverse();
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                widget.pessoa.cor,
                widget.pessoa.cor.withOpacity(0.7),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: widget.pessoa.cor.withOpacity(0.4),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                top: -30,
                right: -30,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 36,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        widget.pessoa.nome,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Pessoa {
  final String nome;
  final String link;
  final Color cor;

  Pessoa({
    required this.nome,
    required this.link,
    required this.cor,
  });
}
