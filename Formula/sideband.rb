class Sideband < Formula
  desc "Local, durable, tridirectional communication between a human, Claude Code, and Codex"
  homepage "https://github.com/moltenbits/sideband"
  version "1.1.2"

  on_macos do
    url "https://github.com/moltenbits/sideband/releases/download/v#{version}/sideband-#{version}-macos-arm64.tar.gz"
    sha256 "02338d75ca301d0f9e4588406f119fca08cd3dac89ac05d6d38a751bdbc293e7"
  end

  on_linux do
    on_arm do
      url "https://github.com/moltenbits/sideband/releases/download/v#{version}/sideband-#{version}-linux-arm64.tar.gz"
      sha256 "7accaa08852c0122b90e13547dc0a00abfa637e764f3d7ba648ca5c18f4740c8"
    end
    on_intel do
      url "https://github.com/moltenbits/sideband/releases/download/v#{version}/sideband-#{version}-linux-x86_64.tar.gz"
      sha256 "2d6f1cedbcbb17d3531a68df3aef2c7aac33256ba6645f2764b6c2c2971619ca"
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
