require 'calculos'

class CalculosController < ApplicationController
  def performance
    valor_performance = Calculos.performance(params[:valor_meta].to_f, params[:valor_realizado].to_f)

    render json: { valor_performance: valor_performance }
  end
end
