class HarambeesController < ApplicationController
  before_action :set_harambee, only: [:show, :edit, :update, :destroy, :make_contribution]
  before_action :authenticate_user!

  respond_to :js, :json, :html

  # GET /harambees
  # GET /harambees.json
  def index
    @harambees = Harambee.all
  end

  # GET /harambees/1
  # GET /harambees/1.json
  def show
    @my_contributing_members = Contribution.all.collect{|contr| contr.member}
  end

  # GET /harambees/new
  def new
    @harambee = Harambee.new
  end

  # GET /harambees/1/edit
  def edit
  end

  # POST /harambees
  # POST /harambees.json
  def create
    @harambee = Harambee.new(harambee_params)

    respond_to do |format|
      if @harambee.save
        format.html { redirect_to @harambee, notice: 'Harambee was successfully created.' }
        format.json { render :show, status: :created, location: @harambee }
      else
        format.html { render :new }
        format.json { render json: @harambee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /harambees/1
  # PATCH/PUT /harambees/1.json
  def update
    respond_to do |format|
      if @harambee.update(harambee_params)
        format.html { redirect_to @harambee, notice: 'Harambee was successfully updated.' }
        format.json { render :show, status: :ok, location: @harambee }
      else
        format.html { render :edit }
        format.json { render json: @harambee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /harambees/1
  # DELETE /harambees/1.json
  def destroy
    @harambee.destroy
    respond_to do |format|
      format.html { redirect_to harambees_url, notice: 'Harambee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # method for making contributions
  def make_contribution
    # @members = current_user.group.members.all
    @contribution = Contribution.new
    # @contribution.amount = params[:amount]['amount']
    @contribution.harambee_id = @harambee.id
    @contribution.member_id = params[:member_id][:id]
    @contribution.amount = params[:amount]
    # @contribution.amount =
    @contribution.save!
    # redirect_to harambee_path, notice: "Contribution added successfully!"
    respond_with @harambee
    puts "----------- >>> #{params[:amount]}"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_harambee
      @harambee = Harambee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def harambee_params
      params.require(:harambee).permit(:description, :target_amount)
    end
end
