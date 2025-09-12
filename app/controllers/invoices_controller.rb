class InvoicesController < ApplicationController

  def overdue
    invoices = Invoice.overdue.order(due_date: :asc, id_facture: :asc)
    render json: invoices.map(&:as_json)
  end

  def generate
    result = Demurrage::InvoiceGenerator.new.call
    render json: {
      created: result.created_count,
      invoice_ids: result.created_ids,
      skipped_bl_numbers: result.skipped_bl_numbers
    }
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end
end
