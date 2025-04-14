class Crtop::Models::Device
  getter path : String
  getter size : String
  getter fsused : String
  getter fssize : String
  getter fsavail : String
  getter label : String?

  def initialize(
    @path : String, @size : String,
    @fsused : String, @fssize : String,
    @fsavail : String, @label : String?
  ); end
end
