# frozen_string_literal: true

module Admin
  class MlModelsController < AdminController
    before_action :set_model, only: %i[show edit update destroy]
    before_action :authorize_ml_model

    before_action -> { define_model_name('ml_model') }
    before_action -> { fetch_admin_comments(@ml_model) }, only: :show

    def index
      @pagy, @ml_models = pagy(MlModel.includes(:account).all)
    end

    def show; end

    def new
      @ml_model = MlModel.new
    end

    def create
      @ml_model = MlModel.new(ml_model_params)

      if @ml_model.save
        redirect_to [:admin, @ml_model], notice: t(:create, model:)
      else
        render :new, status: :unprocessable_entity, alert: t(:failed_create, model:)
      end
    end

    def edit; end

    def update
      if @ml_model.update(ml_model_params)
        redirect_to [:admin, @ml_model], notice: t(:update, model:)
      else
        render :edit, status: :unprocessable_entity, alert: t(:failed_update, model:)
      end
    end

    def destroy
      @ml_model.destroy
      redirect_to %i[admin ml_models]
    end

    def prediction
      @prediction = 123
    end

    private

    def set_model
      @ml_model = MlModel.find(params[:id])
    end

    def authorize_ml_model
      authorize @ml_model, policy_class: Admin::MlModelPolicy
    end

    def ml_model_params
      params.require(:ml_model)
            .permit(
              :title, :explanation, :description, :notebook, :notebook_html, :model_diagram,
              :model_type, parameters_with_order: []
            )
            .merge(account: current_account)
    end
  end
end
