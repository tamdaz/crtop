# Model about the process.
class Crtop::Models::Process
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

  def format_oneline(width : Int32) : String
    remaining_spaces = width - 9 - 11 - 10

    [
      pid.to_s.ljust(8),
      user.ljust(10),
      command.ljust(remaining_spaces),
      100.0 #memory_percentage.to_s,
    ].join(" ")
  end
end
