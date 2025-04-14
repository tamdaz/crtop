module Crtop
  # disks window
  Crtop::Window.tick_window(:disks, 1) do |window|
    y = 1

    Crtop::Collections::DevicesCollection.refresh
    Crtop::Collections::DevicesCollection.device_list.each do |device|

      device_info_output = [
        device.path.ljust(20), device.size.ljust(6)
      ].join(" ").to_s

      window.print(device_info_output, y, 1)

      y += 1
    end
  end
end
