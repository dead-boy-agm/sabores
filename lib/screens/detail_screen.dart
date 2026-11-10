import 'package:flutter/material.dart';
import '../models/receta.dart';
import '../widgets/info_item.dart';

class DetailScreen extends StatefulWidget {
  final Receta receta;

  const DetailScreen({super.key, required this.receta});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final receta = widget.receta;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Compartiendo ${receta.titulo}')),
                  );
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                receta.titulo,
                style: const TextStyle(
                  shadows: [Shadow(blurRadius: 8, color: Colors.black87)],
                ),
              ),
              background: Hero(
                tag: 'receta_${receta.id}',
                child: Image.network(
                  receta.imagen,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: const Color(0xFFFFE0B2),
                    child: const Icon(
                      Icons.restaurant,
                      size: 80,
                      color: Color(0xFFE65100),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Chip(
                    label: Text(receta.categoria),
                    backgroundColor: const Color(0xFFFFE0B2),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    receta.descripcion,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InfoItem(
                            icono: Icons.timer_outlined,
                            valor: '${receta.minutos} min',
                            etiqueta: 'Tiempo',
                          ),
                          InfoItem(
                            icono: Icons.people_outline,
                            valor: '${receta.porciones}',
                            etiqueta: 'Porciones',
                          ),
                          InfoItem(
                            icono: Icons.star,
                            valor: '${receta.calificacion}',
                            etiqueta: 'Calificación',
                          ),
                          InfoItem(
                            icono: Icons.local_fire_department_outlined,
                            valor: receta.dificultad,
                            etiqueta: 'Nivel',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Ingredientes',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ...receta.ingredientes.map(
                    (ingrediente) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.check_circle,
                            size: 20,
                            color: Color(0xFFE65100),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              ingrediente,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Preparación',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ...receta.pasos.asMap().entries.map(
                    (entrada) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 14,
                            backgroundColor: const Color(0xFFE65100),
                            child: Text(
                              '${entrada.key + 1}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              entrada.value,
                              style: const TextStyle(fontSize: 16, height: 1.4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: receta.favorito
                            ? Colors.red
                            : const Color(0xFFE65100),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {
                        setState(() => receta.favorito = !receta.favorito);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              receta.favorito
                                  ? 'Agregada a favoritos'
                                  : 'Eliminada de favoritos',
                            ),
                          ),
                        );
                      },
                      icon: Icon(
                        receta.favorito
                            ? Icons.favorite
                            : Icons.favorite_border,
                      ),
                      label: Text(
                        receta.favorito
                            ? 'Quitar de favoritos'
                            : 'Agregar a favoritos',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
