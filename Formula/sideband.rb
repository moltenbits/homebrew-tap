class Sideband < Formula
  desc "Local, durable, tridirectional communication between a human, Claude Code, and Codex"
  homepage "https://github.com/moltenbits/sideband"
  version "1.1.1"

  on_macos do
    url "https://github.com/moltenbits/sideband/releases/download/v#{version}/sideband-#{version}-macos-arm64.tar.gz"
    sha256 "6fc233118f957a87822e7d0ab524e1f196b50254eb3bc6cd2e0d70f7cf0bf1cd"
  end

  on_linux do
    on_arm do
      url "https://github.com/moltenbits/sideband/releases/download/v#{version}/sideband-#{version}-linux-arm64.tar.gz"
      sha256 "3ec3fcea2f04efbad8d9987ced434f9f1834cb65b24cca5760b92ad4e6ab3f02"
    end
    on_intel do
      url "https://github.com/moltenbits/sideband/releases/download/v#{version}/sideband-#{version}-linux-x86_64.tar.gz"
      sha256 "371e05fa0ab99934a7ab441475f57e69d52bf88c639f45aaefb57bf4add23a3f"
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
