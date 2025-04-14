module Crtop
  # proc window
  Crtop::Window.tick_window(:proc, 1) do |window|
    y = 0

    Crtop::Collections::ProcessCollection.refresh
    Crtop::Collections::ProcessCollection.process_list.each do |process|
      window.print(process.format_oneline(window.width), y, 1)
      y += 1
    end
  end
end
