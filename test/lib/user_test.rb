# frozen_string_literal: true

require_relative '../minitest_helper'

describe User do
  before do
    @user = User.new('user,1,Palmer,Katrina,65')
    [
      'session,1,0,Safari 17,12,2016-10-21',
      'session,1,1,Firefox 32,3,2016-12-20'
    ].each do |row|
      @user.sessions << Session.new(row)
    end
  end

  describe '#sessions_duration' do
    it 'returns session durations' do
      @user.sessions_duration.must_equal([12, 3])
    end
  end

  describe '#browsers' do
    it 'returns all user browsers' do
      @user.browsers.must_equal(['SAFARI 17', 'FIREFOX 32'])
    end
  end

  describe '#used_ie?' do
    it 'returns false if IE was not used' do
      @user.used_ie?.must_equal false
    end

    it 'returns true if IE was used' do
      @user.sessions << Session.new('session,1,0,Internet Explorer 7,12,2016-10-21')
      @user.used_ie?.must_equal true
    end
  end

  describe '#always_used_chrome?' do
    it 'returns false if using not only Chrome' do
      @user.always_used_chrome?.must_equal false
    end

    it 'returns true if using only Chrome' do
      @user.sessions = []
      [
        'session,1,0,Chrome 17,12,2016-10-21',
        'session,1,1,Chrome 32,3,2016-12-20'
      ].each do |row|
        @user.sessions << Session.new(row)
      end
      @user.always_used_chrome?.must_equal true
    end
  end

  describe '#formatted_session_dates' do
    it 'returns dates sorted in reverse' do
      @user.formatted_session_dates.must_equal %w[2016-12-20 2016-10-21]
    end
  end
end
