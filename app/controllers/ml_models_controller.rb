# frozen_string_literal: true

# Controller for Machine Learning Models. This is for normal users only.
class MlModelsController < AuthenticatedController
  def index
    @ml_models = MlModel.include(:account).all
  end

  def show
    @ml_model = MlModel.find(params[:id])
  end

  def predication
    @prediction = 123
  end
end
