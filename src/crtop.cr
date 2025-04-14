require "ncurses"
require "term-screen"
require "signal"
require "./windows"
require "./configs/*"
require "./utils/*"
require "./models/*"
require "./collections/*"
require "./windows/*"

# Crtop is a program that list all processes.
module Crtop
  VERSION = "0.1.0"

  NCurses.start
  NCurses.cbreak
  NCurses.no_echo
  NCurses.keypad true
  NCurses.set_cursor NCurses::Cursor::Invisible

  NCurses.start_color
  NCurses.use_default_colors
  Crtop.init_colors

  Crtop::Window.init_windows

  Channel(Nil).new.receive

  NCurses.end
end
