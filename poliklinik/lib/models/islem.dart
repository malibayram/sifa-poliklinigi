class Islem {
  String? islemadi;
  String? islemID;
  DateTime? islemTarihi;

  Islem();

  Islem.fromJson(Map<String, dynamic>? json) {
    this.islemadi = json?['islem-adi'];
    this.islemID = json?['islem-id'];
    this.islemTarihi = json?['islem-tarihi'];
  }

  Map<String, dynamic> toJson() {
    return {
      'islem-id': this.islemID,
      'islem-adi': this.islemadi,
      'islem-tarihi': this.islemTarihi,
    };
  }
}
