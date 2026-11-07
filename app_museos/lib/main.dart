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
      title: 'App de Museos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const MuseumsScreen(),
    );
  }
}

class Museum {
  final String imagenUrl;
  final String nombre;
  final String descripcion;
  final String locacion;
  final String sitioWeb;

  Museum({
    required this.imagenUrl,
    required this.nombre,
    required this.descripcion,
    required this.locacion,
    required this.sitioWeb,
  });
}

class MuseumsScreen extends StatefulWidget {
  const MuseumsScreen({super.key});

  @override
  State<MuseumsScreen> createState() => _MuseumsScreenState();
}

class _MuseumsScreenState extends State<MuseumsScreen> {
  final List<Museum> _allMuseums = [
    Museum(
      imagenUrl: 'https://images.unsplash.com/photo-1565193566173-7a0ee3dbe261?w=500',
      nombre: 'Museo de Arte del Rio',
      descripcion: 'Coleccion de pinturas y esculturas modernas con salas dedicadas al arte del siglo XX y a exposiciones temporales.',
      locacion: '4.5981, -74.760',
      sitioWeb: 'https://riotur.rio/es/que_fazer/11134/',
    ),
    Museum(
      imagenUrl: 'https://images.unsplash.com/photo-1582555172866-f73bb12a2ab3?w=500',
      nombre: 'Museo de Historia Natural Andina',
      descripcion: 'Especie de fauna, flora y geología de la región andina, con exposiciones interactivas y educativas.',
      locacion: '6.5837, -73.150',
      sitioWeb: 'https://museoandino.org/', 
    ),
    Museum(
      imagenUrl: 'https://images.unsplash.com/photo-1513694203232-719a280e022f?w=500',
      nombre: 'Museo Arquitectonico del Antiplano',
      descripcion: 'Exposiciones de arquitectura y diseño, con énfasis en la historia evolución de la arquitectura en la región del altiplano.',
      locacion: '6.0904, -75.423',
      sitioWeb: 'https://museoarquitectonico.org/',
    ),
    Museum(
      imagenUrl: 'https://images.unsplash.com/photo-1566127444979-b3d2b65463d7?w=500',
      nombre: 'Casa Museo del patrimonio local',
      descripcion: 'Exposiciones de arte y cultura local, con énfasis en la preservación del patrimonio histórico y cultural de la región.',
      locacion: '7.1234, -76.543',
      sitioWeb: 'https://casamuseo.com/',
    ),
  ];

  List<Museum> _filteredMuseums = [];

  @override
  void initState() {
    super.initState();
    _filteredMuseums = _allMuseums;
  }

  void _runFilter(String enteredKeyword) {
    List<Museum> results = [];
    if (enteredKeyword.isEmpty) {
      results = _allMuseums;
    } else {
      results = _allMuseums
          .where((museum) =>
              museum.nombre.toLowerCase().contains(enteredKeyword.toLowerCase()) ||
              museum.descripcion.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _filteredMuseums = results;
    });
  }

  Future<void> _abrirSitioWeb(String urlString) async {
    final Uri url = Uri.parse(urlString);
   
    debugPrint("Abriendo enlace: $urlString");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Museos', 
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: InputDecoration(
                labelText: 'Buscar museos...',
                hintText: 'Escribe el nombre del museo...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              ),
            ),
            const SizedBox(height: 12),

            Expanded(
              child: _filteredMuseums.isEmpty
                  ? const Center(
                      child: Text(
                        'No se encontraron museos',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : GridView.builder(
                      itemCount: _filteredMuseums.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.62, 
                      ),
                      itemBuilder: (context, index) {
                        final museum = _filteredMuseums[index];
                        return Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 95,
                                width: double.infinity,
                                child: Image.network(
                                  museum.imagenUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => Container(
                                    color: Colors.grey[300],
                                    child: const Center(
                                      child: Icon(Icons.broken_image, color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        museum.nombre,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        museum.descripcion,
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 9,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        '📍 ${museum.locacion}',
                                        style: TextStyle(
                                          color: Colors.blue[800],
                                          fontSize: 9,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const Spacer(),
                                  
                                      SizedBox(
                                        width: double.infinity,
                                        height: 28,
                                        child: ElevatedButton(
                                          onPressed: () => _abrirSitioWeb(museum.sitioWeb),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blue,
                                            foregroundColor: Colors.white,
                                            padding: EdgeInsets.zero,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                          ),
                                          child: const Text(
                                            'Ver sitio web',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}