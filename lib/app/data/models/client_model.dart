class ClientModel {
  String? clientId;
  String? name;
  String? address;
  String? city;
  String? state;
  String? gstno;
  String? panNo;
  String? phoneNo;
  String? email;
  String? pin;

  ClientModel(
      {this.clientId,
      this.name,
      this.address,
      this.city,
      this.state,
      this.gstno,
      this.panNo,
      this.phoneNo,
      this.email,
      this.pin});

  ClientModel.fromJson(Map<String, dynamic> json) {
    clientId = json['ClientId'];
    name = json['Name'];
    address = json['Address'];
    city = json['City'];
    state = json['State'];
    gstno = json['Gstno'];
    panNo = json['PanNo'];
    phoneNo = json['PhoneNo'];
    email = json['Email'];
    pin = json['Pin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ClientId'] = this.clientId;
    data['Name'] = this.name;
    data['Address'] = this.address;
    data['City'] = this.city;
    data['State'] = this.state;
    data['Gstno'] = this.gstno;
    data['PanNo'] = this.panNo;
    data['PhoneNo'] = this.phoneNo;
    data['Email'] = this.email;
    data['Pin'] = this.pin;
    return data;
  }
}
