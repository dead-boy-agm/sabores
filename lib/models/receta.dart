class Receta {
  final int id;
  final String titulo;
  final String descripcion;
  final String categoria;
  final String imagen;
  final int minutos;
  final int porciones;
  final double calificacion;
  final String dificultad;
  final List<String> ingredientes;
  final List<String> pasos;
  bool favorito;

  Receta({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.categoria,
    required this.imagen,
    required this.minutos,
    required this.porciones,
    required this.calificacion,
    required this.dificultad,
    required this.ingredientes,
    required this.pasos,
    this.favorito = false,
  });
}
