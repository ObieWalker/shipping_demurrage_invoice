FactoryBot.define do
  factory :invoice, class: 'Invoice' do
    initialize_with { Invoice.new(attributes) }
    reference { SecureRandom.alphanumeric(10).upcase }
    numero_bl { 'BLX123456' }
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