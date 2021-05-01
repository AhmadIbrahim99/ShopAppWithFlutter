class Address{

  String streetNumber;
  String streetName;
  String city;
  String state;
  String country;
  String postCode;

  Address.fromJson(Map <String, dynamic> jsongObject){
    this.streetNumber=jsongObject["street_number"];
    this.streetName=jsongObject["street_name"];
    this.city=jsongObject["city"];
    this.state=jsongObject["state"];
    this.country=jsongObject["country"];
    this.postCode=jsongObject["post_code"];
}

}