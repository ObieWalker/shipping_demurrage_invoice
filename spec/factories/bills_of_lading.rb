FactoryBot.define do
  factory :bill_of_lading, class: 'BillOfLading' do
    initialize_with { BillOfLading.new(attributes) }
    id_bl { SecureRandom.random_number(1_000_000) }
    numero_bl { SecureRandom.alphanumeric(9).upcase }
    arrival_date { 5.days.ago.change(hour: 0) }
    freetime { 5 }
    nbre_20pieds_sec { 1 }
    nbre_40pieds_sec { 0 }
    nbre_20pieds_frigo { 0 }
    nbre_40pieds_frigo { 0 }
    nbre_20pieds_special { 0 }
    nbre_40pieds_special { 0 }
  end
end