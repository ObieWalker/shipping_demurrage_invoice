class RefundRequest < ApplicationRecord
  self.table_name = "remboursement"
  self.primary_key = "id_remboursement"

  alias_attribute :number, :numero_bl

  belongs_to :bill_of_lading, primary_key: :numero_bl, foreign_key: :numero_bl, optional: true
end
