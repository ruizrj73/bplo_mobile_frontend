class DBScripts {
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
      tin_no TEXT,
      dtiseccda_registration_date TEXT,
      dtiseccda_registration_no TEXT,
      remarks TEXT,
      application_status TEXT
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
      first_name TEXT,
      middle_name TEXT,
      last_name TEXT,
      suffix TEXT,
      gender TEXT,
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
      line_of_business TEXT,
      application_type TEXT,
      capital_investment REAL,
      gross_essential REAL,
      gross_non_essential REAL,
      measure_description TEXT,
      number_of_units INTEGER,
      capacity INTEGER,
      remarks TEXT,
      baId TEXT
    )""";
  }
}