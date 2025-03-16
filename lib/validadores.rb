class Validadores
  def match_periodo(periodo)
    case periodo
    when /(^(19|20)\d{2})((0[1-9])|(1[0-2])$)/ # YYYYMM
      format_str = '%Y%m'
    when /(^(19|20)\d{2})[\-]((0?[1-9]|1[012]){1}$)/ # YYYY-mm
      format_str = '%Y-%m'
    end

    Date.strptime(periodo, format_str)
  end

  def self.data(data)
    case data
    when /^(?:(?:19|20)\d{2})-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01])$/ # YYYY-MM-DD
      begin
        Date.strptime(data, '%Y-%m-%d') # Tenta converter para uma data válida
        true
      rescue ArgumentError
        false # Se der erro, a data é inválida
      end
    when /^(?:(?:19|20)\d{2})-(0[1-9]|1[0-2])$/ # YYYY-MM
      begin
        # Usando Date.strptime para o formato YYYY-MM
        # A data será convertida para o primeiro dia do mês (ex: '2021-05' será convertido para '2021-05-01')
        Date.strptime("#{data}-01", '%Y-%m-%d')
        true
      rescue ArgumentError
        false
      end
    when /^(?:(?:0[1-9]|[12][0-9]|3[01])\/(?:0[1-9]|1[0-2])\/(?:19|20)\d{2})$/ # DD/MM/YYYY
      begin
        Date.strptime(data, '%d/%m/%Y') # Tenta converter para uma data válida
        true
      rescue ArgumentError
        false # Se der erro, a data é inválida
      end
    else
      false
    end
  end

  def self.valor(valor)
    /([+-]?((\d+|\d{1,3}(\.\d{3})+)(\,\d*)?|\,\d+))%$/.match?(valor)
  end

  def self.email(email)
    /([A-Za-z0-9]+[._%+-]*[A-Za-z0-9]+)*@([A-Za-z0-9.-]+)\.([A-Za-z]{2,})/.match?(email)
  end
end
