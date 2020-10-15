/// Items : [{"IsCorrect":true,"IsDirectDebitCapable":true,"StatusInformation":"OK","CorrectedSortCode":"404784","CorrectedAccountNumber":"70872490","IBAN":"GB68HBUK40478470872490","Bank":"HSBC UK BANK PLC","BankBIC":"HBUKGB41","Branch":"Firstdirect Leeds","BranchBIC":"FDD","ContactAddressLine1":"40 Wakefield Road","ContactAddressLine2":"","ContactPostTown":"Leeds","ContactPostcode":"LS98 1FD","ContactPhone":"03456 100100","ContactFax":"","FasterPaymentsSupported":true,"CHAPSSupported":true}]

class AccountValidatorModel {
  List<Items> items;

  AccountValidatorModel({this.items});

  AccountValidatorModel.fromJson(Map<String, dynamic> json) {
    if (json['Items'] != null) {
      items = new List<Items>();
      json['Items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['Items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  bool isCorrect;
  bool isDirectDebitCapable;
  String statusInformation;
  String correctedSortCode;
  String correctedAccountNumber;
  String iBAN;
  String bank;
  String bankBIC;
  String branch;
  String branchBIC;
  String contactAddressLine1;
  String contactAddressLine2;
  String contactPostTown;
  String contactPostcode;
  String contactPhone;
  String contactFax;
  bool fasterPaymentsSupported;
  bool cHAPSSupported;

  Items(
      {this.isCorrect,
        this.isDirectDebitCapable,
        this.statusInformation,
        this.correctedSortCode,
        this.correctedAccountNumber,
        this.iBAN,
        this.bank,
        this.bankBIC,
        this.branch,
        this.branchBIC,
        this.contactAddressLine1,
        this.contactAddressLine2,
        this.contactPostTown,
        this.contactPostcode,
        this.contactPhone,
        this.contactFax,
        this.fasterPaymentsSupported,
        this.cHAPSSupported});

  Items.fromJson(Map<String, dynamic> json) {
    isCorrect = json['IsCorrect'];
    isDirectDebitCapable = json['IsDirectDebitCapable'];
    statusInformation = json['StatusInformation'];
    correctedSortCode = json['CorrectedSortCode'];
    correctedAccountNumber = json['CorrectedAccountNumber'];
    iBAN = json['IBAN'];
    bank = json['Bank'];
    bankBIC = json['BankBIC'];
    branch = json['Branch'];
    branchBIC = json['BranchBIC'];
    contactAddressLine1 = json['ContactAddressLine1'];
    contactAddressLine2 = json['ContactAddressLine2'];
    contactPostTown = json['ContactPostTown'];
    contactPostcode = json['ContactPostcode'];
    contactPhone = json['ContactPhone'];
    contactFax = json['ContactFax'];
    fasterPaymentsSupported = json['FasterPaymentsSupported'];
    cHAPSSupported = json['CHAPSSupported'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsCorrect'] = this.isCorrect;
    data['IsDirectDebitCapable'] = this.isDirectDebitCapable;
    data['StatusInformation'] = this.statusInformation;
    data['CorrectedSortCode'] = this.correctedSortCode;
    data['CorrectedAccountNumber'] = this.correctedAccountNumber;
    data['IBAN'] = this.iBAN;
    data['Bank'] = this.bank;
    data['BankBIC'] = this.bankBIC;
    data['Branch'] = this.branch;
    data['BranchBIC'] = this.branchBIC;
    data['ContactAddressLine1'] = this.contactAddressLine1;
    data['ContactAddressLine2'] = this.contactAddressLine2;
    data['ContactPostTown'] = this.contactPostTown;
    data['ContactPostcode'] = this.contactPostcode;
    data['ContactPhone'] = this.contactPhone;
    data['ContactFax'] = this.contactFax;
    data['FasterPaymentsSupported'] = this.fasterPaymentsSupported;
    data['CHAPSSupported'] = this.cHAPSSupported;
    return data;
  }
}