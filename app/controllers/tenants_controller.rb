class TenantsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    tenants = Tenant.all
    render json: tenants
  end

  def show
    find_tenant
    render json: @tenant
  end

  def create
    tenant = Tenant.create!(tenant_params)
    render json: tenant, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  rescue
  end

  def update
    find_tenant
    @tenant.update!(tenant_params)
    render json: @tenant
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  rescue
  end

  def destroy
    find_tenant
    @tenant.destroy
  end

  private

  def find_tenant
    @tenant = Tenant.find(params[:id])
  end

  def tenant_params
    params.permit(:name, :age)
  end

  def render_not_found_response
    render json: { error: "Tenant not found" }, status: :not_found
  end
end
