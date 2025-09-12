require 'rails_helper'

RSpec.describe 'Invoices API', type: :request do
  describe 'GET /invoices/overdue' do
    it 'returns overdue unpaid invoices' do
      create(:invoice, statut: 'init', due_date: Date.yesterday)
      create(:invoice, statut: 'paid', due_date: Date.yesterday)
      get '/invoices/overdue'
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json.size).to eq(1)
      expect(json.first['status']).to eq('init')
    end
  end

  describe 'POST /invoices/generate' do
    it 'returns summary of created invoices' do
      bl = create(:bill_of_lading, arrival_date: 4.days.ago, freetime: 4, nbre_20pieds_sec: 1)
      post '/invoices/generate'
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['created']).to eq(1)
      expect(json['invoice_ids']).not_to be_empty
      expect(Invoice.find(json['invoice_ids'].first).numero_bl).to eq(bl.numero_bl)
    end
  end
end