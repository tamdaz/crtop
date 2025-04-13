module BCrytop
  def self.init_colors
    # Between 10..15 => Grey shade for logo.
    LibNCurses.init_pair(1, 10, -1)
    LibNCurses.init_pair(2, 11, -1)
    LibNCurses.init_pair(3, 12, -1)
    LibNCurses.init_pair(4, 13, -1)
    LibNCurses.init_pair(5, 14, -1)
    LibNCurses.init_pair(6, 15, -1)

    if NCurses.can_change_color?
      NCurses.use_default_colors

      # Between 10..15 => Change foreground color with RGB for the BCRYTOP logo.
      NCurses.change_color(10, 1000, 1000, 1000)
      NCurses.change_color(11, 900, 900, 900)
      NCurses.change_color(12, 800, 800, 800)
      NCurses.change_color(13, 700, 700, 700)
      NCurses.change_color(14, 600, 600, 600)
      NCurses.change_color(15, 500, 500, 500)
    end
  end
end
