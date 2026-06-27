cask "spaceballs" do
  version "1.0.0"
  sha256 "fbb760517cd217a9351cc34ecc8a65aa32e3f486a1abaf8d7bd629a14273eb85"

  url "https://github.com/moltenbits/spaceballs/releases/download/v#{version}/spaceballs-#{version}-macos.tar.gz"
  name "Spaceballs"
  desc "Keyboard-driven macOS window switcher for Spaces"
  homepage "https://github.com/moltenbits/spaceballs"

  depends_on macos: ">= :sonoma"

  app "Spaceballs.app"
  binary "Spaceballs-CLI.app/Contents/MacOS/spaceballs"

  caveats <<~EOS
    Spaceballs requires Accessibility and Screen Recording permissions.
    Enable them in System Settings > Privacy & Security after installation.

    Spaceballs uses private macOS APIs for Spaces/window activation and is
    tested on modern macOS releases.
  EOS
end
