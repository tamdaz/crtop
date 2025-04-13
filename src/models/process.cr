# Model about the process.
class BCrytop::Models::Process
  getter pid : Int32
  getter user : String
  getter cpu_percentage : Float64
  getter memory_percentage : Float64
  getter command : String

  def initialize(
    @pid : Int32,
    @user : String,
    @cpu_percentage : Float64,
    @memory_percentage : Float64,
    @command : String
  ); end
end
