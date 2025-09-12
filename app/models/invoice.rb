class Invoice < ApplicationRecord
  self.table_name = "facture"
  self.primary_key = "id_facture"

  alias_attribute :amount, :montant_facture
  alias_attribute :currency, :devise
  alias_attribute :status, :statut
  alias_attribute :number, :numero_bl

  belongs_to :bill_of_lading, primary_key: :numero_bl, foreign_key: :numero_bl
  belongs_to :customer, primary_key: :code_client, foreign_key: :code_client, optional: true

  validates :numero_bl, :reference, :montant_facture, :statut, :date_facture, :created_at, presence: true
  validates :due_date, presence: true

  before_validation :ensure_due_date

  scope :unpaid, -> { where.not(statut: "paid") }
  scope :overdue, -> { unpaid.where("due_date < ?", Date.current) }

  # Set 15 days fixed term
  def ensure_due_date
    self.due_date ||= (created_at || Time.current).to_date + 15.days
  end

  def as_json(_opts = {})
    {
      id: id_facture,
      reference: reference,
      bl_number: numero_bl,
      customer_code: code_client,
      customer_name: nom_client,
      amount: montant_facture.to_f,
      currency: devise,
      status: statut,
      issued_at: date_facture,
      due_date: due_date
    }
  end
end