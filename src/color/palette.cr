# Curated designer color palettes for Celestine
module Celestine::Palette
  # The elegant Arctic Nord palette
  module Nord
    # Polar Night (dark background tones)
    PolarNight0 = Celestine::Color.hex("#2e3440")
    PolarNight1 = Celestine::Color.hex("#3b4252")
    PolarNight2 = Celestine::Color.hex("#434c5e")
    PolarNight3 = Celestine::Color.hex("#4c566a")

    # Snow Storm (light foreground tones)
    SnowStorm0 = Celestine::Color.hex("#d8dee9")
    SnowStorm1 = Celestine::Color.hex("#e5e9f0")
    SnowStorm2 = Celestine::Color.hex("#eceff4")

    # Frost (calm cyan and blue tones)
    Frost0 = Celestine::Color.hex("#8fbcbb")
    Frost1 = Celestine::Color.hex("#88c0d0")
    Frost2 = Celestine::Color.hex("#81a1c1")
    Frost3 = Celestine::Color.hex("#5e81ac")

    # Aurora (vivid accent tones)
    Red    = Celestine::Color.hex("#bf616a")
    Orange = Celestine::Color.hex("#d08770")
    Yellow = Celestine::Color.hex("#ebcb8b")
    Green  = Celestine::Color.hex("#a3be8c")
    Purple = Celestine::Color.hex("#b48ead")
  end

  # The popular dark theme Dracula palette
  module Dracula
    Background  = Celestine::Color.hex("#282a36")
    CurrentLine = Celestine::Color.hex("#44475a")
    Foreground  = Celestine::Color.hex("#f8f8f2")
    Comment     = Celestine::Color.hex("#6272a4")
    Cyan        = Celestine::Color.hex("#8be9fd")
    Green       = Celestine::Color.hex("#50fa7b")
    Orange      = Celestine::Color.hex("#ffb86c")
    Pink        = Celestine::Color.hex("#ff79c6")
    Purple      = Celestine::Color.hex("#bd93f9")
    Red         = Celestine::Color.hex("#ff5555")
    Yellow      = Celestine::Color.hex("#f1fa8c")
  end

  # Curated modern UI color scales inspired by Tailwind CSS
  module Tailwind
    Slate = {
      50  => Celestine::Color.hex("#f8fafc"),
      100 => Celestine::Color.hex("#f1f5f9"),
      200 => Celestine::Color.hex("#e2e8f0"),
      300 => Celestine::Color.hex("#cbd5e1"),
      400 => Celestine::Color.hex("#94a3b8"),
      500 => Celestine::Color.hex("#64748b"),
      600 => Celestine::Color.hex("#475569"),
      700 => Celestine::Color.hex("#334155"),
      800 => Celestine::Color.hex("#1e293b"),
      900 => Celestine::Color.hex("#0f172a"),
    }

    Emerald = {
      50  => Celestine::Color.hex("#ecfdf5"),
      100 => Celestine::Color.hex("#d1fae5"),
      200 => Celestine::Color.hex("#a7f3d0"),
      300 => Celestine::Color.hex("#6ee7b7"),
      400 => Celestine::Color.hex("#34d399"),
      500 => Celestine::Color.hex("#10b981"),
      600 => Celestine::Color.hex("#059669"),
      700 => Celestine::Color.hex("#047857"),
      800 => Celestine::Color.hex("#065f46"),
      900 => Celestine::Color.hex("#064e3b"),
    }

    Indigo = {
      50  => Celestine::Color.hex("#eef2ff"),
      100 => Celestine::Color.hex("#e0e7ff"),
      200 => Celestine::Color.hex("#c7d2fe"),
      300 => Celestine::Color.hex("#a5b4fc"),
      400 => Celestine::Color.hex("#818cf8"),
      500 => Celestine::Color.hex("#6366f1"),
      600 => Celestine::Color.hex("#4f46e5"),
      700 => Celestine::Color.hex("#4338ca"),
      800 => Celestine::Color.hex("#3730a3"),
      900 => Celestine::Color.hex("#312e81"),
    }

    Amber = {
      50  => Celestine::Color.hex("#fffbeb"),
      100 => Celestine::Color.hex("#fef3c7"),
      200 => Celestine::Color.hex("#fde68a"),
      300 => Celestine::Color.hex("#fcd34d"),
      400 => Celestine::Color.hex("#fbbf24"),
      500 => Celestine::Color.hex("#f59e0b"),
      600 => Celestine::Color.hex("#d97706"),
      700 => Celestine::Color.hex("#b45309"),
      800 => Celestine::Color.hex("#92400e"),
      900 => Celestine::Color.hex("#78350f"),
    }

    Rose = {
      50  => Celestine::Color.hex("#fff1f2"),
      100 => Celestine::Color.hex("#ffe4e6"),
      200 => Celestine::Color.hex("#fecdd3"),
      300 => Celestine::Color.hex("#fda4af"),
      400 => Celestine::Color.hex("#fb7185"),
      500 => Celestine::Color.hex("#f43f5e"),
      600 => Celestine::Color.hex("#e11d48"),
      700 => Celestine::Color.hex("#be123c"),
      800 => Celestine::Color.hex("#9f1239"),
      900 => Celestine::Color.hex("#881337"),
    }

    Cyan = {
      50  => Celestine::Color.hex("#ecfeff"),
      100 => Celestine::Color.hex("#cffafe"),
      200 => Celestine::Color.hex("#a5f3fc"),
      300 => Celestine::Color.hex("#67e8f9"),
      400 => Celestine::Color.hex("#22d3ee"),
      500 => Celestine::Color.hex("#06b6d4"),
      600 => Celestine::Color.hex("#0891b2"),
      700 => Celestine::Color.hex("#0e7490"),
      800 => Celestine::Color.hex("#155e75"),
      900 => Celestine::Color.hex("#164e63"),
    }
  end
end
