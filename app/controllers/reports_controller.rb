require 'telegram'

class ReportsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  # before_action :set_report, only: [:show, :edit, :update, :destroy]

  # GET /reports
  # GET /reports.json
  def index
    @reports = Report.all
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
  end

  # GET /reports/new
  def new
    # @report = Report.new
  end

  # GET /reports/1/edit
  def edit
    authorize! :edit, @report
  end

  # POST /reports
  # POST /reports.json
  def create
    # @report = Report.new(report_params)
    @report_title = @report.title
    @report_content = @report.content
    @report_number_of_attendees = @report.number_of_attendees
    @report_discussed_topics = @report.meeting_topics#.collect{|meeting_topics| "#{meeting_topics.topic}" }
    @report_challenges = @report.meeting_challenges#.collect{|meeting_challenge| meeting_challenge.challenge }
    respond_to do |format|
      if @report.save

        format.html { redirect_to @report, notice: 'Report was successfully created.' }
        format.json { render :show, status: :created, location: @report }

        # send telegram info
        # TELEGRAM_CHAT_ID
        chat_id = "#{ENV['TELEGRAM_CHAT_ID']}"
        Telegram.send_message(chat_id, "#{@report_title.upcase}\n
        Report from #{@report.user.group.name.upcase}\n
        #{@report_content}\n
        The number of attendees were #{@report_number_of_attendees}.\n
        Topics discussed were:
        ", true, [])

        @report_discussed_topics.each_with_index do |value, index|
          Telegram.send_message(chat_id, "#{index + 1}: #{value.topic}", true, [])
        end

        Telegram.send_message(chat_id, "Challenges faced were:", true, [])

        @report_challenges.each_with_index do |value, index|
          Telegram.send_message(chat_id, "#{index + 1}: #{value.challenge}", true, [])
        end

        Telegram.send_message(chat_id, "Report by #{@report.user.username}", true, [])
        # render json: params
      else
        format.html { render :new }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reports/1
  # PATCH/PUT /reports/1.json
  def update
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to @report, notice: 'Report was successfully updated.' }
        format.json { render :show, status: :ok, location: @report }
      else
        format.html { render :edit }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report.destroy
    respond_to do |format|
      format.html { redirect_to reports_url, notice: 'Report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_report
    #   @report = Report.find(params[:id])
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_params
      params.require(:report).permit(:title, :content, :number_of_attendees, :user_id,
        meeting_topics_attributes: [:id, :topic, :_destroy], meeting_challenges_attributes: [:id, :challenge,
          :requires_attention, :_destroy], issues_attributes: [:id, :matter, :_destroy])
    end
end
