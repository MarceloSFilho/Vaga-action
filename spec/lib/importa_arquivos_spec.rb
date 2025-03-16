require 'rails_helper'
require 'csv'
require 'validadores'
require 'resultados'

include ActionDispatch::TestProcess::FixtureFile

RSpec.describe Validadores, type: :lib do
  describe "Importando arquivos" do
    let(:arquivo_valido) { { file: fixture_file_upload('arquivo_valido.csv', 'text/csv') } }
    let(:arquivo_invalido) { { file: fixture_file_upload('arquivo_invalido.csv', 'text/csv') } }

    context "Arquivo valido" do
      it "validando datas" do
        @file = File.open(arquivo_valido[:file])

        CSV.foreach(@file, {headers: true, header_converters: :symbol, col_sep: ';'}) do |row|
          break unless Validadores.data(row[:periodo])
          cliente = Cliente.create!(nome: row[:cliente])
          cliente.resultado.create!(periodo: row[:periodo], valor_meta: row[:valor_meta], valor_realizado: row[:valor_realizado])
        end

        expect(Cliente.all.size).to eq(3)
      end

      it "salva arquivo na base e calcula performance total" do
        @file = File.open(arquivo_valido[:file])

        # Processando o arquivo e salvando os dados no banco
        CSV.foreach(@file, {headers: true, header_converters: :symbol, col_sep: ';'}) do |row|
          cliente = Cliente.create!(nome: row[:cliente])
          cliente.resultado.create!(periodo: row[:periodo], valor_meta: row[:valor_meta], valor_realizado: row[:valor_realizado])
        end

        # Verificando se os registros foram salvos corretamente
        expect(Cliente.count).to eq(3)  # Número de clientes esperados no arquivo
        expect(Resultado.count).to eq(3)  # Número de resultados esperados no arquivo

        # Agora calculando a performance total
        total_performance = 0
        Cliente.find_each do |cliente|
          cliente.resultado.each do |resultado|
            total_performance += (resultado.valor_realizado.to_f / resultado.valor_meta.to_f) if resultado.valor_meta > 0
          end
        end

        # Espera-se que a performance total seja calculada corretamente
        expect(total_performance.round(2)).to eq(2.28)  # Altere conforme o esperado, isso depende dos valores no arquivo
      end
    end

    context "Arquivo invalido" do
      it "validando datas" do
        # Coloque a lógica do seu arquivo inválido aqui
        # Como a data no arquivo está inválida, espera-se que a validação falhe.

        File.open(arquivo_invalido[:file]) do |file|
          # Processando o arquivo e validando os dados antes de salvar
          CSV.foreach(file, {headers: true, header_converters: :symbol, col_sep: ';'}) do |row|
            # Verifica se a data e o valor são válidos antes de inserir no banco
            if Validadores.data(row[:periodo]) && Validadores.valor(row[:valor_meta])
              cliente = Cliente.create!(nome: row[:cliente])
              cliente.resultado.create!(periodo: row[:periodo], valor_meta: row[:valor_meta], valor_realizado: row[:valor_realizado])
            end
          end
        end

        # Espera-se que o banco não tenha registros após o processamento de um arquivo inválido
        expect(Cliente.count).to eq(0)  # Nenhum cliente deve ser inserido
        expect(Resultado.count).to eq(0)  # Nenhum resultado deve ser inserido
      end
    end
  end
end
