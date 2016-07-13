require 'json'
require 'open-uri'

class GithubIssues
  URI = "https://api.github.com/repos/$ORGANIZATION/$REPOSITORY/issues?state=$STATUS"

  attr_accessor :closed_issues, :opened_issues
  attr_reader :options

  def initialize(options={})
    @options       = options
    @issues        = fetch_issues
    @closed_issues = { issues: [], total_time: "" }
    @opened_issues = []
  end

  def report
    case options[:status]
    when 'closed'
      report_closed_issues
    when 'open'
      report_opened_issues
    end
  end

  def report_closed_issues
    return "There is any issue to show" if @issues.nil?

    @issues.each do |issue|
      closed_issues[:issues] << "Issue #{issue['title']}: took #{time_opened(issue)} to be finished."
    end

    closed_issues[:total_time] = "Time average that was taken for all issues to be finished: #{average_time_opened}"

    closed_issues
  end

  def report_opened_issues
    return "There is any issue to show" if @issues.nil?

    @issues.each do |issue|
      opened_issues << "Issue #{issue['title']}"
    end

    opened_issues
  end

  def time_opened(issue)
    created_at = Time.parse(issue["created_at"])
    closed_at  = Time.parse(issue["closed_at"])
    seconds    = closed_at - created_at

    convert_seconds_to_formatted_time(seconds)
  end

  def average_time_opened
    total_seconds = 0

    @issues.each do |issue|
      total_seconds += Time.parse(issue["closed_at"]) - Time.parse(issue["created_at"])
    end

    average = total_seconds / @issues.length
    convert_seconds_to_formatted_time(average)
  end

  private

  attr_reader :options

  def fetch_issues
    begin
      uri = parse_uri(options)
      JSON.load(open(uri))
    rescue Exception => e
      puts e
    end
  end

  def parse_uri(params={})
    URI.sub!("$ORGANIZATION", "#{params[:org]}")
       .sub!("$REPOSITORY", "#{params[:repo]}")
       .sub!("$STATUS", "#{params[:status]}")
  end

  def convert_seconds_to_formatted_time(seconds)
    Time.at(seconds).utc.strftime("%H:%M:%S")
  end
end
