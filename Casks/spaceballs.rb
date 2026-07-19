cask "spaceballs" do
  version "1.0.2"
  sha256 "8772d5b0df4b99acefab73f2de4c3bb144a16a4e3be75b457ce8483676647176"

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
