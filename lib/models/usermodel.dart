class userModel{
  String ?name;
  String ?email;
  String ?phone;
  String ?uid;
  String ?image;
  String ?major;
  String?token;
  int ? id;
  String ?date;
  String ?cv;
  String ?status;
  String ?gender;
  userModel({
    this.name,
    this.email,
    this.uid,
    this.phone,
    this.image,
    this.major,
     this.id,
    this.date,
    this.cv,
    this.status,
    this.gender, this.token
});
  userModel.fromJson(Map<String,dynamic> json)
  {
    token=json['token'];
    email=json['email'];
    name=json['name'];
    phone=json['phone'];
    uid=json['uid'];
    image=json['image'];
    major=json['major'];
    id=json['id'];
    date=json['date'];
    cv=json['cv'];
    status=json['status'];
    gender=json['gender'];





  }
  Map<String,dynamic> toMap(){
    return{
      'token':token,
      'name':name,
      'phone':phone,
      'email':email,
      'uid':uid,
      'image':image,
      'major':major,
      'id':id,
      'date':date,
      'cv':cv,
      'status':status,
      'gender':gender,






    };
  }

}