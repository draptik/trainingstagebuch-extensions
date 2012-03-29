# Usage example:
# 
# $rails console
# > ttb = Ttb.new
# > ttb.login("username", "password")
# > ttb.sports
# > quit
class Ttb

  include HTTParty

  # attr_* assignes instance variable
  #
  # attr_accessor creates getter/setter
  #   Note: attr_accesible can't be used here because it is a method of ActiveRecord!
  #
  # attr_reader creates getter
  # attr_writer creates setter
  #
  attr_accessor :user
  attr_writer = :password
  # attr_reader :session

  self.base_uri 'https://trainingstagebuch.org'
  self.default_params output: 'json'
  self.format :json

  def login(username, password)
    # TODO Add error checking
    @response = Ttb.get("/login/sso",
                        :query => query_json("user" => username, "pass" => password))
  end

  def update_sports
    sports_json = Ttb.get("/sports/list", :query => query_sso)

    sports_json["sports"].each do |s|

      # 'adapter' mapping
      attr = {
        :id => s["id"],
        :name => s["name"],
        :comment => s["comment"],
        :lastchange => s["lastchange"]
      }

      sport_json = Sports.new(attr)

      # TODO Replace with Rails idiom
      begin 
        sport_db = Sports.find(sport_json.id) # can throw exception...
        sport_db.update_attributes(attr)
      rescue # catch if record was not found and exception was thrown...
        sport_db = sport_json
      end

      sport_db.save
    end # sports_json["sports"].each do |s|
  end # sports

  # PRIVATE =========================================================
  private

  def session
    # TODO Add error checking
    @response["session"]
  end

  def query
    @query_json = {:view => "json"}
  end

  def query_json(query_hash)
    # TODO Add error checking
    @query = query.merge(query_hash)
  end

  def query_sso
    @query_sso = query.merge(:sso => session)
  end
end
