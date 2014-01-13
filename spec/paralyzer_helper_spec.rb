require 'spec_helper'
require 'rspec'
require 'paralyzer_helper'

describe 'paralyzer_helper object' do

  it 'return a string from an array' do
    arr = ['value1', 'value2']

    ParalyzerHelper.array_to_email_string(arr, 'email').kind_of? String.class

    ParalyzerHelper.array_to_email_string(arr, 'email') == 'value1,email=value2'
  end
end