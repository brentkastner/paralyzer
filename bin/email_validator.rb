#!/usr/bin/env ruby

require_relative '../lib/paralyzer'
require_relative '../lib/paralyzer_helper'
require 'csv'

@Api_Key = ENV["LINKEDIN_API_KEY"]
@Api_Secret = ENV["LINKEDIN_API_SECRET"]
@OAuth_Key = ENV["LINKEDIN_OAUTH_KEY"]
@OAuth_Secret = ENV["LINKEDIN_OAUTH_SECRET"]

@my_paralyzer = Paralyzer.new(@Api_Key, @Api_Secret, @OAuth_Key, @OAuth_Secret)

#default email_chunk_size to 1, otherwise take the first argument and assign it
@email_chunk_size = 1

@email_chunk_size = ARGV.first if ARGV.first

#initialize email array - pull this in from a file

email_file = File.read('email.csv')
emails = email_file.split(",")

#puts emails.count
if File.file?('output.csv')
  prepend_comma = ','
else
  prepend_comma = ''
end


until emails.count == 0 do
  email_chunk = emails.shift(Integer(@email_chunk_size))
  email_csv = ParalyzerHelper.array_to_email_string(email_chunk, "email")

  #puts email_csv

  result = @my_paralyzer.get_profile_by_email(email_csv)
  File.open('in-process.csv', 'w') { |file| file.write(emails.to_csv.chomp) }
  matched_emails = []
  output = result["values"]
  if output
    output.each do |key|
      matched_emails << key._key.gsub(/email=/, '')
    end

    File.open('output.csv', 'a') {|file| file.write(prepend_comma + matched_emails.compact.to_csv.chomp)}
  end

  prepend_comma = ','
end


