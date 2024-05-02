# frozen_string_literal: true

class MlModelsController < AuthenticatedController
  def index
    @ml_models = Ai::MlModel.include(:account).all
  end

  def show
    @ml_model = Ai::MlModel.find(params[:id])
  end

  def predication
    @prediction = 123
  end
end
