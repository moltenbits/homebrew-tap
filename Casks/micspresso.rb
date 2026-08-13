cask "micspresso" do
  version "1.2.1"
  sha256 "912cf835966f2a941b02ba184c6705379441a2ed6cb8be4a5845f8c5e0bf9f35"

  url "https://github.com/moltenbits/micspresso/releases/download/v#{version}/micspresso-#{version}-macos.tar.gz"
  name "Micspresso"
  desc "Menu bar app that keeps Bluetooth mics warm so dictation starts instantly"
  homepage "https://github.com/moltenbits/micspresso"

  depends_on macos: :ventura

  app "Micspresso.app"
  binary "#{appdir}/Micspresso.app/Contents/MacOS/micspresso"

  # Quit the running instance before brew replaces the bundle on
  # upgrade/uninstall, then relaunch (-g: without stealing focus).
  uninstall quit: "com.moltenbits.micspresso"

  postflight do
    system_command "/usr/bin/open",
                   args: ["-g", "-a", "#{appdir}/Micspresso.app"]
  end

  zap trash: [
    "~/Library/Preferences/com.moltenbits.micspresso.plist",
  ]

  caveats <<~EOS
    Micspresso needs microphone permission to hold the mic open —
    allow it when prompted. The orange mic indicator staying lit is
    expected: the mic is open (that's the point) but nothing is
    recorded.

    While a Bluetooth mic is kept warm, macOS keeps the headset in
    its call-audio mode, which reduces playback quality. Pause
    Micspresso from the menu bar when you want full-quality audio.
  EOS
end
