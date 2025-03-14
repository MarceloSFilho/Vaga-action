class Calculos
  def self.performance(valor_meta, valor_realizado)
    valor_meta.zero? ? 0 : (valor_realizado / valor_meta)
  end
end
