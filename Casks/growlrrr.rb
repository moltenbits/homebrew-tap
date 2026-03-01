cask "growlrrr" do
  version "1.3.0"
  sha256 "5d1beeb11cb3fb582d78ba9dddfc49dbcb96cd604435cfdf52e47317a78097ca"

  url "https://github.com/moltenbits/growlrrr/releases/download/v#{version}/growlrrr-#{version}-macos.tar.gz"
  name "growlrrr"
  desc "Modern CLI tool for macOS notifications"
  homepage "https://github.com/moltenbits/growlrrr"

  depends_on macos: ">= :ventura"

  app "growlrrr.app"
  binary "#{appdir}/growlrrr.app/Contents/MacOS/growlrrr"
  binary "#{appdir}/growlrrr.app/Contents/MacOS/growlrrr", target: "grrr"

  caveats <<~EOS
    growlrrr requires notification permissions. On first run, allow
    notifications when prompted or enable in System Settings > Notifications.

    Note: Only actively tested on macOS Tahoe (26). May work on Ventura and later.
  EOS
end
