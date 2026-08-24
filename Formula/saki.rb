class Saki < Formula
  desc "Backend service for the saki build orchestrator"
  homepage "https://github.com/drayanaindra/saki-cli"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/drayanaindra/saki-cli/releases/download/v0.3.0/saki-backend-darwin-arm64"
      sha256 "fe6049987de3ee1b24c40bd7c2bfde76d312134612d6807d869f3eab416a71e0"
    else
      url "https://github.com/drayanaindra/saki-cli/releases/download/v0.3.0/saki-backend-darwin-amd64"
      sha256 "7d8afba7c61a6cac974bd5cfcf0b242badee2c97f3337eb4579d3a3d659a2482"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/drayanaindra/saki-cli/releases/download/v0.3.0/saki-backend-linux-arm64"
      sha256 "1b6adda5e903d80237d43fb7dc45bc2964949deb04ea97fcfca5c8d5f866d3b5"
    else
      url "https://github.com/drayanaindra/saki-cli/releases/download/v0.3.0/saki-backend-linux-amd64"
      sha256 "fd975dfd17d57a7f4204c1383d3523b8ae4b01b841f2dbcfd3b53d97158125ff"
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
    assert_path_exists bin/"saki-backend"
    assert_predicate bin/"saki-backend", :executable?
  end
end
