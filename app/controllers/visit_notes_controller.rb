class VisitNotesController < ApplicationController
  before_action :set_visit_note, only: [:show, :edit, :update, :destroy]

  def index
    @visit_notes = VisitNote.where(patient_id: params[:patient_id])
  end

  def show
  end

  def new
    @visit_note = VisitNote.new
  end

  def edit
  end

  def create
    @visit_note = VisitNote.new(visit_note_params)
    @visit_note.patient_id = params[:patient_id]

    respond_to do |format|
      if @visit_note.save
        return if params[:quicksave]

        format.html { redirect_to @visit_note, notice: "Visit note was successfully created." }
        format.json { render :show, status: :created, location: @visit_note }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @visit_note.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
      Rails.logger.debug "HERE"
      if @visit_note.update(visit_note_params)
        if params[:quicksave] 
          Rails.logger.debug "QUICKSAVED"
          flash.now[:notice] = "Quicksaved" 
          return false
        end
        Rails.logger.debug "Still here"
        redirect_to(@visit_note, notice: "Visit note was successfully updated.")
      else
        render json: @visit_note.errors, status: :unprocessable_entity 
      end
  end

  def destroy
    @visit_note.destroy
    respond_to do |format|
      format.html { redirect_to visit_notes_url, notice: "Visit note was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_visit_note
      @visit_note = VisitNote.find(params[:id])
    end
  
    def visit_note_params
      params.require(:visit_note).permit(:title, :body)
    end
end
