# frozen_string_literal: true

require_relative 'minitest_helper'

describe Report do
  before do
    @report = Report.new("#{__dir__}/dummy/data.txt", 'result_test.json')
  end

  it 'creates report with correct data' do
    expected_result = File.read("#{__dir__}/fixtures/result.json")
    @report.create
    actual_result = File.read("#{__dir__}/../reports/result_test.json")
    actual_result.must_equal expected_result
  end
end
