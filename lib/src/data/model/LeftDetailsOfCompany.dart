class LeftDataOfCompanies {
  int? _id;
  String? _whatDistinguishUs;
  String? _secondWebsite;
  String? _authorizedPersonFunction;
  String? _secondMobile;
  String? _thirdWebsite;
  String? _secondEmail;
  String? _secondPhone;
  String? _certificates;
  String? _thirdMobile;
  String? _thirdEmail;
  String? _thirdPhone;
  String? _companyId;
  String? _administrationAddress;
  String? _instagram;
  String? _hotLine;
  String? _facebook;
  String? _twitter;
  String? _commercialRegister;
  String? _authorizedPerson;
  String? _firstWebsite;
  String? _firstMobile;
  String? _companyInfo;
  String? _dateCreated;
  String? _taxCard;
  String? _address;
  String? _createdAt;
  String? _updatedAt;
  String? _services;

  int? get id => _id;

  String? get whatDistinguishUs => _whatDistinguishUs;

  String? get secondWebsite => _secondWebsite;

  String? get authorizedPersonFunction => _authorizedPersonFunction;

  String? get secondMobile => _secondMobile;

  String? get thirdWebsite => _thirdWebsite;

  String? get secondEmail => _secondEmail;

  String? get secondPhone => _secondPhone;

  String? get certificates => _certificates;

  String? get thirdMobile => _thirdMobile;

  String? get thirdEmail => _thirdEmail;

  String? get thirdPhone => _thirdPhone;

  String? get companyId => _companyId;

  String? get administrationAddress => _administrationAddress;

  String? get instagram => _instagram;

  String? get hotLine => _hotLine;

  String? get facebook => _facebook;

  String? get twitter => _twitter;

  String? get commercialRegister => _commercialRegister;

  String? get authorizedPerson => _authorizedPerson;

  String? get firstWebsite => _firstWebsite;

  String? get firstMobile => _firstMobile;

  String? get companyInfo => _companyInfo;

  String? get dateCreated => _dateCreated;

  String? get taxCard => _taxCard;

  String? get address => _address;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  String? get services => _services;

  LeftDataOfCompanies(
      {int? id,
        String? whatDistinguishUs,
        String? secondWebsite,
        String? authorizedPersonFunction,
        String? secondMobile,
        String? thirdWebsite,
        String? secondEmail,
        String? secondPhone,
        String? certificates,
        String? thirdMobile,
        String? thirdEmail,
        String? thirdPhone,
        String? companyId,
        String? administrationAddress,
        String? instagram,
        String? hotLine,
        String? facebook,
        String? twitter,
        String? commercialRegister,
        String? authorizedPerson,
        String? firstWebsite,
        String? firstMobile,
        String? companyInfo,
        String? dateCreated,
        String? taxCard,
        String? address,
        String? createdAt,
        String? updatedAt,
        String? services}) {
    _id = id;
    _whatDistinguishUs = whatDistinguishUs;
    _secondWebsite = secondWebsite;
    _authorizedPersonFunction = authorizedPersonFunction;
    _secondMobile = secondMobile;
    _thirdWebsite = thirdWebsite;
    _secondEmail = secondEmail;
    _secondPhone = secondPhone;
    _certificates = certificates;
    _thirdMobile = thirdMobile;
    _thirdEmail = thirdEmail;
    _thirdPhone = thirdPhone;
    _companyId = companyId;
    _administrationAddress = administrationAddress;
    _instagram = instagram;
    _hotLine = hotLine;
    _facebook = facebook;
    _twitter = twitter;
    _commercialRegister = commercialRegister;
    _authorizedPerson = authorizedPerson;
    _firstWebsite = firstWebsite;
    _firstMobile = firstMobile;
    _companyInfo = companyInfo;
    _dateCreated = dateCreated;
    _taxCard = taxCard;
    _address = address;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _services = services;
  }

  LeftDataOfCompanies.fromJson(dynamic json) {
    _id = json["id"];
    _whatDistinguishUs = json["what_distinguish_us"];
    _secondWebsite = json["second_website"];
    _authorizedPersonFunction = json["authorized_person_function"];
    _secondMobile = json["second_mobile"];
    _thirdWebsite = json["third_website"];
    _secondEmail = json["second_email"];
    _secondPhone = json["second_phone"];
    _certificates = json["certificates"];
    _thirdMobile = json["third_mobile"];
    _thirdEmail = json["third_email"];
    _thirdPhone = json["third_phone"];
    _companyId = json["company_id"];
    _administrationAddress = json["administration_address"];
    _instagram = json["instagram"];
    _hotLine = json["hot_line"];
    _facebook = json["facebook"];
    _twitter = json["twitter"];
    _commercialRegister = json["commercial_register"];
    _authorizedPerson = json["authorized_person"];
    _firstWebsite = json["first_website"];
    _firstMobile = json["firstMobile"];
    _companyInfo = json["company_info"];
    _dateCreated = json["date_created"];
    _taxCard = json["tax_card"];
    _address = json["address"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _services = json["services"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    // map["id"] = _id;
    // map["company_id"] = _companyId;
    map["what_distinguish_us"] = _whatDistinguishUs;
    map["second_website"] = _secondWebsite;
    map["authorized_person_function"] = _authorizedPersonFunction;
    map["second_mobile"] = _secondMobile;
    map["third_website"] = _thirdWebsite;
    map["second_email"] = _secondEmail;
    map["second_phone"] = _secondPhone;
    map["certificates"] = _certificates;
    map["third_mobile"] = _thirdMobile;
    map["third_email"] = _thirdEmail;
    map["third_phone"] = _thirdPhone;
    map["firstMobile"] = _firstMobile;
    map["administration_address"] = _administrationAddress;
    map["instagram"] = _instagram;
    map["hot_line"] = _hotLine;
    map["facebook"] = _facebook;
    map["twitter"] = _twitter;
    map["commercial_register"] = _commercialRegister;
    map["authorized_person"] = _authorizedPerson;
    map["first_website"] = _firstWebsite;
    map["first_mobile"] = _firstMobile;
    map["company_info"] = _companyInfo;
    map["date_created"] = _dateCreated;
    map["tax_card"] = _taxCard;
    map["address"] = _address;
    map["services"] = _services;
    return map;
  }
}
