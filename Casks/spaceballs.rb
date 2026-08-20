cask "spaceballs" do
  version "1.3.2"
  sha256 "43e83c7ca0a8d5a4e68627a303ed4eb42a94b998176f0d6073355433761630c5"

  url "https://github.com/moltenbits/spaceballs/releases/download/v#{version}/spaceballs-#{version}-macos.tar.gz"
  name "Spaceballs"
  desc "Keyboard-driven macOS window switcher for Spaces"
  homepage "https://github.com/moltenbits/spaceballs"

  depends_on macos: :tahoe

  app "Spaceballs.app"
  binary "Spaceballs-CLI.app/Contents/MacOS/spaceballs"

  # Quit the running instance before brew replaces the bundle on
  # upgrade/uninstall — otherwise the old version keeps running from
  # its memory-mapped (deleted) binary until manually restarted.
  uninstall quit: "com.moltenbits.spaceballs"

  # Relaunch after install/upgrade (-g: without stealing focus), so
  # an upgrade is quit -> replace -> relaunch with no manual step.
  postflight do
    system_command "/usr/bin/open",
                   args: ["-g", "-a", "#{appdir}/Spaceballs.app"]
  end

  caveats <<~EOS
    This release is built for and tested on macOS 26 (Tahoe). Spaceballs
    relies on private macOS APIs that can change in any macOS release —
    on an older macOS version, install the Spaceballs release that
    targeted it.

    Spaceballs requires Accessibility and Screen Recording permissions.
    Enable them in System Settings > Privacy & Security after installation.
  EOS
end
