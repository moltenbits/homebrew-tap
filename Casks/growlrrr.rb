cask "growlrrr" do
  version "1.1.1"
  sha256 "e236dd669119b460a2012a1bbce10077091a0d6bf2a525f33cd1bad404b1d77e"

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
