class UsersController < ApplicationController
  include Pagy::Backend

  before_action :authorize_admin, only: [:index]

  def index
    # Main view with Tabulator table
  end

  def table_data
    # JSON endpoint for Tabulator with pagination - skip authorization since it's already checked in index
    @pagy, @users = pagy(User.order(created_at: :desc), items: params[:size] || 25, page: params[:page] || 1)

    render json: {
      data: @users.as_json(only: [:id, :username, :email, :role, :created_at], methods: []),
      last: @pagy.last
    }
  end

  private

  def authorize_admin
    authorize User
  end
end
