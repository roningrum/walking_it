class Walking{
  int? id;
  String? name;
  int? langkah;
  String? tgl;

  Walking({this.id, this.name, this.langkah, this.tgl});

  Walking.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res["name"],
        langkah = res["langkah"],
        tgl = res["tgl"];
  Map<String, Object?> toMap(){
    return {
      'id':id,
      'name':name,
      'langkah':langkah,
      'tgl': tgl
    };
  }
}