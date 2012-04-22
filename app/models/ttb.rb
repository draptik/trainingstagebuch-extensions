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
  
  # http://railscasts.com/episodes/219-active-model
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming


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

  def initialize(dbg=true)
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

    return_value = false

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

      debug_helper "CNT: #{cnt} DEBUG 1 AFTER TRY/CATCH"
      debug_helper user
      
      debug_helper "Current Sport object: #{sport_db}"
      sport_db.users << user

      debug_helper "CNT: #{cnt} DEBUG 2 AFTER TRY/CATCH"
      debug_helper sport_db.users
      debug_helper "CNT: #{cnt} DEBUG 3 AFTER TRY/CATCH"

      debug_helper "Current sport_json is: #{sport_json}"
      debug_helper "Current sport_json.id is: #{sport_json.id}"
      debug_helper "Current sport_db is: #{sport_db}"
      debug_helper "Current sport_db.sport_id is: #{sport_db.id}"
      debug_helper "Current sport_db.name is: #{sport_db.name}"
      debug_helper "Current sport_db.users is: #{sport_db.users}"
      return_value = sport_db.save
      debug_helper "Current return_value is: #{return_value}"

      cnt += 1 if (@debug)

    end # sports_json["sports"].each do |s|
    
    #return return_value
  end # sports



  def pull_materials(user_id)
    debug_helper "Starting pull_materials..................."            
    materials_json = Ttb.get("/material/list", :query => query_sso)

    debug_helper "Checking user_id = #{user_id}..................."            
    user = User.find(user_id) # TODO Refactor, Error Checking, Throw Exception...
    debug_helper user

    cnt = 0 if @debug

    return_value = false

    materials_json["material"].each do |material_entry|
      debug_helper "STARTING CNT: #{cnt}"

      attr = material_mapping(material_entry)

      material_json = user.materials.build(attr)
      debug_helper "(CNT: #{cnt}) Created material_json: #{material_json}"

      # TODO Replace with Ruby idiom for Try/Catch
      begin 
        debug_helper "CNT: #{cnt} Entering TRY...."
        material_db = material.find(material_json.id) # can throw exception...
        material_db.update_attributes(attr)
      rescue # catch if record was not found and exception was thrown...
        debug_helper "CNT: #{cnt} CATCH!!!!"
        material_db = material_json
      end

      debug_helper "CNT: #{cnt} DEBUG 1 AFTER TRY/CATCH"
      debug_helper user
      
      debug_helper "Current material object: #{material_db}"
      material_db.user = user

      debug_helper "CNT: #{cnt} DEBUG 2 AFTER TRY/CATCH"
      debug_helper material_db.user
      debug_helper "CNT: #{cnt} DEBUG 3 AFTER TRY/CATCH"

      debug_helper "Current material_json is: #{material_json}"
      debug_helper "Current material_json.id is: #{material_json.id}"
      debug_helper "Current material_db is: #{material_db}"
      debug_helper "Current material_db.material_id is: #{material_db.id}"
      debug_helper "Current material_db.name is: #{material_db.name}"
      debug_helper "Current material_db.user is: #{material_db.user}"
      return_value = material_db.save
      debug_helper "Current return_value is: #{return_value}"

      cnt += 1 if (@debug)

    end # materials_json["material"].each do |s|
    
    #return return_value
  end # materials





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

  # many-to-many
  def sport_mapping(sport_entry)
    attr = {
      :sport_id   => sport_entry["id"],
      :name       => sport_entry["name"],
      :comment    => sport_entry["comment"],
      :lastchange => sport_entry["lastchange"]
    }
  end

  # one-to-many (one user has-many materials)
  def material_mapping(material_entry)
    attr = {
      :material_id => material_entry["id"],
      :name        => material_entry["name"],
      :status      => material_entry["status"],
      :comment     => material_entry["comment"],
      :count       => material_entry["count"],
      :duration    => material_entry["duration"],
      :distance_km => material_entry["distance-km"],
      :lastchange  => material_entry["lastchange"]
    }
  end

  def debug_helper(content)
    if @debug
      puts "DEBUG:"
      puts content
    end
  end
end
