# SwiftShop
 InnovaBootcamp-BitirmeProjesi
# SwiftShop: E-Ticaret Uygulaması

## Başlarken
Bu proje, Firebase ve API çağrıları ile çalışan bir e-ticaret uygulamasıdır.

## API Referansları
- **Ürünler**: Kategorilere göre ürünleri listeler.
- **Sepet**: Sepete ekleme ve silme işlemlerini yapar.
- **Kimlik Doğrulama**: Firebase ile kullanıcı oturumları.

## Mimari: MVVM-C (Model-View-ViewModel-Coordinator)

Bu projede **MVVM-C mimarisi** kullanılmıştır. Bu yapı, uygulamanın daha modüler, test edilebilir ve sürdürülebilir olmasını sağlar. **MVVM-C**, her bileşenin belirli bir sorumluluğu yerine getirmesini sağlar ve uygulamanın büyümesiyle birlikte daha rahat yönetilmesine olanak tanır.

### Model-View-ViewModel-Coordinator Bileşenleri

1. **Model (Veri Katmanı):**
   - Uygulamanın verilerini ve veri işlemlerini temsil eder.  
   - Bu projede, `Product`, `CartItem`, ve `GroupedCartItem` gibi modeller kullanıldı.  
   - Modeller, verilerin kodlanması ve çözümlenmesi için **Codable** protokolü ile uyumlu hale getirildi.

2. **View (Görünüm Katmanı):**
   - Kullanıcı arayüzleri UIKit kullanılarak oluşturuldu.  
   - `ProductListVC`, `CartVC`, `SignInVC`, ve diğer ViewController sınıfları ile her ekranın arayüzü ve etkileşimleri tanımlandı.  
   - View katmanı, yalnızca UI bileşenlerini içerir ve herhangi bir iş mantığı içermez.

3. **ViewModel (İş Mantığı Katmanı):**
   - ViewModel, **iş mantığını** ve **veri yönetimini** sağlar.  
   - View ile Model arasında köprü görevi görür. ViewModel'ler, ViewController'ları gereksiz iş yükünden kurtararak daha sade hale getirir.
   - Projemdeki örnek ViewModel'ler:
     - **`ProductVM`**: Ürünlerin listelenmesi ve filtrelenmesini sağlar.
     - **`CartVM`**: Sepet yönetim işlemlerini yürütür.
     - **`AuthenticationVM`**: Kullanıcı kayıt ve giriş işlemlerini Firebase ile yönetir.

4. **Coordinator (Navigasyon ve Akış Yönetimi):**
   - **Koordinatör yapısı**, uygulamadaki ekranlar arası geçişleri yönetir.  
   - ViewController'ların navigasyon kodlarından arındırılması için bu desen kullanıldı.  
   - Örneğin, bir ürün detayına geçiş yapmak veya giriş sonrası ana ekrana yönlendirme yapmak gibi işlemler Coordinator üzerinden gerçekleştirilir.

### MVVM-C Mimarisi ile Çalışmanın Avantajları

- **Modüler Yapı:** Her bileşen (Model, View, ViewModel) tek bir sorumluluğa sahiptir. Bu, projeyi hem daha okunabilir hem de sürdürülebilir hale getirir.  
- **Test Edilebilirlik:** ViewModel'lerin bağımsız olması sayesinde kolayca **unit test** yazılabilir. Örneğin, `ProductVM` içerisinde API’den dönen ürünleri test etmek mümkündür.
- **Görünüm ve İş Mantığının Ayrılması:** ViewController’lar yalnızca UI bileşenleri ile ilgilenir. Böylece, iş mantığı ve veri işlemleri ViewModel’de izole edilir.
- **Navigasyon Yönetimi:** Koordinatör yapısı ile ekranlar arası geçişler düzenli ve merkezi bir şekilde yönetilir.

### Projenin MVVM-C Yapısına Uygun Uygulanışı

- **`ProductListVC` ve `ProductVM` İlişkisi:**  
  - **ProductListVC**, kullanıcıya ürünleri gösteren ekranı temsil eder.  
  - Ürünler, **ProductVM** tarafından API’den getirilir ve filtreleme işlemleri burada yapılır.
  - Kullanıcı arama yaptığında, arama metni doğrudan ViewModel’e iletilir ve ViewModel arama sonucunu güncelleyip ViewController'a iletir.

