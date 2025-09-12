class Customer < ApplicationRecord
  self.table_name = "client"
  self.primary_key = "id_client"

  alias_attribute :name, :nom
  alias_attribute :code, :code_client

  has_many :bills_of_lading, foreign_key: :id_client
  has_many :invoices, primary_key: :code_client, foreign_key: :code_client
end
