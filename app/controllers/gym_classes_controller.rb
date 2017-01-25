class GymClassesController < ApplicationController
  before_action :set_gym_class, only: [:show, :edit, :update, :destroy]

  # GET /gym_classes
  # GET /gym_classes.json
  def index
    @gym_classes = GymClass.all
  end

  # GET /gym_classes/1
  # GET /gym_classes/1.json
  def show
  end

  # GET /gym_classes/new
  def new
    @gym_class = GymClass.new
  end

  # GET /gym_classes/1/edit
  def edit
  end

  # POST /gym_classes
  # POST /gym_classes.json
  def create
    @gym_class = GymClass.new(gym_class_params)

    respond_to do |format|
      if @gym_class.save
        format.html { redirect_to @gym_class, notice: 'Gym class was successfully created.' }
        format.json { render :show, status: :created, location: @gym_class }
      else
        format.html { render :new }
        format.json { render json: @gym_class.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gym_classes/1
  # PATCH/PUT /gym_classes/1.json
  def update
    respond_to do |format|
      if @gym_class.update(gym_class_params)
        format.html { redirect_to @gym_class, notice: 'Gym class was successfully updated.' }
        format.json { render :show, status: :ok, location: @gym_class }
      else
        format.html { render :edit }
        format.json { render json: @gym_class.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gym_classes/1
  # DELETE /gym_classes/1.json
  def destroy
    @gym_class.destroy
    respond_to do |format|
      format.html { redirect_to gym_classes_url, notice: 'Gym class was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gym_class
      @gym_class = GymClass.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gym_class_params
      params.require(:gym_class).permit(:name, :start_time, :end_time, :day)
    end
end
