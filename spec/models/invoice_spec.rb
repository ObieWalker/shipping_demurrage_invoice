require 'rails_helper'

RSpec.describe Invoice, type: :model do
  it 'requires due_date' do
    inv = build(:invoice, due_date: nil)
    expect(inv.valid?).to be true
    expect(inv.due_date).to eq((inv.created_at.to_date + 15.days))
  end

  it 'overdue scope returns unpaid with due_date < today' do
    overdue = create(:invoice, statut: 'init', due_date: Date.yesterday)
    _paid   = create(:invoice, statut: 'paid', due_date: Date.yesterday)
    _future = create(:invoice, statut: 'init', due_date: Date.tomorrow)
    expect(Invoice.overdue).to contain_exactly(overdue)
  end
end