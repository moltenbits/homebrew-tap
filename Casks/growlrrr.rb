cask "growlrrr" do
  version "1.5.1"
  sha256 "9f7a568a770bf8ce2435501d703d4072ec0ce9a7529b89ab44347a1a5e819758"

  url "https://github.com/moltenbits/growlrrr/releases/download/v#{version}/growlrrr-#{version}-macos.tar.gz"
  name "growlrrr"
  desc "Modern CLI tool for macOS notifications"
  homepage "https://github.com/moltenbits/growlrrr"

  depends_on macos: :ventura

  app "growlrrr.app"
  binary "#{appdir}/growlrrr.app/Contents/MacOS/growlrrr"
  binary "#{appdir}/growlrrr.app/Contents/MacOS/growlrrr", target: "grrr"

  caveats <<~EOS
    growlrrr requires notification permissions. On first run, allow
    notifications when prompted or enable in System Settings > Notifications.

    Note: Only actively tested on macOS Tahoe (26). May work on Ventura and later.
  EOS
end
