require "ncurses"
require "term-screen"
require "signal"
require "./windows"
require "./configs/*"
require "./utils/*"
require "./models/*"

# BCrytop is a program that list all processes.
module BCrytop
  VERSION = "0.1.0"

  NCurses.start
  NCurses.cbreak
  NCurses.no_echo
  NCurses.set_cursor NCurses::Cursor::Invisible
  NCurses.start_color

  NCurses.use_default_colors
  BCrytop.init_colors

  BCrytop::Window.init_windows

  BCrytop::Window.tick_window(:cpu, 0.2) do
    logo = [
      " ██████╗██████╗ ████████╗ ██████╗ ██████╗",
      "██╔════╝██╔══██╗╚══██╔══╝██╔═══██╗██╔══██╗",
      "██║     ██████╔╝   ██║   ██║   ██║██████╔╝",
      "██║     ██╔══██╗   ██║   ██║   ██║██╔═══╝",
      "╚██████╗██║  ██║   ██║   ╚██████╔╝██║",
      " ╚═════╝╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═╝"
    ]

    i = 4

    logo_position_x = Term::Screen.width / 2 - (logo[1].size / 2)

    logo.each do |line|
      pair = i - 4
      BCrytop::Window.get_window(:cpu).set_color(pair)
      BCrytop::Window.get_window(:cpu).print(line, i, logo_position_x)
      i += 1
    end

    BCrytop::Window.get_window(:cpu).print("Current width: #{Term::Screen.width.to_s}", i, logo_position_x)
    BCrytop::Window.get_window(:cpu).print("Window : :cpu", i + 1, logo_position_x)
  end

  # proc window
  BCrytop::Window.tick_window(:proc, 1) do
    y = 1

    BCrytop::Window.get_window(:proc).print("Proc window", 1, 1)

    BCrytop::Utils.processes_list.each do |process|
      y += 1

      output = "#{process.pid} #{process.command}"

      BCrytop::Window.get_window(:disks).print(output, y, 1)
    end
  end

  # disks window
  BCrytop::Window.tick_window(:disks, 0.2) do

    BCrytop::Window.get_window(:disks).print("Disks window", 1, 1)
  end

  Channel(Nil).new.receive

  NCurses.end
end
