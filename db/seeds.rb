cust = Customer.create!(id_client: 1, nom: 'Acme Corp', code_client: 'ACM')
bl = BillOfLading.create!(
  numero_bl: 'BL1234567',
  id_client: cust.id_client,
  arrival_date: 7.days.ago.change(hour: 0),
  freetime: 7,
  nbre_20pieds_sec: 1
)
puts "Seeded BL #{bl.numero_bl} for customer #{cust.nom}"