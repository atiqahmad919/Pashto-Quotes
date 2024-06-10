class Pmatals {
  final int id;
  final String title;
  final String matal;
  bool fav;

  Pmatals(
      {required this.id,
      required this.title,
      required this.matal,
      this.fav = false});

  factory Pmatals.fromMap(Map<String, dynamic> json) => Pmatals(
        id: json['id'],
        title: json['tittle'],
        matal: json['matals'],
        fav: json['fav'] == 1,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'tittle': title,
        'matals': matal,
        'fav': fav ? 1 : 0,
      };
}
