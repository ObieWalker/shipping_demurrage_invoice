class AddDueDateAndFkToInvoices < ActiveRecord::Migration[7.2]
  def change
    execute <<-SQL
      ALTER TABLE bl
      MODIFY numero_bl VARCHAR(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL;
    SQL

    execute <<-SQL
      ALTER TABLE facture
      MODIFY numero_bl VARCHAR(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL;
    SQL

    unless foreign_key_exists?(:facture, :bl, column: :numero_bl, name: :fk_facture_bl_numero)
      add_foreign_key :facture, :bl,
        column: :numero_bl,
        primary_key: :numero_bl,
        name: :fk_facture_bl_numero
    end
  end
end
