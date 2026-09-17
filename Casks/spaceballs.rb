cask "spaceballs" do
  version "2.0.0"
  sha256 "5e3fcaba0f5793b420d6cbccc228c88e484e2eaf5a89b90118c94e6255c1c948"

  url "https://github.com/moltenbits/spaceballs/releases/download/v#{version}/spaceballs-#{version}-macos.tar.gz"
  name "Spaceballs"
  desc "Keyboard-driven window switcher for Spaces"
  homepage "https://github.com/moltenbits/spaceballs"

  depends_on macos: :golden_gate

  app "Spaceballs.app"
  binary "Spaceballs-CLI.app/Contents/MacOS/spaceballs"

  # Homebrew 7 runs install steps in a sandbox that cannot launch
  # applications (deny lsopen), so the app is NOT relaunched after an
  # upgrade any more; the caveats say so. Local Dev builds have a
  # separate identity and are not stopped by the release app's
  # uninstall hook, so stop one here. No match is normal.
  postflight_steps do
    terminate_process '/Spaceballs Dev\.app/Contents/MacOS/spaceballs([[:space:]]|$)',
                      match: :full
  end

  # Quit the running instance before brew replaces the bundle on
  # upgrade/uninstall — otherwise the old version keeps running from
  # its memory-mapped (deleted) binary until manually restarted.
  uninstall quit: "com.moltenbits.spaceballs"

  caveats <<~EOS
    This release requires macOS 27 (Golden Gate) or newer and was tested
    on macOS 27. Spaceballs relies on private macOS APIs that can change
    in any macOS release — on an older macOS version, install the
    Spaceballs release that targeted it.

    Spaceballs requires Accessibility and Screen Recording permissions.
    Enable them in System Settings > Privacy & Security after installation.

    Upgrades quit the running Spaceballs but cannot relaunch it (Homebrew's
    install sandbox forbids launching apps): open Spaceballs again afterwards.
  EOS
end
