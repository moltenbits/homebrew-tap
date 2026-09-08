class Sideband < Formula
  desc "Local, durable, tridirectional communication between a human, Claude Code, and Codex"
  homepage "https://github.com/moltenbits/sideband"
  version "1.0.1"

  on_macos do
    url "https://github.com/moltenbits/sideband/releases/download/v#{version}/sideband-#{version}-macos-arm64.tar.gz"
    sha256 "a4d7b543d16bf1a8f1c8c310e36217a221a3d5ca633a8f2ea63d54b8b74be25e"
  end

  on_linux do
    on_arm do
      url "https://github.com/moltenbits/sideband/releases/download/v#{version}/sideband-#{version}-linux-arm64.tar.gz"
      sha256 "49788a6941a4edaa0e4e45487f3aad45cb842ea285561682351b08a353afa4ed"
    end
    on_intel do
      url "https://github.com/moltenbits/sideband/releases/download/v#{version}/sideband-#{version}-linux-x86_64.tar.gz"
      sha256 "a0661525c4a9866ba19d18950aa8b1a0bdaafc8e8148e22ecc04b5e01997a430"
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
