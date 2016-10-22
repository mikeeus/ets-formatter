require 'csv'
desc "imports csv file"
task :import_tariff_rates => :environment do

  if Hscode.count == 0
    Hscode.create!(
      code: 0,
      description: "Hscode not found"
    )
  end
  
  CSV.foreach('db/records/rates.csv', headers: true, 
    encoding: 'windows-1251:UTF-8') do |row|

    hscode_hash = row.to_hash
    hscode = Hscode.find_by(code: hscode_hash['code'])

    hscode_record = {
      code: hscode_hash['code'],
      description: hscode_hash['description'],
      unit: hscode_hash['unit'].nil? ? '' : hscode_hash['unit'],
      special_permission: hscode_hash['special_permission'].nil? ? 
        '' : hscode_hash['special_permission'],
      duty: hscode_hash['duty'],
      excise: hscode_hash['excise'],
      vat: hscode_hash['vat'],
      sur: hscode_hash['sur'],
      withhold: hscode_hash['withhold'],
      ss1: hscode_hash['ss1'],
      ss2: hscode_hash['ss2'],
    }
    if hscode
      hscode.update_attributes(
        hscode_record
      )
    else
      Hscode.create!(
        hscode_record
      )
    end
  end 
end
