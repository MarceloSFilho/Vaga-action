require 'rails_helper'
require 'validadores'

RSpec.describe Validadores, type: :lib do
  describe "Validadores" do
    context "data" do
      it "valida uma data válida" do
        data_valida = Validadores.data('31/12/2025')
        expect(data_valida).to eq(true)
      end

      it "não valida uma data inválida com dia inexistente" do
        data_invalida = Validadores.data('31/02/2025')
        expect(data_invalida).to eq(false)
      end

      it "não valida uma data com mês inválido" do
        data_invalida = Validadores.data('31/13/2025')
        expect(data_invalida).to eq(false)
      end

      it "não valida uma data com dia inválido (ex: 32)" do
        data_invalida = Validadores.data('32/12/2025')
        expect(data_invalida).to eq(false)
      end

      it "valida uma data no formato correto mesmo com mês de 30 dias" do
        data_valida = Validadores.data('30/04/2025')
        expect(data_valida).to eq(true)
      end

      it "valida uma data no formato correto mesmo com mês de 31 dias" do
        data_valida = Validadores.data('31/01/2025')
        expect(data_valida).to eq(true)
      end

      it "não valida uma data no formato errado (exemplo: 2025/12/31)" do
        data_invalida = Validadores.data('2025/12/31')
        expect(data_invalida).to eq(false)
      end

      it "validador data (YYYY-MM-DD)" do
        data = Validadores.data('2019-12-31')
        expect(data).to eq(true)
      end

      it "validador data (YYYY-MM)" do
        data_valida = Validadores.data('2021-05')
        expect(data_valida).to eq(true)

        data_invalida_1 = Validadores.data('2021-13')
        expect(data_invalida_1).to eq(false)

        data_invalida_2 = Validadores.data('2021-00')
        expect(data_invalida_2).to eq(false)
      end
    end

    context "número" do
      it "validador número percentual" do
        percentual_valido = '50%'
        expect(Validadores.valor(percentual_valido)).to eq(true)

        percentual_invalido_1 = '-50%'
        expect(Validadores.valor(percentual_invalido_1)).to eq(true)

        percentual_invalido_2 = '50'
        expect(Validadores.valor(percentual_invalido_2)).to eq(false)

        percentual_invalido_3 = '150%'
        expect(Validadores.valor(percentual_invalido_3)).to eq(true)
      end
    end

    context "diversos" do
      it "validador e-mail" do
        email_valido = 'teste@dominio.com'
        expect(Validadores.email(email_valido)).to eq(true)

        email_invalido_1 = 'teste@dominio'
        expect(Validadores.email(email_invalido_1)).to eq(false)

        email_invalido_2 = 'testedominio.com'
        expect(Validadores.email(email_invalido_2)).to eq(false)

        email_invalido_3 = 'teste@dominio!com'
        expect(Validadores.email(email_invalido_3)).to eq(false)
      end
    end
  end
end
