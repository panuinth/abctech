class Candidate
  include HTTParty
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  base_uri 'http://siam.dev.abctech-thailand.com/candidate/rest/candidateService/'
  format :json

  attr_accessor :name, :age, :gender

  validates :name, :age, :gender, :presence => true

  def initialize(attr = {})
    self.name, self.age, self.gender = attr[:name], attr[:age], attr[:gender]
  end

  class << self
    def load(uuid)
      response = get("/load/#{uuid}.json").parsed_response
    end

    def upload_picture(attr = {})
      b = Base64.encode64(File.open('/Users/panuausavasereelert/panu.jpg').read)
      payload = { :uuid => attr[:uuid], :imageBase64 => b }
      response = put("/upload/image/#{attr[:uuid]}.json", :body => payload.to_json, :headers => {"Content-Type" => "application/json"}).parsed_response
    end

  end

  def save
    if valid?
      payload = { :name => name, :age => age, :gender => gender }
      response = post('/save/candidate.json', :body => payload.to_json, :headers => {"Content-Type" => "application/json"}).parsed_response
      return response
    else
      false
    end
  end

  private

  def get(method, opts={})
    begin
      response = self.class.get(method, opts)
    rescue Timeout::Error
      raise "ABC tech candidate didn't respond in time"
    end

    response['code'] == 200 ? response = response.parsed_response : response = response.parsed_response["errorMessage"]
    return response
  end

  def post(method, opts={})
    begin
      response = self.class.post(method, opts)
    rescue Timeout::Error
      raise "ABC tech candidate didn't respond in time"
    end

    response['code'] == 200 ? response = response.parsed_response : response = response.parsed_response["errorMessage"]
  end

  def put(method, opts={})
    begin
      response = self.class.post(method, opts)
    rescue Timeout::Error
      raise "ABC tech candidate didn't respond in time"
    end

    response['code'] == 200 ? response = response.parsed_response : response = response.parsed_response["errorMessage"]
  end


end
