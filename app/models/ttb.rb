# Usage example:
# 
# $rails console
# > ttb = Ttb.new
# > ttb.login("username", "password")
# > ttb.sports
# > quit
class Ttb

  include HTTParty

  # attr_* assinges instance variable
  # attr_accessor creates getter/setter
  # attr_reader creates getter
  # attr_writer creates setter
  attr_accessor :user, :password
  # attr_reader :session

  self.base_uri 'https://trainingstagebuch.org'
  self.default_params output: 'json'
  self.format :json

  def login(username, password)
    # TODO Add error checking
    @response = Ttb.get("/login/sso",
                        :query => query_json("user" => username, "pass" => password))
  end

  def sports
    # TODO Add error checking
    @sports = Ttb.get("/sports/list", :query => query_sso)
  end

  # PRIVATE =========================================================
  private

  def session
    # TODO Add error checking
    @response["session"]
  end

  def query
    @query_json = {"view" => "json"}
  end

  def query_json(query_hash)
    # TODO Add error checking
    @query = query.merge(query_hash)
  end

  def query_sso
    @query_sso = query.merge("sso" => session)
  end
end
