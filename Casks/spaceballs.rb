cask "spaceballs" do
  version "1.4.3"
  sha256 "658715df1f171340c0863527bc8c53cdac4a083c98cc6eb730ecfa75e49cedcc"

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
    # Local Dev builds have a separate identity and are not stopped
    # by the release app's uninstall hook. No match is normal.
    result = system_command "/usr/bin/pkill",
                            args: ["-INT", "-f", '/Spaceballs Dev\.app/Contents/MacOS/spaceballs([[:space:]]|$)'],
                            must_succeed: false
    unless [0, 1].include?(result.exit_status)
      raise "Could not stop Spaceballs Dev (pkill exit #{result.exit_status})"
    end

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
