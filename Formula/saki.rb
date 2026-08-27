class Saki < Formula
  desc "Backend service for the saki build orchestrator"
  homepage "https://github.com/drayanaindra/saki-cli"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/drayanaindra/saki-cli/releases/download/v0.3.1/saki-backend-darwin-arm64"
      sha256 "1be4d54de1db63dbe1f7b19a9c128d452f311090a53b3635e67ba615f7c3fd35"
    else
      url "https://github.com/drayanaindra/saki-cli/releases/download/v0.3.1/saki-backend-darwin-amd64"
      sha256 "eb7eb5cd0a9fb11179f250977141d4f8b93bdbe5a1e3f6ea644aface5d528170"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/drayanaindra/saki-cli/releases/download/v0.3.1/saki-backend-linux-arm64"
      sha256 "c19b905bae839eec0fb059f14c8a99d447898c5529c64f8fd523b2e0a6cdc583"
    else
      url "https://github.com/drayanaindra/saki-cli/releases/download/v0.3.1/saki-backend-linux-amd64"
      sha256 "48f10dc10aeabdb7cc00fcc1fea2b2450b54e5b427208fa8e8b8b6497929f71b"
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
