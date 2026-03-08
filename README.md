# 2409116004_Indah-Putri-Lestari_Tugas5

Nama: Indah Putri Lestari

NIM: 2409116004

Kelas: A'2024

## A. Struktur Form Registrasi

Form pendaftaran dibagi menjadi **3 tahap** menggunakan widget **Stepper**.

### 1. Data Akun

Pada tahap pertama form registrasi yaitu **Data Akun**, pengguna diminta untuk mengisi beberapa informasi dasar yang diperlukan untuk melakukan pendaftaran event. Informasi yang diminta pada tahap ini meliputi **nama lengkap, email, dan password**.

<img width="3200" height="2000" alt="image" src="https://github.com/user-attachments/assets/c8a2e5fb-b782-428b-a98c-55e0cd7d7ef7" />

Setiap field menggunakan komponen `TextFormField` yang dilengkapi dengan **validasi input**. Validasi ini bertujuan untuk memastikan bahwa data yang dimasukkan oleh pengguna sudah benar sebelum melanjutkan ke tahap berikutnya.

<img width="3200" height="2000" alt="image" src="https://github.com/user-attachments/assets/c59db38f-56f6-4ac4-a7d9-5e3ae315a090" />

Jika pengguna menekan tombol **Continue** tanpa mengisi data dengan benar, maka akan muncul pesan error seperti:

- Nama wajib diisi dan harus diisi minimal 3 karakter.
- Email wajib diisi dan harus menggunakan format email yang valid.
- Password minimal 8 karakter dan harus mengandung huruf besar.

<img width="3200" height="2000" alt="image" src="https://github.com/user-attachments/assets/cf683290-2d1a-4fed-9347-c04f99fdc432" />

Pada tahap ini pengguna telah mengisi **nama lengkap, email, dan password**. Jika semua data sudah valid, pengguna dapat menekan tombol **Continue** untuk melanjutkan ke tahap berikutnya yaitu **Informasi Pribadi**.

Pada field password juga terdapat ikon **show/hide password** yang memungkinkan pengguna untuk melihat atau menyembunyikan password yang sedang diketik.

### 2. Informasi Pribadi

Pada tahap kedua yaitu **Informasi Pribadi**, pengguna diminta untuk melengkapi data tambahan setelah mengisi data akun pada langkah sebelumnya.

<img width="3200" height="2000" alt="image" src="https://github.com/user-attachments/assets/750bcdc8-c6d3-420d-9eb1-8aca4f418983" />

Jika pengguna tidak memilih program studi dan langsung menekan tombol **Continue**, maka akan muncul pesan validasi: **"Program Studi wajib dipilih"**

Selain itu terdapat field **Tanggal Lahir** yang menggunakan `TextFormField` dengan fitur **Date Picker**. Field ini bersifat **read-only**, sehingga pengguna tidak dapat mengetik tanggal secara manual dan harus memilih tanggal melalui kalender yang muncul saat field ditekan. Apabila tanggal lahir belum diisi, maka sistem akan menampilkan pesan validasi: **"Tanggal lahir wajib diisi"**.

<img width="3200" height="2000" alt="image" src="https://github.com/user-attachments/assets/06b30d2b-a862-4a5e-a595-f518a0fef76f" />

Pengguna terlebih dahulu memilih **jenis kelamin** menggunakan komponen `RadioListTile`. Terdapat dua pilihan yang tersedia yaitu **Laki-laki** dan **Perempuan**.

Selanjutnya pengguna harus memilih **Program Studi** menggunakan komponen `DropdownButtonFormField`. Field ini menampilkan beberapa pilihan program studi seperti:

- Teknik Informatika  
- Sistem Informasi  
- Teknik Komputer  
- Data Science  
- Desain Komunikasi Visual

<img width="3200" height="2000" alt="image" src="https://github.com/user-attachments/assets/fff37848-ca7f-4e30-add9-ae2f821be73f" />

Tanggal lahir dipilih menggunakan fungsi `showDatePicker()` kemudian hasilnya akan ditampilkan pada field tanggal lahir.

### 3. Konfirmasi

<img width="3200" height="2000" alt="image" src="https://github.com/user-attachments/assets/d4969d37-bd26-4170-9397-e64f64d52f36" />

Pada tahap **Konfirmasi**, pengguna diminta untuk memastikan bahwa semua data yang telah diisi pada langkah sebelumnya sudah benar. Pada bagian ini terdapat komponen **CheckboxListTile** yang digunakan untuk menyatakan bahwa pengguna telah menyetujui **syarat & ketentuan** pendaftaran.

Checkbox ini berfungsi sebagai validasi tambahan sebelum proses registrasi diselesaikan. Jika pengguna belum mencentang persetujuan tersebut, maka sistem tidak akan melanjutkan proses pendaftaran. Setelah disetujui, pengguna dapat menekan tombol **Continue** untuk menyimpan data pendaftar ke dalam sistem.

### 4. Notifikasi Registrasi Berhasil

<img width="3200" height="2000" alt="image" src="https://github.com/user-attachments/assets/4b206f3c-a34a-4012-8513-823dd7ec04ed" />

