cask "spaceballs" do
  version "1.0.1"
  sha256 "3c0786e6fe4675cecb7842d073de64f171c455184dd4c94de1dad715b5d20bfe"

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
