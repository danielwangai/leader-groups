require 'json'
require 'open-uri'

class HomeController < ApplicationController
  def index
  end

  def report
    # @start = params[:from].to_s
    # @end = params[:to].to_s
    # @start_date = Date.parse(params[:from]).to_time.beginning_of_day
    # @end_date = Date.parse(params[:to]).to_time.end_of_day

    #
    @matter = Report.all.collect{|report| report.issues.collect{|issue| issue.matter}}
    @matter.delete([])
    @matter = @matter.flatten(1).collect{|arr| arr.size == 1 ? arr[0] : arr}
    json = JSON.parse(@matter)
    @bereavements = json["Bereavements"]
    @visitations = json["Visitations"]
  end
end