- **`CartVC` ve `CartVM` İlişkisi:**  
  - **CartVC**, sepet ekranını temsil eder.  
  - Sepetteki ürünler, **CartVM** üzerinden yönetilir. Sepetten ürün silindiğinde ViewModel, API çağrısı yapar ve güncellenmiş veriyi ViewController'a iletir.

- **`SignInVC` ve `AuthenticationVM` İlişkisi:**  
  - Kullanıcı giriş ve kayıt işlemleri, **AuthenticationVM** üzerinden gerçekleştirilir.  
  - Firebase üzerinden kimlik doğrulama, ViewModel aracılığıyla yönetilir. Giriş işlemi başarıyla tamamlandığında, ViewController ilgili ekrana yönlendirme yapar.

### Gelecekte MVVM-C ile Geliştirme Olasılıkları

1. **Test Yazma:**  
   - ViewModel bileşenleri bağımsız çalıştığı için, her biri için kolayca **unit test** yazılabilir. Örneğin, `ProductVM` için sahte (mock) API verileri kullanılarak testler yapılabilir.  
   - **Dependency Injection** ile bağımlılıkların kolayca değiştirilmesi, test yazmayı daha da kolaylaştırır.

2. **Koordinatör Yapısının Genişletilmesi:**  
   - Uygulamanın büyümesi durumunda, daha fazla ekran ve akış eklenerek koordinatör yapısı genişletilebilir. Bu sayede, ekranlar arası geçişler merkezi bir şekilde yönetilmeye devam eder.

3. **SwiftUI ve Combine Kullanımı:**  
   - İlerleyen zamanlarda SwiftUI ve Combine öğrenilerek, daha modern ve reaktif bir mimari ile uygulama yeniden ele alınabilir. Böylece UI güncellemeleri daha akıcı hale gelir.


## Ağ Katmanı
URLSession ile manuel ağ çağrıları yapılmıştır.

```swift
func fetchData<T: Decodable>(
    endpoint: Endpointable,
    body: Encodable?,
    completion: @escaping (Result<T, Error>) -> ()
)
```

## Proje Hakkındaki Düşüncelerim

Bu proje benim için harika bir öğrenme deneyimi oldu. Küçük ölçekli projelerde bile MVVM-C mimarisi ile çalışmak, projeyi daha **ölçeklenebilir** ve düzenli hale getiriyor.

- **Koordinatör Yapısı:** Büyük projelerde navigasyon akışını düzenlemek için çok faydalı.  
- **Geliştirme Alanları:** Mock servis talepleri eklenerek gelecekte testlerin güvenilirliği artırılabilir.  
- **Test Planlaması:** Şu an için test eklemedim, ancak ilerleyen süreçte eklemeyi planlıyorum.

## Neler Geliştirilebilir?

- **UI Özelleştirme:** Kullanıcı arayüzü bileşenleri daha soyut ve yeniden kullanılabilir hale getirilebilir.  
- **Firebase ve Bildirimler:** Sepet güncellemeleri veya kampanyalar için bildirim entegrasyonu yapılabilir.  
- **SwiftUI ve Combine:** Daha modern ve reaktif mimari için bu teknolojileri öğrenmek faydalı olacaktır.

## İlginç Bulduğum Noktalar

- **Query Parametreleri:** Backend JSON yerine query parametreleri beklediği için manuel çözüm geliştirildi.  
- **Network Yönetimi:** Üçüncü taraf kütüphaneler yerine URLSession kullanmak, bana önemli bir deneyim kazandırdı.

## Özet

Bu proje, manuel ağ yönetimi, MVVM-C mimarisi ve Firebase ile çalışma konusunda bana değerli bir deneyim sağladı. Kullanıcı arayüzünü basit tuttum ve ağırlıklı olarak proje mimarisi ile konseptlere odaklandım. Gelecekte, SwiftUI ve Combine gibi teknolojileri öğrenmeyi hedefliyorum.
