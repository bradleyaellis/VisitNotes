class PatientsController < ApplicationController
  def index
    Rails.logger.debug Patient.all.inspect
    @patients = Patient.all
  end

  def show
    @patient = Patient.find_by(id: params[:id])
  end
end
