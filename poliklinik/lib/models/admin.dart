import 'personel.dart';
import 'klinik.dart';

class Admin extends Personel {

List<Personel>? personeller;
  
personelEkle(Personel personel) {
    personeller?.add(personel);
}
personelSil(Personel personel) {
    personeller?.remove(personel);
}

klinikEkle(Klinik klinik) {
    klinikler?.add(klinik);
}
klinikSil(Klinik klinik) {
    klinikler?.remove(klinik);
}
  
}
