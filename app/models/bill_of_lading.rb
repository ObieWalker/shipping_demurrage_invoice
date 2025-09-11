class BillOfLading < ApplicationRecord
  self.table_name = 'bl'
  self.primary_key = 'id_bl'

  alias_attribute :number, :numero_bl
  alias_attribute :arrival_at, :arrival_date
  alias_attribute :free_time_days, :freetime

  belongs_to :customer, foreign_key: :id_client, optional: true
  has_many :invoices, foreign_key: :numero_bl, primary_key: :numero_bl

  validates :numero_bl, presence: true, length: { maximum: 9 }

  def containers_count
    [
      nbre_20pieds_sec,
      nbre_40pieds_sec,
      nbre_20pieds_frigo,
      nbre_40pieds_frigo,
      nbre_20pieds_special,
      nbre_40pieds_special
    ].compact.sum
  end

  def arrival_date_safe
    arrival_date&.to_date.presence
  end

  def due_date
    return nil if arrival_date_safe.nil? || free_time_days.nil?
    arrival_date_safe + free_time_days.days
  end

  scope :overdue_today, -> {
    today = Date.current
    where.not(arrival_date: nil)
      .where.not(freetime: nil)
      .select('*')
      .where(Arel.sql("DATE(arrival_date) + INTERVAL freetime DAY = DATE('#{today}')"))
  }
end
