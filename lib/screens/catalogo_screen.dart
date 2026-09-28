import 'package:flutter/material.dart';
import '../models/produto.dart';
import '../widgets/produto_card.dart';
import 'detalhes_produto_screen.dart';

class CatalogoScreen extends StatefulWidget {
  const CatalogoScreen({super.key});

  @override
  State<CatalogoScreen> createState() => _CatalogoScreenState();
}

class _CatalogoScreenState extends State<CatalogoScreen> {
  final List<Produto> _produtos = [
    const Produto(id: '1', nome: 'Smartphone Galaxy S24', preco: 4500.00, categoria: 'Eletrônicos', icone: '📱'),
    const Produto(id: '2', nome: 'Notebook Dell XPS', preco: 8900.00, categoria: 'Informática', icone: '💻'),
    const Produto(id: '3', nome: 'Fone Bluetooth Sony', preco: 1200.00, categoria: 'Áudio', icone: '🎧'),
    const Produto(id: '4', nome: 'Smartwatch Garmin', preco: 2300.00, categoria: 'Wearables', icone: '⌚'),
    const Produto(id: '5', nome: 'Teclado Mecânico RGB', preco: 450.00, categoria: 'Periféricos', icone: '⌨️'),
  ];

  int _proximoId = 6;

  void _adicionarProduto() {
    final novosExemplos = [
      ('Mouse Gamer Sem Fio', 280.00, 'Periféricos', '🖱️'),
      ('Monitor 27" 144Hz', 1650.00, 'Informática', '🖥️'),
      ('Caixa de Som Bluetooth', 350.00, 'Áudio', '🔊'),
      ('Tablet 10.5 Polegadas', 2100.00, 'Eletrônicos', '📱'),
      ('Webcam Full HD 1080p', 320.00, 'Periféricos', '📷'),
    ];

    final indexModelo = (_proximoId - 6) % novosExemplos.length;
    final modelo = novosExemplos[indexModelo];

    setState(() {
      _produtos.add(
        Produto(
          id: _proximoId.toString(),
          nome: '${modelo.$1} ($_proximoId)',
          preco: modelo.$2,
          categoria: modelo.$3,
          icone: modelo.$4,
        ),
      );
      _proximoId++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo de Produtos'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                'Itens: ${_produtos.length}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: _produtos.isEmpty
          ? const Center(
              child: Text(
                'Nenhum produto no catálogo.\nToque no botão "+" para adicionar.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: _produtos.length,
              itemBuilder: (context, index) {
                final produto = _produtos[index];
                return Dismissible(
                  key: Key(produto.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20.0),
                    color: Colors.red,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    final produtoRemovido = produto;
                    setState(() {
                      _produtos.removeAt(index);
                    });

                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Produto "${produtoRemovido.nome}" foi removido.'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  child: ProdutoCard(
                    produto: produto,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetalhesProdutoScreen(produto: produto),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _adicionarProduto,
        tooltip: 'Adicionar Produto',
        child: const Icon(Icons.add),
      ),
    );
  }
}
