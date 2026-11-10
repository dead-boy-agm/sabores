import 'package:flutter/material.dart';
import '../data/recetas_data.dart';
import '../models/receta.dart';
import '../widgets/receta_card.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _categoriaActual = 'Todas';
  String _busqueda = '';

  List<Receta> get _filtradas {
    return recetas.where((r) {
      final coincideCategoria =
          _categoriaActual == 'Todas' || r.categoria == _categoriaActual;
      final coincideBusqueda =
          r.titulo.toLowerCase().contains(_busqueda.toLowerCase());
      return coincideCategoria && coincideBusqueda;
    }).toList();
  }

  Future<void> _abrirDetalle(Receta receta) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetailScreen(receta: receta)),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final lista = _filtradas;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sabores',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, size: 30),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Perfil próximamente')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              onChanged: (valor) => setState(() => _busqueda = valor),
              decoration: InputDecoration(
                hintText: 'Buscar recetas...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: categorias.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final categoria = categorias[index];
                final seleccionada = categoria == _categoriaActual;
                return ChoiceChip(
                  label: Text(categoria),
                  selected: seleccionada,
                  selectedColor: const Color(0xFFE65100),
                  labelStyle: TextStyle(
                    color: seleccionada ? Colors.white : Colors.black87,
                  ),
                  checkmarkColor: Colors.white,
                  onSelected: (_) =>
                      setState(() => _categoriaActual = categoria),
                );
              },
            ),
          ),
          Expanded(
            child: lista.isEmpty
                ? const Center(child: Text('No se encontraron recetas'))
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 16),
                    itemCount: lista.length,
                    itemBuilder: (context, index) {
                      final receta = lista[index];
                      return RecetaCard(
                        receta: receta,
                        onTap: () => _abrirDetalle(receta),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
