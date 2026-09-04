class Saki < Formula
  desc "Backend service for the saki build orchestrator"
  homepage "https://github.com/drayanaindra/saki-cli"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/drayanaindra/saki-cli/releases/download/v0.6.1/saki-backend-darwin-arm64"
      sha256 "06e5c1e6d02fe6846e19709ee964775e8212a81182228ed55e3b8b0d6be3ca96"
    else
      url "https://github.com/drayanaindra/saki-cli/releases/download/v0.6.1/saki-backend-darwin-amd64"
      sha256 "cba07a9deaab95ecf46b98a75d82cd33088d6f163e37d659c6411e6da11b4acc"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/drayanaindra/saki-cli/releases/download/v0.6.1/saki-backend-linux-arm64"
      sha256 "109ed3c33d2d1778181173885d63c1ee327a9f46568118289b724dd681318d7c"
    else
      url "https://github.com/drayanaindra/saki-cli/releases/download/v0.6.1/saki-backend-linux-amd64"
      sha256 "282d55df3273a15e81d22b48a0922185f15ed44ad76ff3cd8c7281a8a0d99378"
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
