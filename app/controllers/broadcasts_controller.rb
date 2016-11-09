class BroadcastsController < ApplicationController
  # before_action :set_broadcast, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /broadcasts
  # GET /broadcasts.json
  def index
    @broadcasts = Broadcast.all
  end

  # GET /broadcasts/1
  # GET /broadcasts/1.json
  def show
  end

  # GET /broadcasts/new
  def new
    # @broadcast = Broadcast.new
  end

  # GET /broadcasts/1/edit
  def edit
    authorize! :edit, @broadcast
  end

  # POST /broadcasts
  # POST /broadcasts.json
  def create
    # @broadcast = Broadcast.new(broadcast_params)

    respond_to do |format|
      if @broadcast.save
        format.html { redirect_to @broadcast, notice: 'Broadcast was successfully created.' }
        format.json { render :show, status: :created, location: @broadcast }

        chat_id = "#{ENV['TELEGRAM_CHAT_ID']}"
        @broadcast_title = @broadcast.title
        @broadcast_description = @broadcast.content
        Telegram.send_message(chat_id, "BROADCAST: #{@broadcast_title.upcase}\n
          #{@broadcast_description}
          ", true, [])
      else
        format.html { render :new }
        format.json { render json: @broadcast.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /broadcasts/1
  # PATCH/PUT /broadcasts/1.json
  def update
    respond_to do |format|
      if @broadcast.update(broadcast_params)
        format.html { redirect_to @broadcast, notice: 'Broadcast was successfully updated.' }
        format.json { render :show, status: :ok, location: @broadcast }
      else
        format.html { render :edit }
        format.json { render json: @broadcast.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /broadcasts/1
  # DELETE /broadcasts/1.json
  def destroy
    @broadcast.destroy
    respond_to do |format|
      format.html { redirect_to broadcasts_url, notice: 'Broadcast was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_broadcast
    #   @broadcast = Broadcast.find(params[:id])
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    def broadcast_params
      params.require(:broadcast).permit(:title, :content)
    end
end
