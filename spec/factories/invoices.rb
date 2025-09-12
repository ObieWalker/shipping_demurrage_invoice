FactoryBot.define do
  factory :invoice, class: 'Invoice' do
    association :bill_of_lading
    numero_bl { bill_of_lading.numero_bl }
    initialize_with { Invoice.new(attributes) }
    reference { "INV#{SecureRandom.hex(2)}" }
    code_client { 'C123' }
    nom_client { 'Acme Corp' }
    montant_facture { 160 }
    montant_orig { 160 }
    devise { 'USD' }
    statut { 'init' }
    date_facture { Date.current }
    id_utilisateur { 0 }
    create_type_utilisateur { 'system' }
    created_at { Time.current }
    due_date { Date.current + 15.days }
  end
end
