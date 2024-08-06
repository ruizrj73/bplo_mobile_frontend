class DBScripts {

  String createUserTable() {
    return """CREATE TABLE IF NOT EXISTS mobileuser(
      id TEXT PRIMARY KEY,
      username TEXT,
      password TEXT,
      empId TEXT,
      firstname TEXT,
      middlename TEXT,
      lastname TEXT,
      suffix TEXT,
      email TEXT,
      contactnumber TEXT,
      clusterGroup TEXT,
      userType TEXT,
      typeId TEXT,
      typeName TEXT,
      allowOffline INTEGER,
      allowAttach INTEGER
    )""";
  }

  String createLineBusinessTable() {
    return """CREATE TABLE IF NOT EXISTS linebusiness(
      id TEXT PRIMARY KEY,
      code TEXT,
      description TEXT,
      status TEXT,
      sequence INTEGER
    )""";
  }

  String createModeOfPaymentTable() {
    return """CREATE TABLE IF NOT EXISTS modeofpayment(
      id TEXT PRIMARY KEY,
      payment_type TEXT,
      code TEXT
    )""";
  }

  String createStatusApplicationTable() {
    return """CREATE TABLE IF NOT EXISTS statusofapplication(
      id TEXT PRIMARY KEY,
      code TEXT,
      application_type TEXT,
      `group` TEXT
    )""";
  }

  String createTypeApplicationTable() {
    return """CREATE TABLE IF NOT EXISTS typeofapplication(
      id TEXT PRIMARY KEY,
      code TEXT,
      permit_type TEXT,
      `group` TEXT
    )""";
  }

  String createTypeBusinessTable() {
    return """CREATE TABLE IF NOT EXISTS typeofbusiness(
      id TEXT PRIMARY KEY,
      code TEXT,
      organization_type TEXT
    )""";
  }

  String createMeasurePaxTable() {
    return """CREATE TABLE IF NOT EXISTS measurepax(
      id TEXT PRIMARY KEY,
      code TEXT,
      description TEXT
    )""";
  }

  String createAppStatusTable() {
    return """CREATE TABLE IF NOT EXISTS appstatus(
      id TEXT PRIMARY KEY,
      connectivityStatus TEXT,
      attachmentStatus TEXT
    )""";
  }

  String createBusinessApplicationTable() {
    return """CREATE TABLE IF NOT EXISTS businessapplication(
      id TEXT PRIMARY KEY,
      transaction_no TEXT,
      user_id TEXT,
      user_name TEXT,
      application_type TEXT,
      payment_type TEXT,
      tax_year TEXT,
      organization_type TEXT,
      business_name TEXT,
      trade_name TEXT,
      business_started_date TEXT,
      business_permit_no TEXT,
      business_permit_issued_date TEXT,
      bir_permit_no TEXT,
      bir_issued_date TEXT,
      tin_no TEXT,
      dtiseccda_registration_date TEXT,
      dtiseccda_registration_no TEXT,
      ctc_no TEXT,
      ctc_issued_date TEXT,
      plate_no TEXT,
      signage_name TEXT,
      business_longitude TEXT,
      business_latitude TEXT,
      business_actual_address TEXT,
      remarks TEXT,
      application_status TEXT,
      created_by TEXT
    )""";
  }

  String createAttachmentTable() {
    return """CREATE TABLE IF NOT EXISTS attachment(
      id TEXT,
      xfile BLOB,
      file_type TEXT,
      file_name TEXT,
      file_description TEXT,
      file_url TEXT,
      remarks TEXT,
      status TEXT,
      baId TEXT
    )""";
  }

  String createBusinessOwnerInfoTable() {
    return """CREATE TABLE IF NOT EXISTS businessownerinfo(
      id TEXT,
      has_manager TEXT,
      is_same TEXT,
      first_name TEXT,
      middle_name TEXT,
      last_name TEXT,
      suffix TEXT,
      gender TEXT,
      corp_first_name TEXT,
      corp_middle_name TEXT,
      corp_last_name TEXT,
      corp_suffix TEXT,
      corp_gender TEXT,
      remarks TEXT,
      baId TEXT
    )""";
  }

  String createBusinessContactInfoTable() {
    return """CREATE TABLE IF NOT EXISTS businesscontactinfo(
      id TEXT,
      mobile_number TEXT,
      tel_fax_number TEXT,
      email_address TEXT,
      business_mobile_number TEXT,
      business_tel_fax_number TEXT,
      business_email_address TEXT,
      remarks TEXT,
      baId TEXT
    )""";
  }

  String createBusinessAddressInfoTable() {
    return """CREATE TABLE IF NOT EXISTS businessaddressinfo(
      id TEXT,
      region TEXT,
      province TEXT,
      city_municipality TEXT,
      barangay TEXT,
      zip_code TEXT,
      house_bldg_no TEXT,
      building_name TEXT,
      lot_unit_no TEXT,
      block_floor_no TEXT,
      street TEXT,
      subdivision TEXT,
      remarks TEXT,
      baId TEXT
    )""";
  }

  String createBusinessOwnerAddressInfoTable() {
    return """CREATE TABLE IF NOT EXISTS businessowneraddressinfo(
      id TEXT,
      is_same TEXT,
      region TEXT,
      province TEXT,
      city_municipality TEXT,
      barangay TEXT,
      zip_code TEXT,
      house_bldg_no TEXT,
      building_name TEXT,
      lot_unit_no TEXT,
      block_floor_no TEXT,
      street TEXT,
      subdivision TEXT,
      remarks TEXT,
      baId TEXT
    )""";
  }

  String createBusinessOperationInfoTable() {
    return """CREATE TABLE IF NOT EXISTS businessoperationinfo(
      id TEXT,
      business_activity TEXT,
      business_area REAL,
      total_floor_area REAL,
      number_male_employee INTEGER,
      number_female_employee INTEGER,
      total_number_employee_establishment INTEGER,
      total_number_employee_residing_lgu INTEGER,
      supervisor INTEGER,
      rank_and_file INTEGER,
      cashier INTEGER,
      on_field INTEGER,
      has_delivery_vehicles TEXT,
      total_delivery_vehicle_van_truck INTEGER,
      total_delivery_vehicle_motorcycle INTEGER,
      place_owned_rented TEXT,
      taxdec_number TEXT,
      property_index_number TEXT,
      government_tax_incentives_enjoy TEXT,
      community_tax_certificate TEXT,
      barangay_micro_business_enterprise_registered TEXT,
      bangko_sentral_registered TEXT,
      remarks TEXT,
      baId TEXT
    )""";
  }

  String createLineOfBusinessTable() {
    return """CREATE TABLE IF NOT EXISTS lineofbusiness(
      id TEXT,
      code TEXT,
      line_of_business TEXT,
      application_type TEXT,
      capital_investment REAL,
      gross_essential REAL,
      gross_non_essential REAL,
      units INTEGER,
      remarks TEXT,
      baId TEXT
    )""";
  }

  String createLineOfBusinessMeasurePaxTable() {
    return """CREATE TABLE IF NOT EXISTS lineofbusinessmeasurepax(
      id TEXT,
      line_of_business TEXT,
      measure_description TEXT,
      number_of_units INTEGER,
      capacity INTEGER,
      remarks TEXT,
      baId TEXT
    )""";
  }

  String createBusinessFindingsTable() {
    return """CREATE TABLE IF NOT EXISTS businessfindings(
      id TEXT,
      remarks TEXT,
      baId TEXT
    )""";
  }

  String createBusinessNoticeToComplyTable() {
    return """CREATE TABLE IF NOT EXISTS businessnoticetocomply(
      id TEXT,
      remarks TEXT,
      baId TEXT
    )""";
  }

  String createBusinessRemarksTable() {
    return """CREATE TABLE IF NOT EXISTS businessremarks(
      id TEXT,
      remarks TEXT,
      baId TEXT
    )""";
  }

  String createLessorInfoTable() {
    return """CREATE TABLE IF NOT EXISTS lessorinfo(
      id TEXT,
      first_name TEXT,
      middle_name TEXT,
      last_name TEXT,
      suffix TEXT,
      region TEXT,
      province TEXT,
      city_municipality TEXT,
      barangay TEXT,
      zip_code TEXT,
      house_bldg_no TEXT,
      building_name TEXT,
      lot_unit_no TEXT,
      block_floor_no TEXT,
      street TEXT,
      subdivision TEXT,
      mobile_number TEXT,
      tel_fax_number TEXT,
      email_address TEXT,
      remarks TEXT,
      baId TEXT
    )""";
  }

  String createBookkeeperInfoTable() {
    return """CREATE TABLE IF NOT EXISTS bookkeeperinfo(
      id TEXT,
      first_name TEXT,
      middle_name TEXT,
      last_name TEXT,
      suffix TEXT,
      mobile_number TEXT,
      tel_fax_number TEXT,
      email_address TEXT,
      accounting_audit_certificate TEXT,
      remarks TEXT,
      baId TEXT
    )""";
  }

  String createAccountingFirmInfoTable() {
    return """CREATE TABLE IF NOT EXISTS accountingfirminfo(
      id TEXT,
      name TEXT,
      address TEXT,
      mobile_number TEXT,
      tel_fax_number TEXT,
      email_address TEXT,
      accounting_audit_certificate TEXT,
      remarks TEXT,
      baId TEXT
    )""";
  }
}