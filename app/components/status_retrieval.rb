class StatusRetrieval
  
  # Constants
  URI_LOGIN = "https://academic.ui.ac.id/main/Authentication/Index"
  URI_TARGET = "https://academic.ui.ac.id/main/CoursePlan/CoursePlanEdit"
  RTO_TIME = 30000
  
  def initialize username, password
    @username = username
    @password = password
  end
  def perform
    beginning_time = Time.now
    
    begin 
      ck = get_cookie_login
      retrieve_uri ck 
    rescue
      rto = true
    end
    
    record = SiakStatus.new
    record.ping_ms = rto ? RTO_TIME : (Time.now - beginning_time) * 1000
    record
  end
  def get_cookie_login
    response = RestClient.post URI_LOGIN, {u: @username, p: @password}
    raise "Failure login!" unless response.body.match(/redirecting/i)
    return response.cookies
  end
  def retrieve_uri cookies
    response = RestClient.get URI_LOGIN, {cookies: cookies}
    
  end
end