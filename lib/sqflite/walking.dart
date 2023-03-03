class Walking{
  int? id;
  String? name;
  int? langkah;
  String? uid;
  String? tgl;

  Walking({this.id, this.name, this.langkah, this.uid, this.tgl});

  Walking.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res["name"],
        langkah = res["langkah"],
        uid = res["uid"],
        tgl = res["tgl"];
  Map<String, Object?> toMap(){
    return {
      'id':id,
      'name':name,
      'langkah':langkah,
      'uid': uid,
      'tgl': tgl
    };
  }
}