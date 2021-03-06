class Candidate
  include HTTParty
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  base_uri 'http://siam.dev.abctech-thailand.com/candidate/rest/candidateService/'
  format :json

  attr_accessor :name, :age, :gender, :uuid

  validates_presence_of :name, :age, :gender

  def initialize(attr = {})
    self.name, self.age, self.gender, self.uuid = attr[:name], attr[:age], attr[:gender], attr[:uuid]
  end

  def save
    if valid?
      payload = { :name => name, :age => age, :gender => gender }
      response = post('/save.json', :body => payload.to_json, :headers => {"Content-Type" => "application/json"}).parsed_response
      self.uuid = response["uuid"]

      return response
    else
      false
    end
  end

  class << self
    def load(uuid)
      response = get("/load/#{uuid}.json").parsed_response if uuid
    end

    def upload_picture(attr = {})
      picture = Base64.encode64(File.open(attr[:imageBase64]).read)
      payload = { :uuid => attr[:uuid], :imageBase64 => picture }
      response = put("/upload/image/#{attr[:uuid]}.json", :body => payload.to_json, :headers => {"Content-Type" => "application/json"}).parsed_response
    end

    def view_link(uuid)
      "http://siam.dev.abctech-thailand.com/candidate/view.html?uuid=#{uuid}" if uuid
    end


  end

  private

  def get(method, opts={})
    begin
      response = self.class.get(method, opts)
    rescue Timeout::Error
      raise "ABC tech candidate didn't respond in time"
    end

    response["code"] == 200 ? response = response.parsed_response : response = response.parsed_response["errorMessage"]
    return response
  end

  def post(method, opts={})
    begin
      response = self.class.post(method, opts)
    rescue Timeout::Error
      raise "ABC tech candidate didn't respond in time"
    end

    return response


    response.code == 200 ? response = response : response = response.message
    return response
  end

  def put(method, opts={})
    begin
      response = self.class.put(method, opts)
    rescue Timeout::Error
      raise "ABC tech candidate didn't respond in time"
    end

    response["code"] == 200 ? response = response.parsed_response : response = response.parsed_response["errorMessage"]
    return response
  end

end
