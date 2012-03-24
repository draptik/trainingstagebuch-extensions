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
                        :query => {"user" => username, "pass" => password, "view" => "json"})
  end

  def sports
    # TODO Add error checking
    @sports = Ttb.get("/sports/list", :query => {"sso" => session, "view" => "json"})
  end

  # PRIVATE =========================================================
  private

  def session
    # TODO Add error checking
    @response["session"]
  end

end
