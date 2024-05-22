class DoctorModel{
  String ?name;
  String ?email;
  String ?phone;
  String ?uid;
  String ?image;
  String ?major;
  int ? id;
  String ?date;
  String ?cv;
  DoctorModel({
    this.name,
    this.email,
    this.uid,
    this.phone,
    this.image,
    this.major,
    this.id,
    this.date,
    this.cv
  });
  DoctorModel.fromJson(Map<String,dynamic> json)
  {
    email=json['email'];
    name=json['name'];
    phone=json['phone'];
    uid=json['uid'];
    image=json['image'];
    major=json['major'];
    id=json['id'];
    date=json['date'];
    cv=json['cv'];




  }
  Map<String,dynamic> toMap(){
    return{
      'name':name,
      'phone':phone,
      'email':email,
      'uid':uid,
      'image':image,
      'major':major,
      'id':id,
      'date':date,
      'cv':cv,





    };
  }

}