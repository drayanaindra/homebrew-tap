class Saki < Formula
  desc "Backend service for the saki build orchestrator"
  homepage "https://github.com/drayanaindra/saki-cli"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/drayanaindra/saki-cli/releases/download/v0.4.1/saki-backend-darwin-arm64"
      sha256 "692bf0d03c1840ea29e72a425a25f7a5cb886792d2c346796c325f6a41de12b6"
    else
      url "https://github.com/drayanaindra/saki-cli/releases/download/v0.4.1/saki-backend-darwin-amd64"
      sha256 "dddccba3d30848e2e246401f2cedd4cd0c35204857c8102cd5020944302072eb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/drayanaindra/saki-cli/releases/download/v0.4.1/saki-backend-linux-arm64"
      sha256 "0f3658da2e3201afb7708e17581de3533362432bf53eb13e3974550ca539e3d8"
    else
      url "https://github.com/drayanaindra/saki-cli/releases/download/v0.4.1/saki-backend-linux-amd64"
      sha256 "11d4143281dca4a10672d6999913a3b6ddb06c4f7f0f113f25333127ccf32d4d"
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
