class Crtop::Collections::ProcessCollection
  class_getter process_list = [] of Crtop::Models::Process

  # Gets the running processes and store into the list.
  def self.refresh : Void
    output = IO::Memory.new

    unless @@process_list.empty?
      @@process_list.clear
    end

    Process.run("ps", ["-o", "pid,user,%cpu,%mem,comm", "--no-headers"], output: output)

    output.rewind

    output.gets_to_end.each_line do |line|
      pid, user, cpu, mem, cmd = line.squeeze(' ').delete_at(0).split(' ')

      @@process_list << Crtop::Models::Process.new(
        pid.to_i, user, cpu.to_f, mem.to_f, cmd
      )
    end
  end
end