Setelah pengguna menyelesaikan seluruh tahapan form dan menekan tombol **Continue**, sistem akan menampilkan dialog **Registrasi Berhasil**. Dialog ini berfungsi sebagai konfirmasi bahwa data pendaftar telah berhasil disimpan ke dalam sistem.

Dialog menampilkan nama pendaftar serta menyediakan dua pilihan aksi, yaitu **Daftar Lagi** untuk kembali ke form pendaftaran dan mengisi data baru, serta **Lihat Daftar** untuk melihat daftar seluruh peserta yang telah terdaftar.

## B. Lihat Daftar

<img width="3200" height="2000" alt="image" src="https://github.com/user-attachments/assets/faad5143-6641-40d2-9b67-4fab0cf5f93c" />

Halaman **Daftar Peserta** menampilkan seluruh data pendaftar yang telah berhasil diregistrasi. Data ditampilkan dalam bentuk **ListTile** yang berisi nama peserta, program studi, dan email.

## Edit Daftar Peserta

**Sebelum Edit Pendaftar**

<img width="3200" height="2000" alt="image" src="https://github.com/user-attachments/assets/7e969b49-b039-4440-b5e1-6d70aa932110" />

Pada bagian ini, saya ingin mengedit data pendaftar bernama **Indah Putri Lestari** dengan menekan ikon **edit (pensil)** pada data peserta. 

**Edit Pendaftar**

<img width="3200" height="2000" alt="image" src="https://github.com/user-attachments/assets/b3e8009b-ecfc-4382-afdf-639136ffe08f" />

Setelah itu akan muncul dialog **Edit Pendaftar** yang berisi field **nama** dan **email** yang dapat diubah. Pada contoh ini, saya mengubah **nama dan email pendaftar**, kemudian menekan tombol **Simpan** untuk memperbarui data tersebut di dalam daftar peserta.

**Sesudah Edit Pendaftar**

<img width="3200" height="2000" alt="image" src="https://github.com/user-attachments/assets/1d368edd-2ff7-442d-bf87-cc06eb517f06" />

Data pendaftar bernama **Putri** berhasil diperbarui setelah proses edit dilakukan. Perubahan pada **nama dan email** pendaftar telah tersimpan dan langsung ditampilkan pada daftar peserta.

## Hapus Pendaftar

**Sebelum dihapus**

<img width="3200" height="2000" alt="image" src="https://github.com/user-attachments/assets/dcf6d8c6-2a34-4437-8839-e0f432707c98" />

Pada bagian ini, saya ingin menghapus data pendaftar bernama **Kirei**.

**Pesan Konfirmasi Hapus**

<img width="3200" height="2000" alt="image" src="https://github.com/user-attachments/assets/81c4845a-3cc6-4db0-833f-9a4c663c5733" />

Dialog ini bertujuan untuk memastikan bahwa pengguna benar-benar ingin menghapus data peserta yang dipilih.

Pengguna dapat memilih **Batal** untuk membatalkan proses penghapusan atau **Hapus** untuk menghapus data pendaftar dari daftar peserta.

**Sesudah dihapus**

<img width="3200" height="2000" alt="image" src="https://github.com/user-attachments/assets/71ce15f8-e867-42d8-b789-9ef214e44df0" />

Pendaftar bernama **Kirei** berhasil dihapus dari list daftar peserta.

## Fitur Search Pendaftar

Pada halaman **Daftar Peserta**, tersedia fitur **pencarian (search)** yang memungkinkan pengguna mencari data pendaftar berdasarkan **nama, email, atau program studi**.

<img width="3200" height="2000" alt="image" src="https://github.com/user-attachments/assets/12d20f4c-31fd-4fdf-a87a-bd29cd3de392" />

Pada bagian ini, saya mencoba mencari pendaftar dengan kata kunci **"Kirei"**. Karena data tersebut sebelumnya telah dihapus, maka sistem menampilkan pesan **"Tidak ada hasil ditemukan"**, yang menandakan bahwa tidak ada data yang sesuai dengan kata kunci pencarian.

### Pencarian Berdasarkan Program Studi

<img width="3200" height="2000" alt="image" src="https://github.com/user-attachments/assets/f9a45f7d-e42d-4e42-8c40-1382d83fe688" />

Pada bagian ini, saya memasukkan kata kunci **"infor"**, sehingga sistem menampilkan pendaftar yang memiliki program studi yang mengandung kata tersebut, seperti **Sistem Informasi** dan **Teknik Informatika**.

### Pencarian Berdasarkan Nama

<img width="3200" height="2000" alt="image" src="https://github.com/user-attachments/assets/aeb068d0-2699-4550-be60-a76b3ddc9021" />

Pada bagian ini, saya memasukkan kata kunci **"Indah"**, sehingga sistem menampilkan data pendaftar yang memiliki nama tersebut, seperti **Putri Indah** dan **Indah Lestari**.

### Pencarian Berdasarkan Email

<img width="3200" height="2000" alt="image" src="https://github.com/user-attachments/assets/4b7f6b6d-2321-40f9-aed6-b4f0eb0acfd6" />

Pada bagian ini, saya memasukkan kata kunci **"lestari001"**, sehingga sistem menampilkan data pendaftar yang memiliki email yang mengandung kata tersebut, yaitu **lestari001@gmail.com** milik **Indah Lestari**.
