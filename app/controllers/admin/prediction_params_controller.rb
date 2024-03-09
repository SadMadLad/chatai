# frozen_string_literal: true

module Admin
  class PredictionParamsController < AdminController
    before_action :set_ml_model, only: %i[new create edit update]
    before_action :set_prediction_param, only: %i[show edit update destroy]
    before_action :authorize_prediction_param

    before_action -> { define_model_name('prediction param') }
    before_action -> { fetch_admin_comments(@prediction_param) }, only: :show

    def index
      @pagy, @prediction_params = pagy(PredictionParam.includes(:ml_model).all)
    end

    def show
      @ml_model = @prediction_param.ml_model
    end

    def new
      @prediction_param = PredictionParam.new(name: params[:name])
    end

    def edit; end

    def create
      @prediction_param = PredictionParam.new(ml_model: @ml_model, **prediction_param_params)

      if @prediction_param.save
        respond_to { |format| format.turbo_stream }
      else
        render :new, status: :unprocessable_entity, alert: t(:failed_create, model:)
      end
    end

    def update
      if @prediction_param.update(prediction_param_params)
        redirect_to [:admin, @ml_model], notice: t(:update, model:)
      else
        render :edit, status: :unprocessable_entity, alert: t(:failed_update, model:)
      end
    end

    def destroy
      @prediction_param.destroy

      redirect_to [:admin, @ml_model], notice: t(:destroy, model:)
    end

    private

    def prediction_param_params
      params.require(:prediction_param).permit(:name, :param_type, :description, possible_values: [])
    end

    def set_ml_model
      @ml_model = MlModel.find(params[:ml_model_id])
    end

    def set_prediction_param
      @prediction_param = PredictionParam.find(params[:id])
    end

    def authorize_prediction_param
      authorize @prediction_param, policy_class: Admin::PredictionParamPolicy
    end
  end
end
