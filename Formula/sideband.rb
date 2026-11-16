class Sideband < Formula
  desc "Local, durable, tridirectional communication between a human, Claude Code, and Codex"
  homepage "https://github.com/moltenbits/sideband"
  version "2.0.0"

  on_macos do
    url "https://github.com/moltenbits/sideband/releases/download/v#{version}/sideband-#{version}-macos-arm64.tar.gz"
    sha256 "f306604e9fe50d17a8c2b525f048699718362d33b2414f195c31f59820b406aa"
  end

  on_linux do
    on_arm do
      url "https://github.com/moltenbits/sideband/releases/download/v#{version}/sideband-#{version}-linux-arm64.tar.gz"
      sha256 "a51c64120550ebc6fd8abb07ed550fc62e47c84e870f1326dfa5ccc92e498643"
    end
    on_intel do
      url "https://github.com/moltenbits/sideband/releases/download/v#{version}/sideband-#{version}-linux-x86_64.tar.gz"
      sha256 "1ff48c77a20c5b5e600f9f92629fd9f9ba2b4fae403731b8a346f5ccfa0c2f5f"
    end
  end

  def install
    bin.install "sideband"
  end

  test do
    assert_match "sideband #{version}", shell_output("#{bin}/sideband --version")
    repo = testpath/"repo"
    system "git", "init", "-q", repo
    system bin/"sideband", "init", "--skip-clients", "--repo", repo
    pipe_output("#{bin}/sideband append --repo #{repo} --from operator --via claude", "claude: brew test\n")
    assert_match "brew test", shell_output("#{bin}/sideband log --repo #{repo}")
  end
end
