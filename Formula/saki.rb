class Saki < Formula
  desc "Backend service for the saki build orchestrator"
  homepage "https://github.com/drayanaindra/saki-cli"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/drayanaindra/saki-cli/releases/download/v0.2.0/saki-backend-darwin-arm64"
      sha256 "5d6a8564b9f8dccf6c3f5e0856269bf3054be946232de67deff9a484bccf5ecd"
    else
      url "https://github.com/drayanaindra/saki-cli/releases/download/v0.2.0/saki-backend-darwin-amd64"
      sha256 "5d5a97a46b095e4fbbf88e04542e415b504f5d9a9f32801c9b7ac2529b3d542b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/drayanaindra/saki-cli/releases/download/v0.2.0/saki-backend-linux-arm64"
      sha256 "f27fc4b1c4e712640780261d3f5fe0bab265ad59fb6440779cb4e95a8ba13bc6"
    else
      url "https://github.com/drayanaindra/saki-cli/releases/download/v0.2.0/saki-backend-linux-amd64"
      sha256 "502ce660dfa1d76307c42a1e4bf9a4d13f97a98e932010e13f2642cc75fa38f4"
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
