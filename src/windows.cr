class Crtop::Window
  class_getter windows = {} of Symbol => NCurses::Window

  def self.init_windows
    NCurses.start
    NCurses.cbreak
    NCurses.no_echo
    NCurses.set_cursor NCurses::Cursor::Invisible

    [:cpu, :proc, :disks].each do |name|
      windows[name] = create_window(name).as(NCurses::Window)
    end
  end

  # Gets the window
  def self.get_window(name : Symbol)
    windows[name]
  end

  def self.create_window(name : Symbol)
    half_size = Term::Screen.width // 2
    remaining_size = Term::Screen.width % 2
    cpu_height = Term::Screen.height - 15

    case name
    when :cpu then NCurses::Window.new(15, Term::Screen.width, 0, 0)
    when :proc then NCurses::Window.new(cpu_height, half_size, 15, 0)
    when :disks then NCurses::Window.new(cpu_height, half_size + remaining_size, 15, half_size)
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

        windows[name].set_color(-1)

        sleep tick.seconds

        # Recreate the window only if the screen size has changed.
        if Term::Screen.width != previous_width || Term::Screen.height != previous_height
          windows[name].delete_window
          windows[name] = create_window(name).as(NCurses::Window)

          previous_width = Term::Screen.width
          previous_height = Term::Screen.height
        end
      end
    end
  end
end
