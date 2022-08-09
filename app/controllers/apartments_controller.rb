class ApartmentsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    apartments = Apartment.all
    render json: apartments
  end

  def show
    find_apartment
    render json: @apartment
  end

  def create
    apartment = Apartment.create!(apartment_params)
    render json: apartment, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  rescue
  end

  def destroy
    find_apartment
    @apartment.destroy
  end

  def update
    find_apartment
    @apartment.update!(apartment_params)
    render json: @apartment
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  rescue
  end

  private

  def find_apartment
    @apartment = Apartment.find(params[:id])
  end

  def apartment_params
    params.permit(:number)
  end

  def render_not_found_response
    render json: { error: "Apartment not found" }, status: :not_found
  end
end
