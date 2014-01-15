module ParalyzerHelper

  def self.array_to_email_string(arr, option)
    url_string = nil

    if arr.count == 1
      url_string = option + arr.first.to_s
    else
      url_string = option + arr.shift.to_s
      arr.each do |val|
        url_string << "," + option + val.to_s
      end
    end

    url_string

  end

end