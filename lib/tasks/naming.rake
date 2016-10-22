desc "Format import and export country names"
task country_names: :environment do
  
  def format_country_name(country)
    country[:incorrect].each do |incorr|
      Import.where(country_origin: "#{incorr}").each do |im|
        im.update_attribute(:country_origin, country[:correct])
      end
      Import.where(country_consignment: "#{incorr}").each do |im|
        im.update_attribute(:country_consignment, country[:correct])
      end
      Export.where(destination: incorr).each do |ex|
        ex.update_attribute(:destination, country[:correct])
      end
    end
  end

  afghanistan = {incorrect: ["Afganistan"], correct: "Afghanistan"}
  antigua = {incorrect: ["Antigua And Barbuda"], correct: "Antigua and Barbuda"}
  congo = {incorrect: ["Democratic republic of the Congo"], correct: "Congo"}
  cote_d_ivoire = {incorrect: ["Cote d'Ivoire", "Cote D'ivoire", "Cote d&#39;Ivoire"], correct: "Ivory Coast"}
  yemen = {incorrect: ["Democratic Yemen"], correct: "Yemen"}
  el_savador = {incorrect: ["Elsalvador"], correct: "El Salvador"}
  germany = {incorrect: ["United Germany"], correct: "Germany"}
  iran = {incorrect: ["Iran, Islamic Republic of", "Iran (Islamic Republic Of)", "Iran Islamic Republic of"], correct: "Iran"}
  south_korea = {incorrect: ["Korea, Democratic People's Rep. of", "Korea, Democratic People's Rep.", "Korea Dem.People's Rep. Of", 
    "Korea Democratic People&#39;s Rep. of", "Korea  Dem.People&#39;s Rep. Of", "Korea Democratic People's Rep.", "Korea Republic Of", "Korea Republic of",  "Korea, Republic of", "Korea  Republic Of"], correct: "South Korea"}
  lao = {incorrect: ["Lao", "Lao People's Dem. Republic", "Lao People&#39;s Democratic Republic", "Lao People's Democratic Republi", "Lao People&#39;s Democratic Republic"], correct: "Laos"}
  libya = {incorrect: ["Libyan Arab Jamahiriya", "Lybian Arab Jamahiriya"], correct: "Libya"}
  micronesia = {incorrect: ["Micronesia Federated States of"], correct: "Micronesia"}
  moldova = {incorrect: ["Republic of Moldova"], correct: "Moldova"}
  russia = {incorrect: ["Russian Federation", "Union Of Soviet Socialist Rep."], correct: "Russia"}
  st_helena = {incorrect: ["St. Helena"], correct: "Saint Helena"}
  kitts_nevis = {incorrect: ["Saint Kitts And Nevis"], correct: "Saint Kitts and Nevis" }
  vincent_grenadines = {incorrect: ["Saint Vincent And Grenadines"], correct: "Saint Vincent and the Grenadines"}
  pierre_miquelon= {incorrect: ["St. Pierre Et Miquelon"], correct: "Saint Pierre Et Miquelon"}
  syria = {incorrect: ["Syrian Arab Republic"], correct: "Syria"}
  taiwan = {incorrect: ["Taiwan, Province of China", "Taiwan Province of China"], correct: "Taiwan"}
  tanzania = {incorrect: ["United Republic of Tanzania"], correct: "Tanzania"}
  macedonia = {incorrect: ["The former Yugoslav Rep. Macedonia", "The former Yugoslav Rep. Macedo"], correct: "Macedonia"}
  trinidad = {incorrect: ["Trinidad & Tobago"], correct: "Trinidad and Tobago"}
  turks = {incorrect: ["Turks And Caicos Islands"], correct: "Turks and Caicos Islands"}
  us_virgin_islands = {incorrect: ["Virgin Islands U.S."], correct: "United States Virgin Islands"}
  slovenia = {incorrect: ["Sloviena"], correct: "Slovenia"}
  ukraine = {incorrect: ["Ukrain"], correct: "Ukraine"}
  uk = {incorrect: ["Great Britain"], correct: "United Kingdom"}
  guinea = {incorrect: ["Guinea Bissau", "GuineaBissau"], correct: "Guinea-Bissau"}
  wallis = {incorrect: ["Wallis And Futuna Islands"], correct: "Wallis and Futuna Islands"}
  christmas = {incorrect: ["Christmas Island[Australia]"], correct: "Christmas Island (Australia)"}


  countries = [afghanistan, antigua, congo, cote_d_ivoire, yemen, el_savador, germany, iran, south_korea, lao, libya, micronesia, moldova, russia, st_helena, kitts_nevis, vincent_grenadines, pierre_miquelon, syria, taiwan, tanzania, macedonia, trinidad, turks, us_virgin_islands, slovenia, ukraine, uk, guinea, wallis, christmas]

  countries.each do |c|
    format_country_name(c)
  end

end