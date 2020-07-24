# frozen_string_literal: true

class User
  CHROME_REGEX = /^CHROME/.freeze
  IE_REGEX = /^INTERNET EXPLORER/.freeze
  attr_reader :id, :name
  attr_accessor :sessions

  def initialize(row)
    fields = row.split(COMMA_SEP)
    @id = fields[1]
    @name = "#{fields[2]} #{fields[3]}"
    @sessions = []
    @sessions_duration = []
    @browsers = []
  end

  def sessions_count
    sessions.count
  end

  def sessions_duration
    collect_session_data if @sessions_duration.empty?
    @sessions_duration
  end

  def browsers
    collect_session_data if @browsers.empty?
    @browsers
  end

  def used_ie?
    browsers.any? { |b| b =~ IE_REGEX }
  end

  def always_used_chrome?
    browsers.all? { |b| b =~ CHROME_REGEX }
  end

  def formatted_session_dates
    sessions.map(&:formatted_date).sort!.reverse!.map!(&:iso8601)
  end

  private

  def collect_session_data
    sessions.each do |s|
      @browsers << s.browser
      @sessions_duration << s.time.to_i
    end
  end
end
