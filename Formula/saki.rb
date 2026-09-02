class Saki < Formula
  desc "Backend service for the saki build orchestrator"
  homepage "https://github.com/drayanaindra/saki-cli"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/drayanaindra/saki-cli/releases/download/v0.4.0/saki-backend-darwin-arm64"
      sha256 "8d474f925d087a505c0a288822826c1e2df7e130a64dcbc8fd7d9654957240b5"
    else
      url "https://github.com/drayanaindra/saki-cli/releases/download/v0.4.0/saki-backend-darwin-amd64"
      sha256 "df63da268597951f90a0faeb4bff4b0df78b3b7de0924b29ff8d16c93c809667"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/drayanaindra/saki-cli/releases/download/v0.4.0/saki-backend-linux-arm64"
      sha256 "bc7287fa69da975b171fb62c20a664a9b337f0e22bc7bd3abb722b8d72dfcc7e"
    else
      url "https://github.com/drayanaindra/saki-cli/releases/download/v0.4.0/saki-backend-linux-amd64"
      sha256 "1e434d8c9527808f69dab2cea96f7ce6f1218c58b8c5413f3376445662fb5dec"
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
