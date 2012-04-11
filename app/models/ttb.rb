# This class is a pure Ruby class.
# 
# ==> Rails::ActiveRecord methods can't be used by this class!
# 
# Usage example:
# 
#     $rails console
#     > ttb = Ttb.new
#     > ttb.login("username", "password")
#     > ttb.pull_sports(user_id)
#     > quit
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
  attr_writer   :password
  # attr_reader :session

  self.base_uri 'https://trainingstagebuch.org'
  self.default_params output: 'json'
  self.format :json

  def initialize(dbg=false)
    @debug = dbg
  end

  def login(ttb_username, ttb_password)
    # TODO Add error checking
    options = {:query => query_json("user" => ttb_username, "pass" => ttb_password)}
    @response = Ttb.get("/login/sso", options)
  end

  def pull_sports(user_id)
    debug_helper "Starting pull_sports..................."            
    sports_json = Ttb.get("/sports/list", :query => query_sso)

    debug_helper "Checking user_id = #{user_id}..................."            
    user = User.find(user_id) # TODO Refactor, Error Checking, Throw Exception...
    debug_helper user

    cnt = 0 if @debug

    sports_json["sports"].each do |sport_entry|
      debug_helper "STARTING CNT: #{cnt}"

      attr = sport_mapping(sport_entry)

      sport_json = Sport.new(attr)
      debug_helper "(CNT: #{cnt}) Created sport_json: #{sport_json}"

      # TODO Replace with Ruby idiom for Try/Catch
      begin 
        debug_helper "CNT: #{cnt} Entering TRY...."
        sport_db = Sport.find(sport_json.id) # can throw exception...
        sport_db.update_attributes(attr)
      rescue # catch if record was not found and exception was thrown...
        debug_helper "CNT: #{cnt} CATCH!!!!"
        sport_db = sport_json
      end

      if (@debug)
        debug_helper "CNT: #{cnt} DEBUG 1 AFTER TRY/CATCH"
        debug_helper user
      end
      
      sport_db.users << user

      if (@debug)
        debug_helper "CNT: #{cnt} DEBUG 2 AFTER TRY/CATCH"
        debug_helper sport_db.users
        debug_helper "CNT: #{cnt} DEBUG 3 AFTER TRY/CATCH"
      end

      sport_db.save

      if (@debug)
        cnt += 1
      end

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


  def sport_mapping(sport_entry)
    attr = {
      :id         => sport_entry["id"],
      :name       => sport_entry["name"],
      :comment    => sport_entry["comment"],
      :lastchange => sport_entry["lastchange"]
    }
  end

  def material_mapping(mapping_entry)
    attr = {
      :id         => s["id"],
      :name       => s["name"],
      :status     => s["status"],
      :comment    => s["comment"],
      :count      => s["count"],
      :duration   => s["duration"],
      :distancekm => s["distance-km"],
      :lastchange => s["lastchange"]
    }
  end

  def debug_helper(content)
    if @debug
      pp "DEBUG:"
      pp content
    end
  end
end
