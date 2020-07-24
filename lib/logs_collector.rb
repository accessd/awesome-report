# frozen_string_literal: true

class LogsCollector
  USER_ROW = 'user'
  attr_reader :file_path, :users, :browsers
  attr_accessor :total_sessions

  def initialize(file_path)
    @file_path = file_path
    @users = {}
    @total_sessions = 0
    @browsers = []
  end

  def collect_data
    File.new(file_path).each do |row|
      if row.start_with?(USER_ROW)
        collect_user(row)
        next
      end

      collect_session(row)
    end
  end

  private

  def collect_user(row)
    user = User.new(row)
    users[user.id] = user
  end

  def collect_session(row)
    session = Session.new(row)
    user = users[session.user_id]
    user.sessions << session

    browsers << session.browser
    self.total_sessions += 1
  end
end
