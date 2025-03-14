class Resultados
  attr_accessor :valor_meta, :valor_realizado, :valor_performance

  def initialize()
    @valor_meta = valor_meta
    @valor_realizado = valor_realizado
  end

  def calcula_performance
    return nil if valor_meta.nil? || valor_meta.zero?
    return 1 if valor_realizado.to_f.zero?
    valor_realizado / valor_meta
  end

  def calcula_realizado
    return 1 if valor_realizado.to_f.zero?
    valor_meta * valor_peformance
  end
end
