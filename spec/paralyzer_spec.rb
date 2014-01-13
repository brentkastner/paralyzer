require 'spec_helper'
require 'rspec'
require 'paralyzer'
require 'paralyzer_helper'
require 'csv'
require 'json'

describe 'paralyzer object' do


  before {
    @Api_Key = ENV["LINKEDIN_API_KEY"]
    @Api_Secret = ENV["LINKEDIN_API_SECRET"]
    @OAuth_Key = ENV["LINKEDIN_OAUTH_KEY"]
    @OAuth_Secret = ENV["LINKEDIN_OAUTH_SECRET"]

    @my_paralyzer = Paralyzer.new(@Api_Key, @Api_Secret, @OAuth_Key, @OAuth_Secret)
  }

  it 'should be a valid paralyzer object' do

    @my_paralyzer.kind_of? Paralyzer.class

    @my_paralyzer.Api_Key == ENV["LINKEDIN_API_KEY"]

  end

  it 'should return a LinkedIn::Mash object' do
    profile = @my_paralyzer.get_full_profile.kind_of? LinkedIn::Mash.class

  end

  it 'should return a profile id' do
    profile = @my_paralyzer.get_profile_id
    profile.should_not be_empty
  end


  it 'should be able to lookup a user by email address' do
    emails = ["me@example.com"]
    email_csv = ParalyzerHelper.array_to_email_string(emails, "email")
    accounts = @my_paralyzer.get_profile_by_email(email_csv)
    accounts.kind_of? LinkedIn::Mash.class
    accounts._total.should equal 1
  end

  it 'should be able to lookup multiple email addresses' do
    emails = ["me@example.com", "you@example.com", "them@example.com"]
    email_csv = ParalyzerHelper.array_to_email_string(emails, "email")
    accounts = @my_paralyzer.get_profile_by_email(email_csv)
    accounts.kind_of? LinkedIn::Mash.class
    accounts._total.should == 3
  end

end