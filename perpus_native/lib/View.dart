import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Controller.dart';
import 'Model.dart';
import 'Widgets/MenuBotBar.dart';
class PerpustakaanScreen extends StatefulWidget {
  @override
  _PerpustakaanScreenState createState() => _PerpustakaanScreenState();
}

class _PerpustakaanScreenState extends State<PerpustakaanScreen> {
  final PerpustakaanController _controller = PerpustakaanController();
  final _judulController = TextEditingController();
  final _penulisController = TextEditingController();
  final _tahunController = TextEditingController();
  final _halamanController = TextEditingController();

  void _tambahBuku() {
    final judul = _judulController.text;
    final penulis = _penulisController.text;
    final tahun = int.tryParse(_tahunController.text) ?? 0;
    final halaman = int.tryParse(_halamanController.text) ?? 0;

    setState(() {
      _controller.tambahBuku(Perpus(
        judul: judul,
        penulis: penulis,
        tahunTerbit: tahun,
        jumlahHalaman: halaman,
      ));
    });

    _clearControllers();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Buku berhasil ditambahkan")));
  }
  int _PoinMembaca = 0;

  void _editBuku(int index) {
    final buku = _controller.getBukuList()[index];
    _judulController.text = buku.judul;
    _penulisController.text = buku.penulis;
    _tahunController.text = buku.tahunTerbit.toString();
    _halamanController.text = buku.jumlahHalaman.toString();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Edit Buku'),
        content: _bukuForm(),
        actions: [
          TextButton(
            child: Text('Simpan'),
            onPressed: () {
              setState(() {
                _controller.editBuku(
                    index,
                    Perpus(
                      judul: _judulController.text,
                      penulis: _penulisController.text,
                      tahunTerbit: int.parse(_tahunController.text),
                      jumlahHalaman: int.parse(_halamanController.text),
                    ));
              });
              Navigator.of(context).pop();
              _clearControllers();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Buku berhasil diedit")));
            },
          ),
          TextButton(
            child: Text('Batal'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  void _hapusBuku(int index) {
    setState(() {
      _controller.hapusBuku(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Buku berhasil dihapus", style: TextStyle(color: Colors.white)),));
  }

  void _clearControllers() {
    _judulController.clear();
    _penulisController.clear();
    _tahunController.clear();
    _halamanController.clear();
  }

  Widget _bukuForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        child: Column( 
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                controller: _judulController,
                decoration: InputDecoration(labelText: 'Judul'),
                
                ),
                
            TextField(
                controller: _penulisController,
                decoration: InputDecoration(labelText: 'Penulis')
                
                ),
            TextField(
                controller: _tahunController,
                decoration: InputDecoration(labelText: 'Tahun Terbit'),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly
                ],
                ),
            TextField(
                controller: _halamanController,
                decoration: InputDecoration(labelText: 'Jumlah Halaman'),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly
                ],
                ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0), 
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.0)),
          child: AppBar(
            title: Text("E - Library"),
            titleTextStyle: TextStyle(color: Colors.white),
            backgroundColor: Color.fromARGB(255, 0, 64, 255),
            leading: Icon(Icons.menu_book_rounded, color: Color.fromARGB(255, 255, 255, 255)),
            actions: [
              Padding(
                padding: const EdgeInsets.all(16.0), 
                child: Text("Poin Anda :  + $_PoinMembaca", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
      
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            _bukuForm(),
            ElevatedButton.icon(
              onPressed: _tambahBuku,
              icon: Icon(Icons.add),
              label: Text('Tambah Buku', style: TextStyle(color: Colors.white), ),
              style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 8, 123, 255)),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _controller.getBukuList().length,
                itemBuilder: (context, index) {
                  final buku = _controller.getBukuList()[index];
                  return ListTile(
                    title: Text(buku.judul),
                    subtitle: Text(
                      'Penulis: ${buku.penulis}, Tahun: ${buku.tahunTerbit}, Halaman: ${buku.jumlahHalaman}',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _editBuku(index),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.blue),
                          onPressed: () => _hapusBuku(index),
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
      bottomNavigationBar: MenuBotBar(),
    );
  }
}


