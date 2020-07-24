# frozen_string_literal: true

require 'date'

class Session
  attr_reader :user_id, :session_id, :browser, :time, :date

  def initialize(row)
    fields = row.split(COMMA_SEP)
    @user_id = fields[1]
    @session_id = fields[2]
    @browser = fields[3].upcase!
    @time = fields[4]
    @date = fields[5]
  end

  def formatted_date
    Date.strptime(date, '%Y-%m-%d')
  end
end
