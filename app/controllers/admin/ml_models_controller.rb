# frozen_string_literal: true

module Admin
  class MlModelsController < AdminController
    layout 'admin', except: :notebook_html

    before_action :set_model, only: %i[show edit update destroy prediction notebook_html]
    before_action :authorize_ml_model

    before_action -> { define_model_name('ml_model') }
    before_action -> { fetch_admin_comments(@ml_model) }, only: :show

    def index
      @pagy, @ml_models = pagy(MlModel.includes(:account).all)
    end

    def show
      @prediction_params = @ml_model.prediction_params
      @prediction_params_names = @prediction_params.pluck(:name)
    end

    def new
      @ml_model = MlModel.new
    end

    def edit; end

    def create
      @ml_model = MlModel.new(ml_model_params)

      if @ml_model.save
        redirect_to [:admin, @ml_model], notice: t(:create, model:)
      else
        render :new, status: :unprocessable_entity, alert: t(:failed_create, model:)
      end
    end

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
      @response = Clients::ApiClient.new(ml_model: @ml_model).prediction(prediction_params)
      @prediction = JSON.parse(@response.body).first
    end

    def notebook_html
      client = Clients::ApiClient.new.client
      @html = client.get("ml_models/#{@ml_model.id}/notebook_html").body

      render inline: @html
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
              :model_type, :identifier, parameters_with_order: []
            )
            .merge(account: current_account)
    end

    def prediction_params
      params.require(:prediction).permit(*@ml_model.parameters_with_order).compact_blank
    end
  end
end
