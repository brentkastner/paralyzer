class Paralyzer

  require 'linkedin'
  attr_accessor :Api_Key,:Api_Secret,:OAuth_Key,:OAuth_Secret

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

    puts email
    user = @client.profile(:email => email, :fields => %w(id))

  end

  def get_full_profile
    user = @client.profile
  end

  def get_profile_by_id(id)

    id = @client.profile(:id => id, :fields => %w(first_name last_name headline formatted_name id))

  end

  def get_profile_by_numeric_id(ids)
    profiles = @client.profile(:numeric_id => ids, :fields => %w(first_name id))
  end

  def get_profile_by_name(name)
    profile = @client.search(:keywords => name)
  end

end