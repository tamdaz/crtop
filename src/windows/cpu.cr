module Crtop
  Crtop::Window.tick_window(:cpu, 1) do |window|
    logo = [
      " ██████╗██████╗ ████████╗ ██████╗ ██████╗",
      "██╔════╝██╔══██╗╚══██╔══╝██╔═══██╗██╔══██╗",
      "██║     ██████╔╝   ██║   ██║   ██║██████╔╝",
      "██║     ██╔══██╗   ██║   ██║   ██║██╔═══╝",
      "╚██████╗██║  ██║   ██║   ╚██████╔╝██║",
      " ╚═════╝╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═╝",
    ]

    i = 4

    logo_position_x = Term::Screen.width / 2 - (logo[1].size / 2)

    logo.each do |line|
      pair = i - 4
      window.set_color(pair)
      window.print(line, i, logo_position_x)
      i += 1
    end

    window.set_color(0)

    window.print("Current width: #{Term::Screen.width.to_s}", i, logo_position_x)
    window.print("Window : :cpu", i + 1, logo_position_x)
  end
end
