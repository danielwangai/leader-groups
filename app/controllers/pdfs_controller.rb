class PdfsController < ApplicationController
  def index
    period = params[:period]
    period = 'All time' if period.blank?

    @all_members = Member.all.collect{|g| g.group.name} 
    if period == 'month'
      @range = 'This Month'
      @start_date = DateTime.now.prev_month.beginning_of_day.to_time
      @end_date = DateTime.now.to_time
      @reports = Report.where(created_at: @start_date..@end_date)
      @new_members = Member.where(created_at: @start_date..@end_date)
    elsif period == 'day'
      @range = 'Today'
      @start_date = DateTime.now.to_time.beginning_of_day.to_time
      @end_date = DateTime.now.to_time.end_of_day.to_time
      @reports = Report.where(created_at: @start_date..@end_date)
      @new_members = Member.where(created_at: @start_date..@end_date)
    elsif period == 'week'
      @range = 'This Week'
      @start_date = Date.today.prev_week.beginning_of_day.to_time
      @end_date = DateTime.now.to_time
      @reports = Report.where(created_at: @start_date..@end_date)
      @new_members = Member.where(created_at: @start_date..@end_date)
    elsif period == 'all'
      @range = 'All Time'
      @start_date = Report.first.created_at.to_time
      @end_date = Report.last.created_at.to_time
      @reports = Report.where(created_at: @start_date..@end_date)
      @new_members = Member.where(created_at: Member.first.created_at.to_time..Member.last.created_at.to_time)
    elsif period == 'custom'
      @range = 'Custom'
      @start = params[:from].to_s
      @end = params[:to].to_s
      @start_date = Date.parse(params[:from]).to_time.beginning_of_day
      @end_date = Date.parse(params[:to]).to_time.end_of_day
      @reports = Report.where(created_at: @start_date..@end_date)
      @new_members = Member.where(created_at: @start_date..@end_date)
    end
    # @reports
    matters = []
    groups = []
    @matters_hash = Hash.new 0
    @groups_hash = Hash.new 0
    @members = Hash.new 0

    @reports.each do |matter|
      issues = matter.issues.collect{|i| i.matter}
      issues.each do |issue|
        @matters_hash[issue] += 1
      end
    end

    # get group with most subitted reports
    @reports.each do |report|
      g = report.user.group.name
      groups.push(g)
    end
    groups.each do |group|
      @groups_hash[group] += 1
    end
    @matters_hash
    @groups_hash

    @all_members.each do |grp|
      @members[grp] += 1
    end

    # for PDFs
    # respond_to do |format|
    #   format.html
    #   format.pdf do
    #     pdf = ReportPdf.new(@reports)
    #     send_data pdf.render, filename: "reports.pdf", type: "application/pdf", disposition: 'inline'
    #   end
    # end
  end
end
