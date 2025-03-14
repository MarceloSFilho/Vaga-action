class Resultado < ApplicationRecord
  belongs_to :cliente
  validates :valor_meta, :valor_realizado, :cliente_id, presence: true
end
