import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/registration_provider.dart';
import '../models/registrant_model.dart';

class RegistrantListPage extends StatefulWidget {
  const RegistrantListPage({super.key});

  @override
  State<RegistrantListPage> createState() => _RegistrantListPageState();
}

class _RegistrantListPageState extends State<RegistrantListPage> {
  String _searchQuery = '';

  List<Registrant> _filterRegistrants(List<Registrant> registrants) {
    if (_searchQuery.isEmpty) return registrants;

    return registrants.where((r) {
      return r.name.toLowerCase().contains(_searchQuery) ||
          r.email.toLowerCase().contains(_searchQuery) ||
          r.programStudi.toLowerCase().contains(_searchQuery);
    }).toList();
  }

  void _showEditDialog(BuildContext context, Registrant registrant) {
    final nameController = TextEditingController(text: registrant.name);
    final emailController = TextEditingController(text: registrant.email);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Pendaftar'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Batal'),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: const Text('Simpan'),
              onPressed: () {
                final provider =
                    context.read<RegistrationProvider>();

                final updatedRegistrant = Registrant(
                  id: registrant.id,
                  name: nameController.text,
                  email: emailController.text,
                  gender: registrant.gender,
                  programStudi: registrant.programStudi,
                  dateOfBirth: registrant.dateOfBirth,
                  registeredAt: registrant.registeredAt,
                );

                provider.updateRegistrant(
                  registrant.id,
                  updatedRegistrant,
                );

                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<RegistrationProvider>(
          builder: (context, provider, _) {
            return Text('Daftar Peserta (${provider.count})');
          },
        ),
      ),

      body: Consumer<RegistrationProvider>(
        builder: (context, provider, child) {
          final filtered = _filterRegistrants(provider.registrants);

          return Column(
            children: [

              /// SEARCH BAR
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Cari nama, email, atau prodi...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value.toLowerCase();
                    });
                  },
                ),
              ),

              /// EMPTY STATE
              if (filtered.isEmpty)
                const Expanded(
                  child: Center(
                    child: Text(
                      'Tidak ada hasil ditemukan',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                )

              else

                /// LIST VIEW
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final registrant = filtered[index];

                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(
                              registrant.name[0].toUpperCase(),
                            ),
                          ),

                          title: Text(
                            registrant.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          subtitle: Text(
                            '${registrant.programStudi} • ${registrant.email}',
                          ),

                          /// ACTION BUTTONS
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              /// EDIT
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                onPressed: () {
                                  _showEditDialog(
                                      context, registrant);
                                },
                              ),

                              /// DELETE
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: const Text(
                                          'Hapus Pendaftar?'),
                                      content: Text(
                                          'Yakin hapus ${registrant.name}?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(ctx),
                                          child:
                                              const Text('Batal'),
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton
                                              .styleFrom(
                                            backgroundColor:
                                                Colors.red,
                                          ),
                                          onPressed: () {
                                            provider
                                                .removeRegistrant(
                                                    registrant.id);
                                            Navigator.pop(ctx);
                                          },
                                          child:
                                              const Text('Hapus'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),

                          /// DETAIL PAGE
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/detail',
                              arguments: registrant.id,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}