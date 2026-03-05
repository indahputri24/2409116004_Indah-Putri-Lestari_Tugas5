import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/registrant_model.dart';
import '../providers/registration_provider.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  final _formKey = GlobalKey<FormState>();
  final _accountFormKey = GlobalKey<FormState>();
  final _personalFormKey = GlobalKey<FormState>();

  int _currentStep = 0;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _dateController = TextEditingController();

  bool _obscurePassword = true;
  String _selectedGender = 'Laki-laki';
  String? _selectedProdi;
  DateTime? _selectedDate;
  bool _agreeTerms = false;

  final List<String> _prodiList = [
    'Teknik Informatika',
    'Sistem Informasi',
    'Teknik Komputer',
    'Data Science',
    'Desain Komunikasi Visual',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    final months = [
      '',
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];

    return '${date.day} ${months[date.month]} ${date.year}';
  }

  Future<void> _pickDate() async {

    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2004,1,1),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );

    if(picked != null){
      setState(() {
        _selectedDate = picked;
        _dateController.text = _formatDate(picked);
      });
    }
  }

  void _submitForm(){
    if(!_formKey.currentState!.validate()) return;
    final provider = context.read<RegistrationProvider>();
    if(provider.isEmailRegistered(_emailController.text)){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email sudah terdaftar'),
          backgroundColor: Colors.orange,
        )
      );
      return;
    }

    final registrant = Registrant(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      gender: _selectedGender,
      programStudi: _selectedProdi!,
      dateOfBirth: _selectedDate!,
    );

    provider.addRegistrant(registrant);

    showDialog(
      context: context,
      builder: (context)=>AlertDialog(
        icon: const Icon(Icons.check_circle,color: Colors.green,size: 48),
        title: const Text('Registrasi Berhasil'),
        content: Text('${registrant.name} berhasil didaftarkan'),
        actions: [
          TextButton(
            onPressed: (){
              Navigator.pop(context);
              _resetForm();
            },
            child: const Text('Daftar Lagi'),
          ),
          ElevatedButton(
            onPressed: (){
              Navigator.pop(context);
              Navigator.pushNamed(context,'/list');
              _resetForm();
            },
            child: const Text('Lihat Daftar'),
          )
        ],
      ),
    );

  }

  void _resetForm(){
    _formKey.currentState!.reset();

    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _dateController.clear();

    setState(() {
      _currentStep = 0;
      _selectedGender = 'Laki-laki';
      _selectedProdi = null;
      _selectedDate = null;
      _agreeTerms = false;
    });

  }

  void _continueStep(){

    if(_currentStep == 0){
      if(!_accountFormKey.currentState!.validate()){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Periksa kembali data akun'),
            backgroundColor: Colors.red,
          )
        );
        return;
      }
    }

    if(_currentStep == 1){
      if(!_personalFormKey.currentState!.validate()){
        return;
      }
    }

    if(_currentStep == 2){
      if(!_agreeTerms){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Anda harus menyetujui syarat & ketentuan'),
            backgroundColor: Colors.red,
          )
        );
        return;
      }
      _submitForm();
      return;
    }

    setState(() {
      _currentStep++;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrasi Event'),
        actions: [
          Consumer<RegistrationProvider>(
            builder: (context,provider,child){
              return Badge(
                label: Text('${provider.count}'),
                isLabelVisible: provider.count > 0,
                child: IconButton(
                  icon: const Icon(Icons.people),
                  onPressed: (){
                    Navigator.pushNamed(context,'/list');
                  },
                ),
              );
            },
          )
        ],
      ),

      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Stepper(
          currentStep: _currentStep,
          onStepContinue: _continueStep,
          onStepCancel: (){
            if(_currentStep > 0){
              setState(() {
                _currentStep--;
              });
            }
          },

          steps: [
            Step(
              title: const Text('Data Akun'),
              isActive: _currentStep >= 0,
              content: Form(
                key: _accountFormKey,
                child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Nama Lengkap',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nama wajib diisi';
                          }
                          if (value.length < 3) {
                            return 'Minimal 3 karakter';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email wajib diisi';
                          }
                          final regex = RegExp(r'^[\w\.-]+@gmail\.com$');
                          if (!regex.hasMatch(value)) {
                            return 'Gunakan email @gmail.com';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.length < 8) {
                            return 'Password minimal 8 karakter';
                          }
                          if (!RegExp(r'[A-Z]').hasMatch(value)) {
                            return 'Password harus mengandung huruf besar';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Step(
              title: const Text('Informasi Pribadi'),
              isActive: _currentStep >= 1,
              content: Form(
                key: _personalFormKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile(
                            title: const Text('Laki-laki'),
                            value: 'Laki-laki',
                            groupValue: _selectedGender,
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value!;
                              });
                            },
                          ),
                        ),

                        Expanded(
                          child: RadioListTile(
                            title: const Text('Perempuan'),
                            value: 'Perempuan',
                            groupValue: _selectedGender,
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    DropdownButtonFormField<String>(
                      value: _selectedProdi,
                      decoration: const InputDecoration(
                        labelText: 'Program Studi',
                        border: OutlineInputBorder(),
                      ),
                      items: _prodiList.map((prodi) {
                        return DropdownMenuItem(
                          value: prodi,
                          child: Text(prodi),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedProdi = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Program Studi wajib dipilih';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    TextFormField(
                      controller: _dateController,
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: 'Tanggal Lahir',
                        border: OutlineInputBorder(),
                      ),
                      onTap: _pickDate,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Tanggal lahir wajib diisi';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),

            Step(
              title: const Text('Konfirmasi'),
              isActive: _currentStep >= 2,
              content: CheckboxListTile(
                title: const Text('Saya setuju dengan syarat & ketentuan'),
                value: _agreeTerms,
                onChanged: (value) {
                  setState(() {
                    _agreeTerms = value ?? false;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}