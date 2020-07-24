# frozen_string_literal: true

require 'json'

class Report
  attr_reader :report_filename, :collector, :report

  def initialize(file_path, report_filename)
    @report_filename = report_filename
    @collector = LogsCollector.new(file_path)
    @report = {}
    @pastel = Pastel.new
  end

  def create
    profile do
      spinner('collect data...') do
        collector.collect_data
      end
    end

    profile do
      spinner('create report...') do
        create_report
      end
    end
  end

  private

  def spinner(caption)
    spinner = TTY::Spinner.new(@pastel.green("[:spinner] #{caption}"))
    spinner.auto_spin
    yield
    spinner.success('(done!)')
  end

  def create_report
    collect_base_stat
    collect_users_stat
    write_report_to_file
  end

  def collect_base_stat
    report[:totalUsers] = collector.users.count
    report[:uniqueBrowsersCount] = uniq_browsers.count
    report[:totalSessions] = collector.total_sessions
    report[:allBrowsers] = uniq_browsers.sort!.join(COMMA_SEP)
  end

  def uniq_browsers
    @uniq_browsers ||= collector.browsers.uniq!
  end

  def collect_users_stat
    report[:usersStats] = {}

    until collector.users.empty?
      user = collector.users.shift[1]
      report[:usersStats][user.name] = collect_user_stat(user)
    end
  end

  def collect_user_stat(user)
    {
      sessionsCount: user.sessions_count,
      totalTime: "#{user.sessions_duration.sum} min.",
      longestSession: "#{user.sessions_duration.max} min.",
      browsers: user.browsers.sort!.join(', '),
      usedIE: user.used_ie?,
      alwaysUsedChrome: user.always_used_chrome?,
      dates: user.formatted_session_dates
    }
  end

  def write_report_to_file
    File.write(report_file_path, "#{report.to_json}\n")
  end

  def report_file_path
    "#{__dir__}/reports/#{report_filename}"
  end
end
