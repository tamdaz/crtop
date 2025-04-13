class BCrytop::Window
  class_getter windows = {} of Symbol => NCurses::Window

  def self.init_windows
    NCurses.start
    NCurses.cbreak
    NCurses.no_echo
    NCurses.set_cursor NCurses::Cursor::Invisible

    windows[:cpu] = NCurses::Window.new(15, Term::Screen.width, 0, 0)
    windows[:proc] = NCurses::Window.new(Term::Screen.height - 15, (Term::Screen.width // 2), 15, 0)
    windows[:disks] = NCurses::Window.new(Term::Screen.height - 15, (Term::Screen.width // 2), 15, (Term::Screen.width // 2))
  end

  # Gets the window
  def self.get_window(name : Symbol)
    windows[name]
  end

  def self.create_window(name : Symbol)
    case name
    when :cpu then NCurses::Window.new(15, Term::Screen.width, 0, 0)
    when :proc then NCurses::Window.new(Term::Screen.height - 15, (Term::Screen.width // 2), 15, 0)
    when :disks then NCurses::Window.new(Term::Screen.height - 15, (Term::Screen.width // 2), 15, (Term::Screen.width // 2))
    end
  end

  # Render the window every 100 milliseconds.
  def self.tick_window(name : Symbol, tick : Float64, &block : Proc(NCurses::Window, Nil))
    spawn do
      loop do
        previous_width = Term::Screen.width
        previous_height = Term::Screen.height

        block.call windows[name]

        windows[name].border
        windows[name].refresh

        sleep tick

        # Recreate the window only if the screen size has changed.
        if Term::Screen.width != previous_width || Term::Screen.height != previous_height
          windows[name].delete_window
          windows[name] = create_window(name).as(NCurses::Window)

          previous_width = Term::Screen.width
          previous_height = Term::Screen.height
        end

        NCurses.erase
      end
    end
  end
end
