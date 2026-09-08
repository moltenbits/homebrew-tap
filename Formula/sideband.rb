class Sideband < Formula
  desc "Local, durable, tridirectional communication between a human, Claude Code, and Codex"
  homepage "https://github.com/moltenbits/sideband"
  version "1.0.0"

  on_macos do
    url "https://github.com/moltenbits/sideband/releases/download/v#{version}/sideband-#{version}-macos-arm64.tar.gz"
    sha256 "f60137a0184cc3f9bbaa0179676ee6eb36902fe43c620fc187dec0a13af9781b"
  end

  on_linux do
    on_arm do
      url "https://github.com/moltenbits/sideband/releases/download/v#{version}/sideband-#{version}-linux-arm64.tar.gz"
      sha256 "3035ae0596924528c67b7a0c7be169801e8461ad2c800f98c95f2c37cebdbbac"
    end
    on_intel do
      url "https://github.com/moltenbits/sideband/releases/download/v#{version}/sideband-#{version}-linux-x86_64.tar.gz"
      sha256 "456bb39e9dcdab8f8fbcffb81485617c6028a1ae524248aa274203c94cf4ba54"
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
