require "json"

class Crtop::Collections::DevicesCollection
  class_getter device_list = [] of Crtop::Models::Device

  private def self.cmd_output : IO::Memory
    output = IO::Memory.new

    Process.run("lsblk", ["-J", "-o", "PATH,SIZE,FSUSED,FSSIZE,FSAVAIL,LABEL,TYPE"], output: output)

    unless @@device_list.empty?
      @@device_list.clear
    end

    output.rewind
  end

  def self.refresh : Void
    data = JSON.parse(cmd_output)

    i = 0

    until i == (data["blockdevices"].size)
      devices = data["blockdevices"][i]

      if (devices["type"] == "part" && devices["fssize"] != nil)
        @@device_list << Crtop::Models::Device.new(
          path: devices["path"].as_s,
          size: devices["size"].as_s,
          fsused: devices["fsused"].as_s,
          fssize: devices["fssize"].as_s,
          fsavail: devices["fsavail"].as_s,
          label: devices["label"].as_s?
        )
      end

      i += 1
    end
  end
end
