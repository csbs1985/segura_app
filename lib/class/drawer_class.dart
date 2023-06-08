class DrawerModel {
  String rota;
  String texto;

  DrawerModel({
    required this.rota,
    required this.texto,
  });
}

final List<DrawerModel> listaDrawer = [
  DrawerModel(texto: 'Criar senha', rota: 'false'),
  DrawerModel(texto: 'lixeira', rota: 'true'),
  DrawerModel(texto: 'sair', rota: 'false'),
];
