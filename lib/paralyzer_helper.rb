class Paralyzer

  require 'linkedin'
  attr_accessor :Api_Key,:Api_Secret,:OAuth_Key,:OAuth_Secret

  module LinkedIn::Api::QueryMethods

    def person_path(options)
      path = "/people"
      if id = options.delete(:id)
        path += "/id=#{id}"
      elsif url = options.delete(:url)
        path += "/url=#{CGI.escape(url)}"
      elsif email = options.delete(:email)
        path += "::(email=#{email})"
      elsif numeric_id = options.delete(:numeric_id)
        path += "::(#{numeric_id})"
      else
        path += "/~"
      end
    end

  end

  module LinkedIn::Helpers::Request
    def get(path, options={})
      #puts "#{API_PATH}#{path}", DEFAULT_HEADERS.merge(options)
      response = access_token.get("#{API_PATH}#{path}", DEFAULT_HEADERS.merge(options))
      #puts response.body
      raise_errors(response)

      response.body
    end
  end

  class LinkedIn::Mash

    # a simple helper to convert a json string to a Mash
    def self.from_json(json_string)

      result_hash = ::MultiJson.decode(json_string)
      #puts result_hash
      new(result_hash)
    end

      protected
      # overload the convert_key mash method so that the LinkedIn
      # keys are made a little more ruby-ish
      def convert_key(key)
        key.to_s

      end


  end

  def initialize(api_key, api_secret, oauth_key, oauth_secret)
    @Api_Key = api_key
    @Api_Secret = api_secret
    @OAuth_Key = oauth_key
    @OAuth_Secret = oauth_secret

    @client = LinkedIn::Client.new(@Api_Key, @Api_Secret)
    @client.authorize_from_access(@OAuth_Key, @OAuth_Secret)
  end

  def get_profile_name

    user = @client.profile(:fields => %w(first_name))
    user.first_name

  end

  def get_profile_id
    mash = @client.profile(:fields => %w(id))
    mash.id
  end

  def get_profile_by_email(email)

    user = @client.profile(:email => email, :fields => %w(id))

  end

  def get_full_profile
    user = @client.profile
  end

  def get_profile_by_id(id)

    id = @client.profile(:id => id, :fields => %w(first_name id))

  end

  def get_profile_by_numeric_id(ids)
    profiles = @client.profile(:numeric_id => ids, :fields => %w(first_name id))
  end

  def get_profile_by_name(name)
    profile = @client.search(:keywords => name)
  end

end