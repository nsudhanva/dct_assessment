class BatchesController < ApplicationController
  before_action :set_batch, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /batches
  # GET /batches.json
  def index
    if current_user.is_admin?
      @on_going_batches = Batch.where("complete = ?", false).includes(:course)
      @completed_batches = Batch.where("complete = ?", true).includes(:course)
    elsif current_user.is_student?
      @batches = current_student.batches
    end
  end

  # GET /batches/1
  # GET /batches/1.json
  def show
    @batch_students = @batch.students.includes(:user)
    @batch_sets = BatchSet.where('batch_id = ?', @batch.id)

    if current_user.is_admin?
      @assessments = @batch_sets.where('kind = ?', "assessment")
      @assignments = @batch_sets.where('kind = ?', "assignment")
    else
      @assessments = @batch_sets.where('kind = ? AND set_date <= ?', "assessment", Date.today) 
      @assignments = @batch_sets.where('kind = ? AND set_date <= ?', "assignment", Date.today)
    end

  end

  def student
    @batch = Batch.find(params[:batch])
    @student = Student.find(params[:student])
  end

  # GET /batches/new
  def new
    @batch = Batch.new
  end

  # GET /batches/1/edit
  def edit
  end

  # POST /batches
  # POST /batches.json
  def create
    @batch = Batch.new(batch_params)

    respond_to do |format|
      if @batch.save
        format.html { redirect_to @batch, notice: 'Batch was successfully created.' }
        format.json { render :show, status: :created, location: @batch }
      else
        format.html { render :new }
        format.json { render json: @batch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /batches/1
  # PATCH/PUT /batches/1.json
  def update
    respond_to do |format|
      if @batch.update(batch_params)
        format.html { redirect_to @batch, notice: 'Batch was successfully updated.' }
        format.json { render :show, status: :ok, location: @batch }
      else
        format.html { render :edit }
        format.json { render json: @batch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /batches/1
  # DELETE /batches/1.json
  def destroy
    @batch.destroy
    respond_to do |format|
      format.html { redirect_to batches_url, notice: 'Batch was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_batch
      @batch = Batch.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def batch_params
      params.require(:batch).permit(:title, :start_date, :end_date, :course_id, :complete, student_ids: [])
    end
end
