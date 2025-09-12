require 'rails_helper'

RSpec.describe Demurrage::InvoiceGenerator do
  let(:service) { described_class.new }

  it 'creates an invoice for BLs due today and skips ones with open invoice' do
    bl_due_today = create(:bill_of_lading, arrival_date: 7.days.ago, freetime: 7, nbre_20pieds_sec: 2)
    _not_due = create(:bill_of_lading, arrival_date: 3.days.ago, freetime: 7)

    bl_skip = create(:bill_of_lading, arrival_date: 10.days.ago, freetime: 10, nbre_20pieds_sec: 1)
    create(:invoice, bill_of_lading: bl_skip, statut: 'init')

    result = service.call

    expect(result.created_count).to eq(1)
    expect(result.skipped_bl_numbers).to include(bl_skip.numero_bl)
    inv = Invoice.find(result.created_ids.first)
    expect(inv.montant_facture.to_f).to eq(2 * 80.0)
    expect(inv.devise).to eq('USD')
    expect(inv.statut).to eq('init')
  end

  it 'does nothing when containers_count is zero' do
    bl = create(:bill_of_lading, arrival_date: 5.days.ago, freetime: 5,
               nbre_20pieds_sec: 0, nbre_40pieds_sec: 0, nbre_20pieds_frigo: 0,
               nbre_40pieds_frigo: 0, nbre_20pieds_special: 0, nbre_40pieds_special: 0)
    result = service.call
    expect(result.created_count).to eq(0)
  end
end
