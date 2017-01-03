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
    feedback_info = [["Total Bereavements reported", "#{matters_hash['Bereavements']}"],
                      ["Total Visits made", "#{matters_hash['Visitations']}"],
                      ["Group with the most number of reports ", "#{groups_hash.key(groups_hash.values.max)} with #{groups_hash.values.max} reports"]
                    ]

    table feedback_info, width: bounds.width
    move_down 20
  end
end
