class Saki < Formula
  desc "Backend service for the saki build orchestrator"
  homepage "https://github.com/drayanaindra/saki-cli"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/drayanaindra/saki-cli/releases/download/v0.1.0/saki-backend-darwin-arm64"
      sha256 "721758255149075a17d435aa8dc0c9f0b93c2a4cb9f68a162a90216fa08beacd"
    else
      url "https://github.com/drayanaindra/saki-cli/releases/download/v0.1.0/saki-backend-darwin-amd64"
      sha256 "ad08e42a8309b2ea9a8b53fd6357f86bbd37f200a338c4d0e456eb212af5dec4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/drayanaindra/saki-cli/releases/download/v0.1.0/saki-backend-linux-arm64"
      sha256 "6f6c1e3b490e172e73cde3593b70249d23c96083d664484f31e97aac16504d4c"
    else
      url "https://github.com/drayanaindra/saki-cli/releases/download/v0.1.0/saki-backend-linux-amd64"
      sha256 "86c4d81b9a1f86b3b3b65b76ae2b0ba3410a23c529bc7fa7e3801d5a3e2ada6e"
    end
  end

  def install
    binary_name = if OS.mac?
      Hardware::CPU.arm? ? "saki-backend-darwin-arm64" : "saki-backend-darwin-amd64"
    else
      Hardware::CPU.arm? ? "saki-backend-linux-arm64" : "saki-backend-linux-amd64"
    end
    bin.install binary_name => "saki-backend"
  end

  service do
    run [opt_bin/"saki-backend"]
    keep_alive true
    log_path var/"log/saki-backend.log"
    error_log_path var/"log/saki-backend.log"
  end

  test do
    assert_predicate bin/"saki-backend", :exist?
    assert_predicate bin/"saki-backend", :executable?
  end
end
