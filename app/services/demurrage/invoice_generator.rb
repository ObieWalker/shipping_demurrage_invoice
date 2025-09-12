module Demurrage
  class InvoiceGenerator
    FLAT_RATE = 80

    Result = Struct.new(:created_count, :created_ids, :skipped_bl_numbers, keyword_init: true)

    def call(run_date: Date.current)
      created_ids = []
      skipped = []

      BillOfLading.overdue_today.find_each do |bl|
        # Skip if any open invoice exists for this BL
        if Invoice.where(numero_bl: bl.numero_bl).where.not(statut: 'paid').exists?
          skipped << bl.numero_bl
          next
        end

        containers = bl.containers_count
        next if containers.zero?

        amount_usd = containers * FLAT_RATE

        inv = Invoice.create!(
          reference: SecureRandom.alphanumeric(10).upcase,
          numero_bl: bl.numero_bl,
          code_client: bl.customer&.code_client || bl.consignee_code || 'UNKNOWN',
          nom_client: bl.customer&.nom || bl.consignee_name || 'UNKNOWN',
          montant_facture: amount_usd,
          montant_orig: amount_usd,
          devise: 'USD',
          statut: 'init',
          date_facture: run_date,
          id_utilisateur: 0,
          create_type_utilisateur: 'system',
          created_at: Time.current
        )
        created_ids << inv.id_facture
      end

      Result.new(created_count: created_ids.size, created_ids: created_ids, skipped_bl_numbers: skipped)
    end
  end
end
