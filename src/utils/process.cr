module BCrytop::Utils

  # Gets an array of running processes.
  def self.processes_list
    output = IO::Memory.new

    Process.run("ps", ["-eo", "pid,user,%cpu,%mem,comm", "--no-headers"], output: output)

    process_list = [] of BCrytop::Models::Process

    output.rewind

    output.gets_to_end.each_line do |line|
      pid, user, cpu, mem, cmd = line.squeeze(' ').delete_at(0).split(' ')

      process_list << BCrytop::Models::Process.new(
        pid: pid.to_i,
        user: user,
        cpu_percentage: cpu.to_f,
        memory_percentage: mem.to_f,
        command: cmd
      )
    end

    process_list
  end
end
