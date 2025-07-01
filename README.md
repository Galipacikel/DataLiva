masraf_app
Masraf Takip Uygulaması – Flutter ile Geliştirilmiş Modern Mock Expense Tracker
🚀 Proje Hakkında
Bu proje, kullanıcıların masraf girişlerini kolayca yapabildiği, masraflarını takip edebildiği ve sahte (mock) onay sürecini deneyimleyebildiği modern bir Flutter uygulamasıdır. Uygulama, tamamen frontend odaklıdır ve gerçek bir backend bağlantısı olmadan, kullanıcı deneyimini ve arayüz tasarımını ön plana çıkarır.
🛠️ Kullanılan Teknolojiler
Flutter (Dart)
Modern UI/UX tasarımı
State management: setState (ileride Provider, Bloc gibi yapılar entegre edilebilir)
Mock veri ve sahte login/onay akışı
📱 Uygulama Özellikleri
Modern Login Ekranı:
Kullanıcı adı ve şifre ile giriş, sadece belirlenen kullanıcı için giriş izni.
Şık ve kullanıcı dostu arayüz.
Kayıt (Sign Up) ve Şifre Sıfırlama (Forgot Password):
Kayıt ve şifre sıfırlama için ayrı ekranlar (mock, backend yok).
Ana Panel (HomePage):
Masraf girişi, masraf onay ve çıkış işlemleri için modern, ikonlu kontrol paneli.
Masraf Girişi (ExpenseFormPage):
Tutar, açıklama, tarih, kategori ve opsiyonel fiş/fotoğraf ekleme alanları.
Kayıt işlemi mock olarak SnackBar ile simüle edilir.
Masraf Onay (ApprovalPage):
Sahte masraf kartları, her kartta “Onayla” ve “Reddet” butonları.
Butonlara tıklanınca bilgi mesajı gösterilir.
Responsive ve Modern Tasarım:
Tüm ekranlarda renk uyumu, ikon kullanımı, köşeli kutular ve modern butonlar.
🧑‍💻 Kurulum ve Çalıştırma
Projeyi Klonla:
Apply to login_page.d...
Bağımlılıkları Yükle:
Apply to login_page.d...
Uygulamayı Başlat:
Apply to login_page.d...
🔑 Demo Kullanıcı Bilgileri
Kullanıcı Adı: galip
Şifre: 1234
Sadece bu bilgilerle giriş yapılabilir.
📂 Klasör Yapısı
lib/login_page.dart – Giriş ekranı
lib/home_page.dart – Ana panel
lib/expense_form_page.dart – Masraf girişi
lib/approval_page.dart – Masraf onay ekranı
lib/main.dart – Uygulama başlangıcı ve yönlendirme
📌 Notlar
Uygulama tamamen mock (sahte) veri ile çalışır, gerçek bir backend bağlantısı yoktur.
UI/UX odaklı geliştirilmiştir, kod yapısı ve tasarım kolayca geliştirilebilir ve ölçeklenebilir.
📝 Katkı ve Lisans
Katkıda bulunmak isterseniz, lütfen bir pull request gönderin.
Bu proje MIT lisansı ile lisanslanmıştır.
