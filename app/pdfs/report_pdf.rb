class ReportPdf < Prawn::Document
  def initialize(users)
    super()
    @reports = Report.order("id DESC").all
    reports
  end

  def reports
    matters = []
    groups = []
    matters_hash = Hash.new 0
    groups_hash = Hash.new 0
    all_reports = Report.all

    all_reports.each do |matter|
      issues = matter.issues.collect{|i| i.matter}
      issues.each do |issue|
        matters_hash[issue] += 1
      end
    end

    # get group with most subitted reports
    all_reports.each do |report|
      g = report.user.group.name
      groups.push(g)
    end
    groups.each do |group|
      groups_hash[group] += 1
    end

    text "Report for BS Feedback", size: 20, :styles => [:bold, :underline]
    formatted_text([
      { :text => "Total Bereavements reported", style: :bold, size: 14 },
      { :text => " - #{matters_hash['Bereavements']}", :styles=> [:bold, :italic], size: 14, :color => "#37b39d" }
    ])
    formatted_text([
      { :text => "Total Visits made", style: :bold, size: 14 },
      { :text => " - #{matters_hash['Visitations']}", :styles=> [:bold, :italic], size: 14, :color => "#37b39d" }
    ])
    formatted_text([
      { :text => "Group with the most number of reports - ", style: :bold, size: 14 },
      { :text => "#{groups_hash.key(groups_hash.values.max)}", :styles=> [:bold, :italic], size: 14, :color => "#37b39d" },
      { :text => " with ", style: :bold, size: 14 },
      { :text => "#{groups_hash.values.max}", :styles=> [:bold, :italic], size: 14, :color => "#37b39d" },
      { :text => " reports", style: :bold, size: 14 }
    ])
    # formatted_text([
    #   { :text => "Group with the most number of reports", size: 14 },
    #   { :text => " - #{groups_hash.key(groups_hash.values.max)}", :styles=> [:bold, :italic], size: 14, :color => "#37b39d" },
    #   { :text => " with ", styles: :bold, size: 14 },
    #   { :text => " #{groups_hash.values.max}", :styles=> [:bold, :italic], size: 14, :color => "#37b39d" },
    #   { :text => " reports", styles: :bold, size: 14 }
    # ])
    # text "Group with the most number of report - #{groups_hash.key(groups_hash.values.max)} with #{groups_hash.values.max} reports.", size: 16, style: :bold
    # formatted_text([
    #   { :text => "Bold and Italic!", :styles => [:bold, :italic] },
    #   # Gotcha Arial is not known by default
    #   { :text => " Colored Helvetica.", :font => "Helvetica", :color => "#37b39d" },
    #   { :text => " GO big Runnable!", :size => 20 }
    # ])
  end
end
