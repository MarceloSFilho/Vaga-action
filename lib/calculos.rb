class Calculos
  def self.performance(valor_meta, valor_realizado)
    return 0 if valor_meta.nil?  # Verifica se valor_meta é nil e retorna 0
    valor_meta.zero? ? 0 : (valor_realizado / valor_meta)
  end
end
